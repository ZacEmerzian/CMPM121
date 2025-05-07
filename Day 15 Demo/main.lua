-- Zac Emerzian
-- Conway's Game of Life - CPMP 121
-- 5-7-2025
io.stdout:setvbuf("no") -- makes print statements immediately
GAME_TITLE = "Conway's Game of Life"

CELL_SIZE = 16
GRID_WIDTH = 64
GRID_HEIGHT = 36

cellGrid = {}

aliveColor = {1, 0.8, 1, 1}
deadColor = {0, 0.3, 0, 1}


function love.load()
  --math.randomseed(os.time())
  love.graphics.setDefaultFilter("nearest", "nearest")
  
  love.window.setTitle(GAME_TITLE)
  love.window.setMode(CELL_SIZE * GRID_WIDTH, CELL_SIZE * GRID_HEIGHT)
  
  require "vector"
  for i = 1, GRID_WIDTH do
    local cellColumns = {}
    for j = 1, GRID_HEIGHT do
      table.insert(cellColumns, math.random() > 0.65)
    end
    table.insert(cellGrid, cellColumns)
  end  
end

function love.update()
  
  simulationStep()
end

function love.draw()
  for x, col in ipairs(cellGrid) do
    for y, cell in ipairs(col) do
      love.graphics.setColor(cell and aliveColor or deadColor)
      love.graphics.rectangle("fill", (x - 1) * CELL_SIZE, (y - 1) * CELL_SIZE, CELL_SIZE, CELL_SIZE)
    end
  end
end

function simulationStep()
  function getNeighborsAlive(x, y)
    local result = 0
    for w = -1, 1 do
      for h = -1, 1 do
        local targetPos = Vector(x, y) + Vector(w, h)
        targetPos = wrapGridPos(targetPos)
        local targetCell = cellGrid[targetPos.x][targetPos.y]
        if targetCell and Vector(x, y) ~= targetPos then
          result = result + 1
        end
      end
    end
    return result
  end
  function wrapGridPos(gridPos)
    -- Horizontal Wrapping
    if gridPos.x > GRID_WIDTH then
      gridPos.x = 1
    elseif gridPos.x < 1 then
      gridPos.x = GRID_WIDTH
    end
    -- Vertical Wrapping
    if gridPos.y > GRID_HEIGHT then
      gridPos.y = 1
    elseif gridPos.y < 1 then
      gridPos.y = GRID_HEIGHT
    end
    return gridPos
  end
  --[[
  1 4 6
  2 X 7
  3 5 8
  ]]--
  
  for x, col in ipairs(cellGrid) do
    for y, cell in ipairs(col) do
      local neighborsAlive = getNeighborsAlive(x, y)
      if cell then
        cellGrid[x][y] = (neighborsAlive == 2 or neighborsAlive == 3)
      else
        cellGrid[x][y] = neighborsAlive == 3
      end
    end
  end
end

