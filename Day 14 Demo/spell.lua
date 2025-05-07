
ELEMENTS = {
  EARTH = 1,
  FIRE = 2,
  WATER = 3,
  WIND = 4
}

elementDisplayName = {
  "Earth",
  "Fire",
  "Water",
  "Wind"
}

radialDamageFalloff = {
  0.8,
  0.6,
  0.4,
  0.2
}

SpellPrototype = {}

function SpellPrototype:new(dispName, descrip, pow, elem, cost, range)
  local spell = {}
  local metadata = {__index = SpellPrototype}
  setmetatable(spell, metadata)
   
  spell.displayName = dispName
  spell.description = descrip
  spell.power = pow
  spell.element = elem
  spell.cost = cost
  spell.range = range or 0
  
  return spell
end
function SpellPrototype:getElementName()
  return elementDisplayName[self.element]
end
function SpellPrototype:getRandomEnemy()
  local randIndex = math.random(#enemyTable)
  return enemyTable[randIndex]
end
function SpellPrototype:getAdjacentEnemies(givenEnemy, range)
  local targets = {}
  
  -- Get Given Enemy Index
  local givenIndex = -1
  for i = 1, #enemyTable do 
    if enemyTable[i] == givenEnemy then
      givenIndex = i
    end
  end
  -- Abort if we can't find the enemy
  if givenIndex < 1 then
    return nil
  end
  
  for i = 1, range do
    local adjacents = {}
    
    local leftIndex = givenIndex - i
    if leftIndex > 0 then
      table.insert(adjacents, enemyTable[leftIndex])
    end
    
    local rightIndex = givenIndex + i
    if rightIndex <= #enemyTable then
      table.insert(adjacents, enemyTable[rightIndex])
    end
    
    table.insert(targets, adjacents)
  end 
  
  return targets
end

function SpellPrototype:damageRandomTarget()
  local target = self:getRandomEnemy()
  local subTargets = self:getAdjacentEnemies(target, self.range)
  
  self:damageEntity(target, self.power)
  
  if subTargets == nil or #subTargets <= 0 then
    return
  end
  
  -- AoE Damage
  for k, v in ipairs(subTargets) do
    local damage = self.power * radialDamageFalloff[k]
    for _, adjacents in ipairs(v) do
      self:damageEntity(adjacents, damage)
    end
  end
  
  return target
end

function SpellPrototype:damageEntity(entity, damage)
  if entity == nil then
    print("No targets remaining for " .. tostring(self.displayName) .. "!")
    return
  end
  
  entity:takeDamage(damage)
end

function SpellPrototype:getRandomAlly()
  local randIndex = math.random(#allyTable)
  return allyTable[randIndex]
end

function SpellPrototype:healEntity(entity, healAmount)
  if entity == nil then
    print("No targets remaining for " .. tostring(self.displayName) .. "!")
    return
  end
  
  entity:restoreHealth(healAmount)
end

-- SPELL DEFINITIONS --
CarpetBombPrototype = SpellPrototype:new(
  "Carpet Bomb",
  "Attack with a bomb blast.",
  130,
  ELEMENTS.FIRE,
  29,
  3
)
function CarpetBombPrototype:new()
  return CarpetBombPrototype
end
function CarpetBombPrototype:cast()
  self:damageRandomTarget()
end

GrowthPrototype = SpellPrototype:new(
  "Growth",
  "Attack with wild plants.",
  25,
  ELEMENTS.EARTH,
  4
)
function GrowthPrototype:new()
  return GrowthPrototype
end
function GrowthPrototype:cast()
  self:damageRandomTarget()
end

FrothSpiralPrototype = SpellPrototype:new(
  "Froth Spiral",
  "Attack with a bubble vortex.",
  150,
  ELEMENTS.WATER,
  31,
  3
)
function FrothSpiralPrototype:new()
  return FrothSpiralPrototype
end
function FrothSpiralPrototype:cast()
  self:damageRandomTarget()
end

CurePrototype = SpellPrototype:new(
  "Cure",
  "Restore 70 HP.",
  70,
  ELEMENTS.EARTH,
  3,
  0
)
function CurePrototype:new()
  return CurePrototype
end
function CurePrototype:cast()
  local target = self:getRandomAlly()
  self:healEntity(target, self.power)
end