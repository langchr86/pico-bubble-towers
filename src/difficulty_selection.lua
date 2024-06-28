-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class DifficultySelection
---@field mode number
---@field manual boolean
---@field level number
---@field next_session any
DifficultySelection = {}
DifficultySelection.__index = DifficultySelection

---@return DifficultySelection
function DifficultySelectionNew()
  local o = {
    mode = 0,
    manual = false,
    level = 0,
  }
  return setmetatable(o, DifficultySelection)
end

function DifficultySelection:Up()
  if self.mode == 0 then
    self.manual = not self.manual

  elseif self.mode == 1 then
    if self.level > 0 then
      self.level -= 1
    end
  end
end

function DifficultySelection:Down()
  if self.mode == 0 then
    self.manual = not self.manual

  elseif self.mode == 1 then
    if self.level < 2 then
      self.level += 1
    end
  end
end

function DifficultySelection:PressO()
  if self.mode == 0 then
    self.next_session = StartScreenNew()
  else
    self.mode -= 1
  end
end

function DifficultySelection:PressX()
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
    self.next_session = MapSelectionNew(CreatePredefinedWaveList(self.level))
  end
end

function DifficultySelection:Update()
  if self.next_session then
    return self.next_session
  else
    return self
  end
end

function DifficultySelection:Draw()
  DrawBackground()
  PrintCenterX("select difficulty level", 4, 12)

  print("start game", 32, 24, 12)
  print("read the manual", 32, 36, 12)

  if self.manual then
    rect(30, 34, 96, 42, 12)
  else
    rect(30, 22, 96, 30, 12)
  end

  if self.mode > 0 then
    self:DrawNormal()
  end

  if self.mode > 1 then
    PrintCenterX("start?", 98, 12)
    rect(48, 96, 78, 104, 12)
  end
end

function DifficultySelection:DrawNormal()
  print("level:", 16, 54, 12)
  print("easy", 56, 54, 12)
  print("medium", 56, 62, 12)
  print("hard", 56, 70, 12)

  local y = 52 + self.level * 8
  rect(54, y, 96, y + 8, 12)
end
