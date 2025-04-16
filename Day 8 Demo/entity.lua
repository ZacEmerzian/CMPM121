require "vector"

EntityClass = {}

SPRITE_SIZE = 16
SPRITE_SCALE = 4

inputVector = {
  ["w"] = Vector(0, -1),
  ["a"] = Vector(-1, 0),
  ["s"] = Vector(0, 1),
  ["d"] = Vector(1, 0)
}

DIRECTIONS = {
  UP = 1,
  DOWN = 2,
  LEFT = 3,
  RIGHT = 4
}

function EntityClass:new(sc, xPos, yPos, width, height, scale)
  local entity = {}
  local metatable = {__index = EntityClass}
  setmetatable(entity, metatable)
  
  --entity.sprite = love.graphics.newImage("Sprites/LinkDown.png")
  entity.spriteClass = sc
    
  entity.facingDirection = DIRECTIONS.DOWN
  entity.walking = false
  
  entity.position = Vector(xPos, yPos)
  entity.size = Vector(width, height) * SPRITE_SIZE
  entity.scale = SPRITE_SCALE * (scale == nil and 1 or scale)
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
  
  -- NEW (change direction and set walking bool)
  if moveDirection.y ~= 0 then
    self.facingDirection = moveDirection.y > 0 and DIRECTIONS.DOWN or DIRECTIONS.UP
  elseif moveDirection.x ~= 0 then
    self.facingDirection = moveDirection.x > 0 and DIRECTIONS.RIGHT or DIRECTIONS.LEFT
  end
  
  self.walking = moveDirection ~= Vector(0, 0)
end

function EntityClass:draw()
  --love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
  
  local currentSprite, flipX = self.spriteClass:getSprite(self.facingDirection, self.walking)
  
  love.graphics.draw(currentSprite, 
    self.position.x, self.position.y, 0, 
    self.scale * flipX, self.scale,
    self.size.x/2, self.size.y/2)
end


