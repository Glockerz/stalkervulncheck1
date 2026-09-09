-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Maps = {
		{
			id = "Cordon",
			name = "Cordon",
			subtitle = "Rookie zone. Warehouses, checkpoint, bandit camp.",
			placeId = 112318794071351,
			available = true,
			difficulty = "Easy"
		},
		{
			id = "Garbage",
			name = "Garbage",
			subtitle = "Coming soon.",
			placeId = 0,
			available = false,
			difficulty = "Medium"
		},
		{
			id = "DarkValley",
			name = "Dark Valley",
			subtitle = "Coming soon.",
			placeId = 0,
			available = false,
			difficulty = "Hard"
		},
		{
			id = "AgroProm",
			name = "Agroprom",
			subtitle = "Coming soon.",
			placeId = 0,
			available = false,
			difficulty = "Hard"
		}
	}
}

function t.GetByPlaceId(p1) --[[ GetByPlaceId | Line: 47 | Upvalues: t (copy) ]]
	if not p1 then
		return nil
	end

	for i, v in ipairs(t.Maps) do
		if v.placeId == p1 then
			return v
		end
	end

	return nil
end
function t.GetById(p1) --[[ GetById | Line: 56 | Upvalues: t (copy) ]]
	if not p1 then
		return nil
	end

	for i, v in ipairs(t.Maps) do
		if v.id == p1 then
			return v
		end
	end

	return nil
end
function t.GetDefault() --[[ GetDefault | Line: 65 | Upvalues: t (copy) ]]
	for i, v in ipairs(t.Maps) do
		if v.available then
			return v
		end
	end

	return t.Maps[1]
end

return t