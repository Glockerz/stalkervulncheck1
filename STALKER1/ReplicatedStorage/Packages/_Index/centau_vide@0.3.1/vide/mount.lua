-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2

if game then
	v1 = require(script.Parent.root)
	v2 = require(script.Parent.apply)

	return function(p13, p23) --[[ mount | Line: 6 | Upvalues: v1 (copy), v2 (copy) ]]
		return v1(function() --[[ Line: 7 | Upvalues: p13 (copy), p23 (copy), v2 (ref) ]]
			local v1 = p13()

			if not p23 then
				return
			end

			v2(p23, { v1 })
		end)
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.root)
v2 = require(script.Parent.apply)

return function(p13, p23) --[[ mount | Line: 6 | Upvalues: v1 (copy), v2 (copy) ]]
	return v1(function() --[[ Line: 7 | Upvalues: p13 (copy), p23 (copy), v2 (ref) ]]
		local v1 = p13()

		if not p23 then
			return
		end

		v2(p23, { v1 })
	end)
end