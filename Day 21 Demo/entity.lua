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

function EntityClass:new(dc, sc, xPos, yPos, scale)
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
  local tempSprite = entity.spriteClass.sprites[1]
  entity.size = Vector(
    tempSprite:getPixelWidth(), 
    tempSprite:getPixelHeight()
  )
  entity.scale = SPRITE_SCALE * (scale == nil and 1 or scale)
  
  entity.collisionCell = nil
  local newGridPos = Vector(
    math.floor(entity.position.x / (collisionManager.CELL_SIZE * SPRITE_SCALE)) + 1,
    math.floor(entity.position.y / (collisionManager.CELL_SIZE * SPRITE_SCALE)) + 1
  )
  collisionManager:addToCell(entity, newGridPos)
  
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
    self.size.x/2, self.size.y/2
  )
  
  -- DEBUG SPRITE CENTER
  local white = {1, 1, 1, 1}
  local black = {0.4, 0, 0, 1}
  love.graphics.setColor(white)
  love.graphics.circle("fill", self.position.x, self.position.y, 8)
  love.graphics.setColor(black)
  love.graphics.circle("fill", self.position.x, self.position.y, 6)
  love.graphics.setColor(white)
  love.graphics.circle("fill", self.position.x, self.position.y, 2)  
end


