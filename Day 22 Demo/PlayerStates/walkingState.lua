
WalkingState = PlayerState:new()
function WalkingState:new()
  self.name = "Walking"
  return self
end
function WalkingState:update(player)
  -- Horizontal Movement
  player.position = player.position + (player.directionalInput * player.GROUND_SPEED * love.timer.getDelta())
  
  -- Move Check
  if player.directionInput == Vector() then
    player:setState(player.states.idle)
  end
  
  -- Grounded Check
  if not player:onTheGround() then
    player:setState(player.states.falling)
  end
  
  -- Jump Check
  if player.jumpPressed then
    player:setState(player.states.jumping)
  end
end