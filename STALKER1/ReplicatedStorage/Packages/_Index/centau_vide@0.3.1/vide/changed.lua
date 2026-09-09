-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2

if game then
	v1 = require(script.Parent.action)()
	v2 = require(script.Parent.cleanup)

	return function(p13, p23) --[[ changed | Line: 6 | Upvalues: v1 (copy), v2 (copy) ]]
		return v1(function(p1) --[[ Line: 7 | Upvalues: p13 (copy), p23 (copy), v2 (ref) ]]
			local v1 = p1:GetPropertyChangedSignal(p13):Connect(function() --[[ Line: 8 | Upvalues: p23 (ref), p1 (copy), p13 (ref) ]]
				p23(p1[p13])
			end)

			v2(function() --[[ Line: 12 | Upvalues: v1 (copy) ]]
				v1:Disconnect()
			end)
			p23(p1[p13])
		end)
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.action)()
v2 = require(script.Parent.cleanup)

return function(p13, p23) --[[ changed | Line: 6 | Upvalues: v1 (copy), v2 (copy) ]]
	return v1(function(p1) --[[ Line: 7 | Upvalues: p13 (copy), p23 (copy), v2 (ref) ]]
		local v1 = p1:GetPropertyChangedSignal(p13):Connect(function() --[[ Line: 8 | Upvalues: p23 (ref), p1 (copy), p13 (ref) ]]
			p23(p1[p13])
		end)

		v2(function() --[[ Line: 12 | Upvalues: v1 (copy) ]]
			v1:Disconnect()
		end)
		p23(p1[p13])
	end)
end