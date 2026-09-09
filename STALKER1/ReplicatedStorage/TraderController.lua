-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local v1 = nil
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"))
local ItemIconStyle = require(ReplicatedStorage:WaitForChild("ItemIconStyle"))
local t = {}

t.__index = t

local t2 = {
	"All",
	"Weapons",
	"Ammo",
	"Armor",
	"Wearables",
	"Backpacks",
	"Uniforms",
	"Medical",
	"Food",
	"Barter",
	"Misc"
}
local v2 = UDim2.fromOffset(120, 120)
local v3 = UDim2.fromOffset(8, 8)

t.Gui = nil
t.MainFrame = nil
t.ResScale = nil
t.IsOpen = false
t.CurrentTrader = nil
t.Stock = {}
t.SelectedTab = "All"
t.Mode = "BUY"
t.SellQueue = {}
t._catCache = {}
t._roubleBalance = 0
function t.Init(p1) --[[ Init | Line: 53 ]]
	if not p1.Gui then
		p1:_buildGui()
		p1:_wireResScale()
		p1:_wireRemotes()
		p1:_wireInput()
		p1:_wireDeathClose()
		p1.Gui.Enabled = false
		print("[TraderController] initialized")
	end
end
function t._buildGui(p1) --[[ _buildGui | Line: 68 | Upvalues: LocalPlayer (copy), t2 (copy), v2 (copy), v3 (copy) ]]
	local TraderGui = Instance.new("ScreenGui")

	TraderGui.Name = "TraderGui"
	TraderGui.ResetOnSpawn = false
	TraderGui.IgnoreGuiInset = true
	TraderGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	TraderGui.DisplayOrder = 5
	TraderGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	local MainFrame = Instance.new("Frame")

	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.fromScale(0.325, 0.8)
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.Position = UDim2.fromScale(0.83, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 24)
	MainFrame.BackgroundTransparency = 0
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = TraderGui

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(48, 48, 48)
	UIStroke.Transparency = 0
	UIStroke.Thickness = 1
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Parent = MainFrame

	local UIGradient = Instance.new("UIGradient")

	UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 80, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 3, 2)) })
	UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.46875) })
	UIGradient.Rotation = -90
	UIGradient.Parent = MainFrame

	local ResScale = Instance.new("UIScale")

	ResScale.Name = "ResScale"
	ResScale.Scale = 1
	ResScale.Parent = MainFrame

	local Header = Instance.new("Frame")

	Header.Name = "Header"
	Header.Size = UDim2.new(1, 0, 0, 50)
	Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Header.BackgroundTransparency = 0
	Header.BorderSizePixel = 0
	Header.Parent = MainFrame

	local UIGradient2 = Instance.new("UIGradient")

	UIGradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) })
	UIGradient2.Rotation = -90
	UIGradient2.Parent = Header

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = Color3.fromRGB(48, 48, 48)
	UIStroke2.Transparency = 0
	UIStroke2.Thickness = 1
	UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke2.Parent = Header

	local TraderName = Instance.new("TextLabel")

	TraderName.Name = "TraderName"
	TraderName.Size = UDim2.new(0.4, 0, 1, 0)
	TraderName.Position = UDim2.fromOffset(15, 0)
	TraderName.BackgroundTransparency = 1
	TraderName.TextColor3 = Color3.fromRGB(197, 197, 197)
	TraderName.TextSize = 26
	TraderName.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TraderName.TextXAlignment = Enum.TextXAlignment.Left
	TraderName.Text = "Trader"
	TraderName.Parent = Header

	local ToggleHolder = Instance.new("Frame")

	ToggleHolder.Name = "ToggleHolder"
	ToggleHolder.Size = UDim2.fromOffset(180, 36)
	ToggleHolder.Position = UDim2.new(1, -240, 0.5, -18)
	ToggleHolder.BackgroundTransparency = 1
	ToggleHolder.Parent = Header

	local function makeToggle(p1, p2, p3) --[[ makeToggle | Line: 155 | Upvalues: ToggleHolder (copy) ]]
		local TextButton = Instance.new("TextButton")

		TextButton.Name = p1
		TextButton.Size = UDim2.fromOffset(85, 36)
		TextButton.Position = UDim2.fromOffset(p3, 0)
		TextButton.Text = p2
		TextButton.TextColor3 = Color3.fromRGB(240, 240, 240)
		TextButton.TextSize = 18
		TextButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
		TextButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
		TextButton.BorderSizePixel = 0
		TextButton.AutoButtonColor = false
		TextButton.Parent = ToggleHolder

		return TextButton
	end

	local v1 = makeToggle("BuyToggle", "BUY", 0)
	local v22 = makeToggle("SellToggle", "SELL", 95)
	local CloseButton = Instance.new("TextButton")

	CloseButton.Name = "CloseButton"
	CloseButton.Size = UDim2.fromOffset(36, 36)
	CloseButton.Position = UDim2.new(1, -45, 0.5, -18)
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.fromRGB(240, 240, 240)
	CloseButton.TextSize = 20
	CloseButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	CloseButton.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
	CloseButton.BorderSizePixel = 0
	CloseButton.AutoButtonColor = true
	CloseButton.Parent = Header

	local Body = Instance.new("Frame")

	Body.Name = "Body"
	Body.Size = UDim2.new(1, 0, 1, -130)
	Body.Position = UDim2.fromOffset(0, 50)
	Body.BackgroundTransparency = 1
	Body.Parent = MainFrame

	local TabsCol = Instance.new("Frame")

	TabsCol.Name = "TabsCol"
	TabsCol.Size = UDim2.new(0, 140, 1, 0)
	TabsCol.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	TabsCol.BackgroundTransparency = 0.8
	TabsCol.BorderSizePixel = 0
	TabsCol.Parent = Body

	local UIStroke3 = Instance.new("UIStroke")

	UIStroke3.Color = Color3.fromRGB(48, 48, 48)
	UIStroke3.Transparency = 0
	UIStroke3.Thickness = 1
	UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke3.Parent = TabsCol

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 2)
	UIListLayout.Parent = TabsCol

	for i, v in ipairs(t2) do
		local TextButton = Instance.new("TextButton")

		TextButton.Name = "Tab_" .. v
		TextButton.Size = UDim2.new(1, 0, 0, 42)
		TextButton.LayoutOrder = i
		TextButton.Text = v
		TextButton.TextColor3 = Color3.fromRGB(197, 197, 197)
		TextButton.TextSize = 16
		TextButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
		TextButton.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
		TextButton.BackgroundTransparency = 0.8
		TextButton.BorderSizePixel = 0
		TextButton.AutoButtonColor = false
		TextButton.Parent = TabsCol

		local UIStroke4 = Instance.new("UIStroke")

		UIStroke4.Color = Color3.fromRGB(48, 48, 48)
		UIStroke4.Transparency = 0
		UIStroke4.Thickness = 1
		UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke4.Parent = TextButton
	end

	local ItemGrid = Instance.new("ScrollingFrame")

	ItemGrid.Name = "ItemGrid"
	ItemGrid.Size = UDim2.new(1, -140, 1, 0)
	ItemGrid.Position = UDim2.fromOffset(140, 0)
	ItemGrid.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	ItemGrid.BackgroundTransparency = 0.8
	ItemGrid.BorderSizePixel = 0
	ItemGrid.ScrollBarThickness = 8
	ItemGrid.CanvasSize = UDim2.fromScale(0, 0)
	ItemGrid.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ItemGrid.Parent = Body

	local ItemContent = Instance.new("Frame")

	ItemContent.Name = "ItemContent"
	ItemContent.Size = UDim2.new(1, 0, 0, 0)
	ItemContent.AutomaticSize = Enum.AutomaticSize.Y
	ItemContent.BackgroundTransparency = 1
	ItemContent.Parent = ItemGrid

	local UIGridLayout = Instance.new("UIGridLayout")

	UIGridLayout.CellSize = v2
	UIGridLayout.CellPadding = v3
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.Parent = ItemContent

	local Footer = Instance.new("Frame")

	Footer.Name = "Footer"
	Footer.Size = UDim2.new(1, 0, 0, 80)
	Footer.Position = UDim2.new(0, 0, 1, -80)
	Footer.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	Footer.BackgroundTransparency = 0.8
	Footer.BorderSizePixel = 0
	Footer.Parent = MainFrame

	local UIStroke4 = Instance.new("UIStroke")

	UIStroke4.Color = Color3.fromRGB(48, 48, 48)
	UIStroke4.Transparency = 0
	UIStroke4.Thickness = 1
	UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke4.Parent = Footer

	local CartList = Instance.new("ScrollingFrame")

	CartList.Name = "CartList"
	CartList.Size = UDim2.new(1, -240, 1, -8)
	CartList.Position = UDim2.fromOffset(8, 4)
	CartList.BackgroundTransparency = 1
	CartList.BorderSizePixel = 0
	CartList.ScrollBarThickness = 6
	CartList.CanvasSize = UDim2.fromScale(0, 0)
	CartList.AutomaticCanvasSize = Enum.AutomaticSize.X
	CartList.ScrollingDirection = Enum.ScrollingDirection.X
	CartList.Parent = Footer

	local UIListLayout2 = Instance.new("UIListLayout")

	UIListLayout2.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout2.Padding = UDim.new(0, 6)
	UIListLayout2.Parent = CartList

	local TotalsLabel = Instance.new("TextLabel")

	TotalsLabel.Name = "TotalsLabel"
	TotalsLabel.Size = UDim2.fromOffset(220, 36)
	TotalsLabel.Position = UDim2.new(1, -230, 0, 4)
	TotalsLabel.BackgroundTransparency = 1
	TotalsLabel.TextColor3 = Color3.fromRGB(197, 197, 197)
	TotalsLabel.TextSize = 16
	TotalsLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	TotalsLabel.TextXAlignment = Enum.TextXAlignment.Right
	TotalsLabel.Text = string.format("Total: %s0\nBalance: %s0", "\226\130\189", "\226\130\189")
	TotalsLabel.Parent = Footer

	local ClearCart = Instance.new("TextButton")

	ClearCart.Name = "ClearCart"
	ClearCart.Size = UDim2.fromOffset(100, 32)
	ClearCart.Position = UDim2.new(1, -220, 1, -38)
	ClearCart.Text = "Clear Cart"
	ClearCart.TextColor3 = Color3.fromRGB(240, 240, 240)
	ClearCart.TextSize = 16
	ClearCart.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
	ClearCart.BackgroundColor3 = Color3.fromRGB(80, 50, 50)
	ClearCart.BorderSizePixel = 0
	ClearCart.Parent = Footer

	local Confirm = Instance.new("TextButton")

	Confirm.Name = "Confirm"
	Confirm.Size = UDim2.fromOffset(110, 32)
	Confirm.Position = UDim2.new(1, -115, 1, -38)
	Confirm.Text = "Confirm"
	Confirm.TextColor3 = Color3.fromRGB(240, 240, 240)
	Confirm.TextSize = 16
	Confirm.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Confirm.BackgroundColor3 = Color3.fromRGB(50, 110, 50)
	Confirm.BorderSizePixel = 0
	Confirm.Parent = Footer

	local ConfirmFailureToast = Instance.new("TextLabel")

	ConfirmFailureToast.Name = "ConfirmFailureToast"
	ConfirmFailureToast.Size = UDim2.fromOffset(280, 36)
	ConfirmFailureToast.Position = UDim2.new(0.5, -140, 0, 60)
	ConfirmFailureToast.AnchorPoint = Vector2.new(0, 0)
	ConfirmFailureToast.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
	ConfirmFailureToast.BorderSizePixel = 0
	ConfirmFailureToast.TextColor3 = Color3.fromRGB(255, 255, 255)
	ConfirmFailureToast.TextSize = 16
	ConfirmFailureToast.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
	ConfirmFailureToast.Text = ""
	ConfirmFailureToast.Visible = false
	ConfirmFailureToast.ZIndex = 10
	ConfirmFailureToast.Parent = MainFrame
	p1.Gui = TraderGui
	p1.MainFrame = MainFrame
	p1.ResScale = ResScale
	p1.Header = Header
	p1.TabsCol = TabsCol
	p1.ItemGrid = ItemGrid
	p1.ItemContent = ItemContent
	p1.Footer = Footer
	p1.CartList = CartList
	p1.TotalsLabel = TotalsLabel
	p1.ConfirmBtn = Confirm
	p1.ClearBtn = ClearCart
	p1.CloseBtn = CloseButton
	p1.BuyToggle = v1
	p1.SellToggle = v22
	p1.Toast = ConfirmFailureToast
