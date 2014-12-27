--
-- Author: Jacky Woo
-- Date: 2014-12-14 21:10:37
--

local StartMenu = class("StartMenu", function()
	return display.newNode()
end)

StartMenu.PLAY_BUTTON_IMAGES = {
	normal = "#play.png",
	pressed = "#play.png",
	disabled = "#play.png",
}

StartMenu.PLAY_BUTTON_SCALE = 0.6

function StartMenu:ctor(parent)
	cc.ui.UIPushButton.new(StartMenu.PLAY_BUTTON_IMAGES)
	:align(display.BOTTOM_CENTER, 0, 10)
	:onButtonClicked(function(event)
		printInfo("play btn clicked!")
	end)
	:scale(StartMenu.PLAY_BUTTON_SCALE)
	:addTo(self)

	display.newSprite("#logo.png", 0, display.height*3/4):addTo(self)
end

return StartMenu