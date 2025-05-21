
require "notice"

NoticeManager = {}

function NoticeManager:new()
  -- TODO: replace images with nil and actually use the observer pattern
  NoticeManager.noticeTable = {
    NoticeClass:new("DUMMY 1", love.graphics.newImage("Sprites/Acorn.png"), 1),
    NoticeClass:new("DUMMY 2", love.graphics.newImage("Sprites/Acorn.png"), 2),
    NoticeClass:new("DUMMY 3", love.graphics.newImage("Sprites/Acorn.png"), 3)
  }
  
  return NoticeManager
end

function NoticeManager:newNotice(displayName, sprite)
  
  local givenIndex = 1
  
  local givenNotice = self.noticeTable[givenIndex]
  givenNotice:show(displayName, sprite, givenIndex)
end