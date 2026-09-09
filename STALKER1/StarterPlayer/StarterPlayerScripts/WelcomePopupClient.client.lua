-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ShowWelcomePopup = Remotes:WaitForChild("ShowWelcomePopup")
local ReshowWelcomePopup = Remotes:WaitForChild("ReshowWelcomePopup")
local v1 = Color3.fromRGB(22, 22, 22)
local v2 = Color3.fromRGB(30, 28, 25)
local v3 = Color3.fromRGB(220, 215, 200)
local v4 = Color3.fromRGB(170, 165, 155)
local v5 = Color3.fromRGB(190, 160, 80)
local v6 = Color3.fromRGB(245, 232, 210)
local v7 = Color3.fromRGB(55, 50, 42)
local v8 = Color3.fromRGB(35, 33, 30)
local v9 = Color3.fromRGB(55, 50, 42)
local v10 = Color3.fromRGB(230, 160, 80)
local v11 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v12 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v13 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
local WelcomePopupGui = Instance.new("ScreenGui")

WelcomePopupGui.Name = "WelcomePopupGui"
WelcomePopupGui.IgnoreGuiInset = true
WelcomePopupGui.ResetOnSpawn = false
WelcomePopupGui.DisplayOrder = 200
WelcomePopupGui.Enabled = false
WelcomePopupGui.Parent = PlayerGui

local Dim = Instance.new("Frame")

Dim.Name = "Dim"
Dim.Size = UDim2.fromScale(1, 1)
Dim.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
Dim.BackgroundTransparency = 0.45
Dim.BorderSizePixel = 0
Dim.Parent = WelcomePopupGui

local Panel = Instance.new("Frame")

Panel.Name = "Panel"
Panel.AnchorPoint = Vector2.new(0.5, 0.5)
Panel.Position = UDim2.fromScale(0.5, 0.5)
Panel.Size = UDim2.fromOffset(620, 620)
Panel.BackgroundColor3 = v1
Panel.BorderSizePixel = 0
Panel.Parent = WelcomePopupGui

local UICorner = Instance.new("UICorner")

UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = Panel

local UIStroke = Instance.new("UIStroke")

UIStroke.Color = v7
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.2
UIStroke.Parent = Panel

local Header = Instance.new("Frame")

Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = v2
Header.BorderSizePixel = 0
Header.Parent = Panel

local UICorner2 = Instance.new("UICorner")

UICorner2.CornerRadius = UDim.new(0, 6)
UICorner2.Parent = Header

local Frame = Instance.new("Frame")

Frame.Size = UDim2.new(1, 0, 0, 6)
Frame.Position = UDim2.new(0, 0, 1, -6)
Frame.BackgroundColor3 = v2
Frame.BorderSizePixel = 0
Frame.Parent = Header

local TextLabel = Instance.new("TextLabel")

TextLabel.Size = UDim2.new(1, -24, 1, 0)
TextLabel.Position = UDim2.fromOffset(16, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.FontFace = v11
TextLabel.Text = "Welcome to the Warehouse"
TextLabel.TextColor3 = v6
TextLabel.TextSize = 24
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.Parent = Header

local Body = Instance.new("ScrollingFrame")

Body.Name = "Body"
Body.Position = UDim2.fromOffset(0, 50)
Body.Size = UDim2.new(1, 0, 1, -110)
Body.BackgroundTransparency = 1
Body.BorderSizePixel = 0
Body.ScrollBarThickness = 6
Body.ScrollBarImageColor3 = v4
Body.AutomaticCanvasSize = Enum.AutomaticSize.Y
Body.CanvasSize = UDim2.new()
Body.Parent = Panel

local UIListLayout = Instance.new("UIListLayout")

UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = Body

local UIPadding = Instance.new("UIPadding")

UIPadding.PaddingTop = UDim.new(0, 16)
UIPadding.PaddingBottom = UDim.new(0, 16)
UIPadding.PaddingLeft = UDim.new(0, 20)
UIPadding.PaddingRight = UDim.new(0, 20)
UIPadding.Parent = Body

local function paragraph(p1, p2, p3) --[[ paragraph | Line: 155 | Upvalues: v13 (copy), Body (copy) ]]
	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 0)
	TextLabel.AutomaticSize = Enum.AutomaticSize.Y
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v13
	TextLabel.Text = p1
	TextLabel.TextColor3 = p2
	TextLabel.TextSize = 16
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel.TextWrapped = true
	TextLabel.LayoutOrder = p3
	TextLabel.Parent = Body

	return TextLabel
