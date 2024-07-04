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
    self.manual = not self.manual

  elseif self.mode == 1 then
    if self.level > 0 then
      self.level -= 1
    end
  end
end

function DiffSelect:Down()
  if self.mode == 0 then
    self.manual = not self.manual

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
  elseif self.mode == 1 then
    self.mode = 2
  else
    self.next_session = MapSelectNew(CreatePredefinedWaveList(self.level))
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

  print("start game", 32, 36, 12)
  print("read the manual", 32, 24, 12)

  if self.manual then
    rect(30, 22, 96, 30, 12)
  else
    rect(30, 34, 96, 42, 12)
  end

  if self.mode > 0 then
    self:DrawNormal()
  end

  if self.mode > 1 then
    PrintCenterX("start?", 98, 12)
    rect(48, 96, 78, 104, 12)
  end
end

function DiffSelect:DrawNormal()
  print("level:", 16, 54, 12)
  print("easy", 56, 54, 12)
  print("medium", 56, 62, 12)
  print("hard", 56, 70, 12)
  print("insane", 56, 78, 12)

  local y = 52 + self.level * 8
  rect(54, y, 96, y + 8, 12)
end
