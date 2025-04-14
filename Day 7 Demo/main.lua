-- Zac Emerzian
-- CMPM 121 - Update
-- 4-7-2025 - 4-14-2025
io.stdout:setvbuf("no")

require "entity"
require "spriteClass"

function love.load()
  love.window.setTitle("Zelda Demo")
  love.graphics.setDefaultFilter("nearest", "nearest")
  screenWidth = 640
  screenHeight = 480
  love.window.setMode(screenWidth, screenHeight)
  love.graphics.setBackgroundColor(0.2, 0.7, 0.2, 1)
  
  linkSpriteClass = LinkSprites:new()
  moblinSpriteClass = MoblinSprites:new()
  octorokSpriteClass = OctorokSprites:new()
  likeLikeSpriteClass = LikeLikeSprites:new()
  gibdoSpriteClass = GibdoSprites:new()
  
  entityTable = {}
  
  table.insert(entityTable,
    EntityClass:new(linkSpriteClass, screenWidth/2, screenHeight/2, 1, 1, 0.5)
  )
  table.insert(entityTable,
    EntityClass:new(moblinSpriteClass, screenWidth/4, screenHeight/4, 1, 1)
  )
  table.insert(entityTable,
    EntityClass:new(gibdoSpriteClass, 0, 0, 1, 1, 2)
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