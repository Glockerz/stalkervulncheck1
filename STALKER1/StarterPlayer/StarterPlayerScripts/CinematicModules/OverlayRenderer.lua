-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CinematicCameraConfig = require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"))
local t = {}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local t2 = {}
local t3 = {}
local v15 = nil
local t4 = {}
local t5 = {}
local t6 = {
	off = nil,
	["16:9"] = 1.7777777777777777,
	["2.35:1"] = 2.35,
	["2.39:1"] = 2.39
}

local function buildThirds(p1) --[[ buildThirds | Line: 42 ]]
	local ThirdsGrid = Instance.new("Frame")

	ThirdsGrid.Name = "ThirdsGrid"
	ThirdsGrid.Size = UDim2.fromScale(1, 1)
	ThirdsGrid.BackgroundTransparency = 1
	ThirdsGrid.Parent = p1

	local function line(p1, p2) --[[ line | Line: 49 | Upvalues: ThirdsGrid (copy) ]]
		local Frame = Instance.new("Frame")

		Frame.Position = p1
		Frame.Size = p2
		Frame.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
		Frame.BackgroundTransparency = 0.5
		Frame.BorderSizePixel = 0
		Frame.Parent = ThirdsGrid
	end

	local v1 = UDim2.new(0, 0, 0.3333, 0)
	local v2 = UDim2.new(1, 0, 0, 1)
	local Frame = Instance.new("Frame")

	Frame.Position = v1
	Frame.Size = v2
	Frame.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
	Frame.BackgroundTransparency = 0.5
	Frame.BorderSizePixel = 0
	Frame.Parent = ThirdsGrid

	local v3 = UDim2.new(0, 0, 0.6667, 0)
	local v4 = UDim2.new(1, 0, 0, 1)
	local Frame2 = Instance.new("Frame")

	Frame2.Position = v3
	Frame2.Size = v4
	Frame2.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
	Frame2.BackgroundTransparency = 0.5
	Frame2.BorderSizePixel = 0
	Frame2.Parent = ThirdsGrid

	local v5 = UDim2.new(0.3333, 0, 0, 0)
	local v6 = UDim2.new(0, 1, 1, 0)
	local Frame3 = Instance.new("Frame")

	Frame3.Position = v5
	Frame3.Size = v6
	Frame3.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
	Frame3.BackgroundTransparency = 0.5
	Frame3.BorderSizePixel = 0
	Frame3.Parent = ThirdsGrid

	local v7 = UDim2.new(0.6667, 0, 0, 0)
	local v8 = UDim2.new(0, 1, 1, 0)
	local Frame4 = Instance.new("Frame")

	Frame4.Position = v7
	Frame4.Size = v8
	Frame4.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
	Frame4.BackgroundTransparency = 0.5
	Frame4.BorderSizePixel = 0
	Frame4.Parent = ThirdsGrid

	return ThirdsGrid
end

local function buildCenterDot(p1) --[[ buildCenterDot | Line: 65 ]]
	local CenterDot = Instance.new("Frame")

	CenterDot.Name = "CenterDot"
	CenterDot.AnchorPoint = Vector2.new(0.5, 0.5)
	CenterDot.Position = UDim2.fromScale(0.5, 0.5)
	CenterDot.Size = UDim2.fromOffset(6, 6)
	CenterDot.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
	CenterDot.BackgroundTransparency = 0.3
	CenterDot.BorderSizePixel = 0
	CenterDot.Parent = p1

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = CenterDot

	return CenterDot
end

local function buildInfo(p1) --[[ buildInfo | Line: 81 ]]
	local InfoReadout = Instance.new("TextLabel")

	InfoReadout.Name = "InfoReadout"
	InfoReadout.AnchorPoint = Vector2.new(0.5, 1)
	InfoReadout.Position = UDim2.new(0.5, 0, 1, -46)
	InfoReadout.Size = UDim2.new(0, 720, 0, 40)
	InfoReadout.BackgroundTransparency = 1
	InfoReadout.Font = Enum.Font.Code
	InfoReadout.TextSize = 13
	InfoReadout.TextColor3 = Color3.fromRGB(255, 200, 90)
	InfoReadout.TextXAlignment = Enum.TextXAlignment.Center
	InfoReadout.TextYAlignment = Enum.TextYAlignment.Bottom
	InfoReadout.Text = ""
	InfoReadout.Parent = p1

	return InfoReadout
end

