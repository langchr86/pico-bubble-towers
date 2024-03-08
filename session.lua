-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Session = {
  map_index=0,
  start=nil,
  goal=nil,
  enemy_path={},
  tower_list={},
  enemy_list={},
  player_life=0,
}
Session.__index = Session

function Session:New(map_index)
  o = {
    map_index=map_index,
    start=Point:New(0, 7),
    goal=Point:New(15, 8),
    enemy_path={},
    tower_list={},
    enemy_list={},
    player_life=20,
  }
  return setmetatable(o, self)
end

function Session:PlaceTower(cursor)
  local removed = false
  for tower in all(self.tower_list) do
    if tower.pos == cursor.pos then
      tower:Destroy()
      del(self.tower_list, tower)
      self.enemy_path = self:CalculateNewPath()
      self:ResetEnemies()
      return
    end
  end

  if not cursor:IsFree() then
    return
  end

  local new_tower = Tower:New(cursor.pos)
  local new_path = self:CalculateNewPath()
  if #new_path > 0 then
    add(self.tower_list, new_tower)
    self.enemy_path = new_path
    self:ResetEnemies()
  else
    new_tower:Destroy()
  end
end

function Session:CalculateNewPath()
  local function is_coord_reachable(x, y)
    return IsTileFree(Point:New(x, y))
  end

  local path = module:find(max_x, max_y, self.start, self.goal, is_coord_reachable)

  local real_path = {}
  if (path == false) return {}

  for pos in all(path) do
    local pos = ConvertTileToPixel(pos)
    add(real_path, pos)
  end

  return real_path
end

function Session:ResetEnemies()
  self.enemy_list = {}
  self:CreateEnemiesIfNeeded()
end

function Session:CreateEnemiesIfNeeded()
  if (#self.enemy_path == 0) return

  local start_point = ConvertTileToPixel(self.start)
  local diff_point = Point:New(16, 0)

  for i=#self.enemy_list,3 do
    enemy = Enemy:New(start_point, self.enemy_path)
    add(self.enemy_list, enemy)

    start_point = start_point - diff_point
  end
end

function Session:DrawPath()
  for pos in all(self.enemy_path) do
    spr(16, pos.x, pos.y)
  end
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

  self:CreateEnemiesIfNeeded()

  for tower in all(self.tower_list) do
    tower:Update(self.enemy_list)
  end
end

function Session:Draw()
  if self.player_life <= 0 then
    map(0, 16)
    return
  end

  map(self.map_index * kMapSizeInTiles, 0)

  self:DrawPath()

  for tower in all(self.tower_list) do
    tower:Draw()
  end

  for enemy in all(self.enemy_list) do
    enemy:Draw()
  end

  spr(17, self.start.x * kTileSize, self.start.y * kTileSize)
  spr(18, self.goal.x * kTileSize, self.goal.y * kTileSize)

  print(self.player_life, 0, 0, 10)
end
