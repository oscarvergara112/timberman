
local startMenu = import("..ui.StartMenu")
local Trunk = import("..entity.Trunk")
local Role = import("..entity.Role")
local PlayTab = import("..ui.PlayTab")
local ScoreMenu = import("..ui.ScoreMenu")
local ProgressBar = import("..ui.ProgressBar")

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
    self._isGameStart = false
    self._num = 0
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
	local tab = PlayTab.new()
						:addTo(self,5)
						:pos(display.left, display.bottom)
	tab:addEventListener(PlayTab.TOUCH_EVENT, function(event)
		if not self._isGameStart then
			self._isGameStart = true
			self._progressBar:start(10)
		end

		self._role:chop(event.dire)
		if self:isGameOver(event.dire) then
			self:gameOver()
		else
			self._trunk:chop(event.dire)
			self._num = self._num + 1
			self._chopNumTxt:setString(self._num)
			if self:isGameOver(event.dire) then
				self:gameOver()
			end
		end
	end)
	self._playTab = tab

	self._progressBar = ProgressBar.new():addTo(self, 5):pos(display.cx, display.top - 150)
	self._progressBar:addEventListener(ProgressBar.END, function()
		self:gameOver()
	end)

	self._chopNumTxt = cc.ui.UILabel.new({
			text = self._num,
			font = "font_issue1343.fnt",
			x = display.cx,
			y = display.top - 80,
			align = cc.ui.TEXT_ALIGN_CENTER,
		}):addTo(self, 3):scale(1.5)
end

function MainScene:isGameOver(dire)
	if self._trunk:hasBranch(dire) then		
		return true
	end
	return false
end

function MainScene:gameOver()
	self._dead = display.newSprite("#die.png", self._role:getPosition()):addTo(self)
	self._role:removeSelf()
	self._progressBar:stop()
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
