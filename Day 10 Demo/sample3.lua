
-- Original Code Sample #3
-- in the draw loop for a card, with the heading

-- set it to red or black
if self.suit == "Hearts" or self.suit == "Diamonds" then
  love.graphics.setColor(1, 0, 0)
else
  love.graphics.setColor(0, 0, 0)
end