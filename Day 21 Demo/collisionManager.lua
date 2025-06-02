
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
  print(tostring(gridPos))
  self.cells[gridPos.x][gridPos.y]:addToContents(object)
end

function CollisionManager:draw()
  for x = 1, self.CELL_DIMENSIONS.x do
    for y = 1, self.CELL_DIMENSIONS.y do
      self.cells[x][y]:draw()
    end
  end  
end
