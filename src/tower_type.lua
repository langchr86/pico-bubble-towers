-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@alias TowerType number

---@type table<string, TowerType>
TowerType = {
  BASE = 0,
  NORMAL_SNIPER_L1 = 111,
  NORMAL_SNIPER_L2 = 112,
  NORMAL_SNIPER_L3 = 113,
  NORMAL_SNIPER_L4 = 114,
  NORMAL_FAST_L2 = 122,
  NORMAL_FAST_L3 = 123,
  NORMAL_FAST_L4 = 124,
  NORMAL_SPLASH_L2 = 132,
  NORMAL_SPLASH_L3 = 133,
  NORMAL_SPLASH_L4 = 134,
  GHOST_SNIPER_L1 = 211,
  GHOST_SNIPER_L2 = 212,
  GHOST_SNIPER_L3 = 213,
  GHOST_SNIPER_L4 = 214,
  GHOST_SPLASH_L2 = 222,
  GHOST_SPLASH_L3 = 223,
  GHOST_SPLASH_L4 = 224,
  BOOST_RANGE_L2 = 312,
  BOOST_RANGE_L3 = 313,
  BOOST_RANGE_L4 = 314,
  BOOST_FAST_L2 = 322,
  BOOST_FAST_L3 = 323,
  BOOST_FAST_L4 = 324,
  BOOST_DAMAGE_L1 = 331,
  BOOST_DAMAGE_L2 = 332,
  BOOST_DAMAGE_L3 = 333,
  BOOST_DAMAGE_L4 = 334,
  AREA_SNIPER_L1 = 411,
  AREA_SNIPER_L2 = 412,
  AREA_SNIPER_L3 = 413,
  AREA_SNIPER_L4 = 414,
  AREA_SLOW_L2 = 422,
  AREA_SLOW_L3 = 423,
  AREA_SLOW_L4 = 424,
  AREA_WEAK_L2 = 432,
  AREA_WEAK_L3 = 433,
  AREA_WEAK_L4 = 434,
}

---@param type TowerType
---@return boolean
function IsTowerModifierUpgrade(type)
  return type == TowerType.BOOST_DAMAGE_L1
end

---@param type TowerType
---@return boolean
function IsAreaDamageUpgrade(type)
  return type == TowerType.AREA_SNIPER_L1
end

---@param type TowerType
---@return boolean
function IsNoGhostUpgrade(type)
  return type == TowerType.NORMAL_SPLASH_L2
      or type == TowerType.AREA_SNIPER_L1
      or type == TowerType.BOOST_DAMAGE_L1
end

---@param type TowerType
---@return boolean
function IsGhostOnlyUpgrade(type)
  return type == TowerType.GHOST_SNIPER_L1
end

---@class TowerUpgrade
---@field sprite number
---@field preview_sprite number
---@field cost number
---@field range number
---@field reload number
---@field damage number
---@field weaken_factor number
---@field slow_down_factor number
---@field damage_factor number
---@field reload_factor number
---@field range_factor number

---@alias TowerUpgradeMap TowerUpgrade[]

