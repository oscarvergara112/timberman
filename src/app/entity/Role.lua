--
-- Author: Jacky Woo
-- Date: 2014-12-24 23:01:37
--
local Role = class("Role", function()
	local sprite = display.newSprite()
	sprite:setNodeEventEnabled(true)
	return sprite
end)

Role.SCALE = 0.85

function Role:ctor(left, right, y)
	self._left = left
	self._right = right
	self:pos(self._left, y):scale(Role.SCALE)
end

function Role:onEnter()
	self:setAnchorPoint(cc.p(.5, .2))
	self._waitFrame = display.newSpriteFrame("role.png")
	self._attLeftFrame = display.newSpriteFrame("att_left.png")
	self._attRightFrame = display.newSpriteFrame("att_right.png")

	self:setSpriteFrame(self._waitFrame)
end

function Role:onExit()
	-- body
end

return Role