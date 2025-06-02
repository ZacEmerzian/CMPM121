
CollisionManager = {}
function CollisionManager:new()
  CollisionManager.CELL_SIZE = 16
  CollisionManager.CELL_DIMENSIONS = Vector(10, 8)
  
  CollisionManager.cells = {}
  
  require "collisionCell"
  for x = 1, CollisionManager.CELL_DIMENSIONS.x do
    local cellColumn = {}
    for y = 1, CollisionManager.CELL_DIMENSIONS.y do
      local xPos = (x - 1) * CollisionManager.CELL_SIZE * SPRITE_SCALE
      local yPos = (y - 1) * CollisionManager.CELL_SIZE * SPRITE_SCALE
      table.insert(cellColumn,
        CollisionCell:new(xPos, yPos, x, y)
      )
    end
    table.insert(CollisionManager.cells, cellColumn)
  end
  
  return CollisionManager
end

function CollisionManager:addToCell(object, gridPos)
  --print(tostring(gridPos))
  self.cells[gridPos.x][gridPos.y]:addToContents(object)
end

function CollisionManager:inRange(obj1, obj2, distance)
  local gridPos1 = obj1.collisionCell.gridPosition
  local gridPos2 = obj2.collisionCell.gridPosition
  
  local gridDistance = Vector:distance(gridPos1, gridPos2)
  
  local approxDistance = gridDistance * self.CELL_SIZE
  
  return approxDistance < distance
end

function CollisionManager:isGridPositionInGrid(gridPos)
  return gridPos.x > 0 and gridPos.y > 0 and
    gridPos.x <= self.CELL_DIMENSIONS.x and gridPos.y <= self.CELL_DIMENSIONS.y
end

function CollisionManager:onMoveCollisionGrid()
  -- Update Entity in Range Values
  for _, entity in ipairs(entityTable) do
    if entity.behavior.updateInRange ~= nil then
      entity.behavior:updateInRange()
    end
  end
end

function CollisionManager:draw()
  for x = 1, self.CELL_DIMENSIONS.x do
    for y = 1, self.CELL_DIMENSIONS.y do
      self.cells[x][y]:draw()
    end
  end  
end
