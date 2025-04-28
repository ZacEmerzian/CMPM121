
Vector = {}

metatable = {
  __call = function(self, a, b)
    local vec = {
      x = a or 0,
      y = b or 0
    }
    setmetatable(vec, metatable)
    return vec
  end, 
  __add = function(a, b)
    return Vector(a.x + b.x, a.y + b.y)
  end,
  __mul = function(a, b)
    if type(a) == "number" then return Vector(a * b.x, a * b.y) end   
    if type(b) == "number" then return Vector(a.x * b, a.y * b) end
    return Vector(a.x * b.x, a.y * b.y)
  end,
  __eq = function(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then return false end
    return a.x == b.x and a.y == b.y
  end
}

setmetatable(Vector, metatable)