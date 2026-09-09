-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1

if game then
	v1 = require(script.Parent.graph).get_scope

	return function(p13) --[[ untrack | Line: 7 | Upvalues: v1 (copy) ]]
		local v12 = v1()

		if not v12 then
			return p13()
		end

		local effect = v12.effect

		v12.effect = false

		local ok, result = pcall(p13)

		v12.effect = effect

		if not ok then
			error(result, 0)
		end

		return result
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.graph).get_scope

return function(p13) --[[ untrack | Line: 7 | Upvalues: v1 (copy) ]]
	local v12 = v1()

	if not v12 then
		return p13()
	end

	local effect = v12.effect

	v12.effect = false

	local ok, result = pcall(p13)

	v12.effect = effect

	if not ok then
		error(result, 0)
	end

	return result
end