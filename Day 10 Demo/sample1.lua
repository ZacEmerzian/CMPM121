
-- Original Code Sample #1

function CardClass:draw()
  values = {'A','2','3','4','5','6','7','8','9','10','J','Q','K',}
  suits = {spadeImage, clubImage, heartImage, diamondImage}
  
  if self.shown then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
  
    love.graphics.setColor(1,0,0,1)
    if self.suit<3 then love.graphics.setColor(0,0,0,1) end
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.printf(values[self.value], self.position.x, self.position.y+5, 50, "center")
    
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(suits[self.suit], self.position.x+10, self.position.y+50)
    love.graphics.draw(suits[self.suit], self.position.x+55, self.position.y+8, 0, 0.4, 0.4)
    
  end
  
  if not self.shown then
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(backImage, self.position.x, self.position.y)
  end
end