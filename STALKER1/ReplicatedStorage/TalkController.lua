-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
local v3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local v4 = Color3.fromRGB(255, 180, 70)
local v5 = Color3.fromRGB(130, 220, 130)
local v6 = Color3.fromRGB(220, 220, 220)
local v7 = Color3.fromRGB(48, 48, 48)
local v8 = Color3.fromRGB(25, 27, 24)
local t = {
	IsOpen = false,
	CurrentNPC = nil,
	CurrentProfile = nil,
	_tree = nil,
	_currentNode = nil,
	_history = nil,
	_lastNpcFinishTime = 0,
	_npcPanelOwnsCursor = function(p1) --[[ _npcPanelOwnsCursor | Line: 44 | Upvalues: LocalPlayer (copy) ]]
		local v1 = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
		local v2 = if v1 then v1:FindFirstChild("NpcInteractionGui") else v1

		return v2 and (v2:IsA("ScreenGui") and v2.Enabled) and true or false
	end,
	_acquireCursor = function(p1) --[[ _acquireCursor | Line: 50 | Upvalues: UserInputService (copy), RunService (copy) ]]
		if not (p1._cursorHeld or p1:_npcPanelOwnsCursor()) then
			p1._cursorHeld = true
			p1._savedMouseBehavior = UserInputService.MouseBehavior
			p1._savedMouseIcon = UserInputService.MouseIconEnabled
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = true
			RunService:BindToRenderStep("TalkControllerCursor", Enum.RenderPriority.Camera.Value + 101, function() --[[ Line: 60 | Upvalues: UserInputService (ref) ]]
				if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				end

				if UserInputService.MouseIconEnabled then
					return
				end

				UserInputService.MouseIconEnabled = true
			end)
		end
	end,
	_releaseCursor = function(p1) --[[ _releaseCursor | Line: 70 | Upvalues: RunService (copy), UserInputService (copy) ]]
		if not p1._cursorHeld then
			return
		end

		p1._cursorHeld = false
		pcall(function() --[[ Line: 73 | Upvalues: RunService (ref) ]]
			RunService:UnbindFromRenderStep("TalkControllerCursor")
		end)

		if p1._savedMouseBehavior ~= nil then
			UserInputService.MouseBehavior = p1._savedMouseBehavior
			p1._savedMouseBehavior = nil
		end

		if p1._savedMouseIcon == nil then
			return
		end

		UserInputService.MouseIconEnabled = p1._savedMouseIcon
		p1._savedMouseIcon = nil
	end,
	_bindCursorOwnership = function(p1) --[[ _bindCursorOwnership | Line: 87 ]]
		if p1._cursorBound or not p1.Gui then
			return
		end

		p1._cursorBound = true

		local function refresh() --[[ refresh | Line: 90 | Upvalues: p1 (copy) ]]
			if p1.Gui and p1.Gui.Enabled then
				p1:_acquireCursor()
			else
				p1:_releaseCursor()
			end
		end

		p1.Gui:GetPropertyChangedSignal("Enabled"):Connect(refresh)

		if p1.Gui and p1.Gui.Enabled then
			p1:_acquireCursor()

			return
		end

		p1:_releaseCursor()
	end
}

local function applyBodyGradient(p1) --[[ applyBodyGradient | Line: 101 ]]
	local UIGradient = Instance.new("UIGradient")

	UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 80, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 3, 2)) })
	UIGradient.Rotation = -90
	UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.46875) })
	UIGradient.Parent = p1

	return UIGradient
end

local function applyStroke(p1) --[[ applyStroke | Line: 116 | Upvalues: v7 (copy) ]]
	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v7
	UIStroke.Thickness = 1
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Parent = p1

	return UIStroke
end

