--[[
    Lua star example - Run with love (https://love2d.org/)
    Copyright 2018 Wesley Werner <wesley.werner@gmail.com>

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

    References:
    https://en.wikipedia.org/wiki/A*_search_algorithm
    https://www.redblobgames.com/pathfinding/a-star/introduction.html
    https://www.raywenderlich.com/4946/introduction-to-a-pathfinding
]]--

--- Provides easy A* path finding.
-- @module lua-star

LuaStar = {}
LuaStar.__index = LuaStar

-- (Internal) Return the distance between two points.
-- This method doesn't bother getting the square root of s, it is faster
-- and it still works for our use.
local function distance(x1, y1, x2, y2)
  local dx = x1 - x2
  local dy = y1 - y2
  local s = dx * dx + dy * dy
  return s
end

-- (Internal) Clamp a value to a range.
local function clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end

-- (Internal) Return the score of a node.
-- G is the cost from START to this node.
-- H is a heuristic cost, in this case the distance from this node to the goal.
-- Returns F, the sum of G and H.
local function calculateScore(previous, node, goal)

    local G = previous.score + 1
    local H = distance(node.x, node.y, goal.x, goal.y)
    return G + H, G, H

end

-- (Internal) Returns true if the given list contains the specified item.
local function listContains(list, item)
    for _, test in ipairs(list) do
        if test.x == item.x and test.y == item.y then
            return true
        end
    end
    return false
end

-- (Internal) Returns the item in the given list.
local function listItem(list, item)
    for _, test in ipairs(list) do
        if test.x == item.x and test.y == item.y then
            return test
        end
    end
end

local positions = {
    { x = 0, y = -1 },  -- top
    { x = -1, y = 0 },  -- left
    { x = 0, y = 1 },   -- bottom
    { x = 1, y = 0 },   -- right
}

-- (Internal) Requests adjacent map values around the given node.
local function getAdjacent(max_x, max_y, node, positionIsOpenFunc)

    local result = { }


    for _, point in ipairs(positions) do
        local px = clamp(node.x + point.x, 0, max_x)
        local py = clamp(node.y + point.y, 0, max_y)
        local value = positionIsOpenFunc( px, py )
        if value then
            add(result, { x = px, y = py  } )
        end
    end

    return result

end

-- Returns the path from start to goal, or false if no path exists.
---@param max_x number
---@param max_y number
---@param start Point
---@param goal Point
---@param positionIsOpenFunc function
---@return Point[]|boolean
function LuaStar:Find(max_x, max_y, start, goal, positionIsOpenFunc)
    local success = false
    local open = { }
    local closed = { }

    start.score = 0
    start.G = 0
    start.H = distance(start.x, start.y, goal.x, goal.y)
    start.parent = { x = -1, y = -1 }
    add(open, start)

    while not success and #open > 0 do

        -- sort by score: high to low
        InsertionSort(open, function(a, b) return a.score > b.score end)

        local current = deli(open)

        add(closed, current)

        success = listContains(closed, goal)

        if not success then

            local adjacentList = getAdjacent(max_x, max_y, current, positionIsOpenFunc)

            for _, adjacent in ipairs(adjacentList) do

                if not listContains(closed, adjacent) then

                    if not listContains(open, adjacent) then

                        adjacent.score = calculateScore(current, adjacent, goal)
                        adjacent.parent = current
                        add(open, adjacent)

                    end

                end

            end

        end

    end


    if not success then
        return false
    end

    -- traverse the parents from the last point to get the path
    local node = listItem(closed, closed[#closed])
    local path = { }

    while node do
        add(path, { x = node.x, y = node.y }, 1 )
        node = listItem(closed, node.parent)
    end


    -- reverse the closed list to get the solution
    return path

end

-- return module
