
require "notice"

NoticeManager = {}

function NoticeManager:new()
  NoticeManager.noticeTable = {
    NoticeClass:new("DUMMY 1", nil, 1),
    NoticeClass:new("DUMMY 2", nil, 2),
    NoticeClass:new("DUMMY 3", nil, 3)
  }
  
  NoticeManager.eventQueue = {}
    
  return NoticeManager
end

function NoticeManager:update()
  -- Takes the first notification in the queue each frame to process
  if #self.eventQueue < 1 then
    return
  end
  
  local queuedEvent = self.eventQueue[1]
  local queuedNoticeIsNew = true
  for _, notice in ipairs(self.noticeTable) do
    if notice.displayName == queuedEvent.dataClass.displayName and notice.visible then
      queuedNoticeIsNew = false
      notice:addToCount(1)
    end
  end
  
  if queuedNoticeIsNew then
    self:newNotice(queuedEvent.dataClass.displayName, queuedEvent.spriteClass.sprites[1])
  end
  
  table.remove(self.eventQueue, 1)
end

function NoticeManager:onNotify(event, eventData)
  print("ON NOTIFY - " .. tostring(event))
  if event == EVENT_TYPE.ITEM_PICKUP then
    table.insert(self.eventQueue, eventData)
    --self:newNotice(eventData.dataClass.displayName, eventData.spriteClass.sprites[1])
  end
  
end

function NoticeManager:newNotice(displayName, sprite)
  -- Use the first notice in the pool that isn't being used (ie. it's invisible)
  local givenIndex = 1
  for i, notice in ipairs(self.noticeTable) do
    if not notice.visible then
      givenIndex = i
      break
    end
  end  
  
  local givenNotice = self.noticeTable[givenIndex]
  givenNotice:show(displayName, sprite, givenIndex)
end