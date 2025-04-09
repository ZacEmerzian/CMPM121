-- Zac Emerzian
-- CMPM 121 - Update
-- 4-7-2025
io.stdout:setvbuf("no")

require "entity"

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  screenWidth = 640
  screenHeight = 480
  love.window.setMode(screenWidth, screenHeight)
  love.graphics.setBackgroundColor(0.2, 0.7, 0.2, 1)
  
  entityTable = {}
  
  table.insert(entityTable,
    EntityClass:new(screenWidth/2, screenHeight/2, 1, 1, 0.5)
  )
  table.insert(entityTable,
    EntityClass:new(screenWidth/4, screenHeight/4, 1, 1)
  )
  table.insert(entityTable,
    EntityClass:new(0, 0, 1, 1, 2)
  )
end

function love.update()
  for _, entity in ipairs(entityTable) do
    entity:update()
  end
end

function love.draw()
  for _, entity in ipairs(entityTable) do
    entity:draw()
  end
end