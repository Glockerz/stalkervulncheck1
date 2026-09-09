-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local container = require(script.Parent.Parent.util.container)
local padding = require(script.Parent.Parent.util.padding)
local shadow = require(script.Parent.Parent.util.shadow)
local divider = require(script.Parent.divider)
local snapping = require(script.Parent.snapping)
local borders = require(script.borders)
local topbar = require(script.topbar)
local create = vide.create
local source = vide.source
local cleanup = vide.cleanup
local changed = vide.changed
local action = vide.action
local spring = vide.spring
local v1 = 100000
local v2 = nil

vide.mount(function() --[[ Line: 43 | Upvalues: v2 (ref), snapping (copy), create (copy) ]]
	v2 = snapping()

	return create("ScreenGui")({
		Name = "docks",
		AutoLocalize = false,
		create("Frame")({
			Size = UDim2.new(0, 16, 1, 0),
			BackgroundTransparency = 1,
			AutoLocalize = false,
			v2.snap_area({})
		})
	})
end, Players.LocalPlayer.PlayerGui)

return function(p1) --[[ Line: 79 | Upvalues: source (copy), v1 (ref), cleanup (copy), UserInputService (copy), GuiService (copy), Players (copy), RunService (copy), create (copy), action (copy), theme (copy), changed (copy), shadow (copy), borders (copy), container (copy), topbar (copy), divider (copy), padding (copy), v2 (ref) ]]
	local v3 = Vector2.new(100, 100):Max(p1.min_size or Vector2.zero)
	local v4 = p1.position or Vector2.new(32, 32)
	local v5 = p1.size or v3 * 1.5
	local v7 = source((math.max(v3.X, v5.X)))
	local v9 = source((math.max(v3.Y, v5.Y)))
	local v10 = source(v4.X)
	local v11 = source(v4.Y)
	local v122 = source(Vector2.zero)
	local v13 = source(false)
	local v14 = source(Vector2.zero)
	local v15 = source(Vector2.zero)
	local v16 = source(false)
	local v17 = source(false)
	local v18 = source(false)
	local v19 = source(false)
	local v20 = source(false)
	local v21 = source()
	local v222 = source(v1 + 1)

	v1 = v1 + 1

	local v23 = source(false)
	local v24 = nil
	local v25 = nil

	cleanup(UserInputService.InputEnded:Connect(function(p1) --[[ Line: 108 | Upvalues: v20 (copy), v13 (copy) ]]
		if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then
			v20(false)
			v13(false)
		end
	end))
	cleanup(UserInputService.InputChanged:Connect(function(p1) --[[ Line: 119 | Upvalues: v20 (copy), UserInputService (ref), GuiService (ref), v17 (copy), v9 (copy), v24 (ref), v3 (copy), v18 (copy), v7 (copy), v16 (copy), v25 (ref), v11 (copy), v19 (copy), v10 (copy) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end

		if not v20() then
			return
		end

		local v1 = UserInputService:GetMouseLocation()
		local v2, v32 = GuiService:GetGuiInset()
		local v4 = v1 + (-v2 - v32)
		local X = v4.X
		local Y = v4.Y

		if v17() then
			v9((math.max(Y - v24.Y, v3.Y)))
		end

		if v18() then
			v7((math.max(X - v24.X, v3.X)))
		end

		if v16() then
			v9((math.max(v25.Y - Y, v3.Y)))
			v11((math.min(Y, v25.Y - v3.Y)))
		end

		if not v19() then
			return
		end

		v7((math.max(v25.X - X, v3.X)))
		v10((math.min(X, v25.X - v3.X)))
	end))
	cleanup(UserInputService.InputBegan:Connect(function(p1) --[[ Line: 140 | Upvalues: v13 (copy), v20 (copy), v24 (ref), v14 (copy), v25 (ref), v15 (copy), Players (ref), RunService (ref), v21 (copy), v222 (copy), v1 (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end

		if not v13() then
			v20(true)
		end

		v24 = v14()
		v25 = v14() + v15()

		local v12

		if Players.LocalPlayer and RunService:IsRunning() then
			v12 = Players.LocalPlayer:WaitForChild("PlayerGui")
		else
			if not (RunService:IsStudio() and RunService:IsRunning()) then
				return
			end

			v12 = game:GetService("CoreGui")
		end

		local v2 = v12:GetGuiObjectsAtPosition(p1.Position.X, p1.Position.Y)

		if #v2 == 0 then
			return
		end

		if v2[1]:IsDescendantOf(v21()) then
			v222(v1 + 1)
			v1 = v1 + 1
		end
	end))
	cleanup(UserInputService.InputChanged:Connect(function(p1) --[[ Line: 164 | Upvalues: v13 (copy), UserInputService (ref), v10 (copy), v122 (copy), v11 (copy) ]]
		if v13() == false then
			return
		end

		if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
			local v1 = UserInputService:GetMouseLocation()

			v10(v1.X + v122().X)
			v11(v1.Y + v122().Y)
		else
			v13(false)
		end
	end))

	local v26 = source(false)
	local v27 = source(UDim2.new())
	local v28 = source(UDim2.new())

	local function radius() --[[ radius | Line: 182 | Upvalues: v26 (copy) ]]
		if v26() then
			return UDim.new()
		end

		return UDim.new(0, 6)
	end

	return create("ScreenGui")({
		Name = p1.title,
		AutoLocalize = false,
		DisplayOrder = v222,
		action(v21),
		create("Frame")({
			AutoLocalize = false,
			Position = function() --[[ Position | Line: 194 | Upvalues: v26 (copy), v28 (copy), v10 (copy), v11 (copy) ]]
				if v26() then
					return v28()
				end

				return UDim2.fromOffset(v10(), v11())
			end,
			Size = function() --[[ Size | Line: 198 | Upvalues: v26 (copy), v7 (copy), v27 (copy), v9 (copy) ]]
				if v26() then
					return UDim2.fromOffset(v7() + 6, v27().Y.Offset)
				end

				return UDim2.fromOffset(v7() + 6, v9() + 6)
			end,
			Active = true,
			BackgroundColor3 = theme.bg[0],
			MouseMoved = function() --[[ MouseMoved | Line: 206 | Upvalues: v20 (copy), UserInputService (ref), GuiService (ref), v4 (ref), v14 (copy), v16 (copy), v19 (copy), v17 (copy), v15 (copy), v18 (copy) ]]
				if v20() then
					return
				end

				local v1 = UserInputService:GetMouseLocation()
				local v2, v3 = GuiService:GetGuiInset()

				v4 = v4 + (-v2 - v3)

				local v42 = v1.X - v14().X
				local v5 = v1.Y - v14().Y

				v16(v5 < 6)
				v19(if v42 < 6 then true else false)
				v17(if v15().Y - 6 < v5 then true else false)
				v18(v15().X - 6 < v42)
			end,
			MouseEnter = function() --[[ MouseEnter | Line: 222 | Upvalues: v23 (copy) ]]
				v23(true)
			end,
			MouseLeave = function() --[[ MouseLeave | Line: 226 | Upvalues: v20 (copy), RunService (ref), v23 (copy) ]]
				if v20() then
					return
				end

				if RunService:IsRunning() ~= false then
					v23(false)
				end
			end,
			changed("AbsolutePosition", v14),
			changed("AbsoluteSize", v15),
			create("UICorner")({
				CornerRadius = radius
			}),
			shadow({}),
			borders({
				resize_range = 6,
				min_size = v3,
				can_resize_top = v16,
				can_resize_bottom = v17,
				can_resize_left = v19,
				can_resize_right = v18,
				resizing = v20
			}),
			container({
				Size = UDim2.fromScale(1, 1),
				create("UIListLayout")({}),
				topbar({
					title = p1.title,
					subtitle = p1.subtitle,
					dragging = v13,
					offset = v122,
					bind_to_close = p1.bind_to_close,
					radius = radius
				}),
				divider({}),
				container({
					Size = UDim2.fromScale(1, 0),
					padding({
						x = UDim.new(0, 8),
						y = UDim.new(0, 8)
					}),
					unpack(p1),
					create("UIFlexItem")({
						FlexMode = Enum.UIFlexMode.Grow
					})
				})
			}),
			v2.snappable({
				dragging = v13,
				snapped = v26,
				position = v28,
				size = v27
			})
		})
	})
end