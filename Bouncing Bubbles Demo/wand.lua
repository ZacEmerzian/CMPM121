
require "vector"
require "bubble"

WandClass = {}

function WandClass:new(bubbles)
  local wand = {}
  local metadata = {__index = WandClass}
  setmetatable(wand, metadata) 
  
  wand.startPosition = nil
  wand.bubbleTable = bubbles -- so the Wand knows the table it should add bubbles into
  wand.burstPressed = false
  return wand
end

function WandClass:update()
  -- Hold
  if love.mouse.isDown(1) and self.startPosition == nil then
    self.startPosition = Vector(
      love.mouse.getX(),
      love.mouse.getY()
    )
  end
  -- Release
  if not love.mouse.isDown(1) and self.startPosition ~= nil then
    local rp = Vector(
      love.mouse.getX(),
      love.mouse.getY()
    )
    spawnBubble(self, rp)
    self.startPosition = nil
  end
  
  burst(self)
end

function WandClass:draw()
  if self.startPosition == nil then
    return
  end
  
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.line(
    self.startPosition.x, self.startPosition.y,
    love.mouse.getX(), love.mouse.getY()
  )
end

function spawnBubble(self, releasePosition)
  if self.startPosition == releasePosition then
    return
  end
  
  local randColor = {
    math.random(0.5, 1),
    math.random(0.5, 1),
    math.random(0.5, 1),
    1
  }
  local bubbleSpeed = 0.1
  local newBubble = BubbleClass:new(
    self.startPosition.x,
    self.startPosition.y,
    (self.startPosition.x - releasePosition.x) * bubbleSpeed,
    (self.startPosition.y - releasePosition.y) * bubbleSpeed,
    randColor,
    self.bubbleTable
  )
  table.insert(self.bubbleTable, newBubble)
  --print("Bubble Made!")
end

-- A fun extra thing I added! ^-^
function burst(self)
  if love.mouse.isDown(2) and self.startPosition == nil and not self.burstPressed then
    self.startPosition = Vector(
      love.mouse.getX(),
      love.mouse.getY()
    )
    local burstPower = 20
    local burstCount = 12
    for i = 1, burstCount do
      local rp = self.startPosition + Vector(
        math.cos(math.pi * 2 * i / burstCount) * burstPower,
        math.sin(math.pi * 2 * i / burstCount) * burstPower
      )
      rp = rp + Vector(math.random(), math.random()) -- add some slight variance to the bursts
      spawnBubble(self, rp)
    end
    self.burstPressed = true
  end
  if not love.mouse.isDown(2) and self.burstPressed then
    self.burstPressed = false
  end
end