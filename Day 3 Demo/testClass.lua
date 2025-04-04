
TestClass = {}

function TestClass:new(xPos, yPos, rot)
  local testClass = {}
  
  setmetatable(testClass, {__index = TestClass})
  
  testClass.position = {x = xPos, y = yPos}
  testClass.rotation = rot
  return testClass
end

function TestClass:draw()
  -- NEW CODE - not in class
  love.graphics.setColor(1, 1, 1, 0.5) -- color values [0, 1]
  love.graphics.circle("fill", self.position.x, self.position.y, 50)
  
  love.graphics.setColor(0, 0, 0, 1)
  local posString = tostring(math.floor(self.position.x)) .. ", " .. tostring(math.floor(self.position.y))
  love.graphics.print(posString, self.position.x, self.position.y)
end