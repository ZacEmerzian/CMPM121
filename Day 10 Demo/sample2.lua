
-- Original Code Sample #2

function CardPile:update()
  
  -- Ensure the top card is face up
  if self.drawStack then
    return false
  end
  
  if #self.cardTable == 0 then
    return false
  end
  
  if self.cardTable[#self.cardTable].faceUp then
    return false
  end
  
  self.cardTable[#self.cardTable].faceUp = true
  
  -- Original code
--  if not self.drawStack and #self.cardTable ~= 0 and self.cardTable[#self.cardTable].faceUp == false then
--    self.cardTable[#self.cardTable].faceUp = true
--  end
end