-- Zac Emerzian
-- CMPM 121 - Day 3 Demo
-- 4-4-2025
io.stdout:setvbuf("no") -- prints statements in real time

require "testClass"

testObjects = {}

GAME_TITLE = "Day 3 Demo" -- NEW CODE

function love.load()
  
  -- NEW CODE --
  love.window.setTitle(GAME_TITLE)
  screenWidth = 640
  screenHeight = 480
  love.window.setMode(screenWidth, screenHeight)
  love.graphics.setBackgroundColor(0.2, 0.7, 0.2, 1) -- this green background looks familiar...
  -- END NEW CODE --
  
  
  print("YO")
  local indexedTable = {
    [1] = "A",
    [2] = "B",
    [3] = "C"
  }
  
  for k,v in ipairs(indexedTable) do
    print(tostring(k) .. " - " .. tostring(v))
  end
  
  local noIndexTable = {
    "A", "B", "C", "D"
  }
  for k,v in ipairs(noIndexTable) do
    print(tostring(k) .. " - " .. tostring(v))
  end
  
  print(" - Mess Table - ")
  local xyTable = {x, y}
  local messTable = {
    [1] = "A",
    ["cheese"] = "B",
    [false] = "C",
    [4.5] = "D",
    [xyTable] = "E",
    ["F"] = nil, -- this one will be pruned from the table, since it's nil
    -- [nil] = "G" -- Uncomment this to have it crash
  }
  for k,v in pairs(messTable) do
    print(tostring(k) .. " - " .. tostring(v))
  end
  
end

function love.update()
  -- Add Circles (that's our object)
  if love.keyboard.isDown("w", "a", "s", "d") then
    local randX = love.math.random() * screenWidth
    local randY = love.math.random() * screenHeight
    local testObj = TestClass:new(randX, randY, 0) -- x:func() == x.func(self)
    table.insert(testObjects, testObj)
  end
  
  -- Clear All Circles
  if love.keyboard.isDown("r") then
    testObjects = {} -- this overwrites our table with an empty one, so garbage collection will clean up all the circles since they are no longer used
  end
end

function love.draw()
  for _, obj in ipairs(testObjects) do
    obj:draw()
  end
end