--
-- Author: Jacky Woo
-- Date: 2014-12-30 21:51:51
--
local PlayTab = class("PlayTab", function()
	return display.newNode():setNodeEventEnabled(true)
end)

PlayTab.LEFT_TAB_IMAGE = {
	normal = "#left.png",
	pressed = "#left.png",
	disabled = "#left.png",
}

PlayTab.RIGHT_TAB_IMAGE = {
	normal = "#right.png",
	pressed = "#right.png",
	disabled = "#right.png",
}

-- events
PlayTab.LEFT_EVENT = "LEFT_EVENT"
PlayTab.RIGHT_EVENT = "RIGHT_EVENT"

function PlayTab:ctor()
	cc.GameObject.extend(self)
		:addComponent("components.behavior.EventProtocol"):exportMethods()
end

function PlayTab:onEnter()
	self._left = cc.ui.UIPushButton.new(PlayTab.LEFT_TAB_IMAGE)
					:align(display.CENTER_BOTTOM, -150, 50)
					:onButtonClicked(function(event)
						printInfo("play left tab clicked!")
						self:dispatchEvent({name = PlayTab.LEFT_EVENT})
					end)
					:scale(0.7)
					:addTo(self)
	self._left:runAction(cc.RepeatForever:create(transition.sequence({
		cc.MoveBy:create(0.3, cc.p(-40,0)),
		cc.MoveBy:create(0.3, cc.p(40, 0))
		})))

	self._right = cc.ui.UIPushButton.new(PlayTab.RIGHT_TAB_IMAGE)
					:align(display.CENTER_BOTTOM, 150, 50)
					:onButtonClicked(function(event)
						printInfo("play right tab clicked!")
						self:dispatchEvent({name = PlayTab.RIGHT_EVENT})
					end)
					:scale(0.7)
					:addTo(self)

	self._right:runAction(cc.RepeatForever:create(transition.sequence({
		cc.MoveBy:create(0.3, cc.p(40,0)),
		cc.MoveBy:create(0.3, cc.p(-40, 0))
		})))
end

return PlayTab