local function addHistoryEntry(p1, p2, p3, p4, p5) --[[ addHistoryEntry | Line: 125 | Upvalues: v1 (copy), v6 (copy), v3 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Name = "Entry" .. tostring(p5)
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.Size = UDim2.new(1, 0, 0, 0)
	Frame.AutomaticSize = Enum.AutomaticSize.Y
	Frame.LayoutOrder = p5
	Frame.Parent = p1

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 2)
	UIListLayout.Parent = Frame

	local Speaker = Instance.new("TextLabel")

	Speaker.Name = "Speaker"
	Speaker.BackgroundTransparency = 1
	Speaker.Size = UDim2.new(1, 0, 0, 0)
	Speaker.AutomaticSize = Enum.AutomaticSize.Y
	Speaker.Text = string.upper(p2)
	Speaker.TextColor3 = p3
	Speaker.TextSize = 20
	Speaker.FontFace = v1
	Speaker.TextXAlignment = Enum.TextXAlignment.Left
	Speaker.TextYAlignment = Enum.TextYAlignment.Top
	Speaker.TextWrapped = false
	Speaker.LayoutOrder = 1
	Speaker.Parent = Frame

	local Line = Instance.new("TextLabel")

	Line.Name = "Line"
	Line.BackgroundTransparency = 1
	Line.Size = UDim2.new(1, -16, 0, 0)
	Line.Position = UDim2.new(0, 16, 0, 0)
	Line.AutomaticSize = Enum.AutomaticSize.Y
	Line.Text = p4
	Line.TextColor3 = v6
	Line.TextSize = 18
	Line.FontFace = v3
	Line.TextXAlignment = Enum.TextXAlignment.Left
	Line.TextYAlignment = Enum.TextYAlignment.Top
	Line.TextWrapped = true
	Line.LayoutOrder = 2
	Line.Parent = Frame

	return Line
end

local function makeChoiceButton(p1, p2, p3) --[[ makeChoiceButton | Line: 174 | Upvalues: v6 (copy), v3 (copy) ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Name = "Choice" .. tostring(p3)
	TextButton.BackgroundTransparency = 1
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = false
	TextButton.Size = UDim2.new(1, 0, 0, 0)
	TextButton.AutomaticSize = Enum.AutomaticSize.Y
	TextButton.LayoutOrder = p3
	TextButton.Text = p2
	TextButton.TextColor3 = v6
	TextButton.TextSize = 18
	TextButton.FontFace = v3
	TextButton.TextXAlignment = Enum.TextXAlignment.Left
	TextButton.TextYAlignment = Enum.TextYAlignment.Top
	TextButton.TextWrapped = true
	TextButton.Parent = p1
	TextButton.MouseEnter:Connect(function() --[[ Line: 192 | Upvalues: TextButton (copy) ]]
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)
	TextButton.MouseLeave:Connect(function() --[[ Line: 195 | Upvalues: TextButton (copy), v6 (ref) ]]
		TextButton.TextColor3 = v6
	end)

	return TextButton
end

local function topicReady(p1, p2) --[[ topicReady | Line: 207 ]]
	local v1 = ipairs

	for v3, v4 in v1(p1.requires or {}) do
		if not p2[v4] then
			return false
		end
	end

	local v5 = ipairs

	for v7, v8 in v5(p1.excludes or {}) do
		if p2[v8] then
			return false
		end
	end

	return true
end

function t._buildGui(p1) --[[ _buildGui | Line: 221 | Upvalues: LocalPlayer (copy), v8 (copy), v7 (copy), applyBodyGradient (copy), v1 (copy), v2 (copy), ReplicatedStorage (copy) ]]
	local TalkGui = Instance.new("ScreenGui")

	TalkGui.Name = "TalkGui"
	TalkGui.ResetOnSpawn = false
	TalkGui.IgnoreGuiInset = true
	TalkGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	TalkGui.DisplayOrder = 5
	TalkGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	local MainFrame = Instance.new("Frame")

	MainFrame.Name = "MainFrame"
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.Position = UDim2.fromScale(0.5, 0.5)
	MainFrame.Size = UDim2.fromScale(0.5, 0.7)
	MainFrame.BackgroundColor3 = v8
	MainFrame.BackgroundTransparency = 0
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = TalkGui

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v7
	UIStroke.Thickness = 1
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Parent = MainFrame
	applyBodyGradient(MainFrame)

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = MainFrame

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 0)
	UIListLayout.Parent = MainFrame

	local Header = Instance.new("Frame")

	Header.Name = "Header"
	Header.Size = UDim2.new(1, 0, 0.12, 0)
	Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Header.BackgroundTransparency = 0
	Header.BorderSizePixel = 0
	Header.LayoutOrder = 1
	Header.Parent = MainFrame

	local UIGradient = Instance.new("UIGradient")

	UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) })
	UIGradient.Rotation = -90
	UIGradient.Parent = Header

	local UIStroke2 = Instance.new("UIStroke")

	UIStroke2.Color = v7
	UIStroke2.Thickness = 1
	UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke2.Parent = Header

	local NpcName = Instance.new("TextLabel")

	NpcName.Name = "NpcName"
	NpcName.Size = UDim2.fromScale(1, 1)
	NpcName.BackgroundTransparency = 1
	NpcName.Text = "NPC NAME"
	NpcName.TextColor3 = Color3.fromRGB(220, 220, 220)
	NpcName.TextSize = 30
	NpcName.FontFace = v1
	NpcName.TextXAlignment = Enum.TextXAlignment.Center
	NpcName.TextYAlignment = Enum.TextYAlignment.Center
	NpcName.Parent = Header

	local HistoryFrame = Instance.new("ScrollingFrame")

	HistoryFrame.Name = "HistoryFrame"
	HistoryFrame.Size = UDim2.new(1, 0, 0.55, 0)
	HistoryFrame.BackgroundTransparency = 1
	HistoryFrame.BorderSizePixel = 0
	HistoryFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	HistoryFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	HistoryFrame.ScrollBarThickness = 6
	HistoryFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
	HistoryFrame.LayoutOrder = 2
	HistoryFrame.Parent = MainFrame

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingTop = UDim.new(0, 8)
	UIPadding.PaddingBottom = UDim.new(0, 8)
	UIPadding.PaddingLeft = UDim.new(0, 8)
	UIPadding.PaddingRight = UDim.new(0, 8)
	UIPadding.Parent = HistoryFrame

	local UIListLayout2 = Instance.new("UIListLayout")

	UIListLayout2.FillDirection = Enum.FillDirection.Vertical
	UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout2.Padding = UDim.new(0, 8)
	UIListLayout2.Parent = HistoryFrame

	local ChoicesFrame = Instance.new("ScrollingFrame")

	ChoicesFrame.Name = "ChoicesFrame"
	ChoicesFrame.Size = UDim2.new(1, 0, 0.28, 0)
	ChoicesFrame.BackgroundColor3 = v8
	ChoicesFrame.BackgroundTransparency = 0.5
	ChoicesFrame.BorderSizePixel = 0
	ChoicesFrame.LayoutOrder = 3
	ChoicesFrame.Active = true
	ChoicesFrame.CanvasSize = UDim2.new()
	ChoicesFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ChoicesFrame.ScrollingDirection = Enum.ScrollingDirection.Y
	ChoicesFrame.ScrollBarThickness = 4
	ChoicesFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
	ChoicesFrame.Parent = MainFrame

	local UIStroke3 = Instance.new("UIStroke")

	UIStroke3.Color = v7
	UIStroke3.Thickness = 1
	UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke3.Parent = ChoicesFrame

	local UIPadding2 = Instance.new("UIPadding")

	UIPadding2.PaddingTop = UDim.new(0, 12)
	UIPadding2.PaddingBottom = UDim.new(0, 12)
	UIPadding2.PaddingLeft = UDim.new(0, 12)
	UIPadding2.PaddingRight = UDim.new(0, 12)
	UIPadding2.Parent = ChoicesFrame

	local UIListLayout3 = Instance.new("UIListLayout")

	UIListLayout3.FillDirection = Enum.FillDirection.Vertical
	UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout3.Padding = UDim.new(0, 4)
	UIListLayout3.Parent = ChoicesFrame

	local Footer = Instance.new("Frame")

	Footer.Name = "Footer"
	Footer.Size = UDim2.new(1, 0, 0.05, 0)
	Footer.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	Footer.BackgroundTransparency = 0.5
	Footer.BorderSizePixel = 0
	Footer.LayoutOrder = 4
	Footer.Parent = MainFrame

	local UIStroke4 = Instance.new("UIStroke")

	UIStroke4.Color = v7
	UIStroke4.Thickness = 1
	UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke4.Parent = Footer

	local TradeBtn = Instance.new("TextButton")

	TradeBtn.Name = "TradeBtn"
	TradeBtn.Size = UDim2.fromScale(1, 1)
	TradeBtn.BackgroundTransparency = 1
	TradeBtn.AutoButtonColor = false
	TradeBtn.Text = "TRADE"
	TradeBtn.TextColor3 = Color3.fromRGB(255, 200, 90)
	TradeBtn.TextSize = 20
	TradeBtn.FontFace = v2
	TradeBtn.TextXAlignment = Enum.TextXAlignment.Center
	TradeBtn.TextYAlignment = Enum.TextYAlignment.Center
	TradeBtn.Parent = Footer
	TradeBtn.MouseButton1Click:Connect(function() --[[ Line: 368 | Upvalues: p1 (copy), ReplicatedStorage (ref) ]]
		if not p1.IsOpen then
			return
		end

		local CurrentNPC = p1.CurrentNPC

		if not CurrentNPC then
			return
		end

		p1.IsOpen = false
		p1.Gui.Enabled = false
		p1._tree = nil
		p1._currentNode = nil
		p1._history = nil
		p1:_clearHistoryUI()
		p1:_clearChoicesUI()
		p1.CurrentNPC = nil
		p1.CurrentProfile = nil

		local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
		local v1 = if Remotes then Remotes:FindFirstChild("OpenTraderFromMenu") else Remotes

		if not v1 then
			return
		end

		v1:FireServer(CurrentNPC)
	end)
	p1.Gui = TalkGui
	p1:_bindCursorOwnership()
	p1.MainFrame = MainFrame
	p1.NpcName = NpcName
	p1.HistoryFrame = HistoryFrame
	p1.ChoicesFrame = ChoicesFrame
	p1.TradeBtn = TradeBtn
end
function t._clearHistoryUI(p1) --[[ _clearHistoryUI | Line: 397 ]]
	if not p1.HistoryFrame then
		return
	end

	for i, v in ipairs(p1.HistoryFrame:GetChildren()) do
		if not (v:IsA("UIListLayout") or v:IsA("UIPadding")) then
			v:Destroy()
		end
	end
end
function t._clearChoicesUI(p1) --[[ _clearChoicesUI | Line: 406 ]]
	if not p1.ChoicesFrame then
		return
	end

	for i, v in ipairs(p1.ChoicesFrame:GetChildren()) do
		if not (v:IsA("UIListLayout") or (v:IsA("UIPadding") or v:IsA("UIStroke"))) then
			v:Destroy()
		end
	end