local function buildLetterboxBars(p1) --[[ buildLetterboxBars | Line: 101 ]]
	local function bar(p1) --[[ bar | Line: 102 | Upvalues: p1 (copy) ]]
		local Frame = Instance.new("Frame")

		Frame.Name = p1
		Frame.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
		Frame.BorderSizePixel = 0
		Frame.Visible = false
		Frame.Parent = p1

		return Frame
	end

	local LetterboxTop = Instance.new("Frame")

	LetterboxTop.Name = "LetterboxTop"
	LetterboxTop.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	LetterboxTop.BorderSizePixel = 0
	LetterboxTop.Visible = false
	LetterboxTop.Parent = p1

	local LetterboxBottom = Instance.new("Frame")

	LetterboxBottom.Name = "LetterboxBottom"
	LetterboxBottom.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	LetterboxBottom.BorderSizePixel = 0
	LetterboxBottom.Visible = false
	LetterboxBottom.Parent = p1

	local LetterboxLeft = Instance.new("Frame")

	LetterboxLeft.Name = "LetterboxLeft"
	LetterboxLeft.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	LetterboxLeft.BorderSizePixel = 0
	LetterboxLeft.Visible = false
	LetterboxLeft.Parent = p1

	local LetterboxRight = Instance.new("Frame")

	LetterboxRight.Name = "LetterboxRight"
	LetterboxRight.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	LetterboxRight.BorderSizePixel = 0
	LetterboxRight.Visible = false
	LetterboxRight.Parent = p1

	return LetterboxTop, LetterboxBottom, LetterboxLeft, LetterboxRight
end

local function buildFocusRect(p1) --[[ buildFocusRect | Line: 114 ]]
	local FocusRect = Instance.new("Frame")

	FocusRect.Name = "FocusRect"
	FocusRect.AnchorPoint = Vector2.new(0.5, 0.5)
	FocusRect.Size = UDim2.fromOffset(24, 24)
	FocusRect.BackgroundTransparency = 1
	FocusRect.Visible = false
	FocusRect.Parent = p1

	local v1 = Color3.fromRGB(255, 200, 90)

	local function bracket(p1, p2, p3, p4) --[[ bracket | Line: 124 | Upvalues: v1 (copy), FocusRect (copy) ]]
		local Frame = Instance.new("Frame")

		Frame.AnchorPoint = Vector2.new(p3, p4)
		Frame.Position = UDim2.fromScale(p1, p2)
		Frame.Size = UDim2.fromOffset(8, 2)
		Frame.BackgroundColor3 = v1
		Frame.BorderSizePixel = 0
		Frame.Parent = FocusRect

		local Frame2 = Instance.new("Frame")

		Frame2.AnchorPoint = Vector2.new(p3, p4)
		Frame2.Position = UDim2.fromScale(p1, p2)
		Frame2.Size = UDim2.fromOffset(2, 8)
		Frame2.BackgroundColor3 = v1
		Frame2.BorderSizePixel = 0
		Frame2.Parent = FocusRect
	end

	bracket(0, 0, 0, 0)
	bracket(1, 0, 1, 0)
	bracket(0, 1, 0, 1)
	bracket(1, 1, 1, 1)

	return FocusRect
end

local function buildLevel(p1) --[[ buildLevel | Line: 143 ]]
	local LevelIndicator = Instance.new("Frame")

	LevelIndicator.Name = "LevelIndicator"
	LevelIndicator.AnchorPoint = Vector2.new(0.5, 1)
	LevelIndicator.Position = UDim2.new(0.5, 0, 1, -20)
	LevelIndicator.Size = UDim2.fromOffset(200, 20)
	LevelIndicator.BackgroundTransparency = 1
	LevelIndicator.Parent = p1

	local Line = Instance.new("Frame")

	Line.Name = "Line"
	Line.AnchorPoint = Vector2.new(0.5, 0.5)
	Line.Position = UDim2.fromScale(0.5, 0.5)
	Line.Size = UDim2.fromOffset(200, 2)
	Line.BackgroundColor3 = Color3.fromRGB(255, 200, 90)
	Line.BorderSizePixel = 0
	Line.Parent = LevelIndicator

	local Tick = Instance.new("Frame")

	Tick.Name = "Tick"
	Tick.AnchorPoint = Vector2.new(0.5, 0.5)
	Tick.Position = UDim2.fromScale(0.5, 0.5)
	Tick.Size = UDim2.fromOffset(6, 12)
	Tick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tick.BorderSizePixel = 0
	Tick.Parent = LevelIndicator

	return Line, Tick
end

