--
-- Author: Jacky Woo
-- Date: 2014-12-30 21:51:51
--
local PlayTab = class("PlayTab", function()
	return display.newNode():setNodeEventEnabled(true)
end)

-- events
PlayTab.TOUCH_EVENT = "TOUCH_EVENT"

PlayTab.RIGHT = 1
PlayTab.LEFT = 2

function PlayTab:ctor()
	cc.GameObject.extend(self)
		:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function PlayTab:onEnter()
	self._left = display.newSprite("#left.png")
				:align(display.CENTER_BOTTOM, display.cx-150, 50)
				:scale(0.7)
				:addTo(self)
	self._left:runAction(cc.RepeatForever:create(transition.sequence({
		cc.MoveBy:create(0.3, cc.p(-40,0)),
		cc.MoveBy:create(0.3, cc.p(40, 0))
		})))

	self._right = display.newSprite("#right.png")
				:align(display.CENTER_BOTTOM, display.cx+150, 50)
				:scale(0.7)
				:addTo(self)
	self._right:runAction(cc.RepeatForever:create(transition.sequence({
		cc.MoveBy:create(0.3, cc.p(40,0)),
		cc.MoveBy:create(0.3, cc.p(-40, 0))
		})))

	self._touchLayer = display.newLayer():addTo(self,-1)
	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		if event.name == "began" then
			if event.x < display.cx then
				self:dispatchEvent({name=PlayTab.TOUCH_EVENT, dire=GAMECONFIG.LEFT})
			else
				self:dispatchEvent({name=PlayTab.TOUCH_EVENT, dire=GAMECONFIG.RIGHT})
			end
		end
		return true
	end)
end

return PlayTab