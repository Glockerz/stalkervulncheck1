-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local HitboxCaster = require(script.HitboxCaster)
local Signal = require(script.Signal)
local t = {}

t.__index = t
t.__type = "RaycastHitboxModule"
t.DetectionMode = {
	Default = 1,
	PartMode = 2,
	Bypass = 3
}
function t.new(p1) --[[ new | Line: 185 | Upvalues: CollectionService (copy), HitboxCaster (copy), t (copy), Signal (copy) ]]
	if p1 and CollectionService:HasTag(p1, "_RaycastHitboxV4Managed") then
		return HitboxCaster:_FindHitbox(p1)
	end

	local v2 = setmetatable({
		RaycastParams = nil,
		HitboxPendingRemoval = false,
		HitboxStopTime = 0,
		HitboxActive = false,
		Visualizer = true,
		DebugLog = true,
		Tag = "_RaycastHitboxV4Managed",
		DetectionMode = t.DetectionMode.Default,
		HitboxRaycastPoints = {},
		HitboxObject = p1,
		HitboxHitList = {},
		OnUpdate = Signal:Create(),
		OnHit = Signal:Create()
	}, HitboxCaster)

	v2:_Init()

	return v2
end
function t.GetHitbox(p1, p2) --[[ GetHitbox | Line: 215 | Upvalues: HitboxCaster (copy) ]]
	if p2 then
		return HitboxCaster:_FindHitbox(p2)
	end
end

return t