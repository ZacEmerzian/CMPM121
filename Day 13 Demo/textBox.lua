
TextBoxPrototype = {}

function TextBoxPrototype:new(xPos, yPos, elements, cursor)
  local textBox = {}
  local metadata = {__index = TextBoxPrototype}
  setmetatable(textBox, metadata)
    
  textBox.position = Vector(
    xPos * WINDOW_SCALE, 
    yPos * WINDOW_SCALE
  )
  
  textBox.cursorIndex = 0
  textBox.cursorObj = cursor
  textBox:setCursorPosition()
  textBox.elements = elements
  
  textBox.size = Vector(80, 60)
  
  textBox.cursorCounter = 0
  textBox.cursorMax = 0.35
  textBox.cursorReset = 0.3
  textBox.spellSelected = false
  
  return textBox
end

function TextBoxPrototype:update()
  local moveValue = 0
  
  if love.keyboard.isDown("w") or love.keyboard.isDown("s") then
    if self.cursorCounter == 0 then
      -- First press
      moveValue = updateMoveValue()
    elseif self.cursorCounter > self.cursorMax then
      -- While held down
      moveValue = updateMoveValue()
      self.cursorCounter = self.cursorReset
    end
    self.cursorCounter = self.cursorCounter + love.timer.getDelta()
  elseif self.cursorCounter ~= 0 then
    -- Release
    self.cursorCounter = 0
  end
  
  function updateMoveValue()
    local mv = 0
    if love.keyboard.isDown("w") then
      mv = mv - 1
    end
    if love.keyboard.isDown("s") then
      mv = mv + 1
    end
    return mv
  end
    
  -- Update Cursor Index
  if moveValue ~= 0 then
    self.cursorIndex = (self.cursorIndex + moveValue) % #self.elements
    --print(self.cursorIndex)
    self:setCursorPosition()
  end
  
  -- Select Spell
  if love.keyboard.isDown("space") then
    if not self.spellSelected then
      local givenSpell = self.elements[self.cursorIndex + 1]
      local caster = allyTable[math.random(#allyTable)]
      print(caster.displayName .. " casts " .. tostring(givenSpell.displayName) .. "!")
      caster:changeAnimation(ANIMATION_STATES.SPELL)
      -- TODO: actually cast the spell
      self.spellSelected = true
    end
  else
    self.spellSelected = false
  end
  
end

function TextBoxPrototype:draw()  
  local white = {1, 1, 1, 1}
  local gray = {0.1, 0.1, 0.3, 0.9}
    
  love.graphics.setColor(gray)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x * WINDOW_SCALE, self.size.y * WINDOW_SCALE)
  love.graphics.setColor(white)
  love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x * WINDOW_SCALE, self.size.y * WINDOW_SCALE)
  
  for i = 1, #self.elements do
    local offset = Vector(
      6 * WINDOW_SCALE,
      WINDOW_SCALE + (i - 1) * 10 * WINDOW_SCALE
    )
    love.graphics.print(self.elements[i].displayName, 
      self.position.x + offset.x, self.position.y + offset.y
    )
  end
  
  -- Bottom Text Box
  love.graphics.printf(self.elements[self.cursorIndex + 1].description, 
    WINDOW_SCALE, love.graphics.getHeight() - 24 * WINDOW_SCALE,
    love.graphics.getWidth()
  )
  
end

function TextBoxPrototype:setCursorPosition()
  local newOffset = Vector(
    -12 * WINDOW_SCALE,
    (self.cursorIndex) * 10 * WINDOW_SCALE
  )
  
  local newPosition = self.position + newOffset
  self.cursorObj.position = newPosition
end