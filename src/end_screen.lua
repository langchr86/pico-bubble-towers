-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class EndScreen
---@field killed number
---@field lost number
---@field spent number
---@field finished boolean
EndScreen = {}
EndScreen.__index = EndScreen

---@return EndScreen
function EndScreenNew()
  local o = {
    killed = 0,
    lost = 0,
    spent = 0,
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
    return DifficultySelectionNew()
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

  local function PrintStat(text, value, y)
    print(text, 20, y, 12)
    print(value, 90, y, 12)
  end

  PrintStat("killed enemies: ", self.killed, 40)
  PrintStat("lost enemies: ", self.lost, 50)
  PrintStat("cash spent: ", self.spent, 60)
end
