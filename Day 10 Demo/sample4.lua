
-- Original Code Sample #4
-- In love.load()

SUIT_ENUM = {
  SPADE,
  CLUB, 
  HEART,
  DIAMOND
}

cards = {}

local suitPrefix = {"S", "C", "H", "D"}
local ranks = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"}

for suit in SUIT_ENUM do
    for j = 1, #ranks do
        table.insert(cards, love.graphics.newImage("sprites/" .. suitPrefix[suit] .. ranks[j] .. ".png"))
    end
end
