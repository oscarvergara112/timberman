--
-- Author: Jacky Woo
-- Date: 2014-12-25 21:03:26
--
local Branch = class("Branch", function()
	local sprite = display.newSprite("branch.png")
	sprite:setNodeEventEnabled(true)
	return sprite
end)

function Branch:ctor()
	-- body
end

function Branch:onEnter()
	-- body
end

function Branch:onExit()
	-- body
end

return Branch