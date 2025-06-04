
EntityPrototype = {}
function EntityPrototype:new(pos, sprite)
  local entity = {}
  local metadata = {
    __index = EntityPrototype
  }
  setmetatable(entity, metadata)
  
  entity.sprite = sprite  
  entity.position = pos
  entity.isGround = true
  entity.isWall = true
  
  return entity
end

function EntityPrototype:update()
end

function EntityPrototype:draw()
  if self.sprite == nil then
    return
  end
  
  self.sprite:draw(self.position)
end