-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	named = function(p1) --[[ named | Line: 30 ]]
		assert(type(p1) == "string", "Symbols must be created using a string name!")

		local v2 = newproxy(true)
		local v3 = string.format("Symbol(%s)", p1)

		getmetatable(v2).__tostring = function() --[[ Line: 37 | Upvalues: v3 (copy) ]]
			return v3
		end

		return v2
	end
}