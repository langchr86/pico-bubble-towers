-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class ModVal
---@field base number
---@field current number
ModVal = {}
ModVal.__index = ModVal

---@param base number
---@return ModVal
function ModValNew(base)
  local instance = --[[---@type ModVal]] setmetatable({}, ModVal)
  instance:SetBase(base)
  return instance
end

function ModVal:Reset()
  self.current = self.base
end

---@param base number
function ModVal:SetBase(base)
  self.base = base
  self.current = base
end

---@param f number
function ModVal:Modify(f)
  if f > 0 then
    self.current = self.current * f
  end
end

---@return number
function ModVal:Get()
  return self.current
end