--- dimensions: [current_type][upgrade_type]
---@class UPGRADE_TABLE
---@field [TowerType] TowerUpgradeMap
UPGRADE_TABLE = {
  [TowerType.BASE] = {
    [TowerType.NORMAL_SNIPER_L1] = {
      sprite = 66,
      preview_sprite = 114,
      cost = 18,
      damage = 15,
      range = 18.6,
    },
    [TowerType.GHOST_SNIPER_L1] = {
      sprite = 70,
      preview_sprite = 98,
      cost = 20,
      damage = 20,
      range = 24,
    },
    [TowerType.AREA_SNIPER_L1] = {
      sprite = 68,
      preview_sprite = 100,
      cost = 35,
      range = 13.3,
    },
    [TowerType.BOOST_DAMAGE_L1] = {
      sprite = 72,
      preview_sprite = 99,
      cost = 40,
      damage_factor = 1.25,
    },
  },
  [TowerType.NORMAL_SNIPER_L1] = {
    [TowerType.NORMAL_SNIPER_L2] = {
      preview_sprite = 114,
      cost = 32,
      damage = 25,
      range = 21.3,
    },
    [TowerType.NORMAL_FAST_L2] = {
      preview_sprite = 115,
      cost = 40,
      damage = 20,
      reload = 6.6,
    },
    [TowerType.NORMAL_SPLASH_L2] = {
      preview_sprite = 117,
      cost = 50,
      damage = 35,
      range = 21.3,
      reload = 13.3,
    },
  },
  [TowerType.NORMAL_SNIPER_L2] = {
    [TowerType.NORMAL_SNIPER_L3] = {
      preview_sprite = 114,
      cost = 90,
      damage = 70,
      range = 26.6,
    },
  },
  [TowerType.NORMAL_SNIPER_L3] = {
    [TowerType.NORMAL_SNIPER_L4] = {
      preview_sprite = 114,
      cost = 225,
      damage = 180,
      range = 60,
    },
  },
  [TowerType.NORMAL_FAST_L2] = {
    [TowerType.NORMAL_FAST_L3] = {
      preview_sprite = 115,
      cost = 100,
      damage = 45,
      range = 21.3,
      reload = 5.3,
    },
  },
  [TowerType.NORMAL_FAST_L3] = {
    [TowerType.NORMAL_FAST_L4] = {
      preview_sprite = 115,
      cost = 190,
      damage = 75,
      range = 26.6,
      reload = 4,
    },
  },
  [TowerType.NORMAL_SPLASH_L2] = {
    [TowerType.NORMAL_SPLASH_L3] = {
      preview_sprite = 117,
      cost = 115,
      damage = 75,
      range = 24,
    },
  },
  [TowerType.NORMAL_SPLASH_L3] = {
    [TowerType.NORMAL_SPLASH_L4] = {
      preview_sprite = 117,
      cost = 250,
      damage = 200,
      range = 29.3,
    },
  },
  [TowerType.GHOST_SNIPER_L1] = {
    [TowerType.GHOST_SNIPER_L2] = {
      preview_sprite = 114,
      cost = 40,
      damage = 40,
      range = 26.6,
    },
    [TowerType.GHOST_SPLASH_L2] = {
      preview_sprite = 117,
      cost = 50,
      damage = 50,
      range = 18.6,
      reload = 13.3,
    },
  },
  [TowerType.GHOST_SNIPER_L2] = {
    [TowerType.GHOST_SNIPER_L3] = {
      preview_sprite = 114,
      cost = 100,
      damage = 100,
      range = 33.3,
    },
  },
  [TowerType.GHOST_SNIPER_L3] = {
    [TowerType.GHOST_SNIPER_L4] = {
      preview_sprite = 114,
      cost = 250,
      damage = 250,
      range = 45,
    },
  },
  [TowerType.GHOST_SPLASH_L2] = {
    [TowerType.GHOST_SPLASH_L3] = {
      preview_sprite = 117,
      cost = 130,
      damage = 130,
      range = 24,
    },
  },
  [TowerType.GHOST_SPLASH_L3] = {
    [TowerType.GHOST_SPLASH_L4] = {
      preview_sprite = 117,
      cost = 325,
      damage = 325,
      range = 40,
    },
  },
  [TowerType.AREA_SNIPER_L1] = {
    [TowerType.AREA_SNIPER_L2] = {
      preview_sprite = 114,
      cost = 50,
      damage = 20,
      range = 16,
    },
    [TowerType.AREA_SLOW_L2] = {
      sprite = 76,
      preview_sprite = 116,
      cost = 35,
      range = 14,
      slow_down_factor = 0.8,
    },
    [TowerType.AREA_WEAK_L2] = {
      sprite = 74,
      preview_sprite = 101,
      cost = 80,
      range = 14,
      weaken_factor = 1.2,
    },
  },
  [TowerType.AREA_SNIPER_L2] = {
    [TowerType.AREA_SNIPER_L3] = {
      preview_sprite = 114,
      cost = 115,
      damage = 50,
      range = 18.6,
    },
  },
  [TowerType.AREA_SNIPER_L3] = {
    [TowerType.AREA_SNIPER_L4] = {
      preview_sprite = 114,
      cost = 350,
      damage = 160,
      range = 24,
    },
  },
  [TowerType.AREA_SLOW_L2] = {
    [TowerType.AREA_SLOW_L3] = {
      preview_sprite = 116,
      cost = 90,
      range = 18.6,
      slow_down_factor = 0.7,
    },
  },
  [TowerType.AREA_SLOW_L3] = {
    [TowerType.AREA_SLOW_L4] = {
      preview_sprite = 116,
      cost = 180,
      range = 24,
      slow_down_factor = 0.6,
    },
  },
  [TowerType.AREA_WEAK_L2] = {
    [TowerType.AREA_WEAK_L3] = {
      preview_sprite = 101,
      cost = 130,
      range = 16,
      weaken_factor = 1.5,
    },
  },
  [TowerType.AREA_WEAK_L3] = {
    [TowerType.AREA_WEAK_L4] = {
      preview_sprite = 101,
      cost = 220,
      range = 20,
      weaken_factor = 2,
    },
  },
  [TowerType.BOOST_DAMAGE_L1] = {
    [TowerType.BOOST_DAMAGE_L2] = {
      preview_sprite = 117,
      cost = 50,
      damage_factor = 1.3,
    },
    [TowerType.BOOST_FAST_L2] = {
      preview_sprite = 115,
      cost = 60,
      damage_factor = 0,
      reload_factor = 0.8,
    },
    [TowerType.BOOST_RANGE_L2] = {
      preview_sprite = 114,
      cost = 40,
      damage_factor = 0,
      range_factor = 1.4,
    },
  },
  [TowerType.BOOST_DAMAGE_L2] = {
    [TowerType.BOOST_DAMAGE_L3] = {
      preview_sprite = 117,
      cost = 90,
      damage_factor = 1.35,
    },
  },
  [TowerType.BOOST_DAMAGE_L3] = {
    [TowerType.BOOST_DAMAGE_L4] = {
      preview_sprite = 117,
      cost = 190,
      damage_factor = 1.5,
    },
  },
  [TowerType.BOOST_FAST_L2] = {
    [TowerType.BOOST_FAST_L3] = {
      preview_sprite = 115,
      cost = 115,
      reload_factor = 0.7,
    },
  },
  [TowerType.BOOST_FAST_L3] = {
    [TowerType.BOOST_FAST_L4] = {
      preview_sprite = 115,
      cost = 225,
      reload_factor = 0.5,
    },
  },
  [TowerType.BOOST_RANGE_L2] = {
    [TowerType.BOOST_RANGE_L3] = {
      preview_sprite = 114,
      cost = 75,
      range_factor = 1.6,
    },
  },
  [TowerType.BOOST_RANGE_L3] = {
    [TowerType.BOOST_RANGE_L4] = {
      preview_sprite = 114,
      cost = 175,
      range_factor = 2.0,
    },
  },
}
