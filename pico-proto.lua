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
start = {x = 0, y = 7}
goal = {x = 15, y = 8}
object_map = {}
path = false

enemy = {pos = false, last_path_index = 1, speed = 1}

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
  else
    for i = 1, #path do
      local x = path[i].x * field_width
      local y = path[i].y * field_height
      spr(5, x, y)
    end
  end
end

function convert_field_to_pixel(field)
  return {px = field.x * 8, py = field.y * 8}
end

function draw_enemy_on_path()
  if path == false then
    reset_enemy()
    spr(7, goal.x * field_width, goal.y * field_height)
  else
    for i = enemy.last_path_index, #path do
      if move_enemy(path[i], enemy.speed) == true then
        draw_enemy()
        enemy.last_path_index = i
        return
      end
    end

    -- no next field -> reached goal
    reset_enemy()
  end
end

function draw_enemy()
  if enemy.pos == false then
    return
  end

  spr(2, enemy.pos.px, enemy.pos.py)
end

function move_enemy(next_field, speed)
  local function move_pixel(current, destination, speed)
    difference = destination - current
    if difference < 0 then
      return -speed
    elseif difference > 0 then
      return speed
    else
      return 0
    end
  end

  field = convert_field_to_pixel(next_field)
  moved_x = move_pixel(enemy.pos.px, field.px, speed)
  moved_y = move_pixel(enemy.pos.py, field.py, speed)

  enemy.pos.px += moved_x
  enemy.pos.py += moved_y

  return moved_x != 0 or moved_y != 0
end

function reset_enemy()
  enemy.pos = convert_field_to_pixel(start)
  enemy.last_path_index = 1
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
    reset_enemy()
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
  draw_enemy_on_path()

  fps = stat(7)
  print(fps, 120, 0, 10)
  print(sw_algo, 0, 0, 10)
end
