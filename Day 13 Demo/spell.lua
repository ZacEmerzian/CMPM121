
ELEMENTS = {
  EARTH = 1,
  FIRE = 2,
  WATER = 3,
  WIND = 4
}

SpellPrototype = {}

function SpellPrototype:new(dispName, descrip, pow, elem, cost)
  local spell = {}
  local metadata = {__index = SpellPrototype}
  setmetatable(textBox, metadata)
   
  spell.displayName = dispName
  spell.description = descrip
  spell.power = pow
  spell.element = elem
  spell.cost = cost
  
  return spell
end

-- SPELL DEFINITIONS --
-- TODO
