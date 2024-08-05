-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@alias TT number

TT_BASE = 0
TT_N_SNP_1 = 111
TT_N_SNP_2 = 112
TT_N_SNP_3 = 113
TT_N_SNP_4 = 114
TT_N_FST_2 = 122
TT_N_FST_3 = 123
TT_N_FST_4 = 124
TT_N_DMG_2 = 132
TT_N_DMG_3 = 133
TT_N_DMG_4 = 134
TT_G_SNP_1 = 211
TT_G_SNP_2 = 212
TT_G_SNP_3 = 213
TT_G_SNP_4 = 214
TT_G_DMG_2 = 222
TT_G_DMG_3 = 223
TT_G_DMG_4 = 224
TT_B_RNG_2 = 312
TT_B_RNG_3 = 313
TT_B_RNG_4 = 314
TT_B_FST_2 = 322
TT_B_FST_3 = 323
TT_B_FST_4 = 324
TT_B_DMG_1 = 331
TT_B_DMG_2 = 332
TT_B_DMG_3 = 333
TT_B_DMG_4 = 334
TT_A_SNP_1 = 411
TT_A_SNP_2 = 412
TT_A_SNP_3 = 413
TT_A_SNP_4 = 414
TT_A_SLW_2 = 422
TT_A_SLW_3 = 423
TT_A_SLW_4 = 424
TT_A_WEA_2 = 432
TT_A_WEA_3 = 433
TT_A_WEA_4 = 434

---@param type TT
---@return boolean
function IsTowerModifierUpgrade(type)
  return type == TT_B_DMG_1
end

---@param type TT
---@return boolean
function IsAreaDamageUpgrade(type)
  return type == TT_A_SNP_1
end

---@param type TT
---@return boolean
function IsNoGhostUpgrade(type)
  return type == TT_N_DMG_2
      or type == TT_A_SNP_1
      or type == TT_B_DMG_1
end

---@param type TT
---@return boolean
function IsGhostOnlyUpgrade(type)
  return type == TT_G_SNP_1
end

---@class TowerUpgrade
---@field sprite number
---@field psprite number
---@field cost number
---@field range number
---@field reload number
---@field damage number
---@field weak_f number
---@field slow_f number
---@field damage_f number
---@field reload_f number
---@field range_f number

---@alias TowerUpgradeMap TowerUpgrade[]

