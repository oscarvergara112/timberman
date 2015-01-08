--
-- Author: Jacky Woo
-- Date: 2014-12-24 23:01:37
--
local Role = class("Role", function()
	local sprite = display.newSprite()
	sprite:setNodeEventEnabled(true)
	return sprite
end)

Role.SCALE = 0.7

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
	if dire == GAMECONFIG.RIGHT then
		self:setFlippedX(true)
		self:setPositionX(self._right) 
		self:setSpriteFrame(self._attLeftFrame) -- left flipx
		self:performWithDelay(function()
			self:setSpriteFrame(self._waitFrame)
		end, 0.1)
	elseif dire == GAMECONFIG.LEFT then
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

function Role:getDire()
	local x = self:getPositionX()
	if x == self._left then
		return GAMECONFIG.LEFT
	elseif x == self._right then
		return GAMECONFIG.RIGHT 
	else
		printError("Role get direction error!")
	end
end

return Role