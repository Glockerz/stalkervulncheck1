-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local tbl = {
	IsLobby = false,
	AllowItemDrops = true,
	ItemDropLifetime = 0,
	AllowDeathLoot = true,
	HasDayNightCycle = true,
	HasHostileNPCs = true,
	HasMutants = true,
	HasAnomalies = true,
	HasLootSpawns = true,
	HasMapData = true,
	HasAmbientWind = true
}

local function zone(p1, p2, p3) --[[ zone | Line: 82 | Upvalues: tbl (copy) ]]
	local t = {
		Id = p1,
		Name = p2
	}

	for k, v in pairs(tbl) do
		t[k] = v
	end

	if p3 then
		for k, v in pairs(p3) do
			t[k] = v
		end
	end

	return t
end

local t = {
	Id = "cordon",
	Name = "Cordon"
}
local t2 = {}

for k, v in pairs(tbl) do
	t[k] = v
end

t2[112318794071351] = t
t2[72072976067143] = zone("lobby", "Lobby", {
	IsLobby = true,
	AllowItemDrops = true,
	ItemDropLifetime = 600,
	AllowDeathLoot = false,
	HasDayNightCycle = false,
	HasHostileNPCs = false,
	HasMutants = false,
	HasAnomalies = false,
	HasLootSpawns = false,
	HasMapData = false,
	HasAmbientWind = false
})

local v2 = t2[game.PlaceId]

if not v2 then
	warn(string.format("[PlaceConfig] placeId %d is not registered; defaulting to ZONE behaviour. Add it to PlaceConfig.PLACES.", game.PlaceId))

	local t3 = {
		Id = "unknown",
		Name = tostring(game.Name)
	}

	for k, v in pairs(tbl) do
		t3[k] = v
	end

	v2 = t3
end

function v2.NameFor(p1) --[[ NameFor | Line: 126 | Upvalues: t2 (copy) ]]
	return t2[p1] and t2[p1].Name or "place " .. tostring(p1)
end
function v2.ItemDropsAllowed() --[[ ItemDropsAllowed | Line: 151 | Upvalues: v2 (ref) ]]
	local v1 = game:GetService("ReplicatedStorage"):GetAttribute("ItemDropsOverride")

	if type(v1) == "boolean" then
		return v1
	end

	return v2.AllowItemDrops
end
function v2.ItemDropLifetimeSeconds() --[[ ItemDropLifetimeSeconds | Line: 165 | Upvalues: v2 (ref) ]]
	local v1 = game:GetService("ReplicatedStorage"):GetAttribute("ItemDropLifetimeOverride")

	if type(v1) == "number" and v1 >= 0 then
		return v1
	end

	return v2.ItemDropLifetime or 0
end

return v2