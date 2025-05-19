
NoticeClass = {}

function NoticeClass:new(dn, spr, ind)
  local notice = {}
  local metadata = {
    __index = NoticeClass
  }
  setmetatable(notice, metadata)
  
  --notice.reuse(dn, spr, ind)
  notice.displayName = dn
  notice.sprite = spr
  notice.index = ind
  
  notice.count = 1
  notice.timer = 4
  notice.visible = false
  
  notice.size = Vector(188, 72)
  
  return notice
end

function NoticeClass:update()
  if not self.visible then
    return
  end
  
  if self.timer > 0 then
    self.timer = self.timer - love.timer.getDelta()
  else
    self.visible = false
  end  
end

function NoticeClass:draw()
  if not self.visible then
    return
  end
  
  local pos = Vector(
    love.graphics.getWidth() - self.size.x,
    (love.graphics.getHeight() / 2) + ((self.index - 1) * (self.size.y + 16))
  )
  local noticeBoxColor = {0.1, 0.1, 0.5, 0.8}
  local white = {1, 1, 1, 1}

  -- Notice Box
  love.graphics.setColor(noticeBoxColor)
  love.graphics.rectangle("fill", pos.x, pos.y, self.size.x, self.size.y)
  love.graphics.setColor(white)
  
  -- Item Sprite
  local spriteOffset = Vector(16, 4)
  love.graphics.draw(self.sprite, 
    pos.x + spriteOffset.x, pos.y + spriteOffset.y, 0,
    SPRITE_SCALE, SPRITE_SCALE
  )
  
  -- Item Label
  local textOffset = Vector(64 + 4, 12)
  love.graphics.printf(self.displayName, pos.x + textOffset.x, pos.y + textOffset.y, 128) 
  
  -- Count Bubble
  if self.count < 2 then
    return
  end
  local bubbleOffset = Vector(56, 0)
  local countBubbleColor = {0.8, 0.1, 0.1, 1}  
  love.graphics.setColor(countBubbleColor)
  love.graphics.circle("fill", pos.x + bubbleOffset.x, pos.y + bubbleOffset.y, 16)
  love.graphics.setColor(white)  
  love.graphics.printf(self.count, pos.x + bubbleOffset.x - 4, pos.y + bubbleOffset.y - 12, 128) 
end