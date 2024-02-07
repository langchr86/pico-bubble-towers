b1 = {}
b1.x = 0
b1.y = 64

function _init()
  cls()
end

function _update()
b1.x = b1.x + 1
    if b1.x > 127 then
    b1.x = 0
  end
end

function _draw()
  cls()
  --pset(b1.x, b1.y, 12)
  spr(2, b1.x, b1.y)
end
