-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Menu = {
  running = true,
  wave_handler = nil,
}
Menu.__index = Menu

function Menu:New()
  o = {
  }
  return setmetatable(o, self)
end

function Menu:SetWaveHandler(wave_handler)
  self.wave_handler = wave_handler
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

  menuitem(2, "add waves", self.wave_handler)
end

function Menu:HandleRunning()
  self.running = not self.running
  self:Update()
end
