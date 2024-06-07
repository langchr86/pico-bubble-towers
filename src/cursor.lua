-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Cursor
---@field sprite number
---@field small_sprite number
---@field pos Point
---@field min Point
---@field max Point
---@field inc number
---@field show_menu boolean
---@field menu_index number
---@field menu_sprite_list number[]
---@field menu_handler function
---@field menu_sprite_getter function
Cursor = {
  sprite = 5,
  small_sprite = 19,
  pos = Point:New(8, 16),
  min = Point:New(0, 8),
  max = Point:New(112, 112),
  inc = kTileSize,
  show_menu = false,
  menu_index = 0,
  menu_sprite_list = {},
  menu_handler = nil,
  menu_sprite_getter = nil,
}
Cursor.__index = Cursor

---@type number
Cursor.ShowNoSprite = 0
---@type number
Cursor.AbortShowMenu = 255

---@return Cursor
function Cursor:New()
  local o = {
  }
  return --[[---@type Cursor]] setmetatable(o, self)
end

function Cursor:Up()
  if self.show_menu then
    self:HandleMenuSelect(2, 4)
    return
  end

  self.pos.y = self.pos.y - self.inc
  if (self.pos.y < self.min.y) then
    self.pos.y = self.min.y
  end
end

function Cursor:Down()
  if self.show_menu then
    self:HandleMenuSelect(4, 2)
    return
  end

  self.pos.y = self.pos.y + self.inc
  if (self.pos.y > self.max.y) then
    self.pos.y = self.max.y
  end
end

function Cursor:Left()
  if self.show_menu then
    self:HandleMenuSelect(1, 3)
    return
  end

  self.pos.x = self.pos.x - self.inc
  if (self.pos.x < self.min.x) then
    self.pos.x = self.min.x
  end
end

function Cursor:Right()
  if self.show_menu then
    self:HandleMenuSelect(3, 1)
    return
  end

  self.pos.x = self.pos.x + self.inc
  if (self.pos.x > self.max.x) then
    self.pos.x = self.max.x
  end
end

---@param move_direction number
---@param opposite_direction number
function Cursor:HandleMenuSelect(move_direction, opposite_direction)
  if self.menu_index == opposite_direction then
    self.menu_index = 0
  elseif self.menu_sprite_list[move_direction] ~= Cursor.ShowNoSprite then
    self.menu_index = move_direction
  else
    --- do not change anything
  end
end

---@return boolean
function Cursor:IsFreeToBuildTower()
  local tile_pos = Point:New(self.pos.x / self.inc, self.pos.y / self.inc)
  return Map:CanBuildOnTile4(tile_pos)
end

---@param handler function
---@param sprite_getter function
function Cursor:RegisterMenuHandler(handler, sprite_getter)
  self.menu_handler = handler
  self.menu_sprite_getter = sprite_getter
end

function Cursor:Press()
  if self.show_menu then
    local handler = self.menu_handler
    if handler then
      if handler(self.menu_index) then
        self:HideMenu()
      end
    end
  else
    self:ShowMenu()
  end
end

function Cursor:ShowMenu()
  self.show_menu = true
  self.menu_sprite_list[0] = self.menu_sprite_getter(0)

  if self.menu_sprite_list[0] == Cursor.AbortShowMenu then
    self:HideMenu()
    return
  end

  for i = 1, 4 do
    self.menu_sprite_list[i] = self.menu_sprite_getter(i)
  end
end

function Cursor:HideMenu()
  self.show_menu = false
  self.menu_sprite_list = {}
  self.menu_index = 0
end

function Cursor:Draw()
  if not self.pos then
    return
  end

  if self.show_menu then
    self:DrawMenuItem(0)
    self:DrawMenuItem(1)
    self:DrawMenuItem(2)
    self:DrawMenuItem(3)
    self:DrawMenuItem(4)

    local menu_pos, menu_size = self:CalcMenuPositionAndSize(self.menu_index)

    local selection_sprite = self.small_sprite
    if self.menu_index == 0 then
      selection_sprite = self.sprite
    end

    spr(selection_sprite, menu_pos.x, menu_pos.y, menu_size.x, menu_size.y)

    return
  end

  spr(self.sprite, self.pos.x, self.pos.y, 2, 2)

  self:DrawDebug()
end

function Cursor:DrawDebug()
  if not g_show_debug_info then
    return
  end

  local tile_pos = Point:New(self.pos.x / self.inc, self.pos.y / self.inc)
  print(Map:GetSprite(tile_pos), 2, 121, 10)
  print(Map:IsTileBuildable(tile_pos), 18, 121, 10)
  print(Map:IsTileWalkable(tile_pos), 50, 121, 10)
end

---@param index number
function Cursor:DrawMenuItem(index)
  local sprite = self.menu_sprite_list[index]
  if sprite == 0 then
    return
  end

  local menu_pos, menu_size = self:CalcMenuPositionAndSize(index)
  spr(sprite, menu_pos.x, menu_pos.y, menu_size.x, menu_size.y)
end

---@param index number
function Cursor:CalcMenuPositionAndSize(index)
  local menu_pos = self.pos:Clone()
  local menu_size = Point:New(1, 1)

  if index == 0 then
    menu_size.x = 2
    menu_size.y = 2
  elseif index == 1 then
    menu_pos.x = menu_pos.x - 8
  elseif index == 2 then
    menu_pos.x = menu_pos.x + 8
    menu_pos.y = menu_pos.y - 8
  elseif index == 3 then
    menu_pos.x = menu_pos.x + 16
    menu_pos.y = menu_pos.y + 8
  elseif index == 4 then
    menu_pos.y = menu_pos.y + 16
  end

  if menu_pos.x < self.min.x then
    menu_pos.x = self.min.x
  end
  if menu_pos.x > self.max.x then
    menu_pos.x = self.max.x + 8
  end
  if menu_pos.y < self.min.y then
    menu_pos.y = self.min.y
  end
  if menu_pos.y > self.max.y then
    menu_pos.y = self.max.y + 8
  end

  return menu_pos, menu_size
end
