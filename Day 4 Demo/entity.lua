require "vector"

EntityClass = {}

inputVector = {
  ["w"] = Vector(0, -1),
  ["a"] = Vector(-1, 0),
  ["s"] = Vector(0, 1),
  ["d"] = Vector(1, 0)
}

function EntityClass:new(xPos, yPos, width, height)
  local entity = {}
  local metatable = {__index = EntityClass}
  setmetatable(entity, metatable)
  
  entity.position = Vector(xPos, yPos)
  entity.size = Vector(width, height)
  return entity
end

function EntityClass:update()
  
  local moveDirection = Vector(0, 0)
  
  for input, direction in pairs(inputVector) do
    if love.keyboard.isDown(input) then
      moveDirection = moveDirection + direction
    end
  end
  
  self.position = self.position + moveDirection
end

function EntityClass:draw()
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
end