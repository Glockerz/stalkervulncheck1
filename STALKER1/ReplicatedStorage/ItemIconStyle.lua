-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	CropByType = {
		Ammo = true
	}
}

function t.ScaleTypeFor(p1) --[[ ScaleTypeFor | Line: 68 | Upvalues: t (copy) ]]
	if not p1 then
		return Enum.ScaleType.Fit
	end

	if p1.CropIcon == nil then
		if t.CropByType[p1.ItemType] then
			return Enum.ScaleType.Crop
		end

		return Enum.ScaleType.Fit
	end

	return p1.CropIcon and Enum.ScaleType.Crop or Enum.ScaleType.Fit
end

return t