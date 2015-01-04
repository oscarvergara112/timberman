
local startMenu = import("..ui.StartMenu")
local Trunk = import("..entity.Trunk")
local Role = import("..entity.Role")
local playTab = import("..ui.PlayTab")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

MainScene.BG_NUM = 2
MainScene.TRUNK_Y = 135
MainScene.TRUNK_RADIUS = 165
MainScene.STATE_WELCOME = 1
MainScene.STATE_DEAD = 2
MainScene.STATE_SELECT_ROLE = 3

function MainScene:ctor(state)
    self._state = state or MainScene.STATE_WELCOME
end

function MainScene:onEnter()
	display.addSpriteFrames("images/timberman.plist", "images/timberman.png")

	display.newSprite(string.format("#bg%d.jpg", math.random(1, MainScene.BG_NUM)), display.cx, display.cy)
		:addTo(self)

	self._trunk = Trunk.new(display.height-MainScene.TRUNK_Y)
		:pos(display.cx, display.bottom+MainScene.TRUNK_Y)
		:addTo(self, 2)

	self._role = Role.new(display.cx-MainScene.TRUNK_RADIUS, display.cx+MainScene.TRUNK_RADIUS, display.bottom+MainScene.TRUNK_Y)
		:addTo(self, 2)

	if self._state == MainScene.STATE_WELCOME then
		startMenu.new()
			:addTo(self, 5)
			:pos(display.cx, display.bottom)
			:addEventListener(startMenu.START_EVENT, handler(self, self.play))
	end
end

function MainScene:onExit()
end

function MainScene:play()
	printInfo("MainScene:play()")
	local tab = playTab.new()
						:addTo(self,5)
						:pos(display.cx, display.bottom)
	tab:addEventListener(playTab.LEFT_EVENT, function()
		self._trunk:chop(Trunk.DIRE_LEFT)
		self._role:chop(Role.DIRE_LEFT)
	end)
	tab:addEventListener(playTab.RIGHT_EVENT, function()
		self._trunk:chop(Trunk.DIRE_RIGHT)
		self._role:chop(Role.DIRE_RIGHT)
	end)
end

return MainScene
