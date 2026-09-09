-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	new = function(p1) --[[ new | Line: 15 ]]
		local v1 = newproxy(true)
		local v2 = if p1 then ("Symbol(%s)"):format(p1) else "Symbol()"

		getmetatable(v1).__tostring = function() --[[ Line: 23 | Upvalues: v2 (ref) ]]
			return v2
		end

		return v1
	end
}