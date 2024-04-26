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
      preview_sprite = 114,
      cost = 18,
      sprite = 66,
      range = 20,
    },
    [TowerType.GHOST_SNIPER_L1] = {
      preview_sprite = 98,
      cost = 20,
      sprite = 70,
      damage = 15,
    },
    [TowerType.AREA_SNIPER_L1] = {
      preview_sprite = 100,
      cost = 35,
      sprite = 68,
    },
    [TowerType.BOOST_DAMAGE_L1] = {
      preview_sprite = 99,
      cost = 40,
      sprite = 72,
      damage_factor = 2,
    },
  },
  [TowerType.NORMAL_SNIPER_L1] = {
    [TowerType.NORMAL_SNIPER_L2] = {
      preview_sprite = 114,
      cost = 32,
      range = 30,
    },
    [TowerType.NORMAL_FAST_L2] = {
      preview_sprite = 115,
      cost = 32,
      reload = 10,
    },
    [TowerType.NORMAL_SPLASH_L2] = {
      preview_sprite = 117,
      cost = 32,
      damage = 15,
    },
  },
  [TowerType.NORMAL_SNIPER_L2] = {
    [TowerType.NORMAL_SNIPER_L3] = {
      preview_sprite = 114,
      cost = 90,
      range = 40,
    },
  },
  [TowerType.NORMAL_SNIPER_L3] = {
    [TowerType.NORMAL_SNIPER_L4] = {
      preview_sprite = 114,
      cost = 225,
      range = 70,
    },
  },
  [TowerType.NORMAL_FAST_L2] = {
    [TowerType.NORMAL_FAST_L3] = {
      preview_sprite = 115,
      cost = 32,
      reload = 7,
    },
  },
  [TowerType.NORMAL_FAST_L3] = {
    [TowerType.NORMAL_FAST_L4] = {
      preview_sprite = 115,
      cost = 32,
      reload = 4,
    },
  },
  [TowerType.NORMAL_SPLASH_L2] = {
    [TowerType.NORMAL_SPLASH_L3] = {
      preview_sprite = 117,
      cost = 32,
      damage = 20,
    },
  },
  [TowerType.NORMAL_SPLASH_L3] = {
    [TowerType.NORMAL_SPLASH_L4] = {
      preview_sprite = 117,
      cost = 32,
      damage = 30,
    },
  },
  [TowerType.GHOST_SNIPER_L1] = {
    [TowerType.GHOST_SNIPER_L2] = {
      preview_sprite = 114,
      cost = 32,
      range = 30,
    },
    [TowerType.GHOST_SPLASH_L2] = {
      preview_sprite = 117,
      cost = 32,
      damage = 20,
    },
  },
  [TowerType.GHOST_SNIPER_L2] = {
    [TowerType.GHOST_SNIPER_L3] = {
      preview_sprite = 114,
      cost = 90,
      range = 40,
    },
  },
  [TowerType.GHOST_SNIPER_L3] = {
    [TowerType.GHOST_SNIPER_L4] = {
      preview_sprite = 114,
      cost = 150,
      range = 50,
    },
  },
  [TowerType.GHOST_SPLASH_L2] = {
    [TowerType.GHOST_SPLASH_L3] = {
      preview_sprite = 117,
      cost = 118,
      damage = 30,
    },
  },
  [TowerType.GHOST_SPLASH_L3] = {
    [TowerType.GHOST_SPLASH_L4] = {
      preview_sprite = 117,
      cost = 250,
      damage = 40,
    },
  },
  [TowerType.AREA_SNIPER_L1] = {
    [TowerType.AREA_SNIPER_L2] = {
      preview_sprite = 114,
      cost = 32,
      range = 20,
    },
    [TowerType.AREA_SLOW_L2] = {
      preview_sprite = 116,
      cost = 32,
      sprite = 76,
      slow_down_factor = 0.9,
    },
    [TowerType.AREA_WEAK_L2] = {
      preview_sprite = 101,
      cost = 32,
      sprite = 74,
      weaken_factor = 1.5,
    },
  },
  [TowerType.AREA_SNIPER_L2] = {
    [TowerType.AREA_SNIPER_L3] = {
      preview_sprite = 114,
      cost = 90,
      range = 30,
    },
  },
  [TowerType.AREA_SNIPER_L3] = {
    [TowerType.AREA_SNIPER_L4] = {
      preview_sprite = 114,
      cost = 250,
      range = 40,
    },
  },
  [TowerType.AREA_SLOW_L2] = {
    [TowerType.AREA_SLOW_L3] = {
      preview_sprite = 116,
      cost = 90,
      range = 30,
      slow_down_factor = 0.7,
    },
  },
  [TowerType.AREA_SLOW_L3] = {
    [TowerType.AREA_SLOW_L4] = {
      preview_sprite = 116,
      cost = 250,
      range = 40,
      slow_down_factor = 0.5,
    },
  },
  [TowerType.AREA_WEAK_L2] = {
    [TowerType.AREA_WEAK_L3] = {
      preview_sprite = 101,
      cost = 90,
      range = 30,
      weaken_factor = 2,
    },
  },
  [TowerType.AREA_WEAK_L3] = {
    [TowerType.AREA_WEAK_L4] = {
      preview_sprite = 101,
      cost = 250,
      range = 40,
      weaken_factor = 3,
    },
  },
  [TowerType.BOOST_DAMAGE_L1] = {
    [TowerType.BOOST_DAMAGE_L2] = {
      preview_sprite = 117,
      cost = 70,
      damage_factor = 3,
    },
    [TowerType.BOOST_FAST_L2] = {
      preview_sprite = 115,
      cost = 70,
      damage_factor = 0,
      reload_factor = 0.8,
    },
    [TowerType.BOOST_RANGE_L2] = {
      preview_sprite = 114,
      cost = 70,
      damage_factor = 0,
      range_factor = 1.3,
    },
  },
  [TowerType.BOOST_DAMAGE_L2] = {
    [TowerType.BOOST_DAMAGE_L3] = {
      preview_sprite = 117,
      cost = 150,
      damage_factor = 4,
    },
  },
  [TowerType.BOOST_DAMAGE_L3] = {
    [TowerType.BOOST_DAMAGE_L4] = {
      preview_sprite = 117,
      cost = 250,
      damage_factor = 5,
    },
  },
  [TowerType.BOOST_FAST_L2] = {
    [TowerType.BOOST_FAST_L3] = {
      preview_sprite = 115,
      cost = 150,
      reload_factor = 0.5,
    },
  },
  [TowerType.BOOST_FAST_L3] = {
    [TowerType.BOOST_FAST_L4] = {
      preview_sprite = 115,
      cost = 250,
      reload_factor = 0.2,
    },
  },
  [TowerType.BOOST_RANGE_L2] = {
    [TowerType.BOOST_RANGE_L3] = {
      preview_sprite = 114,
      cost = 150,
      range_factor = 1.7,
    },
  },
  [TowerType.BOOST_RANGE_L3] = {
    [TowerType.BOOST_RANGE_L4] = {
      preview_sprite = 114,
      cost = 250,
      range_factor = 2.0,
    },
  },
}
