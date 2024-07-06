-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class EndScreen
---@field killed number
---@field lost number
---@field spent number
---@field level number
---@field map number
---@field finished boolean
EndScreen = {}
EndScreen.__index = EndScreen

---@param level number
---@param map number
---@return EndScreen
function EndScreenNew(level, map)
  local o = {
    killed = 0,
    lost = 0,
    spent = 0,
    level = level,
    map = map,
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
    PrintCenterX("you lost", 20)
    self.lost = 10
  else
    PrintCenterX("you won", 20)
  end

  if self.level == 0 then
    PrintCenterX("level: easy", 40)
  elseif self.level == 1 then
    PrintCenterX("level: medium", 40)
  elseif self.level == 2 then
    PrintCenterX("level: hard", 40)
  else
    PrintCenterX("level: insane", 40)
  end

  local x = PrintLeft("map: ", 50, 50)
  PrintLeft(self.map, x, 50)

  local function PrintStat(text, value, y)
    PrintLeft(text, 20, y)
    PrintLeft(value, 90, y)
  end

  PrintStat("killed enemies: ", self.killed, 70)
  PrintStat("lost enemies: ", self.lost, 80)
  PrintStat("cash spent: ", self.spent, 90)
end
