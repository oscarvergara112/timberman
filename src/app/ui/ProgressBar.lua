--
-- Author: Jacky Woo
-- Date: 2015-01-08 20:54:51
--
local ProgressBar = class("ProgressBar", function()
	return display.newNode():setNodeEventEnabled(true)
end)

ProgressBar.END = "END"

function ProgressBar:ctor()
	cc.GameObject.extend(self)
	:addComponent("components.behavior.EventProtocol"):exportMethods()

	self._percent = 50

	self:scale(0.6)
end

function ProgressBar:onEnter()
	-- bg
	display.newSprite("#blood_bg.png"):addTo(self)

	-- progress timer
	self._bar = display.newProgressTimer("#blood.png", display.PROGRESS_TIMER_BAR):addTo(self,1)
	self._bar:setMidpoint(cc.p(0, 0.5))
	self._bar:setBarChangeRate(cc.p(1, 0))
	self._bar:setPercentage(self._percent) -- 最后设置百分比，否则绘制出错。
	
end

function ProgressBar:start( time )
	self._time = time

	local to = cca.progressFromTo(self._time, self._percent, 0)
	local cf = cca.callFunc(function()
		self:dispatchEvent({name=ProgressBar.END})
	end)
	local seq = transition.sequence({to, cf})
	self._bar:runAction(seq)
end

function ProgressBar:stop()
	self._bar:stopAllActions()
end

function ProgressBar:addTime( dt )
	-- body
end

return ProgressBar