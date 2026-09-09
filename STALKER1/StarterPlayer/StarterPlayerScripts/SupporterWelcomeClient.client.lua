-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local RequestSupporterWelcome = Remotes:WaitForChild("RequestSupporterWelcome", 30)
local SubmitSupporterWelcomeAck = Remotes:WaitForChild("SubmitSupporterWelcomeAck", 30)

if not (RequestSupporterWelcome and SubmitSupporterWelcomeAck) then
	warn("[SupporterWelcome] remotes missing")

	return
end

local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)

Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)

local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)

local function tryReq(p1) --[[ tryReq | Line: 37 | Upvalues: ReplicatedStorage (copy) ]]
	local v1 = ReplicatedStorage:WaitForChild(p1, 10)

	if not v1 then
		return nil
	end

	local ok, result = pcall(require, v1)

	return if ok and result then result else nil
end

local SupporterCatalog = ReplicatedStorage:WaitForChild("SupporterCatalog", 10)
local v3

if SupporterCatalog then
	local ok, result = pcall(require, SupporterCatalog)

	v3 = if ok then result or nil else nil
else
	v3 = nil
end

local LootConfig = ReplicatedStorage:WaitForChild("LootConfig", 10)
local v4

if LootConfig then
	local ok, result = pcall(require, LootConfig)

	v4 = if ok then result or nil else nil
else
	v4 = nil
end

local ItemDatabase = ReplicatedStorage:WaitForChild("ItemDatabase", 10)
local v5

if ItemDatabase then
	local ok, result = pcall(require, ItemDatabase)

	v5 = if ok then result or nil else nil
else
	v5 = nil
end

local StashTierConfig = ReplicatedStorage:WaitForChild("StashTierConfig", 10)
local v6

if StashTierConfig then
	local ok, result = pcall(require, StashTierConfig)

	v6 = if ok then result or nil else nil
else
	v6 = nil
end

local SkinCatalog = ReplicatedStorage:WaitForChild("SkinCatalog", 10)
local v7

if SkinCatalog then
	local ok, result = pcall(require, SkinCatalog)

	v7 = if ok then result or nil else nil
else
	v7 = nil
end

local v8 = false

local function summarizeLoadout(p1) --[[ summarizeLoadout | Line: 54 | Upvalues: v5 (ref) ]]
	local t = {}
	local list = {}

	for i, v in ipairs(p1) do
		if v.ID then
			if t[v.ID] == nil then
				t[v.ID] = 0
				table.insert(list, v.ID)
			end

			t[v.ID] = t[v.ID] + 1
		end
	end

	local t2 = {}

	for i, v in ipairs(list) do
		local v1 = v5 and (v5.GetItemData and v5.GetItemData(v))
		local v3 = t[v]

		table.insert(t2, (v3 > 1 and v3 .. "x " or "") .. (v1 and v1.Name or v))
	end

	return t2
end

local function stashSizeFor(p1) --[[ stashSizeFor | Line: 75 | Upvalues: v6 (ref) ]]
	if not (v6 and v6.GetSizeForTier) then
		return nil
	end

	local v1 = v6.GetSizeForTier(p1)

	if v1 then
		return string.format("Tier %d \226\128\148 %dx%d (%d slots)", p1, v1.X, v1.Y, v1.X * v1.Y)
	end

	return nil
end

