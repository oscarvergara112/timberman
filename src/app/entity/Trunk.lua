--
-- Author: Jacky Woo
-- Date: 2014-12-23 22:31:42
--
local Trunk = class("Trunk", function()
	local node = display.newNode()
	node:setNodeEventEnabled(true)
	return node
end)

Trunk.SCALE = 0.65
Trunk.NONE_BRANCH = false

function Trunk:ctor(height)
	self._body = {}
	self._branch = {}
	self._treeHeight = height
end

function Trunk:onEnter()
	-- base
	display.newSprite("#base.png")
		:addTo(self)
		:scale(Trunk.SCALE)
		:align(display.TOP_CENTER, 2, 0)

	-- body
	local spriteFrame = display.newSpriteFrame("body.jpg")
	local bodyHeight = spriteFrame:getRect().height * Trunk.SCALE
	local bodyNum = math.ceil(self._treeHeight / (bodyHeight))
	self._branchNum = bodyNum
	printInfo(bodyNum)
	for i = 1, bodyNum do
		self._body[i] = display.newSprite("#body.jpg")
							:align(display.BOTTOM_CENTER, 0, (i-1)*bodyHeight)
							:addTo(self)
							:scale(Trunk.SCALE)
	end

	-- branch
	self._body[1] = Trunk.NONE_BRANCH
	for i = 2, bodyNum do
		local hasBranch = math.random(1,2) == 1
		if hasBranch then
			self._body[i] = {}
		else
			self._body[i] = Trunk.NONE_BRANCH
		end
	end
end

function Trunk:onExit()
	-- body
end

function Trunk:chop(dire)
	-- body
end

return Trunk