
Vector = {}

metatable = { -- Define Vector meta methods
  __index = metatable,
  __call = function(self, a, b)
    local vec = {
      x = a or 0,
      y = b or 0
    }
    -- print("New Vector: {" .. tostring(vec.x) .. ", " .. tostring(vec.y) .. "}")
    setmetatable(vec, metatable)
    return vec
  end,
  __tostring = function(a)
    return "Vector(" .. tostring(a.x) .. ", " .. tostring(a.y) .. ")"
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
    if a == nil or b == nil then return false end
    if type(a) ~= "table" or type(b) ~= "table" then return false end
    local xClose = math.abs(a.x - b.x) < 0.01
    local yClose = math.abs(a.y - b.y) < 0.01
    --print(tostring(xClose) .. " " .. tostring(yClose))
    return xClose and yClose
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

return Vector