local function buildSections(p1) --[[ buildSections | Line: 83 | Upvalues: v3 (ref), v6 (ref), v4 (ref), summarizeLoadout (copy), v7 (ref), v5 (ref) ]]
	local v1 = v3 and (v3.Tiers and v3.Tiers[p1])

	if not v1 then
		return {}, v1
	end

	local t = {}
	local v2 = v1.StashTierBonus or 0
	local v32

	if v6 and v6.GetSizeForTier then
		local v42 = v6.GetSizeForTier(v2)

		v32 = if v42 then string.format("Tier %d \226\128\148 %dx%d (%d slots)", v2, v42.X, v42.Y, v42.X * v42.Y) else nil
	else
		v32 = nil
	end

	if v32 then
		table.insert(t, {
			title = "PERSONAL STASH",
			bullets = { v32 .. "  (wipe-safe)" }
		})
	end

	table.insert(t, {
		title = "CHAT IDENTITY",
		bullets = { (v1.ChatPrefix or "[]") .. "  prefix + tier-colored nameplate" }
	})

	if v4 and (v4.Respawn and v4.Respawn.SupporterLoadouts) then
		local v62 = v4.Respawn.SupporterLoadouts[v1.LoadoutKey]

		if v62 then
			table.insert(t, {
				title = "INSURANCE KIT (on every respawn)",
				bullets = summarizeLoadout(v62)
			})
		end
	end

	if v1.UniformPacks and #v1.UniformPacks > 0 then
		local t3 = {}

		for i, v in ipairs(v1.UniformPacks) do
			local v72 = v7 and (v7.Packs and v7.Packs[v])

			table.insert(t3, v72 and v72.DisplayName or v)
		end

		if p1 == "MasterStalker" then
			table.insert(t3, "+ Any future faction uniform packs unlock automatically")
		end

		table.insert(t, {
			title = "UNIFORM PACKS UNLOCKED",
			bullets = t3
		})
	elseif p1 == "Veteran" then
		table.insert(t, {
			title = "UNIFORM PACK",
			bullets = { "Pick 1 faction\'s uniforms after this (Mercenary / Duty / Freedom)." }
		})
	end

	local function slotLabel(p1) --[[ slotLabel | Line: 144 ]]
		if p1 == "Uniform" then
			return "uniform skin"
		end

		if p1 == "BodyGear" then
			return "BodyGear skin"
		end

		if p1 == "HeadGear" then
			return "helmet skin"
		end

		if p1 == "FaceWear" then
			return "mask skin"
		end

		if p1 == "Backpack" then
			return "backpack skin"
		end

		return "skin"
	end

	if v1.ExclusiveSkins and #v1.ExclusiveSkins > 0 then
		local t3 = {}

		for i, v in ipairs(v1.ExclusiveSkins) do
			local v9 = v5 and (v5.GetItemData and v5.GetItemData(v))
			local v11 = if v9 then v9.ItemType else v9

			table.insert(t3, (v9 and v9.Name or v) .. "  (" .. (if v11 == "Uniform" then "uniform skin" elseif v11 == "BodyGear" then "BodyGear skin" elseif v11 == "HeadGear" then "helmet skin" elseif v11 == "FaceWear" then "mask skin" elseif v11 == "Backpack" then "backpack skin" else "skin") .. ")")
		end

		table.insert(t, {
			title = "EXCLUSIVE ITEMS",
			bullets = t3
		})
	end

	table.insert(t, {
		title = "BADGE + COMMUNITY",
		bullets = { "\'" .. v1.DisplayName .. "\' Roblox badge", "Discord \'" .. v1.DisplayName .. "\' role" }
	})

	return t, v1
end

