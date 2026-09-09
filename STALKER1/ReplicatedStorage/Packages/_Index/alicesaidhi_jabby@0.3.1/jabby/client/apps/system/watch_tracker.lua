-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble)
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide)

require(script.Parent.Parent.Parent.Parent.modules.types)

local tooltip = require(script.Parent.Parent.Parent.components.tooltip)
local virtualscroller_horizontal = require(script.Parent.Parent.Parent.components.virtualscroller_horizontal)
local create = vide.create
local source = vide.source

return function(p1) --[[ Line: 26 | Upvalues: source (copy), pebble (copy), virtualscroller_horizontal (copy), create (copy), tooltip (copy) ]]
	local recording = p1.recording
	local watching_frame = p1.watching_frame
	local per_frame_data = p1.per_frame_data
	local changes = p1.changes

	local function sheet_changes() --[[ sheet_changes | Line: 33 | Upvalues: changes (copy) ]]
		local v1 = changes()
		local t = {}
		local t2 = {}

		t2[1] = "type"
		t2[2] = unpack(v1.types)

		local t3 = {}

		t3[1] = "entity"
		t3[2] = unpack(v1.entities)

		local t4 = {}

		t4[1] = "component"
		t4[2] = unpack(v1.component)

		local t5 = {}

		t5[1] = "value"
		t5[2] = unpack(v1.values)
		t[1] = t2
		t[2] = t3
		t[3] = t4
		t[4] = t5

		return t
	end

	local function max() --[[ max | Line: 44 | Upvalues: per_frame_data (copy) ]]
		return math.max(1, unpack(per_frame_data()))
	end

	local function total_changes() --[[ total_changes | Line: 48 | Upvalues: per_frame_data (copy) ]]
		local sum = 0

		for v1, v2 in per_frame_data() do
			sum = sum + v2
		end

		return sum
	end

	local v1 = source(false)

	return pebble.list({
		justifycontent = Enum.UIFlexAlignment.SpaceEvenly,
		spacing = UDim.new(0, 4),
		pebble.pane({ virtualscroller_horizontal({
				item_size = 6,
				item = function(p1) --[[ item | Line: 65 | Upvalues: per_frame_data (copy), create (ref), v1 (copy), pebble (ref), watching_frame (copy) ]]
					local function value() --[[ value | Line: 66 | Upvalues: per_frame_data (ref), p1 (copy) ]]
						return per_frame_data()[p1()] or 0
					end

					return create("TextButton")({
						Size = function() --[[ Size | Line: 71 ]]
							return UDim2.new(0, 6, 1, 0)
						end,
						BackgroundTransparency = function() --[[ BackgroundTransparency | Line: 74 | Upvalues: v1 (ref), p1 (copy) ]]
							if v1() == p1() then
								return 0.5
							end

							return 1
						end,
						BackgroundColor3 = pebble.theme.bg[10],
						MouseEnter = function() --[[ MouseEnter | Line: 79 | Upvalues: v1 (ref), p1 (copy) ]]
							v1(p1())
						end,
						MouseLeave = function() --[[ MouseLeave | Line: 82 | Upvalues: v1 (ref), p1 (copy) ]]
							if v1() == p1() then
								v1(false)
							end
						end,
						Activated = function() --[[ Activated | Line: 86 | Upvalues: watching_frame (ref), p1 (copy) ]]
							watching_frame(p1())
						end,
						AutoLocalize = false,
						create("Frame")({
							Size = function() --[[ Size | Line: 92 | Upvalues: per_frame_data (ref), p1 (copy) ]]
								local fromScale = UDim2.fromScale
								local v1 = per_frame_data()[p1()] or 0

								return fromScale(1, v1 / math.max(1, unpack(per_frame_data())))
							end,
							Position = UDim2.fromScale(1, 1),
							AnchorPoint = Vector2.new(1, 1),
							BackgroundColor3 = function() --[[ BackgroundColor3 | Line: 97 | Upvalues: watching_frame (ref), p1 (copy), pebble (ref), v1 (ref) ]]
								if watching_frame() == p1() then
									return pebble.theme.acc[20]()
								end

								if v1() == p1() then
									return pebble.theme.acc[5]()
								end

								return pebble.theme.acc[0]()
							end
						})
					})
				end,
				max_items = function() --[[ max_items | Line: 108 | Upvalues: per_frame_data (copy) ]]
					return #per_frame_data()
				end,
				create("UIStroke")({
					Color = pebble.theme.bg[-3]
				}),
				{
					ScrollBarThickness = 6,
					Size = UDim2.new(1, 0, 0, 56),
					HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
					BackgroundColor3 = pebble.theme.bg[-1],
					CanvasPosition = function() --[[ CanvasPosition | Line: 120 | Upvalues: per_frame_data (copy) ]]
						per_frame_data()

						return Vector2.new(table.maxn(per_frame_data()) * 6)
					end
				}
			}), pebble.typography({
				text = function() --[[ text | Line: 128 | Upvalues: per_frame_data (copy) ]]
					local v1 = #per_frame_data()
					local sum = 0

					for v3, v4 in per_frame_data() do
						sum = sum + v4
					end

					return ("Recorded %* frames and tracked %* changes"):format(v1, sum)
				end
			}), pebble.typography({
				text = function() --[[ text | Line: 134 | Upvalues: watching_frame (copy) ]]
					return ("Currently viewing frame %*"):format((watching_frame()))
				end
			}) }),
		tooltip({
			transparency = 0,
			visible = function() --[[ visible | Line: 142 | Upvalues: v1 (copy) ]]
				return v1() ~= false
			end,
			pebble.typography({
				wrapped = true,
				automaticsize = Enum.AutomaticSize.XY,
				text = function() --[[ text | Line: 149 | Upvalues: v1 (copy), per_frame_data (copy) ]]
					return ("Frame: #%*\nChanges: %*"):format(v1(), per_frame_data()[v1()] or 0)
				end,
				xalignment = Enum.TextXAlignment.Left
			})
		}),
		pebble.container({
			Size = UDim2.fromScale(1, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = pebble.theme.bg[1],
			BackgroundTransparency = 0,
			create("UIListLayout")({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
				VerticalFlex = Enum.UIFlexAlignment.Fill,
				Padding = UDim.new(0, 8)
			}),
			pebble.padding({
				x = UDim.new(0, 4),
				y = UDim.new(0, 4)
			}),
			pebble.button({
				size = UDim2.new(0, 80, 0, 30),
				automaticsize = Enum.AutomaticSize.X,
				text = function() --[[ text | Line: 180 | Upvalues: recording (copy) ]]
					if recording() then
						return "Pause"
					end

					return "Record"
				end,
				activated = function() --[[ activated | Line: 184 | Upvalues: recording (copy) ]]
					recording(not recording())
				end
			}),
			pebble.container({
				Size = UDim2.fromScale(0, 0),
				create("UIFlexItem")({
					FlexMode = Enum.UIFlexMode.Fill
				}),
				pebble.textfield({
					placeholder = "frame",
					size = UDim2.new(1, 0, 1, 0),
					text = tostring(watching_frame()),
					enter = function(p1) --[[ enter | Line: 201 | Upvalues: watching_frame (copy) ]]
						if tonumber(p1) ~= nil then
							watching_frame((tonumber(p1)))
						end
					end
				})
			})
		}),
		pebble.container({
			Size = UDim2.fromScale(1, 1),
			create("UIFlexItem")({
				FlexMode = Enum.UIFlexMode.Fill
			}),
			pebble.tablesheet({
				size = UDim2.fromScale(1, 1),
				column_sizes = source({ 100, 80, 100, 200 }),
				read_value = function(p1, p2) --[[ read_value | Line: 221 | Upvalues: sheet_changes (copy) ]]
					local v1 = sheet_changes()[p1][p2]

					if v1 == false then
						return ""
					end

					return v1
				end,
				on_click = function() --[[ on_click | Line: 226 ]] end,
				on_click2 = function() --[[ on_click2 | Line: 227 ]] end,
				columns = sheet_changes
			})
		})
	})
end