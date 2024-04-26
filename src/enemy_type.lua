-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

---@alias EnemyType number

---@type table<string, EnemyType>
EnemyType = {
  NORMAL = 0,
  GHOST = 1,
  FAST = 2,
  REGENERATE = 3,
  HEAVY = 4,
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
  [EnemyType.GHOST] = {
    sprite = 32,
    sprite_count = 2,
    frame_count = 10,
    speed = 1.0,
    life = 100,
    value_bonus = 0,
  },
  [EnemyType.FAST] = {
    sprite = 34,
    sprite_count = 4,
    frame_count = 6,
    speed = 1.4,
    life = 100,
    value_bonus = 0,
  },
  [EnemyType.REGENERATE] = {
    sprite = 0,
    sprite_count = 1,
    frame_count = 100,
    speed = 0.8,
    life = 100,
    value_bonus = 10,
  },
}
