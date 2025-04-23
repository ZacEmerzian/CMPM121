
-- Original Code Sample #2

function CardPile:update()
  if not self.drawStack and #self.cardTable ~= 0 and self.cardTable[#self.cardTable].faceUp == false then
    self.cardTable[#self.cardTable].faceUp = true
  end
end