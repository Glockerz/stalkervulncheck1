-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"))
local t = {
	SelfMonitor = false,
	DistanceAttenuation = {
		[0] = 1,
		[25] = 0.85,
		[55] = 0.4,
		[90] = 0
	},
	Filter = {
		Type = "Lowpass24dB",
		Frequency = 2000,
		Q = 1
	},
	EQ = {
		LowGain = 3,
		MidGain = -3,
		HighGain = -8
	},
	Compressor = {
		Threshold = -18,
		Ratio = 3,
		Attack = 0.04,
		Release = 0.18,
		MakeupGain = 8
	},
	Volume = 2.5,
	Limiter = {
		MaxLevel = -1,
		Release = 0.05
	},
	ListenerEQ = {
		LowGain = 2,
		MidGain = -3,
		HighGain = -12
	},
	PollInterval = 1,
	AVATAR_ADMITTED_ATTR = "ZS_AvatarAdmitted"
}

function t.isZoneGear(p1) --[[ isZoneGear | Line: 62 | Upvalues: t (copy) ]]
	if p1:GetAttribute(t.AVATAR_ADMITTED_ATTR) == nil then
		return p1:IsA("Model")
	end

	return false
end
function t.wearsFaceWear(p1, p2) --[[ wearsFaceWear | Line: 72 | Upvalues: t (copy), ItemDatabase (copy) ]]
	if not p1 then
		return false
	end

	for v1, v2 in p1:GetChildren() do
		if t.isZoneGear(v2) then
			for k, v in pairs(ItemDatabase) do
				if type(v) == "table" and (v.ItemType == "FaceWear" and (p2(v) and v2.Name == (v.Model or k))) then
					return true
				end
			end
		end
	end

	return false
end
function t.isWearingGasMask(p1) --[[ isWearingGasMask | Line: 87 | Upvalues: t (copy) ]]
	return t.wearsFaceWear(p1, function(p1) --[[ Line: 88 ]]
		return if p1.RadResist == nil then false else p1.RadResist > 0
	end)
end
function t.isWearingVisorMask(p1) --[[ isWearingVisorMask | Line: 96 | Upvalues: t (copy) ]]
	return t.wearsFaceWear(p1, function(p1) --[[ Line: 97 ]]
		return p1.HasVisor == true
	end)
end

return t