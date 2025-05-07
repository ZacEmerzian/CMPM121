-- Zac Emerzian
-- Conway's Game of Life - CPMP 121
-- 5-7-2025
io.stdout:setvbuf("no") -- makes print statements immediately
GAME_TITLE = "Conway's Game of Life"



function love.load()
  --math.randomseed(os.time())
  love.graphics.setDefaultFilter("nearest", "nearest")
  
  love.window.setTitle(GAME_TITLE)
end

function love.update()
  
end

function love.draw()
  
end