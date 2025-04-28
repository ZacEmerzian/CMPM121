-- Zac Emerzian
-- CMPM 121 - Zelda Demo
-- 4-7-2025 - 4-28-2025
io.stdout:setvbuf("no")

function love.load()
  love.window.setTitle("Zelda Demo")
  love.graphics.setDefaultFilter("nearest", "nearest")
  screenWidth = 640
  screenHeight = 480
  love.window.setMode(screenWidth, screenHeight)
  love.graphics.setBackgroundColor(0.2, 0.7, 0.2, 1)
  
  require "entity"
  require "entityData"
  require "spriteClass" -- require will call the functions in the given file, so the Gibdo sprite WAS being loaded in BEFORE we were setting the default filter in load(), by moving the requires into load(), we can setup the project before getting the other scripts involved
  require "behaviorClass"
  
  linkSpriteClass = LinkSprites:new()
  moblinSpriteClass = MoblinSprites:new()
  octorokSpriteClass = OctorokSprites:new()
  likeLikeSpriteClass = LikeLikeSprites:new()
  gibdoSpriteClass = GibdoSprites:new()
  keeseSpriteClass = KeeseSprites:new()
  
  entityTable = {}
  
  local linkData = EntityDataClass:new("Link", 12, 5, false, PlayerInputClass:new())
  local moblinData = EntityDataClass:new("Moblin", 4, 4, false, CardinalWanderClass:new())
  local octorokData = EntityDataClass:new("Octorok", 3, 2, false, CardinalWanderClass:new())
  local likeLikeData = EntityDataClass:new("Like Like", 2, 1, false, CardinalWanderClass:new())
  local gibdoData = EntityDataClass:new("Gibdo", 5, 3, false, CardinalWanderClass:new())
  local keeseData = EntityDataClass:new("Keese", 1, 6, true, CardinalWanderClass:new())
  
  local entityDataTable = {
    linkData,
    moblinData,
    octorokData,
    likeLikeData,
    gibdoData,
    keeseData
  }
  
  local spriteClassTable = {
    linkSpriteClass,
    moblinSpriteClass,
    octorokSpriteClass,
    likeLikeSpriteClass,
    gibdoSpriteClass,
    keeseSpriteClass
  }
  
  -- Parade of Entities!
  math.randomseed(os.time()) -- to make sure the numbers are actually random
  for x = 1, 10 do
    for y = 1, 10 do
      local xPos = x * 16 * 4
      local yPos = y * 16 * 4
      local randIndex = math.random(#entityDataTable)
      local chosenData = entityDataTable[randIndex]
      local chosenSpriteClass = spriteClassTable[randIndex]      
      table.insert(entityTable,
        chosenData:newEntity(chosenSpriteClass, xPos, yPos)
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