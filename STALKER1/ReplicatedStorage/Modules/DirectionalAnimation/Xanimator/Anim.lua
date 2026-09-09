-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local SignalPlus = require(script.Parent.SignalPlus)
local t = {}

t.__index = t
t.ClassName = t
t.Enums = table.freeze({
	BlendData = table.freeze({
		Start = 0,
		Target = 1,
		Duration = 2,
		Style = 3,
		Direction = 4,
		Progress = 5,
		Speed = 6
	})
})

local BlendData = t.Enums.BlendData

t.DEFAULT_STYLE = Enum.EasingStyle.Sine
t.DEFAULT_DIRECTION = Enum.EasingDirection.Out
t.DEFAULT_FADE = 0.5
function t.new(p1, p2, p3) --[[ new | Line: 25 | Upvalues: SignalPlus (copy), t (copy) ]]
	return setmetatable({
		FadeOut = nil,
		_Blend = nil,
		IsPaused = false,
		Speed = 1,
		Name = p2,
		Parent = p3,
		Track = p3.Animator:LoadAnimation(p1),
		Finished = SignalPlus(),
		Transitioned = SignalPlus()
	}, t)
end
function t.SetWeight(p1, p2) --[[ SetWeight | Line: 40 ]]
	p1.Track:AdjustWeight(math.max(0.0001, p2), 0)
end
function t.SetSpeed(p1, p2) --[[ SetSpeed | Line: 44 ]]
	p1.Speed = p2

	if not (p1.IsPaused or p1.IsReversed) then
		p1.Track:AdjustSpeed(p2)
	end
end
function t.Blend(p1, p2, p3, p4, p5) --[[ Blend | Line: 50 | Upvalues: BlendData (copy) ]]
	if p1._Blend then
		p1.__Blend = nil
		p1._Blend = {}
		table.remove(p1.Parent.QueuedBlends, table.find(p1.Parent.QueuedBlends, p1.Name))
	else
		p1._Blend = {}
	end

	if p1.FadeOut then
		p1.FadeOut:Disconnect()
	end

	local _Blend = p1._Blend

	table.insert(_Blend, BlendData.Progress, 0)
	table.insert(_Blend, BlendData.Duration, p3)
	table.insert(_Blend, BlendData.Target, p2)
	table.insert(_Blend, BlendData.Start, p1.Track.WeightTarget)
	table.insert(_Blend, BlendData.Style, p4)
	table.insert(_Blend, BlendData.Direction, p5)
	table.insert(p1.Parent.QueuedBlends, p1.Name)
end
function t.Between(p1, p2, p3, p4, p5, p6) --[[ Between | Line: 74 ]]
	p1:Blend(1 - p3, p4, p5, p6)
	p2:Blend(p3, p4, p5, p6)
end
function t.CBlend(p1, p2, p3) --[[ CBlend | Line: 79 | Upvalues: BlendData (copy) ]]
	if p1._Blend then
		table.clear(p1._Blend)
	else
		p1._Blend = {}
	end

	local _Blend = p1._Blend

	table.insert(_Blend, BlendData.Speed, p3)
	table.insert(_Blend, BlendData.Target, p2)
end
function t.RetargetCBlend(p1, p2) --[[ RetargetCBlend | Line: 90 | Upvalues: BlendData (copy) ]]
	table.remove(p1.Blend, BlendData.Target)
	table.insert(p1.Blend, BlendData.Target, p2)
end
function t.Play(p1, p2, p3, p4) --[[ Play | Line: 95 ]]
	local Track = p1.Track

	if p2 then
		p1.FadeOut = Track.Stopped:Once(function() --[[ Line: 98 | Upvalues: Track (copy), p1 (copy), p2 (copy), p3 (copy), p4 (copy) ]]
			Track:Play(0, Track.WeightCurrent, 0)
			Track.TimePosition = Track.Length
			p1:Blend(0, p2, p3, p4)
			p1.Finished:Fire()
		end)
	end

	Track:Play(0, Track.WeightTarget, p1.Speed)
end
function t.Pause(p1) --[[ Pause | Line: 108 ]]
	p1.Track:AdjustSpeed(0)
	p1.IsPaused = true
end
function t.Resume(p1) --[[ Resume | Line: 113 ]]
	p1.Track:AdjustSpeed(p1.Speed)
	p1.IsPaused = false
end
function t.Reverse(p1) --[[ Reverse | Line: 118 ]]
	p1:SetSpeed(-p1.Speed)
end
function t.Stop(p1, p2, p3, p4, p5) --[[ Stop | Line: 122 ]]
	if p1.FadeOut then
		p1.FadeOut:Disconnect()
	end

	p1.Track:AdjustSpeed(0)
	p1:Blend(0, p2, p3, p4)
end
function t.Destroy(p1) --[[ Destroy | Line: 130 ]]
	p1.Track:Destroy()
	p1.Finished:Destroy()
	p1.Transitioned:Destroy()
end

return t