
IdleState = PlayerState:new()
function IdleState:new()
  self.name = "Idle"
  return self
end
function IdleState:update(player)
  -- Move Check
  if player.directionInput ~= Vector() then
    player:setState(player.states.walking)
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