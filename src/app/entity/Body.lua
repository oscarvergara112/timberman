--
-- Author: Jacky Woo
-- Date: 2015-01-05 21:34:59
--
local Body = class("Body", function()
	local node = display.newNode()
	node:setNodeEventEnabled(true)
	return node
end)

function Body:ctor()
	self._hasBranch = math.random(1, 3) == 1
	if self._hasBranch then
		self._dire = math.random(1,2) == 1 -- true : right  false : left
	end
end

function Body:onEnter()
	self._body = display.newSprite("#body.jpg")
						:align(display.BOTTOM_CENTER, 0, 0)
						:addTo(self)

	if self._hasBranch then
		local spriteFrame = display.newSpriteFrame("body.jpg")
		local bodyWidth = spriteFrame:getRect().width
		local bodyHeight = spriteFrame:getRect().height

		if self._dire then
			self._branch = display.newSprite("#branch.png")
							:align(display.LEFT_BOTTOM, bodyWidth/2, bodyHeight/2)
							:addTo(self)
		else
			self._branch = display.newSprite("#branch.png")
							:align(display.RIGHT_BOTTOM, -bodyWidth/2, bodyHeight/2)
							:addTo(self)
							:flipX(true)
		end
	end
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

return Body