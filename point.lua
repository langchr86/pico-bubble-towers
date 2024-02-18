-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Point = {
    x=0,
    y=0,
}
Point.__index = Point

function Point:New(init_x, init_y)
    o = {
        x=init_x,
        y=init_y,
    }
    return setmetatable(o, self)
end
