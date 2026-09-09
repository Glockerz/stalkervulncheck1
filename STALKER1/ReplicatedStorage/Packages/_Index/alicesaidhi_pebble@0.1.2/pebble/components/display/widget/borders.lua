-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.Parent.util.theme)
local container = require(script.Parent.Parent.Parent.util.container)
local create = vide.create
local source = vide.source
local spring = vide.spring
local changed = vide.changed
local cleanup = vide.cleanup

local function xpos(p1) --[[ xpos | Line: 29 ]]
	return function() --[[ Line: 30 | Upvalues: p1 (copy) ]]
		return Vector2.new(p1(), 0)
	end
end

local function ypos(p1) --[[ ypos | Line: 35 ]]
	return function() --[[ Line: 36 | Upvalues: p1 (copy) ]]
		return Vector2.new(0, p1())
	end
end

return function(p1) --[[ Line: 41 | Upvalues: source (copy), theme (copy), cleanup (copy), RunService (copy), UserInputService (copy), GuiService (copy), changed (copy), container (copy), spring (copy), create (copy) ]]
	local resize_range = p1.resize_range
	local min_size = p1.min_size
	local can_resize_left = p1.can_resize_left
	local can_resize_right = p1.can_resize_right
	local can_resize_bottom = p1.can_resize_bottom
	local can_resize_top = p1.can_resize_top
	local resizing = p1.resizing
	local v1 = source(Vector2.new(1, 1))
	local v2 = source(Vector2.zero)
	local v3 = theme.acc[8]
	local v4 = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.25, 1),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(0.75, 1),
		NumberSequenceKeypoint.new(1, 1)
	})
	local v5 = source(0)
	local v6 = source(0)

	cleanup(RunService.Heartbeat:Connect(function() --[[ Line: 67 | Upvalues: UserInputService (ref), GuiService (ref), min_size (copy), v1 (copy), resizing (copy), v5 (copy), v6 (copy) ]]
		local v12 = UserInputService:GetMouseLocation()
		local v2, v3 = GuiService:GetGuiInset()
		local v4 = v12 + (-v2 - v3)

		if min_size.X ~= v1().X or not resizing() then
			v5(v4.X)
		end

		if min_size.Y == v1().Y and resizing() then
			return
		end

		v6(v4.Y)
	end))
	cleanup(RunService.RenderStepped:Connect(function() --[[ Line: 76 | Upvalues: UserInputService (ref), GuiService (ref), resizing (copy), v2 (copy), v1 (copy), resize_range (copy), can_resize_top (copy), can_resize_left (copy), can_resize_bottom (copy), can_resize_right (copy) ]]
		local v12 = UserInputService:GetMouseLocation()
		local v22, v3 = GuiService:GetGuiInset()
		local v4 = v12 + (-v22 - v3)
		local X = v4.X
		local Y = v4.Y

		if resizing() then
			return
		end

		local X2 = v2().X
		local Y2 = v2().Y
		local v5 = X2 + v1().X
		local v6 = Y2 + v1().Y
		local v7 = v2() - Vector2.new(resize_range, resize_range)
		local v8 = v2() + v1() + Vector2.new(resize_range, resize_range)
		local v9 = if v7.X < X and (v7.Y < Y and X < v8.X) then if Y < v8.Y then true else false else false

		can_resize_top(if Y2 - resize_range < Y then if Y < Y2 then v9 else false else false)
		can_resize_left(if X < X2 + resize_range then if X2 - resize_range < X then v9 else false else false)
		can_resize_bottom(if Y < v6 + resize_range then if v6 - resize_range < Y then v9 else false else false)
		can_resize_right(if X < v5 + resize_range then if v5 - resize_range < X then v9 else false else false)
	end))

	local t = {}
	local v7 = changed("AbsoluteSize", function(p1) --[[ Line: 103 | Upvalues: v1 (copy) ]]
		if p1.Magnitude ~= 0 then
			v1(p1)
		end
	end)
	local v8 = changed("AbsolutePosition", v2)
	local t2 = {
		Name = "Left",
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.new(0, 4, 1, 8),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundColor3 = v3,
		BackgroundTransparency = spring(function() --[[ Line: 119 | Upvalues: can_resize_left (copy) ]]
			if can_resize_left() then
				return 0
			end

			return 1
		end, 0.2),
		ZIndex = 1000
	}
	local v10 = create("UIGradient")
	local t3 = {
		Rotation = 90,
		Transparency = v4
	}
	local v11 = spring(function() --[[ Line: 130 | Upvalues: v6 (copy), v2 (copy), v1 (copy) ]]
		return (v6() - v2().Y - v1().Y / 2) / v1().Y
	end, 0.1)

	function t3.Offset() --[[ Line: 36 | Upvalues: v11 (copy) ]]
		return Vector2.new(0, v11())
	end
	t2[1] = v10(t3)
	t2[2] = create("UICorner")({
		CornerRadius = UDim.new(0, 4)
	})

	local v12 = container(t2)
	local t4 = {
		Name = "Right",
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.new(0, 4, 1, 8),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = v3,
		BackgroundTransparency = spring(function() --[[ Line: 150 | Upvalues: can_resize_right (copy) ]]
			if can_resize_right() then
				return 0
			end

			return 1
		end, 0.2),
		ZIndex = 1000
	}
	local v14 = create("UIGradient")
	local t5 = {
		Rotation = 90,
		Transparency = v4
	}
	local v15 = spring(function() --[[ Line: 161 | Upvalues: v6 (copy), v2 (copy), v1 (copy) ]]
		return (v6() - v2().Y - v1().Y / 2) / v1().Y
	end, 0.1)

	function t5.Offset() --[[ Line: 36 | Upvalues: v15 (copy) ]]
		return Vector2.new(0, v15())
	end
	t4[1] = v14(t5)
	t4[2] = create("UICorner")({
		CornerRadius = UDim.new(0, 4)
	})

	local v16 = container(t4)
	local t6 = {
		Name = "Bottom",
		Position = UDim2.fromScale(0.5, 1),
		Size = UDim2.new(1, 8, 0, 4),
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = v3,
		BackgroundTransparency = spring(function() --[[ Line: 181 | Upvalues: can_resize_bottom (copy) ]]
			if can_resize_bottom() then
				return 0
			end

			return 1
		end, 0.2),
		ZIndex = 1000
	}
	local v18 = create("UIGradient")
	local t7 = {
		Transparency = v4
	}
	local v19 = spring(function() --[[ Line: 190 | Upvalues: v5 (copy), v2 (copy), v1 (copy) ]]
		return (v5() - v2().X - v1().X / 2) / v1().X
	end, 0.1)

	function t7.Offset() --[[ Line: 30 | Upvalues: v19 (copy) ]]
		return Vector2.new(v19(), 0)
	end
	t6[1] = v18(t7)
	t6[2] = create("UICorner")({
		CornerRadius = UDim.new(0, 4)
	})

	local v20 = container(t6)
	local t8 = {
		Name = "Top",
		Position = UDim2.fromScale(0.5, 0),
		Size = UDim2.new(1, 8, 0, 4),
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundColor3 = v3,
		BackgroundTransparency = spring(function() --[[ Line: 210 | Upvalues: can_resize_top (copy) ]]
			if can_resize_top() then
				return 0
			end

			return 1
		end, 0.2),
		ZIndex = 1000
	}
	local v22 = create("UIGradient")
	local t9 = {
		Transparency = v4
	}
	local v23 = spring(function() --[[ Line: 219 | Upvalues: v5 (copy), v2 (copy), v1 (copy) ]]
		return (v5() - v2().X - v1().X / 2) / v1().X
	end, 0.1)

	function t9.Offset() --[[ Line: 30 | Upvalues: v23 (copy) ]]
		return Vector2.new(v23(), 0)
	end
	t8[1] = v22(t9)
	t8[2] = create("UICorner")({
		CornerRadius = UDim.new(0, 4)
	})
	t[1] = v7
	t[2] = v8
	t[3] = v12
	t[4] = v16
	t[5] = v20
	t[6] = container(t8)

	return t
end