-- Zac Emerzian
-- CMPM 121 - Bubble Demo
-- 4-2-2025
io.stdout:setvbuf("no")

require "bubble"
require "wand"

function love.load()
  love.window.setMode(960, 640)
  love.graphics.setBackgroundColor(0, 0, 0.2, 1)
  
  bubbleTable = {}
  wand = WandClass:new(bubbleTable)
  
  love.graphics.setLineWidth(4)
end

function love.update()
  wand:update()
  for _, bubble in ipairs(bubbleTable) do
    bubble:update()
  end
end

function love.draw()
  wand:draw()
  for _, bubble in ipairs(bubbleTable) do
    bubble:draw()
  end  
  
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print("Bubbles: " .. #bubbleTable, 10, 10, 0, 2, 2)
end