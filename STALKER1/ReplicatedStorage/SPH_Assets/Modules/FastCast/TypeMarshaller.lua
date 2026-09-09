-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = typeof

return function(p1) --[[ typeof | Line: 5 | Upvalues: v1 (copy) ]]
	local v12 = v1(p1)

	if v12 ~= "table" then
		return v12
	end

	local v2 = getmetatable(p1)

	if v1(v2) ~= "table" then
		return v12
	end

	local __type = v2.__type

	if __type == nil then
		return v12
	end

	return __type
end