end
function t._addHistoryLine(p1, p2, p3, p4) --[[ _addHistoryLine | Line: 415 | Upvalues: v4 (copy), v5 (copy), addHistoryEntry (copy) ]]
	addHistoryEntry(p1.HistoryFrame, p2, p4 and v4 or v5, p3, #p1.HistoryFrame:GetChildren())
	table.insert(p1._history, {
		speaker = p2,
		text = p3,
		isNPC = p4
	})
	task.defer(function() --[[ Line: 420 | Upvalues: p1 (copy) ]]
		if not (p1.HistoryFrame and p1.HistoryFrame.Parent) then
			return
		end

		p1.HistoryFrame.CanvasPosition = Vector2.new(0, p1.HistoryFrame.AbsoluteCanvasSize.Y)
	end)

	if not p4 then
		return
	end

	p1._lastNpcFinishTime = os.clock()
end
function t._renderFallbackMessage(p1, p2) --[[ _renderFallbackMessage | Line: 433 | Upvalues: v3 (copy) ]]
	p1:_clearHistoryUI()
	p1:_clearChoicesUI()

	local FallbackMessage = Instance.new("TextLabel")

	FallbackMessage.Name = "FallbackMessage"
	FallbackMessage.BackgroundTransparency = 1
	FallbackMessage.Size = UDim2.new(1, 0, 0, 0)
	FallbackMessage.AutomaticSize = Enum.AutomaticSize.Y
	FallbackMessage.Text = p2
	FallbackMessage.TextColor3 = Color3.fromRGB(140, 140, 140)
	FallbackMessage.TextSize = 18
	FallbackMessage.FontFace = v3
	FallbackMessage.TextXAlignment = Enum.TextXAlignment.Left
	FallbackMessage.TextYAlignment = Enum.TextYAlignment.Top
	FallbackMessage.TextWrapped = true
	FallbackMessage.LayoutOrder = 1
	FallbackMessage.Parent = p1.HistoryFrame
end
function t._findNodeByName(p1, p2) --[[ _findNodeByName | Line: 452 ]]
	if p1._tree then
		return p1._tree:FindFirstChild(p2)
	end

	return nil
end

local function groupDigits(p1) --[[ groupDigits | Line: 459 ]]
	return tostring((math.floor(tonumber(p1) or 0))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

function t._setPriceTag(p1, p2) --[[ _setPriceTag | Line: 472 | Upvalues: v2 (copy) ]]
	if not p1.ChoicesFrame then
		return
	end

	local PriceTag = p1.ChoicesFrame:FindFirstChild("PriceTag")

	if PriceTag then
		PriceTag:Destroy()
	end

	if p2 and not (p2 <= 0) then
		local PriceTag2 = Instance.new("TextLabel")

		PriceTag2.Name = "PriceTag"
		PriceTag2.LayoutOrder = 0
		PriceTag2.Size = UDim2.new(1, 0, 0, 18)
		PriceTag2.AutomaticSize = Enum.AutomaticSize.Y
		PriceTag2.BackgroundTransparency = 1
		PriceTag2.TextColor3 = Color3.fromRGB(220, 90, 90)
		PriceTag2.TextSize = 16
		PriceTag2.FontFace = v2
		PriceTag2.TextXAlignment = Enum.TextXAlignment.Left
		PriceTag2.Text = string.format("Asking: %s RU", (tostring((math.floor(tonumber(p2) or 0))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
		PriceTag2.Parent = p1.ChoicesFrame
	end
end
function t._addTransactionLine(p1, p2) --[[ _addTransactionLine | Line: 491 | Upvalues: v2 (copy) ]]
	local Transaction = Instance.new("Frame")

	Transaction.Name = "Transaction"
	Transaction.BackgroundTransparency = 1
	Transaction.Size = UDim2.new(1, 0, 0, 18)
	Transaction.AutomaticSize = Enum.AutomaticSize.Y
	Transaction.LayoutOrder = #p1.HistoryFrame:GetChildren()
	Transaction.Parent = p1.HistoryFrame

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, -16, 0, 18)
	TextLabel.Position = UDim2.fromOffset(16, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextColor3 = Color3.fromRGB(220, 90, 90)
	TextLabel.TextSize = 16
	TextLabel.FontFace = v2
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextWrapped = true
	TextLabel.AutomaticSize = Enum.AutomaticSize.Y
	TextLabel.Text = string.format("-%s RU", (tostring((math.floor(tonumber(p2) or 0))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
	TextLabel.Parent = Transaction
	task.defer(function() --[[ Line: 511 | Upvalues: p1 (copy) ]]
		if not (p1.HistoryFrame and p1.HistoryFrame.Parent) then
			return
		end

		p1.HistoryFrame.CanvasPosition = Vector2.new(0, p1.HistoryFrame.AbsoluteCanvasSize.Y)
	end)
end
function t._findTree(p1, p2) --[[ _findTree | Line: 518 ]]
	if not p2 then
		return nil
	end

	for i, v in ipairs(p2:GetDescendants()) do
		if v:IsA("Configuration") and v:GetAttribute("NodeTree") == true then
			return v
		end
	end

	return nil
end
function t._findRootNode(p1, p2) --[[ _findRootNode | Line: 528 ]]
	for i, v in ipairs(p2:GetChildren()) do
		if v:IsA("Configuration") and v:GetAttribute("Type") == "DialogueRoot" then
			return v
		end
	end

	return nil
end
function t._getOutputs(p1, p2) --[[ _getOutputs | Line: 537 ]]
	local t = {}
	local MainPathway = p2:FindFirstChild("MainPathway")

	if not MainPathway then
		return t
	end

	local Outputs = MainPathway:FindFirstChild("Outputs")

	if not Outputs then
		return t
	end

	for i, v in ipairs(Outputs:GetChildren()) do
		if v:IsA("ObjectValue") and (v.Value and v.Value.Parent) then
			table.insert(t, v.Value.Parent)
		end
	end

	return t
end
function t._singleOutput(p1, p2) --[[ _singleOutput | Line: 551 ]]
	return p1:_getOutputs(p2)[1]
end
function t._runIncomingCommands(p1, p2) --[[ _runIncomingCommands | Line: 556 ]]
	if not p1._tree then
		return
	end

	for i, v in ipairs(p1._tree:GetChildren()) do
		if v:IsA("Configuration") and v:GetAttribute("Type") == "Command" then
			for i2, v2 in ipairs(p1:_getOutputs(v)) do
				if v2 == p2 then
					local Function = v:FindFirstChild("Function")

					if Function and Function:IsA("ModuleScript") then
						local ok, result = pcall(require, Function)

						if ok and result and type(result.Run) == "function" then
							pcall(result.Run)
						end
					end

					break
				end
			end
		end
	end
end
function t._getReadyTurnIns(p1) --[[ _getReadyTurnIns | Line: 579 | Upvalues: ReplicatedStorage (copy) ]]
	local CurrentNPC = p1.CurrentNPC

	if not CurrentNPC then
		return {}, nil
	end

	local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3))

	if not (ok and result) then
		return {}, nil
	end

	local v1 = CurrentNPC.Name

	local function objectivesDone(p1) --[[ objectivesDone | Line: 585 ]]
		local v1 = ipairs

		for v3, v4 in v1(p1.objectives or {}) do
			if v4.id ~= "return" and (v4.id ~= "deliver" and not v4.complete) then
				return false
			end
		end

		return true
	end

	local function isForThisNpc(p1) --[[ isForThisNpc | Line: 593 | Upvalues: v1 (copy) ]]
		if p1.type == "delivery" then
			return p1.params and p1.params.destination_npc == v1
		end

		return p1.giver and p1.giver.npcId == v1
	end

	local t = {}
	local v2 = ipairs
	local v3 = result:GetActiveTasks()

	for v6, v7 in v2(if v3 then v3 else {}) do
		local v5

		v5 = if v7.type == "delivery" then v7.params and v7.params.destination_npc == v1 else v7.giver and (if v7.giver.npcId == v1 then true else false)

		if v5 and (objectivesDone(v7) and not v7.shared_from) then
			table.insert(t, v7)
		end
	end

	return t, result
end
function t._onTurnInClicked(p1, p2, p3, p4) --[[ _onTurnInClicked | Line: 609 | Upvalues: ReplicatedStorage (copy) ]]
	p1:_addHistoryLine("PLAYER", p4, false)

	local v2 = p3:Handin(p2.id, p1.CurrentNPC and p1.CurrentNPC.Name)

	if v2 and v2.ok then
		p1.IsOpen = false
		p1.Gui.Enabled = false
		p1._tree = nil
		p1._currentNode = nil
		p1._history = nil
		p1:_clearHistoryUI()
		p1:_clearChoicesUI()
		p1.CurrentNPC = nil
		p1.CurrentProfile = nil

		local ok, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1))

		if ok and (result and result.IsOpen) then
			result:Close()
		end
	else
		local v3 = v2 and v2.error or "unknown"

		p3:ShowToast(if v3 == "missing_package" then "You no longer have the package" elseif v3 == "missing_items" then "You don\'t have the required items" else "Couldn\'t turn in")
	end
end
function t._renderChoicesFromResponses(p1, p2) --[[ _renderChoicesFromResponses | Line: 637 | Upvalues: makeChoiceButton (copy) ]]
	p1:_clearChoicesUI()
	table.sort(p2, function(p1, p2) --[[ Line: 639 ]]
		return (p1:GetAttribute("Priority") or 0) > (p2:GetAttribute("Priority") or 0)
	end)

	local v1, v2

	if p1._history and #p1._history <= 1 then
		local v3, v4 = p1:_getReadyTurnIns()

		v1 = v3
		v2 = v4
	else
		v1 = {}
		v2 = nil
	end

	local count = 0

	for i, v in ipairs(v1) do
		local v5

		count = count + 1
		v5 = if v.type == "delivery" or v.type == "fetching" then "Here\'s what you requested." else "The job is done."

		local v6 = string.format("%s  (TURN IN: %s)", v5, v.title or "Task")
		local v7 = makeChoiceButton(p1.ChoicesFrame, tostring(count) .. ". " .. v6, count)

		v7.TextColor3 = Color3.fromRGB(150, 210, 140)

		local v8 = v
		local v9 = v2
		local v10 = v6

		v7.MouseButton1Click:Connect(function() --[[ Line: 663 | Upvalues: p1 (copy), v8 (copy), v9 (copy), v10 (copy) ]]
			if not p1.IsOpen then
				return
			end

			p1:_onTurnInClicked(v8, v9, v10)
		end)
	end

	for i, v in ipairs(p2) do
		count = count + 1

		local Text = v:FindFirstChild("Text")

		makeChoiceButton(p1.ChoicesFrame, tostring(count) .. ". " .. (Text and Text.Value or ""), count).MouseButton1Click:Connect(function() --[[ Line: 675 | Upvalues: p1 (copy), v (copy) ]]
			if not p1.IsOpen then
				return
			end

			p1:_onChoiceClicked(v)
		end)
	end
end
function t._advanceTo(p1, p2) --[[ _advanceTo | Line: 683 ]]
	p1._currentNode = p2
	p1:_runIncomingCommands(p2)

	local v1 = p2:GetAttribute("Type")

	if v1 == "Prompt" then
		local Text = p2:FindFirstChild("Text")
		local v2 = if Text then Text.Value or "" else ""
		local upper = string.upper

		p1:_addHistoryLine(upper(p1.CurrentProfile and p1.CurrentProfile.DisplayName or (p1.CurrentNPC and p1.CurrentNPC.Name or "NPC")), v2, true)

		local t = {}
		local t2 = {}

		for i, v in ipairs((p1:_getOutputs(p2))) do
			local v5 = v:GetAttribute("Type")

			if v5 == "Response" then
				table.insert(t2, v)

				continue
			end

			if v5 == "Prompt" then
				table.insert(t, v)
			end
		end

		if #t2 > 0 then
			p1:_renderChoicesFromResponses(t2)

			return
		end

		if #t == 1 then
			task.defer(function() --[[ Line: 708 | Upvalues: p1 (copy), p2 (copy), t (copy) ]]
				if not p1.IsOpen or p1._currentNode ~= p2 then
					return
				end

				p1:_advanceTo(t[1])
			end)

			return
		end

		if #t > 1 then
			p1:_renderChoicesFromResponses(t)
		else
			p1:_endDialogue()
		end
	else
		if v1 ~= "Command" then
			return
		end

		local Function = p2:FindFirstChild("Function")

		if Function and Function:IsA("ModuleScript") then
			local ok, result = pcall(require, Function)

			if ok and result and type(result.Run) == "function" then
				pcall(result.Run)
			end
		end

		local v6 = p1:_singleOutput(p2)

		if not v6 then
			return
		end

		p1:_advanceTo(v6)
	end
end
function t._endDialogue(p1) --[[ _endDialogue | Line: 731 | Upvalues: ReplicatedStorage (copy) ]]
	p1:_clearChoicesUI()

	local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
	local v1 = if Remotes then Remotes:FindFirstChild("PlayVoiceline") else Remotes

	if v1 and p1.CurrentNPC then
		v1:FireServer(p1.CurrentNPC, "Goodbye")
	end

	task.delay(math.max(0, p1._lastNpcFinishTime - os.clock()) + 2, function() --[[ Line: 742 | Upvalues: p1 (copy), ReplicatedStorage (ref) ]]
		if not p1.IsOpen then
			return
		end

		p1.IsOpen = false
		p1.Gui.Enabled = false
		p1._tree = nil
		p1._currentNode = nil
		p1._history = nil
		p1:_clearHistoryUI()
		p1:_clearChoicesUI()
		p1.CurrentNPC = nil
		p1.CurrentProfile = nil

		local ok, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1))

		if not (ok and (result and (result.IsOpen and result.Gui))) then
			return
		end

		result.Gui.Enabled = true
	end)
end
function t._openWorkPanelHandoff(p1) --[[ _openWorkPanelHandoff | Line: 763 | Upvalues: ReplicatedStorage (copy) ]]
	local CurrentNPC = p1.CurrentNPC
	local CurrentProfile = p1.CurrentProfile

	p1.IsOpen = false
	p1.Gui.Enabled = false
	p1._tree = nil
	p1._currentNode = nil
	p1._history = nil
	p1:_clearHistoryUI()
	p1:_clearChoicesUI()
	p1.CurrentNPC = nil
	p1.CurrentProfile = nil

	if not CurrentNPC then
		return
	end

	local ok, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1))

	if not (ok and result) then
		return
	end

	if result.IsOpen and result.CurrentNPC == CurrentNPC then
		if result.Gui then
			result.Gui.Enabled = true
		end
	else
		result:Open(CurrentNPC, CurrentProfile)
	end

	result:OpenWorkPanel()
