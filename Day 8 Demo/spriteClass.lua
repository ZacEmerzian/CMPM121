
SpriteClass = {}

function SpriteClass:new()
  local sprite = {}
  local metadata = {__index = SpriteClass}
  setmetatable(sprite, metadata)
  
  sprite.sprites = {
    love.graphics.newImage("Sprites/Gibdo.png")
  }
  local onlyAnim = {
    {sprite = sprite.sprites[1], flipX = false},
    {sprite = sprite.sprites[1], flipX = true}
  }
  self.directionSprites = {
    [DIRECTIONS.UP] = onlyAnim,
    [DIRECTIONS.DOWN] = onlyAnim,
    [DIRECTIONS.LEFT] = onlyAnim,
    [DIRECTIONS.RIGHT] = onlyAnim
  }
  sprite.animSpeed = 5
  sprite.animFrame = 1
  
  return sprite
end

function SpriteClass:getSprite(dir, isAnimating)
  if isAnimating then
    local increasingNumber = love.timer.getTime() * self.animSpeed
    local increasingInt = math.floor(increasingNumber)
    local frame = increasingInt % #self.directionSprites[dir]
    self.animFrame = frame + 1
  end
  
  local animFrame = self.directionSprites[dir][self.animFrame]
  return animFrame["sprite"], animFrame["flipX"] and -1 or 1
end

LinkSprites = SpriteClass:new()
function LinkSprites:new()
  self.sprites = {
    love.graphics.newImage("Sprites/LinkUp.png"),
    love.graphics.newImage("Sprites/LinkDown.png"),
    love.graphics.newImage("Sprites/LinkSide1.png"),
    love.graphics.newImage("Sprites/LinkSide2.png")    
  }
  self.directionSprites = {
    [DIRECTIONS.UP] = {
      {sprite = self.sprites[1], flipX = false},
      {sprite = self.sprites[1], flipX = true}
    },
    [DIRECTIONS.DOWN] = {
      {sprite = self.sprites[2], flipX = false},
      {sprite = self.sprites[2], flipX = true}
    },
    [DIRECTIONS.LEFT] = {      
      {sprite = self.sprites[3], flipX = false},
      {sprite = self.sprites[4], flipX = false}
    },
    [DIRECTIONS.RIGHT] = {
      {sprite = self.sprites[3], flipX = true},
      {sprite = self.sprites[4], flipX = true}
    }
  }
  return self
end

MoblinSprites = SpriteClass:new()
function MoblinSprites:new()
  self.sprites = {
    love.graphics.newImage("Sprites/MoblinUp.png"),
    love.graphics.newImage("Sprites/MoblinDown.png"),
    love.graphics.newImage("Sprites/MoblinSide1.png"),
    love.graphics.newImage("Sprites/MoblinSide2.png")    
  }
  self.directionSprites = {
    [DIRECTIONS.UP] = {
      {sprite = self.sprites[1], flipX = false},
      {sprite = self.sprites[1], flipX = true}
    },
    [DIRECTIONS.DOWN] = {
      {sprite = self.sprites[2], flipX = false},
      {sprite = self.sprites[2], flipX = true}
    },
    [DIRECTIONS.LEFT] = {      
      {sprite = self.sprites[3], flipX = false},
      {sprite = self.sprites[4], flipX = false}
    },
    [DIRECTIONS.RIGHT] = {
      {sprite = self.sprites[3], flipX = true},
      {sprite = self.sprites[4], flipX = true}
    }
  }
  return self
end

OctorokSprites = SpriteClass:new()
function OctorokSprites:new()
  self.sprites = {
    love.graphics.newImage("Sprites/OctorokDown1.png"),
    love.graphics.newImage("Sprites/OctorokDown2.png"),
    love.graphics.newImage("Sprites/OctorokSide1.png"),
    love.graphics.newImage("Sprites/OctorokSide2.png")    
  }
  self.directionSprites = {
    [DIRECTIONS.UP] = {
      {sprite = self.sprites[1], flipX = false}, -- TODO: add flipY element
      {sprite = self.sprites[2], flipX = false}
    },
    [DIRECTIONS.DOWN] = {
      {sprite = self.sprites[1], flipX = false},
      {sprite = self.sprites[2], flipX = false}
    },
    [DIRECTIONS.LEFT] = {      
      {sprite = self.sprites[3], flipX = false},
      {sprite = self.sprites[4], flipX = false}
    },
    [DIRECTIONS.RIGHT] = {
      {sprite = self.sprites[3], flipX = true},
      {sprite = self.sprites[4], flipX = true}
    }
  }
  return self
end
LikeLikeSprites = SpriteClass:new()
function LikeLikeSprites:new()
  self.sprites = {
    love.graphics.newImage("Sprites/LikeLike1.png"),
    love.graphics.newImage("Sprites/LikeLike2.png")
  }
  local onlyAnim = {
    {sprite = self.sprites[1], flipX = false},
    {sprite = self.sprites[2], flipX = false}
  }
  self.directionSprites = {
    [DIRECTIONS.UP] = onlyAnim,
    [DIRECTIONS.DOWN] = onlyAnim,
    [DIRECTIONS.LEFT] = onlyAnim,
    [DIRECTIONS.RIGHT] = onlyAnim
  }
  return self
end

GibdoSprites = SpriteClass:new()