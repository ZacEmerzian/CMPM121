
ZenithState = PlayerState:new()
function ZenithState:new()
  self.name = "Zenith"
  self.STARTING_ZENITH_TIMER = 0.15
  self.zenithTimer = self.STARTING_ZENITH_TIMER
  return self
end
function ZenithState:update(player)
  -- Horizontal Movement  
  player.position = player.position + (player.directionalInput * player.AIR_SPEED * love.timer.getDelta())
  
  self.zenithTimer = self.zenithTimer - love.timer.getDelta()
  
  if self.zenithTimer <= 0  then
    player:setState(player.states.falling)
  end  
end

function ZenithState:onExit()
  self.zenithTimer = self.STARTING_ZENITH_TIMER  
end