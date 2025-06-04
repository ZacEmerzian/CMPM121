-- Zac Emerzian
-- CMPM 121 - Platformer Demo
io.stdout:setvbuf("no") -- makes print statements immediately

GAME_TITLE = "Platformer Demo"

entityTable = {}

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  
  love.window.setTitle(GAME_TITLE)
  love.window.setMode(640, 480)
  love.graphics.setBackgroundColor(0.1, 0.4, 0.3, 1)
  
  require "vector"
  require "entity"
  require "sprite"
  require "player"
  
  spawnLevel()
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
  
  displayFPS()
end

function displayFPS()
  love.graphics.setColor(0, 0, 0, 0.5)
  love.graphics.rectangle("fill", 0, 0, 64, 24)
  love.graphics.setColor(1, 1, 1, 1)
  local delta = love.timer.getAverageDelta()
  local fps = math.floor(1.0 / delta) --love.timer.getFPS() obviously works too
  love.graphics.print(tostring(fps) .. " FPS", 4, 4)
end

function spawnLevel()
  local playerSprite = PlayerSprite:new()
  local playerEntity = PlayerPrototype:new(Vector(64, 64), playerSprite)  
  table.insert(entityTable, playerEntity)
  
  local blockSprite = SpritePrototype:new()
  local blockPositions = {
    Vector(32, 256),
    Vector(64, 256),
    Vector(96, 256),
    Vector(128, 256),
    Vector(160, 288),
    Vector(192, 288),
    Vector(224, 160),
    Vector(256, 128),
    Vector(288, 128)    
  }
  
  for _, pos in ipairs(blockPositions) do
    table.insert(entityTable, 
      EntityPrototype:new(
        pos, 
        blockSprite
      ) 
    )
  end  
end