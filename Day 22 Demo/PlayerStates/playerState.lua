
PlayerState = {}
function PlayerState:new()
  local state = {}
  local metadata = {__index = PlayerState}
  setmetatable(state, metadata)
  state.name = "DUMMY"
  return state
end
function PlayerState:update()
end
function PlayerState:onEnter()
end
function PlayerState:onExit()
end

require "PlayerStates/idleState"
require "PlayerStates/walkingState"
require "PlayerStates/jumpingState"
require "PlayerStates/zenithState"
require "PlayerStates/fallingState"