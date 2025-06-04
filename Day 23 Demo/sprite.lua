
SpritePrototype = {}
function SpritePrototype:new()
  local sprite = {}
  local metadata = {__index = SpritePrototype}
  setmetatable(sprite, metadata)
  
  sprite.image = nil
  sprite.color = {1, 1, 0.8, 1}
  sprite.size = 32
  
  return sprite
end
function SpritePrototype:draw(pos)
  if self.image ~= nil then
    -- TODO: add actual images later
  end
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", pos.x - self.size/2, pos.y - self.size/2, self.size, self.size)
  love.graphics.setColor({1, 1, 1, 1})  
end

PlayerSprite = SpritePrototype:new()
function PlayerSprite:new()
  self.color = {0.9, 0.6, 0.6, 1}
  return self
end
function PlayerSprite:draw(pos)
  if self.image ~= nil then
    -- TODO: add actual images later
  end  
  love.graphics.setColor(self.color)
  love.graphics.circle("fill", pos.x, pos.y, self.size/2)
  love.graphics.setColor({1, 1, 1, 1})  
end