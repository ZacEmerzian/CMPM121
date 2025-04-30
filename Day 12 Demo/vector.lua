
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
  __sub = function(a, b)
    return Vector(a.x - b.x, a.y - b.y)
  end,
  __mul = function(a, b)
    if type(a) == "number" then return Vector(a * b.x, a * b.y) end   
    if type(b) == "number" then return Vector(a.x * b, a.y * b) end
    return Vector(a.x * b.x, a.y * b.y)
  end,
  __eq = function(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then return false end
    return a.x == b.x and a.y == b.y
  end,
  __tostring = function(a)
    return "(" .. tostring(a.x) .. ", " .. tostring(a.y) .. ")"
  end
}

setmetatable(Vector, metatable)

function Vector:magnitude(a)
  return math.sqrt(a.x^2 + a.y^2)
end

function Vector:normalize(a)
  return Vector(
    a.x / Vector:magnitude(a),
    a.y / Vector:magnitude(a)
  )
end