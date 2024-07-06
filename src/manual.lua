-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Manual
---@field page number
Manual = {}
Manual.__index = Manual

---@return Manual
function ManualNew()
  local o = {
    page = 1
  }
  return setmetatable(o, Manual)
end

function Manual:PressO()
  self.page -= 1
end

function Manual:PressX()
  self.page += 1
end

function Manual:Update()
  if self.page < 1 or self.page > 4 then
    return DiffSelectNew()
  end
  return self
end

function Manual:Draw()
  DrawBackground()

  local function TextLine(text, y)
    print(text, 18, y, 12)
  end

  local function TowerDesc(sprite, psprite, spsprite, text, y)
    spr(sprite, 8, y, 2, 2)
    spr(psprite, 26, y)
    if spsprite != 0 then
      spr(spsprite, 26, y + 8)
    end
    print(text, 38, y + 2, 12)
  end

  if self.page == 1 then
    PrintCenterX("mission", 6)

    TextLine("do not allow enemies", 20)
    TextLine("to enter the goal   .", 29)
    TextLine("start enemy wave with 🅾️.", 38)

    TextLine("place defence towers", 54)
    TextLine("with ❎ to shape", 63)
    TextLine("the enemies path.", 72)

    TextLine("upgrade towers with", 88)
    TextLine("the cash earned by", 97)
    TextLine("destroying enemies.", 106)

    spr(8, 100, 18)
    spr(18, 90, 27)
    spr(36, 100, 54, 2, 2)
    spr(110, 100, 88, 2, 2)

  elseif self.page == 2 then
    PrintCenterX("enemies", 6)

    spr(8, 8, 18)
    TextLine("normal", 20)
    spr(12, 8, 28)
    TextLine("fast but weak", 30)
    spr(24, 8, 38)
    TextLine("slow but heavy armored", 40)
    spr(28, 8, 48)
    TextLine("regenerates life over time", 50)
    spr(32, 8, 58)
    TextLine("can fly over towers", 60)

    spr(40, 39, 80)
    spr(44, 49, 80)
    spr(56, 59, 80)
    spr(60, 69, 80)
    spr(48, 79, 80)
    PrintCenterX("boss variants", 94)
    PrintCenterX("are much stronger", 104)

  elseif self.page == 3 then
    PrintCenterX("attacking towers", 6)

    TowerDesc(64, 114, 0, "better range & damage", 18)
    TowerDesc(66, 117, 0, "more damage", 38)
    TowerDesc(68, 115, 0, "higher fire rate", 58)
    TowerDesc(70, 98, 0, "can only shot flying", 78)
    TowerDesc(74, 100, 0, "area damage", 98)

  elseif self.page == 4 then
    PrintCenterX("special towers", 6)

    TowerDesc(76, 100, 116, "slow down enemies", 18)
    TowerDesc(78, 100, 101, "weaken enemies", 38)
    TowerDesc(106, 99, 117, "increase tower damage", 58)
    TowerDesc(108, 99, 114, "increase tower range", 78)
    TowerDesc(110, 99, 115, "increase tower rate", 98)
  end

  local x = PrintRight("/4", 126, 120, 12)
  PrintRight(self.page, x, 120, 12)
end
