-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Session
---@field cursor Cursor
---@field start Point
---@field goal Point
---@field enemy_path Point[]
---@field tower_list Tower[]
---@field modifier_tower_list Tower[]
---@field tower_selected Tower|nil
---@field enemy_list Enemy[]
---@field wave_list Wave[]
---@field active_wave_list Wave[]
---@field cash number
---@field player_life number
Session = {}
Session.__index = Session

---@param cursor Cursor
---@return Session
function Session:New(cursor)
  local o = {
    cursor = cursor,
    start = Point:New(0, 0),
    goal = Point:New(0, 0),
    enemy_path = {},
    tower_list = {},
    modifier_tower_list = {},
    tower_selected = nil,
    enemy_list = {},
    wave_list = {},
    active_wave_list = {},
    cash = 5000,
    player_life = 20,
  }

  local instance = --[[---@type Session]] setmetatable(o, self)

  instance:SearchSpecialPoints()
  instance:CalculateNewPath()
  instance:PrepareCursorMenu()

  return instance
end

---@param wave_list Wave[]
function Session:AddWaves(wave_list)
  for wave in all(wave_list) do
    add(self.wave_list, wave)
  end
end

function Session:SearchSpecialPoints()
  self:DrawMap()

  for x = 0, kMapSizeInTiles - 1 do
    for y = 0, kMapSizeInTiles - 1 do
      local tile_pos = Point:New(x, y)
      if Map:IsTileStart(tile_pos) then
        self.start = tile_pos
      elseif Map:IsTileGoal(tile_pos) then
        self.goal = tile_pos
      end
    end
  end
end

---@return boolean
function Session:PlaceTower()
  if self:AnyEnemies() then
    return false
  end

  if self.cash < Tower.BuyCost then
    return false
  end

  local new_tower = Tower:New(self.cursor.pos)

  if self:CalculateNewPath() then
    add(self.tower_list, new_tower)
    self.cash = self.cash - Tower.BuyCost
    return true
  end

  new_tower:Destroy()
  return false
end

function Session:RemoveTower()
  local tower = --[[---@type Tower]] self.tower_selected
  tower:Destroy()
  del(self.tower_list, tower)
  del(self.modifier_tower_list, tower)
  self.cash = self.cash + tower:GetValue()
  self:CalculateNewPath()
end

function Session:PrepareCursorMenu()
  ---@param menu_index number
  local function CursorMenuHandler(menu_index)
    if menu_index == 0 then
      self:RemoveTower()
      return true
    end

    return self:UpgradeTower(menu_index)
  end

  ---@param menu_index number
  local function CursorMenuSpriteGetter(menu_index)
    if self.tower_selected == nil then
      if self.cursor:IsFree() then
        self:PlaceTower()
      end
      return Cursor.AbortShowMenu
    end

    local tower = --[[---@type Tower]] self.tower_selected
    if tower:HasMaxLevel() then
      return Cursor.AbortShowMenu
    end

    if menu_index == 0 then
      return Tower.GetDestroySprite()
    end

    local menu_entry = tower:GetUpgradeMenuEntry(menu_index)
    if menu_entry then
      local upgrade = --[[---@type TowerMenu]] menu_entry
      return upgrade.sprite
    end

    return Cursor.ShowNoSprite
  end

  self.cursor:RegisterMenuHandler(CursorMenuHandler, CursorMenuSpriteGetter)
end

---@param menu_index number
function Session:UpgradeTower(menu_index)
  local tower = --[[---@type Tower]] self.tower_selected
  assert(tower)

  local menu_entry = tower:GetUpgradeMenuEntry(menu_index)
  local upgrade = --[[---@type TowerMenu]] menu_entry

  if upgrade.cost > self.cash then
    ---TODO: user feedback: too low on cash
    return false
  end

  self.cash = self.cash - upgrade.cost
  tower:Upgrade(upgrade.type)

  if IsTowerModifierUpgrade(upgrade.type) then
    del(self.tower_list, tower)
    add(self.modifier_tower_list, tower)
  end

  return true
