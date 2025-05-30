-- Zac Emerzian
-- CMPM 121 - Zelda Demo
-- 4-7-2025 - 5-30-2025
io.stdout:setvbuf("no")

EVENT_TYPE = {
  ITEM_PICKUP = 1
}

function love.load()
  love.window.setTitle("Zelda Demo")
  love.graphics.setDefaultFilter("nearest", "nearest")
  screenWidth = 640
  screenHeight = 480
  love.window.setMode(screenWidth, screenHeight)
  love.graphics.setBackgroundColor(0.6, 0.2, 0.5, 1) -- Purple
  
  font = love.graphics.newFont("TLOZ-Links-Awakening.ttf", 24)
  --love.graphics.setFont(font)
  
  require "entity"
  require "entityData"
  require "spriteClass"
  require "behaviorClass"
  require "noticeManager"
  noticeManager = NoticeManager:new()
  require "collisionManager"
  collisionManager = CollisionManager:new()
  
  linkSpriteClass = LinkSprites:new()
  moblinSpriteClass = MoblinSprites:new()
  octorokSpriteClass = OctorokSprites:new()
  likeLikeSpriteClass = LikeLikeSprites:new()
  gibdoSpriteClass = GibdoSprites:new()
  keeseSpriteClass = KeeseSprites:new()
  redRupeeSpriteClass = RedRupeeSprites:new()
  blueRupeeSpriteClass = BlueRupeeSprites:new()
  acornSpriteClass = AcornSprites:new()  
  
  entityTable = {}
  
  local linkData = EntityDataClass:new("Link", 12, 5, false, PlayerInputClass:new())
  linkEntity = linkData:newEntity(linkSpriteClass, 32, 32)
  table.insert(entityTable, linkEntity) 
    
  local moblinData = EntityDataClass:new("Moblin", 4, 4, false, CardinalWanderClass:new())
  local octorokData = EntityDataClass:new("Octorok", 3, 2, false, CardinalWanderClass:new())
  local likeLikeData = EntityDataClass:new("Like Like", 2, 1, false, PursueClass:new(nil, linkEntity))
  local gibdoData = EntityDataClass:new("Gibdo", 5, 3, false, CardinalWanderClass:new())
  local keeseData = EntityDataClass:new("Keese", 1, 6, true, ErraticWanderClass:new())
  local redRupeeData = EntityDataClass:new("Red Rupee", 1, 0, true, PickupClass:new(nil, linkEntity))
  local blueRupeeData = EntityDataClass:new("Blue Rupee", 5, 0, true, PickupClass:new(nil, linkEntity))
  local acornData = EntityDataClass:new("Acorn", 1, 0, true, PickupClass:new(nil, linkEntity))
  
  local entityDataTable = {
    --linkData,
--    moblinData,
--    octorokData,
--    likeLikeData,
--    gibdoData,
--    keeseData
    redRupeeData,
    blueRupeeData,
    acornData
  }
  
  local spriteClassTable = {
    --linkSpriteClass,
--    moblinSpriteClass,
--    octorokSpriteClass,
--    likeLikeSpriteClass,
--    gibdoSpriteClass,
--    keeseSpriteClass
    redRupeeSpriteClass,
    blueRupeeSpriteClass,
    acornSpriteClass
  }
  
  -- Parade of Entities!
  math.randomseed(os.time()) -- to make sure the numbers are actually random
  for x = 1, 9 do
    for y = 1, 7 do
      local xPos = (x * SPRITE_SIZE + math.random(2, 14)) * SPRITE_SCALE
      local yPos = (y * SPRITE_SIZE + math.random(2, 14)) * SPRITE_SCALE
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
  
  noticeManager:update()
  
  for _, notice in ipairs(noticeManager.noticeTable) do
    notice:update()
  end
end

function love.draw()
  for _, entity in ipairs(entityTable) do
    entity:draw()
  end
  
  for _, notice in ipairs(noticeManager.noticeTable) do
    notice:draw()
  end
  
  collisionManager:draw()
end