-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"))
local ItemIconStyle = require(ReplicatedStorage:WaitForChild("ItemIconStyle"))
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)

Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)

local v2 = Color3.fromRGB(24, 26, 24)
local v3 = Color3.fromRGB(255, 200, 90)
local v4 = Color3.fromRGB(235, 235, 235)
local v5 = Color3.fromRGB(70, 70, 70)
local t = { "Primary", "Secondary", "Sidearm", "Melee" }
local t2 = {
	Enum.KeyCode.One,
	Enum.KeyCode.Two,
	Enum.KeyCode.Three,
	Enum.KeyCode.Four
}
local t3 = {
	Enum.KeyCode.F1,
	Enum.KeyCode.F2,
	Enum.KeyCode.F3,
	Enum.KeyCode.F4
}
local t4 = { "TraderGui", "PdaGui", "InventoryGui", "PremiumVendorGui", "NpcInteractionGui", "TalkGui", "EmoteWheelGui" }
local t5 = {
	_gui = nil,
	_weaponSlots = {},
	_quickSlots = {},
	_started = false
}

local function getEquippedToolName() --[[ getEquippedToolName | Line: 49 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	for i, v in ipairs(Character:GetChildren()) do
		if v:IsA("Tool") then
			return v.Name
		end
	end

	return nil
end

local function findToolFor(p1) --[[ findToolFor | Line: 58 | Upvalues: LocalPlayer (copy) ]]
	if not p1 then
		return nil
	end

	local Character = LocalPlayer.Character

	if Character then
		local v1 = Character:FindFirstChild(p1)

		if v1 and v1:IsA("Tool") then
			return v1
		end
	end

	local Backpack = LocalPlayer:FindFirstChild("Backpack")

	if not Backpack then
		return nil
	end

	local v2 = Backpack:FindFirstChild(p1)

	if v2 and v2:IsA("Tool") then
		return v2
	end

	return nil
end

local function isBlocked() --[[ isBlocked | Line: 73 | Upvalues: UserInputService (copy), LocalPlayer (copy), t4 (copy) ]]
	if UserInputService:GetFocusedTextBox() then
		return true
	end

	local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")

	if not PlayerGui then
		return false
	end

	for i, v in ipairs(t4) do
		local v1 = PlayerGui:FindFirstChild(v)

		if v1 and (v1:IsA("ScreenGui") and v1.Enabled) then
			return true
		end
	end

	return false
end

local v6 = 0

Remotes.ItemUseStarted.OnClientEvent:Connect(function(p1, p2) --[[ Line: 101 | Upvalues: v6 (ref) ]]
	v6 = os.clock() + (tonumber(p2) or 4) + 0.5
end)
Remotes.ItemUseStopped.OnClientEvent:Connect(function() --[[ Line: 104 | Upvalues: v6 (ref) ]]
	v6 = 0
end)

local function handsBusy() --[[ handsBusy | Line: 108 | Upvalues: v6 (ref) ]]
	return os.clock() < v6
end

local function reloading() --[[ reloading | Line: 129 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:GetAttribute("_ReloadingUntil") else Character

	return if type(v1) == "number" then os.clock() < v1 else false
end

local function styleSlot(p1, p2) --[[ styleSlot | Line: 137 | Upvalues: v2 (copy), v5 (copy) ]]
	p1.BackgroundColor3 = v2
	p1.BackgroundTransparency = 0.25
	p1.BorderSizePixel = 0

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = p1

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = if p2 then p2 else v5
	UIStroke.Thickness = 1
	UIStroke.Transparency = 0.4
	UIStroke.Parent = p1

	return UIStroke
end

function t5._buildWeaponBar(p1) --[[ _buildWeaponBar | Line: 152 | Upvalues: t (copy), styleSlot (copy), v5 (copy), ItemIconStyle (copy), v1 (copy), v4 (copy) ]]
	local WeaponBar = Instance.new("Frame")

	WeaponBar.Name = "WeaponBar"
	WeaponBar.AnchorPoint = Vector2.new(0.5, 1)
	WeaponBar.Position = UDim2.new(0.5, 0, 1, -12)
	WeaponBar.Size = UDim2.fromOffset(#t * 60 + (#t - 1) * 8, 60)
	WeaponBar.BackgroundTransparency = 1
	WeaponBar.Parent = p1._gui

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.Parent = WeaponBar

	for i, v in ipairs(t) do
		local Frame = Instance.new("Frame")

		Frame.Name = v .. "Slot"
		Frame.Size = UDim2.fromOffset(60, 60)
		Frame.LayoutOrder = i
		Frame.BackgroundTransparency = 0.55
		Frame.Parent = WeaponBar

		local v12 = styleSlot(Frame, v5)
		local Icon = Instance.new("ImageLabel")

		Icon.Name = "Icon"
		Icon.Size = UDim2.fromScale(0.82, 0.82)
		Icon.Position = UDim2.fromScale(0.5, 0.5)
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundTransparency = 1
		Icon.ScaleType = ItemIconStyle.ScaleTypeFor(nil)
		Icon.Image = ""
		Icon.Visible = false
		Icon.Parent = Frame

		local KeyNum = Instance.new("TextLabel")

		KeyNum.Name = "KeyNum"
		KeyNum.Size = UDim2.fromOffset(16, 16)
		KeyNum.Position = UDim2.new(0, 3, 0, 1)
		KeyNum.BackgroundTransparency = 1
		KeyNum.Text = tostring(i)
		KeyNum.FontFace = v1
		KeyNum.TextSize = 14
		KeyNum.TextColor3 = v4
		KeyNum.TextXAlignment = Enum.TextXAlignment.Left
		KeyNum.TextTransparency = 0.4
		KeyNum.ZIndex = 3
		KeyNum.Parent = Frame
		p1._weaponSlots[v] = {
			itemID = nil,
			toolName = nil,
			frame = Frame,
			iconHost = Icon,
			numberLabel = KeyNum,
			stroke = v12
		}
	end
end
function t5._buildQuickCluster(p1) --[[ _buildQuickCluster | Line: 212 | Upvalues: styleSlot (copy), v5 (copy), ItemIconStyle (copy), v1 (copy), v4 (copy) ]]
	local QuickCluster = Instance.new("Frame")

	QuickCluster.Name = "QuickCluster"
	QuickCluster.AnchorPoint = Vector2.new(1, 1)
	QuickCluster.Position = UDim2.new(1, -16, 1, -12)
	QuickCluster.Size = UDim2.fromOffset(210, 48)
	QuickCluster.BackgroundTransparency = 1
	QuickCluster.Parent = p1._gui

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 6)
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.Parent = QuickCluster

	for i = 1, 4 do
		local Frame = Instance.new("Frame")

		Frame.Name = "Quick" .. i
		Frame.Size = UDim2.fromOffset(48, 48)
		Frame.LayoutOrder = i
		Frame.BackgroundTransparency = 0.45
		Frame.Parent = QuickCluster

		local v12 = styleSlot(Frame, v5)
		local Icon = Instance.new("ImageLabel")

		Icon.Name = "Icon"
		Icon.Size = UDim2.fromScale(0.82, 0.82)
		Icon.Position = UDim2.fromScale(0.5, 0.45)
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundTransparency = 1
		Icon.ScaleType = ItemIconStyle.ScaleTypeFor(nil)
		Icon.Image = ""
		Icon.Visible = false
		Icon.Parent = Frame

		local KeyLabel = Instance.new("TextLabel")

		KeyLabel.Name = "KeyLabel"
		KeyLabel.Size = UDim2.fromOffset(20, 14)
		KeyLabel.Position = UDim2.new(0, 3, 0, 1)
		KeyLabel.BackgroundTransparency = 1
		KeyLabel.Text = "F" .. i
		KeyLabel.FontFace = v1
		KeyLabel.TextSize = 12
		KeyLabel.TextColor3 = v4
		KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
		KeyLabel.TextTransparency = 0.25
		KeyLabel.ZIndex = 3
		KeyLabel.Parent = Frame
		p1._quickSlots[i] = {
			itemID = nil,
			frame = Frame,
			icon = Icon,
			keyLabel = KeyLabel,
			stroke = v12
		}
	end
end

local function ensureGui(p1) --[[ ensureGui | Line: 267 | Upvalues: LocalPlayer (copy) ]]
	if p1._gui and p1._gui.Parent then
		return
	end

	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local Hotbar = PlayerGui:FindFirstChild("Hotbar")
	local Hotbar2

	if Hotbar then
		Hotbar:Destroy()
	end

	Hotbar2 = Instance.new("ScreenGui")
	Hotbar2.Name = "Hotbar"
	Hotbar2.ResetOnSpawn = false
	Hotbar2.IgnoreGuiInset = true
	Hotbar2.DisplayOrder = 8
	Hotbar2.Parent = PlayerGui
	p1._gui = Hotbar2
	p1._weaponSlots = {}
	p1._quickSlots = {}
	p1:_buildWeaponBar()
	p1:_buildQuickCluster()
end

function t5._setWeaponSlot(p1, p2, p3) --[[ _setWeaponSlot | Line: 287 | Upvalues: ItemDatabase (copy), ItemIconStyle (copy) ]]
	local v1 = p1._weaponSlots[p2]

	if not v1 then
		return
	end

	v1.itemID = p3

	local ViewportIcon = v1.iconHost:FindFirstChild("ViewportIcon")

	if ViewportIcon then
		ViewportIcon:Destroy()
	end

	if p3 then
		local v2 = ItemDatabase.GetItemData(p3)

		v1.toolName = ItemDatabase.GetItemData(p3) and v2.ToolName or nil
		v1.iconHost.Image = v2 and v2.ImageID or ""
		v1.iconHost.ScaleType = ItemIconStyle.ScaleTypeFor(v2)
		v1.iconHost.Visible = true
		v1.frame.BackgroundTransparency = 0.25
		v1.numberLabel.TextTransparency = 0
	else
		v1.toolName = nil
		v1.iconHost.Image = ""
		v1.iconHost.Visible = false
		v1.frame.BackgroundTransparency = 0.55
		v1.numberLabel.TextTransparency = 0.4
	end

	p1:_refreshWeaponHighlight()
end
function t5._refreshWeaponHighlight(p1) --[[ _refreshWeaponHighlight | Line: 313 | Upvalues: getEquippedToolName (copy), t (copy), v3 (copy), v5 (copy) ]]
	local v1 = getEquippedToolName()

	for i, v in ipairs(t) do
		local v2 = p1._weaponSlots[v]

		if v2 then
			local v32 = if v2.toolName == nil then false elseif v2.toolName == v1 then true else false

			v2.stroke.Color = v32 and v3 or v5
			v2.stroke.Thickness = if v32 then 2 else 1
			v2.stroke.Transparency = if v32 then 0 else 0.4
		end
	end
end
function t5._drawWeapon(p1, p2) --[[ _drawWeapon | Line: 326 | Upvalues: LocalPlayer (copy), v6 (ref), getEquippedToolName (copy), findToolFor (copy) ]]
	local v1 = p1._weaponSlots[p2]

	if not (v1 and v1.toolName) then
		return
	end

	local Character = LocalPlayer.Character
	local v2 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

	if not v2 or v2.Health <= 0 then
		return
	end

	local v3 = if os.clock() < v6 then true else false

	if v3 and getEquippedToolName() ~= v1.toolName then
		return
	end

	local Character2 = LocalPlayer.Character
	local v4 = if Character2 then Character2:GetAttribute("_ReloadingUntil") else Character2

	if if type(v4) == "number" then os.clock() < v4 else false then
		return
	end

	if getEquippedToolName() == v1.toolName then
		v2:UnequipTools()

		return
	end

	local v62 = findToolFor(v1.toolName)

	if not v62 then
		return
	end

	v2:EquipTool(v62)
end
function t5.SetQuickSlot(p1, p2, p3) --[[ SetQuickSlot | Line: 350 | Upvalues: ItemDatabase (copy), ItemIconStyle (copy) ]]
	local v1 = p1._quickSlots[p2]

	if not v1 then
		return
	end

	if p3 then
		for k, v in pairs(p1._quickSlots) do
			if k ~= p2 and v.itemID == p3 then
				v.itemID = nil
				v.icon.Image = ""
				v.icon.Visible = false
			end
		end
	end

	v1.itemID = p3

	if p3 then
		local v2 = ItemDatabase.GetItemData(p3)

		v1.icon.Image = v2 and v2.ImageID or ""
		v1.icon.ScaleType = ItemIconStyle.ScaleTypeFor(v2)
		v1.icon.Visible = true
	else
		v1.icon.Image = ""
		v1.icon.Visible = false
	end

	p1:RefreshQuickAvailability()
end
function t5.RefreshQuickAvailability(p1) --[[ RefreshQuickAvailability | Line: 376 | Upvalues: Remotes (copy), ItemDatabase (copy), ItemIconStyle (copy), v3 (copy), v5 (copy) ]]
	local ok, result = pcall(function() --[[ Line: 377 | Upvalues: Remotes (ref) ]]
		return Remotes.GetQuickSlots:InvokeServer()
	end)

	if not ok or type(result) ~= "table" then
		return
	end

	for i = 1, 4 do
		local v1 = p1._quickSlots[i]

		if v1 then
			local v2 = result[i] or result[tostring(i)]

			if v2 and v2.id then
				v1.itemID = v2.id

				local v32 = ItemDatabase.GetItemData(v2.id)

				v1.icon.Image = v32 and v32.ImageID or ""
				v1.icon.ScaleType = ItemIconStyle.ScaleTypeFor(v32)
				v1.icon.Visible = true
				v1.icon.ImageTransparency = if v2.available then 0 else 0.65
				v1.stroke.Color = v2.available and v3 or v5
				v1.stroke.Transparency = if v2.available then 0.2 else 0.5

				continue
			end

			v1.itemID = nil
			v1.icon.Visible = false
			v1.stroke.Color = v5
			v1.stroke.Transparency = 0.4
		end
	end
end
function t5._useQuick(p1, p2) --[[ _useQuick | Line: 402 | Upvalues: Remotes (copy) ]]
	local v1 = p1._quickSlots[p2]

	if v1 and v1.itemID then
		Remotes.UseItemByType:FireServer(v1.itemID)
		task.delay(0.4, function() --[[ Line: 406 | Upvalues: p1 (copy) ]]
			p1:RefreshQuickAvailability()
		end)
	end
end
function t5._bindInput(p1) --[[ _bindInput | Line: 411 | Upvalues: ContextActionService (copy), isBlocked (copy), t2 (copy), t (copy), t3 (copy) ]]
	local v1 = t2

	ContextActionService:BindAction("Hotbar_Weapons", function(p12, p2, p3) --[[ Line: 412 | Upvalues: isBlocked (ref), t2 (ref), p1 (copy), t (ref) ]]
		if p2 ~= Enum.UserInputState.Begin then
			return Enum.ContextActionResult.Pass
		end

		if isBlocked() then
			return Enum.ContextActionResult.Pass
		end

		for i, v in ipairs(t2) do
			if p3.KeyCode == v then
				p1:_drawWeapon(t[i])

				return Enum.ContextActionResult.Sink
			end
		end

		return Enum.ContextActionResult.Pass
	end, false, table.unpack(v1))

	local v2 = t3

	ContextActionService:BindAction("Hotbar_Quick", function(p12, p2, p3) --[[ Line: 424 | Upvalues: isBlocked (ref), t3 (ref), p1 (copy) ]]
		if p2 ~= Enum.UserInputState.Begin then
			return Enum.ContextActionResult.Pass
		end

		if isBlocked() then
			return Enum.ContextActionResult.Pass
		end

		for i, v in ipairs(t3) do
			if p3.KeyCode == v then
				p1:_useQuick(i)

				return Enum.ContextActionResult.Sink
			end
		end

		return Enum.ContextActionResult.Pass
	end, false, table.unpack(v2))
end
function t5._onEquipmentLoaded(p1, p2) --[[ _onEquipmentLoaded | Line: 439 | Upvalues: t (copy) ]]
	if type(p2) ~= "table" then
		return
	end

	for i, v in ipairs(t) do
		local v1, v2
		local v3 = p2[v]

		if v3 then
			v1 = v3.ID

			if v1 then
				v2 = v
			else
				v2 = v
				v1 = nil
			end
		else
			v2 = v
			v1 = nil
		end

		p1:_setWeaponSlot(v2, v1)
	end
end
function t5._hookCharacter(p1, p2) --[[ _hookCharacter | Line: 447 | Upvalues: StarterGui (copy) ]]
	pcall(function() --[[ Line: 450 | Upvalues: StarterGui (ref) ]]
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	end)

	local function refresh() --[[ refresh | Line: 451 | Upvalues: p1 (copy) ]]
		p1:_refreshWeaponHighlight()
	end

	p2.ChildAdded:Connect(function(p1) --[[ Line: 452 | Upvalues: refresh (copy) ]]
		if not p1:IsA("Tool") then
			return
		end

		task.defer(refresh)
	end)
	p2.ChildRemoved:Connect(function(p1) --[[ Line: 453 | Upvalues: refresh (copy) ]]
		if not p1:IsA("Tool") then
			return
		end

		task.defer(refresh)
	end)
	task.defer(refresh)
end
function t5.Init(p1) --[[ Init | Line: 457 | Upvalues: ensureGui (copy), StarterGui (copy), Remotes (copy), t (copy), LocalPlayer (copy) ]]
	if p1._started then
		return
	end

	p1._started = true
	ensureGui(p1)
	pcall(function() --[[ Line: 462 | Upvalues: StarterGui (ref) ]]
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	end)
	p1:_bindInput()
	Remotes.LoadEquipment.OnClientEvent:Connect(function(p12) --[[ Line: 466 | Upvalues: p1 (copy) ]]
		p1:_onEquipmentLoaded(p12)
	end)
	Remotes.EquipSlotChanged.OnClientEvent:Connect(function(p12, p2) --[[ Line: 469 | Upvalues: t (ref), p1 (copy) ]]
		for i, v in ipairs(t) do
			local v1, v2

			if p12 == v then
				if p2 then
					v1 = p2.ID

					if v1 then
						v2 = v
					else
						v2 = v
						v1 = nil
					end
				else
					v2 = v
					v1 = nil
				end

				p1:_setWeaponSlot(v2, v1)
			end
		end
	end)
	Remotes:WaitForChild("HotbarEquipChanged").OnClientEvent:Connect(function(p12, p2) --[[ Line: 480 | Upvalues: p1 (copy) ]]
		local v2, v3

		if p2 then
			v2 = p2.ID

			if v2 then
				v3 = p12
			else
				v3 = p12
				v2 = nil
			end
		else
			v3 = p12
			v2 = nil
		end

		p1:_setWeaponSlot(v3, v2)
	end)
	Remotes.RefreshInventory.OnClientEvent:Connect(function() --[[ Line: 486 | Upvalues: p1 (copy) ]]
		p1:RefreshQuickAvailability()
	end)

	if LocalPlayer.Character then
		p1:_hookCharacter(LocalPlayer.Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p12) --[[ Line: 491 | Upvalues: p1 (copy) ]]
		p1:_hookCharacter(p12)
	end)
	task.defer(function() --[[ Line: 493 | Upvalues: p1 (copy) ]]
		p1:RefreshQuickAvailability()
	end)
end

return t5