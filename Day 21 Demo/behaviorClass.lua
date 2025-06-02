
BehaviorClass = {}

function BehaviorClass:new(o)
  local behavior = {}
  local metadata = {__index = BehaviorClass}
  setmetatable(behavior, metadata)
  
  behavior.owner = o
  behavior.observers = {}
  
  return behavior  
end
function BehaviorClass:update()
end
function BehaviorClass:simpleMove(directionVector)
  self.owner.position = self.owner.position + (directionVector * self.owner.dataClass.moveSpeed * 0.5)
  
  if directionVector.y ~= 0 then
    self.owner.facingDirection = directionVector.y > 0 and DIRECTIONS.DOWN or DIRECTIONS.UP
  elseif directionVector.x ~= 0 then
    self.owner.facingDirection = directionVector.x > 0 and DIRECTIONS.RIGHT or DIRECTIONS.LEFT
  end
  
  -- Check if we've moved to a new collision cell
  local newGridPos = Vector(
    math.floor(self.owner.position.x / (collisionManager.CELL_SIZE * SPRITE_SCALE)) + 1,
    math.floor(self.owner.position.y / (collisionManager.CELL_SIZE * SPRITE_SCALE)) + 1
  )
  local newCell = collisionManager.cells[newGridPos.x][newGridPos.y]
  if newCell ~= self.owner.collisionCell then
    collisionManager:addToCell(self.owner, newGridPos)
  end
end

function BehaviorClass:addObserver(newObserver)
  -- Redudancy Check
  local alreadyAdded = false
  for _, observer in ipairs(self.observers) do
    if observer == newObserver then
      alreadyAdded = true
      break
    end
  end
  if alreadyAdded then
    return
  end
  
  table.insert(self.observers, newObserver)
end
function BehaviorClass:removeObserver(observerToRemove)
  -- Find Observer Index
  local observerIndex = 0
  for i, observer in ipairs(self.observers) do
    if observer == observerToRemove then
      observerIndex = i
      break
    end
  end
  if observerIndex < 1 then
    return
  end
  
  table.remove(self.observer, observerIndex)
end

function BehaviorClass:notifyObservers(event, eventData)
  for i, observer in ipairs(self.observers) do
    if observer.onNotify ~= nil then
      observer:onNotify(event, eventData)
    end
  end
end

-- PLAYER INPUT --
PlayerInputClass = BehaviorClass:new()
function PlayerInputClass:new(o)
  local playerInput = {}
  local metadata = {__index = PlayerInputClass}
  setmetatable(playerInput, metadata)
  
  playerInput.owner = o
  
  return playerInput  
end
function PlayerInputClass:update()
  local moveDirection = Vector(0, 0)
  
  for input, direction in pairs(inputVector) do
    if love.keyboard.isDown(input) then
      moveDirection = moveDirection + direction
    end
  end  
  self.owner.walking = moveDirection ~= Vector(0, 0)
  
  -- Actually Move
  if self.owner.walking then
    self:simpleMove(moveDirection)
  end
end

-- CARDINAL WANDER --
CardinalWanderClass = BehaviorClass:new()
function CardinalWanderClass:new(o)
  local cardinalWander = {}
  local metadata = {__index = CardinalWanderClass}
  setmetatable(cardinalWander, metadata)
  
  cardinalWander.owner = o
  cardinalWander.movingDirection = Vector()
  cardinalWander.timer = 0
  
  return cardinalWander
end
function CardinalWanderClass:update()
  if self.timer > 0 then
    self.timer = self.timer - love.timer.getDelta()
  else -- Time up
    if not self.owner.walking then
      -- Start walking
      self.movingDirection = directionToVector[math.random(#directionToVector)]
      self.timer = math.random() * 3
      self.owner.walking = true
    else
      -- Stop walking
      self.movingDirection = Vector()
      self.timer = math.random() * 2
      self.owner.walking = false
    end
  end
  
  -- Actually Move
  if self.owner.walking then
    self:simpleMove(self.movingDirection)
  end
end

-- ERRATIC WANDER --
ErraticWanderClass = BehaviorClass:new()
function ErraticWanderClass:new(o)
  local erraticWander = {}
  local metadata = {__index = ErraticWanderClass}
  setmetatable(erraticWander, metadata)
  
  erraticWander.owner = o
  erraticWander.movingDirection = Vector()
  erraticWander.timer = 0
  
  return erraticWander
end
function ErraticWanderClass:update()
  if self.timer > 0 then
    self.timer = self.timer - love.timer.getDelta()
  else -- Time up
    if not self.owner.walking then
      -- Start walking
      self.movingDirection = Vector(
        -1,--math.random() * 2 - 1,
        -1--math.random() * 2 - 1
      )
      --print("Before: " .. tostring(Vector:magnitude(self.movingDirection)))
      self.movingDirection = Vector:normalize(self.movingDirection)
      --print("After " .. tostring(Vector:magnitude(self.movingDirection)))
      self.timer = math.random() * 3
      self.owner.walking = true
    else
      -- Stop walking
      self.movingDirection = Vector()
      self.timer = math.random() * 2
      self.owner.walking = false
    end
  end
  
  -- Actually Move
  if self.owner.walking then
    self:simpleMove(self.movingDirection)
  end
end

-- PURSUE --
PursueClass = BehaviorClass:new()
function PursueClass:new(o, to)
  local pursue = {}
  local metadata = {__index = PursueClass}
  setmetatable(pursue, metadata)
  
  pursue.owner = o
  pursue.targetObj = to or pursue.owner.dataClass.behavior.targetObj
  
  return pursue
end
function PursueClass:update()
  -- Moves towards the target
  if self.targetObj == nil then
    self.owner.walking = false
    return
  end
  local moveDirection = self.targetObj.position - self.owner.position
  moveDirection = Vector:normalize(moveDirection)
  
  self.owner.walking = moveDirection ~= Vector()
  
  -- Actually Move
  if self.owner.walking then
    self:simpleMove(moveDirection)
  end
end

-- PICKUP CLASS --
PickupClass = BehaviorClass:new()
function PickupClass:new(o, to)
  local pickup = {}
  local metadata = {__index = PickupClass}
  setmetatable(pickup, metadata)
  
  pickup.owner = o
  pickup.targetObj = to or pickup.owner.dataClass.behavior.targetObj
  pickup:addObserver(noticeManager)
  
  return pickup
end

function PickupClass:update()
  -- Is picked up when the target object is close enough
  if self.targetObj == nil then
    return
  end
  
  local threshold = 32
  local distance = Vector:distance(self.targetObj.position, self.owner.position)
  if distance < threshold then
    self:notifyObservers(EVENT_TYPE.ITEM_PICKUP, self.owner)
    self.owner.collisionCell:removeFromContents(self.owner)
    
    for i, entity in ipairs(entityTable) do
      if entity == self.owner then
        table.remove(entityTable, i)
      end
    end
  end
end