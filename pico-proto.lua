-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

function _init()
  cls()

  -- custom cursor speed for btnp()
  poke(0x5f5c, 8) -- set the initial delay before repeating. 255 means never repeat.
  poke(0x5f5d, 2) -- set the repeating delay.
end

screen_max = Point:New(128, 128)
field_size = 8
cursor_min = Point:New(field_size, field_size)
cursor_max = screen_max - cursor_min - cursor_min
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

tower_list = {}
enemy = Enemy:New(start)

sw_algo = 0


function tower_placement()
  current = cursor.pos

  removed = false
  for tower in all(tower_list) do
    if tower.pos == current then
      del(tower_list, tower)
      removed = true
      break
    end
  end

  if removed == false then
    add(tower_list, Tower:New(current))
  end
end

function path_calculation()
  local function is_coord_reachable(x, y)
    -- should return true if the position is open to walk
    for tower in all(tower_list) do
      field_pos = convert_pixel_to_field(tower.pos)
      if field_pos.x == x and field_pos.y == y then
        return false
      end
    end
    return true
  end

  sw_algo = stat(1)
  path = module:find(max_x, max_y, start, goal, is_coord_reachable)
  sw_algo = stat(1) - sw_algo
end

function draw_path()
  if path == false then
    path_pos = convert_field_to_pixel(goal)
    spr(7, path_pos.x, path_pos.y)
    return
  end

  for i = 1, #path do
    local pos = convert_field_to_pixel(path[i])
    spr(5, pos.x, pos.y)
  end
end

function convert_field_to_pixel(field)
  return Point:New(field.x * field_size, field.y * field_size)
end

function convert_pixel_to_field(pos)
  return Point:New(pos.x / field_size, pos.y / field_size)
end

function draw_enemy()
  if path == false then
    enemy:Reset(convert_field_to_pixel(start))
    return
  end

  next_field = path[enemy.last_path_index]
  current_dest = convert_field_to_pixel(next_field)

  if not enemy:DefineMoveDestination(current_dest) then
    enemy.last_path_index += 1

    if enemy.last_path_index > #path then
      -- no next field -> reached goal
      enemy:Reset(convert_field_to_pixel(start))
      return
    end

    next_field = path[enemy.last_path_index]
    current_dest = convert_field_to_pixel(next_field)
    enemy:DefineMoveDestination(current_dest)
  end

  enemy:Move()
  enemy:Draw()
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

  if btnp(🅾️) then
  end

  if btnp(❎) then
    tower_placement()
    enemy:Reset(convert_field_to_pixel(start))
    path_calculation()
  end

end

function _draw()
  cls()
  map()

  for tower in all(tower_list) do
    tower:Draw()
  end

  spr(3, start.x * field_width, start.y * field_height)
  spr(4, goal.x * field_width, goal.y * field_height)

  draw_path()
  draw_enemy()
  cursor:Draw()

  fps = stat(7)
  print(fps, 120, 0, 10)
  print(sw_algo, 0, 0, 10)
end
