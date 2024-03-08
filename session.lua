-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Session = {
  map_index=0,
  start=nil,
  goal=nil,
  enemy_path={},
  tower_list={},
  enemy_list={},
  wave_list={},
  cash=9999,
  player_life=0,
}
Session.__index = Session

function Session:New(map_index, wave_list)
  o = {
    map_index=map_index,
    start=Point:New(0, 0),
    goal=Point:New(0, 0),
    enemy_path={},
    tower_list={},
    enemy_list={},
    wave_list=wave_list,
    player_life=20,
  }

  return setmetatable(o, self)
end

function Session:Init()
  self:SearchSpecialPoints()
  self:CalculateNewPath()
end

function Session:SearchSpecialPoints()
  self:DrawMap()

  for x=0,kMapSizeInTiles do
    for y=0,kMapSizeInTiles do
      local tile_pos = Point:New(x, y)
      if fget(mget(x, y), 6) then
        self.start = tile_pos
      elseif fget(mget(x, y), 7) then
        self.goal = tile_pos
      end
    end
  end
end

function Session:PlaceTower(cursor)
  if (self:AnyEnemies()) return

  local removed = false
  for tower in all(self.tower_list) do
    if tower.pos == cursor.pos then
      tower:Destroy()
      del(self.tower_list, tower)
      self:CalculateNewPath()
      return
    end
  end

  if not cursor:IsFree() then
    return
  end

  local new_tower = Tower:New(cursor.pos)
  if self:CalculateNewPath() then
    add(self.tower_list, new_tower)
  else
    new_tower:Destroy()
  end
end

function Session:StartNextWave()
  if (#self.enemy_path == 0) return
  if (#self.wave_list == 0) return

  local next_wave = deli(wave_list, 1)

  local start_point = ConvertTileToPixel(self.start)
  local diff_point = Point:New(16, 0)

  for i=1,next_wave.enemy_count do
    enemy = Enemy:New(start_point, self.enemy_path, next_wave.enemy_type)
    add(self.enemy_list, enemy)

    start_point = start_point - diff_point
  end
end

function Session:AnyEnemies()
  return #self.enemy_list > 0
end

function Session:CalculateNewPath()
  local function is_coord_reachable(x, y)
    return IsTileFree(Point:New(x, y))
  end

  local path = module:find(15, 15, self.start, self.goal, is_coord_reachable)
  if (path == false) return false

  self.enemy_path = {}
  for pos in all(path) do
    local pos = ConvertTileToPixel(pos)
    add(self.enemy_path, pos)
  end

  return true
end

function Session:DrawMapBorder()
  local border_color = 6
  line(0, kTileSize, 127, kTileSize, border_color)
  line(0, kTileSize, 0, 127, border_color)
  line(127, kTileSize, 127, 127, border_color)
  line(0, 127, 127, 127, border_color)
end

function Session:DrawMap()
  map(self.map_index * kMapSizeInTiles, 0)
end

function Session:DrawPath()
  for pos in all(self.enemy_path) do
    spr(16, pos.x, pos.y)
  end
end

function Session:DrawStats()
  for x=0,15 do
    spr(9, x * kTileSize, 0)
  end

  print("cash: ", 1, 1, 12)
  print(self.cash, 21, 1, 7)

  print("next: ", 43, 1, 12)
  local x = 62
  for i=1,min(4, #self.wave_list) do
    local wave = self.wave_list[i]
    local enemy_sprite = 32 + wave.enemy_type
    spr(enemy_sprite, x, 0)
    x += 8
  end

  print("life: ", 100, 1, 12)
  print(self.player_life, 120, 1, 7)
end

function Session:Update()
  for enemy in all(self.enemy_list) do
    enemy:Update()
    if enemy:IsDead() then
      del(self.enemy_list, enemy)
    end
    if enemy:InTarget() then
      del(self.enemy_list, enemy)
      self.player_life -= 1
    end
  end

  for tower in all(self.tower_list) do
    tower:Update(self.enemy_list)
  end
end

function Session:Draw(cursor)
  if self.player_life <= 0 then
    map(0, 16)
    return
  end

  self:DrawMap()
  self:DrawPath()

  for tower in all(self.tower_list) do
    tower:Draw(cursor)
  end

  for enemy in all(self.enemy_list) do
    enemy:Draw()
  end

  self:DrawMapBorder()
  self:DrawStats()
end
