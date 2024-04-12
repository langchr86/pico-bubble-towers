-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Menu
---@field running boolean
---@field debug_info_handler function
Menu = {}
Menu.__index = Menu

---@return Menu
function Menu:New()
  local o = {
    running = true,
    debug_info_handler = nil,
  }
  return --[[---@type Menu]] setmetatable(o, self)
end

function Menu:SetDebugInfoHandler(debug_info_handler)
  self.debug_info_handler = debug_info_handler
end

function Menu:Update()
  local function HandleRunningWrapper()
    self:HandleRunning()
  end

  if self.running then
    menuitem(1, "stop animation", HandleRunningWrapper)
  else
    menuitem(1, "start animation", HandleRunningWrapper)
  end

  menuitem(2, "toggle debg info", self.debug_info_handler)
end

function Menu:HandleRunning()
  self.running = not self.running
  self:Update()
end
