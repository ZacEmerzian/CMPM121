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

directionToVector = {
  Vector(0, -1),
  Vector(0, 1),
  Vector(-1, 0),
  Vector(1, 0)
}

function EntityClass:new(dc, sc, xPos, yPos, width, height, scale)
  local entity = {}
  local metatable = {__index = EntityClass}
  setmetatable(entity, metatable)
  
  entity.dataClass = dc
  entity.behavior = entity.dataClass.behavior:new(entity)
  entity.spriteClass = sc
    
  entity.facingDirection = DIRECTIONS.DOWN
  entity.animationFrame = 1
  entity.walking = false
  
  entity.position = Vector(xPos, yPos)
  entity.size = Vector(width, height) * SPRITE_SIZE
  entity.scale = SPRITE_SCALE * (scale == nil and 1 or scale)
  return entity
end

function EntityClass:update()
  if self.behavior == nil then
    return
  end
  
  self.behavior:update()
end

function EntityClass:draw()
  --love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
  
  local currentSprite, flipX = self.spriteClass:getSprite(self.facingDirection, self.walking, self)
  
  love.graphics.draw(currentSprite, 
    self.position.x, self.position.y, 0, 
    self.scale * flipX, self.scale,
    self.size.x/2, self.size.y/2)
end