end
function t._onChoiceClicked(p1, p2) --[[ _onChoiceClicked | Line: 795 ]]
	if p2:GetAttribute("OpenWorkPanel") == true then
		p1:_openWorkPanelHandoff()

		return
	end

	local Function = p2:FindFirstChild("Function")

	if Function and Function:IsA("ModuleScript") then
		local ok, result = pcall(require, Function)

		if ok and result and type(result.Decide) == "function" then
			local Text = p2:FindFirstChild("Text")

			p1:_addHistoryLine("PLAYER", if Text then Text.Value or "" else "", false)

			local ok2, result2, result3 = pcall(result.Decide)

			if ok2 and result2 then
				if result3 and result3 > 0 then
					p1:_addTransactionLine(result3)
				end

				local v2 = p1:_findNodeByName(result2)

				if v2 then
					p1:_advanceTo(v2)
				else
					p1:_endDialogue()
				end

				return
			end
		end
	end

	local Text = p2:FindFirstChild("Text")

	p1:_addHistoryLine("PLAYER", p2:FindFirstChild("Text") and Text.Value or "", false)

	local v4 = p1:_singleOutput(p2)

	if v4 then
		p1:_advanceTo(v4)
	else
		p1:_endDialogue()
	end
end
function t._wireInput(p1) --[[ _wireInput | Line: 833 | Upvalues: UserInputService (copy) ]]
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 834 | Upvalues: p1 (copy) ]]
		if p2 or not p1.IsOpen then
			return
		end

		if p12.KeyCode ~= Enum.KeyCode.Q then
			return
		end

		p1:Close()
	end)