local function makeSlider(p1, p2, p3, p4) --[[ makeSlider | Line: 178 ]]
	local UserInputService = game:GetService("UserInputService")
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, -12, 0, 40)
	Frame.Position = UDim2.new(0, 6, 0, p3)
	Frame.BackgroundTransparency = 1
	Frame.Parent = p1

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 16)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Font = Enum.Font.Code
	TextLabel.TextSize = 12
	TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Text = p4.label
	TextLabel.Parent = Frame

	local Frame2 = Instance.new("Frame")

	Frame2.Position = UDim2.new(0, 0, 0, 22)
	Frame2.Size = UDim2.new(1, 0, 0, 8)
	Frame2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Frame

	local TextButton = Instance.new("TextButton")

	TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
	TextButton.Position = UDim2.new(0, 0, 0.5, 0)
	TextButton.Size = UDim2.fromOffset(12, 16)
	TextButton.BackgroundColor3 = Color3.fromRGB(255, 200, 90)
	TextButton.Text = ""
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = false
	TextButton.Parent = Frame2

	local function refresh() --[[ refresh | Line: 212 | Upvalues: p4 (copy), TextButton (copy), TextLabel (copy) ]]
		local v1 = p4.getValue()

		TextButton.Position = UDim2.new(math.clamp((v1 - p4.min) / (p4.max - p4.min), 0, 1), 0, 0.5, 0)
		TextLabel.Text = string.format("%s  %.2f", p4.label, v1)
	end

	refresh()

	local v1 = false

	TextButton.MouseButton1Down:Connect(function() --[[ Line: 224 | Upvalues: v1 (ref) ]]
		v1 = true
	end)

	local function f2(p1) --[[ Line: 227 | Upvalues: v1 (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end

		v1 = false
	end

	table.insert(p2, UserInputService.InputEnded:Connect(f2))

	local function f3(p1) --[[ Line: 230 | Upvalues: v1 (ref), Frame2 (copy), p4 (copy), refresh (copy) ]]
		if not v1 or p1.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end

		local X = Frame2.AbsolutePosition.X
		local X2 = Frame2.AbsoluteSize.X

		if not (X2 <= 0) then
			p4.setValue(p4.min + math.clamp((p1.Position.X - X) / X2, 0, 1) * (p4.max - p4.min))
			refresh()
		end
	end

	table.insert(p2, UserInputService.InputChanged:Connect(f3))

	return refresh
end

local function makeToggle(p1, p2, p3, p4, p5) --[[ makeToggle | Line: 245 ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.new(1, -12, 0, 22)
	TextButton.Position = UDim2.new(0, 6, 0, p2)
	TextButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	TextButton.BorderSizePixel = 0
	TextButton.Font = Enum.Font.Code
	TextButton.TextSize = 12
	TextButton.TextColor3 = Color3.fromRGB(255, 200, 90)
	TextButton.Text = ""
	TextButton.Parent = p1

	local function refresh() --[[ refresh | Line: 255 | Upvalues: TextButton (copy), p4 (copy), p3 (copy) ]]
		TextButton.Text = string.format("[%s] %s", if p4() then "X" else " ", p3)
	end

	TextButton.Text = string.format("[%s] %s", if p4() then "X" else " ", p3)
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 259 | Upvalues: p5 (copy), p4 (copy), TextButton (copy), p3 (copy) ]]
		p5(not p4())
		TextButton.Text = string.format("[%s] %s", if p4() then "X" else " ", p3)
	end)

	return refresh
end

local function makeControlRow(p1, p2, p3, p4) --[[ makeControlRow | Line: 269 ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.new(1, -12, 0, 22)
	TextButton.Position = UDim2.new(0, 6, 0, p3)
	TextButton.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
	TextButton.BorderSizePixel = 0
	TextButton.Font = Enum.Font.Code
	TextButton.TextSize = 12
	TextButton.TextColor3 = Color3.fromRGB(255, 200, 90)
	TextButton.TextXAlignment = Enum.TextXAlignment.Left
	TextButton.AutoButtonColor = true
	TextButton.Text = ""
	TextButton.Parent = p1

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingLeft = UDim.new(0, 6)
	UIPadding.Parent = TextButton

	local function refresh() --[[ refresh | Line: 282 | Upvalues: p4 (copy), TextButton (copy) ]]
		local v1 = if p4.getState then p4.getState() or "" else ""

		if v1 and v1 ~= "" then
			TextButton.Text = string.format("[%s] %-15s %s", p4.hotkey, p4.name, v1)
		else
			TextButton.Text = string.format("[%s] %s", p4.hotkey, p4.name)
		end
	end

	refresh()
	table.insert(p2, TextButton.MouseButton1Click:Connect(p4.onClick))

	return refresh
end

local function buildControlPanel(p1, p2) --[[ buildControlPanel | Line: 295 | Upvalues: CinematicCameraConfig (copy), t4 (ref), makeControlRow (copy), t5 (ref) ]]
	local ControlPanel = Instance.new("Frame")

	ControlPanel.Name = "ControlPanel"
	ControlPanel.AnchorPoint = Vector2.new(0, 0)
	ControlPanel.Position = UDim2.new(0, 12, 0, 64)
	ControlPanel.Size = UDim2.fromOffset(260, 392)
	ControlPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	ControlPanel.BackgroundTransparency = 0.15
	ControlPanel.BorderSizePixel = 0
	ControlPanel.Parent = p1

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 24)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Font = Enum.Font.Code
	TextLabel.TextSize = 13
	TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90)
	TextLabel.Text = "  CONTROLS  (C to hide)"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = ControlPanel

	local t = {
		Raw = "Smoothed",
		Smoothed = "Handheld",
		Handheld = "Raw"
	}
	local t2 = {
		off = "16:9",
		["16:9"] = "2.35:1",
		["2.35:1"] = "2.39:1",
		["2.39:1"] = "off"
	}
	local list = {
		{
			hotkey = "M",
			name = "MOTION",
			getState = function() --[[ getState | Line: 321 | Upvalues: p2 (copy) ]]
				return p2.mode
			end,
			onClick = function() --[[ onClick | Line: 322 | Upvalues: p2 (copy), t (copy) ]]
				p2.mode = t[p2.mode] or "Raw"
			end
		},
		{
			hotkey = "L",
			name = "LETTERBOX",
			getState = function() --[[ getState | Line: 323 | Upvalues: p2 (copy) ]]
				return p2.overlays.letterbox
			end,
			onClick = function() --[[ onClick | Line: 324 | Upvalues: p2 (copy), t2 (copy) ]]
				p2.overlays.letterbox = t2[p2.overlays.letterbox] or "off"
			end
		},
		{
			hotkey = "G",
			name = "THIRDS",
			getState = function() --[[ getState | Line: 325 | Upvalues: p2 (copy) ]]
				if p2.overlays.thirds then
					return "ON"
				end

				return "off"
			end,
			onClick = function() --[[ onClick | Line: 326 | Upvalues: p2 (copy) ]]
				p2.overlays.thirds = not p2.overlays.thirds
			end
		},
		{
			hotkey = "H",
			name = "LEVEL",
			getState = function() --[[ getState | Line: 327 | Upvalues: p2 (copy) ]]
				if p2.overlays.level then
					return "ON"
				end

				return "off"
			end,
			onClick = function() --[[ onClick | Line: 328 | Upvalues: p2 (copy) ]]
				p2.overlays.level = not p2.overlays.level
			end
		},
		{
			hotkey = "I",
			name = "INFO",
			getState = function() --[[ getState | Line: 329 | Upvalues: p2 (copy) ]]
				if p2.overlays.info then
					return "ON"
				end

				return "off"
			end,
			onClick = function() --[[ onClick | Line: 330 | Upvalues: p2 (copy) ]]
				p2.overlays.info = not p2.overlays.info
			end
		},
		{
			hotkey = "F",
			name = "FOCUS RECT",
			getState = function() --[[ getState | Line: 331 | Upvalues: p2 (copy) ]]
				if p2.overlays.focusRect then
					return "ON"
				end

				return "off"
			end,
			onClick = function() --[[ onClick | Line: 332 | Upvalues: p2 (copy) ]]
				p2.overlays.focusRect = not p2.overlays.focusRect
			end
		},
		{
			hotkey = "P",
			name = "LIGHTING",
			getState = function() --[[ getState | Line: 333 | Upvalues: p2 (copy) ]]
				if p2.overlays.lightingPanel then
					return "ON"
				end

				return "off"
			end,
			onClick = function() --[[ onClick | Line: 334 | Upvalues: p2 (copy) ]]
				p2.overlays.lightingPanel = not p2.overlays.lightingPanel
			end
		},
		{
			hotkey = "V",
			name = "HIGHLIGHT",
			getState = function() --[[ getState | Line: 335 | Upvalues: p2 (copy) ]]
				if p2.overlays.hoverHighlight then
					return "ON"
				end

				return "off"
			end,
			onClick = function() --[[ onClick | Line: 336 | Upvalues: p2 (copy) ]]
				p2.overlays.hoverHighlight = not p2.overlays.hoverHighlight
			end
		},
		{
			hotkey = "Home",
			name = "RESET",
			getState = function() --[[ getState | Line: 337 ]]
				return ""
			end,
			onClick = function() --[[ onClick | Line: 338 | Upvalues: p2 (copy) ]]
				p2.actions.resetRequested = true
			end
		},
		{
			hotkey = "[/]",
			name = "FOV",
			getState = function() --[[ getState | Line: 339 | Upvalues: p2 (copy) ]]
				return tostring(p2.fov)
			end,
			onClick = function() --[[ onClick | Line: 340 | Upvalues: p2 (copy), CinematicCameraConfig (ref) ]]
				p2.fov = math.clamp(p2.fov + 5, CinematicCameraConfig.Camera.MinFOV, CinematicCameraConfig.Camera.MaxFOV)
			end
		},
		{
			hotkey = "F10",
			name = "EXIT",
			getState = function() --[[ getState | Line: 341 ]]
				return ""
			end,
			onClick = function() --[[ onClick | Line: 342 | Upvalues: p2 (copy) ]]
				p2.__exitRequested = true
			end
		},
		{
			hotkey = "Tab",
			name = "CURSOR",
			getState = function() --[[ getState | Line: 343 | Upvalues: p2 (copy) ]]
				if p2.cursorFree then
					return "FREE"
				end

				return "locked"
			end,
			onClick = function() --[[ onClick | Line: 344 | Upvalues: p2 (copy) ]]
				p2.cursorFree = not p2.cursorFree
			end
		},
		{
			hotkey = "Bksp",
			name = "HIDE UI",
			getState = function() --[[ getState | Line: 345 | Upvalues: p2 (copy) ]]
				if p2.hudHidden then
					return "HIDDEN"
				end

				return "visible"
			end,
			onClick = function() --[[ onClick | Line: 346 | Upvalues: p2 (copy) ]]
				p2.hudHidden = not p2.hudHidden
			end
		}
	}
	local sum = 28

	for i, v in ipairs(list) do
		table.insert(t4, (makeControlRow(ControlPanel, t5, sum, v)))
		sum = sum + 26
	end

	return ControlPanel
end

local function buildLightingPanel(p1, p2) --[[ buildLightingPanel | Line: 355 | Upvalues: t2 (ref), makeSlider (copy), t3 (ref), CinematicCameraConfig (copy), makeToggle (copy) ]]
	local LightingPanel = Instance.new("Frame")

	LightingPanel.Name = "LightingPanel"
	LightingPanel.AnchorPoint = Vector2.new(1, 0.5)
	LightingPanel.Position = UDim2.new(1, -10, 0.5, 0)
	LightingPanel.Size = UDim2.fromOffset(220, 788)
	LightingPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	LightingPanel.BackgroundTransparency = 0.15
	LightingPanel.BorderSizePixel = 0
	LightingPanel.Visible = false
	LightingPanel.Parent = p1

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 28)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Font = Enum.Font.Code
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90)
	TextLabel.Text = "  CAMERA + LIGHTING FX  (P)"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = LightingPanel

	local v1 = 32

	table.insert(t2, (makeSlider(LightingPanel, t3, v1, {
		label = "Exposure",
		min = -3,
		max = 3,
		getValue = function() --[[ getValue | Line: 380 | Upvalues: p2 (copy) ]]
			return p2.lighting.exposure
		end,
		setValue = function(p1) --[[ setValue | Line: 381 | Upvalues: p2 (copy) ]]
			p2.lighting.exposure = p1
		end
	})))

	local v4 = v1 + 44

	table.insert(t2, (makeSlider(LightingPanel, t3, v4, {
		label = "FOV",
		min = CinematicCameraConfig.Camera.MinFOV,
		max = CinematicCameraConfig.Camera.MaxFOV,
		getValue = function() --[[ getValue | Line: 386 | Upvalues: p2 (copy) ]]
			return p2.fov
		end,
		setValue = function(p1) --[[ setValue | Line: 387 | Upvalues: p2 (copy) ]]
			p2.fov = math.floor(p1 + 0.5)
		end
	})))

	local v7 = v4 + 44

	table.insert(t2, (makeToggle(LightingPanel, v7, "Bloom", function() --[[ Line: 391 | Upvalues: p2 (copy) ]]
		return p2.lighting.bloom.on
	end, function(p1) --[[ Line: 392 | Upvalues: p2 (copy) ]]
		p2.lighting.bloom.on = p1
	end)))

	local v10 = v7 + 24

	table.insert(t2, (makeSlider(LightingPanel, t3, v10, {
		label = "  Intensity",
		min = 0,
		max = 3,
		getValue = function() --[[ getValue | Line: 395 | Upvalues: p2 (copy) ]]
			return p2.lighting.bloom.intensity
		end,
		setValue = function(p1) --[[ setValue | Line: 396 | Upvalues: p2 (copy) ]]
			p2.lighting.bloom.intensity = p1
		end
	})))

	local v13 = v10 + 44

	table.insert(t2, (makeSlider(LightingPanel, t3, v13, {
		label = "  Threshold",
		min = 0,
		max = 4,
		getValue = function() --[[ getValue | Line: 400 | Upvalues: p2 (copy) ]]
			return p2.lighting.bloom.threshold
		end,
		setValue = function(p1) --[[ setValue | Line: 401 | Upvalues: p2 (copy) ]]
			p2.lighting.bloom.threshold = p1
		end
	})))

	local v16 = v13 + 44

	table.insert(t2, (makeSlider(LightingPanel, t3, v16, {
		label = "  Size",
		min = 0,
		max = 56,
		getValue = function() --[[ getValue | Line: 405 | Upvalues: p2 (copy) ]]
			return p2.lighting.bloom.size
		end,
		setValue = function(p1) --[[ setValue | Line: 406 | Upvalues: p2 (copy) ]]
			p2.lighting.bloom.size = p1
		end
	})))

	local v19 = v16 + 44

	table.insert(t2, (makeToggle(LightingPanel, v19, "Color Correction", function() --[[ Line: 410 | Upvalues: p2 (copy) ]]
		return p2.lighting.colorCorrection.on
	end, function(p1) --[[ Line: 411 | Upvalues: p2 (copy) ]]
		p2.lighting.colorCorrection.on = p1
	end)))

	local v22 = v19 + 24

	table.insert(t2, (makeSlider(LightingPanel, t3, v22, {
		label = "  Brightness",
		min = -1,
		max = 1,
		getValue = function() --[[ getValue | Line: 414 | Upvalues: p2 (copy) ]]
			return p2.lighting.colorCorrection.brightness
		end,
		setValue = function(p1) --[[ setValue | Line: 415 | Upvalues: p2 (copy) ]]
			p2.lighting.colorCorrection.brightness = p1
		end
	})))

	local v25 = v22 + 44

	table.insert(t2, (makeSlider(LightingPanel, t3, v25, {
		label = "  Contrast",
		min = -1,
		max = 1,
		getValue = function() --[[ getValue | Line: 419 | Upvalues: p2 (copy) ]]
			return p2.lighting.colorCorrection.contrast
		end,
		setValue = function(p1) --[[ setValue | Line: 420 | Upvalues: p2 (copy) ]]
			p2.lighting.colorCorrection.contrast = p1
		end
	})))

	local v28 = v25 + 44

	table.insert(t2, (makeSlider(LightingPanel, t3, v28, {
		label = "  Saturation",
		min = -1,
		max = 1,
		getValue = function() --[[ getValue | Line: 424 | Upvalues: p2 (copy) ]]
			return p2.lighting.colorCorrection.saturation
		end,
		setValue = function(p1) --[[ setValue | Line: 425 | Upvalues: p2 (copy) ]]
			p2.lighting.colorCorrection.saturation = p1
		end
	})))

	local v31 = v28 + 44

	table.insert(t2, (makeToggle(LightingPanel, v31, "DOF", function() --[[ Line: 429 | Upvalues: p2 (copy) ]]
		return p2.lighting.dof.on
	end, function(p1) --[[ Line: 430 | Upvalues: p2 (copy) ]]
		p2.lighting.dof.on = p1
	end)))

	local v34 = v31 + 24

	table.insert(t2, (makeSlider(LightingPanel, t3, v34, {
		label = "  Focus Dist",
		min = 1,
		max = 100,
		getValue = function() --[[ getValue | Line: 433 | Upvalues: p2 (copy) ]]
			return p2.lighting.dof.focusDistance
		end,
		setValue = function(p1) --[[ setValue | Line: 434 | Upvalues: p2 (copy) ]]
			p2.lighting.dof.focusDistance = p1
		end
	})))

	local v37 = v34 + 44

	table.insert(t2, (makeSlider(LightingPanel, t3, v37, {
		label = "  Far",
		min = 0,
		max = 1,
		getValue = function() --[[ getValue | Line: 438 | Upvalues: p2 (copy) ]]
			return p2.lighting.dof.farIntensity
		end,
		setValue = function(p1) --[[ setValue | Line: 439 | Upvalues: p2 (copy) ]]
			p2.lighting.dof.farIntensity = p1
		end
	})))

	local v40 = v37 + 44

	table.insert(t2, (makeSlider(LightingPanel, t3, v40, {
		label = "  Near",
		min = 0,
		max = 1,
		getValue = function() --[[ getValue | Line: 443 | Upvalues: p2 (copy) ]]
			return p2.lighting.dof.nearIntensity
		end,
		setValue = function(p1) --[[ setValue | Line: 444 | Upvalues: p2 (copy) ]]
			p2.lighting.dof.nearIntensity = p1
		end
	})))

	local v43 = v40 + 44

	table.insert(t2, (makeSlider(LightingPanel, t3, v43, {
		label = "  Radius",
		min = 0,
		max = 50,
		getValue = function() --[[ getValue | Line: 448 | Upvalues: p2 (copy) ]]
			return p2.lighting.dof.inFocusRadius
		end,
		setValue = function(p1) --[[ setValue | Line: 449 | Upvalues: p2 (copy) ]]
			p2.lighting.dof.inFocusRadius = p1
		end
	})))

	local v46 = v43 + 44

	table.insert(t2, (makeToggle(LightingPanel, v46, "Blur", function() --[[ Line: 453 | Upvalues: p2 (copy) ]]
		return p2.lighting.blur.on
	end, function(p1) --[[ Line: 454 | Upvalues: p2 (copy) ]]
		p2.lighting.blur.on = p1
	end)))

	local v49 = v46 + 24

	table.insert(t2, (makeSlider(LightingPanel, t3, v49, {
		label = "  Size",
		min = 0,
		max = 56,
		getValue = function() --[[ getValue | Line: 457 | Upvalues: p2 (copy) ]]
			return p2.lighting.blur.size
		end,
		setValue = function(p1) --[[ setValue | Line: 458 | Upvalues: p2 (copy) ]]
			p2.lighting.blur.size = p1
		end
	})))
	table.insert(t2, (makeSlider(LightingPanel, t3, v49 + 44, {
		label = "Look Sens",
		min = 0.25,
		max = 4,
		getValue = function() --[[ getValue | Line: 463 | Upvalues: p2 (copy) ]]
			return p2.mouseSensitivityMult
		end,
		setValue = function(p1) --[[ setValue | Line: 464 | Upvalues: p2 (copy) ]]
			p2.mouseSensitivityMult = p1
		end
	})))

	return LightingPanel
