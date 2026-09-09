-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local container = require(script.Parent.Parent.util.container)
local create = vide.create
local source = vide.source
local action = vide.action
local effect = vide.effect
local read = vide.read

return function(p1) --[[ Line: 25 | Upvalues: source (copy), effect (copy), read (copy), container (copy), create (copy), theme (copy), action (copy) ]]
	local v1 = source()

	effect(function() --[[ Line: 29 | Upvalues: v1 (copy), p1 (copy), read (ref) ]]
		if not v1() then
			return
		end

		local v12 = v1()
		local v2 = table.create(50)
		local v3 = #p1.values()
		local v4 = read(p1.max) or 100
		local v5 = read(p1.min) or 0
		local v6 = math.abs(v4 - v5)

		for v7, v8 in p1.values() do
			local v9 = Path2DControlPoint.new

			table.insert(v2, v9(UDim2.fromScale((v7 - 1) / (v3 - 1), 1 - (v8 - v5) / v6)))
		end

		v12:SetControlPoints(v2)
	end)

	return container({
		Position = p1.position,
		Size = p1.size,
		AnchorPoint = p1.anchorpoint,
		ClipsDescendants = true,
		create("Path2D")({
			Thickness = 2,
			Color3 = theme.acc[3],
			action(v1)
		}),
		unpack(p1)
	})
end