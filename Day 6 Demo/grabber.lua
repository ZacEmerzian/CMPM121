
require "vector"

GrabberClass = {}

function GrabberClass:new()
  local grabber = {}
  local metadata = {__index = GrabberClass}
  setmetatable(grabber, metadata)
  
  grabber.previousMousePos = nil
  grabber.currentMousePos = nil
  
  grabber.grabPos = nil
  
  -- NEW: we'll want to keep track of the object (ie. card) we're holding
  grabber.heldObject = nil
  
  return grabber
end

function GrabberClass:update()
  self.currentMousePos = Vector(
    love.mouse.getX(),
    love.mouse.getY()
  )
  
  -- Click (just the first frame)
  if love.mouse.isDown(1) and self.grabPos == nil then
    self:grab()
  end
  -- Release
  if not love.mouse.isDown(1) and self.grabPos ~= nil then
    self:release()
  end  
end

function GrabberClass:grab()
  self.grabPos = self.currentMousePos
  print("GRAB - " .. tostring(self.grabPos))
end
function GrabberClass:release()
  print("RELEASE - ")
  -- NEW: some more logic stubs here
  if self.heldObject == nil then -- we have nothing to release
    return
  end
  
  -- TODO: eventually check if release position is invalid and if it is
  -- return the heldObject to the grabPosition
  local isValidReleasePosition = true -- *insert actual check instead of "true"*
  if now isValidReleasePosition then
    self.heldObject.position = self.grabPosition
  end
  
  self.heldObject.state = 0 -- it's no longer grabbed
  
  self.heldObject = nil
  self.grabPos = nil
end