end
function t.Init(p1) --[[ Init | Line: 842 ]]
	if not p1.Gui then
		p1:_buildGui()
		p1:_wireInput()
		p1.Gui.Enabled = false
		print("[TalkController] initialized")
	end
end
function t.Open(p1, p2, p3) --[[ Open | Line: 850 | Upvalues: Players (copy) ]]
	if p1.IsOpen then
		return
	end

	p1.IsOpen = true
	p1.CurrentNPC = p2
	p1.CurrentProfile = p3

	local upper = string.upper

	p1.NpcName.Text = upper(p3 and p3.DisplayName or (p2 and p2.Name or "NPC"))
	p1._history = {}
	p1._lastNpcFinishTime = 0
	p1._tree = p1:_findTree(p2)
	p1:_clearHistoryUI()
	p1:_clearChoicesUI()
	p1.Gui.Enabled = true

	if p1.TradeBtn then
		p1.TradeBtn.Visible = not (if p2 then if p2:GetAttribute("NpcType") == "Extractor" then true else false else p2)
	end

	if p2 and p2:GetAttribute("NpcType") == "Extractor" then
		p1:_runExtractDialog(p2)

		return
	end

	if p2 and p2:GetAttribute("NpcType") == "SimpleTrader" then
		p1:_runSimpleTraderIntro(p2)

		return
	end

	local LocalPlayer = Players.LocalPlayer

	if LocalPlayer and (LocalPlayer:GetAttribute("_TutorialPending") and (not LocalPlayer:GetAttribute("_StarterPackGranted") and (p2 and p2:GetAttribute("TraderID") == "Crow"))) then
		p1:_runTutorialIntro(p2)

		return
	end

	if not p1._tree then
		p1:_renderFallbackMessage("(NPC has no dialogue tree)")

		return
	end

	local v3 = p1:_findRootNode(p1._tree)

	if not v3 then
		p1:_renderFallbackMessage("(Dialogue tree has no root)")

		return
	end

	local v4 = p1:_singleOutput(v3)

	if v4 then
		p1:_advanceTo(v4)
	else
		p1:_renderFallbackMessage("(No dialogue available)")
	end
end

local t2 = {
	{
		id = "money",
		label = "Money. I heard people get rich out here.",
		reply = { "Sure they do. Usually the ones selling equipment to people like you." }
	},
	{
		id = "wish",
		label = "I\'ve heard stories about the Wish Granter.",
		reply = { "Some say there\'s something at the center that\'ll give you anything you ask for.", "Funny thing about desperate men. They\'ll believe anything if you tell them it\'s waiting far enough north." }
	},
	{
		id = "debt",
		label = "I\'ve got debts back home.",
		reply = { "Maybe you\'ll make enough to go home. Maybe after a while you won\'t want to." }
	},
	{
		id = "nothing_left",
		label = "There\'s nothing left for me outside.",
		reply = { "That one\'s more common than you\'d think.", "Zone doesn\'t ask who you used to be." }
	},
	{
		id = "searching",
		label = "I\'m looking for someone.",
		followPlayer = "I don\'t know.",
		reply = { "Alive?" },
		followReply = { "Then start hoping they\'re smart." }
	},
	{
		id = "silence",
		label = "None of your business.",
		reply = { "Good. You\'ll last longer if you don\'t tell strangers everything about yourself." }
	}
}

function t._runTutorialIntro(p1, p2) --[[ _runTutorialIntro | Line: 969 | Upvalues: Players (copy), t2 (copy), makeChoiceButton (copy) ]]
	local v2 = string.upper(p1.CurrentProfile and p1.CurrentProfile.DisplayName or (p2.Name or "CROW"))
	local LocalPlayer = Players.LocalPlayer
	local v3 = if LocalPlayer then LocalPlayer:GetAttribute("_StarterPackGranted") == true else LocalPlayer

	p1._tutorialBusy = false
	p1:_clearChoicesUI()

	if v3 then
		p1:_addHistoryLine(v2, "Still alive? Good for you.", true)
		p1:_addHistoryLine(v2, "Hand off was clean. I\'m not running a charity. Finish the Flesh and come back.", true)
		p1:_tutorialShowAccept(v2, true, nil)

		return
	end

	p1:_addHistoryLine(v2, "Fresh meat. You still smell like the outside.", true)
	p1:_addHistoryLine(v2, "Everyone who comes through here walked away from something. So before I put work in your hands. Why\'d you come to the Zone?", true)

	for i, v in ipairs(t2) do
		makeChoiceButton(p1.ChoicesFrame, i .. ". " .. v.label, i).MouseButton1Click:Connect(function() --[[ Line: 993 | Upvalues: p1 (copy), v2 (copy), v (copy) ]]
			if p1.IsOpen then
				p1:_tutorialAnswer(v2, v)
			end
		end)
	end
end
function t._tutorialAnswer(p1, p2, p3) --[[ _tutorialAnswer | Line: 1002 | Upvalues: makeChoiceButton (copy) ]]
	if p1._tutorialBusy then
		return
	end

	p1._tutorialBusy = true
	p1:_addHistoryLine("PLAYER", p3.label, false)
	p1:_clearChoicesUI()

	for i, v in ipairs(p3.reply) do
		p1:_addHistoryLine(p2, v, true)
	end

	if p3.followPlayer then
		p1._tutorialBusy = false
		makeChoiceButton(p1.ChoicesFrame, "1. " .. p3.followPlayer, 1).MouseButton1Click:Connect(function() --[[ Line: 1015 | Upvalues: p1 (copy), p3 (copy), p2 (copy) ]]
			if not p1.IsOpen or p1._tutorialBusy then
				return
			end

			p1._tutorialBusy = true
			p1:_addHistoryLine("PLAYER", p3.followPlayer, false)
			p1:_clearChoicesUI()

			local v1 = ipairs

			for v3, v4 in v1(p3.followReply or {}) do
				p1:_addHistoryLine(p2, v4, true)
			end

			p1:_tutorialBriefing(p2, p3.id)
		end)
	else
		p1:_tutorialBriefing(p2, p3.id)
	end
