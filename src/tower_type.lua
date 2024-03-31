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
  AREA_SNIPER_L1 = 311,
  AREA_SNIPER_L2 = 312,
  AREA_SNIPER_L3 = 313,
  AREA_SNIPER_L4 = 314,
  AREA_SLOW_L2 = 322,
  AREA_SLOW_L3 = 323,
  AREA_SLOW_L4 = 324,
  AREA_WEAK_L2 = 332,
  AREA_WEAK_L3 = 333,
  AREA_WEAK_L4 = 334,
  BOOST_DAMAGE_L1 = 411,
  BOOST_DAMAGE_L2 = 412,
  BOOST_DAMAGE_L3 = 413,
  BOOST_DAMAGE_L4 = 414,
  BOOST_FAST_L2 = 422,
  BOOST_FAST_L3 = 423,
  BOOST_FAST_L4 = 424,
  BOOST_RANGE_L2 = 432,
  BOOST_RANGE_L3 = 433,
  BOOST_RANGE_L4 = 434,
}

---@class TowerUpgrade
---@field sprite number
---@field preview_sprite number
---@field cost number
---@field radius number
---@field reload number
---@field damage number

---@alias TowerUpgradeMap TowerUpgrade[]

--- dimensions: [current_type][upgrade_type]
---@class UPGRADE_TABLE
---@field [TowerType] TowerUpgradeMap
UPGRADE_TABLE = {
  [TowerType.BASE] = {
    [TowerType.NORMAL_SNIPER_L1] = {
      preview_sprite = 162,
      cost = 18,
      sprite = 130,
      radius = 20,
    },
    [TowerType.GHOST_SNIPER_L1] = {
      preview_sprite = 166,
      cost = 20,
      sprite = 134,
    },
    [TowerType.AREA_SNIPER_L1] = {
      preview_sprite = 164,
      cost = 35,
      sprite = 132,
    },
    [TowerType.BOOST_DAMAGE_L1] = {
      preview_sprite = 168,
      cost = 40,
      sprite = 136,
    },
  },
  [TowerType.NORMAL_SNIPER_L1] = {
    [TowerType.NORMAL_SNIPER_L2] = {
      preview_sprite = 179,
      cost = 32,
      radius = 30,
    },
    [TowerType.NORMAL_FAST_L2] = {
      preview_sprite = 181,
      cost = 32,
      reload = 10,
    },
    [TowerType.NORMAL_SPLASH_L2] = {
      preview_sprite = 183,
      cost = 32,
      damage = 15,
    },
  },
  [TowerType.NORMAL_SNIPER_L2] = {
    [TowerType.NORMAL_SNIPER_L3] = {
      preview_sprite = 179,
      cost = 90,
      radius = 40,
    },
  },
  [TowerType.NORMAL_SNIPER_L3] = {
    [TowerType.NORMAL_SNIPER_L4] = {
      preview_sprite = 179,
      cost = 225,
      radius = 70,
    },
  },
  [TowerType.NORMAL_FAST_L2] = {
    [TowerType.NORMAL_FAST_L3] = {
      preview_sprite = 181,
      cost = 32,
      reload = 7,
    },
  },
  [TowerType.NORMAL_FAST_L3] = {
    [TowerType.NORMAL_FAST_L4] = {
      preview_sprite = 181,
      cost = 32,
      reload = 4,
    },
  },
  [TowerType.NORMAL_SPLASH_L2] = {
    [TowerType.NORMAL_SPLASH_L3] = {
      preview_sprite = 183,
      cost = 32,
      damage = 20,
    },
  },
  [TowerType.NORMAL_SPLASH_L3] = {
    [TowerType.NORMAL_SPLASH_L4] = {
      preview_sprite = 183,
      cost = 32,
      damage = 30,
    },
  },
  [TowerType.GHOST_SNIPER_L1] = {},
  [TowerType.AREA_SNIPER_L1] = {},
  [TowerType.BOOST_DAMAGE_L1] = {},
}
