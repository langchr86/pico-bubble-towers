-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class EndScreen
---@field killed number
---@field lost number
---@field spent number
---@field level number
---@field finished boolean
EndScreen = {}
EndScreen.__index = EndScreen

---@param level number
---@return EndScreen
function EndScreenNew(level)
  local o = {
    killed = 0,
    lost = 0,
    spent = 0,
    level = level,
    finished = false
  }

  return setmetatable(o, EndScreen)
end

function EndScreen:PressX()
  self.finished = true
end

function EndScreen:Update()
  if self.finished then
    reload()
    return DiffSelectNew()
  end
  return self
end

function EndScreen:Draw()
  DrawBackground()

  if self.lost >= 10 then
    PrintCenterX("you lost", 20, 12)
    self.lost = 10
  else
    PrintCenterX("you won", 20, 12)
  end

  if self.level == 0 then
    PrintCenterX("level: easy", 40, 12)
  elseif self.level == 1 then
    PrintCenterX("level: medium", 40, 12)
  elseif self.level == 2 then
    PrintCenterX("level: hard", 40, 12)
  else
    PrintCenterX("level: insane", 40, 12)
  end

  local function PrintStat(text, value, y)
    print(text, 20, y, 12)
    print(value, 90, y, 12)
  end

  PrintStat("killed enemies: ", self.killed, 60)
  PrintStat("lost enemies: ", self.lost, 70)
  PrintStat("cash spent: ", self.spent, 80)
end
