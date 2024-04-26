-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@alias EnemyType number

---@type table<string, EnemyType>
EnemyType = {
  NORMAL = 0,
  GHOST = 1,
  FAST = 2,
  REGENERATE = 3,
  HEAVY = 4,
  NORMAL_BOSS = 5,
  GHOST_BOSS = 6,
  FAST_BOSS = 7,
  REGENERATE_BOSS = 8,
  HEAVY_BOSS = 9,
}

---@class EnemyProperties
---@field sprite number
---@field sprite_count number
---@field frame_count number
---@field speed number
---@field life number
---@field value_bonus number

---@class ENEMY_TABLE
---@field [EnemyType] EnemyProperties
ENEMY_TABLE = {
  [EnemyType.NORMAL] = {
    sprite = 8,
    sprite_count = 4,
    frame_count = 8,
    speed = 1.0,
    life = 100,
    value_bonus = 0,
  },
  [EnemyType.GHOST] = {
    sprite = 32,
    sprite_count = 2,
    frame_count = 10,
    speed = 1.0,
    life = 100,
    value_bonus = 5,
  },
  [EnemyType.FAST] = {
    sprite = 12,
    sprite_count = 4,
    frame_count = 4,
    speed = 1.4,
    life = 100,
    value_bonus = 0,
  },
  [EnemyType.REGENERATE] = {
    sprite = 28,
    sprite_count = 3,
    frame_count = 6,
    speed = 1.0,
    life = 100,
    value_bonus = 5,
  },
  [EnemyType.HEAVY] = {
    sprite = 24,
    sprite_count = 4,
    frame_count = 6,
    speed = 0.6,
    life = 200,
    value_bonus = 0,
  },
  [EnemyType.NORMAL_BOSS] = {
    sprite = 40,
    sprite_count = 4,
    frame_count = 8,
    speed = 1.0,
    life = 300,
    value_bonus = 20,
  },
  [EnemyType.GHOST_BOSS] = {
    sprite = 48,
    sprite_count = 2,
    frame_count = 10,
    speed = 1.0,
    life = 200,
    value_bonus = 25,
  },
  [EnemyType.FAST_BOSS] = {
    sprite = 44,
    sprite_count = 4,
    frame_count = 4,
    speed = 1.4,
    life = 200,
    value_bonus = 20,
  },
  [EnemyType.REGENERATE_BOSS] = {
    sprite = 60,
    sprite_count = 3,
    frame_count = 6,
    speed = 1.0,
    life = 200,
    value_bonus = 25,
  },
  [EnemyType.HEAVY_BOSS] = {
    sprite = 56,
    sprite_count = 4,
    frame_count = 6,
    speed = 0.6,
    life = 400,
    value_bonus = 20,
  },
}
