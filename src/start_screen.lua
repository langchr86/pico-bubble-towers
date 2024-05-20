-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class StartScreen
---@field next_session any
StartScreen = {}
StartScreen.__index = StartScreen

---@return StartScreen
function StartScreen:New()
  local o = {
    next_session = nil,
  }

  local instance = --[[---@type StartScreen]] setmetatable(o, self)
  instance:Init()
  return instance
end

function StartScreen:Init()
  music(0,120)
end

function StartScreen:MoveUp()
end

function StartScreen:MoveDown()
end

function StartScreen:MoveLeft()
end

function StartScreen:MoveRight()
end

function StartScreen:PressO()
end

function StartScreen:PressX()
  self.next_session = MapSelection:New()
end

function StartScreen:Update()
    if self.next_session then
    return self.next_session
  else
    return self
  end
end

function StartScreen:Draw()
  rectfill(0, 0, 127, 127, 1)
  rect(0, 0, 127, 127, 12)
  PrintCenterX("bubble towers", 50, 12)
  PrintCenterX("pRESS ❎ TO CONFIRM", 80, 12)
  PrintCenterX("pRESS 🅾️ TO ABORT", 88, 12)
end
