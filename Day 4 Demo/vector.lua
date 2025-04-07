
Vector = {}

metatable = {
  __call = function(self, a, b)
    local vec = {
      x = a,
      y = b
    }
    setmetatable(vec, metatable)
    return vec
  end, 
  __add = function(a, b)
    return Vector(a.x + b.x, a.y + b.y)
  end
}

setmetatable(Vector, metatable)