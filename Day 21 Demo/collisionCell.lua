
CollisionCell = {}

function CollisionCell:new(x, y, gridX, gridY)
  local cell = {}
  local metadata = {__index = CollisionCell}
  setmetatable(cell, metadata)
  
  cell.position = Vector(x, y)
  cell.gridPosition = Vector(gridX, gridY)
  cell.contents = {}
  
  return cell  
end

function CollisionCell:addToContents(object)
  -- Redundancy Check
  for _, obj in ipairs(self.contents) do
    if obj == object then
      return
    end
  end
  
  if object.collisionCell ~= nil then
    object.collisionCell:removeFromContents(object)
  end
  table.insert(self.contents, object)
  object.collisionCell = self  
end

function CollisionCell:removeFromContents(object)
  local objectIndex = 0
  
  for i, obj in ipairs(self.contents) do
    if obj == object then
      objectIndex = i
      break
    end
  end
  
  if objectIndex < 1 then
    return
  end
  
  table.remove(self.contents, objectIndex)
  object.collisionCell = nil  
end

function CollisionCell:draw()
  local blue = {0.25, 0.5, 1, 0.5}
  local white = {1, 1, 1, 1}
  
  love.graphics.setColor(blue)
    love.graphics.rectangle("line",
      self.position.x, self.position.y,
      collisionManager.CELL_SIZE * SPRITE_SCALE, collisionManager.CELL_SIZE * SPRITE_SCALE
    )
    love.graphics.setColor(white)
--    love.graphics.print(tostring(self.gridPosition),
--      self.position.x, self.position.y, 0.3
--    )
    love.graphics.print(tostring(#self.contents), self.position.x + 20, self.position.y + 20)
end