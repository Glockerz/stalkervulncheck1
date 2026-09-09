-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local oklab = require(script.Parent.Parent.libraries.oklab)

return function(p1, p2, p3) --[[ oklch | Line: 17 | Upvalues: oklab (copy) ]]
	return oklab.linear_srgb_to_color3(oklab.oklab_to_linear_srgb(oklab.oklch_to_oklab((Vector3.new(math.clamp(p1, 0, 1), p2, p3)))), true)
end