end
function t._tutorialBriefing(p1, p2, p3) --[[ _tutorialBriefing | Line: 1034 ]]
	task.delay(0.7, function() --[[ Line: 1035 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		if p1.IsOpen then
			p1:_addHistoryLine(p2, "Doesn\'t really matter why you came. Money. Debt. Legends. Running from something. Running toward something. The Zone doesn\'t care.", true)
			p1:_addHistoryLine(p2, "You eat by working out here. Simple as that.", true)
			p1:_addHistoryLine(p2, "There\'s a Flesh sniffing around near the camps. Pig-mutant. Sloppy, but it bites if you let it. Put it down, come back to me.", true)
			p1._tutorialBusy = false
			p1:_tutorialShowAccept(p2, false, p3)
		end
	end)
end
function t._tutorialShowAccept(p1, p2, p3, p4) --[[ _tutorialShowAccept | Line: 1047 | Upvalues: makeChoiceButton (copy), ReplicatedStorage (copy) ]]
	p1:_clearChoicesUI()

	local v1 = if p3 then "I\'m on it." else "I\'ll handle it."

	makeChoiceButton(p1.ChoicesFrame, "1. " .. v1, 1).MouseButton1Click:Connect(function() --[[ Line: 1051 | Upvalues: p1 (copy), v1 (copy), ReplicatedStorage (ref), p4 (copy), p3 (copy), p2 (copy) ]]
		if not p1.IsOpen or p1._tutorialBusy then
			return
		end

		p1._tutorialBusy = true
		p1:_addHistoryLine("PLAYER", v1, false)
		p1:_clearChoicesUI()

		local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
		local v12 = if Remotes then Remotes:FindFirstChild("TutorialAcceptIntro") else Remotes

		if v12 then
			v12:FireServer(p4)
		end

		if not p3 then
			p1:_addHistoryLine(p2, "Here. Skorpion, three mags, a box of rounds, bandages and a medkit. On the house. Lose it and you\'re on your own. If you need more, see what\'s on offer.", true)
		end

		task.delay(if p3 then 2 else 6, function() --[[ Line: 1066 | Upvalues: p1 (ref) ]]
			if not p1.IsOpen then
				return
			end

			p1:Close()
		end)
	end)
end
function t._runSimpleTraderIntro(p1, p2) --[[ _runSimpleTraderIntro | Line: 1081 | Upvalues: makeChoiceButton (copy) ]]
	local CurrentProfile = p1.CurrentProfile
	local v2 = string.upper(CurrentProfile and CurrentProfile.DisplayName or (p2.Name or "TRADER"))
	local v3 = CurrentProfile and CurrentProfile.IntroLine or "(no intro configured)"

	p1:_clearChoicesUI()
	makeChoiceButton(p1.ChoicesFrame, "1. Who are you?", 1).MouseButton1Click:Connect(function() --[[ Line: 1088 | Upvalues: p1 (copy), v2 (copy), v3 (copy), makeChoiceButton (ref) ]]
		if p1.IsOpen then
			p1:_addHistoryLine("PLAYER", "Who are you?", false)
			p1:_clearChoicesUI()
			p1:_addHistoryLine(v2, v3, true)
			task.delay(0.6, function() --[[ Line: 1094 | Upvalues: p1 (ref), makeChoiceButton (ref) ]]
				if p1.IsOpen then
					makeChoiceButton(p1.ChoicesFrame, "1. Understood.", 1).MouseButton1Click:Connect(function() --[[ Line: 1097 | Upvalues: p1 (ref) ]]
						if p1.IsOpen then
							p1:_addHistoryLine("PLAYER", "Understood.", false)
							p1:_clearChoicesUI()
							task.delay(0.4, function() --[[ Line: 1101 | Upvalues: p1 (ref) ]]
								if not p1.IsOpen then
									return
								end

								p1:Close()
							end)
						end
					end)
				end
			end)
		end
	end)
end
function t._runExtractDialog(p1, p2) --[[ _runExtractDialog | Line: 1109 | Upvalues: makeChoiceButton (copy), ReplicatedStorage (copy) ]]
	local v2 = string.upper(p1.CurrentProfile and p1.CurrentProfile.DisplayName or (p2.Name or "GUIDE"))

	p1:_addHistoryLine(v2, "Need a ride out of the Zone?", true)
	p1:_addHistoryLine(v2, "I\'ll drop you back at the warehouse. Whatever you\'re carrying comes with you.", true)
	p1:_clearChoicesUI()

	local v3 = makeChoiceButton(p1.ChoicesFrame, "1. Get me out of here.", 1)

	v3.TextColor3 = Color3.fromRGB(150, 210, 140)
	v3.MouseButton1Click:Connect(function() --[[ Line: 1118 | Upvalues: p1 (copy), ReplicatedStorage (ref), p2 (copy), v2 (copy) ]]
		if not p1.IsOpen then
			return
		end

		p1:_addHistoryLine("PLAYER", "Get me out of here.", false)
		p1:_clearChoicesUI()

		local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
		local v1 = if Remotes then Remotes:FindFirstChild("RequestExtract") else Remotes

		if v1 then
			v1:FireServer(p2)
		end

		p1:_addHistoryLine(v2, "Saving your gear. Hold on.", true)
	end)
	makeChoiceButton(p1.ChoicesFrame, "2. Maybe later.", 2).MouseButton1Click:Connect(function() --[[ Line: 1131 | Upvalues: p1 (copy) ]]
		if p1.IsOpen then
			p1:_addHistoryLine("PLAYER", "Maybe later.", false)
			p1:_clearChoicesUI()
			task.delay(1, function() --[[ Line: 1135 | Upvalues: p1 (ref) ]]
				if not p1.IsOpen then
					return
				end

				p1:Close()
			end)
		end
	end)
end
function t.Close(p1) --[[ Close | Line: 1141 | Upvalues: ReplicatedStorage (copy) ]]
	if not p1.IsOpen then
		return
	end

	p1.IsOpen = false
	p1.Gui.Enabled = false
	p1.CurrentNPC = nil
	p1.CurrentProfile = nil
	p1._tree = nil
	p1._currentNode = nil
	p1._history = nil
	p1._lastNpcFinishTime = 0
	p1:_clearHistoryUI()
	p1:_clearChoicesUI()

	local ok, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1))

	if not (ok and (result and result.IsOpen)) then
		return
	end

	result:Close()
end
function t._addRewardLine(p1, p2) --[[ _addRewardLine | Line: 1161 | Upvalues: v2 (copy) ]]
	local RewardLine = Instance.new("Frame")

	RewardLine.Name = "RewardLine"
	RewardLine.BackgroundTransparency = 1
	RewardLine.Size = UDim2.new(1, 0, 0, 18)
	RewardLine.AutomaticSize = Enum.AutomaticSize.Y
	RewardLine.LayoutOrder = #p1.HistoryFrame:GetChildren()
	RewardLine.Parent = p1.HistoryFrame

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, -16, 0, 18)
	TextLabel.Position = UDim2.fromOffset(16, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextColor3 = Color3.fromRGB(140, 200, 120)
	TextLabel.TextSize = 16
	TextLabel.FontFace = v2
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextWrapped = true
	TextLabel.AutomaticSize = Enum.AutomaticSize.Y
	TextLabel.Text = p2
	TextLabel.Parent = RewardLine
	task.defer(function() --[[ Line: 1181 | Upvalues: p1 (copy) ]]
		if not (p1.HistoryFrame and p1.HistoryFrame.Parent) then
			return
		end

		p1.HistoryFrame.CanvasPosition = Vector2.new(0, p1.HistoryFrame.AbsoluteCanvasSize.Y)
	end)
end
function t._returnToNpcMenu(p1) --[[ _returnToNpcMenu | Line: 1190 | Upvalues: ReplicatedStorage (copy) ]]
	p1.IsOpen = false
	p1.Gui.Enabled = false
	p1._tree = nil
	p1._currentNode = nil
	p1._history = nil
	p1:_clearHistoryUI()
	p1:_clearChoicesUI()

	local CurrentNPC = p1.CurrentNPC

	p1.CurrentNPC = nil
	p1.CurrentProfile = nil

	if not CurrentNPC then
		return
	end

	local ok, result = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1))

	if not ok or (not result or (not result.IsOpen or (result.CurrentNPC ~= CurrentNPC or not result.Gui))) then
		return
	end

	result.Gui.Enabled = true
end
function t._performTake(p1, p2) --[[ _performTake | Line: 1212 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3))

	if not (ok and result) then
		return
	end

	local v1, v2

	if type(p2.onTake) == "function" then
		local v3, v4 = p2.onTake()

		v1 = v3
		v2 = v4
	else
		local v5 = result:AcceptOffer(p2.id)
		local v6 = if v5 then v5.ok else v5

		v1, v2 = v6, if v5 then v5.error else v5
	end

	if v1 then
		p1.IsOpen = false
		p1.Gui.Enabled = false
		p1._tree = nil
		p1._currentNode = nil
		p1._history = nil
		p1:_clearHistoryUI()
		p1:_clearChoicesUI()
		p1.CurrentNPC = nil
		p1.CurrentProfile = nil

		local ok2, result2 = pcall(require, ReplicatedStorage:WaitForChild("NpcInteractionController", 1))

		if ok2 and (result2 and result2.IsOpen) then
			result2:Close()
		end
	else
		result:ShowToast(({
			no_package_space = "Not enough inventory space for the package",
			task_cap_reached = "Task limit reached",
			offer_expired = "That contract\'s already gone",
			locked = "Crow doesn\'t trust you with that yet",
			already_active = "Finish what you\'re already carrying first",
			already_done = "That\'s behind you now",
			wrong_place = "Not here. That\'s Zone business."
		})[v2 or "unknown"] or "Couldn\'t accept task")
		p1:_openWorkPanelHandoff()
	end
