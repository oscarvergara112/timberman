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
Trunk.DIRE_LEFT = 0
Trunk.DIRE_RIGHT = 1

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
	self._branch[1] = Trunk.NONE_BRANCH
	for i = 2, bodyNum do
		local hasBranch = math.random(1,2) == 1
		if hasBranch then
			self._branch[i] = {}
		else
			self._branch[i] = Trunk.NONE_BRANCH
		end
	end
end

function Trunk:onExit()
	-- body
end

function Trunk:chop(dire)
	if dire == Trunk.DIRE_LEFT then
		local body = display.newSprite("#body.jpg")
						:align(display.BOTTOM_CENTER, 0, 0)
						:addTo(self)
						:scale(Trunk.SCALE)
		-- transition.moveBy(body, {time = 0.4, x = display.width/2, y = 0, onComplete = handler(body, self.removeSelf)})
		body:runAction(cc.RotateBy:create(0.4, 180))
		body:runAction(transition.sequence{
			cca.jumpBy(0.6, display.width, 50, 100, 1),
			cca.removeSelf(),
			})
	elseif dire == Trunk.DIRE_RIGHT then
		local body = display.newSprite("#body.jpg")
						:align(display.BOTTOM_CENTER, 0, 0)
						:addTo(self)
						:scale(Trunk.SCALE)
		-- transition.moveBy(body, {time = 0.4, x = -display.width/2, y = 0, onComplete = handler(body, self.removeSelf)})
		body:runAction(cc.RotateBy:create(0.4, -180))
		body:runAction(transition.sequence{
			cca.jumpBy(0.6, -display.width, 50, 100, 1),
			cca.removeSelf(),
			})
	end
	if self._body[1]:getNumberOfRunningActions() == 0 then
		for _, body in ipairs(self._body) do
			body:runAction(transition.sequence({
				cca.place(body:getPositionX(), body:getPositionY()+5),
				cca.delay(0.05),
				cca.place(body:getPositionX(), body:getPositionY()),
				}))
		end
	end
end

return Trunk