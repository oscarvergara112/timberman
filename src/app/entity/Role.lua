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
Role.DIRE_LEFT = 0
Role.DIRE_RIGHT = 1

function Role:ctor(left, right, y)
	self._left = left
	self._right = right
	self:pos(self._left, y):scale(Role.SCALE)
end

function Role:onEnter()
	self:setAnchorPoint(cc.p(.5, .2))
	self._waitFrame = display.newSpriteFrame("role.png")
	self._attLeftFrame = display.newSpriteFrame("att_left.png")
	self._attRightFrame = display.newSpriteFrame("att_right.png") -- unused

	self:setSpriteFrame(self._waitFrame)
end

function Role:onExit()
	-- body
end

function Role:chop(dire)
	if dire == Role.DIRE_RIGHT then
		self:setFlippedX(true)
		self:setPositionX(self._right) 
		self:setSpriteFrame(self._attLeftFrame) -- left flipx
		self:performWithDelay(function()
			self:setSpriteFrame(self._waitFrame)
		end, 0.1)
	elseif dire == Role.DIRE_LEFT then
		self:setFlippedX(false)
		self:setPositionX(self._left)
		self:setSpriteFrame(self._attLeftFrame)
		self:performWithDelay(function()
			self:setSpriteFrame(self._waitFrame)
		end, 0.1)
	else
		printError("Role chop dire error!")
	end
end

return Role