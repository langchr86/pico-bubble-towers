-- Copyright 2024 by Christian Lang is lluaTowericensed under CC BY-NC-SA 4.0

Tower = {
  sprite_n=8,
  pos=nil,
  radius=1,
  shot_interval=30,
}
Tower.__index = Tower

function Tower:New(pos)
  o = {
    pos=pos:Clone(),
  }
  return setmetatable(o, self)
end

function Tower:Draw()
  spr(self.sprite_n, self.pos.x, self.pos.y)
end