end

function Session:StartNextWave()
  if #self.enemy_path == 0 or #self.wave_list == 0 then
    return
  end

  ---@type Point
  local start_point = ConvertTileToPixel(self.start)

  local next_wave = deli(self.wave_list, 1)
  next_wave:Start(start_point, self.enemy_path)

  add(self.active_wave_list, next_wave)
end

function Session:TrySpawnEnemy()
  for wave in all(self.active_wave_list) do
    if not wave:IsActive() then
      del(self.active_wave_list, wave)
    else
      wave:TrySpawnBaby(self.enemy_list)
    end
  end
end

---@return boolean
function Session:AnyEnemies()
  return #self.enemy_list > 0
end

---@return boolean
function Session:CalculateNewPath()
  local function is_coord_reachable(x, y)
    local tile_pos = Point:New(x, y)
    return Map:IsTileFree(tile_pos)
  end

  ---@type Point[]|boolean
  local path = LuaStar:Find(15, 15, self.start, self.goal, is_coord_reachable)
  if path == false then
    return false
  end

  self.enemy_path = {}
  for pos in all(path) do
    ---@type Point
    local pixel_pos = ConvertTileToPixel(pos)
    add(self.enemy_path, pixel_pos)
  end

  return true
end

function Session:DrawMapBorder()
  ---@type number
  local border_color = 6
  line(0, kTileSize, 127, kTileSize, border_color)
  line(0, kTileSize, 0, 127, border_color)
  line(127, kTileSize, 127, 127, border_color)
  line(0, 127, 127, 127, border_color)
end

function Session:DrawMap()
  Map:Draw()
end

function Session:DrawPath()
  for pos in all(self.enemy_path) do
    spr(16, pos.x, pos.y)
  end
end

function Session:DrawStats()
  for x = 0, 15 do
    spr(9, x * kTileSize, 0)
  end

  print("life: ", 1, 1, 12)
  PrintRight(self.player_life, 29, 1, 7)

  print("next: ", 35, 1, 12)
  local x = 54
  for i = 1, min(4, #self.wave_list) do
    local wave = self.wave_list[i]
    spr(wave.enemy_template.sprite, x, 0)
    x = x + 8
  end

  print("cash: ", 92, 1, 12)
  PrintRight(self.cash, 128, 1, 7)
end

function Session:Update()
  self:ClearModifications()
  self:TrySpawnEnemy()

  self.tower_selected = nil
  for tower in all(self.modifier_tower_list) do
    tower:ModifyTowers(self.tower_list)
    if tower.pos == self.cursor.pos then
      self.tower_selected = tower
    end
  end

  for tower in all(self.tower_list) do
    tower:Update(self.enemy_list)
    if tower.pos == self.cursor.pos then
      self.tower_selected = tower
    end
  end

  for enemy in all(self.enemy_list) do
    enemy:Update()
    if enemy:IsDead() then
      del(self.enemy_list, enemy)
      self.cash = self.cash + enemy:GetValue()
    end
    if enemy:InTarget() then
      del(self.enemy_list, enemy)
      self.player_life = self.player_life - 1
    end
  end
end

function Session:ClearModifications()
  for tower in all(self.tower_list) do
    tower:ClearModifications()
  end
  for enemy in all(self.enemy_list) do
    enemy:ClearModifications()
  end
end

---@param cursor Cursor
function Session:Draw(cursor)
  if self.player_life <= 0 then
    map(0, 16)
    return
  end

  if #self.wave_list == 0 and self:AnyEnemies() == false then
    map(16, 16)
    return
  end

  self:DrawMap()
  self:DrawPath()

  for tower in all(self.modifier_tower_list) do
    tower:Draw(cursor)
  end
  for tower in all(self.tower_list) do
    tower:Draw(cursor)
  end

  for enemy in all(self.enemy_list) do
    enemy:Draw()
  end

  self:DrawMapBorder()
  self:DrawStats()
end
