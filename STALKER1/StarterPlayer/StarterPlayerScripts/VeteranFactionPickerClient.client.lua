-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local RequestVeteranFactionPick = Remotes:WaitForChild("RequestVeteranFactionPick", 30)
local SubmitVeteranFactionPick = Remotes:WaitForChild("SubmitVeteranFactionPick", 30)

if not (RequestVeteranFactionPick and SubmitVeteranFactionPick) then
	warn("[VeteranFactionPicker] remotes missing")

	return
end

local v1 = nil
local ok, result = pcall(function() --[[ Line: 35 | Upvalues: ReplicatedStorage (copy) ]]
	return require(ReplicatedStorage:WaitForChild("SkinCatalog", 10))
end)
local v2 = if ok then result else nil
local ok2, result2 = pcall(function() --[[ Line: 37 | Upvalues: ReplicatedStorage (copy) ]]
	return require(ReplicatedStorage:WaitForChild("ItemDatabase", 10))
end)

if ok2 then
	v1 = result2
end

local function getPackUniformNames(p1) --[[ getPackUniformNames | Line: 41 | Upvalues: v2 (ref), v1 (ref) ]]
	if not (v2 and v2.Packs) then
		return {}
	end

	local v12 = v2.Packs[p1]

	if not (v12 and v12.Skins) then
		return {}
	end

	local t = {}

	for i, v in ipairs(v12.Skins) do
		local v22 = v1 and (v1.GetItemData and v1.GetItemData(v))

		table.insert(t, v22 and v22.Name or v)
	end

	return t
end

local v3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v4 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v5 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
local t = {
	{
		key = "MercenaryFactionUniforms",
		name = "MERCENARY",
		tagline = "Earn your pay.",
		tint = Color3.fromRGB(60, 80, 100),
		accent = Color3.fromRGB(120, 150, 175)
	},
	{
		key = "DutyFactionUniforms",
		name = "DUTY",
		tagline = "The Zone must be destroyed.",
		tint = Color3.fromRGB(110, 40, 40),
		accent = Color3.fromRGB(200, 90, 80)
	},
	{
		key = "FreedomFactionUniforms",
		name = "FREEDOM",
		tagline = "The Zone should be free.",
		tint = Color3.fromRGB(45, 90, 45),
		accent = Color3.fromRGB(120, 200, 100)
	}
}
local v6 = false

local function beginMouseUnlock() --[[ beginMouseUnlock | Line: 84 | Upvalues: RunService (copy), UserInputService (copy) ]]
	pcall(function() --[[ Line: 85 | Upvalues: RunService (ref), UserInputService (ref) ]]
		RunService:BindToRenderStep("_VeteranFactionPickerMouseUnlock", Enum.RenderPriority.Last.Value, function() --[[ Line: 86 | Upvalues: UserInputService (ref) ]]
			if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			if UserInputService.MouseIconEnabled then
				return
			end

			UserInputService.MouseIconEnabled = true
		end)
	end)
end

local function endMouseUnlock() --[[ endMouseUnlock | Line: 97 | Upvalues: RunService (copy) ]]
	pcall(function() --[[ Line: 98 | Upvalues: RunService (ref) ]]
		RunService:UnbindFromRenderStep("_VeteranFactionPickerMouseUnlock")
	end)
end