end
function t._onBriefingChoice(p1, p2, p3, p4) --[[ _onBriefingChoice | Line: 1262 ]]
	p1:_addHistoryLine("PLAYER", p3, false)

	if p2 == "take" then
		p1:_performTake(p4)

		return
	end

	if p2 == "else" then
		p1:_openWorkPanelHandoff()

		return
	end

	if p2 ~= "pass" then
		return
	end

	p1:_returnToNpcMenu()
end
function t.SayLine(p1, p2, p3, p4, p5) --[[ SayLine | Line: 1280 | Upvalues: makeChoiceButton (copy) ]]
	if p1.IsOpen then
		return false
	end

	if not p4 or p4 == "" then
		return false
	end

	p1.IsOpen = true
	p1.CurrentNPC = p2
	p1.CurrentProfile = p3

	local v2 = string.upper(p3 and p3.DisplayName or (p2 and p2.Name or "NPC"))

	p1.NpcName.Text = v2
	p1._history = {}
	p1._lastNpcFinishTime = 0
	p1._tree = nil
	p1._currentNode = nil
	p1:_clearHistoryUI()
	p1:_clearChoicesUI()
	p1.Gui.Enabled = true
	p1:_addHistoryLine(v2, p4, true)
	makeChoiceButton(p1.ChoicesFrame, "1. " .. (p5 or "Right."), 1).MouseButton1Click:Connect(function() --[[ Line: 1299 | Upvalues: p1 (copy) ]]
		if p1.IsOpen then
			p1:_returnToNpcMenu()
		end
	end)

	return true
end
function t.OpenBriefingTopics(p1, p2, p3, p4) --[[ OpenBriefingTopics | Line: 1331 | Upvalues: topicReady (copy), makeChoiceButton (copy) ]]
	if p1.IsOpen then
		return false
	end

	if not (p4 and p4.intro) then
		return false
	end

	p1.IsOpen = true
	p1.CurrentNPC = p2
	p1.CurrentProfile = p3

	local v2 = string.upper(p3 and p3.DisplayName or (p2 and p2.Name or "NPC"))

	p1.NpcName.Text = v2
	p1._history = {}
	p1._lastNpcFinishTime = 0
	p1._tree = nil
	p1._currentNode = nil
	p1:_clearHistoryUI()
	p1:_clearChoicesUI()
	p1.Gui.Enabled = true
	p1:_addHistoryLine(v2, p4.intro, true)

	local v3 = p4.rewards and p4.rewards.money or 0

	if v3 > 0 then
		p1:_addRewardLine(string.format("Reward: %d\226\130\189", v3))
	end

	local t = {}

	local function v4() --[[ Line: 1356 | Upvalues: p1 (copy), p4 (copy), t (copy), topicReady (ref), makeChoiceButton (ref), v2 (copy), v4 (ref) ]]
		p1:_clearChoicesUI()

		local count = 0
		local v1 = ipairs
		local v22 = p4.topics or {}

		for v3, v42 in v1(v22) do
			if not t[v42.id] and topicReady(v42, t) then
				count = count + 1
				makeChoiceButton(p1.ChoicesFrame, count .. ". " .. v42.ask, count).MouseButton1Click:Connect(function() --[[ Line: 1364 | Upvalues: p1 (ref), t (ref), v42 (copy), v2 (ref), v4 (ref) ]]
					if p1.IsOpen and not t[v42.id] then
						t[v42.id] = true
						p1:_addHistoryLine("PLAYER", v42.ask, false)
						p1:_addHistoryLine(v2, v42.say, true)
						v4()
					end
				end)
			end
		end

		local v5 = count + 1

		makeChoiceButton(p1.ChoicesFrame, v5 .. ". " .. (p4.accept or "I\'ll take it."), v5).MouseButton1Click:Connect(function() --[[ Line: 1376 | Upvalues: p1 (ref), p4 (ref) ]]
			if p1.IsOpen then
				p1:_addHistoryLine("PLAYER", p4.accept or "I\'ll take it.", false)
				p1:_performTake({
					id = p4.id,
					onTake = p4.onTake
				})
			end
		end)

		local v6 = v5 + 1

		makeChoiceButton(p1.ChoicesFrame, v6 .. ". " .. (p4.decline or "I\'ll pass."), v6).MouseButton1Click:Connect(function() --[[ Line: 1384 | Upvalues: p1 (ref) ]]
			if p1.IsOpen then
				p1:_returnToNpcMenu()
			end
		end)
	end

	v4()

	return true
