-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Cursor
---@field pos Point
---@field min Point
---@field max Point
---@field show_menu boolean
---@field menu_index number
---@field menu_sprite_list number[]
---@field menu_handler function
---@field menu_sprite_getter function
Cursor = {}
Cursor.__index = Cursor

MenuNoSprite = 0
MenuAbort = 255

CursorMinX = 0
CursorMinY = 8
CursorMax = 112

---@return Cursor
function CursorNew()
  local o = {
    pos = PointNew(8, 16),
    show_menu = false,
    menu_index = 0,
    menu_sprite_list = {},
  }
  return setmetatable(o, Cursor)
end

function Cursor:Up()
  if self.show_menu then
    self:HandleMenuSelect(2, 4)
    return
  end

  self.pos.y -= kTileSize
  if (self.pos.y < CursorMinY) then
    self.pos.y = CursorMinY
  end
end

function Cursor:Down()
  if self.show_menu then
    self:HandleMenuSelect(4, 2)
    return
  end

  self.pos.y += kTileSize
  if (self.pos.y > CursorMax) then
    self.pos.y = CursorMax
  end
end

function Cursor:Left()
  if self.show_menu then
    self:HandleMenuSelect(1, 3)
    return
  end

  self.pos.x -= kTileSize
  if (self.pos.x < CursorMinX) then
    self.pos.x = CursorMinX
  end
end

function Cursor:Right()
  if self.show_menu then
    self:HandleMenuSelect(3, 1)
    return
  end

  self.pos.x += kTileSize
  if (self.pos.x > CursorMax) then
    self.pos.x = CursorMax
  end
end

---@param move_dir number
---@param opposite_dir number
function Cursor:HandleMenuSelect(move_dir, opposite_dir)
  if self.menu_index == opposite_dir then
    self.menu_index = 0
  elseif self.menu_sprite_list[move_dir] != MenuNoSprite then
    self.menu_index = move_dir
  end
end

---@return boolean
function Cursor:IsFreeToBuildTower()
  return Map:CanBuildOnTile4(PointNew(self.pos.x / kTileSize, self.pos.y / kTileSize))
end

---@param h function
---@param g function
function Cursor:RegisterMenuHandler(h, g)
  self.menu_handler = h
  self.menu_sprite_getter = g
end

function Cursor:Press()
  if self.show_menu then
    if self.menu_handler then
      if self.menu_handler(self.menu_index) then
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

  if self.menu_sprite_list[0] == MenuAbort then
    self:HideMenu()
    return
  end

  self:UpdateMenuSpriteList()
end

function Cursor:UpdateMenuSpriteList()
  if self.show_menu then
    for i = 1, 4 do
      self.menu_sprite_list[i] = self.menu_sprite_getter(i)
    end
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

    local x, y, size = self:CalcMenuPos(self.menu_index)

    local selection_sprite = 19
    if self.menu_index == 0 then
      selection_sprite = 5
    end

    spr(selection_sprite, x, y, size, size)

    return
  end

  spr(5, self.pos.x, self.pos.y, 2, 2)
end

---@param i number
function Cursor:DrawMenuItem(i)
  local sprite = self.menu_sprite_list[i]
  if sprite != MenuNoSprite then
    local x, y, size = self:CalcMenuPos(i)
    spr(sprite, x, y, size, size)
  end
end

---@param i number
function Cursor:CalcMenuPos(i)
  local x = self.pos.x
  local y = self.pos.y
  local size = 1

  if i == 0 then
    size = 2
  elseif i == 1 then
    x -= 8
  elseif i == 2 then
    x += 8
    y -= 8
  elseif i == 3 then
    x += 16
    y += 8
  elseif i == 4 then
    y += 16
  end

  if x < CursorMinX then
    x = CursorMinX
  end
  if x > CursorMax then
    x = CursorMax + 8
  end
  if y < CursorMinY then
    y = CursorMinY
  end
  if y > CursorMax then
    y = CursorMax + 8
  end

  return x, y, size
end
