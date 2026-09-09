-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 2 ]]
	local v1 = if typeof(p1) == "string" then tonumber(p1) or (0 / 0) else p1

	if typeof(v1) ~= "number" then
		return "nan"
	end

	if p2 ~= nil then
		if typeof(p2) ~= "number" then
			error("TypeError: fractionDigits must be a number between 0 and 100")
		end

		if p2 < 0 or p2 > 100 then
			error("RangeError: fractionDigits must be between 0 and 100")
		end
	end

	return string.format(if p2 == nil then "%e" else "%." .. tostring(p2) .. "e", v1):gsub("%+0", "+"):gsub("%-0", "-"):gsub("0*e", "e")
end