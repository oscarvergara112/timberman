--
-- Author: Jacky Woo
-- Date: 2015-01-07 21:09:32
--
local ScoreMenu = class("ScoreMenu", function()
	return display.newNode():setNodeEventEnabled(true)
end)

ScoreMenu.PLAY_BUTTON_IMAGES = {
	normal = "#play.png",
	pressed = "#play.png",
	disabled = "#play.png",
}

ScoreMenu.PLAY_BUTTON_SCALE = 0.6

ScoreMenu.START_EVENT = "start_event"

function ScoreMenu:ctor()
	cc.GameObject.extend(self)
		:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function ScoreMenu:onEnter()	
	cc.ui.UIPushButton.new(ScoreMenu.PLAY_BUTTON_IMAGES)
	:align(display.BOTTOM_CENTER, 0, 10)
	:onButtonClicked(function(event)
		printInfo("play btn clicked!")
		transition.moveBy(self, {time=0.3, x=0, y=display.height, onComplete=function()
			self:dispatchEvent({name=ScoreMenu.START_EVENT})
		end})
	end)
	:scale(ScoreMenu.PLAY_BUTTON_SCALE)
	:addTo(self)

end

function ScoreMenu:onExit()
	-- body
end

return ScoreMenu