-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

Enemy = {
    sprite_n=2,
    pos=nil,
    dest_pos=nil,
    speed=1,
    last_path_index=1,
}
Enemy.__index = Enemy

function Enemy:New(init_pos)
    o = {
        sprite_n=Enemy.sprite_n,
        pos=init_pos,
        dest_pos=Enemy.dest_pos,
        speed=Enemy.speed,
        last_path_index=Enemy.last_path_index,
    }
    return setmetatable(o, self)
end
