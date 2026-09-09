-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.vide)
local reduced_motion = require(script.Parent.reduced_motion)
local source = vide.source
local spring = vide.spring
local untrack = vide.untrack

return function(p1) --[[ Line: 10 | Upvalues: untrack (copy), reduced_motion (copy), spring (copy) ]]
	local v2 = typeof(untrack(p1))
	local v3 = reduced_motion:consume()
	local v4 = if v2 == "UDim" or (v2 == "UDim2" or v2 == "Vector2") then true else false
	local v5 = spring(p1, 0.1)

	return function() --[[ Line: 20 | Upvalues: v4 (ref), v3 (copy), p1 (copy), v5 (copy) ]]
		if v4 and v3 then
			return p1()
		end

		return v5()
	end
end