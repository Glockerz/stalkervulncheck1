-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, ...) --[[ Line: 12 ]]
	local t = { ... }

	return function(p12) --[[ Line: 14 | Upvalues: p1 (copy), t (copy) ]]
		assert(type(p12) == "table", "cases needs to be table")

		for i = 1, #p12, 2 do
			if p1 == p12[i] then
				local v2 = p12[i + 1]

				if type(v2) == "function" then
					return v2(p1, unpack(t))
				end

				return v2
			end
		end

		return nil
	end
end