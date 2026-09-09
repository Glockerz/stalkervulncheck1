-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local Anim = require(script.Anim)
local BlendData = Anim.Enums.BlendData
local t = {}

t.__index = t
t.ClassName = script.Name
function t.new(p1) --[[ new | Line: 10 | Upvalues: t (copy) ]]
	return setmetatable({
		StepCount = 0,
		Animator = p1,
		Anims = {},
		QueuedBlends = {},
		QueuedCBlends = {}
	}, t)
end
function t.Load(p1, p2, p3) --[[ Load | Line: 21 | Upvalues: Anim (copy) ]]
	p1.Anims[p2] = Anim.new(p3, p2, p1)

	return p1.Anims[p2]
end
function t.Remove(p1, p2) --[[ Remove | Line: 26 ]]
	p1.Anims[p2] = p1.Anims[p2]:Destroy()
end
function t.Update(p1, p2) --[[ Update | Line: 30 | Upvalues: BlendData (copy), TweenService (copy), Anim (copy) ]]
	for v1, v2 in p1.QueuedBlends do
		local v3 = p1.Anims[v2]
		local _Blend = v3._Blend

		_Blend[BlendData.Progress] = math.min(_Blend[BlendData.Progress] + p2, _Blend[BlendData.Duration])
		v3.Track:AdjustWeight(math.max(0.0001, (math.lerp(_Blend[BlendData.Start], _Blend[BlendData.Target], TweenService:GetValue(_Blend[BlendData.Progress] / _Blend[BlendData.Duration], _Blend[BlendData.Style], _Blend[BlendData.Direction])))), 0)

		if _Blend[BlendData.Progress] == _Blend[BlendData.Duration] then
			table.remove(p1.QueuedBlends, v1)
			v3._Blend = nil
		end
	end

	for v13, v14 in p1.QueuedCBlends do
		local v15 = p1.Anims[v14]
		local _Blend = Anim._Blend

		v15.Track:AdjustWeight(math.lerp(v15.Track.WeightTarget, _Blend[BlendData.Target], p2 * _Blend[BlendData.Speed]), 0)
	end

	p1.StepCount = p1.StepCount + 1
end
function t.Destroy(p1) --[[ Destroy | Line: 59 ]]
	for v1, v2 in p1.Anims do
		p1:Remove(v1)
	end
end

return t