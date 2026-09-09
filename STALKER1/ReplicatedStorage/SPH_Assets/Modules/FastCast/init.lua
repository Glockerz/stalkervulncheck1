-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	DebugLogging = false,
	VisualizeCasts = false
}

t.__index = t
t.__type = "FastCast"
t.HighFidelityBehavior = {
	Default = 1,
	Always = 3
}

local ActiveCast = require(script.ActiveCast)
local Signal = require(script.Signal)

require(script.Table)
require(script.TypeDefinitions)
ActiveCast.SetStaticFastCastReference(t)
function t.new() --[[ new | Line: 107 | Upvalues: Signal (copy), t (copy) ]]
	return setmetatable({
		LengthChanged = Signal.new("LengthChanged"),
		RayHit = Signal.new("RayHit"),
		RayPierced = Signal.new("RayPierced"),
		CastTerminating = Signal.new("CastTerminating"),
		WorldRoot = workspace
	}, t)
end
function t.newBehavior() --[[ newBehavior | Line: 119 | Upvalues: t (copy) ]]
	return {
		RaycastParams = nil,
		MaxDistance = 1000,
		CanPierceFunction = nil,
		HighFidelitySegmentSize = 0.5,
		CosmeticBulletTemplate = nil,
		CosmeticBulletProvider = nil,
		CosmeticBulletContainer = nil,
		AutoIgnoreContainer = true,
		Acceleration = Vector3.new(),
		HighFidelityBehavior = t.HighFidelityBehavior.Default
	}
end

local v1 = t.newBehavior()

function t.Fire(p1, p2, p3, p4, p5) --[[ Fire | Line: 136 | Upvalues: v1 (copy), ActiveCast (copy) ]]
	if p5 == nil then
		p5 = v1
	end

	local v12 = ActiveCast.new(p1, p2, p3, p4, p5)

	v12.RayInfo.WorldRoot = p1.WorldRoot

	return v12
end

return t