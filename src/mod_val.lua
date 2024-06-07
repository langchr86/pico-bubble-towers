-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class ModVal
---@field base number
---@field current number
ModVal = {}
ModVal.__index = ModVal

---@param base number
---@return ModVal
function ModVal:New(base)
  local o = {}

  local instance = --[[---@type ModVal]] setmetatable(o, self)

  instance:SetBase(base)

  return instance
end

function ModVal:Reset()
  self.current = self.base
  assert(self.current > 0)
end

---@param base number
function ModVal:SetBase(base)
  assert(base > 0)
  self.base = base
  self.current = base
end

---@param factor number
function ModVal:Modify(factor)
  if factor > 0 then
    self.current = self.current * factor
  end
  assert(self.current > 0)
end

---@return number
function ModVal:Get()
  return self.current
end