--- dimensions: [current_type][upgrade_type]
---@class UPGRADE_TABLE
---@field [TT] TowerUpgradeMap
UPGRADE_TABLE = {
  [TT_BASE] = {
    [TT_N_SNP_1] = {
      sprite = 64,
      psprite = 114,
      cost = 18,
      damage = 15,
      range = 18.6,
    },
    [TT_G_SNP_1] = {
      sprite = 70,
      psprite = 98,
      cost = 20,
      damage = 20,
      range = 24,
    },
    [TT_A_SNP_1] = {
      sprite = 74,
      psprite = 100,
      cost = 35,
      range = 13.3,
    },
    [TT_B_DMG_1] = {
      sprite = 106,
      psprite = 99,
      cost = 40,
      damage_f = 1.25,
    },
  },
  [TT_N_SNP_1] = {
    [TT_N_SNP_2] = {
      psprite = 114,
      cost = 32,
      damage = 25,
      range = 21.3,
    },
    [TT_N_FST_2] = {
      sprite = 68,
      psprite = 115,
      cost = 40,
      damage = 20,
      reload = 6.6,
    },
    [TT_N_DMG_2] = {
      sprite = 66,
      psprite = 117,
      cost = 50,
      damage = 35,
      range = 21.3,
      reload = 13.3,
    },
  },
  [TT_N_SNP_2] = {
    [TT_N_SNP_3] = {
      psprite = 114,
      cost = 90,
      damage = 50,
      range = 26.6,
    },
  },
  [TT_N_SNP_3] = {
    [TT_N_SNP_4] = {
      psprite = 114,
      cost = 225,
      damage = 70,
      range = 60,
    },
  },
  [TT_N_FST_2] = {
    [TT_N_FST_3] = {
      psprite = 115,
      cost = 100,
      damage = 35,
      range = 21.3,
      reload = 5.3,
    },
  },
  [TT_N_FST_3] = {
    [TT_N_FST_4] = {
      psprite = 115,
      cost = 190,
      damage = 50,
      range = 26.6,
      reload = 4,
    },
  },
  [TT_N_DMG_2] = {
    [TT_N_DMG_3] = {
      psprite = 117,
      cost = 115,
      damage = 75,
      range = 24,
    },
  },
  [TT_N_DMG_3] = {
    [TT_N_DMG_4] = {
      psprite = 117,
      cost = 250,
      damage = 150,
      range = 29.3,
    },
  },
  [TT_G_SNP_1] = {
    [TT_G_SNP_2] = {
      psprite = 114,
      cost = 40,
      damage = 30,
      range = 26.6,
    },
    [TT_G_DMG_2] = {
      sprite = 72,
      psprite = 117,
      cost = 50,
      damage = 40,
      range = 18.6,
      reload = 13.3,
    },
  },
  [TT_G_SNP_2] = {
    [TT_G_SNP_3] = {
      psprite = 114,
      cost = 100,
      damage = 50,
      range = 33.3,
    },
  },
  [TT_G_SNP_3] = {
    [TT_G_SNP_4] = {
      psprite = 114,
      cost = 250,
      damage = 70,
      range = 45,
    },
  },
  [TT_G_DMG_2] = {
    [TT_G_DMG_3] = {
      psprite = 117,
      cost = 130,
      damage = 60,
      range = 24,
    },
  },
  [TT_G_DMG_3] = {
    [TT_G_DMG_4] = {
      psprite = 117,
      cost = 325,
      damage = 120,
      range = 40,
    },
  },
  [TT_A_SNP_1] = {
    [TT_A_SNP_2] = {
      psprite = 114,
      cost = 50,
      damage = 20,
      range = 16,
    },
    [TT_A_SLW_2] = {
      sprite = 76,
      psprite = 116,
      cost = 35,
      range = 14.5,
      slow_f = 0.8,
    },
    [TT_A_WEA_2] = {
      sprite = 78,
      psprite = 101,
      cost = 80,
      range = 14,
      weak_f = 1.2,
    },
  },
  [TT_A_SNP_2] = {
    [TT_A_SNP_3] = {
      psprite = 114,
      cost = 115,
      damage = 50,
      range = 18.6,
    },
  },
  [TT_A_SNP_3] = {
    [TT_A_SNP_4] = {
      psprite = 114,
      cost = 350,
      damage = 80,
      range = 24,
    },
  },
  [TT_A_SLW_2] = {
    [TT_A_SLW_3] = {
      psprite = 116,
      cost = 90,
      range = 19,
      slow_f = 0.7,
    },
  },
  [TT_A_SLW_3] = {
    [TT_A_SLW_4] = {
      psprite = 116,
      cost = 180,
      range = 24,
      slow_f = 0.6,
    },
  },
  [TT_A_WEA_2] = {
    [TT_A_WEA_3] = {
      psprite = 101,
      cost = 130,
      range = 16,
      weak_f = 1.5,
    },
  },
  [TT_A_WEA_3] = {
    [TT_A_WEA_4] = {
      psprite = 101,
      cost = 220,
      range = 20,
      weak_f = 2,
    },
  },
  [TT_B_DMG_1] = {
    [TT_B_DMG_2] = {
      psprite = 117,
      cost = 50,
      damage_f = 1.3,
    },
    [TT_B_FST_2] = {
      sprite = 110,
      psprite = 115,
      cost = 60,
      damage_f = 0,
      reload_f = 0.8,
    },
    [TT_B_RNG_2] = {
      sprite = 108,
      psprite = 114,
      cost = 40,
      damage_f = 0,
      range_f = 1.4,
    },
  },
  [TT_B_DMG_2] = {
    [TT_B_DMG_3] = {
      psprite = 117,
      cost = 90,
      damage_f = 1.35,
    },
  },
  [TT_B_DMG_3] = {
    [TT_B_DMG_4] = {
      psprite = 117,
      cost = 190,
      damage_f = 1.5,
    },
  },
  [TT_B_FST_2] = {
    [TT_B_FST_3] = {
      psprite = 115,
      cost = 115,
      reload_f = 0.7,
    },
  },
  [TT_B_FST_3] = {
    [TT_B_FST_4] = {
      psprite = 115,
      cost = 225,
      reload_f = 0.5,
    },
  },
  [TT_B_RNG_2] = {
    [TT_B_RNG_3] = {
      psprite = 114,
      cost = 75,
      range_f = 1.6,
    },
  },
  [TT_B_RNG_3] = {
    [TT_B_RNG_4] = {
      psprite = 114,
      cost = 175,
      range_f = 2.0,
    },
  },
}
