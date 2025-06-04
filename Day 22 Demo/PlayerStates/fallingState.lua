
FallingState = PlayerState:new()
function FallingState:new()
  self.name = "Falling"
  self.GRAVITY_STRENGTH = 600
  self.STARTING_GRAVITY_FORCE = 90
  self.gravityForce = self.STARTING_GRAVITY_FORCE * Vector(0, 1)
  return self
end
function FallingState:update(player)
  -- Horizontal Movement  
  player.position = player.position + (player.directionalInput * player.AIR_SPEED * love.timer.getDelta())
  
  -- Ground Check
  if player:onTheGround() then
    player:setState(player.states.idle)
    return
  end
  
  -- Vertical Movement
  player.position = player.position + (self.gravityForce * love.timer.getDelta())
  self.gravityForce.y = self.gravityForce.y + (self.GRAVITY_STRENGTH * love.timer.getDelta())  
end

function FallingState:onExit()
  self.gravityForce = self.STARTING_GRAVITY_FORCE * Vector(0, 1)
end