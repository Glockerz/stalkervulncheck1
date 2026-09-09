-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StalkerNames = require(ReplicatedStorage:WaitForChild("StalkerNames"))
local t = {}
local t2 = {
	{
		name = "Loner",
		npcId = "ZoneLoner",
		weight = 7,
		tones = {
			respectful = 5,
			dry = 3,
			sarcastic = 2,
			hostile = 0
		},
		uniforms = { "BlackJacketJeans", "PeacoatJeans", "FieldJacketJeans", "BDUTopJeans", "LonerOutfit", "GreyTrenchCoatJumper", "LayeredTrenchCoatJeans", "LongOvercoatCargoPants" }
	},
	{
		name = "Bandit",
		npcId = "ZoneBandit",
		weight = 3,
		tones = {
			respectful = 0,
			dry = 2,
			sarcastic = 3,
			hostile = 5
		},
		uniforms = { "BlackPeacoatJeans", "CollarJacketJeans", "CollarJacketHoodie", "BrownTrenchCoatCargoPants" }
	}
}

t.FACTIONS = t2
t.SKIN_TONES = {
	Color3.fromRGB(255, 220, 200),
	Color3.fromRGB(255, 200, 170),
	Color3.fromRGB(225, 180, 140),
	Color3.fromRGB(190, 145, 110),
	Color3.fromRGB(150, 110, 85),
	Color3.fromRGB(110, 80, 60),
	Color3.fromRGB(80, 55, 40)
}
t.NAMED_MODELS = {
	Sych = "MT_DeadDrop_Parley"
}
function t.LookFor(p1, p2) --[[ LookFor | Line: 91 | Upvalues: t (copy), t2 (copy) ]]
	if type(p1) ~= "string" or p1 == "" then
		return nil
	end

	local v1 = t.NAMED_MODELS[p1]

	if v1 then
		return {
			model = v1
		}
	end

	local v2 = t2[1]

	for i, v in ipairs(t2) do
		if v.name == p2 then
			v2 = v

			break
		end
	end

	if not (v2 and (v2.uniforms and #v2.uniforms > 0)) then
		return nil
	end

	local v3 = 5381

	for i = 1, #p1 do
		v3 = (v3 * 33 + p1:byte(i)) % 4294967296
	end

	return {
		uniform = v2.uniforms[v3 % #v2.uniforms + 1],
		skin = math.floor(v3 / 7919) % #t.SKIN_TONES + 1
	}
end

local t3 = { "respectful", "sarcastic", "hostile", "dry" }

function t.PickTone(p1, p2) --[[ PickTone | Line: 113 | Upvalues: t3 (copy) ]]
	local v2, sum = if p1 then p1 else {}, 0

	for i, v in ipairs(t3) do
		sum = sum + (v2[v] or 0)
	end

	if sum <= 0 then
		return "dry"
	end

	local sum2 = p2:NextNumber() * sum

	for i, v in ipairs(t3) do
		local v3 = v2[v] or 0

		if v3 > 0 then
			sum2 = sum2 - v3

			if sum2 <= 0 then
				return v
			end
		end
	end

	return "dry"
end
function t.RollSpeaker(p1, p2) --[[ RollSpeaker | Line: 134 | Upvalues: t2 (copy), StalkerNames (copy), t (copy) ]]
	local sum, v2 = 0, if p1 then p1 else Random.new()

	for i, v in ipairs(t2) do
		sum = sum + v.weight
	end

	local sum2 = v2:NextNumber() * sum
	local v3 = t2[#t2]

	for i, v in ipairs(t2) do
		sum2 = sum2 - v.weight

		if sum2 <= 0 then
			v3 = v

			break
		end
	end

	local v4 = nil

	for i = 1, 8 do
		local v5 = StalkerNames.Random(v2)

		v4 = v5

		if v5 ~= p2 then
			break
		end
	end

	local uniforms = v3.uniforms
	local t3 = {
		faction = v3.name,
		npcId = v3.npcId,
		name = v4
	}

	t3.uniform = uniforms and #uniforms > 0 and uniforms[v2:NextInteger(1, #uniforms)] or nil
	t3.skin = v2:NextInteger(1, #t.SKIN_TONES)
	t3.tones = v3.tones

	return t3
end
function t.FactionName(p1) --[[ FactionName | Line: 166 | Upvalues: t2 (copy) ]]
	for i, v in ipairs(t2) do
		if v.npcId == p1 then
			return v.name
		end
	end

	return nil
end

return t