end
function t._wireResScale(p1) --[[ _wireResScale | Line: 372 | Upvalues: CurrentCamera (ref) ]]
	local function apply() --[[ apply | Line: 373 | Upvalues: CurrentCamera (ref), p1 (copy) ]]
		p1.ResScale.Scale = math.clamp(CurrentCamera.ViewportSize.Y / 1080, 0.85, 1)
	end

	local v1 = CurrentCamera.ViewportSize.Y / 1080

	p1.ResScale.Scale = math.clamp(v1, 0.85, 1)
	CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(apply)
	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 380 | Upvalues: CurrentCamera (ref), p1 (copy), apply (copy) ]]
		CurrentCamera = workspace.CurrentCamera
		p1.ResScale.Scale = math.clamp(CurrentCamera.ViewportSize.Y / 1080, 0.85, 1)
		CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(apply)
	end)
end
function t._wireRemotes(p1) --[[ _wireRemotes | Line: 386 | Upvalues: ReplicatedStorage (copy), v1 (ref) ]]
	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	local TraderInventoryOpened = Remotes:WaitForChild("TraderInventoryOpened")
	local TraderRosterRefreshed = Remotes:WaitForChild("TraderRosterRefreshed")
	local TraderClosed = Remotes:WaitForChild("TraderClosed")
	local TraderError = Remotes:WaitForChild("TraderError")

	TraderInventoryOpened.OnClientEvent:Connect(function(p12, p2, p3, p4) --[[ Line: 393 | Upvalues: p1 (copy) ]]
		p1:Open(p12, p2, p3)
	end)
	TraderRosterRefreshed.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 397 | Upvalues: p1 (copy) ]]
		if not p1.IsOpen then
			return
		end

		p1.Stock = if p2 then p2 else {}
		p1:_renderItems()
	end)
	TraderClosed.OnClientEvent:Connect(function() --[[ Line: 403 | Upvalues: p1 (copy) ]]
		p1:Close("server-closed")
	end)
	TraderError.OnClientEvent:Connect(function(p12) --[[ Line: 407 | Upvalues: p1 (copy) ]]
		p1:_showToast("Trader error: " .. tostring(p12))
	end)

	local BalanceChanged = Remotes:WaitForChild("BalanceChanged")
	local RequestBalance = Remotes:WaitForChild("RequestBalance")

	BalanceChanged.OnClientEvent:Connect(function(p12) --[[ Line: 413 | Upvalues: p1 (copy) ]]
		p1._roubleBalance = p12 or 0

		if not p1.IsOpen then
			return
		end

		p1:_renderItems()
		p1:_renderCart()
	end)
	task.spawn(function() --[[ Line: 420 | Upvalues: RequestBalance (copy), p1 (copy) ]]
		local ok, result = pcall(function() --[[ Line: 421 | Upvalues: RequestBalance (ref) ]]
			return RequestBalance:InvokeServer()
		end)

		if not ok then
			return
		end

		p1._roubleBalance = result or 0
	end)
	p1.CloseBtn.MouseButton1Click:Connect(function() --[[ Line: 425 | Upvalues: p1 (copy), Remotes (copy) ]]
		p1:Close("user-closed")

		local CloseTrader = Remotes:FindFirstChild("CloseTrader")

		if not CloseTrader then
			return
		end

		CloseTrader:FireServer()
	end)
	p1.ClearBtn.MouseButton1Click:Connect(function() --[[ Line: 431 | Upvalues: v1 (ref), ReplicatedStorage (ref), p1 (copy) ]]
		v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

		if p1.Mode == "BUY" then
			if v1.BuyCart then
				table.clear(v1.BuyCart)
			end

			if v1.RefreshCartGhosts then
				v1:RefreshCartGhosts()
			end
		else
			for i, v in ipairs(p1.SellQueue) do
				p1:_setSellHighlight(v, false)
			end

			table.clear(p1.SellQueue)
		end

		p1:_renderItems()
		p1:_renderCart()
	end)
	p1.ConfirmBtn.MouseButton1Click:Connect(function() --[[ Line: 450 | Upvalues: p1 (copy) ]]
		if not p1.ConfirmBtn.Active then
			return
		end

		if p1.Mode == "BUY" then
			p1:_confirmBuy()
		else
			p1:_confirmSell()
		end
	end)