local function showPicker() --[[ showPicker | Line: 101 | Upvalues: v6 (ref), RunService (copy), UserInputService (copy), PlayerGui (copy), v3 (copy), v5 (copy), t (copy), getPackUniformNames (copy), v4 (copy), SubmitVeteranFactionPick (copy) ]]
	if v6 then
		return
	end

	v6 = true
	pcall(function() --[[ Line: 85 | Upvalues: RunService (ref), UserInputService (ref) ]]
		RunService:BindToRenderStep("_VeteranFactionPickerMouseUnlock", Enum.RenderPriority.Last.Value, function() --[[ Line: 86 | Upvalues: UserInputService (ref) ]]
			if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			if UserInputService.MouseIconEnabled then
				return
			end

			UserInputService.MouseIconEnabled = true
		end)
	end)

	local VeteranFactionPicker = Instance.new("ScreenGui")

	VeteranFactionPicker.Name = "VeteranFactionPicker"
	VeteranFactionPicker.IgnoreGuiInset = true
	VeteranFactionPicker.ResetOnSpawn = false
	VeteranFactionPicker.DisplayOrder = 200
	VeteranFactionPicker.Parent = PlayerGui

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromScale(1, 1)
	Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BackgroundTransparency = 0.35
	Frame.BorderSizePixel = 0
	Frame.ZIndex = 1
	Frame.Parent = VeteranFactionPicker

	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.fromOffset(720, 480)
	Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame2.Position = UDim2.fromScale(0.5, 0.5)
	Frame2.BackgroundColor3 = Color3.fromRGB(20, 22, 20)
	Frame2.BorderSizePixel = 0
	Frame2.ZIndex = 2
	Frame2.Parent = VeteranFactionPicker

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(90, 90, 90)
	UIStroke.Thickness = 1
	UIStroke.Parent = Frame2

	local UIGradient = Instance.new("UIGradient")

	UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 48, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 10)) })
	UIGradient.Rotation = -90
	UIGradient.Parent = Frame2

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingTop = UDim.new(0, 24)
	UIPadding.PaddingBottom = UDim.new(0, 24)
	UIPadding.PaddingLeft = UDim.new(0, 28)
	UIPadding.PaddingRight = UDim.new(0, 28)
	UIPadding.Parent = Frame2

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 30)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = "CHOOSE YOUR FACTION PACK"
	TextLabel.FontFace = v3
	TextLabel.TextSize = 26
	TextLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.ZIndex = 3
	TextLabel.Parent = Frame2

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(1, 0, 0, 40)
	TextLabel2.Position = UDim2.fromOffset(0, 34)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Text = "Veteran Pack: pick 1 faction. All uniforms in that faction unlock as skins.\nThis choice is PERMANENT and survives wipes."
	TextLabel2.FontFace = v5
	TextLabel2.TextSize = 15
	TextLabel2.TextColor3 = Color3.fromRGB(180, 180, 180)
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel2.TextWrapped = true
	TextLabel2.ZIndex = 3
	TextLabel2.Parent = Frame2

	local Frame3 = Instance.new("Frame")

	Frame3.Size = UDim2.new(1, 0, 0, 280)
	Frame3.Position = UDim2.fromOffset(0, 88)
	Frame3.BackgroundTransparency = 1
	Frame3.ZIndex = 3
	Frame3.Parent = Frame2

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 16)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = Frame3

	local function styleCard(p1, p2) --[[ styleCard | Line: 192 ]]
		p1.strokeInst.Color = p2 and p1.faction.accent or Color3.fromRGB(60, 60, 60)
		p1.strokeInst.Thickness = if p2 then 3 else 1
		p1.btn.BackgroundTransparency = if p2 then 0 else 0.25
	end

	local tbl = {}
	local v1 = nil

	for i, v in ipairs(t) do
		local TextButton = Instance.new("TextButton")

		TextButton.Size = UDim2.new(0, 210, 1, 0)
		TextButton.BackgroundColor3 = v.tint
		TextButton.BackgroundTransparency = 0.25
		TextButton.AutoButtonColor = false
		TextButton.Text = ""
		TextButton.BorderSizePixel = 0
		TextButton.LayoutOrder = i
		TextButton.ZIndex = 4
		TextButton.Parent = Frame3

		local UIStroke2 = Instance.new("UIStroke")

		UIStroke2.Color = Color3.fromRGB(60, 60, 60)
		UIStroke2.Thickness = 1
		UIStroke2.Parent = TextButton

		local UIGradient2 = Instance.new("UIGradient")

		UIGradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(255/255, 255/255, 255/255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60)) })
		UIGradient2.Rotation = -90
		UIGradient2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 0.15) })
		UIGradient2.Parent = TextButton

		local Frame4 = Instance.new("Frame")

		Frame4.Size = UDim2.new(1, 0, 0, 4)
		Frame4.BackgroundColor3 = v.accent
		Frame4.BorderSizePixel = 0
		Frame4.ZIndex = 5
		Frame4.Parent = TextButton

		local TextLabel3 = Instance.new("TextLabel")

		TextLabel3.Size = UDim2.new(1, -24, 0, 40)
		TextLabel3.Position = UDim2.fromOffset(12, 16)
		TextLabel3.BackgroundTransparency = 1
		TextLabel3.Text = v.name
		TextLabel3.FontFace = v3
		TextLabel3.TextSize = 32
		TextLabel3.TextColor3 = Color3.fromRGB(240, 240, 240)
		TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel3.ZIndex = 5
		TextLabel3.Parent = TextButton

		local TextLabel4 = Instance.new("TextLabel")

		TextLabel4.Size = UDim2.new(1, -24, 0, 22)
		TextLabel4.Position = UDim2.fromOffset(12, 58)
		TextLabel4.BackgroundTransparency = 1
		TextLabel4.Text = v.tagline
		TextLabel4.FontFace = v5
		TextLabel4.TextSize = 14
		TextLabel4.TextColor3 = Color3.fromRGB(200, 200, 200)
		TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel4.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel4.TextWrapped = true
		TextLabel4.ZIndex = 5
		TextLabel4.Parent = TextButton

		local TextLabel5 = Instance.new("TextLabel")

		TextLabel5.Size = UDim2.new(1, -24, 0, 16)
		TextLabel5.Position = UDim2.fromOffset(12, 96)
		TextLabel5.BackgroundTransparency = 1
		TextLabel5.Text = "UNIFORMS INCLUDED"
		TextLabel5.FontFace = v3
		TextLabel5.TextSize = 11
		TextLabel5.TextColor3 = v.accent
		TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel5.ZIndex = 5
		TextLabel5.Parent = TextButton

		local Frame5 = Instance.new("Frame")

		Frame5.Size = UDim2.new(1, -24, 1, -128)
		Frame5.Position = UDim2.fromOffset(12, 116)
		Frame5.BackgroundTransparency = 1
		Frame5.ZIndex = 5
		Frame5.Parent = TextButton

		local UIListLayout2 = Instance.new("UIListLayout")

		UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout2.Padding = UDim.new(0, 4)
		UIListLayout2.Parent = Frame5

		for i2, v7 in ipairs((getPackUniformNames(v.key))) do
			local TextLabel6 = Instance.new("TextLabel")

			TextLabel6.Size = UDim2.new(1, 0, 0, 20)
			TextLabel6.BackgroundTransparency = 1
			TextLabel6.Text = "\226\128\162 " .. v7
			TextLabel6.FontFace = v4
			TextLabel6.TextSize = 14
			TextLabel6.TextColor3 = Color3.fromRGB(230, 230, 230)
			TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel6.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel6.LayoutOrder = i2
			TextLabel6.ZIndex = 5
			TextLabel6.Parent = Frame5
		end

		local t2 = {
			btn = TextButton,
			strokeInst = UIStroke2,
			faction = v
		}

		tbl[v.key] = t2
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 304 | Upvalues: v1 (ref), t2 (copy) ]]
			if v1 then
				local v12 = v1

				v12.strokeInst.Color = Color3.fromRGB(60, 60, 60)
				v12.strokeInst.Thickness = 1
				v12.btn.BackgroundTransparency = 0.25
			end

			v1 = t2

			local v2 = t2

			v2.strokeInst.Color = v2.faction.accent or Color3.fromRGB(60, 60, 60)
			v2.strokeInst.Thickness = 3
			v2.btn.BackgroundTransparency = 0
		end)
	end

	local Frame4 = Instance.new("Frame")

	Frame4.Size = UDim2.new(1, 0, 0, 44)
	Frame4.AnchorPoint = Vector2.new(0, 1)
	Frame4.Position = UDim2.new(0, 0, 1, 0)
	Frame4.BackgroundTransparency = 1
	Frame4.ZIndex = 3
	Frame4.Parent = Frame2

	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.fromOffset(200, 40)
	TextButton.AnchorPoint = Vector2.new(1, 0.5)
	TextButton.Position = UDim2.new(1, 0, 0.5, 0)
	TextButton.BackgroundColor3 = Color3.fromRGB(45, 55, 40)
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = false
	TextButton.Text = "CONFIRM"
	TextButton.FontFace = v3
	TextButton.TextSize = 18
	TextButton.TextColor3 = Color3.fromRGB(180, 180, 180)
	TextButton.ZIndex = 4
	TextButton.Parent = Frame4

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = Color3.fromRGB(60, 70, 55)
	UIStroke2.Thickness = 1
	UIStroke2.Parent = TextButton

	local function updateConfirmEnabled() --[[ updateConfirmEnabled | Line: 339 | Upvalues: v1 (ref), TextButton (copy), UIStroke2 (copy) ]]
		if v1 then
			TextButton.BackgroundColor3 = Color3.fromRGB(80, 130, 70)
			TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			UIStroke2.Color = Color3.fromRGB(140, 200, 130)
		else
			TextButton.BackgroundColor3 = Color3.fromRGB(45, 55, 40)
			TextButton.TextColor3 = Color3.fromRGB(140, 140, 140)
			UIStroke2.Color = Color3.fromRGB(60, 70, 55)
		end
	end

	for k, v in pairs(tbl) do
		v.btn.MouseButton1Click:Connect(updateConfirmEnabled)
	end

	TextButton.MouseButton1Click:Connect(function() --[[ Line: 356 | Upvalues: v1 (ref), SubmitVeteranFactionPick (ref), RunService (ref), v6 (ref), VeteranFactionPicker (copy) ]]
		if v1 then
			SubmitVeteranFactionPick:FireServer(v1.faction.key)
			pcall(function() --[[ Line: 98 | Upvalues: RunService (ref) ]]
				RunService:UnbindFromRenderStep("_VeteranFactionPickerMouseUnlock")
			end)
			v6 = false
			VeteranFactionPicker:Destroy()
		end
	end)
end

RequestVeteranFactionPick.OnClientEvent:Connect(showPicker)
print("[VeteranFactionPickerClient] ready")