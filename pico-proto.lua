function _init()
  cls()
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

btn_up = false

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

  if btnp(❎) then
    local function is_coord_reachable(x, y)
      -- should return true if the position is open to walk
      for _, value in pairs(object_map) do
        if value.x == x and value.y == y then
          return false
        end
      end
      return true
    end

    excludeDiagonalMoving = true
    path = module:find(max_x, max_y, start, goal, is_coord_reachable, excludeDiagonalMoving)
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

  if path == false then
    spr(7, goal.x * field_width, goal.y * field_height)
  else
    for i = 1, #path do
      local x = path[i].x * field_width
      local y = path[i].y * field_height
      spr(5, x, y)
    end
  end
  --map()
  --pset(b1.x, b1.y, 12)
  --spr(2, b1.x, b1.y)
end