end
function t.Open(p1, p2, p3, p4) --[[ Open | Line: 460 | Upvalues: v1 (ref), ReplicatedStorage (copy), LocalPlayer (copy) ]]
	p1.CurrentTrader = p3
	p1.CurrentNPC = p2
	p1.Stock = if p4 then p4 else {}
	p1.IsOpen = true
	p1.SelectedTab = p1:_firstNonEmptyTab()
	p1.Mode = "BUY"
	p1.Header.TraderName.Text = p3.DisplayName or "Trader"
	p1.Gui.Enabled = true
	p1:_renderTabs()
	p1:_renderModeToggle()
	p1:_renderItems()
	p1:_renderCart()
	v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

	local InventoryGui = LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

	p1._wasInventoryOpen = InventoryGui and InventoryGui.Enabled or false

	if not p1._wasInventoryOpen then
		v1:OpenInventoryUI()
	end

	local v4 = if InventoryGui then InventoryGui.MainFrame and InventoryGui.MainFrame:FindFirstChild("ContainerFrame") else InventoryGui

	if v4 then
		p1._containerWasVisible = v4.Visible
		v4.Visible = false
	end

	if not (v1 and v1.CloseStoragePanel) then
		return
	end

	v1:CloseStoragePanel()
end
function t.Close(p1, p2) --[[ Close | Line: 503 | Upvalues: v1 (ref), ReplicatedStorage (copy), LocalPlayer (copy) ]]
	if not p1.IsOpen then
		return
	end

	p1.IsOpen = false
	p1.CurrentTrader = nil
	p1.CurrentNPC = nil
	p1.Stock = {}
	p1.Gui.Enabled = false
	v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

	if v1._destroyCartGhosts then
		v1:_destroyCartGhosts()
	end

	if v1.BuyCart then
		table.clear(v1.BuyCart)
	end

	if p1.SellQueue then
		for i, v in ipairs(p1.SellQueue) do
			p1:_setSellHighlight(v, false)
		end

		table.clear(p1.SellQueue)
	end

	local InventoryGui = LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")
	local v2 = if InventoryGui then InventoryGui.MainFrame and InventoryGui.MainFrame:FindFirstChild("ContainerFrame") else InventoryGui

	if v2 and p1._containerWasVisible ~= nil then
		v2.Visible = p1._containerWasVisible
	end

	p1._containerWasVisible = nil

	if p1._wasInventoryOpen == false then
		v1:CloseInventoryUI()
	end

	p1._wasInventoryOpen = nil

	local ok, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1))

	if not (ok and (result and result.IsOpen)) then
		return
	end

	result:Close()
end
function t._firstNonEmptyTab(p1) --[[ _firstNonEmptyTab | Line: 540 | Upvalues: t2 (copy) ]]
	if #p1.Stock > 0 then
		return "All"
	end

	for i, v in ipairs(t2) do
		if v ~= "All" then
			for i2, v2 in ipairs(p1.Stock) do
				if v2.Category == v then
					return v
				end
			end
		end
	end

	return t2[1]
end
function t._wireDeathClose(p1) --[[ _wireDeathClose | Line: 569 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy) ]]
	local function hookCharacter(p12) --[[ hookCharacter | Line: 570 | Upvalues: p1 (copy), ReplicatedStorage (ref) ]]
		local v1 = p12:FindFirstChildOfClass("Humanoid") or p12:WaitForChild("Humanoid", 10)

		if v1 then
			v1.Died:Connect(function() --[[ Line: 573 | Upvalues: p1 (ref), ReplicatedStorage (ref) ]]
				if not p1.IsOpen then
					return
				end

				p1:Close("died")

				local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
				local v1 = if Remotes then Remotes:FindFirstChild("CloseTrader") else Remotes

				if not v1 then
					return
				end

				v1:FireServer()
			end)
		end
	end

	if LocalPlayer.Character then
		task.spawn(hookCharacter, LocalPlayer.Character)
	end

	LocalPlayer.CharacterAdded:Connect(hookCharacter)
	LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 588 | Upvalues: p1 (copy) ]]
		if not p1.IsOpen then
			return
		end

		p1:Close("respawned")
	end)
