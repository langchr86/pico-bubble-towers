-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Manual
---@field page number
Manual = {}
Manual.__index = Manual

---@return Manual
function Manual:New()
  local o = {
    page = 0
  }
  return setmetatable(o, self)
end

function Manual:PressO()
  self.page -= 1
end

function Manual:PressX()
  self.page += 1
end

function Manual:Update()
  if self.page < 0 or self.page > 3 then
    return DifficultySelection:New()
  end
  return self
end

function Manual:Draw()
  rectfill(0, 0, 127, 127, 1)
  rect(0, 0, 127, 127, 12)

  if self.page == 0 then
    print("mission:", 8, 4, 12)
    print("do not allow enemies", 8, 20, 12)
    print("to enter the goal.", 8, 30, 12)
    print("place defence towers", 8, 50, 12)
    print("to shape the", 8, 60, 12)
    print("enemies path.", 8, 70, 12)
    print("upgrade towers with", 8, 90, 12)
    print("the earned cash by", 8, 100, 12)
    print("destroying enemies.", 8, 110, 12)

    spr(8, 94, 18)
    spr(18, 94, 28)
    spr(34, 94, 50, 2, 2)
    spr(110, 94, 90, 2, 2)

  elseif self.page == 1 then
    print("enemies:", 8, 4, 12)

    spr(8, 8, 18)
    print("normal", 20, 20, 12)
    spr(12, 8, 28)
    print("fast but weak", 20, 30, 12)
    spr(24, 8, 38)
    print("slow but heavy armored", 20, 40, 12)
    spr(28, 8, 48)
    print("regenerates life over time", 20, 50, 12)
    spr(32, 8, 58)
    print("can fly over towers", 20, 60, 12)


    spr(40, 39, 80)
    spr(44, 49, 80)
    spr(56, 59, 80)
    spr(60, 69, 80)
    spr(48, 79, 80)
    PrintCenterX("boss variants", 94, 12)
    PrintCenterX("are much stronger", 104, 12)


  elseif self.page == 2 then
    print("attacking towers:", 8, 4, 12)

    spr(64, 8, 18, 2, 2)
    spr(114, 26, 19)
    print("better range & damage", 36, 20, 12)
    spr(66, 8, 38, 2, 2)
    spr(117, 26, 39)
    print("more damage", 36, 40, 12)
    spr(68, 8, 58, 2, 2)
    spr(115, 26, 59)
    print("higher fire rate", 36, 60, 12)
    spr(70, 8, 78, 2, 2)
    spr(98, 26, 79)
    print("can only shot flying", 36, 80, 12)
    spr(74, 8, 98, 2, 2)
    spr(100, 26, 99)
    print("area damage", 36, 100, 12)

  elseif self.page == 3 then
    print("special towers:", 8, 4, 12)

    spr(76, 8, 18, 2, 2)
    spr(116, 26, 19)
    print("slow down enemies", 36, 20, 12)
    spr(78, 8, 38, 2, 2)
    spr(101, 26, 39)
    print("weaken enemies", 36, 40, 12)
    spr(106, 8, 58, 2, 2)
    spr(117, 26, 59)
    print("increase tower damage", 36, 60, 12)
    spr(108, 8, 78, 2, 2)
    spr(114, 26, 79)
    print("increase tower range", 36, 80, 12)
    spr(110, 8, 98, 2, 2)
    spr(115, 26, 99)
    print("increase tower rate", 36, 100, 12)
  end
end
