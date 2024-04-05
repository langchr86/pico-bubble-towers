-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class ModifiableValue
---@field base number
---@field current number
ModifiableValue = {}
ModifiableValue.__index = ModifiableValue

---@param base number
---@return ModifiableValue
function ModifiableValue:New(base)
  local o = {}

  local instance = --[[---@type ModifiableValue]] setmetatable(o, self)

  instance:SetBase(base)

  return instance
end

function ModifiableValue:Reset()
  self.current = self.base
  assert(self.current > 0)
end

---@param base number
function ModifiableValue:SetBase(base)
  assert(base > 0)
  self.base = base
  self.current = base
end

---@param factor number
function ModifiableValue:Modify(factor)
  if factor > 0 then
    self.current = self.current * factor
  end
  assert(self.current > 0)
end

---@return number
function ModifiableValue:Get()
  return self.current
end
