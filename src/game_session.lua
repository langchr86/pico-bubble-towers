-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class GameSession
---@field cursor Cursor
---@field start Point
---@field goal Point
---@field enemy_path Point[]
---@field ghost_path Point[]
---@field tower_list Tower[]
---@field modifier_tower_list Tower[]
---@field tower_selected Tower|nil
---@field enemy_list Enemy[]
---@field explosion_list Enemy[]
---@field wave_list Wave[]
---@field active_wave_list Wave[]
---@field cash number
---@field player_life number
---@field shake number
GameSession = {}
GameSession.__index = GameSession

---@param wave_list Wave[]
---@return GameSession
function GameSession:New(wave_list)
  local o = {
    cursor = Cursor:New(),
    start = Point:New(0, 0),
    goal = Point:New(0, 0),
    enemy_path = {},
    ghost_path = {},
    tower_list = {},
    modifier_tower_list = {},
    enemy_list = {},
    explosion_list = {},
    wave_list = wave_list,
    active_wave_list = {},
    cash = 100,
    player_life = 10,
    shake = 0,
  }

  local instance = --[[---@type GameSession]] setmetatable(o, self)

  instance:SearchSpecialPoints()
  assert(instance:CalculateNewPath())
  assert(instance:CalculateGhostPath())
  instance:PrepareCursorMenu()

  music(11, 120)

  return instance
end

function GameSession:SearchSpecialPoints()
  self:DrawMap()
  Map:SetWalkwayMode(false)

  for x = 0, kMapSizeInTiles - 1 do
    for y = 0, kMapSizeInTiles - 1 do
      local tile_pos = Point:New(x, y)
      if Map:IsTileStart(tile_pos) then
        self.start = tile_pos
      elseif Map:IsTileGoal(tile_pos) then
        self.goal = tile_pos
      end

      if Map:IsTileWalkWay(tile_pos) then
        Map:SetWalkwayMode(true)
      end
    end
  end
end

---@return boolean
function GameSession:PlaceTower()
  if not self.cursor:IsFreeToBuildTower() then
    sfx(0x13, -1)
    return false
  end

  if self:AnyEnemies() then
    sfx(0x13, -1)
    return false
  end

  if self.cash < Tower.BuyCost then
    sfx(0x13, -1)
    return false
  end

  local new_tower = Tower:New(self.cursor.pos)

  if self:CalculateNewPath() then
    add(self.tower_list, new_tower)
    self.cash = self.cash - Tower.BuyCost
    sfx(0x15, -1)
    return true
  end

  new_tower:Destroy()
  sfx(0x13, -1)
  return false
end

function GameSession:RemoveTower()
  local tower = --[[---@type Tower]] self.tower_selected
  tower:Destroy()
  del(self.tower_list, tower)
  del(self.modifier_tower_list, tower)
  self.cash += Tower.BuyCost
  self:CalculateNewPath()
  sfx(0x15, -1)
end

function GameSession:PrepareCursorMenu()
  ---@param menu_index number
  local function CursorMenuHandler(menu_index)
    local tower = --[[---@type Tower]] self.tower_selected

    if menu_index == 0 then
      if tower.level == 0 then
        self:RemoveTower()
        return true
      else
        sfx(0x13, -1)
        return false
      end
    end

    return self:UpgradeTower(menu_index)
  end

  ---@param menu_index number
  local function CursorMenuSpriteGetter(menu_index)
    if self.tower_selected == nil then
      self:PlaceTower()
      return Cursor.AbortShowMenu
    end

    local tower = --[[---@type Tower]] self.tower_selected
    if tower:HasMaxLevel() then
      sfx(0x13, -1)
      return Cursor.AbortShowMenu
    end

    if menu_index == 0 and tower.level == 0 then
      return Tower.GetDestroySprite()
    end

    local menu_entry = tower:GetUpgradeMenuEntry(menu_index)
    if menu_entry then
      local upgrade = --[[---@type TowerMenu]] menu_entry
      if upgrade.cost > self.cash then
        return upgrade.sprite + 4
      else
        return upgrade.sprite
      end
    end

    return Cursor.ShowNoSprite
  end

  self.cursor:RegisterMenuHandler(CursorMenuHandler, CursorMenuSpriteGetter)
end

---@param menu_index number
function GameSession:UpgradeTower(menu_index)
  local tower = --[[---@type Tower]] self.tower_selected
  assert(tower)

  local menu_entry = tower:GetUpgradeMenuEntry(menu_index)
  local upgrade = --[[---@type TowerMenu]] menu_entry

  if upgrade.cost > self.cash then
    sfx(0x13, -1)
    return false
  end

  self.cash = self.cash - upgrade.cost
  tower:Upgrade(upgrade.type)

  if IsTowerModifierUpgrade(upgrade.type) then
    del(self.tower_list, tower)
    add(self.modifier_tower_list, tower)
  end

  sfx(0x14, -1)
  return true
end

function GameSession:StartNextWave()
  if #self.enemy_path == 0 or #self.wave_list == 0 then
    return
  end

  ---@type Point
  local start_point = ConvertTileToPixel(self.start)

  local next_wave = --[[---@type Wave]] deli(self.wave_list, 1)
  next_wave:Start(start_point, self.enemy_path, self.ghost_path)

  add(self.active_wave_list, next_wave)
  sfx(0x11, -1)
