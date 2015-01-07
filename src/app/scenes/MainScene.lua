
local startMenu = import("..ui.StartMenu")
local Trunk = import("..entity.Trunk")
local Role = import("..entity.Role")
local PlayTab = import("..ui.PlayTab")
local ScoreMenu = import("..ui.ScoreMenu")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

MainScene.BG_NUM = 2
MainScene.TRUNK_Y = 135
MainScene.TRUNK_RADIUS = 165

MainScene.STATE_WELCOME = 1
MainScene.STATE_START = 2
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
	elseif self._state == MainScene.STATE_START then
		self:play()
	end
end

function MainScene:onExit()
end

function MainScene:play()
	printInfo("MainScene:play()")
	local tab = PlayTab.new()
						:addTo(self,5)
						:pos(display.left, display.bottom)
	tab:addEventListener(PlayTab.LEFT_EVENT, function()
		self._role:chop(Role.DIRE_LEFT)
		if self:isGameOver(Trunk.DIRE_LEFT) then
			self:gameOver(Trunk.DIRE_LEFT)
		else
			self._trunk:chop(Trunk.DIRE_LEFT)
			if self:isGameOver(Trunk.DIRE_LEFT) then
				self:gameOver(Trunk.DIRE_LEFT)
			end
		end
	end)
	tab:addEventListener(PlayTab.RIGHT_EVENT, function()
		self._role:chop(Role.DIRE_RIGHT)
		if self:isGameOver(Trunk.DIRE_RIGHT) then
			self:gameOver(Trunk.DIRE_RIGHT)
		else
			self._trunk:chop(Trunk.DIRE_RIGHT)
			if self:isGameOver(Trunk.DIRE_RIGHT) then
				self:gameOver(Trunk.DIRE_RIGHT)
			end
		end
	end)
	self._playTab = tab
end

function MainScene:isGameOver(dire)
	if self._trunk:hasBranch(dire) then		
		return true
	end
	return false
end

function MainScene:gameOver(dire)
	self._role:removeSelf()
	if dire == Trunk.DIRE_RIGHT then
		self._dead = display.newSprite("#die.png",display.cx+MainScene.TRUNK_RADIUS,display.bottom+MainScene.TRUNK_Y):addTo(self)
	elseif dire == Trunk.DIRE_LEFT then
		self._dead = display.newSprite("#die.png",display.cx-MainScene.TRUNK_RADIUS,display.bottom+MainScene.TRUNK_Y):addTo(self)
	end
	self._playTab:removeSelf()
	local menu = ScoreMenu.new()
	:addTo(self, 5)
	:pos(display.cx, display.top)
	menu:addEventListener(ScoreMenu.START_EVENT, function()
		app:enterScene("MainScene", {MainScene.STATE_START}, "fade", 0.5, display.COLOR_BLACK)
	end)
	transition.moveTo(menu, {time=0.3, x=display.cx, y=display.bottom})
end

return MainScene