local function beginMouseUnlock() --[[ beginMouseUnlock | Line: 184 | Upvalues: RunService (copy), UserInputService (copy) ]]
	pcall(function() --[[ Line: 185 | Upvalues: RunService (ref), UserInputService (ref) ]]
		RunService:BindToRenderStep("_SupporterWelcomeMouseUnlock", Enum.RenderPriority.Last.Value, function() --[[ Line: 186 | Upvalues: UserInputService (ref) ]]
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

local function endMouseUnlock() --[[ endMouseUnlock | Line: 197 | Upvalues: RunService (copy) ]]
	pcall(function() --[[ Line: 198 | Upvalues: RunService (ref) ]]
		RunService:UnbindFromRenderStep("_SupporterWelcomeMouseUnlock")
	end)
end

local function showWelcome(p1) --[[ showWelcome | Line: 201 | Upvalues: v8 (ref), buildSections (copy), SubmitSupporterWelcomeAck (copy), RunService (copy), UserInputService (copy), PlayerGui (copy), v1 (copy), v2 (copy) ]]
	if v8 then
		return
	end

	v8 = true

	local v12, v22 = buildSections(p1)

	if not v22 then
		v8 = false
		SubmitSupporterWelcomeAck:FireServer(p1)

		return
	end

	pcall(function() --[[ Line: 185 | Upvalues: RunService (ref), UserInputService (ref) ]]
		RunService:BindToRenderStep("_SupporterWelcomeMouseUnlock", Enum.RenderPriority.Last.Value, function() --[[ Line: 186 | Upvalues: UserInputService (ref) ]]
			if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			if UserInputService.MouseIconEnabled then
				return
			end

			UserInputService.MouseIconEnabled = true
		end)
	end)

	local v3 = v22.ChatColor or Color3.fromRGB(220, 220, 220)
	local SupporterWelcome = Instance.new("ScreenGui")

	SupporterWelcome.Name = "SupporterWelcome"
	SupporterWelcome.IgnoreGuiInset = true
	SupporterWelcome.ResetOnSpawn = false
	SupporterWelcome.DisplayOrder = 210
	SupporterWelcome.Parent = PlayerGui

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromScale(1, 1)
	Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BackgroundTransparency = 0.35
	Frame.BorderSizePixel = 0
	Frame.ZIndex = 1
	Frame.Parent = SupporterWelcome

	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.fromOffset(560, 580)
	Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame2.Position = UDim2.fromScale(0.5, 0.5)
	Frame2.BackgroundColor3 = Color3.fromRGB(20, 22, 20)
	Frame2.BorderSizePixel = 0
	Frame2.ZIndex = 2
	Frame2.Parent = SupporterWelcome

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

	local Frame3 = Instance.new("Frame")

	Frame3.AnchorPoint = Vector2.new(0.5, 0)
	Frame3.Position = UDim2.new(0.5, 0, 0, 0)
	Frame3.Size = UDim2.new(1, 0, 0, 3)
	Frame3.BackgroundColor3 = v3
	Frame3.BorderSizePixel = 0
	Frame3.ZIndex = 3
	Frame3.Parent = Frame2

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 16)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = "SUPPORTER TIER UNLOCKED"
	TextLabel.FontFace = v1
	TextLabel.TextSize = 12
	TextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.ZIndex = 3
	TextLabel.Parent = Frame2

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(1, 0, 0, 40)
	TextLabel2.Position = UDim2.fromOffset(0, 20)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Text = string.upper(v22.DisplayName or p1)
	TextLabel2.FontFace = v1
	TextLabel2.TextSize = 32
	TextLabel2.TextColor3 = v3
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.ZIndex = 3
	TextLabel2.Parent = Frame2

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.new(1, 0, 0, 20)
	TextLabel3.Position = UDim2.fromOffset(0, 62)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.Text = "Thank you for supporting Zone STALKER. Here\'s what you get:"
	TextLabel3.FontFace = v2
	TextLabel3.TextSize = 14
	TextLabel3.TextColor3 = Color3.fromRGB(190, 190, 190)
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.ZIndex = 3
	TextLabel3.Parent = Frame2

	local ScrollingFrame = Instance.new("ScrollingFrame")

	ScrollingFrame.Size = UDim2.new(1, 0, 1, -156)
	ScrollingFrame.Position = UDim2.fromOffset(0, 92)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.CanvasSize = UDim2.new()
	ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ScrollingFrame.ScrollBarThickness = 4
	ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
	ScrollingFrame.ZIndex = 3
	ScrollingFrame.Parent = Frame2

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 16)
	UIListLayout.Parent = ScrollingFrame

	for i, v in ipairs(v12) do
		local Frame4 = Instance.new("Frame")

		Frame4.Size = UDim2.new(1, -8, 0, 0)
		Frame4.AutomaticSize = Enum.AutomaticSize.Y
		Frame4.BackgroundTransparency = 1
		Frame4.LayoutOrder = i
		Frame4.ZIndex = 3
		Frame4.Parent = ScrollingFrame

		local UIListLayout2 = Instance.new("UIListLayout")

		UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout2.Padding = UDim.new(0, 4)
		UIListLayout2.Parent = Frame4

		local TextLabel4 = Instance.new("TextLabel")

		TextLabel4.Size = UDim2.new(1, 0, 0, 18)
		TextLabel4.BackgroundTransparency = 1
		TextLabel4.Text = v.title
		TextLabel4.FontFace = v1
		TextLabel4.TextSize = 13
		TextLabel4.TextColor3 = v3
		TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel4.LayoutOrder = 1
		TextLabel4.ZIndex = 3
		TextLabel4.Parent = Frame4

		for i2, v4 in ipairs(v.bullets) do
			local TextLabel5 = Instance.new("TextLabel")

			TextLabel5.Size = UDim2.new(1, 0, 0, 22)
			TextLabel5.AutomaticSize = Enum.AutomaticSize.Y
			TextLabel5.BackgroundTransparency = 1
			TextLabel5.Text = "\226\128\162 " .. v4
			TextLabel5.FontFace = v2
			TextLabel5.TextSize = 15
			TextLabel5.TextColor3 = Color3.fromRGB(230, 230, 230)
			TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel5.TextYAlignment = Enum.TextYAlignment.Top
			TextLabel5.TextWrapped = true
			TextLabel5.LayoutOrder = 1 + i2
			TextLabel5.ZIndex = 3
			TextLabel5.Parent = Frame4
		end
	end

	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.fromOffset(200, 40)
	TextButton.AnchorPoint = Vector2.new(1, 1)
	TextButton.Position = UDim2.new(1, 0, 1, 0)
	TextButton.BackgroundColor3 = Color3.fromRGB(45, 55, 40)
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = false
	TextButton.Text = "CONTINUE"
	TextButton.FontFace = v1
	TextButton.TextSize = 18
	TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.ZIndex = 4
	TextButton.Parent = Frame2

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = v3
	UIStroke2.Thickness = 1
	UIStroke2.Parent = TextButton
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 387 | Upvalues: SubmitSupporterWelcomeAck (ref), p1 (copy), RunService (ref), v8 (ref), SupporterWelcome (copy) ]]
		SubmitSupporterWelcomeAck:FireServer(p1)
		pcall(function() --[[ Line: 198 | Upvalues: RunService (ref) ]]
			RunService:UnbindFromRenderStep("_SupporterWelcomeMouseUnlock")
		end)
		v8 = false
		SupporterWelcome:Destroy()
	end)
end

RequestSupporterWelcome.OnClientEvent:Connect(showWelcome)
print("[SupporterWelcomeClient] ready")