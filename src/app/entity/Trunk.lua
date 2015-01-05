--
-- Author: Jacky Woo
-- Date: 2014-12-23 22:31:42
--
local Body = import(".Body")

local Trunk = class("Trunk", function()
	local node = display.newNode()
	node:setNodeEventEnabled(true)
	return node
end)

Trunk.SCALE = 0.65
Trunk.NONE_BRANCH = false
Trunk.DIRE_LEFT = 0
Trunk.DIRE_RIGHT = 1

function Trunk:ctor(height)
	self._body = {}
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
	self._bodyHeight = bodyHeight
	printInfo(bodyNum)
	for i = 1, bodyNum do
		self._body[i] = Body.new():align(display.CENTER, 0, (i-1)*bodyHeight):addTo(self):scale(Trunk.SCALE)
		-- self._body[i] = display.newSprite("#body.jpg")
		-- 					:align(display.BOTTOM_CENTER, 0, (i-1)*bodyHeight)
		-- 					:addTo(self)
		-- 					:scale(Trunk.SCALE)
	end
end

function Trunk:onExit()
	-- body
end

function Trunk:chop(dire)
	if dire == Trunk.DIRE_LEFT then
		local body = table.remove(self._body, 1)
		self:reorderChild(body, 1)
		body:runAction(cc.RotateBy:create(0.6, 270))
		body:runAction(transition.sequence{
			cca.jumpBy(0.6, display.width, 50, 100, 1),
			cca.removeSelf(),
			})

		-- local top = display.newSprite("#body.jpg")
		-- 				:align(display.BOTTOM_CENTER, 0, self._branchNum*self._bodyHeight)
		-- 				:addTo(self)
		-- 				:scale(Trunk.SCALE)
		local top = Body.new():align(display.CENTER, 0, self._branchNum*self._bodyHeight):addTo(self):scale(Trunk.SCALE)
		table.insert(self._body, top)
	elseif dire == Trunk.DIRE_RIGHT then
		local body = table.remove(self._body, 1)
		self:reorderChild(body, 1)
		body:runAction(cc.RotateBy:create(0.6, -270))
		body:runAction(transition.sequence{
			cca.jumpBy(0.6, -display.width, 50, 100, 1),
			cca.removeSelf(),
			})

		-- local top = display.newSprite("#body.jpg")
		-- 				:align(display.BOTTOM_CENTER, 0, self._branchNum*self._bodyHeight)
		-- 				:addTo(self)
		-- 				:scale(Trunk.SCALE)
		local top = Body.new():align(display.CENTER, 0, self._branchNum*self._bodyHeight):addTo(self):scale(Trunk.SCALE)
		table.insert(self._body, top)
	end
	if self._body[1]:getNumberOfRunningActions() == 0 then
		for _, body in ipairs(self._body) do
			body:runAction(transition.sequence({
				cca.place(body:getPositionX(), body:getPositionY()-self._bodyHeight+5),
				cca.delay(0.05),
				cca.place(body:getPositionX(), body:getPositionY()-self._bodyHeight),
				}))
		end
	end
end

function Trunk:hasBranch(dire)
	return self._body[1]:hasBranch(dire == Trunk.DIRE_RIGHT)
end

return Trunk