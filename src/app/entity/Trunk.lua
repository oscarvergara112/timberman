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

function Trunk:ctor(height)
	self._body = {}
	self._branch = {}
	self._treeHeight = height
end

function Trunk:onEnter()
	-- base
	display.newSprite("images/base.png")
		:addTo(self)
		:scale(Trunk.SCALE)
		:align(display.TOP_CENTER, 2, 0)

	local texture = cc.Director:getInstance():getTextureCache():addImage("images/body.jpg")
	local bodyHeight = texture:getContentSize().height * Trunk.SCALE
	local bodyNum = math.ceil(self._treeHeight / (bodyHeight))
	self._branchNum = bodyNum
	
	for i = 1, bodyNum do
		self._body[i] = display.newSprite("images/body.jpg")
							:align(display.BOTTOM_CENTER, 0, (i-1)*bodyHeight)
							:addTo(self)
							:scale(Trunk.SCALE)
	end

end

function Trunk:onExit()
	-- body
end

function Trunk:chop(dire)
	-- body
end

return Trunk