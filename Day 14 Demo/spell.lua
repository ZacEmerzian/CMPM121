
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

SpellPrototype = {}

function SpellPrototype:new(dispName, descrip, pow, elem, cost)
  local spell = {}
  local metadata = {__index = SpellPrototype}
  setmetatable(spell, metadata)
   
  spell.displayName = dispName
  spell.description = descrip
  spell.power = pow
  spell.element = elem
  spell.cost = cost
  
  return spell
end
function SpellPrototype:getElementName()
  return elementDisplayName[self.element]
end
function SpellPrototype:getRandomEnemy()
  local randIndex = math.random(#enemyTable)
  return enemyTable[randIndex]
end
function SpellPrototype:damageEntity(entity, damage)
  if entity == nil then
    print("No targets remaining for " .. tostring(self.displayName) .. "!")
    return
  end
  
  entity:takeDamage(damage)
end

-- SPELL DEFINITIONS --
CarpetBombPrototype = SpellPrototype:new(
  "Carpet Bomb",
  "Attack with a bomb blast.",
  130,
  ELEMENTS.FIRE,
  29
)
function CarpetBombPrototype:new()
  return CarpetBombPrototype
end
function CarpetBombPrototype:cast()
  local target = self:getRandomEnemy()
  self:damageEntity(target, self.power)
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
  local target = self:getRandomEnemy()
  self:damageEntity(target, self.power)
end