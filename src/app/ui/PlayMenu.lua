--
-- Author: Jacky Woo
-- Date: 2014-12-14 21:10:37
--

local PlayMenu = class("PlayMenu")

PlayMenu.PLAY_BUTTON_IMAGES = {
	normal = "images/play.png",
	pressed = "images/play.png",
	disabled = "images/play.png",
}

function PlayMenu:ctor(parent)
	cc.ui.UIPushButton.new(PlayMenu.PLAY_BUTTON_IMAGES)
	:align(display.BOTTOM_CENTER, display.cx, display.bottom+10)
	:onButtonClicked(function(event)
		printInfo("play btn clicked!")
	end)
	:scale(.5)
	:addTo(parent)
end

return PlayMenu