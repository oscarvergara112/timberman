
local gameScene = import(".GameScene")
local playMenu = import("..ui.PlayMenu")
local MainScene = class("MainScene", gameScene)

function MainScene:ctor()
    
end

function MainScene:onEnter()
	MainScene.super.onEnter(self)

	self.coverLayer = display.newLayer():addTo(self)
	display.newSprite("images/logo.png", display.cx, display.top - 100):addTo(self.coverLayer):setAnchorPoint(cc.p(.5, .5))

	playMenu.new(self.coverLayer)
end

function MainScene:onExit()
end

return MainScene
