-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local container = require(script.Parent.container)
local create = vide.create
local read = vide.read

return function(p1) --[[ rounded_frame | Line: 33 | Upvalues: create (copy), read (copy), container (copy) ]]
	local v1 = p1.topleft or UDim.new()
	local v2 = p1.topright or UDim.new()
	local v3 = p1.bottomleft or UDim.new()
	local v4 = p1.bottomright or UDim.new()

	local function corner(p12, p2, p3, p4) --[[ corner | Line: 39 | Upvalues: create (ref), read (ref), p1 (copy) ]]
		return create("Frame")({
			Name = p12,
			AutoLocalize = false,
			Size = function() --[[ Size | Line: 44 | Upvalues: read (ref), p4 (copy) ]]
				return UDim2.new(read(p4), read(p4))
			end,
			Position = p2,
			AnchorPoint = p3,
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			create("Frame")({
				Name = "TopLeft",
				AutoLocalize = false,
				Size = UDim2.fromScale(2, 2),
				Position = UDim2.fromScale(-p3.X, -p3.Y),
				BackgroundColor3 = p1.color,
				ClipsDescendants = true,
				create("UICorner")({
					CornerRadius = p4
				})
			})
		})
	end

	return create("Frame")({
		Name = p1.name or "RoundedFrame",
		Size = p1.size,
		Position = p1.position,
		AnchorPoint = p1.anchor_point,
		BackgroundColor3 = p1.color,
		BackgroundTransparency = 1,
		create("Folder")({
			Name = "Corner",
			corner("TopLeft", UDim2.fromScale(0, 0), Vector2.new(0, 0), v1),
			corner("TopRight", UDim2.fromScale(1, 0), Vector2.new(1, 0), v2),
			corner("BottomLeft", UDim2.fromScale(0, 1), Vector2.new(0, 1), v3),
			corner("BottomRight", UDim2.fromScale(1, 1), Vector2.new(1, 1), v4),
			create("Frame")({
				AutoLocalize = false,
				Name = "FrameLeft",
				Size = function() --[[ Size | Line: 95 | Upvalues: read (ref), v1 (copy), v3 (copy) ]]
					return UDim2.new(0.5, 0, 1 - read(v1).Scale - read(v3).Scale, -(read(v1).Offset + read(v3).Offset))
				end,
				Position = function() --[[ Position | Line: 103 | Upvalues: read (ref), v1 (copy), v3 (copy) ]]
					return UDim2.new(0, 0, 0.5 + read(v1).Scale / 2 - read(v3).Scale / 2, 0 + read(v1).Offset / 2 - read(v3).Offset / 2)
				end,
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = p1.color
			}),
			create("Frame")({
				Name = "FrameRight",
				AutoLocalize = false,
				Size = function() --[[ Size | Line: 120 | Upvalues: read (ref), v2 (copy), v4 (copy) ]]
					return UDim2.new(0.5, 0, 1 - read(v2).Scale - read(v4).Scale, -(read(v2).Offset + read(v4).Offset))
				end,
				Position = function() --[[ Position | Line: 128 | Upvalues: read (ref), v2 (copy), v4 (copy) ]]
					return UDim2.new(1, 0, 0.5 + read(v2).Scale / 2 - read(v4).Scale / 2, 0 + read(v2).Offset / 2 - read(v4).Offset / 2)
				end,
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = p1.color
			}),
			create("Frame")({
				Name = "FrameTop",
				AutoLocalize = false,
				Size = function() --[[ Size | Line: 145 | Upvalues: read (ref), v1 (copy), v2 (copy) ]]
					return UDim2.new(1 - read(v1).Scale - read(v2).Scale, -(read(v1).Offset + read(v2).Offset), 0.5, 0)
				end,
				Position = function() --[[ Position | Line: 153 | Upvalues: read (ref), v1 (copy), v2 (copy) ]]
					return UDim2.new(0.5 + read(v1).Scale / 2 - read(v2).Scale / 2, 0 + read(v1).Offset / 2 - read(v2).Offset / 2, 0, 0)
				end,
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = p1.color
			}),
			create("Frame")({
				Name = "FrameBottom",
				AutoLocalize = false,
				Size = function() --[[ Size | Line: 170 | Upvalues: read (ref), v3 (copy), v4 (copy) ]]
					return UDim2.new(1 - read(v3).Scale - read(v4).Scale, -(read(v3).Offset + read(v4).Offset), 0.5, 0)
				end,
				Position = function() --[[ Position | Line: 178 | Upvalues: read (ref), v3 (copy), v4 (copy) ]]
					return UDim2.new(0.5 + read(v3).Scale / 2 - read(v4).Scale / 2, 0 + read(v3).Offset / 2 - read(v4).Offset / 2, 1, 0)
				end,
				AnchorPoint = Vector2.new(0.5, 1),
				BackgroundColor3 = p1.color
			})
		}),
		container({ unpack(p1) }),
		p1.layout
	})
end