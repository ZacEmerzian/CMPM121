-- Zac Emerzian
-- CMPM 121 - Update
-- 4-7-2025 - 4-16-2025
io.stdout:setvbuf("no")

function love.load()
  love.window.setTitle("Zelda Demo")
  love.graphics.setDefaultFilter("nearest", "nearest")
  screenWidth = 640
  screenHeight = 480
  love.window.setMode(screenWidth, screenHeight)
  love.graphics.setBackgroundColor(0.2, 0.7, 0.2, 1)
  
  require "entity"
  require "spriteClass" -- require will call the functions in the given file, so the Gibdo sprite WAS being loaded in BEFORE we were setting the default filter in load(), by moving the requires into load(), we can setup the project before getting the other scripts involved
  
  linkSpriteClass = LinkSprites:new()
  moblinSpriteClass = MoblinSprites:new()
  octorokSpriteClass = OctorokSprites:new()
  likeLikeSpriteClass = LikeLikeSprites:new()
  gibdoSpriteClass = GibdoSprites:new()
  
  entityTable = {}
  
--  table.insert(entityTable,
--    EntityClass:new(linkSpriteClass, screenWidth/2, screenHeight/2, 1, 1, 1)
--  )
--  table.insert(entityTable,
--    EntityClass:new(moblinSpriteClass, screenWidth/4, screenHeight/4, 1, 1)
--  )
--  table.insert(entityTable,
--    EntityClass:new(gibdoSpriteClass, 0, 0, 1, 1, 1)
--  )
--  table.insert(entityTable,
--    EntityClass:new(octorokSpriteClass, 300, 0, 1, 1, 1)
--  )
--  table.insert(entityTable,
--    EntityClass:new(likeLikeSpriteClass, 0, 300, 1, 1, 1)
--  )
  
  local spriteClassTable = {
    linkSpriteClass,
    moblinSpriteClass,
    octorokSpriteClass,
    likeLikeSpriteClass,
    gibdoSpriteClass
  }
  
  -- Parade of Entities!
  math.randomseed(os.time()) -- to make sure the numbers are actually random
  for x = 1, 10 do
    for y = 1, 10 do
      local xPos = x * 16 * 4
      local yPos = y * 16 * 4
      local chosenSpriteClass = spriteClassTable[math.random(#spriteClassTable)]      
      table.insert(entityTable,
        EntityClass:new(chosenSpriteClass, xPos, yPos, 1, 1, 1)
      )
    end
  end
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