-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1

if game then
	v1 = require(script.Parent.switch)

	return function(p13, p23, p33) --[[ show | Line: 5 | Upvalues: v1 (copy) ]]
		return v1(function() --[[ truthy | Line: 6 | Upvalues: p13 (copy) ]]
			return p13() and true or false
		end)({
			[true] = p23,
			[false] = p33
		})
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.switch)

return function(p13, p23, p33) --[[ show | Line: 5 | Upvalues: v1 (copy) ]]
	return v1(function() --[[ truthy | Line: 6 | Upvalues: p13 (copy) ]]
		return p13() and true or false
	end)({
		[true] = p23,
		[false] = p33
	})
end