-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide)
local create = vide.create
local indexes = vide.indexes
local derive = vide.derive

return function(p1) --[[ Line: 12 | Upvalues: derive (copy), create (copy), indexes (copy) ]]
	local v1 = derive(function() --[[ Line: 14 | Upvalues: p1 (copy) ]]
		local sum = 0

		for v1, v2 in p1.values() do
			sum = sum + v2.value
		end

		return sum
	end)

	return create("Frame")({
		Name = "Graph",
		Size = UDim2.new(1, 0, 0, 32),
		indexes(p1.values, function(p12, p2) --[[ Line: 26 | Upvalues: create (ref), v1 (copy), p1 (copy) ]]
			return create("Frame")({
				Size = function() --[[ Size | Line: 29 | Upvalues: p12 (copy), v1 (ref) ]]
					return UDim2.fromScale(p12().value / v1(), 1)
				end,
				BackgroundColor3 = function() --[[ BackgroundColor3 | Line: 33 | Upvalues: p12 (copy) ]]
					return p12().color
				end,
				MouseEnter = function() --[[ MouseEnter | Line: 35 | Upvalues: p1 (ref), p2 (copy) ]]
					p1.selected(p2)
				end
			})
		end),
		create("UIListLayout")({
			FillDirection = Enum.FillDirection.Horizontal
		})
	})
end