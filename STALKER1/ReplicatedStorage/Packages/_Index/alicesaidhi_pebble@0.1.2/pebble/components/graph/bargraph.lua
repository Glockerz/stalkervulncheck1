-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local container = require(script.Parent.Parent.util.container)
local create = vide.create
local indexes = vide.indexes
local read = vide.read

return function(p1) --[[ Line: 24 | Upvalues: container (copy), indexes (copy), create (copy), read (copy), theme (copy) ]]
	local v1 = p1.max or (function() --[[ Line: 26 | Upvalues: p1 (copy) ]]
		return math.max(unpack(p1.values()))
	end)

	local function total() --[[ total | Line: 30 | Upvalues: p1 (copy) ]]
		return #p1.values()
	end

	return container({
		Position = p1.position,
		Size = p1.size,
		AnchorPoint = p1.anchorpoint,
		ClipsDescendants = true,
		indexes(p1.values, function(p12, p2) --[[ Line: 42 | Upvalues: create (ref), p1 (copy), read (ref), v1 (copy), theme (ref) ]]
			return create("Frame")({
				AutoLocalize = false,
				Position = function() --[[ Position | Line: 47 | Upvalues: p2 (copy), p1 (ref) ]]
					return UDim2.fromScale((p2 - 1) / #p1.values(), 1)
				end,
				Size = function() --[[ Size | Line: 50 | Upvalues: p1 (ref), p12 (copy), read (ref), v1 (ref) ]]
					return UDim2.fromScale(1 / #p1.values(), p12() / read(v1))
				end,
				AnchorPoint = Vector2.new(0, 1),
				create("UIGradient")({
					Rotation = 90,
					Color = function() --[[ Color | Line: 59 | Upvalues: theme (ref) ]]
						return ColorSequence.new(theme.acc[10](), theme.acc[-3]())
					end
				})
			})
		end),
		unpack(p1)
	})
end