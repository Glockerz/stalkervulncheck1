-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local container = require(script.Parent.Parent.util.container)
local create = vide.create
local source = vide.source
local action = vide.action
local effect = vide.effect

return function(p1) --[[ Line: 23 | Upvalues: source (copy), effect (copy), container (copy), create (copy), theme (copy), action (copy) ]]
	local v1 = source()

	effect(function() --[[ Line: 27 | Upvalues: v1 (copy), p1 (copy) ]]
		if v1() then
			v1():SetControlPoints(p1.values())
		end
	end)

	return container({
		Position = p1.position,
		Size = p1.size,
		AnchorPoint = p1.anchorpoint,
		create("Path2D")({
			Thickness = 2,
			Color3 = theme.acc[3],
			action(v1)
		}),
		unpack(p1)
	})
end