-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	resolveDefaultProps = function(p1, p2) --[[ resolveDefaultProps | Line: 14 ]]
		if not p1 or (typeof(p1) ~= "table" or not p1.defaultProps) then
			return p2
		end

		local v1 = table.clone(p2)
		local defaultProps = p1.defaultProps

		for v2, v3 in defaultProps do
			if v1[v2] == nil then
				v1[v2] = defaultProps[v2]
			end
		end

		return v1
	end
}