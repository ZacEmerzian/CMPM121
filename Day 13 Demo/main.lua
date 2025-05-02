-- Zac Emerzian
-- RPG Demo - CPMP 121
-- 5-2-2025
io.stdout:setvbuf("no") -- makes print statements immediately

GAME_TITLE = "RPG Demo"
WINDOW_SCALE = 4

entityTable = {}
allyTable = {}

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  
  love.window.setTitle(GAME_TITLE)
  love.window.setMode(240 * WINDOW_SCALE, 160 * WINDOW_SCALE) -- 240x160 is the GBA's screen size
  
  font = love.graphics.newFont("Assets/GoldenSunFont.ttf", 24)
  love.graphics.setFont(font)
  
  backgroundSprite = love.graphics.newImage("Assets/Sprites/Ankohl_Ruins.png")
  
  require "entity"
  -- Isaac
  isaacSprites = {
    [ANIMATION_STATES.IDLE] = {
      love.graphics.newImage("Assets/Sprites/Isaac/IsaacIdle1.png"),
      love.graphics.newImage("Assets/Sprites/Isaac/IsaacIdle2.png"),
      love.graphics.newImage("Assets/Sprites/Isaac/IsaacIdle3.png"),
      love.graphics.newImage("Assets/Sprites/Isaac/IsaacIdle2.png"),
    },
    [ANIMATION_STATES.SPELL] = {
      love.graphics.newImage("Assets/Sprites/Isaac/IsaacSpell1.png"),
      love.graphics.newImage("Assets/Sprites/Isaac/IsaacSpell2.png")
    },
  }
  isaacEntity = EntityPrototype:new("Isaac", 16, 65, isaacSprites, 100)
  table.insert(entityTable, isaacEntity)
  table.insert(allyTable, isaacEntity)
  -- Garet
  garetSprites = {
    [ANIMATION_STATES.IDLE] = {
      love.graphics.newImage("Assets/Sprites/Garet/GaretIdle1.png"),
      love.graphics.newImage("Assets/Sprites/Garet/GaretIdle2.png"),
      love.graphics.newImage("Assets/Sprites/Garet/GaretIdle3.png"),
      love.graphics.newImage("Assets/Sprites/Garet/GaretIdle2.png"),
    },
    [ANIMATION_STATES.SPELL] = {
      love.graphics.newImage("Assets/Sprites/Garet/GaretSpell1.png"),
      love.graphics.newImage("Assets/Sprites/Garet/GaretSpell2.png")
    },
  }
  garetEntity = EntityPrototype:new("Garet", 48, 67, garetSprites, 120)
  table.insert(entityTable, garetEntity)
  table.insert(allyTable, garetEntity)
  -- Mushroom Enemies
  mushroomSprites = {
    [ANIMATION_STATES.IDLE] = {
      love.graphics.newImage("Assets/Sprites/Mushroom/MushroomIdle1.png"),
      love.graphics.newImage("Assets/Sprites/Mushroom/MushroomIdle2.png"),
      love.graphics.newImage("Assets/Sprites/Mushroom/MushroomIdle3.png"),
      love.graphics.newImage("Assets/Sprites/Mushroom/MushroomIdle2.png"),
    },
    [ANIMATION_STATES.HIT] = {
      love.graphics.newImage("Assets/Sprites/Mushroom/MushroomHit.png")
    },
  }
  local startPos = Vector(106, 82)
  for i = 1, 5 do
    local posOffset = Vector(22 * (i - 1), 2 * (i - 1))
    local endPos = startPos + posOffset
    local mushroom = EntityPrototype:new("Mushroom", endPos.x, endPos.y, mushroomSprites, 30)
    table.insert(entityTable, mushroom)
  end
  -- Menu Cursor
  cursorSprites = {
    [ANIMATION_STATES.IDLE] = {
      love.graphics.newImage("Assets/Sprites/Cursor/Cursor1.png"),
      love.graphics.newImage("Assets/Sprites/Cursor/Cursor2.png"),
      love.graphics.newImage("Assets/Sprites/Cursor/Cursor3.png"),
      love.graphics.newImage("Assets/Sprites/Cursor/Cursor4.png"),
      love.graphics.newImage("Assets/Sprites/Cursor/Cursor5.png"),
      love.graphics.newImage("Assets/Sprites/Cursor/Cursor6.png"),
      love.graphics.newImage("Assets/Sprites/Cursor/Cursor7.png")
    }
  }
  cursorEntity = EntityPrototype:new("Cursor", 0, 0, cursorSprites)
  table.insert(entityTable, cursorEntity)  
  
  require "textBox"
  local spellList = {
    {
      ["displayName"] = "Spell 1",
      ["effect"] = 1,
      ["description"] = "?\nIDK"
    },
    {
      ["displayName"] = "Spell 2",
      ["effect"] = 2,
      ["description"] = "??"
    },
    {
      ["displayName"] = "Spell 3",
      ["effect"] = 3,
      ["description"] = "???"
    },
    {
      ["displayName"] = "Spell 4",
      ["effect"] = 4,
      ["description"] = "????"
    },
    {
      ["displayName"] = "Spell 5",
      ["effect"] = 5,
      ["description"] = "?????\nWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
    },
  }
  spellTextBox = TextBoxPrototype:new(13, 2, spellList, cursorEntity)
  
end


function love.update()
  for _, entity in ipairs(entityTable) do
    entity:update()
  end
  
  spellTextBox:update()
  
end

function love.draw()
  
  love.graphics.draw(backgroundSprite, 0, 14 * WINDOW_SCALE, 0, WINDOW_SCALE, WINDOW_SCALE)
  
  spellTextBox:draw()
  
  for _, entity in ipairs(entityTable) do
    entity:draw()
  end
  
end