end

local function sectionHeader(p1, p2) --[[ sectionHeader | Line: 172 | Upvalues: v12 (copy), v5 (copy), Body (copy) ]]
	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 24)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v12
	TextLabel.Text = string.upper(p1)
	TextLabel.TextColor3 = v5
	TextLabel.TextSize = 14
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
	TextLabel.LayoutOrder = p2
	TextLabel.Parent = Body

	return TextLabel
end

local function controlRow(p1, p2, p3) --[[ controlRow | Line: 187 | Upvalues: Body (copy), v12 (copy), v6 (copy), v13 (copy), v3 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 22)
	Frame.BackgroundTransparency = 1
	Frame.LayoutOrder = p3
	Frame.Parent = Body

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(0, 110, 1, 0)
	TextLabel.Position = UDim2.fromOffset(8, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v12
	TextLabel.Text = p1
	TextLabel.TextColor3 = v6
	TextLabel.TextSize = 15
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Frame

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(1, -130, 1, 0)
	TextLabel2.Position = UDim2.fromOffset(122, 0)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v13
	TextLabel2.Text = p2
	TextLabel2.TextColor3 = v3
	TextLabel2.TextSize = 15
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = Frame

	return Frame
end

local function separator(p1) --[[ separator | Line: 219 | Upvalues: v7 (copy), Body (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 1)
	Frame.BackgroundColor3 = v7
	Frame.BorderSizePixel = 0
	Frame.BackgroundTransparency = 0.3
	Frame.LayoutOrder = p1
	Frame.Parent = Body

	return Frame
end

local v14 = 1

paragraph("This warehouse is your staging area. Stock up at the trader, manage your stash, and take a truck from any garage to enter the Zone. Nothing here is at risk \226\128\148 but everything you carry into the Zone can be lost.", v3, v14)

local v15 = v14 + 1
local Frame2 = Instance.new("Frame")

Frame2.Size = UDim2.new(1, 0, 0, 1)
Frame2.BackgroundColor3 = v7
Frame2.BorderSizePixel = 0
Frame2.BackgroundTransparency = 0.3
Frame2.LayoutOrder = v15
Frame2.Parent = Body

local v16 = v15 + 1

paragraph("PRE-ALPHA: This game is in early pre-alpha and only represents a small part of the planned experience. Expect bugs, missing features, balance changes, wipes, and frequent updates.", v10, v16)

local v17 = v16 + 1
local Frame3 = Instance.new("Frame")

Frame3.Size = UDim2.new(1, 0, 0, 1)
Frame3.BackgroundColor3 = v7
Frame3.BorderSizePixel = 0
Frame3.BackgroundTransparency = 0.3
Frame3.LayoutOrder = v17
Frame3.Parent = Body

local count = v17 + 1

for i, v in ipairs({
	{
		section = "Movement"
	},
	{
		key = "WASD",
		desc = "Move"
	},
	{
		key = "Shift",
		desc = "Sprint (forward only)"
	},
	{
		key = "Space",
		desc = "Jump"
	},
	{
		section = "Interface"
	},
	{
		key = "P",
		desc = "PDA - map, contacts, tasks"
	},
	{
		key = "Tab",
		desc = "Inventory - drag, drop, use items"
	},
	{
		key = "M",
		desc = "Hood up / down (uniforms with a hood)"
	},
	{
		key = "1-4",
		desc = "Draw weapon (Primary / Secondary / Sidearm / Melee)"
	},
	{
		key = "F1-F4",
		desc = "Use quick-consumable"
	},
	{
		key = "F5",
		desc = "Reopen this welcome menu"
	},
	{
		section = "Entering the Zone"
	},
	{
		key = "Truck garage",
		desc = "Step inside a garage to host a party. Pick a map, choose Open or Friends Only, and hit START when your squad is set."
	},
	{
		key = "Party UI",
		desc = "Host sees a side panel with map picker, access toggle, kick, and START. Non-host members see the countdown on the garage\'s dashboard."
	},
	{
		key = "Combat controls",
		desc = "Full weapon + HUD guide shows up once you land in the Zone."
	}
}) do
	if v.section then
		sectionHeader(v.section, count)
		count = count + 1

		continue
	end

	controlRow(v.key, v.desc, count)
	count = count + 1
end

local Frame4 = Instance.new("Frame")

Frame4.Size = UDim2.new(1, 0, 0, 60)
Frame4.Position = UDim2.new(0, 0, 1, -60)
Frame4.BackgroundTransparency = 1
Frame4.Parent = Panel

local GotItButton = Instance.new("TextButton")

GotItButton.Name = "GotItButton"
GotItButton.AnchorPoint = Vector2.new(0.5, 0.5)
GotItButton.Position = UDim2.fromScale(0.5, 0.5)
GotItButton.Size = UDim2.fromOffset(180, 36)
GotItButton.BackgroundColor3 = v8
GotItButton.BorderSizePixel = 0
GotItButton.AutoButtonColor = false
GotItButton.FontFace = v12
GotItButton.Text = "GOT IT"
GotItButton.TextColor3 = v6
GotItButton.TextSize = 16
GotItButton.Parent = Frame4

local UICorner3 = Instance.new("UICorner")

UICorner3.CornerRadius = UDim.new(0, 4)
UICorner3.Parent = GotItButton

local UIStroke2 = Instance.new("UIStroke")

UIStroke2.Color = v7
UIStroke2.Thickness = 1
UIStroke2.Transparency = 0.2
UIStroke2.Parent = GotItButton

local v18 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

GotItButton.MouseEnter:Connect(function() --[[ Line: 277 | Upvalues: TweenService (copy), GotItButton (copy), v18 (copy), v9 (copy) ]]
	TweenService:Create(GotItButton, v18, {
		BackgroundColor3 = v9
	}):Play()
end)
GotItButton.MouseLeave:Connect(function() --[[ Line: 280 | Upvalues: TweenService (copy), GotItButton (copy), v18 (copy), v8 (copy) ]]
	TweenService:Create(GotItButton, v18, {
		BackgroundColor3 = v8
	}):Play()
end)

local function freeMouseTick() --[[ freeMouseTick | Line: 289 | Upvalues: UserInputService (copy) ]]
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	UserInputService.MouseIconEnabled = true
end

local function show() --[[ show | Line: 294 | Upvalues: WelcomePopupGui (copy), Body (copy), RunService (copy), freeMouseTick (copy) ]]
	WelcomePopupGui.Enabled = true
	Body.CanvasPosition = Vector2.new(0, 0)
	pcall(function() --[[ Line: 297 | Upvalues: RunService (ref) ]]
		RunService:UnbindFromRenderStep("WelcomePopup_FreeMouse")
	end)
	RunService:BindToRenderStep("WelcomePopup_FreeMouse", Enum.RenderPriority.Last.Value + 1, freeMouseTick)
end

local function hide() --[[ hide | Line: 301 | Upvalues: WelcomePopupGui (copy), RunService (copy) ]]
	WelcomePopupGui.Enabled = false
	pcall(function() --[[ Line: 303 | Upvalues: RunService (ref) ]]
		RunService:UnbindFromRenderStep("WelcomePopup_FreeMouse")
	end)
end

GotItButton.MouseButton1Click:Connect(hide)
ContextActionService:BindAction("WelcomePopup_Dismiss", function(p1, p2) --[[ Line: 309 | Upvalues: WelcomePopupGui (copy), RunService (copy) ]]
	if p2 == Enum.UserInputState.Begin and WelcomePopupGui.Enabled then
		WelcomePopupGui.Enabled = false
		pcall(function() --[[ Line: 303 | Upvalues: RunService (ref) ]]
			RunService:UnbindFromRenderStep("WelcomePopup_FreeMouse")
		end)

		return Enum.ContextActionResult.Sink
	end

	return Enum.ContextActionResult.Pass
end, false, Enum.KeyCode.Escape)
ContextActionService:BindAction("WelcomePopup_Reopen", function(p1, p2) --[[ Line: 320 | Upvalues: WelcomePopupGui (copy), ReshowWelcomePopup (copy) ]]
	if p2 == Enum.UserInputState.Begin and not WelcomePopupGui.Enabled then
		ReshowWelcomePopup:FireServer()

		return Enum.ContextActionResult.Sink
	end

	return Enum.ContextActionResult.Pass
end, false, Enum.KeyCode.F5)
ShowWelcomePopup.OnClientEvent:Connect(show)
print("[WelcomePopupClient] ready")