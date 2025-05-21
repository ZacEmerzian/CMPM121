
EntityDataClass = {}
function EntityDataClass:new(dn, h, ms, iw, b)
  local entityData = {}
  local metadata = {
    __index = EntityDataClass,
    __tostring = function(a)
      return a.displayName or "MISSING NAME"
    end
  }
  setmetatable(entityData, metadata)
  
  entityData.displayName = dn
  entityData.health = h
  entityData.moveSpeed = ms
  entityData.ignoreWalls = iw
  entityData.damagable = entityData.health ~= 0
  entityData.behavior = b
  
  return entityData
end

function EntityDataClass:newEntity(sc, xp, yp)
  return EntityClass:new(self, sc, xp, yp, 1, 1, 1)
end