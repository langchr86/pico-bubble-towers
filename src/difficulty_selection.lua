-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class DiffSelect
---@field mode number
---@field manual boolean
---@field level number
---@field next_session any
DiffSelect = {}
DiffSelect.__index = DiffSelect

---@return DiffSelect
function DiffSelectNew()
  local o = {
    mode = 0,
    manual = false,
    level = 0,
  }
  return setmetatable(o, DiffSelect)
end

function DiffSelect:Up()
  if self.mode == 0 then
    self.manual = true

  elseif self.mode == 1 then
    if self.level > 0 then
      self.level -= 1
    end
  end
end

function DiffSelect:Down()
  if self.mode == 0 then
    self.manual = false

  elseif self.mode == 1 then
    if self.level < 3 then
      self.level += 1
    end
  end
end

function DiffSelect:PressO()
  if self.mode == 0 then
    self.next_session = StartScreenNew()
  else
    self.mode -= 1
  end
end

function DiffSelect:PressX()
  if self.mode == 0 then
    if self.manual then
      self.next_session = ManualNew()
    else
      self.level = 0
      self.mode = 1
    end
  else
    self.next_session = MapSelectNew(self.level)
  end
end

function DiffSelect:Update()
  StartFullTheme()

  if self.next_session then
    return self.next_session
  else
    return self
  end
end

function DiffSelect:Draw()
  DrawBackground()

  PrintLeft("read the manual", 32, 24)
  PrintLeft("play the game", 32, 36)

  if self.manual then
    rect(30, 22, 96, 30, 12)
  else
    rect(30, 34, 96, 42, 12)
  end

  if self.mode > 0 then
    PrintLeft("level:", 16, 54)
    PrintLeft("easy", 56, 54)
    PrintLeft("medium", 56, 62)
    PrintLeft("hard", 56, 70)
    PrintLeft("insane", 56, 78)

    local y = 52 + self.level * 8
    rect(54, y, 96, y + 8, 12)
  end
end
