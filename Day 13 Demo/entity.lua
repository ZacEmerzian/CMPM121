
require "vector"

EntityPrototype = {}

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

ANIMATION_STATES = {
  IDLE = 1,
  ATTACK = 2,
  SPELL = 3,
  HIT = 4
  -- We could add move if we need to
}

function EntityPrototype:new(dispName, xPos, yPos, spriteCollection, hp)
  local entity = {}
  local metadata = {__index = EntityPrototype}
  setmetatable(entity, metadata)
  
  entity.displayName = dispName
  
  entity.health = hp and hp/2 or nil 
  entity.maxHealth = hp or nil 
  
  entity.spriteTable = spriteCollection
  entity.animationFrame = 1
  entity.animationSpeed = 5
  entity.currentAnimationState = ANIMATION_STATES.IDLE
  
  entity.position = Vector(
    xPos * WINDOW_SCALE, 
    yPos * WINDOW_SCALE
  )
  return entity
end

function EntityPrototype:update()
  -- Nothing for now
end

function EntityPrototype:draw()  
  -- Entity Sprite
  local currentSprite = self:getSprite(true)
  love.graphics.draw(currentSprite, 
    self.position.x, self.position.y, 0, 
    WINDOW_SCALE, WINDOW_SCALE
  )
  
  -- Health Bar
  if self.health == nil then
    return
  end
  local healthBarPos = Vector(
    (self:getAnimation()[1]:getPixelWidth() * 0.5 - 30 * 0.5)* WINDOW_SCALE, 
    (self:getAnimation()[1]:getPixelHeight() + 1) * WINDOW_SCALE
  ) + self.position
  local gray = {0.2, 0.2, 0.2, 1}
  local red = {1, 0.2, 0.2, 1}
  love.graphics.setColor(gray)
  love.graphics.rectangle("fill", healthBarPos.x, healthBarPos.y, 
    30 * WINDOW_SCALE, 5 * WINDOW_SCALE
  )
  
  local healthPercent = self.health / self.maxHealth
  love.graphics.setColor(red)
  love.graphics.rectangle("fill", healthBarPos.x, healthBarPos.y, 
    healthPercent * 30 * WINDOW_SCALE, 5 * WINDOW_SCALE
  )
  
  love.graphics.setColor({1, 1, 1, 1})
end

function EntityPrototype:getAnimation()
  return self.spriteTable[self.currentAnimationState]
end

function EntityPrototype:getSprite(isAnimating)
  if isAnimating then
    local increasingNumber = love.timer.getTime() * self.animationSpeed
    local increasingInt = math.floor(increasingNumber)
    local animFrame = increasingInt % #self:getAnimation()
    self.animationFrame = animFrame + 1
  end
  
  return self:getAnimation()[self.animationFrame]
end

function EntityPrototype:changeAnimation(newAnim)
  if self.spriteTable[newAnim] == nil then
    return
  end
  
  self.currentAnimationState = newAnim
  
  -- TODO: eventually go back to idle (after some time)
end