end
function t.OpenTurnIn(p1, p2, p3, p4) --[[ OpenTurnIn | Line: 1416 | Upvalues: topicReady (copy), makeChoiceButton (copy), ReplicatedStorage (copy) ]]
	if p1.IsOpen then
		return false
	end

	if not (p4 and p4.intro) then
		return false
	end

	if type(p4.onTurnIn) ~= "function" then
		return false
	end

	p1.IsOpen = true
	p1.CurrentNPC = p2
	p1.CurrentProfile = p3

	local v2 = string.upper(p3 and p3.DisplayName or (p2 and p2.Name or "NPC"))

	p1.NpcName.Text = v2
	p1._history = {}
	p1._lastNpcFinishTime = 0
	p1._tree = nil
	p1._currentNode = nil
	p1:_clearHistoryUI()
	p1:_clearChoicesUI()
	p1.Gui.Enabled = true

	local v3 = p4.rewards and p4.rewards.money or 0
	local t = {}
	local v4 = false

	if type(p4.asked) == "table" then
		for k, v in pairs(p4.asked) do
			if v then
				t[k] = true
				v4 = true
			end
		end
	end

	local v5 = false

	p1:_addHistoryLine(v2, v4 and p4.resumeIntro or p4.intro, true)

	if v3 > 0 then
		p1:_addRewardLine(string.format("Reward: %d\226\130\189", v3))
	end

	local function v8() --[[ Line: 1459 | Upvalues: p1 (copy), p4 (copy), t (copy), topicReady (ref), makeChoiceButton (ref), v5 (ref), v2 (copy), v8 (ref), ReplicatedStorage (ref) ]]
		p1:_clearChoicesUI()

		local count = 0
		local v1 = ipairs
		local v22 = p4.topics or {}

		for v3, v4 in v1(v22) do
			if not t[v4.id] and topicReady(v4, t) then
				count = count + 1
				makeChoiceButton(p1.ChoicesFrame, count .. ". " .. v4.ask, count).MouseButton1Click:Connect(function() --[[ Line: 1467 | Upvalues: p1 (ref), v5 (ref), t (ref), v4 (copy), v2 (ref), p4 (ref), v8 (ref) ]]
					if not p1.IsOpen or (v5 or t[v4.id]) then
						return
					end

					t[v4.id] = true
					p1:_addHistoryLine("PLAYER", v4.ask, false)
					p1:_addHistoryLine(v2, v4.say, true)

					if type(p4.onAsk) == "function" then
						pcall(p4.onAsk, v4.id)
					end

					v8()
				end)
			end
		end

		local v52 = true
		local v6 = ipairs
		local v7 = p4.acceptRequires or {}

		for v82, v9 in v6(v7) do
			if not t[v9] then
				v52 = false

				break
			end
		end

		if v52 then
			count = count + 1

			local resolveAccept = p4.resolveAccept
			local v10, v11, v12

			if type(resolveAccept) == "function" then
				local v13, v14, v15 = p4.resolveAccept(t)

				v10 = v13
				v11 = v14
				v12 = v15
			else
				v10 = nil
				v11 = nil
				v12 = nil
			end

			local v16 = v10 or (p4.accept or "Here.")
			local v17 = v11 or v16

			p1:_setPriceTag(v12)
			makeChoiceButton(p1.ChoicesFrame, count .. ". " .. v16, count).MouseButton1Click:Connect(function() --[[ Line: 1512 | Upvalues: p1 (ref), v5 (ref), v17 (ref), p4 (ref), v12 (ref), ReplicatedStorage (ref), v2 (ref), makeChoiceButton (ref), v8 (ref) ]]
				if not p1.IsOpen or v5 then
					return
				end

				v5 = true
				p1:_addHistoryLine("PLAYER", v17, false)
				p1:_clearChoicesUI()

				local v1, v22, v3, v4 = p4.onTurnIn()

				if not p1.IsOpen then
					return
				end

				if v1 then
					local v52 = tonumber(v4) or v12

					if v52 and v52 > 0 then
						p1:_addTransactionLine(v52)

						local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3))

						if ok and (result and result.ShowToast) then
							result:ShowToast(string.format("Paid %s\226\130\189", (tostring((math.floor(tonumber(v52) or 0))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))))
						end
					end

					local v82, v9

					if not v3 or v3 == "" then
						v82 = {}
						v9 = function() --[[ Line: 1552 | Upvalues: p1 (ref), p4 (ref), v82 (copy), makeChoiceButton (ref), v2 (ref), v9 (ref) ]]
							p1:_clearChoicesUI()

							local count2 = 0

							for v3, v4 in ipairs(p4.afterTopics or {}) do
								if not v82[v4.id] then
									count2 = count2 + 1
									makeChoiceButton(p1.ChoicesFrame, count2 .. ". " .. v4.ask, count2).MouseButton1Click:Connect(function() --[[ Line: 1560 | Upvalues: p1 (ref), v82 (ref), v4 (copy), v2 (ref), v9 (ref) ]]
										if p1.IsOpen and not v82[v4.id] then
											v82[v4.id] = true
											p1:_addHistoryLine("PLAYER", v4.ask, false)
											p1:_addHistoryLine(v2, v4.say, true)
											v9()
										end
									end)
								end
							end

							local v5 = count2 + 1

							makeChoiceButton(p1.ChoicesFrame, v5 .. ". " .. (p4.close or "Right."), v5).MouseButton1Click:Connect(function() --[[ Line: 1571 | Upvalues: p1 (ref) ]]
								if p1.IsOpen then
									p1:_returnToNpcMenu()
								end
							end)
						end
						v9()

						return
					end

					p1:_addHistoryLine(v2, v3, true)
					v82 = {}
					v9 = function() --[[ Line: 1552 | Upvalues: p1 (ref), p4 (ref), v82 (copy), makeChoiceButton (ref), v2 (ref), v9 (ref) ]]
						p1:_clearChoicesUI()

						local count2 = 0

						for v3, v4 in ipairs(p4.afterTopics or {}) do
							if not v82[v4.id] then
								count2 = count2 + 1
								makeChoiceButton(p1.ChoicesFrame, count2 .. ". " .. v4.ask, count2).MouseButton1Click:Connect(function() --[[ Line: 1560 | Upvalues: p1 (ref), v82 (ref), v4 (copy), v2 (ref), v9 (ref) ]]
									if p1.IsOpen and not v82[v4.id] then
										v82[v4.id] = true
										p1:_addHistoryLine("PLAYER", v4.ask, false)
										p1:_addHistoryLine(v2, v4.say, true)
										v9()
									end
								end)
							end
						end

						local v5 = count2 + 1

						makeChoiceButton(p1.ChoicesFrame, v5 .. ". " .. (p4.close or "Right."), v5).MouseButton1Click:Connect(function() --[[ Line: 1571 | Upvalues: p1 (ref) ]]
							if p1.IsOpen then
								p1:_returnToNpcMenu()
							end
						end)
					end
					v9()
				else
					local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 3))

					if not (ok and result) then
						v5 = false
						v8()

						return
					end

					result:ShowToast(({
						missing_item = "You don\'t have what he\'s waiting for",
						not_ready = "That\'s not finished yet",
						wrong_place = "Not here. That\'s Zone business.",
						no_active = "Nothing to hand over",
						not_enough = "You don\'t have that kind of money"
					})[v22 or "unknown"] or "Couldn\'t hand that over right now")
					v5 = false
					v8()
				end
			end)
		end

		local v18 = count + 1

		makeChoiceButton(p1.ChoicesFrame, v18 .. ". " .. (p4.decline or "Not yet."), v18).MouseButton1Click:Connect(function() --[[ Line: 1595 | Upvalues: p1 (ref), v5 (ref) ]]
			if p1.IsOpen and not v5 then
				p1:_returnToNpcMenu()
			end
		end)

		if not p4.breakOff then
			return
		end

		local v19 = v18 + 1

		makeChoiceButton(p1.ChoicesFrame, v19 .. ". " .. p4.breakOff, v19).MouseButton1Click:Connect(function() --[[ Line: 1607 | Upvalues: p1 (ref), v5 (ref), p4 (ref), v2 (ref), makeChoiceButton (ref) ]]
			if not p1.IsOpen or v5 then
				return
			end

			v5 = true
			p1:_addHistoryLine("PLAYER", p4.breakOff, false)

			if p4.breakSay and p4.breakSay ~= "" then
				p1:_addHistoryLine(v2, p4.breakSay, true)
			end

			if type(p4.onBreak) == "function" then
				pcall(p4.onBreak)
			end

			p1:_clearChoicesUI()
			makeChoiceButton(p1.ChoicesFrame, "1. " .. (p4.breakClose or "..."), 1).MouseButton1Click:Connect(function() --[[ Line: 1617 | Upvalues: p1 (ref) ]]
				if p1.IsOpen then
					p1:_returnToNpcMenu()
				end
			end)
		end)
	end

	v8()

	return true
end
function t.OpenBriefing(p1, p2, p3, p4) --[[ OpenBriefing | Line: 1632 | Upvalues: makeChoiceButton (copy) ]]
	if p1.IsOpen then
		return
	end

	if not p4 then
		return
	end

	p1.IsOpen = true
	p1.CurrentNPC = p2
	p1.CurrentProfile = p3

	local v2 = string.upper(p3 and p3.DisplayName or (p2 and p2.Name or "NPC"))

	p1.NpcName.Text = v2
	p1._history = {}
	p1._lastNpcFinishTime = 0
	p1._tree = nil
	p1._currentNode = nil
	p1:_clearHistoryUI()
	p1:_clearChoicesUI()
	p1.Gui.Enabled = true
	p1:_addHistoryLine(v2, p4.briefing or p4.description or "...", true)

	local v4 = p4.rewards or {}
	local v6 = v4.rep and v4.rep.amount or 0
	local v7 = v4.rep and v4.rep.faction or "?"
	local v8 = string.format("Reward: %d\226\130\189", v4.money or 0)

	if v6 > 0 then
		v8 = v8 .. string.format("  +%d %s rep", v6, v7)
	end

	p1:_addRewardLine(v8)

	for i, v in ipairs({
		{
			text = "I\'ll take it.",
			action = "take"
		},
		{
			text = "Got anything else?",
			action = "else"
		},
		{
			text = "I\'ll pass.",
			action = "pass"
		}
	}) do
		makeChoiceButton(p1.ChoicesFrame, tostring(i) .. ". " .. v.text, i).MouseButton1Click:Connect(function() --[[ Line: 1670 | Upvalues: p1 (copy), v (copy), p4 (copy) ]]
			if not p1.IsOpen then
				return
			end

			p1:_onBriefingChoice(v.action, v.text, p4)
		end)
	end
end

return t