end

local function reflowLetterbox(p1) --[[ reflowLetterbox | Line: 470 | Upvalues: v5 (ref), t6 (copy), v6 (ref), v7 (ref), v8 (ref) ]]
	if not v5 then
		return
	end

	local v1 = t6[p1.overlays.letterbox]
	local ViewportSize = workspace.CurrentCamera.ViewportSize

	if not v1 or (ViewportSize.Y <= 0 or ViewportSize.X <= 0) then
		v5.Visible = false
		v6.Visible = false
		v7.Visible = false
		v8.Visible = false

		return
	end

	if ViewportSize.X / ViewportSize.Y < v1 then
		local v2 = (ViewportSize.Y - ViewportSize.X / v1) / 2

		v5.Position = UDim2.new(0, 0, 0, 0)
		v5.Size = UDim2.new(1, 0, 0, (math.max(0, v2)))
		v6.Position = UDim2.new(0, 0, 1, -math.max(0, v2))
		v6.Size = UDim2.new(1, 0, 0, (math.max(0, v2)))
		v5.Visible = true
		v6.Visible = true
		v7.Visible = false
		v8.Visible = false
	else
		local v3 = (ViewportSize.X - ViewportSize.Y * v1) / 2

		v7.Position = UDim2.new(0, 0, 0, 0)
		v7.Size = UDim2.new(0, math.max(0, v3), 1, 0)
		v8.Position = UDim2.new(1, -math.max(0, v3), 0, 0)
		v8.Size = UDim2.new(0, math.max(0, v3), 1, 0)
		v5.Visible = false
		v6.Visible = false
		v7.Visible = true
		v8.Visible = true
	end
