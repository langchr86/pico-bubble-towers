-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Tower
---@field sprite number
---@field pos Point
---@field logical_pos Point
---@field type TowerType
---@field level number
---@field spent_cash number
---@field radius number
---@field reload_threshold number
---@field reload_level number
Tower = {}
Tower.__index = Tower

---@param pos Point
---@return Tower
function Tower:New(pos)
  local o = {
    sprite = 128,
    pos = pos:Clone(),
    logical_pos = pos + Point:New(4, 4),
    type = TowerType.BASE,
    level = 0,
    spent_cash = 10,
    radius = 16,
    reload_threshold = 20,
    reload_level = 0,
  }

  local instance = --[[---@type Tower]] setmetatable(o, self)

  instance:UpdateMap()

  return instance
end

function Tower:Destroy()
  local tile_pos = Point:New(self.pos.x / kTileSize, self.pos.y / kTileSize)
  Map:TileClear4(tile_pos, 10)
end

---@param upgrade_type TowerType
function Tower:Upgrade(upgrade_type)
  ---@type TowerUpgrade
  local upgrade = UPGRADE_TABLE[self.type][upgrade_type]

  self.type = upgrade_type
  self.level = self.level + 1
  self.sprite = upgrade.sprite
  self.radius = upgrade.radius
  self.reload_threshold = upgrade.reload
  self.spent_cash = self.spent_cash + flr(upgrade.cost * 0.75)

  self:UpdateMap()
end

---@return number
function Tower:GetBuyCost()
  return 10
end

---@class TowerMenu
---@field cost number
---@field sprite number
---@field type TowerType

---@alias OptionalTowerMenu TowerMenu|nil

---@return OptionalTowerMenu[]
function Tower:GetUpgradeMenu()
  ---@type OptionalTowerMenu[]
  local list = { nil, nil, nil, nil }

  for type, upgrade in pairs(UPGRADE_TABLE[self.type]) do
    local menu = --[[---@type TowerMenu]] {
      cost = upgrade.cost,
      sprite = upgrade.preview_sprite,
      type = type,
    }

    local menu_index = 0
    if self.type == TowerType.BASE then
      menu_index = flr(type / 100)
    else
      menu_index = flr(type % 100 / 10)
    end

    print(menu_index)
    assert(menu_index < 5)

    list[menu_index] = menu
  end

  print("list end")
  return list
end

---@return number
function Tower.GetDestroySprite()
  return 160
end

---@return number
function Tower:GetValue()
  return self.spent_cash
end

function Tower:Update(enemy_list)
  self:ShotOnNearestEnemy(enemy_list)
end

function Tower:UpdateMap()
  local tile_pos = Point:New(self.pos.x / kTileSize, self.pos.y / kTileSize)
  Map:TileSet4(tile_pos, self.sprite)
end

function Tower:Draw(cursor)
  if cursor.pos == self.pos then
    circ(self.pos.x + kTileSize, self.pos.y + kTileSize, self.radius, 5)
  end
end

---@return boolean
function Tower:PlacedOn(other)
  return self.pos:IsColliding(other, 16)
end

function Tower:ShotOnNearestEnemy(enemy_list)
  if self.reload_level < self.reload_threshold then
    self.reload_level = self.reload_level + 1
    return
  end

  ---@type Enemy
  local nearest_enemy_in_reach
  ---@type number
  local nearest_distance

  for enemy in all(enemy_list) do
    local distance = self.logical_pos:Distance(enemy.pos)

    if distance <= self.radius then
      if not nearest_distance then
        nearest_distance = distance
        nearest_enemy_in_reach = enemy
      elseif distance < nearest_distance then
        nearest_distance = distance
        nearest_enemy_in_reach = enemy
      end
    end
  end

  if nearest_enemy_in_reach then
    local bullet = Bullet:New(self.logical_pos, nearest_enemy_in_reach.pos)
    nearest_enemy_in_reach:Shot(bullet)
    self.reload_level = 0
  end
end