end
function t._wireInput(p1) --[[ _wireInput | Line: 593 | Upvalues: UserInputService (copy), ReplicatedStorage (copy) ]]
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 594 | Upvalues: p1 (copy), ReplicatedStorage (ref) ]]
		if p2 then
			return
		end

		if not p1.IsOpen then
			return
		end

		if p12.KeyCode ~= Enum.KeyCode.Tab then
			return
		end

		p1:Close("user-key")

		local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
		local v1 = if Remotes then Remotes:FindFirstChild("CloseTrader") else Remotes

		if not v1 then
			return
		end

		v1:FireServer()
	end)
end
function t._renderTabs(p1) --[[ _renderTabs | Line: 605 | Upvalues: t2 (copy) ]]
	for i, v in ipairs(t2) do
		local v1 = p1.TabsCol:FindFirstChild("Tab_" .. v)

		if v1 then
			local v2 = p1:_tabIsEmpty(v)

			if v == p1.SelectedTab then
				v1.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
				v1.BackgroundTransparency = 0
				v1.TextColor3 = Color3.fromRGB(255, 230, 130)
			elseif v2 then
				v1.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
				v1.BackgroundTransparency = 1
				v1.TextColor3 = Color3.fromRGB(110, 110, 110)
			else
				v1.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
				v1.BackgroundTransparency = 0.8
				v1.TextColor3 = Color3.fromRGB(197, 197, 197)
			end

			if not v1:GetAttribute("__wired") then
				v1:SetAttribute("__wired", true)
				v1.MouseButton1Click:Connect(function() --[[ Line: 626 | Upvalues: p1 (copy), v (copy) ]]
					p1.SelectedTab = v
					p1:_renderTabs()
					p1:_renderItems()
				end)
			end
		end
	end