end

function t.Enter(p1, p2) --[[ Enter | Line: 499 | Upvalues: Players (copy), v1 (ref), v2 (ref), buildThirds (copy), v3 (ref), buildCenterDot (copy), v4 (ref), buildInfo (copy), v5 (ref), v6 (ref), v7 (ref), v8 (ref), v9 (ref), buildFocusRect (copy), v10 (ref), v11 (ref), buildLevel (copy), v12 (ref), reflowLetterbox (copy), t2 (ref), t3 (ref), v14 (ref), buildLightingPanel (copy), t4 (ref), t5 (ref), v15 (ref), buildControlPanel (copy) ]]
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui", 5)

	if PlayerGui then
		v1 = Instance.new("ScreenGui")
		v1.Name = "CinematicHUD"
		v1.IgnoreGuiInset = true
		v1.DisplayOrder = 1000
		v1.ResetOnSpawn = false
		v1.Parent = PlayerGui
		v2 = buildThirds(v1)
		v3 = buildCenterDot(v1)
		v4 = buildInfo(v1)

		local v13 = v1

		local function bar(p1) --[[ bar | Line: 102 | Upvalues: v13 (copy) ]]
			local Frame = Instance.new("Frame")

			Frame.Name = p1
			Frame.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
			Frame.BorderSizePixel = 0
			Frame.Visible = false
			Frame.Parent = v13

			return Frame
		end

		local LetterboxTop = Instance.new("Frame")

		LetterboxTop.Name = "LetterboxTop"
		LetterboxTop.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
		LetterboxTop.BorderSizePixel = 0
		LetterboxTop.Visible = false
		LetterboxTop.Parent = v13

		local LetterboxBottom = Instance.new("Frame")

		LetterboxBottom.Name = "LetterboxBottom"
		LetterboxBottom.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
		LetterboxBottom.BorderSizePixel = 0
		LetterboxBottom.Visible = false
		LetterboxBottom.Parent = v13

		local LetterboxLeft = Instance.new("Frame")

		LetterboxLeft.Name = "LetterboxLeft"
		LetterboxLeft.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
		LetterboxLeft.BorderSizePixel = 0
		LetterboxLeft.Visible = false
		LetterboxLeft.Parent = v13

		local LetterboxRight = Instance.new("Frame")

		LetterboxRight.Name = "LetterboxRight"
		LetterboxRight.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
		LetterboxRight.BorderSizePixel = 0
		LetterboxRight.Visible = false
		LetterboxRight.Parent = v13
		v5 = LetterboxTop
		v6 = LetterboxBottom
		v7 = LetterboxLeft
		v8 = LetterboxRight
		v9 = buildFocusRect(v1)

		local v22, v32 = buildLevel(v1)

		v10 = v22
		v11 = v32
		v12 = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 518 | Upvalues: reflowLetterbox (ref), p2 (copy) ]]
			reflowLetterbox(p2)
		end)
		reflowLetterbox(p2)
		t2 = {}
		t3 = {}
		v14 = buildLightingPanel(v1, p2)
		t4 = {}
		t5 = {}
		v15 = buildControlPanel(v1, p2)
	else
		warn("[OverlayRenderer] no PlayerGui, skipping HUD")
	end
