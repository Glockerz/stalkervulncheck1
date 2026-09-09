-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ Line: 16 ]]
	local t = {}

	t.__index = t
	function t.__tostring(p12) --[[ Line: 19 | Upvalues: p1 (copy) ]]
		return getmetatable(p1).__tostring(p12)
	end

	local t2 = {}

	function t.new(...) --[[ Line: 25 | Upvalues: p3 (copy), t (copy) ]]
		local t2 = {}

		p3(t2, ...)

		return setmetatable(t2, t)
	end

	local v1 = getmetatable(p1)

	if typeof(v1) == "table" and getmetatable(p1).__call then
		function t2.__call(p1, ...) --[[ Line: 32 | Upvalues: t (copy) ]]
			return t.new(...)
		end
	end

	t2.__index = p1
	function t2.__tostring(p12) --[[ Line: 38 | Upvalues: t (copy), p2 (copy), p1 (copy) ]]
		if p12 == t then
			return tostring(p2)
		end

		return getmetatable(p1).__tostring(p12)
	end
	setmetatable(t, t2)

	return t
end