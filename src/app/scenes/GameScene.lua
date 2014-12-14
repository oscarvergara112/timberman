--
-- Author: Jacky Woo
-- Date: 2014-12-14 20:46:48
--

local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

GameScene.BG_NUM = 2
GameScene.TRUNK_Y = 130
GameScene.TRUNK_SCALE = 0.65

function GameScene:ctor()
    self.trunk = {}
end

function GameScene:onEnter()
	display.newSprite(string.format("images/bg%d.jpg", math.random(1, GameScene.BG_NUM)), display.cx, display.cy)
	:addTo(self)

	display.newSprite("images/base.png")
	:scale(GameScene.TRUNK_SCALE)
	:align(display.CENTER_TOP, display.cx, display.bottom + GameScene.TRUNK_Y)
	:addTo(self)

	self:makeTrunk()
end

function GameScene:makeTrunk()
	local height = display.height - GameScene.TRUNK_Y
	local texture = cc.Director:getInstance():getTextureCache():addImage("images/body.jpg")
	local cnt = math.ceil( height/texture:getContentSize().height/GameScene.TRUNK_SCALE )
	local y = display.bottom + GameScene.TRUNK_Y
	for i = 1, cnt do
		self.trunk[#self.trunk+1] = display.newSprite("images/body.jpg")
		:scale(GameScene.TRUNK_SCALE)
		:align(display.CENTER_BOTTOM, display.cx-2, y)
		:addTo(self)

		y = y + texture:getContentSize().height*GameScene.TRUNK_SCALE
	end
end

function GameScene:onExit()
end

return GameScene
