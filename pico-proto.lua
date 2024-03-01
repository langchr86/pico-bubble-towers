-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

menu = Menu:New()

function _init()
  cls()

  -- custom cursor speed for btnp()
  poke(0x5f5c, 8) -- set the initial delay before repeating. 255 means never repeat.
  poke(0x5f5d, 2) -- set the repeating delay.

  menu:Update()
end

screen_max = Point:New(128, 128)
field_size = 8
cursor_min = Point:New(0, 0)
cursor_max = screen_max
cursor = Cursor:New(cursor_min, cursor_min, cursor_max, field_size)

field_width = 8
field_height = 8
map_width = 16
map_height = 16

min_x = 0
min_y = 0
max_x = map_width - 1
max_y = map_height - 1

field = {}
start = Point:New(0, 7)
goal = Point:New(15, 8)
path = false
real_path = {}

tower_list = {}
enemy_list = {}

sw_algo = 0


function TowerPlacement()
  local removed = false
  for tower in all(tower_list) do
    if tower.pos == cursor.pos then
      tower:Destroy()
      del(tower_list, tower)
      return
    end

    if tower:PlacedOn(cursor.pos) then
      return
    end
  end

  add(tower_list, Tower:New(cursor.pos))
end

function PathCalculation()
  local function is_coord_reachable(x, y)
    -- should return true if the position is open to walk
    local sprite = mget(x, y)
    local massive = fget(sprite, 0)
    return not massive
  end

  sw_algo = stat(1)
  path = module:find(max_x, max_y, start, goal, is_coord_reachable)
  sw_algo = stat(1) - sw_algo

  real_path = {}
  if (path == false) return

  for pos in all(path) do
    local pos = ConvertFieldToPixel(pos)
    add(real_path, pos)
  end
end

function ResetEnemies()
  enemy_list = {}
  CreateEnemiesIfNeeded()
end

function CreateEnemiesIfNeeded()
  if (#real_path == 0) return

  local start_point = ConvertFieldToPixel(start)
  local diff_point = Point:New(16, 0)

  for i=#enemy_list,3 do
    enemy = Enemy:New(start_point, real_path)
    add(enemy_list, enemy)

    start_point = start_point - diff_point
  end
end

function UpdateObjects()
  for enemy in all(enemy_list) do
    enemy:Update()
    if enemy:IsDead() or enemy:InTarget() then
      del(enemy_list, enemy)
    end
  end

  CreateEnemiesIfNeeded()

  for tower in all(tower_list) do
    tower:Update(enemy_list)
  end
end

function DrawPath()
  if path == false then
    path_pos = ConvertFieldToPixel(goal)
    spr(7, path_pos.x, path_pos.y)
    return
  end

  for pos in all(real_path) do
    spr(5, pos.x, pos.y)
  end
end

function ConvertFieldToPixel(field)
  return Point:New(field.x * field_size, field.y * field_size)
end

function ConvertPixelToField(pos)
  return Point:New(pos.x / field_size, pos.y / field_size)
end

function _update()
  if btnp(⬆️) then
    cursor:MoveUp()
  end

  if btnp(⬇️) then
    cursor:MoveDown()
  end

  if btnp(⬅️) then
    cursor:MoveLeft()
  end

  if btnp(➡️) then
    cursor:MoveRight()
  end

  if btn(🅾️) then
    if not menu.running then
      UpdateObjects()
    end
  end

  if btnp(❎) then
    TowerPlacement()
    PathCalculation()
    ResetEnemies()
  end

  if menu.running then
    UpdateObjects()
  end
end

function _draw()
  cls()
  map()

  DrawPath()

  for tower in all(tower_list) do
    tower:Draw()
  end

  for enemy in all(enemy_list) do
    enemy:Draw()
  end

  spr(3, start.x * field_width, start.y * field_height)
  spr(4, goal.x * field_width, goal.y * field_height)

  cursor:Draw()

  fps = stat(7)
  print(fps, 120, 0, 10)
  print(sw_algo, 0, 0, 10)

  cursor_sprite = mget(cursor.pos.x / field_width, cursor.pos.y / field_width)
  print(cursor_sprite, 1, 121, 10)
  print(fget(cursor_sprite, 0), 17, 121, 10)
end
