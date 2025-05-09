-- Zac Emerzian
-- Conway's Game of Life - CPMP 121
-- 5-7-2025 - 5-9-2025
io.stdout:setvbuf("no") -- makes print statements immediately
GAME_TITLE = "Conway's Game of Life"

CELL_SIZE = 16
GRID_WIDTH = 64
GRID_HEIGHT = 36

cellGrid = {}
isSimulating = true
simulationSpeed = 4 -- (1,7)

aliveColor = {1, 0.8, 1, 1}
deadColor = {0, 0.3, 0, 1}

stepLengths = {
  1, 0.8, 0.6,
  0.4,
  0.2, 0.1, 0.05
}
stepTimer = 0

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
  if not isSimulating then
    return
  end
  
  if stepTimer < stepLengths[simulationSpeed] then
    stepTimer= stepTimer + love.timer.getDelta()
  else
    simulationStep()
    stepTimer = 0
  end
end

function love.draw()
  for x, col in ipairs(cellGrid) do
    for y, cell in ipairs(col) do
      love.graphics.setColor(cell and aliveColor or deadColor)
      love.graphics.rectangle("fill", (x - 1) * CELL_SIZE, (y - 1) * CELL_SIZE, CELL_SIZE, CELL_SIZE)
    end
  end
end

function love.keypressed(key, scancode, isrepeat)
  -- Perform the Function
  if controls[key] == nil then
    print("No action associated to " .. key .. "!")
    return
  end
  
  controls[key]()
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
  local cellBuffer = {}
  for x, col in ipairs(cellGrid) do
    local cellColumns = {}
    for y, cell in ipairs(col) do
      local neighborsAlive = getNeighborsAlive(x, y)
      local shouldBeAlive = true
      if cell then
        shouldBeAlive = (neighborsAlive == 2 or neighborsAlive == 3)
        --cellGrid[x][y] = (neighborsAlive == 2 or neighborsAlive == 3)
      else
        shouldBeAlive = neighborsAlive == 3
        --cellGrid[x][y] = neighborsAlive == 3
      end
      table.insert(cellColumns, shouldBeAlive)
    end
    table.insert(cellBuffer, cellColumns)
  end
  cellGrid = cellBuffer
end

function playOrPause()
  isSimulating = not isSimulating
end

function increaseSimulationSpeed()
  modifySimulationSpeed(1)
end
function descreaseSimulationSpeed()
  modifySimulationSpeed(-1)
end
function modifySimulationSpeed(delta)
  simulationSpeed = math.min(math.max(simulationSpeed + delta, 1), #stepLengths)
end

function clearBoard()
  for x, col in ipairs(cellGrid) do
    for y, cell in ipairs(col) do
      cellGrid[x][y] = false
    end
  end
end

controls = {
  ["space"] = playOrPause,
  ["return"] = simulationStep,
  ["a"] = descreaseSimulationSpeed,
  ["d"] = increaseSimulationSpeed,
  ["delete"] = clearBoard
}

function love.mousepressed(x, y, button, istouch)
  if button ~= 1 then
    return
  end
  
  toggleCell(math.floor(x / CELL_SIZE) + 1, math.floor(y / CELL_SIZE) + 1)
end

function toggleCell(x, y)
  cellGrid[x][y] = not cellGrid[x][y]
end