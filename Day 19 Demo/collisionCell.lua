
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