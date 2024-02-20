-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

function _init()
  cls()

  -- custom cursor speed for btnp()
  poke(0x5f5c, 8) -- set the initial delay before repeating. 255 means never repeat.
  poke(0x5f5d, 2) -- set the repeating delay.
end

cursor = {x=0, y=0}
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
object_map = {}
path = false

enemy = Enemy:New(start)

sw_algo = 0


function tower_placement()
  current = { x = cursor.x, y = cursor.y }

  removed = false
  for value in all(object_map) do
    if value.x == current.x and value.y == current.y then
      del(object_map, value)
      removed = true
      break
    end
  end

  if removed == false then
    add(object_map, current)
  end
end

function path_calculation()
  local function is_coord_reachable(x, y)
    -- should return true if the position is open to walk
    for _, value in pairs(object_map) do
      if value.x == x and value.y == y then
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
    spr(7, goal.x * field_width, goal.y * field_height)
    return
  end

  for i = 1, #path do
    local pos = convert_field_to_pixel(path[i])
    spr(5, pos.x, pos.y)
  end
end

function convert_field_to_pixel(field)
  return Point:New(field.x * 8, field.y * 8)
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
    cursor.y -= 1
    if cursor.y < min_y then
      cursor.y = min_y
    end
  end

  if btnp(⬇️) then
    cursor.y += 1
    if cursor.y > max_y then
      cursor.y = max_y
    end
  end

  if btnp(⬅️) then
    cursor.x -= 1
    if cursor.x < min_x then
      cursor.x = min_x
    end
  end

  if btnp(➡️) then
    cursor.x += 1
    if cursor.x > max_x then
      cursor.x = max_x
    end
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

  for value in all(object_map) do
    spr(1, value.x * field_width, value.y * field_height)
  end

  spr(3, start.x * field_width, start.y * field_height)
  spr(4, goal.x * field_width, goal.y * field_height)
  spr(6, cursor.x * field_width, cursor.y * field_height)

  draw_path()
  draw_enemy()

  fps = stat(7)
  print(fps, 120, 0, 10)
  print(sw_algo, 0, 0, 10)
end
