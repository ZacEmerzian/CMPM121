
-- Original Code Sample #1
-- X declaring constants every frame
-- X table list formatting
-- X we don't need to set the font every frame
-- X if else 
-- X reference font after loading it
-- X local variables for the colors

values = {'A','2','3','4','5','6','7','8','9','10','J','Q','K',}
suits = {spadeImage, clubImage, heartImage, diamondImage}
cardFont = love.graphics.newFont(30)

SUIT_ENUM = {
  SPADE,
  CLUB, 
  HEART,
  DIAMOND
}

function CardClass:draw()
  local red = {1, 0, 0, 1}
  local black = {0, 0, 0, 1}
  local white = {1, 1, 1, 1}
  
  if self.shown then
    -- White card back
    love.graphics.setColor(white)
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
        
    -- Card Suit
    love.graphics.draw(suits[self.suit], self.position.x+10, self.position.y+50) -- suit icon big
    love.graphics.draw(suits[self.suit], self.position.x+55, self.position.y+8, 0, 0.4, 0.4) -- suit icon small
    
    -- Card Value (eg. A, 4, J, K)
    love.graphics.setColor((self.suit == SUIT_ENUM.SPADE or self.suit == SUIT_ENUM.CLUB) and black or red)
    love.graphics.setFont(cardFont)
    love.graphics.printf(values[self.value], self.position.x, self.position.y+5, 50, "center")
    
  else
    love.graphics.setColor(white)
    love.graphics.draw(backImage, self.position.x, self.position.y)
  end
end