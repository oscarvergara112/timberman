--
-- Author: Jacky Woo
-- Date: 2015-01-05 21:34:59
--
local Body = class("Body", function()
	local node = display.newNode()
	node:setNodeEventEnabled(true)
	return node
end)

Body.SCALE = 0.65

function Body:ctor()
	self._hasBranch = false
	self._dire = false
end

function Body:onEnter()
	self._body = display.newSprite("#body.jpg")
				:align(display.BOTTOM_CENTER, 0, 0)
				:addTo(self)
				:scale(Body.SCALE)
	local spriteFrame = display.newSpriteFrame("body.jpg")
	self._bodyHeight = spriteFrame:getRect().height * Body.SCALE
	self._bodyWidth = spriteFrame:getRect().width*Body.SCALE
	
end

function Body:onExit()
	-- body
end

function Body:hasBranch(dire)
	if self._hasBranch and dire == self._dire then
		return true
	else
		return false
	end
end

function Body:getBodyHeight()
	return self._bodyHeight
end

function Body:setBranchDire( dire )
	self._dire = dire
	self._hasBranch = true

	if self._dire then
		self._branch = display.newSprite("#branch.png")
						:align(display.LEFT_BOTTOM, self._bodyWidth/2-2, 0)
						:addTo(self)
	else
		self._branch = display.newSprite("#branch.png")
						:align(display.RIGHT_BOTTOM, -self._bodyWidth/2+2, 0)
						:addTo(self)
						:flipX(true)

	end
	self._branch:scale(Body.SCALE)
end

function Body:getBranchAndDire( ... )
	return self._hasBranch, self._dire
end

return Body