end
function t._tabIsEmpty(p1, p2) --[[ _tabIsEmpty | Line: 635 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
	if p1.Mode == "BUY" then
		if p2 == "All" then
			return #p1.Stock == 0
		end

		for i, v in ipairs(p1.Stock) do
			if v.Category == p2 then
				return false
			end
		end
	else
		v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

		local v3 = p1:_getSellableInventory(v1)

		if p2 == "All" then
			return #v3 == 0
		end

		for i, v in ipairs(v3) do
			if v.Category == p2 then
				return false
			end
		end
	end

	return true
end
function t._categoryOf(p1, p2) --[[ _categoryOf | Line: 652 | Upvalues: ReplicatedStorage (copy) ]]
	if p1._catCache[p2] then
		return p1._catCache[p2]
	end

	local ItemDatabase = ReplicatedStorage:FindFirstChild("ItemDatabase")
	local v1 = if ItemDatabase then ItemDatabase:FindFirstChild("Categories") else ItemDatabase

	if not v1 then
		p1._catCache[p2] = "Misc"

		return "Misc"
	end

	for i, v in ipairs(v1:GetChildren()) do
		if v:IsA("ModuleScript") then
			local ok, result = pcall(require, v)

			if ok and (type(result) == "table" and result[p2] ~= nil) then
				p1._catCache[p2] = v.Name

				return v.Name
			end
		end
	end

	p1._catCache[p2] = "Misc"

	return "Misc"
end
t._lootCatCache = {}
function t._lootCategoryOf(p1, p2) --[[ _lootCategoryOf | Line: 674 | Upvalues: ItemDatabase (copy), ReplicatedStorage (copy) ]]
	if p1._lootCatCache[p2] ~= nil then
		return p1._lootCatCache[p2]
	end

	local v1 = ItemDatabase.GetItemData(p2)

	if v1 and (v1.LootCategory and v1.LootCategory ~= "") then
		p1._lootCatCache[p2] = v1.LootCategory

		return v1.LootCategory
	end

	local PlayerItems = ReplicatedStorage:FindFirstChild("PlayerItems")
	local v2 = if PlayerItems then PlayerItems:FindFirstChild(p2, true) else PlayerItems
	local v3 = if v2 then v2:GetAttribute("LootCategory") else v2

	p1._lootCatCache[p2] = v3 or false

	return v3
end
function t._getSellableInventory(p1, p2) --[[ _getSellableInventory | Line: 688 | Upvalues: ItemDatabase (copy) ]]
	local t = {}
	local CurrentTrader = p1.CurrentTrader

	if not CurrentTrader then
		return t
	end

	local v2 = if CurrentTrader.BuysEverything == true then true else false
	local v3 = CurrentTrader.BuybackMultiplier or 0.5
	local t2 = {}

	for i, v in ipairs(CurrentTrader.Buys or {}) do
		t2[v] = true
	end

	local function traderAccepts(p1) --[[ traderAccepts | Line: 700 | Upvalues: v2 (copy), t2 (copy) ]]
		if v2 then
			return true
		end

		return t2[p1] == true
	end

	local function tiedOf(p1) --[[ tiedOf | Line: 708 ]]
		return if p1 then p1.Metadata and p1.Metadata.TiedInstance else p1
	end

	local list = {}
	local t3 = {
		key = "Pockets",
		grid = p2.LocalInventory
	}
	local LocalInventory = p2.LocalInventory

	t3.tied = if LocalInventory then LocalInventory.Metadata and LocalInventory.Metadata.TiedInstance else LocalInventory

	local t4 = {
		key = "ChestRig",
		grid = p2.ChestRigInventory
	}
	local ChestRigInventory = p2.ChestRigInventory

	t4.tied = if ChestRigInventory then ChestRigInventory.Metadata and ChestRigInventory.Metadata.TiedInstance else ChestRigInventory

	local t5 = {
		key = "BattleBelt",
		grid = p2.BattleBeltInventory
	}
	local BattleBeltInventory = p2.BattleBeltInventory

	t5.tied = if BattleBeltInventory then BattleBeltInventory.Metadata and BattleBeltInventory.Metadata.TiedInstance else BattleBeltInventory

	local t6 = {
		key = "Backpack",
		grid = p2.MainInventory
	}
	local MainInventory = p2.MainInventory

	t6.tied = if MainInventory then MainInventory.Metadata and MainInventory.Metadata.TiedInstance else MainInventory
	list[1] = t3
	list[2] = t4
	list[3] = t5
	list[4] = t6

	local t7 = {}

	for v10, v11 in ipairs(p1.SellQueue or {}) do
		local v13 = tostring(v11.sourceKey or v11.sourceInv)
		local v14 = tostring(v11.itemID)

		t7[v14 .. "|" .. v13 .. "|" .. tostring(v11.itemIndex)] = true
	end

	for i, v in ipairs(list) do
		local grid = v.grid

		if grid and grid.Items then
			for k, v10 in pairs(grid.Items) do
				if v10 and (v10.Metadata and v10.Metadata.ID) then
					local ID = v10.Metadata.ID
					local v15 = ItemDatabase.GetItemData(ID)

					if v15 then
						local BaseSellValue = v15.BaseSellValue

						if BaseSellValue and not (BaseSellValue <= 0) then
							local v16 = p1:_categoryOf(ID)
							local v17 = p1:_lootCategoryOf(ID)
							local v18 = tostring(ID)
							local v19 = tostring(v.key)

							if (if v2 then true elseif t2[v17] == true then true else false) and (not t7[v18 .. "|" .. v19 .. "|" .. tostring(v10.Metadata.ItemIndex)] and v.tied ~= nil) then
								table.insert(t, {
									qty = 1,
									itemID = ID,
									name = v15.Name or ID,
									price = math.floor(BaseSellValue * v3),
									category = v16,
									Category = v16,
									sourceInv = v.tied,
									sourceKey = v.key,
									position = v10.Position,
									itemIndex = v10.Metadata.ItemIndex
								})
							end
						end
					end
				end
			end
		end
	end

	for i, v in ipairs({
		{
			slotKey = "Head",
			ref = p2.HeadSlot
		},
		{
			slotKey = "FaceWear",
			ref = p2.FaceWearSlot
		},
		{
			slotKey = "EyeWear",
			ref = p2.EyeWearSlot
		},
		{
			slotKey = "Body",
			ref = p2.BodySlot
		},
		{
			slotKey = "BeltGear",
			ref = p2.BeltGearSlot
		},
		{
			slotKey = "Primary",
			ref = p2.PrimarySlot
		},
		{
			slotKey = "Secondary",
			ref = p2.SecondarySlot
		},
		{
			slotKey = "Sidearm",
			ref = p2.SidearmSlot
		},
		{
			slotKey = "Melee",
			ref = p2.MeleeSlot
		},
		{
			slotKey = "Uniform",
			ref = p2.UniformSlot
		},
		{
			slotKey = "Backpack",
			ref = p2.BackpackSlot
		},
		{
			slotKey = "NightOptical",
			ref = p2.NightOpticalSlot
		}
	}) do
		local ref = v.ref
		local v22 = if ref then ref.Metadata and ref.Metadata.TiedInstance else ref
		local v23 = if ref then ref.Item else ref

		if v23 and (v22 ~= nil and (v23.Metadata and v23.Metadata.ID)) then
			local ID = v23.Metadata.ID
			local v24 = ItemDatabase.GetItemData(ID)
			local v25 = if v24 then v24.BaseSellValue else v24
			local v26 = p1:_categoryOf(ID)
			local v27 = p1:_lootCategoryOf(ID)

			if v24 and (v25 and v25 > 0) then
				local v28 = "Equip:" .. v.slotKey
				local v29 = tostring(ID)

				if (if v2 then true elseif t2[v27] == true then true else false) and not t7[v29 .. "|" .. v28 .. "|" .. tostring(v23.Metadata.ItemIndex)] then
					table.insert(t, {
						qty = 1,
						kind = "equipment",
						position = nil,
						itemID = ID,
						name = v24.Name or ID,
						price = math.floor(v25 * v3),
						category = v26,
						Category = v26,
						sourceInv = v22,
						sourceKey = v28,
						slotKey = v.slotKey,
						itemType = v23.Metadata.ItemType,
						itemIndex = v23.Metadata.ItemIndex,
						tied = v22
					})
				end
			end
		end
	end

	return t
end
function t._addToSellQueue(p1, p2) --[[ _addToSellQueue | Line: 817 ]]
	local v1 = tostring(p2.itemID)
	local v4 = tostring(p2.sourceKey or p2.sourceInv)
	local v5 = v1 .. "|" .. v4 .. "|" .. tostring(p2.itemIndex)

	for i, v in ipairs(p1.SellQueue) do
		local v6 = tostring(v.itemID)
		local v9 = tostring(v.sourceKey or v.sourceInv)

		if v6 .. "|" .. v9 .. "|" .. tostring(v.itemIndex) == v5 then
			return
		end
	end

	table.insert(p1.SellQueue, p2)
	p1:_setSellHighlight(p2, true)
	p1:_renderItems()
	p1:_renderCart()
end
function t._setSellHighlight(p1, p2, p3) --[[ _setSellHighlight | Line: 831 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
	v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

	local v2 = nil

	for i, v in ipairs({
		v1.LocalInventory,
		v1.ChestRigInventory,
		v1.BattleBeltInventory,
		v1.MainInventory,
		v1.HeadSlot,
		v1.FaceWearSlot,
		v1.EyeWearSlot,
		v1.BodySlot,
		v1.BeltGearSlot,
		v1.PrimarySlot,
		v1.SecondarySlot,
		v1.SidearmSlot,
		v1.MeleeSlot,
		v1.UniformSlot,
		v1.BackpackSlot,
		v1.NightOpticalSlot
	}) do
		if v and (v.Metadata and v.Metadata.TiedInstance == p2.sourceInv) then
			v2 = v

			break
		end
	end

	if not (v2 and v2.Items) then
		return
	end

	local v3 = nil

	for k, v in pairs(v2.Items) do
		if v and (v.Metadata and v.Metadata.ItemIndex == p2.itemIndex) then
			v3 = v

			break
		end
	end

	if not (v3 and v3.ItemElement) then
		return
	end

	local ItemElement = v3.ItemElement
	local __SellHighlight = ItemElement:FindFirstChild("__SellHighlight")

	if p3 then
		if not __SellHighlight then
			local __SellHighlight2 = Instance.new("UIStroke")

			__SellHighlight2.Name = "__SellHighlight"
			__SellHighlight2.Color = Color3.fromRGB(80, 220, 80)
			__SellHighlight2.Thickness = 2
			__SellHighlight2.Transparency = 0
			__SellHighlight2.Parent = ItemElement
		end
	else
		if not __SellHighlight then
			return
		end

		__SellHighlight:Destroy()
	end
end
function t._renderModeToggle(p1) --[[ _renderModeToggle | Line: 882 ]]
	local function paint(p1, p2) --[[ paint | Line: 883 ]]
		if p2 then
			p1.BackgroundColor3 = Color3.fromRGB(255, 200, 90)
			p1.TextColor3 = Color3.fromRGB(20, 20, 22)
		else
			p1.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
			p1.TextColor3 = Color3.fromRGB(240, 240, 240)
		end
	end

	paint(p1.BuyToggle, p1.Mode == "BUY")
	paint(p1.SellToggle, p1.Mode == "SELL")

	if not p1.BuyToggle:GetAttribute("__wired") then
		p1.BuyToggle:SetAttribute("__wired", true)
		p1.BuyToggle.MouseButton1Click:Connect(function() --[[ Line: 897 | Upvalues: p1 (copy) ]]
			if p1.Mode ~= "BUY" then
				p1.Mode = "BUY"
				p1.SelectedTab = p1:_firstNonEmptyTab()
				p1:_renderModeToggle()
				p1:_renderTabs()
				p1:_renderItems()
			end
		end)
	end

	if p1.SellToggle:GetAttribute("__wired") then
		return
	end

	p1.SellToggle:SetAttribute("__wired", true)
	p1.SellToggle.MouseButton1Click:Connect(function() --[[ Line: 908 | Upvalues: p1 (copy) ]]
		if p1.Mode ~= "SELL" then
			p1.Mode = "SELL"
			p1.SelectedTab = p1:_firstNonEmptyTab()
			p1:_renderModeToggle()
			p1:_renderTabs()
			p1:_renderItems()
		end
	end)
end
function t._renderItems(p1) --[[ _renderItems | Line: 918 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
	for i, v in ipairs(p1.ItemContent:GetChildren()) do
		if (v:IsA("TextButton") or v:IsA("Frame")) and v.Name:sub(1, 5) == "Card_" then
			v:Destroy()
		end
	end

	local isSelectedTab = p1.SelectedTab == "All"

	if p1.Mode == "BUY" then
		for i, v in ipairs(p1.Stock) do
			if isSelectedTab or v.Category == p1.SelectedTab then
				p1:_renderBuyCard(v)
			end
		end
	else
		v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

		for i, v in ipairs(p1:_getSellableInventory(v1)) do
			if isSelectedTab or v.Category == p1.SelectedTab then
				p1:_renderSellCard(v, v1)
			end
		end
	end
end
function t._renderBuyCard(p1, p2) --[[ _renderBuyCard | Line: 942 | Upvalues: ItemDatabase (copy), ItemIconStyle (copy), v1 (ref), ReplicatedStorage (copy) ]]
	local v12 = ItemDatabase.GetItemData(p2.ID)

	if not v12 then
		return
	end

	local TextButton = Instance.new("TextButton")

	TextButton.Name = "Card_" .. p2.ID
	TextButton.Text = ""
	TextButton.AutoButtonColor = false
	TextButton.BackgroundColor3 = v12.BackgroundColor or Color3.fromRGB(50, 50, 55)
	TextButton.BackgroundTransparency = v12.BackgroundTransparency or 0.2
	TextButton.BorderSizePixel = 0
	TextButton.Parent = p1.ItemContent

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Thickness = 1
	UIStroke.Color = Color3.fromRGB(80, 80, 85)
	UIStroke.Parent = TextButton

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, -8, 0, 16)
	TextLabel.Position = UDim2.fromOffset(4, 4)
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
	TextLabel.TextSize = 14
	TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel.Text = v12.Name or p2.ID
	TextLabel.Parent = TextButton

	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.Size = UDim2.new(1, -16, 1, -52)
	ImageLabel.Position = UDim2.fromOffset(8, 22)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Image = v12.ImageID or ""
	ImageLabel.ScaleType = ItemIconStyle.ScaleTypeFor(v12)
	ImageLabel.Parent = TextButton

	if (not v12.ImageID or v12.ImageID == "") and v12.Model then
		local v4 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

		v1 = v4
		pcall(function() --[[ Line: 985 | Upvalues: v4 (copy), ImageLabel (copy), v12 (copy) ]]
			v4:AttachViewportIcon(ImageLabel, v12.Model, v12.ItemType)
		end)
	end

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(0.6, 0, 0, 16)
	TextLabel2.Position = UDim2.new(0, 4, 1, -20)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.TextColor3 = Color3.fromRGB(255, 220, 130)
	TextLabel2.TextSize = 14
	TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Text = "\226\130\189" .. p1:_formatNumber(p2.Price)
	TextLabel2.Parent = TextButton

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.new(0.4, -4, 0, 16)
	TextLabel3.Position = UDim2.new(0.6, 0, 1, -20)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.TextColor3 = Color3.fromRGB(180, 180, 180)
	TextLabel3.TextSize = 13
	TextLabel3.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel3.Text = "x" .. tostring(p2.Quantity or 1)
	TextLabel3.Parent = TextButton
	p1:_applyCardState(TextButton, p2, v12)
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 1012 | Upvalues: p1 (copy), p2 (copy), v12 (copy) ]]
		p1:_onBuyCardClicked(p2, v12)
	end)

	if (p2.Quantity or 0) > 0 then
		local R = TextButton.BackgroundColor3.R
		local G = TextButton.BackgroundColor3.G
		local B = TextButton.BackgroundColor3.B

		TextButton:SetAttribute("__BaseR", R)
		TextButton:SetAttribute("__BaseG", G)
		TextButton:SetAttribute("__BaseB", B)
		TextButton.MouseEnter:Connect(function() --[[ Line: 1021 | Upvalues: TextButton (copy), R (copy), G (copy), B (copy) ]]
			local v1 = TextButton:GetAttribute("__BaseR") or R
			local v2 = TextButton:GetAttribute("__BaseG") or G

			TextButton.BackgroundColor3 = Color3.new(v1, v2, TextButton:GetAttribute("__BaseB") or B):Lerp(Color3.new(255/255, 255/255, 255/255), 0.12)
		end)
		TextButton.MouseLeave:Connect(function() --[[ Line: 1027 | Upvalues: TextButton (copy), R (copy), G (copy), B (copy) ]]
			local v1 = TextButton:GetAttribute("__BaseR") or R
			local v2 = TextButton:GetAttribute("__BaseG") or G

			TextButton.BackgroundColor3 = Color3.new(v1, v2, TextButton:GetAttribute("__BaseB") or B)
		end)
	end

	TextButton.MouseButton2Click:Connect(function() --[[ Line: 1035 | Upvalues: v1 (ref), ReplicatedStorage (ref), p2 (copy) ]]
		v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

		if not v1.ShowDetailsPanel then
			return
		end

		v1:ShowDetailsPanel(p2.ID, {
			Metadata = {
				ID = p2.ID
			}
		})
	end)
end
function t._applyCardState(p1, p2, p3, p4) --[[ _applyCardState | Line: 1043 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
	local v12 = p1:_getPlayerRoubles()
	local UIStroke = p2:FindFirstChildOfClass("UIStroke")

	if (p3.Quantity or 0) <= 0 then
		p2.BackgroundColor3 = Color3.fromRGB(40, 40, 42)
		p2.BackgroundTransparency = 0.4

		if UIStroke then
			UIStroke.Color = Color3.fromRGB(60, 60, 60)
		end
	elseif v12 < p3.Price then
		p2.BackgroundColor3 = Color3.fromRGB(80, 30, 30)

		if UIStroke then
			UIStroke.Color = Color3.fromRGB(120, 50, 50)
		end
	end

	v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

	if not v1.BuyCart then
		return
	end

	for i, v in ipairs(v1.BuyCart) do
		if v.itemID == p3.ID then
			if UIStroke then
				UIStroke.Color = Color3.fromRGB(255, 220, 130)
				UIStroke.Thickness = 2

				return
			end

			break
		end
	end
end
function t._formatNumber(p1, p2) --[[ _formatNumber | Line: 1069 ]]
	return tostring((math.floor(p2))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end
function t._getPlayerRoubles(p1) --[[ _getPlayerRoubles | Line: 1074 ]]
	return p1._roubleBalance or 0
end
function t._renderSellCard(p1, p2, p3) --[[ _renderSellCard | Line: 1078 | Upvalues: ItemDatabase (copy), ItemIconStyle (copy), v1 (ref), ReplicatedStorage (copy) ]]
	local v12 = ItemDatabase.GetItemData(p2.itemID)

	if not v12 then
		return
	end

	local TextButton = Instance.new("TextButton")
	local v3 = tostring(p2.itemID)
	local v6 = tostring(p2.sourceKey or p2.sourceInv or "")

	TextButton.Name = "Card_Sell_" .. v3 .. "_" .. v6 .. "_" .. tostring(p2.itemIndex or "")
	TextButton.Text = ""
	TextButton.AutoButtonColor = false
	TextButton.BackgroundColor3 = Color3.fromRGB(35, 50, 35)
	TextButton.BackgroundTransparency = 0.2
	TextButton.BorderSizePixel = 0
	TextButton.Parent = p1.ItemContent

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Thickness = 1
	UIStroke.Color = Color3.fromRGB(60, 100, 60)
	UIStroke.Parent = TextButton

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, -8, 0, 16)
	TextLabel.Position = UDim2.fromOffset(4, 4)
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextColor3 = Color3.fromRGB(220, 240, 220)
	TextLabel.TextSize = 14
	TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel.Text = v12.Name or p2.itemID
	TextLabel.Parent = TextButton

	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.Size = UDim2.new(1, -16, 1, -52)
	ImageLabel.Position = UDim2.fromOffset(8, 22)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Image = v12.ImageID or ""
	ImageLabel.ScaleType = ItemIconStyle.ScaleTypeFor(v12)
	ImageLabel.Parent = TextButton

	if (not v12.ImageID or v12.ImageID == "") and v12.Model then
		local v9 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

		v1 = v9
		pcall(function() --[[ Line: 1120 | Upvalues: v9 (copy), ImageLabel (copy), v12 (copy) ]]
			v9:AttachViewportIcon(ImageLabel, v12.Model, v12.ItemType)
		end)
	end

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(1, -8, 0, 16)
	TextLabel2.Position = UDim2.new(0, 4, 1, -20)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.TextColor3 = Color3.fromRGB(140, 230, 140)
	TextLabel2.TextSize = 14
	TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Text = "+" .. "\226\130\189" .. p1:_formatNumber(p2.price or 0)
	TextLabel2.Parent = TextButton
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 1134 | Upvalues: p1 (copy), p2 (copy) ]]
		p1:_addToSellQueue(p2)
	end)

	local R = TextButton.BackgroundColor3.R
	local G = TextButton.BackgroundColor3.G
	local B = TextButton.BackgroundColor3.B

	TextButton:SetAttribute("__BaseR", R)
	TextButton:SetAttribute("__BaseG", G)
	TextButton:SetAttribute("__BaseB", B)
	TextButton.MouseEnter:Connect(function() --[[ Line: 1142 | Upvalues: TextButton (copy), R (copy), G (copy), B (copy) ]]
		local v1 = TextButton:GetAttribute("__BaseR") or R
		local v2 = TextButton:GetAttribute("__BaseG") or G

		TextButton.BackgroundColor3 = Color3.new(v1, v2, TextButton:GetAttribute("__BaseB") or B):Lerp(Color3.new(255/255, 255/255, 255/255), 0.12)
	end)
	TextButton.MouseLeave:Connect(function() --[[ Line: 1148 | Upvalues: TextButton (copy), R (copy), G (copy), B (copy) ]]
		local v1 = TextButton:GetAttribute("__BaseR") or R
		local v2 = TextButton:GetAttribute("__BaseG") or G

		TextButton.BackgroundColor3 = Color3.new(v1, v2, TextButton:GetAttribute("__BaseB") or B)
	end)
	TextButton.MouseButton2Click:Connect(function() --[[ Line: 1155 | Upvalues: v1 (ref), ReplicatedStorage (ref), p2 (copy) ]]
		v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

		if not v1.ShowDetailsPanel then
			return
		end

		local v2 = nil

		for i, v in ipairs({
			v1.LocalInventory,
			v1.ChestRigInventory,
			v1.BattleBeltInventory,
			v1.MainInventory
		}) do
			if v and (v.Metadata and v.Metadata.TiedInstance == p2.sourceInv) then
				v2 = v

				break
			end
		end

		local v3 = nil

		if v2 and v2.Items then
			for k, v in pairs(v2.Items) do
				if v and (v.Metadata and v.Metadata.ItemIndex == p2.itemIndex) then
					v3 = v

					break
				end
			end
		end

		v1:ShowDetailsPanel(p2.itemID, if v3 then v3 else {
	Metadata = {
		ID = p2.itemID
	}
})
	end)
end
function t._onBuyCardClicked(p1, p2, p3) --[[ _onBuyCardClicked | Line: 1183 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
	if (p2.Quantity or 0) <= 0 then
		return
	end

	if p1:_getPlayerRoubles() < p2.Price then
		p1:_showToast("Insufficient funds")

		return
	end

	v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

	local function totalQtyForItem() --[[ totalQtyForItem | Line: 1193 | Upvalues: v1 (ref), p2 (copy) ]]
		local sum = 0

		if not v1.BuyCart then
			return 0
		end

		for i, v in ipairs(v1.BuyCart) do
			if v.itemID == p2.ID then
				sum = sum + (v.qty or 1)
			end
		end

		return sum
	end

	local v2 = totalQtyForItem()
	local v3, v4

	if v1.AddToBuyCart then
		local ok, result = pcall(function() --[[ Line: 1208 | Upvalues: v1 (ref), p2 (copy) ]]
			v1:AddToBuyCart(p2.ID, p2.Price, nil, nil)
		end)

		v3 = ok
		v4 = result
	else
		v3 = false
		v4 = "AddToBuyCart not exposed on InventoryController"
	end

	if not v3 then
		p1:_showToast("Cannot add: " .. tostring(v4))

		return
	end

	if totalQtyForItem() <= v2 then
		p1:_showToast("No inventory space")

		return
	end

	if not v1.RefreshCartGhosts then
		p1:_renderItems()
		p1:_renderCart()

		return
	end

	v1:RefreshCartGhosts()
	p1:_renderItems()
	p1:_renderCart()
end
function t._renderCart(p1) --[[ _renderCart | Line: 1232 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
	for i, v in ipairs(p1.CartList:GetChildren()) do
		if v:IsA("Frame") and v.Name:sub(1, 4) == "Row_" then
			v:Destroy()
		end
	end

	v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

	local v2 = if p1.Mode == "BUY" then v1.BuyCart or {} else p1.SellQueue or {}
	local sum = 0

	for i, v in ipairs(v2) do
		local v5 = (v.price or 0) * (v.qty or 1)
		local Frame = Instance.new("Frame")

		Frame.Name = "Row_" .. i
		Frame.Size = UDim2.fromOffset(150, 64)
		Frame.LayoutOrder = i
		Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
		Frame.BorderSizePixel = 0
		Frame.Parent = p1.CartList

		local TextButton = Instance.new("TextButton")

		TextButton.Size = UDim2.fromOffset(18, 18)
		TextButton.Position = UDim2.new(1, -20, 0, 2)
		TextButton.BackgroundTransparency = 1
		TextButton.Text = "X"
		TextButton.TextColor3 = Color3.fromRGB(255, 120, 120)
		TextButton.TextSize = 16
		TextButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		TextButton.Parent = Frame
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 1267 | Upvalues: p1 (copy), i (copy) ]]
			p1:_removeCartEntry(i)
		end)

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.new(1, -8, 0, 18)
		TextLabel.Position = UDim2.fromOffset(4, 4)
		TextLabel.BackgroundTransparency = 1
		TextLabel.TextColor3 = Color3.fromRGB(197, 197, 197)
		TextLabel.TextSize = 14
		TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
		TextLabel.Text = v.name or v.itemID
		TextLabel.Parent = Frame

		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Size = UDim2.new(1, -8, 0, 14)
		TextLabel2.Position = UDim2.new(0, 4, 1, -18)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.TextColor3 = Color3.fromRGB(255, 220, 130)
		TextLabel2.TextSize = 13
		TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.Text = "\226\130\189" .. p1:_formatNumber(v5)
		TextLabel2.Parent = Frame
		sum = sum + v5
	end

	local v7 = p1:_getPlayerRoubles()
	local v8 = if p1.Mode == "BUY" then v7 - sum else v7 + sum

	p1.TotalsLabel.Text = string.format("Total: %s%s\nBalance: %s%s -> %s%s", "\226\130\189", p1:_formatNumber(sum), "\226\130\189", p1:_formatNumber(v7), "\226\130\189", p1:_formatNumber(v8))

	local v9 = if p1.Mode == "BUY" then if #v2 > 0 then v8 >= 0 else false elseif #v2 > 0 then true else false

	p1.ConfirmBtn.Active = v9
	p1.ConfirmBtn.AutoButtonColor = v9
	p1.ConfirmBtn.BackgroundColor3 = v9 and Color3.fromRGB(50, 110, 50) or Color3.fromRGB(50, 60, 50)
	p1.ConfirmBtn.TextColor3 = v9 and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(120, 120, 120)
end
function t._removeCartEntry(p1, p2) --[[ _removeCartEntry | Line: 1325 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
	if p1.Mode == "BUY" then
		v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

		if not v1.BuyCart then
			return
		end

		table.remove(v1.BuyCart, p2)

		if v1.RefreshCartGhosts then
			v1:RefreshCartGhosts()
		end
	else
		local v2 = table.remove(p1.SellQueue, p2)

		if v2 then
			p1:_setSellHighlight(v2, false)
		end
	end

	p1:_renderItems()
	p1:_renderCart()
end
function t._confirmBuy(p1) --[[ _confirmBuy | Line: 1343 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
	v1 = v1 or require(ReplicatedStorage:WaitForChild("InventoryController"))

	local v2 = v1.BuyCart or {}

	if #v2 == 0 then
		return
	end

	local BuyBulk = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuyBulk")
	local t = {}

	for i, v in ipairs(v2) do
		local t2 = {
			itemID = v.itemID,
			qty = v.qty or 1
		}

		if v.preferredGrid and (v.preferredPos and (v.preferredGrid.Metadata and v.preferredGrid.Metadata.TiedInstance)) then
			t2.preferredTied = v.preferredGrid.Metadata.TiedInstance
			t2.preferredPos = {
				X = v.preferredPos.X,
				Y = v.preferredPos.Y
			}
		end

		table.insert(t, t2)
	end

	local ok, result = pcall(function() --[[ Line: 1364 | Upvalues: BuyBulk (copy), p1 (copy), t (copy) ]]
		return BuyBulk:InvokeServer(p1.CurrentNPC, t)
	end)

	if not ok then
		p1:_showToast("Server error")

		return
	end

	if not result or (not result.bought or result.bought == 0) then
		return
	end

	if result.rejected and #result.rejected > 0 then
		local v3 = result.rejected[1]
		local v4 = type(v3) == "table" and v3.reason or "rejected"

		if result.items then
			for i, v in ipairs(result.items) do
				for i2 = 1, #v2 do
					if v2[i2] and v2[i2].itemID == v then
						table.remove(v2, i2)

						break
					end
				end
			end

			if v1.RefreshCartGhosts then
				v1:RefreshCartGhosts()
			end
		end

		p1:_showToast(string.format("Bought %d, %d failed: %s", result.bought, #result.rejected, (tostring(v4))))
	else
		table.clear(v2)

		if not v1.RefreshCartGhosts then
			p1:_renderItems()
			p1:_renderCart()

			return
		end

		v1:RefreshCartGhosts()
	end

	p1:_renderItems()
	p1:_renderCart()
end
function t._confirmSell(p1) --[[ _confirmSell | Line: 1423 | Upvalues: ReplicatedStorage (copy), v1 (ref) ]]
	if #p1.SellQueue == 0 then
		return
	end

	local TraderConfirmSell = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TraderConfirmSell")
	local t = {}

	for i, v in ipairs(p1.SellQueue) do
		table.insert(t, {
			itemID = v.itemID,
			qty = v.qty or 1,
			sourceInv = v.sourceInv,
			position = v.position,
			itemIndex = v.itemIndex,
			kind = v.kind,
			slotKey = v.slotKey,
			itemType = v.itemType
		})
	end

	local ok, result = pcall(function() --[[ Line: 1448 | Upvalues: TraderConfirmSell (copy), p1 (copy), t (copy) ]]
		return TraderConfirmSell:InvokeServer(p1.CurrentNPC, t)
	end)

	if not ok then
		p1:_showToast("Server error")

		return
	end

	if result and (result.sold or 0) ~= 0 then
		if result.rejected and #result.rejected > 0 then
			local v12 = result.rejected[1]

			p1:_showToast(string.format("Sold %d (+%s%d), %d rejected: %s", result.sold, "\226\130\189", result.totalPayout or 0, #result.rejected, (tostring(if type(v12) == "table" then v12.reason or "rejected" else "rejected"))))
		else
			p1:_showToast(string.format("Sold %d items (+%s%d)", result.sold, "\226\130\189", result.totalPayout or 0))
		end

		for i, v in ipairs(p1.SellQueue) do
			p1:_setSellHighlight(v, false)
		end

		table.clear(p1.SellQueue)

		if not v1.RefreshAllPlayerInventories then
			p1:_renderItems()
			p1:_renderCart()

			return
		end

		v1:RefreshAllPlayerInventories()
		p1:_renderItems()
		p1:_renderCart()
	else
		if not (result and (result.rejected and #result.rejected > 0)) then
			return
		end

		local v3 = result.rejected[1]

		p1:_showToast("Failed: " .. tostring(type(v3) == "table" and v3.reason or "rejected"))
	end
end
function t._showToast(p1, p2) --[[ _showToast | Line: 1491 ]]
	p1.Toast.Text = p2
	p1.Toast.Visible = true
	p1.Toast:SetAttribute("__shownAt", os.clock())
	task.delay(3, function() --[[ Line: 1495 | Upvalues: p1 (copy) ]]
		if not (os.clock() - (p1.Toast:GetAttribute("__shownAt") or 0) >= 2.95) then
			return
		end

		p1.Toast.Visible = false
	end)
end

return t