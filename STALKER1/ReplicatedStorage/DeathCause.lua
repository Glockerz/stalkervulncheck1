-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	FRESHNESS = 45
}
local t2 = {
	bleeding = "bled out",
	radiation = "died of radiation",
	fall = "fell to their death",
	explosion = "blown up"
}

t.UNKNOWN_PHRASE = "respawned"
function t.Tag(p1, p2) --[[ Tag | Line: 42 ]]
	if p1 and (type(p2) == "string" and p2 ~= "") then
		p1:SetAttribute("_lastDamageSource", p2:lower())
		p1:SetAttribute("_lastDamageAt", os.clock())
	end
end
function t.Read(p1) --[[ Read | Line: 49 | Upvalues: t (copy) ]]
	if not p1 then
		return nil
	end

	local v1 = p1:GetAttribute("_lastDamageSource")

	if type(v1) ~= "string" or v1 == "" then
		return nil
	end

	local v2 = p1:GetAttribute("_lastDamageAt")

	if type(v2) == "number" and not (os.clock() - v2 > t.FRESHNESS) then
		return v1
	end

	return nil
end
function t.Describe(p1) --[[ Describe | Line: 60 | Upvalues: t (copy), t2 (copy) ]]
	if type(p1) ~= "string" or p1 == "" then
		return t.UNKNOWN_PHRASE
	end

	local v1 = p1:match("^player:(.+)$")

	if v1 then
		return "killed by " .. v1
	end

	return t2[p1] or "died by " .. p1
end

local t3 = {
	whirligig = true,
	vortex = true,
	electro = true,
	burner = true,
	springboard = true
}
local t4 = {
	flesh = true,
	mutant = true
}
local t5 = {
	bandit = true,
	military = true,
	loner = true,
	npc = true
}

function t.Category(p1) --[[ Category | Line: 81 | Upvalues: t3 (copy), t4 (copy), t5 (copy) ]]
	if type(p1) ~= "string" or p1 == "" then
		return "unknown"
	end

	if p1:match("^player:") then
		return "pvp"
	end

	if t3[p1] then
		return "anomaly"
	end

	if t4[p1] then
		return "mutant"
	end

	if t5[p1] then
		return "gunfight"
	end

	if p1 == "radiation" then
		return "radiation"
	end

	if p1 == "bleeding" then
		return "bleeding"
	end

	return "unknown"
end

return t