end

function GameSession:TrySpawnEnemy()
  for wave in all(self.active_wave_list) do
    if not wave:IsActive() then
      del(self.active_wave_list, wave)
    else
      wave:TrySpawnBaby(self.enemy_list)
    end
  end
end

---@return boolean
function GameSession:AnyEnemies()
  return #self.enemy_list > 0
end

---@return boolean
function GameSession:CalculateNewPath()
  local function is_coord_reachable(x, y)
    local tile_pos = Point:New(x, y)
    return Map:IsTileWalkable(tile_pos)
  end

  ---@type Point[]|boolean
  local path = LuaStar:Find(15, 15, self.start, self.goal, is_coord_reachable)
  if path == false then
    return false
  end

  self.enemy_path = ConvertTileToPixelPath(path)
  return true
end

---@return boolean
function GameSession:CalculateGhostPath()
  local function is_coord_reachable(x, y)
    return y ~= 0
  end

  ---@type Point[]|boolean
  local path = LuaStar:Find(15, 15, self.start, self.goal, is_coord_reachable)
  if path == false then
    return false
  end

  self.ghost_path = ConvertTileToPixelPath(path)
  return true
end

function GameSession:DrawMapBorder()
  rect(0, kTileSize, 127, 127, 6)
end

function GameSession:DrawMap()
  Map:Draw()
end

function GameSession:DrawDebug()
  --if not g_show_debug_info then
  --  return
  --end
  --
  --for pos in all(self.enemy_path) do
  --  spr(16, pos.x, pos.y)
  --end
  --
  --for pos in all(self.ghost_path) do
  --  spr(23, pos.x, pos.y)
  --end
end

function GameSession:DrawStats()
  for x = 0, 15 do
    spr(1, x * kTileSize, 0)
  end

  print("life: ", 1, 1, 12)
  PrintRight(self.player_life, 29, 1, 7)

  print("next: ", 35, 1, 12)
  local x = 54
  for i = 1, min(4, #self.wave_list) do
    local wave = self.wave_list[i]
    wave.enemy_template:DrawWaveSprite(x, 0)
    x = x + 8
  end

  print("cash: ", 92, 1, 12)
  PrintRight(self.cash, 128, 1, 7)
end

function GameSession:Up()
  self.cursor:Up()
end

function GameSession:Down()
  self.cursor:Down()
end

function GameSession:Left()
  self.cursor:Left()
end

function GameSession:Right()
  self.cursor:Right()
end

function GameSession:PressO()
  if self.cursor.show_menu then
    self.cursor:HideMenu()
  else
    self:StartNextWave()
  end
end

function GameSession:PressX()
  self:UpdateSelectedTower()
  self.cursor:Press()
end

function GameSession:UpdateSelectedTower()
  self.tower_selected = nil

  for tower in all(self.modifier_tower_list) do
    if tower.pos == self.cursor.pos then
      self.tower_selected = tower
    end
  end

  for tower in all(self.tower_list) do
    if tower.pos == self.cursor.pos then
      self.tower_selected = tower
    end
  end
end

function GameSession:Update()
  self:ClearModifications()
  self:TrySpawnEnemy()

  for tower in all(self.modifier_tower_list) do
    tower:ModifyTowers(self.tower_list)
  end

  for tower in all(self.tower_list) do
    tower:Update(self.enemy_list)
  end

  for enemy in all(self.explosion_list) do
    enemy:Update()
    if enemy:IsDead() then
      del(self.explosion_list, enemy)
      self.cash = self.cash + enemy:GetValue()
      self.cursor:UpdateMenuSpriteList()
    end
  end

  for enemy in all(self.enemy_list) do
    enemy:Update()
    if enemy:IsExploding() then
      del(self.enemy_list, enemy)
      add(self.explosion_list, enemy)
    elseif enemy:InTarget() then
      del(self.enemy_list, enemy)
      self.player_life = self.player_life - 1
      self:StartScreenshake()
      sfx(0x10, -1)
    end
  end

  return self
end

function GameSession:ClearModifications()
  for tower in all(self.tower_list) do
    tower:ClearModifications()
  end
  for enemy in all(self.enemy_list) do
    enemy:ClearModifications()
  end
end

function GameSession:Draw()
  self:DrawScreenshake()

  if self.player_life <= 0 then
    PrintCenterX("game over", 56, 6)
    return
  end

  if #self.wave_list == 0 and self:AnyEnemies() == false then
    PrintCenterX("you win", 56, 6)
    return
  end

  self:DrawMap()
  self:DrawDebug()

  for tower in all(self.modifier_tower_list) do
    tower:Draw(self.cursor)
  end
  for tower in all(self.tower_list) do
    tower:Draw(self.cursor)
  end

  for enemy in all(self.enemy_list) do
    enemy:Draw()
  end

  for enemy in all(self.explosion_list) do
    enemy:Draw()
  end

  self:DrawMapBorder()
  self:DrawStats()

  self.cursor:Draw()
end

function GameSession:StartScreenshake()
  self.shake = 0.2
end

function GameSession:DrawScreenshake()
  local x = (8 - rnd(16)) * self.shake
  local y = (8 - rnd(16)) * self.shake

  camera(x, y)

  self.shake = self.shake * 0.8
  if self.shake < 0.1 then
    self.shake = 0
  end
end
