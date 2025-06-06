
JumpingState = PlayerState:new()
function JumpingState:new()
  self.name = "Jumping"
  self.JUMP_DECAY = 700
  self.STARTING_JUMP_FORCE = 380
  self.jumpForce = self.STARTING_JUMP_FORCE * Vector(0, 1)
  return self
end
function JumpingState:update(player)
  -- Horizontal Movement
  player.position = player.position + (player.directionalInput * player.AIR_SPEED * love.timer.getDelta())
  
  -- Vertical Movement
  player.position = player.position - (self.jumpForce * love.timer.getDelta())
  self.jumpForce.y = self.jumpForce.y - (self.JUMP_DECAY * love.timer.getDelta())
  
  -- Transition to Zenith
  if self.jumpForce.y <= 0 then
    player:setState(player.states.zenith)
  end
  
  -- Jump Release Check
  if not player.jumpHeld then
    player:setState(player.states.falling)
  end
  
end

function JumpingState:onExit()
  self.jumpForce = self.STARTING_JUMP_FORCE * Vector(0, 1)
end