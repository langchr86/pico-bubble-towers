-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@class Manual
---@field page number
Manual = {}
Manual.__index = Manual

---@return Manual
function ManualNew()
  local o = {
    page = 0
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
  if self.page < 0 or self.page > 3 then
    return DifficultySelectionNew()
  end
  return self
end

function Manual:Draw()
  DrawBackground()

  local function TextLine(text, y)
    print(text, 18, y, 12)
  end

  local function TowerDescription(sprite, psprite, text, y)
    spr(sprite, 8, y, 2, 2)
    spr(psprite, 26, y + 1)
    print(text, 38, y + 2, 12)
  end

  if self.page == 0 then
    TextLine("mission:", 4)
    TextLine("do not allow enemies", 20)
    TextLine("to enter the goal.", 30)
    TextLine("place defence towers", 50)
    TextLine("to shape the", 60)
    TextLine("enemies path.", 70)
    TextLine("upgrade towers with", 90)
    TextLine("the earned cash by", 100)
    TextLine("destroying enemies.", 110)

    spr(8, 100, 18)
    spr(18, 100, 28)
    spr(34, 100, 50, 2, 2)
    spr(110, 100, 90, 2, 2)

  elseif self.page == 1 then
    TextLine("enemies:", 4)

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
    PrintCenterX("boss variants", 94, 12)
    PrintCenterX("are much stronger", 104, 12)


  elseif self.page == 2 then
    TextLine("attacking towers:", 4)

    TowerDescription(64, 114, "better range & damage", 18)
    TowerDescription(66, 117, "more damage", 38)
    TowerDescription(68, 115, "higher fire rate", 58)
    TowerDescription(70, 98, "can only shot flying", 78)
    TowerDescription(74, 100, "area damage", 98)

  elseif self.page == 3 then
    TextLine("special towers:", 4)

    TowerDescription(76, 116, "slow down enemies", 18)
    TowerDescription(78, 101, "weaken enemies", 38)
    TowerDescription(106, 117, "increase tower damage", 58)
    TowerDescription(108, 114, "increase tower range", 78)
    TowerDescription(110, 115, "increase tower rate", 98)
  end
end
