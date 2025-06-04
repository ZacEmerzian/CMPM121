
PlayerPrototype = EntityPrototype:new()
INPUT_TO_VECTOR = {
  --["w"] = Vector(0, -1),
  ["a"] = Vector(-1, 0),
  --["s"] = Vector(0, 1),
  ["d"] = Vector(1, 0)
}

function PlayerPrototype:new(pos, sprite)  
  self.sprite = sprite  
  self.position = pos
  self.isGround = false
  self.isWall = false
  
  self.facingRight = true
  self.directionalInput = Vector()
    
  return self
end

function PlayerPrototype:update()
  -- COLLECT INPUT
  self:inputCollection()
  
  -- STATE BASED BEHAVIOR
  -- TODO
end

function PlayerPrototype:inputCollection()
  -- Moves with WASD
  self.directionalInput = Vector()
  
  for input, direction in pairs(INPUT_TO_VECTOR) do
    if love.keyboard.isDown(input) then
      self.directionalInput = self.directionalInput + direction
    end
  end
  if self.directionalInput.x ~= 0 then
    self.facingRight = self.directionalInput.x > 0
  end
  
  -- Jumping with Space
  -- TODO
end

function PlayerPrototype:onTheGround()
  local checkPos = self.position + Vector(0, self.sprite.size/2 + 1)
  
  for i, entity in ipairs(entityTable) do
    if entity.isGround then
      --print(i)
      local spriteHalf = entity.sprite.size / 2
      if entity.position.x + spriteHalf >= checkPos.x and 
         entity.position.x - spriteHalf <= checkPos.x and 
         entity.position.y + spriteHalf >= checkPos.y and 
         entity.position.y - spriteHalf <= checkPos.y then
        return true
      end
    end   
  end  
  return false
end