-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local button = require(script.Parent.Parent.interactable.button)
local rounded_frame = require(script.Parent.Parent.util.rounded_frame)
local virtualscroller = require(script.Parent.Parent.util.virtualscroller)
local resizeable_bar = require(script.Parent.resizeable_bar)
local scroll_frame = require(script.Parent.scroll_frame)
local create = vide.create
local source = vide.source
local derive = vide.derive
local indexes = vide.indexes

return function(p1) --[[ Line: 31 | Upvalues: source (copy), derive (copy), scroll_frame (copy), create (copy), resizeable_bar (copy), indexes (copy), theme (copy), virtualscroller (copy), button (copy), rounded_frame (copy) ]]
	local v1 = source({})
	local v2 = source({})
	local v3 = derive(function() --[[ Line: 35 | Upvalues: p1 (copy) ]]
		local t = {}

		for v1, v2 in p1.columns() do
			t[v1] = v2[1]
		end

		return t
	end)

	local function get_size(p1) --[[ get_size | Line: 45 | Upvalues: v2 (copy), source (ref) ]]
		local v1 = v2()[p1 - 1] or source(0)
		local v22 = v2()[p1] or source(1)

		return v22() - v1()
	end

	local t = {}

	t.Size = p1.size or UDim2.new(1, 0, 0, 256)
	function t.CanvasSize() --[[ CanvasSize | Line: 55 ]]
		return UDim2.new(1, 0)
	end
	t[1] = create("UIListLayout")({
		VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
	})
	t[2] = resizeable_bar({
		meaning = v3,
		sizes = v1,
		splits = v2,
		base_splits = p1.base_splits,
		suggested_sizes = p1.suggested_column_sizes
	})
	t[3] = create("Folder")({ indexes(v3, function(p1, p2) --[[ Line: 73 | Upvalues: create (ref), v2 (copy), theme (ref) ]]
			return create("Frame")({
				AutoLocalize = false,
				ZIndex = 100,
				Size = UDim2.new(0, 1, 1, -32),
				Position = function() --[[ Position | Line: 77 | Upvalues: v2 (ref), p2 (copy) ]]
					local v1 = v2()[p2]

					if v1 then
						return UDim2.fromScale(v1(), 0)
					end

					return UDim2.fromScale(0, 0)
				end,
				BackgroundColor3 = theme.bg[-1]
			})
		end) })
	t[4] = virtualscroller({
		size = UDim2.fromScale(1, 0),
		create("UIFlexItem")({
			FlexMode = Enum.UIFlexMode.Grow
		}),
		{
			BackgroundTransparency = 0,
			BackgroundColor3 = theme.bg[0],
			VerticalScrollBarInset = Enum.ScrollBarInset.None
		},
		item_size = 32,
		item = function(p12) --[[ item | Line: 103 | Upvalues: create (ref), theme (ref), indexes (ref), p1 (copy), button (ref), v2 (copy), source (ref) ]]
			return create("Frame")({
				Size = UDim2.new(1, 0, 0, 32),
				AutoLocalize = false,
				BackgroundColor3 = theme.bg[2],
				create("UIListLayout")({
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 0)
				}),
				create("UIStroke")({
					Color = theme.bg[-1]
				}),
				indexes(p1.columns, function(p13, p2) --[[ Line: 120 | Upvalues: button (ref), v2 (ref), source (ref), p1 (ref), p12 (copy), create (ref) ]]
					return button({
						size = function() --[[ size | Line: 122 | Upvalues: p2 (copy), v2 (ref), source (ref) ]]
							local v1 = p2
							local v22 = v2()[v1 - 1] or source(0)
							local v3 = v2()[v1] or source(1)

							return UDim2.new(v3() - v22(), 0, 0, 32)
						end,
						text = function() --[[ text | Line: 127 | Upvalues: p1 (ref), p2 (copy), p12 (ref) ]]
							return p1.read_value(p2, p12() + 1) or ""
						end,
						create("UIListLayout")({
							FillDirection = Enum.FillDirection.Horizontal,
							VerticalAlignment = Enum.VerticalAlignment.Center
						}),
						xalignment = Enum.TextXAlignment.Left,
						corner = false,
						stroke = false,
						code = true,
						activated = function() --[[ activated | Line: 142 | Upvalues: p1 (ref), p2 (copy), p12 (ref) ]]
							p1.on_click(p2, p12() + 2)
						end,
						mouse2 = function() --[[ mouse2 | Line: 146 | Upvalues: p1 (ref), p2 (copy), p12 (ref) ]]
							p1.on_click2(p2, p12() + 2)
						end
					})
				end)
			})
		end,
		max_items = function() --[[ max_items | Line: 156 | Upvalues: p1 (copy) ]]
			return (if p1.columns()[1] == nil then 0 else #p1.columns()[1] or 0) - 1
		end
	})
	t[5] = rounded_frame({
		size = function() --[[ size | Line: 165 ]]
			return UDim2.new(1, 0, 0, 32)
		end,
		color = theme.bg[1],
		p1.below,
		bottomleft = UDim.new(0, 8),
		bottomright = UDim.new(0, 8)
	})
	t[6] = unpack(p1)

	return scroll_frame(t)
end