end
function t.Tick(p1, p2, p3) --[[ Tick | Line: 534 | Upvalues: v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), v7 (ref), v8 (ref), v9 (ref), v10 (ref), v14 (ref), v15 (ref), CinematicCameraConfig (copy), v13 (ref), reflowLetterbox (copy), v11 (ref), t2 (ref), t4 (ref) ]]
	if not v1 then
		return
	end

	if p2.hudHidden then
		v2.Visible = false
		v3.Visible = false
		v4.Visible = false
		v5.Visible = false
		v6.Visible = false
		v7.Visible = false
		v8.Visible = false
		v9.Visible = false

		if v10 and v10.Parent then
			v10.Parent.Visible = false
		end

		if v14 then
			v14.Visible = false
		end

		if not v15 then
			return
		end

		v15.Visible = false
	else
		v2.Visible = p2.overlays.thirds
		v3.Visible = p2.overlays.centerDot

		if p2.overlays.info then
			v4.Visible = true

			local Position = p2.cameraCFrame.Position

			v4.Text = string.format("POS (%.1f, %.1f, %.1f)   FOV %d   MODE %s   %s%s\nCinematicCamera v%s", Position.X, Position.Y, Position.Z, p2.fov, p2.mode, p2.focus.locked and string.format("FOCAL %.1f stud%s   TARGET %s", p2.focus.distance + p2.focus.distanceOffset, p2.focus.distanceOffset ~= 0 and string.format(" (%+.1f)", p2.focus.distanceOffset) or "", p2.focus.target and p2.focus.target.Name or "?") or "FOCAL --   TARGET none", p2.lockTarget and p2.lockTarget.Parent and "   LOCK " .. p2.lockTarget.Name or "", CinematicCameraConfig.Version)
		else
			v4.Visible = false
		end

		if v13 ~= p2.overlays.letterbox then
			v13 = p2.overlays.letterbox
			reflowLetterbox(p2)
		end

		if p2.overlays.focusRect and (p2.focus.locked and p2.focus.target) then
			local v72, v82 = workspace.CurrentCamera:WorldToViewportPoint(p2.focus.target.Position)

			if v82 and v72.Z > 0 then
				v9.Visible = true
				v9.Position = UDim2.fromOffset(v72.X, v72.Y)
			else
				v9.Visible = false
			end
		else
			v9.Visible = false
		end

		if p2.overlays.level then
			v10.Parent.Visible = true

			local Y = p2.cameraCFrame.RightVector.Y

			v11.Position = UDim2.new(0.5, math.clamp(Y, -1, 1) * 90, 0.5, 0)
			v10.BackgroundColor3 = math.abs(Y) > 0.17364817766693033 and Color3.fromRGB(230, 80, 80) or Color3.fromRGB(255, 200, 90)
		else
			v10.Parent.Visible = false
		end

		if v14 then
			v14.Visible = p2.overlays.lightingPanel

			if v14.Visible then
				for i, v in ipairs(t2) do
					v()
				end
			end
		end

		if not v15 then
			return
		end

		v15.Visible = p2.overlays.controlPanel

		if not v15.Visible then
			return
		end

		for i, v in ipairs(t4) do
			v()
		end
	end
end
function t.Exit(p1) --[[ Exit | Line: 627 | Upvalues: v12 (ref), t3 (ref), v14 (ref), t2 (ref), t5 (ref), v15 (ref), t4 (ref), v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), v7 (ref), v8 (ref), v9 (ref), v10 (ref), v11 (ref), v13 (ref) ]]
	if v12 then
		v12:Disconnect()
		v12 = nil
	end

	for i, v in ipairs(t3) do
		v:Disconnect()
	end

	t3 = {}
	v14 = nil
	t2 = {}

	for i, v in ipairs(t5) do
		v:Disconnect()
	end

	t5 = {}
	v15 = nil
	t4 = {}

	if v1 then
		v1:Destroy()
		v1 = nil
	end

	v2 = nil
	v3 = nil
	v4 = nil
	v5 = nil
	v6 = nil
	v7 = nil
	v8 = nil
	v9 = nil
	v10 = nil
	v11 = nil
	v13 = nil
end

return t