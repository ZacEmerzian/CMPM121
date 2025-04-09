
require "vector"

BubbleClass = {}

directionEnum = {
  none = 0,
  up = 1,
  right = 2,
  down = 3,
  left = 4
}
STARTING_SIZE = 30
IMPACT_DECAY = 0.95
GRADUATL_DECAY = -0.02

function BubbleClass:new(xPos, yPos, xVel, yVel, color, container)
  local bubble = {}
  local metadata = {__index = BubbleClass}
  setmetatable(bubble, metadata) -- now instances will refer to EntityClass for info they don't have
    
  bubble.position = Vector(xPos, yPos)
  bubble.velocity = Vector(xVel, yVel)
  bubble.size = STARTING_SIZE
  bubble.color = color
  bubble.containerTable = container
  return bubble
end

function BubbleClass:update()
  -- Move
  self.position = self.position + self.velocity
  self.size = self.size + GRADUATL_DECAY
  
  -- Wall Bounce
  local wallHit = offScreen(self)
  if wallHit > 0 then
    self.size = self.size * IMPACT_DECAY
    
    if wallHit == directionEnum.up or wallHit == directionEnum.down then
      self.velocity = Vector(
        self.velocity.x,
        -self.velocity.y
      )
    end
    if wallHit == directionEnum.left or wallHit == directionEnum.right then
      self.velocity = Vector(
        -self.velocity.x,
        self.velocity.y
      )
    end
  end
  
  -- Disappear
  if self.size <= 0 then
    for i, v in ipairs(self.containerTable) do
      if v == self then
        table.remove(self.containerTable, i)
        break -- Exits the for loop when we find what we were looking for
      end
    end
  end
end

function BubbleClass:draw()
  self.color[4] = self.size / STARTING_SIZE
  love.graphics.setColor(self.color) -- color values [0, 1]
  love.graphics.circle("line", self.position.x, self.position.y, self.size)
end

function offScreen(self)
  if self.position.y < 0 then
    self.position.y = 0
    return directionEnum.up
  elseif self.position.x > love.graphics.getWidth() then
    self.position.x = love.graphics.getWidth()
    return directionEnum.right
  elseif self.position.y > love.graphics.getHeight() then
    self.position.y = love.graphics.getHeight()
    return directionEnum.down
  elseif self.position.x < 0 then
    self.position.x = 0
    return directionEnum.left
  end
  return directionEnum.none
end