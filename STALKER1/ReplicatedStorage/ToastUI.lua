-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local t = {}
local v3 = Color3.fromRGB(24, 26, 24)
local v4 = Color3.fromRGB(235, 235, 235)
local t2 = {
	success = {
		icon = "\226\156\147",
		accent = Color3.fromRGB(120, 210, 110)
	},
	info = {
		icon = "\226\128\162",
		accent = Color3.fromRGB(255, 200, 90)
	},
	warning = {
		icon = "!",
		accent = Color3.fromRGB(228, 96, 96)
	}
}

function t.InferType(p1) --[[ InferType | Line: 23 ]]
	local v1 = string.lower((tostring(p1 or "")))

	if v1:find("fail") or (v1:find("couldn") or (v1:find("cannot") or (v1:find("can\'t") or (v1:find("no space") or (v1:find("too many") or (v1:find("expired") or (v1:find("no squadmate") or v1:find("not available")))))))) then
		return "warning"
	end

	if v1:find("accepted") or (v1:find("completed") or (v1:find("shared with") or (v1:find("picked up") or (v1:find("equipped") or (v1:find("\226\130\189") or v1:find("\226\156\147")))))) then
		return "success"
	end

	return "info"
end

local t3 = {}

local function ensureStack(p1) --[[ ensureStack | Line: 38 | Upvalues: t3 (copy), LocalPlayer (copy) ]]
	local v1 = t3[p1]

	if v1 and (v1.gui and v1.gui.Parent) then
		return v1
	end

	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local ScreenGui = Instance.new("ScreenGui")

	ScreenGui.Name = "ToastUI_" .. p1
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.DisplayOrder = 60
	ScreenGui.Parent = PlayerGui

	local t = {
		gui = ScreenGui,
		toasts = {}
	}

	t3[p1] = t

	return t
end

local function targetPosition(p1, p2) --[[ targetPosition | Line: 53 ]]
	if p1 == "bottom-center" then
		return UDim2.new(0.5, 0, 1, -110 - 68 * p2)
	end

	return UDim2.new(1, -16, 0, 200 + 68 * p2)
end

local function reflow(p1, p2) --[[ reflow | Line: 60 | Upvalues: TweenService (copy) ]]
	for i, v in ipairs(p1.toasts) do
		local v1
		local v3 = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local t = {}
		local v4 = i - 1

		v1 = if p2 == "bottom-center" then UDim2.new(0.5, 0, 1, -110 - 68 * v4) else UDim2.new(1, -16, 0, 200 + 68 * v4)
		t.Position = v1
		TweenService:Create(v, v3, t):Play()
	end
end

function t.Show(p1, p2, p3) --[[ Show | Line: 69 | Upvalues: t (copy), t2 (copy), ensureStack (copy), v1 (copy), v2 (copy), v4 (copy), reflow (copy), TweenService (copy), v3 (copy) ]]
	local v22 = if p3 == "bottom-center" then "bottom-center" else "top-right"
	local v42 = t2[if p2 then p2 else t.InferType(p1)] or t2.info
	local v5 = ensureStack(v22)
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromOffset(360, 60)
	Frame.BackgroundColor3 = v42.accent
	Frame.BackgroundTransparency = 0.05
	Frame.BorderSizePixel = 0
	Frame.ZIndex = 60
	Frame.AnchorPoint = v22 == "bottom-center" and Vector2.new(0.5, 1) or Vector2.new(1, 0)
	Frame.Position = v22 == "bottom-center" and UDim2.new(0.5, 0, 1, 140) or UDim2.new(1, 440, 0, 200)
	Frame.Parent = v5.gui

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Frame

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v42.accent
	UIStroke.Thickness = 1.5
	UIStroke.Transparency = 0.25
	UIStroke.Parent = Frame

	local UIScale = Instance.new("UIScale")

	UIScale.Scale = 0.88
	UIScale.Parent = Frame

	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.new(0, 5, 1, 0)
	Frame2.BackgroundColor3 = v42.accent
	Frame2.BorderSizePixel = 0
	Frame2.ZIndex = 61
	Frame2.Parent = Frame

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.fromOffset(42, 60)
	TextLabel.Position = UDim2.fromOffset(8, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 26
	TextLabel.TextColor3 = v42.accent
	TextLabel.Text = v42.icon
	TextLabel.ZIndex = 61
	TextLabel.Parent = Frame

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(54, 0)
	TextLabel2.Size = UDim2.new(1, -66, 1, 0)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v2
	TextLabel2.TextSize = 18
	TextLabel2.TextColor3 = v4
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextWrapped = true
	TextLabel2.Text = tostring(p1)
	TextLabel2.ZIndex = 61
	TextLabel2.Parent = Frame
	table.insert(v5.toasts, 1, Frame)
	reflow(v5, v22)
	TweenService:Create(UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Scale = 1
	}):Play()
	TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
		BackgroundColor3 = v3
	}):Play()
	task.delay(6, function() --[[ Line: 129 | Upvalues: Frame (copy), v5 (copy), reflow (ref), v22 (ref), TweenService (ref), UIStroke (copy), Frame2 (copy), TextLabel (copy), TextLabel2 (copy) ]]
		if not Frame.Parent then
			return
		end

		for i, v in ipairs(v5.toasts) do
			if v == Frame then
				table.remove(v5.toasts, i)

				break
			end
		end

		reflow(v5, v22)

		local v1 = TweenInfo.new(0.35, Enum.EasingStyle.Quad)

		TweenService:Create(Frame, v1, {
			BackgroundTransparency = 1
		}):Play()
		TweenService:Create(UIStroke, v1, {
			Transparency = 1
		}):Play()
		TweenService:Create(Frame2, v1, {
			BackgroundTransparency = 1
		}):Play()
		TweenService:Create(TextLabel, v1, {
			TextTransparency = 1
		}):Play()
		TweenService:Create(TextLabel2, v1, {
			TextTransparency = 1
		}):Play()
		task.delay(0.45, function() --[[ Line: 139 | Upvalues: Frame (ref) ]]
			if not Frame then
				return
			end

			Frame:Destroy()
		end)
	end)
end

return t