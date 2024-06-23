-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class DifficultySelection
---@field mode number
---@field manual boolean
---@field level number
---@field next_session any
DifficultySelection = {}
DifficultySelection.__index = DifficultySelection

---@return DifficultySelection
function DifficultySelection:New()
  local o = {
    mode = 0,
    manual = false,
    level = 0,
  }
  return setmetatable(o, self)
end

function DifficultySelection:Up()
  if self.mode == 0 then
    self.manual = not self.manual

  elseif self.mode == 1 then
    if self.level > 0 then
      self.level = self.level - 1
    end
  end
end

function DifficultySelection:Down()
  if self.mode == 0 then
    self.manual = not self.manual

  elseif self.mode == 1 then
    if self.level < 2 then
      self.level = self.level + 1
    end
  end
end

function DifficultySelection:PressO()
  if self.mode == 0 then
    self.next_session = MapSelection:New()
  else
    self.mode = self.mode - 1
  end
end

function DifficultySelection:PressX()
  if self.mode == 0 then
    if self.manual then
      --- TODO self.next_session = Manual:New()
    else
      self.level = 0
      self.mode = 1
    end
  elseif self.mode == 1 then
    self.mode = 2
  else
    self.next_session = GameSession:New(CreatePredefinedWaveList(self.level))
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
  rectfill(0, 0, 127, 127, 1)
  rect(0, 0, 127, 127, 12)
  PrintCenterX("select difficulty level", 4, 12)

  print("mode:", 16, 24, 12)
  print("normal", 56, 24, 12)
  print("manual", 56, 36, 12)

  if self.manual then
    rect(54, 34, 96, 42, 12)
  else
    rect(54, 22, 96, 30, 12)
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
