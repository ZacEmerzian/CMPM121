
CollisionManager = {}
function CollisionManager:new()
  CollisionManager.CELL_SIZE = 16
  CollisionManager.CELL_DIMENSIONS = Vector(10, 8)
  
  CollisionManager.cells = {}
  
  require "collisionCell"
  for x = 1, CollisionManager.CELL_DIMENSIONS.x do
    for y = 1, CollisionManager.CELL_DIMENSIONS.y do
      local xPos = x * CollisionManager.CELL_SIZE * SPRITE_SCALE
      local yPos = y * CollisionManager.CELL_SIZE * SPRITE_SCALE
      table.insert(CollisionManager.cells,
        CollisionCell:new(xPos, yPos, x, y)
      )
    end
  end
  
  return CollisionManager
end

function CollisionManager:draw()
  local blue = {0.2, 0.4, 0.7, 0.5}
  local white = {1, 1, 1, 1}
  
  for _, cell in ipairs(self.cells) do
    love.graphics.setColor(blue)
    love.graphics.rectangle("line",
      cell.position.x, cell.position.y,
      self.CELL_SIZE * SPRITE_SCALE, self.CELL_SIZE * SPRITE_SCALE
    )
    love.graphics.setColor(white)
--    love.graphics.print(tostring(cell.position),
--      cell.position.x, cell.position.y, 0.3
--    )
    
  end  
end
