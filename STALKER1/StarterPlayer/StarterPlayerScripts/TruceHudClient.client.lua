-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v3 = Color3.fromRGB(25, 27, 24)
local v4 = Color3.fromRGB(48, 48, 48)
local v5 = Color3.fromRGB(190, 190, 190)
local v6 = Color3.fromRGB(210, 200, 150)
local v7 = Color3.fromRGB(230, 150, 70)
local v8 = Color3.fromRGB(220, 90, 90)
local v9 = Color3.fromRGB(150, 190, 220)
local TruceHud = Instance.new("ScreenGui")

TruceHud.Name = "TruceHud"
TruceHud.ResetOnSpawn = false
TruceHud.IgnoreGuiInset = true
TruceHud.DisplayOrder = 56
TruceHud.Enabled = false
TruceHud.Parent = PlayerGui

local Card = Instance.new("Frame")

Card.Name = "Card"
Card.Size = UDim2.fromOffset(190, 46)
Card.AnchorPoint = Vector2.new(0.5, 0)
Card.Position = UDim2.new(0.5, 0, 0, 214)
Card.BackgroundColor3 = v3
Card.BackgroundTransparency = 0.25
Card.BorderSizePixel = 0
Card.Parent = TruceHud

local UIStroke = Instance.new("UIStroke")

UIStroke.Color = v4
UIStroke.Thickness = 1
UIStroke.Parent = Card

local Bar = Instance.new("Frame")

Bar.Name = "Bar"
Bar.Size = UDim2.new(0, 4, 1, 0)
Bar.BackgroundColor3 = v6
Bar.BorderSizePixel = 0
Bar.Parent = Card

local Caption = Instance.new("TextLabel")

Caption.Name = "Caption"
Caption.BackgroundTransparency = 1
Caption.Position = UDim2.fromOffset(14, 5)
Caption.Size = UDim2.new(1, -20, 0, 14)
Caption.FontFace = v2
Caption.TextSize = 13
Caption.TextColor3 = v5
Caption.TextXAlignment = Enum.TextXAlignment.Left
Caption.Text = "CEASEFIRE"
Caption.Parent = Card

local Clock = Instance.new("TextLabel")

Clock.Name = "Clock"
Clock.BackgroundTransparency = 1
Clock.Position = UDim2.fromOffset(14, 18)
Clock.Size = UDim2.new(1, -20, 0, 24)
Clock.FontFace = v1
Clock.TextSize = 22
Clock.TextColor3 = v6
Clock.TextXAlignment = Enum.TextXAlignment.Left
Clock.Text = "0:00"
Clock.Parent = Card

local function mmss(p1) --[[ mmss | Line: 88 ]]
	local v2 = math.max(0, (math.floor(p1)))

	return string.format("%d:%02d", math.floor(v2 / 60), v2 % 60)
end

local v10 = 0

local function refresh(p1) --[[ refresh | Line: 97 | Upvalues: LocalPlayer (copy), TruceHud (copy), v9 (copy), v8 (copy), v7 (copy), v6 (copy), Clock (copy), Bar (copy), Caption (copy), v10 (ref), Card (copy) ]]
	local v2 = tonumber(LocalPlayer:GetAttribute("MT_TruceUntil"))
	local v4 = tonumber(LocalPlayer:GetAttribute("MT_TrucePaused"))

	if not v2 then
		TruceHud.Enabled = false

		return
	end

	local v5 = if v4 then v4 else v2 - os.time()

	if v5 <= 0 and not v4 then
		TruceHud.Enabled = false

		return
	end

	TruceHud.Enabled = true

	local v62, v72

	if v4 then
		v62 = v9
		v72 = "CEASEFIRE  (HELD)"
	else
		v62 = v5 <= 15 and v8 or (v5 <= 60 and v7 or v6)
		v72 = "CEASEFIRE"
	end

	local v11 = math.max(0, (math.floor(v5)))

	Clock.Text = string.format("%d:%02d", math.floor(v11 / 60), v11 % 60)
	Clock.TextColor3 = v62
	Bar.BackgroundColor3 = v62
	Caption.Text = v72

	if v4 or not (v5 <= 15) then
		v10 = 0
		Card.BackgroundTransparency = 0.25
	else
		v10 = v10 + (p1 or 0)
		Card.BackgroundTransparency = math.abs((math.sin(v10 * 3))) * 0.2 + 0.25
	end
end

RunService.RenderStepped:Connect(refresh)
LocalPlayer:GetAttributeChangedSignal("MT_TruceUntil"):Connect(function() --[[ Line: 140 | Upvalues: refresh (copy) ]]
	refresh(0)
end)
LocalPlayer:GetAttributeChangedSignal("MT_TrucePaused"):Connect(function() --[[ Line: 141 | Upvalues: refresh (copy) ]]
	refresh(0)
end)
refresh(0)