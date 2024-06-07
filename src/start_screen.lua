-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class StartScreen
---@field next_session any
StartScreen = {}
StartScreen.__index = StartScreen

---@return StartScreen
function StartScreen:New()
  local instance = --[[---@type StartScreen]] setmetatable({}, self)
  instance:Init()
  return instance
end

function StartScreen:Init()
  music(0, 120)
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
  memcpy(0x6000, 0x8000, 128 * 64)
  rect(0, 0, 127, 127, 12)
end
