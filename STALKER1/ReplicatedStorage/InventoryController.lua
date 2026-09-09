-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local GridPack = require(ReplicatedStorage.GridPack.GridPack)
local ItemDatabase = require(ReplicatedStorage.ItemDatabase)
local InventoryWire = require(ReplicatedStorage:WaitForChild("InventoryWire"))
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"))
local ItemIconStyle = require(ReplicatedStorage:WaitForChild("ItemIconStyle"))
local InventorySounds = ReplicatedStorage:WaitForChild("InventorySounds")

local function pickSound(p1, p2) --[[ pickSound | Line: 24 ]]
	if not p1 then
		return nil
	end

	local v1 = p1:FindFirstChild(p2)

	if not v1 then
		return nil
	end

	if v1:IsA("Sound") then
		return if v1.SoundId == "" or not v1 then nil else v1
	end

	if not v1:IsA("Folder") then
		return nil
	end

	local t = {}

	for i, v in ipairs(v1:GetChildren()) do
		if v:IsA("Sound") and v.SoundId ~= "" then
			t[#t + 1] = v
		end
	end

	if #t == 0 then
		return nil
	end

	return t[math.random(#t)]
end

local function dbgCartGhost(...) --[[ dbgCartGhost | Line: 93 ]] end

local t = {
	IsUsingItem = false,
	PlaySound = function(p1, p2, p3) --[[ PlaySound | Line: 100 | Upvalues: InventorySounds (copy), pickSound (copy), Players (copy) ]]
		local v1 = InventorySounds:FindFirstChild(p2)

		if not v1 then
			return
		end

		local v2 = pickSound(v1, p3) or pickSound(v1, "General")

		if v2 then
			local v3 = v2:Clone()

			v3.Parent = Players.LocalPlayer.PlayerGui
			v3:Play()
			v3.Ended:Connect(function() --[[ Line: 110 | Upvalues: v3 (copy) ]]
				v3:Destroy()
			end)
		end
	end,
	StyleGridContainer = function(p1, p2) --[[ StyleGridContainer | Line: 116 ]]
		if not (p2 and p2.GuiElement) then
			return
		end

		local GuiElement = p2.GuiElement

		if not GuiElement:IsA("CanvasGroup") then
			return
		end

		GuiElement.GroupTransparency = 0.3

		local UIGradient = GuiElement:FindFirstChildOfClass("UIGradient")
		local v1

		if UIGradient then
			UIGradient:Destroy()
		end

		v1 = Instance.new("UIGradient")
		v1.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(215, 207, 255))
		v1.Parent = GuiElement
	end
}
local ScaleTypeFor = ItemIconStyle.ScaleTypeFor

local function cumulativeUIScale(p1) --[[ cumulativeUIScale | Line: 143 ]]
	local v1 = 1

	while p1 and not p1:IsA("LayerCollector") do
		local UIScale = p1:FindFirstChildOfClass("UIScale")

		if UIScale then
			v1 = v1 * UIScale.Scale
		end

		p1 = p1.Parent
	end

	if v1 <= 0 then
		return 1
	end

	return v1
end

local function gridScreenToLocal(p1, p2) --[[ gridScreenToLocal | Line: 171 | Upvalues: cumulativeUIScale (copy) ]]
	local v1 = if p1 then p1.GuiElement else p1

	if not v1 then
		return p2
	end

	local v2 = cumulativeUIScale(v1)

	if v2 == 1 then
		return p2
	end

	local AbsolutePosition = v1.AbsolutePosition

	return AbsolutePosition + (p2 - AbsolutePosition) / v2
end

local v1 = Color3.fromRGB(48, 48, 48)

local function buildGridLines(p1, p2) --[[ buildGridLines | Line: 218 | Upvalues: v1 (copy), cumulativeUIScale (copy) ]]
	local v12 = p1.Parent

	if not v12 or (not p2 or (p2.X < 1 or p2.Y < 1)) then
		return
	end

	local __GridLines = Instance.new("Frame")

	__GridLines.Name = "__GridLines"
	__GridLines.BackgroundTransparency = 1
	__GridLines.BorderSizePixel = 0
	__GridLines.Active = false
	__GridLines.ZIndex = p1.ZIndex
	__GridLines.Visible = p1.Visible
	__GridLines.AnchorPoint = p1.AnchorPoint
	__GridLines.Position = p1.Position
	__GridLines.Size = p1.Size
	__GridLines.Parent = v12

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v1
	UIStroke.Parent = __GridLines

	local t = {}
	local t2 = {}

	local function applyMetrics() --[[ applyMetrics | Line: 243 | Upvalues: p1 (copy), UIStroke (copy), cumulativeUIScale (ref), v12 (copy), t (copy), p2 (copy), t2 (copy) ]]
		local AbsoluteSize = p1.AbsoluteSize

		if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
			return
		end

		local v1 = 1 / AbsoluteSize.X
		local v2 = 1 / AbsoluteSize.Y

		UIStroke.Thickness = 1 / cumulativeUIScale(v12)

		for i, v in ipairs(t) do
			v.Size = UDim2.fromScale(v1, 1)
			v.Position = UDim2.fromScale(i / p2.X - v1 / 2, 0)
		end

		for i, v in ipairs(t2) do
			v.Size = UDim2.fromScale(1, v2)
			v.Position = UDim2.fromScale(0, i / p2.Y - v2 / 2)
		end
	end

	local function newLine(p1) --[[ newLine | Line: 259 | Upvalues: v1 (ref), __GridLines (copy) ]]
		local Frame = Instance.new("Frame")

		Frame.BackgroundColor3 = v1
		Frame.BorderSizePixel = 0
		Frame.Active = false
		Frame.Parent = __GridLines
		table.insert(p1, Frame)
	end

	for i = 1, p2.X - 1 do
		local Frame = Instance.new("Frame")

		Frame.BackgroundColor3 = v1
		Frame.BorderSizePixel = 0
		Frame.Active = false
		Frame.Parent = __GridLines
		table.insert(t, Frame)
	end

	for j = 1, p2.Y - 1 do
		local Frame = Instance.new("Frame")

		Frame.BackgroundColor3 = v1
		Frame.BorderSizePixel = 0
		Frame.Active = false
		Frame.Parent = __GridLines
		table.insert(t2, Frame)
	end

	local function mirrorAspect() --[[ mirrorAspect | Line: 270 | Upvalues: p1 (copy), __GridLines (copy) ]]
		local UIAspectRatioConstraint = p1:FindFirstChildOfClass("UIAspectRatioConstraint")
		local UIAspectRatioConstraint2 = __GridLines:FindFirstChildOfClass("UIAspectRatioConstraint")

		if UIAspectRatioConstraint and not UIAspectRatioConstraint2 then
			local UIAspectRatioConstraint3 = Instance.new("UIAspectRatioConstraint")

			UIAspectRatioConstraint3.Parent = __GridLines
			UIAspectRatioConstraint2 = UIAspectRatioConstraint3
		elseif not UIAspectRatioConstraint then
			if not UIAspectRatioConstraint2 then
				return
			end

			UIAspectRatioConstraint2:Destroy()

			return
		end

		UIAspectRatioConstraint2.AspectRatio = UIAspectRatioConstraint.AspectRatio
		UIAspectRatioConstraint2.AspectType = UIAspectRatioConstraint.AspectType
		UIAspectRatioConstraint2.DominantAxis = UIAspectRatioConstraint.DominantAxis
	end

	applyMetrics()
	mirrorAspect()
	p1.ChildAdded:Connect(mirrorAspect)
	p1.ChildRemoved:Connect(mirrorAspect)
	p1:GetPropertyChangedSignal("AbsoluteSize"):Connect(applyMetrics)
	p1:GetPropertyChangedSignal("Size"):Connect(function() --[[ Line: 290 | Upvalues: __GridLines (copy), p1 (copy) ]]
		__GridLines.Size = p1.Size
	end)
	p1:GetPropertyChangedSignal("Position"):Connect(function() --[[ Line: 293 | Upvalues: __GridLines (copy), p1 (copy) ]]
		__GridLines.Position = p1.Position
	end)
	p1:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 296 | Upvalues: __GridLines (copy), p1 (copy) ]]
		__GridLines.Visible = p1.Visible
	end)
	p1.Destroying:Connect(function() --[[ Line: 299 | Upvalues: __GridLines (copy) ]]
		__GridLines:Destroy()
	end)
end

function t.PatchGridForOversizedItems(p1, p2) --[[ PatchGridForOversizedItems | Line: 305 | Upvalues: cumulativeUIScale (copy) ]]
	local GetItemManagerPositionFromAbsolutePosition = p2.GetItemManagerPositionFromAbsolutePosition

	function p2.GetItemManagerPositionFromAbsolutePosition(p1, p2, p3, p4) --[[ Line: 308 | Upvalues: cumulativeUIScale (ref), GetItemManagerPositionFromAbsolutePosition (copy) ]]
		local v1 = if p4 == 1 or (p4 == 3 or p4 == 90) then true elseif p4 == 270 then true else false

		if not (p1.GridSize.X - (v1 and p3.Y or p3.X) < 0 or p1.GridSize.Y - (v1 and p3.X or p3.Y) < 0) then
			return GetItemManagerPositionFromAbsolutePosition(p1, p2, p3, p4)
		end

		local v4 = p1:GetSizeScale()
		local v5 = p1:GetOffset(p4)
		local v6 = if p1 then p1.GuiElement else p1
		local v7

		if v6 then
			local v8 = cumulativeUIScale(v6)

			if v8 == 1 then
				v7 = p2
			else
				local AbsolutePosition = v6.AbsolutePosition

				v7 = AbsolutePosition + (p2 - AbsolutePosition) / v8
			end
		else
			v7 = p2
		end

		local v10 = math.floor((v7.X - v5.X) / v4.X + 0.5)
		local v12 = math.floor((v7.Y - v5.Y) / v4.Y + 0.5)

		return Vector2.new(math.clamp(v10, 0, (math.max(0, p1.GridSize.X - 1))), (math.clamp(v12, 0, (math.max(0, p1.GridSize.Y - 1)))))
	end
end
function t._patchGridPackDragScaling(p1) --[[ _patchGridPackDragScaling | Line: 362 | Upvalues: ReplicatedStorage (copy), cumulativeUIScale (copy), buildGridLines (copy), UserInputService (copy) ]]
	if p1._gridPackDragPatched then
		return
	end

	local GridPack = ReplicatedStorage:FindFirstChild("GridPack")
	local v1 = if GridPack then GridPack:FindFirstChild("GridPack") and GridPack.GridPack:FindFirstChild("Item") else GridPack

	if not v1 then
		warn("[InventoryController] GridPack drag patch skipped: Item module not found")

		return
	end

	local ok, result = pcall(require, v1)

	if ok and type(result) == "table" then
		p1._gridPackDragPatched = true

		local ItemManager = GridPack.GridPack:FindFirstChild("ItemManager")
		local ok2, result2 = pcall(require, if ItemManager then ItemManager:FindFirstChild("Grid") else ItemManager)

		if ok2 and type(result2) == "table" then
			local GetItemManagerPositionFromAbsolutePosition = result2.GetItemManagerPositionFromAbsolutePosition

			function result2.GetItemManagerPositionFromAbsolutePosition(p1, p2, p3, p4) --[[ GetItemManagerPositionFromAbsolutePosition | Line: 391 | Upvalues: GetItemManagerPositionFromAbsolutePosition (copy), cumulativeUIScale (ref) ]]
				local v2 = if p1 then p1.GuiElement else p1
				local v3, v4

				if v2 then
					local v5 = cumulativeUIScale(v2)

					if v5 == 1 then
						v3 = p1
						v4 = p2
					else
						local AbsolutePosition = v2.AbsolutePosition

						v3 = p1
						v4 = AbsolutePosition + (p2 - AbsolutePosition) / v5
					end
				else
					v3 = p1
					v4 = p2
				end

				return GetItemManagerPositionFromAbsolutePosition(v3, v4, p3, p4)
			end

			local _createGuiElement = result2._createGuiElement

			function result2._createGuiElement(p1, p2) --[[ _createGuiElement | Line: 399 | Upvalues: _createGuiElement (copy), buildGridLines (ref) ]]
				local v1, v2 = _createGuiElement(p1, p2)
				local ok, result = pcall(buildGridLines, v1, p2.GridSize)

				if ok then
					return v1, v2
				end

				warn("[InventoryController] grid lines skipped: " .. tostring(result))

				return v1, v2
			end
		else
			warn("[InventoryController] GridPack hit-test patch skipped: Grid module unavailable")
		end

		function result._updateDraggingPosition(p1) --[[ _updateDraggingPosition | Line: 411 | Upvalues: cumulativeUIScale (ref), UserInputService (ref) ]]
			local AbsolutePosition = p1.ItemManager.GuiElement.Parent.AbsolutePosition
			local v1 = cumulativeUIScale(p1.ItemElement.Parent)
			local v2 = UserInputService:GetMouseLocation()

			if not p1._dragAnchored then
				p1._dragAnchored = true
				p1._dragAnchorMouse = v2
				p1._dragAnchorElement = p1.ItemElement.AbsolutePosition

				if p1._draggingTrove then
					p1._draggingTrove:Add(function() --[[ Line: 436 | Upvalues: p1 (copy) ]]
						p1._dragAnchored = false
					end)
				end
			end

			local v3 = p1._dragAnchorElement + (v2 - p1._dragAnchorMouse)

			p1.ItemElement.Position = UDim2.fromOffset((v3.X - AbsolutePosition.X) / v1, (v3.Y - AbsolutePosition.Y) / v1)

			if not p1._highlight then
				return
			end

			local v4 = p1.HoveringItemManager or p1.ItemManager
			local v5 = v4:GetItemManagerPositionFromAbsolutePosition(p1.ItemElement.AbsolutePosition, p1.Size, p1.PotentialRotation)

			p1._highlight.Position = v5

			if v4:IsColliding(p1, { p1 }, v5, p1.PotentialRotation) == true then
				p1._highlight.Color = Color3.new(255/255, 0/255, 0/255)
			else
				p1._highlight.Color = Color3.new(0, 0.666667, 0)
			end
		end
	else
		warn("[InventoryController] GridPack drag patch skipped: " .. tostring(result))
	end
end

local function offsetToScale(p1, p2, p3) --[[ offsetToScale | Line: 468 ]]
	local Size = p1.Size
	local Position = p1.Position

	p1.Size = UDim2.fromScale(Size.X.Scale + Size.X.Offset / p2, Size.Y.Scale + Size.Y.Offset / p3)
	p1.Position = UDim2.fromScale(Position.X.Scale + Position.X.Offset / p2, Position.Y.Scale + Position.Y.Offset / p3)
end

function t._convertReadoutsToScale(p1, p2) --[[ _convertReadoutsToScale | Line: 499 | Upvalues: offsetToScale (copy) ]]
	local UIAspectRatioConstraint = p2:FindFirstChildOfClass("UIAspectRatioConstraint")

	if not UIAspectRatioConstraint then
		return
	end

	local v1 = 1080 * UIAspectRatioConstraint.AspectRatio

	for i, v in ipairs({
		{ "InventoryFrame", "WeightDisplay" },
		{ "InventoryFrame", "RoubleDisplay" },
		{ "CharacterFrame", "RadDisplay" },
		{ "CharacterFrame", "ArmorProtection" }
	}) do
		local v2 = p2:FindFirstChild(v[1])
		local v3 = if v2 then v2:FindFirstChild(v[2]) else v2

		if v3 then
			local Offset = v3.Size.X.Offset
			local Offset2 = v3.Size.Y.Offset

			if Offset > 0 and Offset2 > 0 then
				for i2, v4 in ipairs(v3:GetChildren()) do
					if v4:IsA("GuiObject") then
						offsetToScale(v4, Offset, Offset2)
					end
				end

				offsetToScale(v3, v2.Size.X.Scale * v1, v2.Size.Y.Scale * 1080)
			end
		end
	end

	local InventoryFrame = p2:FindFirstChild("InventoryFrame")
	local v4 = if InventoryFrame then InventoryFrame:FindFirstChild("RoubleDisplay") else InventoryFrame
	local v5 = if v4 then v4:FindFirstChild("DropButton") else v4

	if not v5 or (not v5:IsA("TextButton") or v5.TextScaled) then
		return
	end

	local v6 = v5:FindFirstChildOfClass("UITextSizeConstraint") or Instance.new("UITextSizeConstraint")

	v6.MaxTextSize = v5.TextSize
	v6.Parent = v5
	v5.TextScaled = true
end
function t.ApplyResolutionScale(p1) --[[ ApplyResolutionScale | Line: 553 ]]
	if not p1.ResScale then
		return
	end

	local CurrentCamera = workspace.CurrentCamera

	if not CurrentCamera then
		return
	end

	p1.ResScale.Scale = math.clamp(CurrentCamera.ViewportSize.Y / 1080, 0.85, 1)

	if not p1.InvScroll then
		return
	end

	task.defer(function() --[[ Line: 563 | Upvalues: p1 (copy) ]]
		p1:UpdateInventoryCanvas()
	end)
end
function t.UpdateInventoryCanvas(p1) --[[ UpdateInventoryCanvas | Line: 573 ]]
	local InvScroll = p1.InvScroll
	local InvContent = p1.InvContent

	if not (InvScroll and InvContent) then
		return
	end

	local RunService = game:GetService("RunService")

	RunService.Heartbeat:Wait()
	RunService.Heartbeat:Wait()

	local Y = InvContent.AbsolutePosition.Y
	local Y2 = InvScroll.AbsoluteWindowSize.Y
	local v1 = Y2

	local function consider(p1) --[[ consider | Line: 586 | Upvalues: Y (copy), v1 (ref) ]]
		local v12 = p1 - Y

		if not (v1 < v12) then
			return
		end

		v1 = v12
	end

	if p1.BackpackSectionFrame then
		local v2 = p1.BackpackSectionFrame.AbsolutePosition.Y + p1.BackpackSectionFrame.AbsoluteSize.Y - Y

		if v1 < v2 then
			v1 = v2
		end
	end

	if p1.MainInventory and p1.MainInventory.GuiElement then
		local GuiElement = p1.MainInventory.GuiElement
		local GridSize = p1.MainInventory.GridSize
		local Y3 = GuiElement.AbsolutePosition.Y
		local v3 = Y3 + GuiElement.AbsoluteSize.Y - Y

		if v1 < v3 then
			v1 = v3
		end

		if GridSize and (GridSize.X > 0 and GuiElement.AbsoluteSize.X > 0) then
			local v4 = Y3 + GuiElement.AbsoluteSize.X / GridSize.X * GridSize.Y - Y

			if v1 < v4 then
				v1 = v4
			end
		end
	end

	local v5 = v1 + 40 - Y2
	local v6 = math.max(0, v5)

	InvScroll.CanvasSize = UDim2.new(0, 0, 1, v6 / math.max(p1.ResScale and p1.ResScale.Scale or 1, 0.001))
end

local t2 = {
	pockets = "Pockets",
	rig = "ChestRig",
	belt = "BattleBelt",
	backpack = "Backpack",
	stash = "Stash"
}

function t._scCheckComposite(p1, p2, p3, p4) --[[ _scCheckComposite | Line: 652 | Upvalues: Players (copy), t2 (copy) ]]
	p1._scLatestOp = p2
	task.delay(0.8, function() --[[ Line: 654 | Upvalues: p1 (copy), p2 (copy), Players (ref), p4 (copy), t2 (ref), p3 (copy) ]]
		if p1._scLatestOp ~= p2 then
			return
		end

		local v1 = 0
		local t = {}
		local v2 = 0
		local t3 = {}

		local function drop(p1, p2) --[[ drop | Line: 659 | Upvalues: t (copy), p4 (ref), t2 (ref), v2 (ref), t3 (copy) ]]
			table.insert(t, p1 .. "=" .. p2)

			local v22 = p4 and p4[t2[p1]]

			if not v22 then
				return
			end

			v2 = v2 + v22
			table.insert(t3, string.format("%s(%d)", p1, v22))
		end

		local function count(p1, p2, p3) --[[ count | Line: 670 | Upvalues: t (copy), p4 (ref), t2 (ref), v2 (ref), t3 (copy), v1 (ref) ]]
			if p1 then
				local v12 = p1.Metadata and p1.Metadata.TiedInstance

				if p3 and v12 ~= p3 then
					table.insert(t, p2 .. "=" .. "<showing " .. tostring(v12) .. ">")

					local v4 = p4 and p4[t2[p2]]

					if not v4 then
						return
					end

					v2 = v2 + v4
					table.insert(t3, string.format("%s(%d)", p2, v4))
				else
					local count = 0
					local v6 = pairs

					for v8, v9 in v6(p1.Items or {}) do
						if v9 and (v9.Metadata and v9.Metadata.ID) then
							count = count + 1
						end
					end

					v1 = v1 + count
					table.insert(t, p2 .. "=" .. count)
				end
			else
				table.insert(t, p2 .. "=nil")

				local v12 = p4 and p4[t2[p2]]

				if not v12 then
					return
				end

				v2 = v2 + v12
				table.insert(t3, string.format("%s(%d)", p2, v12))
			end
		end

		count(p1.LocalInventory, "pockets")
		count(p1.ChestRigInventory, "rig")
		count(p1.BattleBeltInventory, "belt")
		count(p1.MainInventory, "backpack")
		count(p1.StorageInventory, "stash", "Stash_" .. Players.LocalPlayer.UserId)

		local v3 = p3 - v2

		if #t3 > 0 then
			table.insert(t, "[not rendered, excluded from both sides: " .. table.concat(t3, " ") .. "]")
		elseif not p4 then
			table.insert(t, "[no per-container data -- comparison is blind]")
		end

		local v5 = table.concat(t, " ")

		if v1 ~= v3 then
			warn(string.format("[SCTRACE op=%s] COMPOSITE_MISMATCH client sees %d, server had %d (short %d) | %s", tostring(p2), v1, v3, v3 - v1, v5))
		end
	end)
end
function t.Init(p1) --[[ Init | Line: 713 | Upvalues: StarterGui (copy), Players (copy), ReplicatedStorage (copy), GridPack (copy), UserInputService (copy), pickSound (copy), ItemDatabase (copy), InventorySounds (copy) ]]
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

	local InventoryGui = Players.LocalPlayer.PlayerGui:WaitForChild("InventoryGui")

	p1.CurrentStoragePart = nil

	local InventoryFrame = InventoryGui.MainFrame.InventoryFrame
	local ContainerFrame = InventoryGui.MainFrame.ContainerFrame
	local CharacterFrame = InventoryGui.MainFrame.CharacterFrame
	local BackpackFrame = InventoryFrame.BackpackFrame
	local Frame2 = InventoryFrame.BackpackFrame.Frame
	local Frame3 = InventoryFrame.ChestRigFrame.Frame

	p1.ChestRigPattern = InventoryFrame.ChestRigFrame.Pattern

	local BattleBeltFrame = InventoryFrame.BattleBeltFrame
	local Frame4 = InventoryFrame.BattleBeltFrame.Frame

	p1.BattleBeltGridFrame = Frame4

	local PrimaryFrame = CharacterFrame.PrimaryFrame
	local SecondaryFrame = CharacterFrame.SecondaryFrame
	local SidearmFrame = CharacterFrame.SidearmFrame
	local MeleeFrame = CharacterFrame.MeleeFrame

	p1.PrimaryFrame = PrimaryFrame
	p1.SecondaryFrame = SecondaryFrame
	p1.SidearmFrame = SidearmFrame
	p1.MeleeFrame = MeleeFrame

	local Frame5 = ContainerFrame.CrateFrame.Frame
	local TextLabel = ContainerFrame.CrateFrame.Title.TextLabel

	p1.BackpackGridFrame = Frame2
	p1.ChestRigGridFrame = Frame3
	p1.CrateGridFrame = Frame5
	p1.CrateTitleLabel = TextLabel
	p1.BackpackSectionFrame = BackpackFrame

	local StashScroll = ContainerFrame:FindFirstChild("StashScroll")

	if StashScroll then
		StashScroll:Destroy()
	end

	p1._stashScroll = nil

	local MainFrame = InventoryGui.MainFrame
	local ResScale = MainFrame:FindFirstChild("ResScale")

	if ResScale then
		ResScale:Destroy()
	end

	local ResScale2 = Instance.new("UIScale")

	ResScale2.Name = "ResScale"
	ResScale2.Scale = 1
	ResScale2.Parent = MainFrame
	p1.ResScale = ResScale2
	p1:_convertReadoutsToScale(MainFrame)
	p1:_patchGridPackDragScaling()

	local CurrentCamera = workspace.CurrentCamera

	if p1._viewportConn then
		p1._viewportConn:Disconnect()
	end

	if CurrentCamera then
		p1._viewportConn = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 782 | Upvalues: p1 (copy) ]]
			p1:ApplyResolutionScale()
		end)
	end

	if p1._camSwapConn then
		p1._camSwapConn:Disconnect()
	end

	p1._camSwapConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 787 | Upvalues: p1 (copy) ]]
		local CurrentCamera = workspace.CurrentCamera

		if not CurrentCamera then
			return
		end

		if p1._viewportConn then
			p1._viewportConn:Disconnect()
		end

		p1._viewportConn = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 791 | Upvalues: p1 (ref) ]]
			p1:ApplyResolutionScale()
		end)
		p1:ApplyResolutionScale()
	end)
	p1:ApplyResolutionScale()

	local InvScroll = InventoryFrame:FindFirstChild("InvScroll")

	if InvScroll then
		InvScroll:Destroy()
	end

	local InvScroll2 = Instance.new("ScrollingFrame")

	InvScroll2.Name = "InvScroll"
	InvScroll2.Size = UDim2.fromScale(1, 1)
	InvScroll2.Position = UDim2.fromScale(0, 0)
	InvScroll2.BackgroundTransparency = 1
	InvScroll2.BorderSizePixel = 0
	InvScroll2.ScrollingDirection = Enum.ScrollingDirection.Y
	InvScroll2.ScrollBarThickness = 6
	InvScroll2.ClipsDescendants = true
	InvScroll2.CanvasSize = UDim2.new(0, 0, 1, 0)
	InvScroll2.AutomaticCanvasSize = Enum.AutomaticSize.None
	InvScroll2.Active = true
	InvScroll2.Parent = InventoryFrame
	p1.InvScroll = InvScroll2

	local InvContent = Instance.new("Frame")

	InvContent.Name = "InvContent"
	InvContent.BackgroundTransparency = 1
	InvContent.BorderSizePixel = 0
	InvContent.Position = UDim2.fromOffset(0, 0)
	InvContent.Parent = InvScroll2
	p1.InvContent = InvContent

	local function syncInvContentSize() --[[ syncInvContentSize | Line: 830 | Upvalues: InvScroll2 (copy), p1 (copy), InvContent (copy) ]]
		local AbsoluteWindowSize = InvScroll2.AbsoluteWindowSize
		local v1 = if p1.ResScale then p1.ResScale.Scale or 1 else 1

		if not (AbsoluteWindowSize.X > 0 and (AbsoluteWindowSize.Y > 0 and v1 > 0)) then
			return
		end

		InvContent.Size = UDim2.fromOffset(AbsoluteWindowSize.X / v1, AbsoluteWindowSize.Y / v1)
	end

	local AbsoluteWindowSize = InvScroll2.AbsoluteWindowSize
	local v1 = p1.ResScale and p1.ResScale.Scale or 1

	if AbsoluteWindowSize.X > 0 and (AbsoluteWindowSize.Y > 0 and v1 > 0) then
		InvContent.Size = UDim2.fromOffset(AbsoluteWindowSize.X / v1, AbsoluteWindowSize.Y / v1)
	end

	if p1._invContentConn then
		p1._invContentConn:Disconnect()
	end

	p1._invContentConn = InvScroll2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 839 | Upvalues: InvScroll2 (copy), p1 (copy), InvContent (copy) ]]
		local AbsoluteWindowSize = InvScroll2.AbsoluteWindowSize
		local v1 = if p1.ResScale then p1.ResScale.Scale or 1 else 1

		if AbsoluteWindowSize.X > 0 and (AbsoluteWindowSize.Y > 0 and v1 > 0) then
			InvContent.Size = UDim2.fromOffset(AbsoluteWindowSize.X / v1, AbsoluteWindowSize.Y / v1)
		end

		p1:UpdateInventoryCanvas()
	end)

	for i, v in ipairs({
		InventoryFrame.ChestRigFrame,
		BattleBeltFrame,
		InventoryFrame:FindFirstChild("PocketsFrame"),
		BackpackFrame
	}) do
		if v and v.Parent then
			v.Parent = InvContent
		end
	end

	p1.BackpackAuthoredSize = BackpackFrame.Size

	local v2 = ReplicatedStorage.Remotes.GetLocalInventory:InvokeServer()
	local v3 = Vector2.new(4, 1)

	p1.LocalInventory = GridPack.createGrid({
		Visible = true,
		SlotAspectRatio = 1,
		Parent = InventoryFrame.PocketsFrame.Frame,
		Assets = {
			Slot = game.ReplicatedStorage.GridPack.Slot
		},
		GridSize = v3,
		Size = UDim2.fromScale(v3.X, v3.Y),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 0, 0),
		Metadata = {
			TiedInstance = v2.TiedInstance
		}
	})
	p1:PatchGridForOversizedItems(p1.LocalInventory)
	p1:StyleGridContainer(p1.LocalInventory)
	p1.LocalInventory.IsColliding = p1:CreateGridIsColliding()
	p1.MainInventory = GridPack.createGrid({
		Visible = false,
		SlotAspectRatio = 1,
		Parent = Frame2,
		Assets = {
			Slot = game.ReplicatedStorage.GridPack.Slot
		},
		GridSize = Vector2.new(1, 1),
		Size = UDim2.fromScale(1, 1),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 0, 0),
		Metadata = {
			TiedInstance = "BackpackInternal_" .. Players.LocalPlayer.UserId
		}
	})
	p1:PatchGridForOversizedItems(p1.MainInventory)
	p1:StyleGridContainer(p1.MainInventory)
	p1.MainInventory.IsColliding = p1:CreateGridIsColliding()
	p1.ChestRigInventory = GridPack.createGrid({
		Visible = false,
		SlotAspectRatio = 1,
		Parent = Frame3,
		Assets = {
			Slot = game.ReplicatedStorage.GridPack.Slot
		},
		GridSize = Vector2.new(1, 1),
		Size = UDim2.fromScale(1, 1),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 0, 0),
		Metadata = {
			TiedInstance = "ChestRigInternal_" .. Players.LocalPlayer.UserId
		}
	})

	if p1.ChestRigInventory.GuiElement then
		p1.ChestRigInventory.GuiElement.Visible = false
		p1.ChestRigInventory.GuiElement.Size = UDim2.new(0, 0, 0, 0)
	end

	p1:PatchGridForOversizedItems(p1.ChestRigInventory)
	p1:StyleGridContainer(p1.ChestRigInventory)
	p1.ChestRigInventory.IsColliding = p1:CreateGridIsColliding()
	p1.BattleBeltInventory = GridPack.createGrid({
		Visible = false,
		SlotAspectRatio = 1,
		Parent = Frame4,
		Assets = {
			Slot = game.ReplicatedStorage.GridPack.Slot
		},
		GridSize = Vector2.new(1, 1),
		Size = UDim2.fromScale(1, 1),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 0, 0),
		Metadata = {
			TiedInstance = "BattleBeltInternal_" .. Players.LocalPlayer.UserId
		}
	})

	if p1.BattleBeltInventory.GuiElement then
		p1.BattleBeltInventory.GuiElement.Visible = false
		p1.BattleBeltInventory.GuiElement.Size = UDim2.new(0, 0, 0, 0)
	end

	p1:PatchGridForOversizedItems(p1.BattleBeltInventory)
	p1:StyleGridContainer(p1.BattleBeltInventory)
	p1.BattleBeltInventory.IsColliding = p1:CreateGridIsColliding()
	p1.HeadSlot = p1:CreateEquipmentSlot(CharacterFrame.HeadGearFrame, "HeadGear")
	p1.FaceWearSlot = p1:CreateEquipmentSlot(CharacterFrame.FaceWearFrame, "FaceWear")
	p1.EyeWearSlot = p1:CreateEquipmentSlot(CharacterFrame.EyeWearFrame, "EyeWear")
	p1.BodySlot = p1:CreateEquipmentSlot(CharacterFrame.BodyGearFrame, "BodyGear")
	p1.BeltGearSlot = p1:CreateEquipmentSlot(BattleBeltFrame, "BeltGear")
	p1.PrimarySlot = p1:CreateEquipmentSlot(PrimaryFrame, "Primary")
	p1.SecondarySlot = p1:CreateEquipmentSlot(SecondaryFrame, "Secondary")
	p1.SidearmSlot = p1:CreateEquipmentSlot(SidearmFrame, "Sidearm")
	p1.MeleeSlot = p1:CreateEquipmentSlot(MeleeFrame, "Melee")
	p1.UniformSlot = p1:CreateEquipmentSlot(CharacterFrame.UniformFrame, "Uniform")
	p1.BackpackSlot = p1:CreateEquipmentSlot(BackpackFrame, "Backpack")
	p1.NightOpticalSlot = p1:CreateEquipmentSlot(CharacterFrame.NightOpticalFrame, "NightOptical")
	p1.StorageInventory = GridPack.createGrid({
		Visible = false,
		SlotAspectRatio = 1,
		Parent = Frame5,
		Assets = {
			Slot = game.ReplicatedStorage.GridPack.Slot
		},
		GridSize = Vector2.new(1, 1),
		Size = UDim2.fromScale(1, 1),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 0, 0),
		Metadata = {
			TiedInstance = nil
		}
	})
	p1:PatchGridForOversizedItems(p1.StorageInventory)
	p1.StorageInventory.IsColliding = p1:CreateGridIsColliding()
	p1.TransferLink = GridPack.createTransferLink({})
	p1.LocalInventory:ConnectTransferLink(p1.TransferLink)
	p1.MainInventory:ConnectTransferLink(p1.TransferLink)
	p1.ChestRigInventory:ConnectTransferLink(p1.TransferLink)
	p1.BattleBeltInventory:ConnectTransferLink(p1.TransferLink)
	p1.StorageInventory:ConnectTransferLink(p1.TransferLink)
	p1.HeadSlot:ConnectTransferLink(p1.TransferLink)
	p1.FaceWearSlot:ConnectTransferLink(p1.TransferLink)
	p1.EyeWearSlot:ConnectTransferLink(p1.TransferLink)
	p1.BodySlot:ConnectTransferLink(p1.TransferLink)
	p1.BeltGearSlot:ConnectTransferLink(p1.TransferLink)
	p1.PrimarySlot:ConnectTransferLink(p1.TransferLink)
	p1.SecondarySlot:ConnectTransferLink(p1.TransferLink)
	p1.SidearmSlot:ConnectTransferLink(p1.TransferLink)
	p1.MeleeSlot:ConnectTransferLink(p1.TransferLink)
	p1.UniformSlot:ConnectTransferLink(p1.TransferLink)
	p1.BackpackSlot:ConnectTransferLink(p1.TransferLink)
	p1.NightOpticalSlot:ConnectTransferLink(p1.TransferLink)

	local RunService = game:GetService("RunService")
	local v4 = Color3.fromRGB(140, 230, 110)
	local v5 = Color3.fromRGB(230, 90, 90)

	local function ensureStroke(p1) --[[ ensureStroke | Line: 1007 | Upvalues: v4 (copy) ]]
		local DragHighlight = p1:FindFirstChild("DragHighlight")

		if not DragHighlight then
			local DragHighlight2 = Instance.new("UIStroke")

			DragHighlight2.Name = "DragHighlight"
			DragHighlight2.Color = v4
			DragHighlight2.Thickness = 3
			DragHighlight2.Transparency = 1
			DragHighlight2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			DragHighlight2.Parent = p1
			DragHighlight = DragHighlight2
		end

		return DragHighlight
	end

	local function findDragging() --[[ findDragging | Line: 1021 | Upvalues: p1 (copy) ]]
		local TransferLink = p1.TransferLink

		if not (TransferLink and TransferLink.ConnectedItemManagers) then
			return nil, nil
		end

		for i, v in ipairs(TransferLink.ConnectedItemManagers) do
			local Items = v.Items

			if Items then
				for k, v2 in pairs(Items) do
					if v2.IsDragging and v2.Metadata then
						return v2.Metadata.ItemType, v2
					end
				end
			end
		end

		return nil, nil
	end

	local v6 = 0

	p1._equipSlotHintConn = RunService.RenderStepped:Connect(function(p12) --[[ Line: 1038 | Upvalues: InventoryGui (copy), p1 (copy), v6 (ref), findDragging (copy), v4 (copy), v5 (copy) ]]
		if InventoryGui and not InventoryGui.Enabled then
			return
		end

		local TransferLink = p1.TransferLink

		if not (TransferLink and TransferLink.ConnectedItemManagers) then
			return
		end

		v6 = v6 + p12

		local v2 = (math.sin(v6 * 1.5 * math.pi * 2) + 1) * 0.5 * -0.55 + 0.55
		local v3, _ = findDragging()

		for i, v in ipairs(TransferLink.ConnectedItemManagers) do
			local v42
			local Metadata = v.Metadata
			local GuiElement = v.GuiElement

			if not (Metadata and Metadata.IsBarterChip) and (Metadata and (Metadata.AcceptsType and (GuiElement and GuiElement.Visible))) then
				local AcceptsType = Metadata.AcceptsType

				v42 = if v3 then if AcceptsType == v3 then true elseif AcceptsType == "Secondary" then if v3 == "Primary" then true else false else false else false

				local v62 = if v.Item == nil then false else true
				local DragHighlight = GuiElement:FindFirstChild("DragHighlight")

				if not DragHighlight then
					local DragHighlight2 = Instance.new("UIStroke")

					DragHighlight2.Name = "DragHighlight"
					DragHighlight2.Color = v4
					DragHighlight2.Thickness = 3
					DragHighlight2.Transparency = 1
					DragHighlight2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					DragHighlight2.Parent = GuiElement
					DragHighlight = DragHighlight2
				end

				if v42 and not v62 then
					DragHighlight.Color = v4
					DragHighlight.Transparency = v2

					continue
				end

				if v42 and v62 then
					DragHighlight.Color = v5
					DragHighlight.Transparency = v2

					continue
				end

				DragHighlight.Transparency = 1
			end
		end
	end)
	task.defer(function() --[[ Line: 1086 | Upvalues: p1 (copy), v2 (copy) ]]
		p1:LoadInventory(p1.LocalInventory, v2)
	end)

	local v7 = nil

	ReplicatedStorage.Remotes.StorageInventoryOpened.OnClientEvent:Connect(function(p12) --[[ Line: 1099 | Upvalues: ReplicatedStorage (ref), p1 (copy), TextLabel (copy), GridPack (ref), InventoryGui (copy), Players (ref), UserInputService (ref), v7 (ref) ]]
		local v1 = if p12 then p12.TiedInstance else p12

		if type(v1) == "string" then
			local v2 = require(ReplicatedStorage:WaitForChild("OpenableContainer")).GetOpen()[v1]

			if v2 and v2.Grid then
				p1:LoadInventory(v2.Grid, p12)

				return
			end
		end

		if p12 and p12.TiedInstance and (type(p12.TiedInstance) == "string" and p12.TiedInstance:sub(1, 5) == "Sell_") then
			if p1.SellPanelGrid then
				p1:LoadInventory(p1.SellPanelGrid, p12)
				p1:RefreshSellPanelTotal()
			end

			if p1.StorageInventory then
				p1:ClearGridPackInventory(p1.StorageInventory)

				if p1.StorageInventory.GuiElement then
					p1.StorageInventory.GuiElement:Destroy()
				end

				p1.StorageInventory = nil
				p1.CurrentStoragePart = nil
			end

			if not p1._expansionPanel then
				return
			end

			p1._expansionPanel.Visible = false

			return
		end

		p1:StopVicinityRefresh()

		if p1._expansionPanel then
			p1._expansionPanel.Visible = false
		end

		if p1.StorageInventory then
			p1:ClearGridPackInventory(p1.StorageInventory)

			if p1.StorageInventory.GuiElement then
				p1.StorageInventory.GuiElement:Destroy()
			end

			p1.StorageInventory = nil
		end

		for k, v in pairs(p1.CrateGridFrame:GetChildren()) do
			if v:IsA("CanvasGroup") then
				v:Destroy()
			end
		end

		local v3 = p12.GridSize or Vector2.new(4, 4)

		TextLabel.Text = string.upper(p12.StorageName or "CRATE")
		print(v3, "Creating new storage grid")
		p1.StorageInventory = GridPack.createGrid({
			Visible = true,
			SlotAspectRatio = 1,
			Parent = p1.CrateGridFrame,
			Assets = {
				Slot = game.ReplicatedStorage.GridPack.Slot
			},
			GridSize = v3,
			Size = UDim2.fromScale(v3.X, v3.Y),
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.new(0, 0, 0, 0),
			Metadata = {
				TiedInstance = p12.TiedInstance
			}
		})
		p1:PatchGridForOversizedItems(p1.StorageInventory)
		p1.StorageInventory.IsColliding = p1:CreateGridIsColliding()
		p1.StorageInventory:ConnectTransferLink(p1.TransferLink)
		InventoryGui.Enabled = true
		game.Lighting.InventoryBlur.Enabled = true
		p1.CurrentStoragePart = p12.TiedInstance
		require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():Disable()
		p1._savedCameraMode = Players.LocalPlayer.CameraMode
		Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
		UserInputService.MouseIconEnabled = true

		if p1._mouseUnlockConn then
			p1._mouseUnlockConn:Disconnect()
		end

		p1._mouseUnlockConn = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 1226 | Upvalues: UserInputService (ref) ]]
			if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			if UserInputService.MouseIconEnabled then
				return
			end

			UserInputService.MouseIconEnabled = true
		end)
		p1:LoadInventory(p1.StorageInventory, p12)
		v7(p12.TiedInstance)

		local TiedInstance = p12.TiedInstance

		if typeof(TiedInstance) ~= "Instance" or not TiedInstance:IsA("BasePart") then
			return
		end

		task.spawn(function() --[[ Line: 1266 | Upvalues: p1 (ref), TiedInstance (copy), Players (ref) ]]
			while p1.CurrentStoragePart == TiedInstance do
				if not TiedInstance.Parent then
					p1:CloseStorage()

					return
				end

				local Character = Players.LocalPlayer.Character
				local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

				if v1 and (v1.Position - TiedInstance.Position).Magnitude > 10 then
					p1:CloseStorage()

					return
				end

				task.wait(0.5)
			end
		end)
	end)

	local function getLootingSoundFolder() --[[ getLootingSoundFolder | Line: 1290 | Upvalues: ReplicatedStorage (ref) ]]
		local InventorySounds = ReplicatedStorage:FindFirstChild("InventorySounds")

		return if InventorySounds then InventorySounds:FindFirstChild("Looting") else InventorySounds
	end

	local function playRandomSound(p1) --[[ playRandomSound | Line: 1298 | Upvalues: ReplicatedStorage (ref), pickSound (ref) ]]
		local InventorySounds = ReplicatedStorage:FindFirstChild("InventorySounds")
		local v1 = InventorySounds and InventorySounds:FindFirstChild("Looting")

		if not v1 then
			return
		end

		local v2 = pickSound(v1, p1)

		if not v2 then
			local t = {}

			for i, v in ipairs(v1:GetChildren()) do
				if v:IsA("Sound") and (v.Name:find("^" .. p1) and v.SoundId ~= "") then
					t[#t + 1] = v
				end
			end

			if #t == 0 then
				return
			end

			v2 = t[math.random(#t)]
		end

		local v3 = v2:Clone()

		v3.Parent = game:GetService("SoundService")
		v3:Play()
		task.delay(8, function() --[[ Line: 1315 | Upvalues: v3 (copy) ]]
			if not (v3 and v3.Parent) then
				return
			end

			v3:Destroy()
		end)
		v3.Ended:Connect(function() --[[ Line: 1316 | Upvalues: v3 (copy) ]]
			if not (v3 and v3.Parent) then
				return
			end

			v3:Destroy()
		end)
	end

	p1._crateSearchSoundToken = 0
	v7 = function(p12) --[[ Line: 1322 | Upvalues: p1 (copy), playRandomSound (copy) ]]
		local v1 = p1

		v1._crateSearchSoundToken = v1._crateSearchSoundToken + 1

		local _crateSearchSoundToken = p1._crateSearchSoundToken

		task.spawn(function() --[[ Line: 1325 | Upvalues: _crateSearchSoundToken (copy), p1 (ref), p12 (copy), playRandomSound (ref) ]]
			while _crateSearchSoundToken == p1._crateSearchSoundToken and (p1.StorageInventory and p1.CurrentStoragePart == p12) do
				local v1 = false

				for i, v in ipairs(p1.CrateGridFrame:GetDescendants()) do
					if v.Name == "SilhouetteOverlay" then
						v1 = true

						break
					end
				end

				if not v1 then
					break
				end

				playRandomSound("Searching")
				task.wait(0.6 + math.random() * 0.4)
			end
		end)
	end
	ReplicatedStorage.Remotes.StorageItemRevealed.OnClientEvent:Connect(function(p12) --[[ Line: 1348 | Upvalues: p1 (copy), playRandomSound (copy) ]]
		if not (p12 and p12.TiedInstance) then
			return
		end

		if not p1.StorageInventory or p1.CurrentStoragePart ~= p12.TiedInstance then
			return
		end

		local t = {}

		for k, v in pairs(p12.Items) do
			if v.Revealed == true then
				t[k] = true
			end
		end

		local count = 0

		for i, v in ipairs(p1.CrateGridFrame:GetDescendants()) do
			if v:IsA("CanvasGroup") and t[v:GetAttribute("ItemIndex")] then
				local SilhouetteOverlay = v:FindFirstChild("SilhouetteOverlay")

				if SilhouetteOverlay then
					SilhouetteOverlay:Destroy()
					count = count + 1
				end
			end
		end

		if not (count > 0) then
			return
		end

		playRandomSound("Reveal")
	end)

	local v8 = false

	ReplicatedStorage.Remotes.LoadEquipment.OnClientEvent:Connect(function(p12) --[[ Line: 1367 | Upvalues: p1 (copy), v8 (ref), PrimaryFrame (copy), SecondaryFrame (copy), SidearmFrame (copy), ReplicatedStorage (ref) ]]
		p1._receivedEquipment = true

		local v1 = (p1._equipEpoch or 0) + 1

		p1._equipEpoch = v1

		local function _eqStale(p12) --[[ _eqStale | Line: 1399 | Upvalues: p1 (ref), v1 (copy) ]]
			return p1._equipEpoch ~= v1
		end

		if not v8 then
			v8 = true
			task.wait(1)
			game:GetService("RunService").RenderStepped:Wait()

			if p1._equipEpoch ~= v1 then
				return
			end
		end

		if p12.IsReconcile then
			local v2 = true
			local v3 = nil

			for k, v in pairs({
				Head = p1.HeadSlot,
				FaceWear = p1.FaceWearSlot,
				EyeWear = p1.EyeWearSlot,
				BeltGear = p1.BeltGearSlot,
				Body = p1.BodySlot,
				Backpack = p1.BackpackSlot,
				Primary = p1.PrimarySlot,
				Secondary = p1.SecondarySlot,
				Sidearm = p1.SidearmSlot,
				Melee = p1.MeleeSlot,
				Uniform = p1.UniformSlot,
				NightOptical = p1.NightOpticalSlot
			}) do
				local v4 = if v then v.Item else v
				local v6 = (if v4 then v4.ItemElement and (if v4.ItemElement.Parent == nil then false else true) else v4) and v4.Metadata and v4.Metadata.ID or nil
				local v82 = p12[k] and p12[k].ID or nil

				if v6 ~= v82 then
					v2, v3 = false, string.format("%s: showing %s, server says %s", k, tostring(v6), (tostring(v82)))

					break
				end
			end

			if v2 then
				return
			end

			warn("[FACEDIAG] equipment reconcile repainting, " .. tostring(v3))
		end

		local function clearSingleSlot(p1) --[[ clearSingleSlot | Line: 1457 ]]
			if not p1 then
				return
			end

			local Item = p1.Item

			if Item then
				pcall(function() --[[ Line: 1461 | Upvalues: p1 (copy) ]]
					p1:RemoveItem()
				end)
				pcall(function() --[[ Line: 1462 | Upvalues: Item (copy) ]]
					Item:Destroy()
				end)
			end

			if not p1.GuiElement then
				return
			end

			for k, v in pairs(p1.GuiElement:GetChildren()) do
				if v:IsA("CanvasGroup") then
					v:Destroy()
				end
			end
		end

		if p12.Head and p1.HeadSlot then
			p1:LoadInventory(p1.HeadSlot, {
				Items = { p12.Head },
				TiedInstance = p1.HeadSlot.Metadata.TiedInstance
			})
		else
			clearSingleSlot(p1.HeadSlot)
		end

		if p12.FaceWear and p1.FaceWearSlot then
			p1:LoadInventory(p1.FaceWearSlot, {
				Items = { p12.FaceWear },
				TiedInstance = p1.FaceWearSlot.Metadata.TiedInstance
			})
		else
			if p1.FaceWearSlot and p1.FaceWearSlot.Item then
				print("[FACEDIAG] client clearing a POPULATED FaceWear slot: LoadEquipment arrived with FaceWear = nil")
			end

			clearSingleSlot(p1.FaceWearSlot)
		end

		if p12.EyeWear and p1.EyeWearSlot then
			p1:LoadInventory(p1.EyeWearSlot, {
				Items = { p12.EyeWear },
				TiedInstance = p1.EyeWearSlot.Metadata.TiedInstance
			})
		else
			clearSingleSlot(p1.EyeWearSlot)
		end

		if p12.NightOptical and p1.NightOpticalSlot then
			p1:LoadInventory(p1.NightOpticalSlot, {
				Items = { p12.NightOptical },
				TiedInstance = p1.NightOpticalSlot.Metadata.TiedInstance
			})
		else
			clearSingleSlot(p1.NightOpticalSlot)
		end

		if p12.Primary and p1.PrimarySlot then
			p1:LoadInventory(p1.PrimarySlot, {
				Items = { p12.Primary },
				TiedInstance = p1.PrimarySlot.Metadata.TiedInstance
			})
			task.delay(0.5, function() --[[ Line: 1524 | Upvalues: p1 (ref), PrimaryFrame (ref) ]]
				p1:UpdateWeaponSlotDisplay(p1.PrimarySlot, PrimaryFrame)
			end)
		else
			clearSingleSlot(p1.PrimarySlot)

			if p1.PrimarySlot and PrimaryFrame then
				p1:UpdateWeaponSlotDisplay(p1.PrimarySlot, PrimaryFrame)
			end
		end

		if p12.Secondary and p1.SecondarySlot then
			p1:LoadInventory(p1.SecondarySlot, {
				Items = { p12.Secondary },
				TiedInstance = p1.SecondarySlot.Metadata.TiedInstance
			})
			task.delay(0.5, function() --[[ Line: 1541 | Upvalues: p1 (ref), SecondaryFrame (ref) ]]
				p1:UpdateWeaponSlotDisplay(p1.SecondarySlot, SecondaryFrame)
			end)
		else
			clearSingleSlot(p1.SecondarySlot)

			if p1.SecondarySlot and SecondaryFrame then
				p1:UpdateWeaponSlotDisplay(p1.SecondarySlot, SecondaryFrame)
			end
		end

		if p12.Sidearm and p1.SidearmSlot then
			p1:LoadInventory(p1.SidearmSlot, {
				Items = { p12.Sidearm },
				TiedInstance = p1.SidearmSlot.Metadata.TiedInstance
			})
			task.delay(0.5, function() --[[ Line: 1557 | Upvalues: p1 (ref), SidearmFrame (ref) ]]
				p1:UpdateWeaponSlotDisplay(p1.SidearmSlot, SidearmFrame)
			end)
		else
			clearSingleSlot(p1.SidearmSlot)

			if p1.SidearmSlot and SidearmFrame then
				p1:UpdateWeaponSlotDisplay(p1.SidearmSlot, SidearmFrame)
			end
		end

		if p12.Melee and p1.MeleeSlot then
			p1:LoadInventory(p1.MeleeSlot, {
				Items = { p12.Melee },
				TiedInstance = p1.MeleeSlot.Metadata.TiedInstance
			})
		else
			clearSingleSlot(p1.MeleeSlot)
		end

		p1:StartWeaponAmmoWatcher()
		p1:RepositionInventorySections()

		if p12.Uniform and p1.UniformSlot then
			p1:LoadInventory(p1.UniformSlot, {
				Items = { p12.Uniform },
				TiedInstance = p1.UniformSlot.Metadata.TiedInstance
			})
		else
			clearSingleSlot(p1.UniformSlot)
		end

		if p12.BeltGear and p1.BeltGearSlot then
			p1:LoadInventory(p1.BeltGearSlot, {
				Items = { p12.BeltGear },
				TiedInstance = p1.BeltGearSlot.Metadata.TiedInstance
			})
			p1:UpdateBattleBeltGridSize(p12.BeltGear.ID)
			task.wait(0.1)

			if if p1._equipEpoch == v1 then false else true then
				return
			end

			if p1.BattleBeltInventory and p12.BattleBeltContents ~= nil then
				p1:LoadInventory(p1.BattleBeltInventory, {
					Items = p12.BattleBeltContents,
					TiedInstance = p1.BattleBeltInventory.Metadata.TiedInstance
				})
			end
		else
			p1:UpdateBattleBeltGridSize(nil)
		end

		if p12.Body and p1.BodySlot then
			p1:LoadInventory(p1.BodySlot, {
				Items = { p12.Body },
				TiedInstance = p1.BodySlot.Metadata.TiedInstance
			})
			p1:UpdateChestRigGridSize(p12.Body.ID)
			task.wait(0.1)

			if if p1._equipEpoch == v1 then false else true then
				return
			end

			if p1.ChestRigInventory and p12.ChestRigContents ~= nil then
				p1:LoadInventory(p1.ChestRigInventory, {
					Items = p12.ChestRigContents,
					TiedInstance = p1.ChestRigInventory.Metadata.TiedInstance
				})
			end
		else
			p1:UpdateChestRigGridSize(nil)
		end

		if p12.Backpack and p1.BackpackSlot then
			p1:LoadInventory(p1.BackpackSlot, {
				Items = { p12.Backpack },
				TiedInstance = p1.BackpackSlot.Metadata.TiedInstance
			})
			p1:UpdateBackpackGridSize(p12.Backpack.ID)
			task.wait(0.1)

			if p1._equipEpoch ~= v1 then
				return
			end

			if p1.MainInventory and p12.BackpackContents ~= nil then
				p1:LoadInventory(p1.MainInventory, {
					Items = p12.BackpackContents,
					TiedInstance = p1.MainInventory.Metadata.TiedInstance
				})
			end
		else
			clearSingleSlot(p1.BackpackSlot)
			p1:UpdateBackpackGridSize(nil)
		end

		if not (p12.Body and p1.BodySlot) then
			clearSingleSlot(p1.BodySlot)
		end

		if not (p12.BeltGear and p1.BeltGearSlot) then
			clearSingleSlot(p1.BeltGearSlot)
		end

		if p12.Head or p12.FaceWear or p12.EyeWear or p12.Primary or p12.Secondary or p12.Sidearm or p12.Melee or p12.Uniform or p12.Body or p12.BeltGear or p12.Backpack or not p1.LocalInventory then
			return
		end

		pcall(function() --[[ Line: 1682 | Upvalues: ReplicatedStorage (ref), p1 (ref), v1 (copy) ]]
			local v12 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer()

			if p1._equipEpoch ~= v1 then
				return
			end

			if not (v12 and v12.Pockets) then
				return
			end

			p1:LoadInventory(p1.LocalInventory, v12.Pockets)
		end)
	end)
	ReplicatedStorage.Remotes.UpdateChestRigContents.OnClientEvent:Connect(function(p12) --[[ Line: 1693 | Upvalues: p1 (copy) ]]
		task.wait(0.1)

		if not p1.ChestRigInventory then
			return
		end

		p1:LoadInventory(p1.ChestRigInventory, {
			Items = p12,
			TiedInstance = p1.ChestRigInventory.Metadata.TiedInstance
		})
	end)
	ReplicatedStorage.Remotes.UpdateBattleBeltContents.OnClientEvent:Connect(function(p12) --[[ Line: 1709 | Upvalues: p1 (copy) ]]
		task.wait(0.1)

		if p1.BattleBeltInventory then
			pcall(function() --[[ Line: 1712 | Upvalues: p1 (ref) ]]
				p1:EnsureBattleBeltGridSized()
			end)
			p1:LoadInventory(p1.BattleBeltInventory, {
				Items = p12,
				TiedInstance = p1.BattleBeltInventory.Metadata.TiedInstance
			})
		else
			warn("[UpdateBattleBeltContents] BattleBeltInventory not found")
		end
	end)
	ReplicatedStorage.Remotes.UpdateBackpackContents.OnClientEvent:Connect(function(p12) --[[ Line: 1723 | Upvalues: p1 (copy) ]]
		task.wait(0.1)

		if p1.MainInventory then
			print("[UpdateBackpackContents] Reloading backpack contents:", p12)
			p1:LoadInventory(p1.MainInventory, {
				Items = p12,
				TiedInstance = p1.MainInventory.Metadata.TiedInstance
			})
		else
			warn("[UpdateBackpackContents] MainInventory not found")
		end
	end)
	InventoryGui:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 1738 | Upvalues: InventoryGui (copy), Players (ref) ]]
		if InventoryGui.Enabled then
			return
		end

		pcall(function() --[[ Line: 1740 | Upvalues: Players (ref) ]]
			require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():Enable()
		end)
	end)
	ReplicatedStorage.Remotes.ItemDropped.OnClientEvent:Connect(function(p12, p2) --[[ Line: 1748 | Upvalues: p1 (copy), ReplicatedStorage (ref) ]]
		for i, v in ipairs({
			{
				name = "HeadGear",
				slot = p1.HeadSlot
			},
			{
				name = "FaceWear",
				slot = p1.FaceWearSlot
			},
			{
				name = "EyeWear",
				slot = p1.EyeWearSlot
			},
			{
				name = "BodyGear",
				slot = p1.BodySlot
			},
			{
				name = "BeltGear",
				slot = p1.BeltGearSlot
			},
			{
				name = "Primary",
				slot = p1.PrimarySlot
			},
			{
				name = "Secondary",
				slot = p1.SecondarySlot
			},
			{
				name = "Sidearm",
				slot = p1.SidearmSlot
			},
			{
				name = "Melee",
				slot = p1.MeleeSlot
			},
			{
				name = "Uniform",
				slot = p1.UniformSlot
			},
			{
				name = "Backpack",
				slot = p1.BackpackSlot
			},
			{
				name = "NightOptical",
				slot = p1.NightOpticalSlot
			}
		}) do
			if v.slot and (v.slot.Metadata and v.slot.Metadata.TiedInstance == p12) then
				if v.slot.Item then
					pcall(function() --[[ Line: 1768 | Upvalues: v (copy) ]]
						v.slot:RemoveItem()
					end)
				end

				if v.name == "Backpack" then
					p1:UpdateBackpackGridSize(nil)

					return
				end

				if v.name == "BodyGear" then
					p1:UpdateChestRigGridSize(nil)

					return
				end

				if v.name == "BeltGear" then
					p1:UpdateBattleBeltGridSize(nil)

					return
				end

				if v.name == "Primary" then
					p1:UpdateWeaponSlotDisplay(p1.PrimarySlot, p1.PrimaryFrame)

					return
				end

				if v.name == "Secondary" then
					p1:UpdateWeaponSlotDisplay(p1.SecondarySlot, p1.SecondaryFrame)

					return
				end

				if v.name ~= "Sidearm" then
					return
				end

				p1:UpdateWeaponSlotDisplay(p1.SidearmSlot, p1.SidearmFrame)

				return
			end
		end

		p1._refreshEpoch = (p1._refreshEpoch or 0) + 1

		local v1 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer()

		if p1._refreshEpoch ~= p1._refreshEpoch then
			return
		end

		if v1 then
			if v1.Pockets and p1.LocalInventory then
				p1:LoadInventory(p1.LocalInventory, v1.Pockets)
			end

			if v1.ChestRig and (p1.ChestRigInventory and (p1.ChestRigInventory.GuiElement and p1.ChestRigInventory.GuiElement.Visible)) then
				p1:LoadInventory(p1.ChestRigInventory, v1.ChestRig)
			end

			if v1.BattleBelt and (p1.BattleBeltInventory and (p1.BattleBeltInventory.GuiElement and p1.BattleBeltInventory.GuiElement.Visible)) then
				p1:LoadInventory(p1.BattleBeltInventory, v1.BattleBelt)
			end

			if v1.Backpack and (p1.MainInventory and (p1.MainInventory.GuiElement and p1.MainInventory.GuiElement.Visible)) then
				p1:LoadInventory(p1.MainInventory, v1.Backpack)
			end
		end

		if type(p12) ~= "string" or (p12:sub(1, 6) ~= "Stash_" or (p1.SafezoneTier ~= "Full" or p1.SafezoneViewMode ~= "stash")) then
			return
		end

		p1:LoadVicinity()
	end)
	function p1.OpenInventoryUI(p1) --[[ OpenInventoryUI | Line: 1832 | Upvalues: InventoryGui (copy), Players (ref), UserInputService (ref), ReplicatedStorage (ref) ]]
		if InventoryGui.Enabled then
			return
		end

		InventoryGui.Enabled = true
		game.Lighting.InventoryBlur.Enabled = true

		local v1 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("CustomShiftLock")
		local v2 = if v1 then v1:FindFirstChild("SmoothShiftLock") and v1.SmoothShiftLock:FindFirstChild("ToggleShiftLock") else v1

		p1._shiftLockWasEnabled = if Players.LocalPlayer:GetAttribute("ShiftLockEnabled") == true then true else false

		if p1._shiftLockWasEnabled and v2 then
			v2:Fire(false)
		end

		require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():Disable()
		p1._savedCameraMode = Players.LocalPlayer.CameraMode
		Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
		p1._mouseUnlockConn = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 1855 | Upvalues: UserInputService (ref) ]]
			if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			if UserInputService.MouseIconEnabled then
				return
			end

			UserInputService.MouseIconEnabled = true
		end)

		if not p1.CurrentStoragePart then
			p1:LoadVicinity()
		end

		pcall(function() --[[ Line: 1874 | Upvalues: ReplicatedStorage (ref) ]]
			ReplicatedStorage.Remotes:WaitForChild("RequestEquipment", 5):FireServer()
		end)
		p1._weightPolling = true
		task.spawn(function() --[[ Line: 1879 | Upvalues: p1 (copy), ReplicatedStorage (ref) ]]
			while p1._weightPolling do
				pcall(function() --[[ Line: 1881 | Upvalues: ReplicatedStorage (ref) ]]
					local v1, v2 = ReplicatedStorage.Remotes.GetWeight:InvokeServer()

					if not v1 then
						return
					end

					updateWeightDisplay(v1, v2)
				end)
				task.wait(0.5)
			end
		end)
	end
	function p1.CloseStoragePanel(p1) --[[ CloseStoragePanel | Line: 1901 ]]
		p1:StopVicinityRefresh()

		if p1.StorageInventory then
			p1:ClearGridPackInventory(p1.StorageInventory)

			if p1.StorageInventory.GuiElement then
				p1.StorageInventory.GuiElement:Destroy()
			end

			p1.StorageInventory = nil
		end

		p1.CurrentStoragePart = nil

		if not p1._expansionPanel then
			return
		end

		p1._expansionPanel.Visible = false
	end
	function p1.CloseInventoryUI(p1) --[[ CloseInventoryUI | Line: 1916 | Upvalues: InventoryGui (copy), Players (ref), UserInputService (ref), ReplicatedStorage (ref) ]]
		if not InventoryGui.Enabled then
			return
		end

		InventoryGui.Enabled = false
		game.Lighting.InventoryBlur.Enabled = false

		local v1 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("CustomShiftLock")
		local v2 = if v1 then v1:FindFirstChild("SmoothShiftLock") and v1.SmoothShiftLock:FindFirstChild("ToggleShiftLock") else v1

		if p1._shiftLockWasEnabled and v2 then
			v2:Fire(true)
		end

		p1._shiftLockWasEnabled = nil
		require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():Enable()

		if p1._mouseUnlockConn then
			p1._mouseUnlockConn:Disconnect()
			p1._mouseUnlockConn = nil
		end

		if p1._savedCameraMode then
			Players.LocalPlayer.CameraMode = p1._savedCameraMode
		end

		UserInputService.MouseIconEnabled = false
		p1._weightPolling = false
		require(ReplicatedStorage:WaitForChild("OpenableContainer")).CloseAll()
		p1:CloseStorage()
		p1:StopVicinityRefresh()
		p1:HideContextMenu()
		p1:HideDetailsPanel()
		p1:HideNotePanel()
		ReplicatedStorage.Remotes.CancelRepack:FireServer()
	end
	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 1962 | Upvalues: ReplicatedStorage (ref), InventoryGui (copy), p1 (copy) ]]
		if p2 or p12.KeyCode ~= Enum.KeyCode.Tab then
			return
		end

		local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TraderController"))

		if ok and (result and result.IsOpen) then
			return
		end

		if InventoryGui.Enabled then
			p1:CloseInventoryUI()

			return
		end

		p1:OpenInventoryUI()
	end)
	function p1._pruneTransferLink(p1) --[[ _pruneTransferLink | Line: 1979 ]]
		local TransferLink = p1.TransferLink

		if not (TransferLink and TransferLink.ConnectedItemManagers) then
			return
		end

		for i = #TransferLink.ConnectedItemManagers, 1, -1 do
			local v1 = TransferLink.ConnectedItemManagers[i]
			local v2 = if v1 then v1.GuiElement else v1

			if not v1 or v2 ~= nil and v2.Parent == nil then
				table.remove(TransferLink.ConnectedItemManagers, i)

				if v1 and v1.ConnectedTransferLinks then
					local v3 = table.find(v1.ConnectedTransferLinks, TransferLink)

					if v3 then
						table.remove(v1.ConnectedTransferLinks, v3)
					end
				end
			end
		end
	end

	local function isPlayerGridTied(p1) --[[ isPlayerGridTied | Line: 2002 | Upvalues: Players (ref) ]]
		if p1 == Players.LocalPlayer then
			return true
		end

		if type(p1) ~= "string" then
			return false
		end

		local v1 = tostring(Players.LocalPlayer.UserId)

		return if p1 == "ChestRigInternal_" .. v1 or p1 == "BattleBeltInternal_" .. v1 then true else p1 == "BackpackInternal_" .. v1
	end

	UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 2010 | Upvalues: UserInputService (ref), Players (ref), p1 (copy), ReplicatedStorage (ref) ]]
		if p12.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end

		if not (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) then
			return
		end

		local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

		if not (InventoryGui and InventoryGui.Enabled) then
			return
		end

		local TransferLink = p1.TransferLink

		if not (TransferLink and TransferLink.ConnectedItemManagers) then
			return
		end

		p1:_pruneTransferLink()

		local GuiService = game:GetService("GuiService")
		local v1 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset()

		for i, v in ipairs(TransferLink.ConnectedItemManagers) do
			local GuiElement = v.GuiElement

			if GuiElement and GuiElement.Parent then
				local v2 = v.Metadata and v.Metadata.TiedInstance

				if v2 and v.Items then
					local v3

					if v2 == Players.LocalPlayer then
						v3 = true
					elseif type(v2) == "string" then
						local v4 = tostring(Players.LocalPlayer.UserId)

						v3 = if v2 == "ChestRigInternal_" .. v4 or v2 == "BattleBeltInternal_" .. v4 then true elseif v2 == "BackpackInternal_" .. v4 then true else false
					else
						v3 = false
					end

					if not (if type(v2) == "string" then if v2:sub(1, 5) == "Sell_" then true else false else false) then
						for k, v4 in pairs(v.Items) do
							if v4 and (v4.ItemElement and (v4.ItemElement.Parent and (v4.Metadata and v4.Metadata.ItemIndex))) then
								local AbsolutePosition = v4.ItemElement.AbsolutePosition
								local AbsoluteSize = v4.ItemElement.AbsoluteSize

								if v1.X >= AbsolutePosition.X and (v1.X <= AbsolutePosition.X + AbsoluteSize.X and (v1.Y >= AbsolutePosition.Y and v1.Y <= AbsolutePosition.Y + AbsoluteSize.Y)) then
									pcall(function() --[[ Line: 2053 | Upvalues: v4 (copy) ]]
										if v4._draggingTrove and v4._draggingTrove.Clean then
											v4._draggingTrove:Clean()
										end

										if v4.ItemElement then
											game:GetService("TweenService"):Create(v4.ItemElement, TweenInfo.new(0), {
												GroupTransparency = 0
											}):Play()
											v4.ItemElement.ZIndex = math.max(1, v4.ItemElement.ZIndex - 1)
										end

										v4.IsDragging = false
										v4.IsDraggable = true
									end)

									local v6 = nil

									if v3 then
										if p1.StorageInventory and (p1.StorageInventory.Metadata and p1.StorageInventory.Metadata.TiedInstance) then
											v6 = p1.StorageInventory.Metadata.TiedInstance
										end

										if not v6 then
											return
										end

										if type(v6) == "string" and v6:sub(1, 9) == "Vicinity_" then
											local DropItem = ReplicatedStorage.Remotes:FindFirstChild("DropItem")

											if not DropItem then
												return
											end

											DropItem:FireServer(v4.Metadata.ItemIndex, v2, v4.Metadata.ID)
											p1:PlaySound("Move", v4.Metadata.ItemType or "General")

											return
										end
									end

									local QuickTakeItem = ReplicatedStorage.Remotes:FindFirstChild("QuickTakeItem")

									if not QuickTakeItem then
										return
									end

									local ok, result, result2 = pcall(function() --[[ Line: 2092 | Upvalues: QuickTakeItem (copy), v2 (copy), v4 (copy), v6 (ref) ]]
										return QuickTakeItem:InvokeServer(v2, v4.Metadata.ItemIndex, v6)
									end)

									if ok and result then
										p1:PlaySound("Move", v4.Metadata.ItemType or "General")

										if type(v2) ~= "string" or v2:sub(1, 16) ~= "OpenedContainer_" then
											return
										end

										pcall(function() --[[ Line: 2101 | Upvalues: v (copy), v4 (copy) ]]
											v:RemoveItem(v4)
										end)
									else
										if not ok or result then
											return
										end

										p1:ShowToast(if result2 == "no room" then "No space" elseif result2 then tostring(result2) or "Move failed" else "Move failed")
									end

									return
								end
							end
						end
					end
				end
			end
		end
	end)

	local CloseNestedContainer = ReplicatedStorage.Remotes:FindFirstChild("CloseNestedContainer")

	if CloseNestedContainer then
		CloseNestedContainer.OnClientEvent:Connect(function(p1) --[[ Line: 2125 | Upvalues: ReplicatedStorage (ref) ]]
			require(ReplicatedStorage:WaitForChild("OpenableContainer")).Close(p1)
		end)
	end

	ReplicatedStorage.Remotes.RefreshInventory.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 2132 | Upvalues: p1 (copy), Players (ref), ReplicatedStorage (ref) ]]
		p1._scOpId = if p12 then p12 else p1._scOpId

		if p12 and p2 then
			p1:_scCheckComposite(p12, p2, p3)
		end

		p1._refreshEpoch = (p1._refreshEpoch or 0) + 1
		p1:_pruneTransferLink()

		local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

		if InventoryGui and not p1._autoFillPreview then
			for i, v in ipairs(InventoryGui:GetDescendants()) do
				if v.Name == "BarterGhostOverlay" then
					pcall(function() --[[ Line: 2164 | Upvalues: v (copy) ]]
						v:Destroy()
					end)
				end
			end
		end

		local v3 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer()

		if p1._refreshEpoch ~= p1._refreshEpoch then
			return
		end

		if not v3 then
			return
		end

		if v3.Pockets and p1.LocalInventory then
			p1:LoadInventory(p1.LocalInventory, v3.Pockets)
		end

		if v3.ChestRig and p1.ChestRigInventory then
			p1:LoadInventory(p1.ChestRigInventory, v3.ChestRig)
		end

		if v3.BattleBelt and p1.BattleBeltInventory then
			p1:LoadInventory(p1.BattleBeltInventory, v3.BattleBelt)
		end

		if v3.Backpack and p1.MainInventory then
			p1:LoadInventory(p1.MainInventory, v3.Backpack)
		end

		task.spawn(function() --[[ Line: 2192 | Upvalues: ReplicatedStorage (ref) ]]
			pcall(function() --[[ Line: 2193 | Upvalues: ReplicatedStorage (ref) ]]
				local v1, v2 = ReplicatedStorage.Remotes.GetWeight:InvokeServer()

				if not v1 then
					return
				end

				updateWeightDisplay(v1, v2)
			end)
		end)
		p1:_refreshExpansionPanel()
	end)

	local StashResized = ReplicatedStorage.Remotes:FindFirstChild("StashResized")

	if StashResized then
		StashResized.OnClientEvent:Connect(function() --[[ Line: 2212 | Upvalues: p1 (copy) ]]
			if p1.SafezoneTier == "Full" and p1.SafezoneViewMode == "stash" then
				p1:LoadVicinity()
			end

			p1:_refreshExpansionPanel()
		end)
	end

	local function updateRadDisplay() --[[ updateRadDisplay | Line: 2221 | Upvalues: Players (ref), ReplicatedStorage (ref) ]]
		local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

		if not InventoryGui then
			return
		end

		local CharacterFrame = InventoryGui.MainFrame:FindFirstChild("CharacterFrame")

		if not CharacterFrame then
			return
		end

		local RadDisplay = CharacterFrame:FindFirstChild("RadDisplay")

		if not RadDisplay then
			return
		end

		local RadLabel = RadDisplay:FindFirstChild("RadLabel")

		if not RadLabel then
			return
		end

		local GetRadProtection = ReplicatedStorage.Remotes:FindFirstChild("GetRadProtection")

		if not GetRadProtection then
			return
		end

		local ok, result = pcall(function() --[[ Line: 2234 | Upvalues: GetRadProtection (copy) ]]
			return GetRadProtection:InvokeServer()
		end)

		if not ok or type(result) ~= "number" then
			return
		end

		local v1 = math.floor(result * 100)

		RadLabel.Text = "Rad Protection: " .. v1 .. "%"

		if v1 >= 60 then
			RadLabel.TextColor3 = Color3.fromRGB(100, 255, 100)

			return
		end

		if v1 >= 30 then
			RadLabel.TextColor3 = Color3.fromRGB(200, 255, 150)
		else
			RadLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		end
	end

	local function updateArmorDisplay() --[[ updateArmorDisplay | Line: 2250 | Upvalues: Players (ref), ItemDatabase (ref), ReplicatedStorage (ref), p1 (copy) ]]
		local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

		if not InventoryGui then
			return
		end

		local CharacterFrame = InventoryGui.MainFrame:FindFirstChild("CharacterFrame")

		if not CharacterFrame then
			return
		end

		local ArmorProtection = CharacterFrame:FindFirstChild("ArmorProtection")

		if not ArmorProtection then
			return
		end

		local RadLabel = ArmorProtection:FindFirstChild("RadLabel")

		if not RadLabel then
			return
		end

		local function slotDur(p1, p2) --[[ slotDur | Line: 2260 | Upvalues: ItemDatabase (ref), ReplicatedStorage (ref) ]]
			if not (p1 and (p1.Item and p1.Item.Metadata)) then
				return 0, 0
			end

			local v1 = ItemDatabase.GetItemData(p1.Item.Metadata.ID)

			if not (v1 and v1.ArmorMaxDurability) then
				return 0, 0
			end

			local ArmorMaxDurability = v1.ArmorMaxDurability
			local GetArmorDurability = ReplicatedStorage.Remotes:FindFirstChild("GetArmorDurability")

			if GetArmorDurability then
				local ok, result = pcall(function() --[[ Line: 2267 | Upvalues: GetArmorDurability (copy), p2 (copy) ]]
					return GetArmorDurability:InvokeServer(p2)
				end)

				if ok and result ~= nil then
					ArmorMaxDurability = result
				end
			end

			return ArmorMaxDurability, v1.ArmorMaxDurability
		end

		local v1, v2 = slotDur(p1.BodySlot, "Body")
		local v3, v4 = slotDur(p1.HeadSlot, "Head")
		local v5 = v1 + v3
		local v6 = v2 + v4

		RadLabel.Text = string.format("Durability: %d / %d", math.floor(v5), v6)

		local v7 = if v6 > 0 then v5 / v6 or 0 else 0

		if v7 > 0.6 then
			RadLabel.TextColor3 = Color3.fromRGB(100, 255, 100)

			return
		end

		if v7 > 0.3 then
			RadLabel.TextColor3 = Color3.fromRGB(255, 220, 80)
		else
			RadLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		end
	end

	local function updateWeightDisplay(p1, p2) --[[ updateWeightDisplay | Line: 2289 | Upvalues: Players (ref), updateRadDisplay (copy), updateArmorDisplay (copy) ]]
		local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

		if not InventoryGui then
			return
		end

		local InventoryFrame = InventoryGui.MainFrame:FindFirstChild("InventoryFrame")

		if not InventoryFrame then
			return
		end

		local WeightDisplay = InventoryFrame:FindFirstChild("WeightDisplay")

		if not WeightDisplay then
			return
		end

		updateRadDisplay()
		updateArmorDisplay()

		local WeightLabel = WeightDisplay:FindFirstChild("WeightLabel")

		if WeightLabel then
			WeightLabel.Text = string.format("%.1f / %.1f kg", p1, p2)

			if p2 * 1.2 <= p1 then
				WeightLabel.TextColor3 = Color3.fromRGB(255, 40, 40)
			elseif p2 <= p1 then
				WeightLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
			elseif p2 * 0.8 <= p1 then
				WeightLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
			else
				WeightLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			end
		end

		local WeightIcon = WeightDisplay:FindFirstChild("WeightIcon")

		if not WeightIcon then
			return
		end

		WeightIcon.ImageColor3 = WeightLabel.TextColor3
	end

	ReplicatedStorage.Remotes.WeightSync.OnClientEvent:Connect(updateWeightDisplay)
	function p1._refreshWeight() --[[ refreshWeight | Line: 2323 | Upvalues: ReplicatedStorage (ref), updateWeightDisplay (copy) ]]
		task.spawn(function() --[[ Line: 2324 | Upvalues: ReplicatedStorage (ref), updateWeightDisplay (ref) ]]
			local GetWeight = ReplicatedStorage.Remotes:FindFirstChild("GetWeight")

			if not GetWeight then
				return
			end

			local ok, result, result2 = pcall(GetWeight.InvokeServer, GetWeight)

			if not (ok and result) then
				return
			end

			updateWeightDisplay(result, result2)
		end)
	end
	ReplicatedStorage.Remotes.RepackProgress.OnClientEvent:Connect(function(p12, p2, p3, p4, p5, p6, p7) --[[ Line: 2336 | Upvalues: InventorySounds (ref), Players (ref), ItemDatabase (ref), p1 (copy) ]]
		local MagazineLoading = InventorySounds:FindFirstChild("MagazineLoading")

		if MagazineLoading then
			local v1 = MagazineLoading:GetChildren()

			if #v1 > 0 then
				local v2 = v1[math.random(#v1)]

				if v2:IsA("Sound") then
					local v3 = v2:Clone()

					v3.PlaybackSpeed = 0.9 + math.random() * 0.2
					v3.Parent = Players.LocalPlayer.PlayerGui
					v3:Play()
					v3.Ended:Connect(function() --[[ Line: 2348 | Upvalues: v3 (copy) ]]
						v3:Destroy()
					end)
				end
			end
		end

		local function updateItemLabel(p1, p2, p3) --[[ updateItemLabel | Line: 2354 | Upvalues: ItemDatabase (ref) ]]
			if not (p1 and p1.Items) then
				return
			end

			for k, v in pairs(p1.Items) do
				if v and (v.Metadata and (v.Metadata.ItemIndex == p2 and v.ItemElement)) then
					local RoundCount = v.ItemElement:FindFirstChild("RoundCount")

					if RoundCount then
						RoundCount.Text = tostring(p3)
						RoundCount.TextColor3 = p3 > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 80, 80)
					end

					v.Metadata.CurrentRounds = p3

					local v2 = ItemDatabase.GetItemData(v.Metadata.ID)

					if v2 then
						v.ItemElement.BackgroundColor3 = p3 > 0 and v2.BackgroundColor or Color3.fromRGB(120, 30, 30)
					end
				end
			end
		end

		local list = {}
		local t5 = {
			grid = p1.StorageInventory
		}

		t5.tied = p1.StorageInventory and p1.StorageInventory.Metadata and p1.StorageInventory.Metadata.TiedInstance
		list[1] = {
			grid = p1.LocalInventory,
			tied = Players.LocalPlayer
		}
		list[2] = {
			grid = p1.ChestRigInventory,
			tied = "ChestRigInternal_" .. Players.LocalPlayer.UserId
		}
		list[3] = {
			grid = p1.BattleBeltInventory,
			tied = "BattleBeltInternal_" .. Players.LocalPlayer.UserId
		}
		list[4] = {
			grid = p1.MainInventory,
			tied = "BackpackInternal_" .. Players.LocalPlayer.UserId
		}
		list[5] = t5

		for i, v in ipairs(list) do
			if v.grid and v.tied then
				if v.tied == p5 then
					updateItemLabel(v.grid, p4, p3)
				end

				if v.tied == p7 then
					updateItemLabel(v.grid, p6, p12)
				end
			end
		end
	end)
	ReplicatedStorage.Remotes.OpenBodyLootUI.OnClientEvent:Connect(function(p12) --[[ Line: 2394 | Upvalues: p1 (copy) ]]
		p1:OpenBodyLoot(p12)
	end)
	ReplicatedStorage.Remotes.BodyRemoved.OnClientEvent:Connect(function(p12) --[[ Line: 2400 | Upvalues: ReplicatedStorage (ref), p1 (copy) ]]
		require(ReplicatedStorage:WaitForChild("OpenableContainer")).Close(p12)

		if p1.CurrentBodyTied ~= p12 then
			return
		end

		p1.CurrentBodyTied = nil
		p1:CloseStorage()
	end)
	ReplicatedStorage.Remotes.TraderError.OnClientEvent:Connect(function(p12) --[[ Line: 2412 | Upvalues: p1 (copy) ]]
		p1:ShowToast((tostring(p12)))
	end)
	ReplicatedStorage.Remotes.EquipSlotChanged.OnClientEvent:Connect(function(p12, p2) --[[ Line: 2418 | Upvalues: p1 (copy) ]]
		local v1 = ({
			Head = p1.HeadSlot,
			FaceWear = p1.FaceWearSlot,
			EyeWear = p1.EyeWearSlot,
			BeltGear = p1.BeltGearSlot,
			Body = p1.BodySlot,
			Primary = p1.PrimarySlot,
			Secondary = p1.SecondarySlot,
			Sidearm = p1.SidearmSlot,
			Melee = p1.MeleeSlot,
			Uniform = p1.UniformSlot,
			Backpack = p1.BackpackSlot,
			NightOptical = p1.NightOpticalSlot
		})[p12]

		if not v1 then
			return
		end

		if p2 then
			local t = {
				Items = { p2 }
			}

			t.TiedInstance = v1.Metadata and v1.Metadata.TiedInstance
			p1:LoadInventory(v1, t)
		elseif v1.Item then
			pcall(function() --[[ Line: 2436 | Upvalues: v1 (copy) ]]
				v1:RemoveItem()
			end)
			pcall(function() --[[ Line: 2437 | Upvalues: v1 (copy) ]]
				v1.Item:Destroy()
			end)
		end

		if p12 == "Body" then
			p1:UpdateChestRigGridSize(if p2 then p2.ID else p2)
		elseif p12 == "Backpack" then
			p1:UpdateBackpackGridSize(if p2 then p2.ID else p2)
		else
			if p12 ~= "BeltGear" then
				return
			end

			p1:UpdateBattleBeltGridSize(if p2 then p2.ID else p2)
		end
	end)
	UserInputService.MouseIconEnabled = false
	Players.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 2457 | Upvalues: UserInputService (ref) ]]
		UserInputService.MouseIconEnabled = false
	end)

	if not p1._receivedEquipment then
		ReplicatedStorage.Remotes:WaitForChild("RequestEquipment"):FireServer()
	end

	p1.SafezoneTier = nil
	p1.SafezoneViewMode = "stash"
	p1:_buildSafezoneTabs()
	p1:_buildExpandButton()

	local function applySafezoneTier(p12) --[[ applySafezoneTier | Line: 2481 | Upvalues: p1 (copy), Players (ref) ]]
		local v1 = if p1.SafezoneTier == "Full" then true else false

		p1.SafezoneTier = (p12 == "Full" or p12 == "TraderOnly") and p12 or nil

		if (if p1.SafezoneTier == "Full" then true else false) and not v1 then
			p1.SafezoneViewMode = "stash"
		end

		p1:_refreshSafezoneTabs()
		p1:_refreshExpandButton()

		local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

		if not (InventoryGui and InventoryGui.Enabled) then
			return
		end

		p1:LoadVicinity()
	end

	local SafezoneChanged = ReplicatedStorage.Remotes:WaitForChild("SafezoneChanged", 5)

	if SafezoneChanged then
		SafezoneChanged.OnClientEvent:Connect(applySafezoneTier)
	end

	task.spawn(function() --[[ Line: 2510 | Upvalues: ReplicatedStorage (ref), p1 (copy), applySafezoneTier (copy) ]]
		local v1 = ReplicatedStorage.Remotes:FindFirstChild("GetSafezoneTier") or ReplicatedStorage.Remotes:WaitForChild("GetSafezoneTier", 10)

		if not v1 then
			warn("[InventoryController] GetSafezoneTier missing; initial safezone sync skipped")

			return
		end

		local ok, result = pcall(function() --[[ Line: 2517 | Upvalues: v1 (copy) ]]
			return v1:InvokeServer()
		end)

		if not ok then
			warn("[InventoryController] GetSafezoneTier failed: " .. tostring(result))

			return
		end

		if p1.SafezoneTier ~= nil then
			return
		end

		applySafezoneTier(result)
	end)
end
function t._buildSafezoneTabs(p1) --[[ _buildSafezoneTabs | Line: 2534 | Upvalues: Players (copy) ]]
	local ContainerFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("InventoryGui").MainFrame:WaitForChild("ContainerFrame")
	local Title = ContainerFrame:WaitForChild("Title")

	if ContainerFrame:FindFirstChild("SafezoneTabs") then
		p1.SafezoneTabs = ContainerFrame.SafezoneTabs
	else
		local SafezoneTabs = Instance.new("Frame")

		SafezoneTabs.Name = "SafezoneTabs"
		SafezoneTabs.BackgroundTransparency = 1
		SafezoneTabs.BorderSizePixel = 0
		SafezoneTabs.AnchorPoint = Title.AnchorPoint
		SafezoneTabs.Size = UDim2.fromScale(Title.Size.X.Scale * 1.5, Title.Size.Y.Scale)
		SafezoneTabs.Position = UDim2.new(Title.Position.X.Scale + Title.Size.X.Scale + 0.012, 0, Title.Position.Y.Scale, 0)
		SafezoneTabs.Visible = false
		SafezoneTabs.Parent = ContainerFrame

		local UIListLayout = Instance.new("UIListLayout")

		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.Padding = UDim.new(0, 6)
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Parent = SafezoneTabs

		local function makeTab(p1, p2, p3) --[[ makeTab | Line: 2569 | Upvalues: SafezoneTabs (copy), Title (copy) ]]
			local TextButton = Instance.new("TextButton")

			TextButton.Name = p1
			TextButton.AutoButtonColor = false
			TextButton.LayoutOrder = p3
			TextButton.Size = UDim2.fromScale(0.46, 1)
			TextButton.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
			TextButton.BackgroundTransparency = 0
			TextButton.BorderSizePixel = 0
			TextButton.Text = ""
			TextButton.Parent = SafezoneTabs

			local UIGradient = Title:FindFirstChildOfClass("UIGradient")

			if UIGradient then
				UIGradient:Clone().Parent = TextButton
			end

			local UIStroke = Title:FindFirstChildOfClass("UIStroke")

			if UIStroke then
				UIStroke:Clone().Parent = TextButton
			end

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "TextLabel"
			TextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TextLabel.Position = UDim2.fromScale(0.04, 0.5)
			TextLabel.Size = UDim2.fromScale(0.96, 0.8)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = p2
			TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
			TextLabel.TextSize = 14
			TextLabel.TextColor3 = Color3.fromRGB(197, 197, 197)
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Parent = TextButton

			return TextButton
		end

		local v1 = makeTab("StashTab", "STASH", 1)
		local v2 = makeTab("VicinityTab", "VICINITY", 2)

		v1.MouseButton1Click:Connect(function() --[[ Line: 2606 | Upvalues: p1 (copy) ]]
			if p1.SafezoneTier ~= "Full" then
				return
			end

			if p1.SafezoneViewMode ~= "stash" then
				p1.SafezoneViewMode = "stash"
				p1:_refreshSafezoneTabs()
				p1:_refreshExpandButton()
				p1:LoadVicinity()
			end
		end)
		v2.MouseButton1Click:Connect(function() --[[ Line: 2614 | Upvalues: p1 (copy) ]]
			if p1.SafezoneTier ~= "Full" then
				return
			end

			if p1.SafezoneViewMode ~= "vicinity" then
				p1.SafezoneViewMode = "vicinity"
				p1:_refreshSafezoneTabs()
				p1:_refreshExpandButton()
				p1:LoadVicinity()
			end
		end)
		p1.SafezoneTabs = SafezoneTabs
		p1._stashTab = v1
		p1._vicinityTab = v2
	end

	p1:_refreshSafezoneTabs()
end
function t._refreshSafezoneTabs(p1) --[[ _refreshSafezoneTabs | Line: 2632 ]]
	local SafezoneTabs = p1.SafezoneTabs

	if not SafezoneTabs then
		return
	end

	local isSafezoneTier = p1.SafezoneTier == "Full"

	SafezoneTabs.Visible = isSafezoneTier

	if not isSafezoneTier then
		return
	end

	local v1 = p1.SafezoneViewMode or "stash"

	local function applyState(p1, p2) --[[ applyState | Line: 2639 ]]
		p1.BackgroundTransparency = if p2 then 0 else 0.45

		local TextLabel = p1:FindFirstChild("TextLabel")

		if not TextLabel then
			return
		end

		TextLabel.TextTransparency = if p2 then 0 else 0.3
	end

	if p1._stashTab then
		local _stashTab = p1._stashTab
		local v2 = v1 == "stash"

		_stashTab.BackgroundTransparency = if v2 then 0 else 0.45

		local TextLabel = _stashTab:FindFirstChild("TextLabel")

		if TextLabel then
			TextLabel.TextTransparency = if v2 then 0 else 0.3
		end
	end

	if not p1._vicinityTab then
		return
	end

	local _vicinityTab = p1._vicinityTab
	local v5 = v1 == "vicinity"

	_vicinityTab.BackgroundTransparency = if v5 then 0 else 0.45

	local TextLabel = _vicinityTab:FindFirstChild("TextLabel")

	if not TextLabel then
		return
	end

	TextLabel.TextTransparency = if v5 then 0 else 0.3
end
function t._buildExpandButton(p1) --[[ _buildExpandButton | Line: 2667 ]]
	p1:_buildStashExpansionPanel()
end
function t._buildStashExpansionPanel(p1) --[[ _buildStashExpansionPanel | Line: 2672 | Upvalues: Players (copy), ReplicatedStorage (copy) ]]
	local ContainerFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("InventoryGui").MainFrame:WaitForChild("ContainerFrame")

	if ContainerFrame:FindFirstChild("StashExpansionPanel") then
		p1._expansionPanel = ContainerFrame.StashExpansionPanel
	else
		require(ReplicatedStorage:WaitForChild("ItemDatabase"))

		local StashExpansionPanel = Instance.new("Frame")

		StashExpansionPanel.Name = "StashExpansionPanel"
		StashExpansionPanel.AnchorPoint = Vector2.new(0.5, 1)
		StashExpansionPanel.Position = UDim2.new(0.5, 0, 1, -10)
		StashExpansionPanel.Size = UDim2.new(0.93, 0, 0, 46)
		StashExpansionPanel.BackgroundColor3 = Color3.fromRGB(17, 18, 16)
		StashExpansionPanel.BorderSizePixel = 0
		StashExpansionPanel.Visible = false
		StashExpansionPanel.ZIndex = 5
		StashExpansionPanel.Parent = ContainerFrame

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = Color3.fromRGB(48, 48, 48)
		UIStroke.Thickness = 1
		UIStroke.Parent = StashExpansionPanel

		local UIPadding = Instance.new("UIPadding")

		UIPadding.PaddingTop = UDim.new(0, 10)
		UIPadding.PaddingBottom = UDim.new(0, 10)
		UIPadding.PaddingLeft = UDim.new(0, 16)
		UIPadding.PaddingRight = UDim.new(0, 16)
		UIPadding.Parent = StashExpansionPanel

		local TitleRow = Instance.new("Frame")

		TitleRow.Name = "TitleRow"
		TitleRow.BackgroundTransparency = 1
		TitleRow.Size = UDim2.new(1, 0, 0, 26)
		TitleRow.ZIndex = 6
		TitleRow.Parent = StashExpansionPanel

		local ImageLabel = Instance.new("ImageLabel")

		ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
		ImageLabel.Position = UDim2.new(0, 0, 0.5, 0)
		ImageLabel.Size = UDim2.fromOffset(24, 24)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Image = "rbxassetid://0"
		ImageLabel.ImageColor3 = Color3.fromRGB(170, 170, 170)
		ImageLabel.ZIndex = 6
		ImageLabel.Parent = TitleRow

		local TextLabel = Instance.new("TextLabel")

		TextLabel.AnchorPoint = Vector2.new(0, 0.5)
		TextLabel.Position = UDim2.new(0, 32, 0.5, 0)
		TextLabel.Size = UDim2.new(0.5, 0, 1, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = "STASH EXPANSION"
		TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
		TextLabel.TextSize = 18
		TextLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.ZIndex = 6
		TextLabel.Parent = TitleRow

		local SizeIndicator = Instance.new("TextLabel")

		SizeIndicator.Name = "SizeIndicator"
		SizeIndicator.AnchorPoint = Vector2.new(1, 0.5)
		SizeIndicator.Position = UDim2.new(1, -32, 0.5, 0)
		SizeIndicator.Size = UDim2.new(0.55, -32, 1, 0)
		SizeIndicator.BackgroundTransparency = 1
		SizeIndicator.Text = ""
		SizeIndicator.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
		SizeIndicator.TextSize = 14
		SizeIndicator.TextColor3 = Color3.fromRGB(170, 180, 170)
		SizeIndicator.TextXAlignment = Enum.TextXAlignment.Right
		SizeIndicator.RichText = true
		SizeIndicator.ZIndex = 6
		SizeIndicator.Parent = TitleRow
		p1._expansionSizeIndicator = SizeIndicator

		local CollapseButton = Instance.new("TextButton")

		CollapseButton.Name = "CollapseButton"
		CollapseButton.AnchorPoint = Vector2.new(1, 0.5)
		CollapseButton.Position = UDim2.new(1, 0, 0.5, 0)
		CollapseButton.Size = UDim2.fromOffset(28, 22)
		CollapseButton.BackgroundColor3 = Color3.fromRGB(40, 42, 38)
		CollapseButton.BorderSizePixel = 0
		CollapseButton.AutoButtonColor = true
		CollapseButton.Text = "+"
		CollapseButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
		CollapseButton.TextSize = 14
		CollapseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
		CollapseButton.ZIndex = 7
		CollapseButton.Parent = TitleRow

		local UIStroke2 = Instance.new("UIStroke")

		UIStroke2.Color = Color3.fromRGB(80, 80, 80)
		UIStroke2.Thickness = 1
		UIStroke2.Parent = CollapseButton
		CollapseButton.MouseButton1Click:Connect(function() --[[ Line: 2777 | Upvalues: p1 (copy) ]]
			p1:_toggleExpansionPopout()
		end)
		p1._expansionCollapseBtn = CollapseButton
		p1._expansionTitleRow = TitleRow

		local ContentScroll = Instance.new("ScrollingFrame")

		ContentScroll.Name = "ContentScroll"
		ContentScroll.Position = UDim2.new(0, 0, 0, 26)
		ContentScroll.Size = UDim2.new(1, 0, 1, -26)
		ContentScroll.BackgroundTransparency = 1
		ContentScroll.BorderSizePixel = 0
		ContentScroll.ScrollBarThickness = 4
		ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(140, 140, 140)
		ContentScroll.ScrollingDirection = Enum.ScrollingDirection.Y
		ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 290)
		ContentScroll.ClipsDescendants = true
		ContentScroll.Visible = false
		ContentScroll.ZIndex = 5
		ContentScroll.Parent = StashExpansionPanel
		p1._expansionContentScroll = ContentScroll

		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Position = UDim2.new(0, 0, 0, 8)
		TextLabel2.Size = UDim2.new(1, 0, 0, 36)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.Text = "Increase your stash capacity by completing a barter upgrade.\nBarter upgrades reset on wipes. Permanent account upgrades persist forever."
		TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
		TextLabel2.TextSize = 13
		TextLabel2.TextColor3 = Color3.fromRGB(150, 150, 150)
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel2.TextWrapped = true
		TextLabel2.ZIndex = 6
		TextLabel2.Parent = ContentScroll

		local TextLabel3 = Instance.new("TextLabel")

		TextLabel3.Position = UDim2.new(0, 0, 0, 50)
		TextLabel3.Size = UDim2.new(1, 0, 0, 16)
		TextLabel3.BackgroundTransparency = 1
		TextLabel3.Text = "REQUIRES (BARTER)"
		TextLabel3.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
		TextLabel3.TextSize = 12
		TextLabel3.TextColor3 = Color3.fromRGB(130, 130, 130)
		TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel3.ZIndex = 6
		TextLabel3.Parent = ContentScroll

		local MaterialsRow = Instance.new("Frame")

		MaterialsRow.Name = "MaterialsRow"
		MaterialsRow.BackgroundTransparency = 1
		MaterialsRow.Position = UDim2.new(0, 0, 0, 70)
		MaterialsRow.Size = UDim2.new(1, 0, 0, 90)
		MaterialsRow.ZIndex = 6
		MaterialsRow.Parent = ContentScroll

		local UIListLayout = Instance.new("UIListLayout")

		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.Padding = UDim.new(0, 8)
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Parent = MaterialsRow

		local UIPadding2 = Instance.new("UIPadding")

		UIPadding2.PaddingLeft = UDim.new(0, 1)
		UIPadding2.PaddingRight = UDim.new(0, 1)
		UIPadding2.Parent = MaterialsRow
		p1._expansionMatsRow = MaterialsRow

		local AutoFillButton = Instance.new("TextButton")

		AutoFillButton.Name = "AutoFillButton"
		AutoFillButton.AnchorPoint = Vector2.new(1, 0)
		AutoFillButton.Position = UDim2.new(1, 0, 0, 44)
		AutoFillButton.Size = UDim2.fromOffset(140, 24)
		AutoFillButton.BackgroundColor3 = Color3.fromRGB(40, 50, 40)
		AutoFillButton.BorderSizePixel = 0
		AutoFillButton.AutoButtonColor = true
		AutoFillButton.Text = "AUTO-FILL"
		AutoFillButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
		AutoFillButton.TextSize = 14
		AutoFillButton.TextColor3 = Color3.fromRGB(190, 220, 190)
		AutoFillButton.ZIndex = 7
		AutoFillButton.Parent = ContentScroll

		local UIStroke3 = Instance.new("UIStroke")

		UIStroke3.Color = Color3.fromRGB(80, 110, 80)
		UIStroke3.Thickness = 1
		UIStroke3.Parent = AutoFillButton
		AutoFillButton.MouseButton1Click:Connect(function() --[[ Line: 2879 | Upvalues: p1 (copy) ]]
			p1:_onAutoFillBarterClicked()
		end)
		p1._autoFillBtn = AutoFillButton

		local PreviewActionRow = Instance.new("Frame")

		PreviewActionRow.Name = "PreviewActionRow"
		PreviewActionRow.Position = UDim2.new(0, 0, 0, 170)
		PreviewActionRow.Size = UDim2.new(1, 0, 0, 42)
		PreviewActionRow.BackgroundTransparency = 1
		PreviewActionRow.ZIndex = 7
		PreviewActionRow.Visible = false
		PreviewActionRow.Parent = ContentScroll

		local CancelPreviewButton = Instance.new("TextButton")

		CancelPreviewButton.Name = "CancelPreviewButton"
		CancelPreviewButton.AnchorPoint = Vector2.new(0, 0)
		CancelPreviewButton.Position = UDim2.new(0, 0, 0, 0)
		CancelPreviewButton.Size = UDim2.new(0.48, 0, 1, 0)
		CancelPreviewButton.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
		CancelPreviewButton.BorderSizePixel = 0
		CancelPreviewButton.AutoButtonColor = true
		CancelPreviewButton.Text = "CANCEL"
		CancelPreviewButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
		CancelPreviewButton.TextSize = 16
		CancelPreviewButton.TextColor3 = Color3.fromRGB(220, 180, 180)
		CancelPreviewButton.ZIndex = 8
		CancelPreviewButton.Parent = PreviewActionRow

		local UIStroke4 = Instance.new("UIStroke")

		UIStroke4.Color = Color3.fromRGB(150, 70, 70)
		UIStroke4.Thickness = 1
		UIStroke4.Parent = CancelPreviewButton
		CancelPreviewButton.MouseButton1Click:Connect(function() --[[ Line: 2914 | Upvalues: p1 (copy) ]]
			p1:_exitAutoFillPreview(false)
		end)

		local ConfirmPreviewButton = Instance.new("TextButton")

		ConfirmPreviewButton.Name = "ConfirmPreviewButton"
		ConfirmPreviewButton.AnchorPoint = Vector2.new(1, 0)
		ConfirmPreviewButton.Position = UDim2.new(1, 0, 0, 0)
		ConfirmPreviewButton.Size = UDim2.new(0.48, 0, 1, 0)
		ConfirmPreviewButton.BackgroundColor3 = Color3.fromRGB(46, 110, 46)
		ConfirmPreviewButton.BorderSizePixel = 0
		ConfirmPreviewButton.AutoButtonColor = true
		ConfirmPreviewButton.Text = "CONFIRM"
		ConfirmPreviewButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
		ConfirmPreviewButton.TextSize = 16
		ConfirmPreviewButton.TextColor3 = Color3.fromRGB(220, 255, 220)
		ConfirmPreviewButton.ZIndex = 8
		ConfirmPreviewButton.Parent = PreviewActionRow

		local UIStroke5 = Instance.new("UIStroke")

		UIStroke5.Color = Color3.fromRGB(140, 240, 140)
		UIStroke5.Thickness = 2
		UIStroke5.Parent = ConfirmPreviewButton
		ConfirmPreviewButton.MouseButton1Click:Connect(function() --[[ Line: 2936 | Upvalues: p1 (copy) ]]
			p1:_exitAutoFillPreview(true)
		end)
		p1._previewActionRow = PreviewActionRow
		p1._cancelPreviewBtn = CancelPreviewButton
		p1._confirmPreviewBtn = ConfirmPreviewButton

		local BarterButton = Instance.new("TextButton")

		BarterButton.Name = "BarterButton"
		BarterButton.Position = UDim2.new(0, 0, 0, 170)
		BarterButton.Size = UDim2.new(1, 0, 0, 42)
		BarterButton.BackgroundColor3 = Color3.fromRGB(32, 33, 30)
		BarterButton.BorderSizePixel = 0
		BarterButton.AutoButtonColor = false
		BarterButton.Text = ""
		BarterButton.ZIndex = 6
		BarterButton.Parent = ContentScroll

		local UIStroke6 = Instance.new("UIStroke")

		UIStroke6.Color = Color3.fromRGB(48, 48, 48)
		UIStroke6.Thickness = 1
		UIStroke6.Parent = BarterButton

		local LockIcon = Instance.new("TextLabel")

		LockIcon.Name = "LockIcon"
		LockIcon.AnchorPoint = Vector2.new(0, 0.5)
		LockIcon.Position = UDim2.new(0, 16, 0.5, 0)
		LockIcon.Size = UDim2.fromOffset(22, 22)
		LockIcon.BackgroundTransparency = 1
		LockIcon.Text = utf8.char(128274)
		LockIcon.TextSize = 16
		LockIcon.TextColor3 = Color3.fromRGB(140, 140, 140)
		LockIcon.ZIndex = 7
		LockIcon.Parent = BarterButton

		local Main = Instance.new("TextLabel")

		Main.Name = "Main"
		Main.AnchorPoint = Vector2.new(0.5, 0)
		Main.Position = UDim2.new(0.5, 0, 0, 5)
		Main.Size = UDim2.new(0.9, 0, 0, 21)
		Main.BackgroundTransparency = 1
		Main.Text = "EXPAND WITH BARTER"
		Main.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
		Main.TextSize = 17
		Main.TextColor3 = Color3.fromRGB(180, 180, 180)
		Main.ZIndex = 7
		Main.Parent = BarterButton

		local Sub = Instance.new("TextLabel")

		Sub.Name = "Sub"
		Sub.AnchorPoint = Vector2.new(0.5, 1)
		Sub.Position = UDim2.new(0.5, 0, 1, -4)
		Sub.Size = UDim2.new(0.9, 0, 0, 14)
		Sub.BackgroundTransparency = 1
		Sub.Text = "Complete all requirements to unlock"
		Sub.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
		Sub.TextSize = 12
		Sub.TextColor3 = Color3.fromRGB(120, 120, 120)
		Sub.ZIndex = 7
		Sub.Parent = BarterButton
		BarterButton.MouseButton1Click:Connect(function() --[[ Line: 3000 | Upvalues: p1 (copy) ]]
			if p1._barterButtonReady then
				p1:_onBarterExpandClicked()
			end
		end)
		p1._barterButton = BarterButton

		local Frame = Instance.new("Frame")

		Frame.Position = UDim2.new(0, 0, 0, 220)
		Frame.Size = UDim2.new(1, 0, 0, 16)
		Frame.BackgroundTransparency = 1
		Frame.ZIndex = 6
		Frame.Parent = ContentScroll

		local TextLabel4 = Instance.new("TextLabel")

		TextLabel4.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel4.Position = UDim2.fromScale(0.5, 0.5)
		TextLabel4.Size = UDim2.fromOffset(50, 16)
		TextLabel4.BackgroundTransparency = 1
		TextLabel4.Text = "OR"
		TextLabel4.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
		TextLabel4.TextSize = 13
		TextLabel4.TextColor3 = Color3.fromRGB(140, 140, 140)
		TextLabel4.ZIndex = 7
		TextLabel4.Parent = Frame

		local PremiumButton = Instance.new("TextButton")

		PremiumButton.Name = "PremiumButton"
		PremiumButton.Position = UDim2.new(0, 0, 0, 240)
		PremiumButton.Size = UDim2.new(1, 0, 0, 46)
		PremiumButton.BackgroundColor3 = Color3.fromRGB(45, 38, 18)
		PremiumButton.BorderSizePixel = 0
		PremiumButton.AutoButtonColor = true
		PremiumButton.Text = ""
		PremiumButton.ZIndex = 6
		PremiumButton.Parent = ContentScroll

		local UIStroke7 = Instance.new("UIStroke")

		UIStroke7.Color = Color3.fromRGB(170, 130, 60)
		UIStroke7.Thickness = 1.5
		UIStroke7.Parent = PremiumButton

		local ImageLabel2 = Instance.new("ImageLabel")

		ImageLabel2.AnchorPoint = Vector2.new(0, 0.5)
		ImageLabel2.Position = UDim2.new(0, 14, 0.5, 0)
		ImageLabel2.Size = UDim2.fromOffset(26, 26)
		ImageLabel2.BackgroundTransparency = 1
		ImageLabel2.Image = "rbxasset://textures/ui/common/robux.png"
		ImageLabel2.ImageColor3 = Color3.fromRGB(255, 204, 80)
		ImageLabel2.ZIndex = 7
		ImageLabel2.Parent = PremiumButton

		local TextLabel5 = Instance.new("TextLabel")

		TextLabel5.AnchorPoint = Vector2.new(0.5, 0)
		TextLabel5.Position = UDim2.new(0.5, 0, 0, 6)
		TextLabel5.Size = UDim2.new(0.9, 0, 0, 22)
		TextLabel5.BackgroundTransparency = 1
		TextLabel5.Text = "PERMANENT UPGRADE"
		TextLabel5.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
		TextLabel5.TextSize = 18
		TextLabel5.TextColor3 = Color3.fromRGB(230, 200, 130)
		TextLabel5.ZIndex = 7
		TextLabel5.Parent = PremiumButton

		local TextLabel6 = Instance.new("TextLabel")

		TextLabel6.AnchorPoint = Vector2.new(0.5, 1)
		TextLabel6.Position = UDim2.new(0.5, 0, 1, -5)
		TextLabel6.Size = UDim2.new(0.9, 0, 0, 14)
		TextLabel6.BackgroundTransparency = 1
		TextLabel6.Text = "UNLOCK WITH ROBUX"
		TextLabel6.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
		TextLabel6.TextSize = 12
		TextLabel6.TextColor3 = Color3.fromRGB(180, 160, 120)
		TextLabel6.ZIndex = 7
		TextLabel6.Parent = PremiumButton
		PremiumButton.MouseButton1Click:Connect(function() --[[ Line: 3077 | Upvalues: p1 (copy) ]]
			p1:_onPremiumUpgradeClicked()
		end)
		p1._expansionPanel = StashExpansionPanel
		p1._expansionPremiumBtn = PremiumButton
	end

	p1:_refreshExpansionPanel()
end
function t._onAutoFillBarterClicked(p1) --[[ _onAutoFillBarterClicked | Line: 3090 | Upvalues: ReplicatedStorage (copy) ]]
	if p1._autoFillPreview then
		p1:_exitAutoFillPreview(true)

		return
	end

	local ok, result = pcall(function() --[[ Line: 3097 | Upvalues: ReplicatedStorage (ref) ]]
		return ReplicatedStorage.Remotes.BarterAutoFillPreview:InvokeServer()
	end)

	if not (ok and result) then
		return
	end

	local v1 = result.items and (if #result.items > 0 then true else false)

	if v1 or result.currency and (if #result.currency > 0 then true else false) then
		p1:_enterAutoFillPreview(result)
	end
end
function t._findItemByTiedAndIdx(p1, p2, p3) --[[ _findItemByTiedAndIdx | Line: 3115 | Upvalues: Players (copy) ]]
	local TransferLink = p1.TransferLink

	if not (TransferLink and TransferLink.ConnectedItemManagers) then
		return nil
	end

	local v1 = tostring(Players.LocalPlayer.UserId)

	for i, v in ipairs(TransferLink.ConnectedItemManagers) do
		local v2
		local v3 = v.Metadata and v.Metadata.TiedInstance

		v2 = if typeof(v3) == "Instance" then tostring(Players.LocalPlayer.UserId) else v3

		if (v2 == p2 or p2 == v1 and typeof(v3) == "Instance") and v.Items then
			for k, v4 in pairs(v.Items) do
				if v4.Metadata and v4.Metadata.ItemIndex == p3 then
					return v4
				end
			end
		end
	end

	return nil
end
function t._buildItemGhostOverlay(p1, p2) --[[ _buildItemGhostOverlay | Line: 3144 ]]
	if not (p2 and p2.ItemElement) then
		return nil
	end

	local BarterGhostOverlay = p2.ItemElement:FindFirstChild("BarterGhostOverlay")
	local BarterGhostOverlay2, v1, Check

	if not BarterGhostOverlay then
		BarterGhostOverlay2 = Instance.new("Frame")
		BarterGhostOverlay2.Name = "BarterGhostOverlay"
		BarterGhostOverlay2.Active = false
		BarterGhostOverlay2.AnchorPoint = Vector2.new(0, 0)
		BarterGhostOverlay2.Position = UDim2.fromScale(0, 0)
		BarterGhostOverlay2.Size = UDim2.fromScale(1, 1)
		BarterGhostOverlay2.BackgroundColor3 = Color3.fromRGB(46, 110, 46)
		BarterGhostOverlay2.BackgroundTransparency = 0.45
		BarterGhostOverlay2.BorderSizePixel = 0
		BarterGhostOverlay2.ZIndex = 50
		BarterGhostOverlay2.Parent = p2.ItemElement
		v1 = Instance.new("UIStroke")
		v1.Color = Color3.fromRGB(140, 240, 140)
		v1.Thickness = 2
		v1.Parent = BarterGhostOverlay2
		Check = Instance.new("TextLabel")
		Check.Name = "Check"
		Check.AnchorPoint = Vector2.new(1, 0)
		Check.Position = UDim2.new(1, -3, 0, 2)
		Check.Size = UDim2.fromOffset(18, 18)
		Check.BackgroundTransparency = 1
		Check.Text = utf8.char(10003)
		Check.TextColor3 = Color3.fromRGB(220, 255, 220)
		Check.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
		Check.TextSize = 18
		Check.ZIndex = 51
		Check.Parent = BarterGhostOverlay2

		return BarterGhostOverlay2
	end

	BarterGhostOverlay:Destroy()
	BarterGhostOverlay2 = Instance.new("Frame")
	BarterGhostOverlay2.Name = "BarterGhostOverlay"
	BarterGhostOverlay2.Active = false
	BarterGhostOverlay2.AnchorPoint = Vector2.new(0, 0)
	BarterGhostOverlay2.Position = UDim2.fromScale(0, 0)
	BarterGhostOverlay2.Size = UDim2.fromScale(1, 1)
	BarterGhostOverlay2.BackgroundColor3 = Color3.fromRGB(46, 110, 46)
	BarterGhostOverlay2.BackgroundTransparency = 0.45
	BarterGhostOverlay2.BorderSizePixel = 0
	BarterGhostOverlay2.ZIndex = 50
	BarterGhostOverlay2.Parent = p2.ItemElement
	v1 = Instance.new("UIStroke")
	v1.Color = Color3.fromRGB(140, 240, 140)
	v1.Thickness = 2
	v1.Parent = BarterGhostOverlay2
	Check = Instance.new("TextLabel")
	Check.Name = "Check"
	Check.AnchorPoint = Vector2.new(1, 0)
	Check.Position = UDim2.new(1, -3, 0, 2)
	Check.Size = UDim2.fromOffset(18, 18)
	Check.BackgroundTransparency = 1
	Check.Text = utf8.char(10003)
	Check.TextColor3 = Color3.fromRGB(220, 255, 220)
	Check.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
	Check.TextSize = 18
	Check.ZIndex = 51
	Check.Parent = BarterGhostOverlay2

	return BarterGhostOverlay2
end
function t._updateChipProjectedQty(p1, p2, p3, p4, p5) --[[ _updateChipProjectedQty | Line: 3181 ]]
	local _expansionMatsRow = p1._expansionMatsRow

	if not _expansionMatsRow then
		return
	end

	local v1 = _expansionMatsRow:FindFirstChild(p2 .. "Chip")

	if not v1 then
		return
	end

	local QuantityLabel = v1:FindFirstChild("QuantityLabel")

	if not QuantityLabel then
		return
	end

	if p4 > 0 then
		QuantityLabel.RichText = true
		QuantityLabel.Text = string.format("%s + <font color=\"rgb(140,240,140)\">%s</font> / %s", p1:_formatBarterQty(p3), p1:_formatBarterQty(p4), p1:_formatBarterQty(p5))
	else
		QuantityLabel.RichText = false
		QuantityLabel.Text = string.format("%s / %s", p1:_formatBarterQty(p3), p1:_formatBarterQty(p5))
	end
end
function t._setAutoFillButtonsForPreview(p1, p2) --[[ _setAutoFillButtonsForPreview | Line: 3203 ]]
	if p1._autoFillBtn then
		p1._autoFillBtn.Visible = not p2
	end

	if p1._barterButton then
		p1._barterButton.Visible = not p2
	end

	if not p1._previewActionRow then
		return
	end

	p1._previewActionRow.Visible = p2
end
function t._enterAutoFillPreview(p1, p2) --[[ _enterAutoFillPreview | Line: 3209 | Upvalues: ReplicatedStorage (copy) ]]
	local StashTierConfig = require(ReplicatedStorage:WaitForChild("StashTierConfig"))
	local ok, result = pcall(function() --[[ Line: 3213 | Upvalues: ReplicatedStorage (ref) ]]
		return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer()
	end)
	local v1, v2

	if ok and result then
		v1 = (result.PremiumTier or 0) + (result.BarterTier or 0)
		v2 = result.BarterContribution or {}
	else
		v1 = 0
		v2 = {}
	end

	local v4 = StashTierConfig.GetBarterRequirements(v1) or {}
	local t = {}

	for i, v in ipairs(v4) do
		t[v.id] = v.quantity
	end

	local t2 = {}
	local t3 = {}

	for i = 1, #(p2.items or {}) do
		t2[i] = true
	end

	for j = 1, #(p2.currency or {}) do
		t3[j] = true
	end

	p1._autoFillPreview = p2
	p1._autoFillSelectedItems = t2
	p1._autoFillSelectedCurrency = t3
	p1._autoFillGhosts = {}
	p1._autoFillCurrentPool = v2
	p1._autoFillQuotaById = t

	local t4 = {}

	for i, v in ipairs(p2.items) do
		local v9 = p1:_findItemByTiedAndIdx(v.tied, v.idx)

		if v9 then
			local v10 = p1:_buildItemGhostOverlay(v9)

			if v10 then
				p1._autoFillGhosts[i] = v10
			end
		end

		t4[v.itemId] = (t4[v.itemId] or 0) + 1
	end

	for i, v in ipairs(p2.currency) do
		t4[v.itemId] = (t4[v.itemId] or 0) + (v.amount or 0)
	end

	for i, v in ipairs(v4) do
		p1:_updateChipProjectedQty(v.id, v2[v.id] or 0, t4[v.id] or 0, v.quantity)
	end

	p1:_setAutoFillButtonsForPreview(true)

	local UserInputService = game:GetService("UserInputService")
	local v11 = game:GetService("GuiService"):GetGuiInset()

	if p1._previewInputConn then
		p1._previewInputConn:Disconnect()
	end

	p1._previewInputConn = UserInputService.InputBegan:Connect(function(p12, p2) --[[ Line: 3267 | Upvalues: p1 (copy), UserInputService (copy), v11 (copy) ]]
		if p12.UserInputType ~= Enum.UserInputType.MouseButton2 then
			return
		end

		if not p1._autoFillPreview then
			return
		end

		local v1 = UserInputService:GetMouseLocation() - v11

		for k, v in pairs(p1._autoFillGhosts) do
			if v.Parent then
				local AbsolutePosition = v.AbsolutePosition
				local AbsoluteSize = v.AbsoluteSize

				if v1.X >= AbsolutePosition.X and (v1.X <= AbsolutePosition.X + AbsoluteSize.X and (v1.Y >= AbsolutePosition.Y and v1.Y <= AbsolutePosition.Y + AbsoluteSize.Y)) then
					p1:_togglePreviewItemEntry(k, false)

					return
				end
			end
		end
	end)
end
function t._recomputeProjectionsAndRepaint(p1) --[[ _recomputeProjectionsAndRepaint | Line: 3285 ]]
	local _autoFillPreview = p1._autoFillPreview

	if not _autoFillPreview then
		return
	end

	local t = {}
	local v1 = ipairs

	for v3, v4 in v1(_autoFillPreview.items or {}) do
		if p1._autoFillSelectedItems[v3] then
			t[v4.itemId] = (t[v4.itemId] or 0) + 1
		end
	end

	local v5 = ipairs

	for v7, v8 in v5(_autoFillPreview.currency or {}) do
		if p1._autoFillSelectedCurrency[v7] then
			t[v8.itemId] = (t[v8.itemId] or 0) + (v8.amount or 0)
		end
	end

	local v9 = pairs

	for v11, v12 in v9(p1._autoFillQuotaById or {}) do
		p1:_updateChipProjectedQty(v11, (p1._autoFillCurrentPool or {})[v11] or 0, t[v11] or 0, v12)
	end
end
function t._togglePreviewItemEntry(p1, p2, p3) --[[ _togglePreviewItemEntry | Line: 3304 ]]
	if not p1._autoFillPreview then
		return
	end

	if p1._autoFillSelectedItems[p2] == p3 then
		return
	end

	p1._autoFillSelectedItems[p2] = p3

	if p3 then
		local v1 = p1._autoFillPreview.items[p2]

		if v1 then
			local v2 = p1:_findItemByTiedAndIdx(v1.tied, v1.idx)

			if v2 then
				local v3 = p1:_buildItemGhostOverlay(v2)

				if v3 then
					p1._autoFillGhosts[p2] = v3
				end
			end
		end
	else
		local v4 = p1._autoFillGhosts[p2]

		if v4 then
			v4:Destroy()
		end

		p1._autoFillGhosts[p2] = nil
	end

	p1:_recomputeProjectionsAndRepaint()
	p1:PlaySound("Move", "General")
end
function t._onRoubleChipClicked(p1, p2) --[[ _onRoubleChipClicked | Line: 3330 | Upvalues: ReplicatedStorage (copy) ]]
	if p1._autoFillPreview then
		return
	end

	if p1._roubleDialogOpen then
		return
	end

	local ok, result = pcall(function() --[[ Line: 3333 | Upvalues: ReplicatedStorage (ref) ]]
		return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer()
	end)

	if not (ok and result) then
		return
	end

	local v3 = p2.quantity - ((result.BarterContribution or {})[p2.id] or 0)

	if v3 <= 0 then
		return
	end

	local ok2, result2 = pcall(function() --[[ Line: 3341 | Upvalues: ReplicatedStorage (ref) ]]
		return ReplicatedStorage.Remotes.RequestBalance:InvokeServer()
	end)
	local v4 = if ok2 and (type(result2) == "number" and result2) then result2 else 0
	local v5 = math.min(v3, v4)

	if v5 <= 0 then
		p1:_showRoubleDialog({
			insufficient = true,
			need = v3,
			balance = v4,
			req = p2
		})
	else
		p1:_showRoubleDialog({
			amount = v5,
			need = v3,
			balance = v4,
			req = p2
		})
	end
end
function t._showRoubleDialog(p1, p2) --[[ _showRoubleDialog | Line: 3355 | Upvalues: ReplicatedStorage (copy) ]]
	local _expansionPanel = p1._expansionPanel

	if not (_expansionPanel and _expansionPanel.Parent) then
		return
	end

	if p1._roubleDialog then
		p1._roubleDialog:Destroy()
	end

	p1._roubleDialogOpen = true

	local RoubleDialogScrim = Instance.new("TextButton")

	RoubleDialogScrim.Name = "RoubleDialogScrim"
	RoubleDialogScrim.Size = UDim2.fromScale(1, 1)
	RoubleDialogScrim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	RoubleDialogScrim.BackgroundTransparency = 0.4
	RoubleDialogScrim.BorderSizePixel = 0
	RoubleDialogScrim.Text = ""
	RoubleDialogScrim.AutoButtonColor = false
	RoubleDialogScrim.ZIndex = 50
	RoubleDialogScrim.Parent = _expansionPanel.Parent
	p1._roubleDialog = RoubleDialogScrim

	local Frame = Instance.new("Frame")

	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.Position = UDim2.fromScale(0.5, 0.5)
	Frame.Size = UDim2.fromOffset(360, 160)
	Frame.BackgroundColor3 = Color3.fromRGB(28, 30, 27)
	Frame.BorderSizePixel = 0
	Frame.ZIndex = 51
	Frame.Parent = RoubleDialogScrim

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(120, 160, 120)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = Frame

	local v2 = utf8.char(8381)
	local TextLabel = Instance.new("TextLabel")

	TextLabel.AnchorPoint = Vector2.new(0.5, 0)
	TextLabel.Position = UDim2.new(0.5, 0, 0, 12)
	TextLabel.Size = UDim2.new(1, -20, 0, 22)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
	TextLabel.TextSize = 18
	TextLabel.TextColor3 = Color3.fromRGB(220, 230, 220)
	TextLabel.Text = if p2.insufficient then "INSUFFICIENT FUNDS" else "CONTRIBUTE ROUBLES"
	TextLabel.ZIndex = 52
	TextLabel.Parent = Frame

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.AnchorPoint = Vector2.new(0.5, 0)
	TextLabel2.Position = UDim2.new(0.5, 0, 0, 42)
	TextLabel2.Size = UDim2.new(1, -24, 0, 58)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
	TextLabel2.TextSize = 14
	TextLabel2.TextColor3 = Color3.fromRGB(190, 190, 190)
	TextLabel2.TextWrapped = true
	TextLabel2.RichText = true
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel2.ZIndex = 52
	TextLabel2.Parent = Frame

	if p2.insufficient then
		TextLabel2.Text = string.format("You need <font color=\'rgb(220,180,180)\'>%s %s</font> more, but your balance is <font color=\'rgb(220,180,180)\'>%s %s</font>.", p1:_formatBarterQty(p2.need), v2, p1:_formatBarterQty(p2.balance), v2)
	else
		TextLabel2.Text = string.format("Contribute <font color=\'rgb(140,220,140)\'>%s %s</font> from your balance? <font color=\'rgb(220,180,180)\'>You can\'t get it back.</font>", p1:_formatBarterQty(p2.amount), v2)
	end

	local function closeDialog() --[[ closeDialog | Line: 3422 | Upvalues: p1 (copy) ]]
		if p1._roubleDialog then
			p1._roubleDialog:Destroy()
		end

		p1._roubleDialog = nil
		p1._roubleDialogOpen = false
	end

	if p2.insufficient then
		local TextButton = Instance.new("TextButton")

		TextButton.AnchorPoint = Vector2.new(0.5, 1)
		TextButton.Position = UDim2.new(0.5, 0, 1, -12)
		TextButton.Size = UDim2.fromOffset(100, 30)
		TextButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		TextButton.BorderSizePixel = 0
		TextButton.AutoButtonColor = true
		TextButton.Text = "CLOSE"
		TextButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
		TextButton.TextSize = 14
		TextButton.TextColor3 = Color3.fromRGB(200, 200, 200)
		TextButton.ZIndex = 52
		TextButton.Parent = Frame
		TextButton.MouseButton1Click:Connect(closeDialog)
		RoubleDialogScrim.MouseButton1Click:Connect(closeDialog)
	else
		local TextButton = Instance.new("TextButton")

		TextButton.AnchorPoint = Vector2.new(0, 1)
		TextButton.Position = UDim2.new(0, 16, 1, -12)
		TextButton.Size = UDim2.new(0.45, -8, 0, 32)
		TextButton.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
		TextButton.BorderSizePixel = 0
		TextButton.AutoButtonColor = true
		TextButton.Text = "CANCEL"
		TextButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
		TextButton.TextSize = 14
		TextButton.TextColor3 = Color3.fromRGB(220, 180, 180)
		TextButton.ZIndex = 52
		TextButton.Parent = Frame

		local UIStroke2 = Instance.new("UIStroke")

		UIStroke2.Color = Color3.fromRGB(150, 70, 70)
		UIStroke2.Thickness = 1
		UIStroke2.Parent = TextButton

		local TextButton2 = Instance.new("TextButton")

		TextButton2.AnchorPoint = Vector2.new(1, 1)
		TextButton2.Position = UDim2.new(1, -16, 1, -12)
		TextButton2.Size = UDim2.new(0.45, -8, 0, 32)
		TextButton2.BackgroundColor3 = Color3.fromRGB(46, 110, 46)
		TextButton2.BorderSizePixel = 0
		TextButton2.AutoButtonColor = true
		TextButton2.Text = string.format("CONTRIBUTE %s %s", p1:_formatBarterQty(p2.amount), v2)
		TextButton2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
		TextButton2.TextSize = 14
		TextButton2.TextColor3 = Color3.fromRGB(220, 255, 220)
		TextButton2.ZIndex = 52
		TextButton2.Parent = Frame

		local UIStroke3 = Instance.new("UIStroke")

		UIStroke3.Color = Color3.fromRGB(140, 240, 140)
		UIStroke3.Thickness = 2
		UIStroke3.Parent = TextButton2
		TextButton.MouseButton1Click:Connect(closeDialog)
		RoubleDialogScrim.MouseButton1Click:Connect(closeDialog)
		TextButton2.MouseButton1Click:Connect(function() --[[ Line: 3485 | Upvalues: p1 (copy), p2 (copy), ReplicatedStorage (ref) ]]
			if p1._roubleDialog then
				p1._roubleDialog:Destroy()
			end

			p1._roubleDialog = nil
			p1._roubleDialogOpen = false

			local t = {
				items = {},
				currency = {
					{
						itemId = p2.req.id,
						amount = p2.amount
					}
				}
			}
			local ok, _ = pcall(function() --[[ Line: 3488 | Upvalues: ReplicatedStorage (ref), t (copy) ]]
				return ReplicatedStorage.Remotes.BarterAutoFillCommit:InvokeServer(t)
			end)

			if not ok then
				return
			end

			p1:PlaySound("Move", "General")
			p1:_refreshExpansionPanel()
		end)
	end
end
function t._exitAutoFillPreview(p1, p2) --[[ _exitAutoFillPreview | Line: 3498 | Upvalues: ReplicatedStorage (copy) ]]
	if not p1._autoFillPreview then
		return
	end

	local v1 = pairs

	for v3, v4 in v1(p1._autoFillGhosts or {}) do
		if v4 and v4.Parent then
			v4:Destroy()
		end
	end

	p1._autoFillGhosts = nil

	if p1._previewInputConn then
		p1._previewInputConn:Disconnect()
		p1._previewInputConn = nil
	end

	p1:_setAutoFillButtonsForPreview(false)

	if not p2 then
		p1._autoFillPreview = nil
		p1._autoFillSelectedItems = nil
		p1._autoFillSelectedCurrency = nil
		p1._autoFillCurrentPool = nil
		p1._autoFillQuotaById = nil
		p1:_refreshExpansionPanel()

		return
	end

	local t = {
		items = {},
		currency = {}
	}
	local v5 = ipairs

	for v7, v8 in v5(p1._autoFillPreview.items or {}) do
		if p1._autoFillSelectedItems[v7] then
			table.insert(t.items, v8)
		end
	end

	local v9 = ipairs

	for v11, v12 in v9(p1._autoFillPreview.currency or {}) do
		if p1._autoFillSelectedCurrency[v11] then
			table.insert(t.currency, v12)
		end
	end

	local v13 = if #t.items > 0 then true elseif #t.currency > 0 then true else false

	p1._autoFillPreview = nil
	p1._autoFillSelectedItems = nil
	p1._autoFillSelectedCurrency = nil
	p1._autoFillCurrentPool = nil
	p1._autoFillQuotaById = nil

	if not v13 then
		p1:_refreshExpansionPanel()

		return
	end

	local ok, _ = pcall(function() --[[ Line: 3533 | Upvalues: ReplicatedStorage (ref), t (copy) ]]
		return ReplicatedStorage.Remotes.BarterAutoFillCommit:InvokeServer(t)
	end)

	if ok then
		p1:LoadVicinity()
	else
		p1:_refreshExpansionPanel()
	end
end
function t._toggleExpansionPopout(p1) --[[ _toggleExpansionPopout | Line: 3562 ]]
	p1:_setExpansionPoppedOut(not p1._expansionPoppedOut)
end
function t._setExpansionPoppedOut(p1, p2) --[[ _setExpansionPoppedOut | Line: 3566 ]]
	local _expansionPanel = p1._expansionPanel

	if not _expansionPanel then
		return
	end

	local InventoryGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")
	local v1 = if InventoryGui then InventoryGui.MainFrame and InventoryGui.MainFrame:FindFirstChild("ContainerFrame") else InventoryGui

	if not (InventoryGui and v1) then
		return
	end

	p1._expansionPoppedOut = p2

	if p1._expansionContentScroll then
		p1._expansionContentScroll.Visible = p2
	end

	if p2 then
		p1._inlineSavedAnchor = _expansionPanel.AnchorPoint
		p1._inlineSavedPosition = _expansionPanel.Position
		p1._inlineSavedSize = _expansionPanel.Size
		_expansionPanel.Parent = InventoryGui
		_expansionPanel.AnchorPoint = Vector2.new(0, 0)
		_expansionPanel.Size = UDim2.fromOffset(420, 360)

		local _popoutLastPosition = p1._popoutLastPosition

		if _popoutLastPosition then
			_expansionPanel.Position = _popoutLastPosition
		else
			local AbsolutePosition = v1.AbsolutePosition
			local fromOffset = UDim2.fromOffset

			_expansionPanel.Position = fromOffset(math.max(AbsolutePosition.X - 440, 20), AbsolutePosition.Y + 60)
		end

		p1:_setAutoFillButtonsForPreview(p1._autoFillPreview ~= nil)
		p1:_attachPopoutDrag()

		if p1._expansionCollapseBtn then
			p1._expansionCollapseBtn.Text = "X"
		end
	else
		p1:_detachPopoutDrag()
		_expansionPanel.Parent = v1
		_expansionPanel.AnchorPoint = p1._inlineSavedAnchor or Vector2.new(0.5, 0)
		_expansionPanel.Size = UDim2.new(0.93, 0, 0, 46)

		if p1._expansionCollapseBtn then
			p1._expansionCollapseBtn.Text = "+"
		end

		p1:_positionExpansionPanelBelowGrid()
	end
end
function t._attachPopoutDrag(p1) --[[ _attachPopoutDrag | Line: 3622 ]]
	local _expansionTitleRow = p1._expansionTitleRow
	local _expansionPanel = p1._expansionPanel

	if _expansionTitleRow and _expansionPanel then
		local UserInputService = game:GetService("UserInputService")

		p1:_detachPopoutDrag()

		local v1 = false
		local v2 = nil
		local v3 = nil

		p1._popoutDragBeganConn = _expansionTitleRow.InputBegan:Connect(function(p12) --[[ Line: 3632 | Upvalues: UserInputService (copy), p1 (copy), v1 (ref), v2 (ref), v3 (ref), _expansionPanel (copy) ]]
			if p12.UserInputType ~= Enum.UserInputType.MouseButton1 then
				return
			end

			local v12 = UserInputService:GetMouseLocation()
			local _expansionCollapseBtn = p1._expansionCollapseBtn

			if _expansionCollapseBtn then
				local AbsolutePosition = _expansionCollapseBtn.AbsolutePosition
				local AbsoluteSize = _expansionCollapseBtn.AbsoluteSize

				if v12.X >= AbsolutePosition.X and (v12.X <= AbsolutePosition.X + AbsoluteSize.X and (v12.Y >= AbsolutePosition.Y and v12.Y <= AbsolutePosition.Y + AbsoluteSize.Y)) then
					return
				end
			end

			v1 = true
			v2 = v12
			v3 = _expansionPanel.Position
		end)
		p1._popoutDragMoveConn = UserInputService.InputChanged:Connect(function(p1) --[[ Line: 3648 | Upvalues: v1 (ref), UserInputService (copy), v2 (ref), _expansionPanel (copy), v3 (ref) ]]
			if not v1 then
				return
			end

			if p1.UserInputType == Enum.UserInputType.MouseMovement then
				local v12 = UserInputService:GetMouseLocation() - v2

				_expansionPanel.Position = UDim2.new(v3.X.Scale, v3.X.Offset + v12.X, v3.Y.Scale, v3.Y.Offset + v12.Y)
			end
		end)
		p1._popoutDragEndConn = UserInputService.InputEnded:Connect(function(p12) --[[ Line: 3659 | Upvalues: v1 (ref), p1 (copy), _expansionPanel (copy) ]]
			if p12.UserInputType ~= Enum.UserInputType.MouseButton1 then
				return
			end

			if not v1 then
				return
			end

			v1 = false
			p1._popoutLastPosition = _expansionPanel.Position
		end)
	end
end
function t._detachPopoutDrag(p1) --[[ _detachPopoutDrag | Line: 3668 ]]
	for i, v in ipairs({ "_popoutDragBeganConn", "_popoutDragMoveConn", "_popoutDragEndConn" }) do
		if p1[v] then
			p1[v]:Disconnect()
			p1[v] = nil
		end
	end
end
function t._autoCollapseIfNoRoom(p1) --[[ _autoCollapseIfNoRoom | Line: 3679 ]] end
function t._onBarterExpandClicked(p1) --[[ _onBarterExpandClicked | Line: 3682 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(function() --[[ Line: 3683 | Upvalues: ReplicatedStorage (ref) ]]
		return ReplicatedStorage.Remotes.BarterExpand:InvokeServer()
	end)
	local _ = ok and (result and result.ok)
end
function t._refreshExpansionSizeIndicator(p1) --[[ _refreshExpansionSizeIndicator | Line: 3696 | Upvalues: ReplicatedStorage (copy) ]]
	local _expansionSizeIndicator = p1._expansionSizeIndicator

	if _expansionSizeIndicator or p1._expansionMatsRow then
		local StashTierConfig = require(ReplicatedStorage:WaitForChild("StashTierConfig"))

		task.spawn(function() --[[ Line: 3701 | Upvalues: ReplicatedStorage (ref), StashTierConfig (copy), p1 (copy), _expansionSizeIndicator (copy) ]]
			local ok, result = pcall(function() --[[ Line: 3702 | Upvalues: ReplicatedStorage (ref) ]]
				return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer()
			end)
			local v3 = (ok and result and result.PremiumTier or 0) + (ok and result and result.BarterTier or 0)
			local v4 = ok and result and result.GridSize or StashTierConfig.BASELINE
			local v5 = StashTierConfig.TierLadder[v3 + 1]
			local v6 = ok and result and result.BarterContribution or {}

			if (StashTierConfig.MAX_TIER or 7) <= v3 then
				if p1._expansionPoppedOut then
					p1:_setExpansionPoppedOut(false)
				end

				if not p1._expansionPanel then
					return
				end

				p1._expansionPanel.Visible = false
			else
				if _expansionSizeIndicator and _expansionSizeIndicator.Parent then
					local v7 = ("%dx%d"):format(v4.X, v4.Y)

					if v5 then
						_expansionSizeIndicator.Text = ("Current <font color=\'rgb(210,210,210)\'>%s</font>  \226\134\146  Next <font color=\'rgb(140,220,140)\'>%s</font>"):format(v7, (("%dx%d"):format(v5.X, v5.Y)))
					else
						_expansionSizeIndicator.Text = ("Current <font color=\'rgb(210,210,210)\'>%s</font>  \226\128\148  MAX TIER"):format(v7)
					end
				end

				p1:_renderBarterChips(v3, v6)
				p1:_refreshBarterButtonState(v3, v6)
			end
		end)
	end
end
function t._refreshBarterButtonState(p1, p2, p3) --[[ _refreshBarterButtonState | Line: 3742 | Upvalues: ReplicatedStorage (copy) ]]
	local _barterButton = p1._barterButton

	if not _barterButton then
		return
	end

	local v1 = require(ReplicatedStorage:WaitForChild("StashTierConfig")).GetBarterRequirements(p2 or 0)
	local v2

	if v1 then
		for i, v in ipairs(v1) do
			if (p3[v.id] or 0) < v.quantity then
				v2 = false

				break
			end
		end
	end

	local LockIcon = _barterButton:FindFirstChild("LockIcon")
	local Main = _barterButton:FindFirstChild("Main")
	local Sub = _barterButton:FindFirstChild("Sub")
	local UIStroke = _barterButton:FindFirstChildOfClass("UIStroke")

	if v2 then
		_barterButton.BackgroundColor3 = Color3.fromRGB(56, 80, 56)
		_barterButton.AutoButtonColor = true

		if UIStroke then
			UIStroke.Color = Color3.fromRGB(140, 200, 140)
		end

		if LockIcon then
			LockIcon.Visible = false
		end

		if Main then
			Main.TextColor3 = Color3.fromRGB(230, 240, 230)
		end

		if Sub then
			Sub.Text = "All requirements met -- click to upgrade"
			Sub.TextColor3 = Color3.fromRGB(170, 220, 170)
		end
	else
		_barterButton.BackgroundColor3 = Color3.fromRGB(32, 33, 30)
		_barterButton.AutoButtonColor = false

		if UIStroke then
			UIStroke.Color = Color3.fromRGB(48, 48, 48)
		end

		if LockIcon then
			LockIcon.Visible = true
		end

		if Main then
			Main.TextColor3 = Color3.fromRGB(180, 180, 180)
		end

		if Sub then
			Sub.Text = "Complete all requirements to unlock"
			Sub.TextColor3 = Color3.fromRGB(120, 120, 120)
		end
	end

	p1._barterButtonReady = v2
end
function t._renderBarterChips(p1, p2, p3) --[[ _renderBarterChips | Line: 3784 | Upvalues: ReplicatedStorage (copy), Players (copy), GridPack (copy), ItemIconStyle (copy) ]]
	local _expansionMatsRow = p1._expansionMatsRow

	if not _expansionMatsRow then
		return
	end

	local StashTierConfig = require(ReplicatedStorage:WaitForChild("StashTierConfig"))
	local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"))
	local v1 = StashTierConfig.GetBarterRequirements(p2 or 0)
	local v3 = if p3 then p3 else {}

	for i, v in ipairs(_expansionMatsRow:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end

	if not v1 then
		local Frame = Instance.new("Frame")

		Frame.Size = UDim2.new(1, 0, 1, 0)
		Frame.BackgroundTransparency = 1
		Frame.Parent = _expansionMatsRow

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.fromScale(1, 1)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = "MAX TIER REACHED"
		TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
		TextLabel.TextSize = 15
		TextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		TextLabel.Parent = Frame

		return
	end

	if p1._barterChipGrids then
		for i, v in ipairs(p1._barterChipGrids) do
			pcall(function() --[[ Line: 3818 | Upvalues: v (copy) ]]
				if not v.GuiElement then
					return
				end

				v.GuiElement:Destroy()
			end)
		end
	end

	p1._barterChipGrids = {}

	if not p1._invisibleSlotTemplate then
		local v4 = game.ReplicatedStorage.GridPack.SingleSlot:Clone()

		v4.BackgroundTransparency = 1

		if v4:IsA("CanvasGroup") then
			v4.GroupTransparency = 1
		end

		for i, v in ipairs(v4:GetDescendants()) do
			if v:IsA("UIStroke") then
				v.Enabled = false
			end

			if v:IsA("Frame") or v:IsA("CanvasGroup") then
				v.BackgroundTransparency = 1
			end

			if v:IsA("CanvasGroup") then
				v.GroupTransparency = 1
			end

			if v:IsA("ImageLabel") then
				v.ImageTransparency = 1
				v.BackgroundTransparency = 1
			end
		end

		p1._invisibleSlotTemplate = v4
	end

	local v5 = utf8.char(8381)
	local UserId = Players.LocalPlayer.UserId

	for i, v in ipairs(v1) do
		local Frame = Instance.new("Frame")

		Frame.Name = v.id .. "Chip"
		Frame.LayoutOrder = i
		Frame.Size = UDim2.new(0.2, -6.4, 1, 0)
		Frame.BackgroundColor3 = Color3.fromRGB(28, 30, 27)
		Frame.BorderSizePixel = 0
		Frame.ZIndex = 6
		Frame.Parent = _expansionMatsRow

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = Color3.fromRGB(48, 48, 48)
		UIStroke.Thickness = 1
		UIStroke.Parent = Frame

		local v6 = ItemDatabase.GetItemData(v.id)

		if not v.isCurrency then
			local v8 = GridPack.createSingleSlot({
				Visible = true,
				Parent = Frame,
				Assets = {
					Slot = p1._invisibleSlotTemplate
				},
				AnchorPoint = Vector2.new(0, 0),
				Position = UDim2.fromScale(0, 0),
				Size = UDim2.fromScale(1, 1)
			})

			v8.Metadata = {
				IsBarterChip = true,
				AcceptsType = "Barter",
				TiedInstance = "BarterChip_" .. v.id .. "_" .. UserId,
				BarterItemId = v.id
			}
			v8.MoveMiddleware = p1:CreateMoveMiddleware()
			v8:ConnectTransferLink(p1.TransferLink)

			if v8.GuiElement then
				v8.GuiElement.ZIndex = 6

				if v8.GuiElement:IsA("CanvasGroup") then
					v8.GuiElement.GroupTransparency = 1
					v8.GuiElement.BackgroundTransparency = 1
				end
			end

			Frame:SetAttribute("BarterChipItemId", v.id)
			Frame:SetAttribute("BarterChipBaseBG", "28,30,27")
			table.insert(p1._barterChipGrids, v8)
		end

		local TextLabel = Instance.new("TextLabel")

		TextLabel.AnchorPoint = Vector2.new(0.5, 0)
		TextLabel.Position = UDim2.new(0.5, 0, 0, 5)
		TextLabel.Size = UDim2.new(1, -8, 0, 14)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = v6 and v6.Name or v.id
		TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
		TextLabel.TextSize = 13
		TextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		TextLabel.ZIndex = 8
		TextLabel.Parent = Frame

		if v.isCurrency then
			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel2.Position = UDim2.new(0.5, 0, 0.52, 0)
			TextLabel2.Size = UDim2.new(0.7, 0, 0.55, 0)
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.Text = v5
			TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
			TextLabel2.TextSize = 32
			TextLabel2.TextColor3 = Color3.fromRGB(140, 200, 140)
			TextLabel2.ZIndex = 8
			TextLabel2.Parent = Frame

			local RoubleClickArea = Instance.new("TextButton")

			RoubleClickArea.Name = "RoubleClickArea"
			RoubleClickArea.BackgroundTransparency = 1
			RoubleClickArea.Text = ""
			RoubleClickArea.Size = UDim2.fromScale(1, 1)
			RoubleClickArea.ZIndex = 9
			RoubleClickArea.Parent = Frame
			RoubleClickArea.MouseButton1Click:Connect(function() --[[ Line: 3950 | Upvalues: p1 (copy), v (copy) ]]
				p1:_onRoubleChipClicked(v)
			end)
		else
			local ImageLabel = Instance.new("ImageLabel")

			ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			ImageLabel.Position = UDim2.new(0.5, 0, 0.52, 0)
			ImageLabel.Size = UDim2.new(0, 38, 0, 38)
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.Image = v6 and v6.ImageID or "rbxassetid://0"
			ImageLabel.ScaleType = ItemIconStyle.ScaleTypeFor(v6)
			ImageLabel.ZIndex = 8
			ImageLabel.Parent = Frame
		end

		local v10 = v3[v.id] or 0
		local v11 = if v.quantity <= v10 then true else false
		local QuantityLabel = Instance.new("TextLabel")

		QuantityLabel.Name = "QuantityLabel"
		QuantityLabel.AnchorPoint = Vector2.new(0.5, 1)
		QuantityLabel.Position = UDim2.new(0.5, 0, 1, -5)
		QuantityLabel.Size = UDim2.new(1, -6, 0, 15)
		QuantityLabel.BackgroundTransparency = 1
		QuantityLabel.Text = ("%s / %s"):format(p1:_formatBarterQty(v10), p1:_formatBarterQty(v.quantity))
		QuantityLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
		QuantityLabel.TextSize = 13
		QuantityLabel.TextColor3 = v11 and Color3.fromRGB(140, 220, 140) or Color3.fromRGB(160, 160, 160)
		QuantityLabel.ZIndex = 8
		QuantityLabel.Parent = Frame
	end
end
function t._startBarterHoverPoll(p1) --[[ _startBarterHoverPoll | Line: 3988 ]]
	if not p1._chipHoverConn then
		local RunService = game:GetService("RunService")
		local t = {}
		local v1 = Color3.fromRGB(46, 80, 46)
		local v2 = Color3.fromRGB(120, 220, 120)
		local v3 = Color3.fromRGB(80, 36, 36)
		local v4 = Color3.fromRGB(220, 110, 110)
		local v5 = Color3.fromRGB(28, 30, 27)
		local v6 = Color3.fromRGB(48, 48, 48)

		local function findDraggingItemId() --[[ findDraggingItemId | Line: 4006 | Upvalues: p1 (copy) ]]
			local TransferLink = p1.TransferLink

			if not (TransferLink and TransferLink.ConnectedItemManagers) then
				return nil
			end

			for i, v in ipairs(TransferLink.ConnectedItemManagers) do
				local Items = v.Items

				if Items then
					for k, v2 in pairs(Items) do
						if v2.IsDragging and (v2.Metadata and v2.Metadata.ID) then
							return v2.Metadata.ID
						end
					end
				end
			end

			return nil
		end

		p1._chipHoverConn = RunService.RenderStepped:Connect(function() --[[ Line: 4022 | Upvalues: p1 (copy), findDraggingItemId (copy), t (copy), v1 (copy), v3 (copy), v5 (copy), v2 (copy), v4 (copy), v6 (copy) ]]
			local _barterChipGrids = p1._barterChipGrids

			if not _barterChipGrids then
				return
			end

			local v12 = false
			local v22 = nil

			for i, v in ipairs(_barterChipGrids) do
				local v32
				local v42 = v.GuiElement and v.GuiElement.Parent

				if v42 and v42:IsA("Frame") then
					if v.Highlights and (if next(v.Highlights) == nil then false else true) then
						if not v12 then
							v22, v12 = findDraggingItemId(), true
						end

						local v7 = v.Metadata and v.Metadata.BarterItemId

						v32 = if v22 and (v7 and v22 == v7) then "match" else "mismatch"
					else
						v32 = "none"
					end

					if v32 ~= t[v] then
						t[v] = v32

						if v32 == "match" then
							v42.BackgroundColor3 = v1
						elseif v32 == "mismatch" then
							v42.BackgroundColor3 = v3
						else
							v42.BackgroundColor3 = v5
						end

						local UIStroke = v42:FindFirstChildOfClass("UIStroke")

						if UIStroke then
							if v32 == "match" then
								UIStroke.Color = v2
								UIStroke.Thickness = 2

								continue
							end

							if v32 == "mismatch" then
								UIStroke.Color = v4
								UIStroke.Thickness = 2

								continue
							end

							UIStroke.Color = v6
							UIStroke.Thickness = 1
						end
					end
				end
			end
		end)
	end
end
function t._updateBarterChipCount(p1, p2, p3) --[[ _updateBarterChipCount | Line: 4073 | Upvalues: ReplicatedStorage (copy) ]]
	local _expansionMatsRow = p1._expansionMatsRow

	if not _expansionMatsRow then
		return
	end

	local v1 = _expansionMatsRow:FindFirstChild(p2 .. "Chip")

	if not v1 then
		return
	end

	local QuantityLabel = v1:FindFirstChild("QuantityLabel")

	if not QuantityLabel then
		return
	end

	local StashTierConfig = require(ReplicatedStorage:WaitForChild("StashTierConfig"))
	local ok, result = pcall(function() --[[ Line: 4082 | Upvalues: ReplicatedStorage (ref) ]]
		return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer()
	end)
	local v3 = StashTierConfig.GetBarterRequirements(if ok and result then (result.PremiumTier or 0) + (result.BarterTier or 0) else 0)
	local v4 = 0

	if v3 then
		for i, v in ipairs(v3) do
			if v.id == p2 then
				v4 = v.quantity

				break
			end
		end
	end

	QuantityLabel.Text = ("%s / %s"):format(p1:_formatBarterQty(p3), p1:_formatBarterQty(v4))
	QuantityLabel.TextColor3 = (if v4 <= p3 then true else false) and Color3.fromRGB(140, 220, 140) or Color3.fromRGB(160, 160, 160)
end
function t._formatBarterQty(p1, p2) --[[ _formatBarterQty | Line: 4101 ]]
	if type(p2) ~= "number" then
		return tostring(p2)
	end

	if p2 >= 1000 then
		return tostring(p2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end

	return tostring(p2)
end
function t._refreshExpansionPanel(p1) --[[ _refreshExpansionPanel | Line: 4116 ]]
	if not p1._expansionPanel then
		return
	end

	local v1 = if p1.SafezoneTier == "Full" and p1.SafezoneViewMode == "stash" then if p1.CurrentStoragePart == nil then true else false else false

	p1._expansionPanel.Visible = v1

	if v1 then
		p1:_refreshExpansionSizeIndicator()
		p1:_startBarterHoverPoll()
		task.defer(function() --[[ Line: 4130 | Upvalues: p1 (copy) ]]
			p1:_autoCollapseIfNoRoom()
		end)
	elseif p1._chipHoverConn then
		p1._chipHoverConn:Disconnect()
		p1._chipHoverConn = nil
	end

	if p1._expansionPosLoop then
		p1._expansionPosLoop:Disconnect()
		p1._expansionPosLoop = nil
	end

	if p1._gridResizeConn then
		p1._gridResizeConn:Disconnect()
		p1._gridResizeConn = nil
	end

	if not v1 then
		return
	end

	local RunService = game:GetService("RunService")
	local v2 = os.clock()

	p1._expansionPosLoop = RunService.Heartbeat:Connect(function() --[[ Line: 4149 | Upvalues: p1 (copy), v2 (copy) ]]
		p1:_positionExpansionPanelBelowGrid()

		if not (os.clock() - v2 > 1 and p1._expansionPosLoop) then
			return
		end

		p1._expansionPosLoop:Disconnect()
		p1._expansionPosLoop = nil
	end)

	if not (p1.StorageInventory and p1.StorageInventory.GuiElement) then
		return
	end

	p1._gridResizeConn = p1.StorageInventory.GuiElement:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 4159 | Upvalues: p1 (copy) ]]
		p1:_positionExpansionPanelBelowGrid()
		p1:_autoCollapseIfNoRoom()
	end)
end
function t._positionExpansionPanelBelowGrid(p1) --[[ _positionExpansionPanelBelowGrid | Line: 4169 ]]
	local _expansionPanel = p1._expansionPanel

	if not (_expansionPanel and (_expansionPanel.Visible and _expansionPanel.Parent)) then
		return
	end

	local v1 = p1.StorageInventory and p1.StorageInventory.GuiElement

	if not v1 then
		local CrateGridFrame = p1.CrateGridFrame

		if CrateGridFrame then
			for i, v in ipairs(CrateGridFrame:GetChildren()) do
				if v:IsA("CanvasGroup") then
					v1 = v

					break
				end
			end
		end
	end

	if not v1 then
		return
	end

	local Y = v1.AbsoluteSize.Y

	if Y < 16 then
		return
	end

	local v2 = _expansionPanel.Parent
	local Y3 = v2.AbsoluteSize.Y

	if p1._expansionPoppedOut then
		return
	end

	local v4 = if Y3 > 0 then (v1.AbsolutePosition.Y + Y + 12 - v2.AbsolutePosition.Y) / Y3 or 0.5 else 0.5

	_expansionPanel.AnchorPoint = Vector2.new(0.5, 0)
	_expansionPanel.Position = UDim2.new(0.5, 0, v4, 0)
end
function t._refreshExpandButton(p1) --[[ _refreshExpandButton | Line: 4205 ]]
	p1:_refreshExpansionPanel()
end
function t._onPremiumUpgradeClicked(p1) --[[ _onPremiumUpgradeClicked | Line: 4214 | Upvalues: ReplicatedStorage (copy), Players (copy) ]]
	local StashTierConfig = require(ReplicatedStorage:WaitForChild("StashTierConfig"))
	local ok, result = pcall(function() --[[ Line: 4216 | Upvalues: ReplicatedStorage (ref) ]]
		return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer()
	end)

	if (ok and result and result.PremiumTier or 0) + (ok and result and result.BarterTier or 0) >= (StashTierConfig.MAX_TIER or 7) then
		return
	end

	local v3 = StashTierConfig.PremiumStashDevProductId or 0

	if v3 == 0 then
		warn("[InventoryController] PremiumStashDevProductId not configured yet -- create the DevProduct on Roblox and wire its ID into StashTierConfig.")
	else
		local MarketplaceService = game:GetService("MarketplaceService")

		pcall(function() --[[ Line: 4230 | Upvalues: MarketplaceService (copy), Players (ref), v3 (copy) ]]
			MarketplaceService:PromptProductPurchase(Players.LocalPlayer, v3)
		end)
	end
end
function t._MagStateText(p1, p2) --[[ _MagStateText | Line: 4238 ]]
	if not p2 or p2 <= 0 then
		return "?", Color3.fromRGB(200, 200, 200)
	end

	if p1 <= 0 then
		return "Empty", Color3.fromRGB(220, 80, 80)
	end

	local v1 = p1 / p2

	if v1 >= 0.75 then
		return "Full", Color3.fromRGB(120, 220, 120)
	end

	if v1 < 0.25 then
		return "Low", Color3.fromRGB(255, 165, 50)
	end

	return "Partial", Color3.fromRGB(230, 210, 110)
end
function t.UpdateWeaponSlotDisplay(p1, p2, p3) --[[ UpdateWeaponSlotDisplay | Line: 4247 | Upvalues: ItemDatabase (copy), Players (copy), t (copy) ]]
	if not (p2 and p3) then
		return
	end

	local WeaponInfoStrip = p3:FindFirstChild("WeaponInfoStrip")

	if WeaponInfoStrip then
		WeaponInfoStrip:Destroy()
	end

	if not (p2.Item and p2.Item.Metadata) then
		return
	end

	local v1 = ItemDatabase.GetItemData(p2.Item.Metadata.ID)

	if not (v1 and v1.MagType) then
		return
	end

	local Character = Players.LocalPlayer.Character
	local v2 = 0
	local v3 = false
	local v4 = false

	if Character then
		local v5 = Character:FindFirstChild(v1.ToolName)

		if not v5 then
			local Backpack = Players.LocalPlayer:FindFirstChild("Backpack")

			if Backpack then
				v5 = Backpack:FindFirstChild(v1.ToolName)
			end
		end

		if v5 then
			v3 = true
			v4 = not v5:GetAttribute("MagUnloaded")
			v2 = v5:GetAttribute("CurrentMagRounds") or 0

			local Ammo = v5:FindFirstChild("Ammo")

			if Ammo then
				local MagAmmo = Ammo:FindFirstChild("MagAmmo")

				if MagAmmo then
					v2 = MagAmmo.Value
				end
			end
		end
	end

	local WeaponInfoStrip2 = Instance.new("Frame")

	WeaponInfoStrip2.Name = "WeaponInfoStrip"
	WeaponInfoStrip2.Size = UDim2.new(1, 0, 0, 18)
	WeaponInfoStrip2.Position = UDim2.new(0, 0, 1, 0)
	WeaponInfoStrip2.AnchorPoint = Vector2.new(0, 1)
	WeaponInfoStrip2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	WeaponInfoStrip2.BackgroundTransparency = 0.5
	WeaponInfoStrip2.BorderSizePixel = 0
	WeaponInfoStrip2.ZIndex = 10
	WeaponInfoStrip2.Parent = p3

	local WeaponRoundsLabel = Instance.new("TextLabel")

	WeaponRoundsLabel.Name = "WeaponRoundsLabel"
	WeaponRoundsLabel.Size = UDim2.new(0, 70, 1, 0)
	WeaponRoundsLabel.Position = UDim2.new(0, 4, 0, 0)
	WeaponRoundsLabel.BackgroundTransparency = 1
	WeaponRoundsLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
	WeaponRoundsLabel.TextSize = 16
	WeaponRoundsLabel.TextXAlignment = Enum.TextXAlignment.Left
	WeaponRoundsLabel.ZIndex = 11
	WeaponRoundsLabel.Parent = WeaponInfoStrip2

	if v4 and v2 > 0 then
		local v8, v9 = t._MagStateText(v2, v1.magazineCapacity or v1.maxRounds)

		WeaponRoundsLabel.Text = v8
		WeaponRoundsLabel.TextColor3 = v9
		WeaponRoundsLabel.Visible = true
	else
		WeaponRoundsLabel.Visible = false
	end

	if not v3 then
		return
	end

	local WeaponLoadedLabel = Instance.new("TextLabel")

	WeaponLoadedLabel.Name = "WeaponLoadedLabel"
	WeaponLoadedLabel.Size = UDim2.new(0, 90, 1, 0)
	WeaponLoadedLabel.Position = UDim2.new(1, -4, 0, 0)
	WeaponLoadedLabel.AnchorPoint = Vector2.new(1, 0)
	WeaponLoadedLabel.BackgroundTransparency = 1
	WeaponLoadedLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
	WeaponLoadedLabel.TextSize = 16
	WeaponLoadedLabel.TextXAlignment = Enum.TextXAlignment.Right
	WeaponLoadedLabel.ZIndex = 11
	WeaponLoadedLabel.Parent = WeaponInfoStrip2

	if not v4 then
		WeaponLoadedLabel.Text = "Unloaded"
		WeaponLoadedLabel.TextColor3 = Color3.fromRGB(170, 170, 170)

		return
	end

	if v2 > 0 then
		WeaponLoadedLabel.Text = "Loaded"
		WeaponLoadedLabel.TextColor3 = Color3.fromRGB(120, 200, 120)

		return
	end

	WeaponLoadedLabel.Text = "Empty"
	WeaponLoadedLabel.TextColor3 = Color3.fromRGB(220, 80, 80)
end
function t.StartWeaponAmmoWatcher(p1) --[[ StartWeaponAmmoWatcher | Line: 4351 | Upvalues: Players (copy) ]]
	if not p1._ammoWatcherRunning then
		p1._ammoWatcherRunning = true
		task.spawn(function() --[[ Line: 4355 | Upvalues: p1 (copy), Players (ref) ]]
			while p1._ammoWatcherRunning do
				task.wait(0.5)

				local Character = Players.LocalPlayer.Character

				if not Character then
					continue
				end

				if p1.PrimarySlot and p1.PrimarySlot.Item then
					local v1 = if Character then Players.LocalPlayer.PlayerGui and (Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui") and Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.CharacterFrame:FindFirstChild("PrimaryFrame")) else Character

					if v1 then
						p1:UpdateWeaponSlotDisplay(p1.PrimarySlot, v1)
					end
				end

				if p1.SecondarySlot and p1.SecondarySlot.Item then
					local v2 = if Character then Players.LocalPlayer.PlayerGui and (Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui") and Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.CharacterFrame:FindFirstChild("SecondaryFrame")) else Character

					if v2 then
						p1:UpdateWeaponSlotDisplay(p1.SecondarySlot, v2)
					end
				end

				if not (p1.SidearmSlot and p1.SidearmSlot.Item) then
					continue
				end

				local v3 = if Character then Players.LocalPlayer.PlayerGui and (Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui") and Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.CharacterFrame:FindFirstChild("SidearmFrame")) else Character

				if not v3 then
					continue
				end

				p1:UpdateWeaponSlotDisplay(p1.SidearmSlot, v3)
			end
		end)
	end
end
function t._setUIInputLock(p1, p2) --[[ _setUIInputLock | Line: 4413 | Upvalues: Players (copy) ]]
	local LocalPlayer = Players.LocalPlayer
	local v1 = if p2 then true else false

	LocalPlayer:SetAttribute("UIInputLocked", v1)

	if p1._uiLockToolConn then
		p1._uiLockToolConn:Disconnect()
		p1._uiLockToolConn = nil
	end

	if not v1 then
		return
	end

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		p1._uiLockToolConn = Character.ChildAdded:Connect(function(p13) --[[ Line: 4431 | Upvalues: LocalPlayer (copy), Character (copy) ]]
			if not p13:IsA("Tool") then
				return
			end

			if LocalPlayer:GetAttribute("UIInputLocked") == true then
				task.defer(function() --[[ Line: 4434 | Upvalues: LocalPlayer (ref), Character (ref) ]]
					if LocalPlayer:GetAttribute("UIInputLocked") ~= true then
						return
					end

					local Humanoid = Character:FindFirstChildOfClass("Humanoid")

					if not Humanoid then
						return
					end

					Humanoid:UnequipTools()
				end)
			end
		end)

		return
	end

	Humanoid:UnequipTools()
	p1._uiLockToolConn = Character.ChildAdded:Connect(function(p13) --[[ Line: 4431 | Upvalues: LocalPlayer (copy), Character (copy) ]]
		if not p13:IsA("Tool") then
			return
		end

		if LocalPlayer:GetAttribute("UIInputLocked") == true then
			task.defer(function() --[[ Line: 4434 | Upvalues: LocalPlayer (ref), Character (ref) ]]
				if LocalPlayer:GetAttribute("UIInputLocked") ~= true then
					return
				end

				local Humanoid = Character:FindFirstChildOfClass("Humanoid")

				if not Humanoid then
					return
				end

				Humanoid:UnequipTools()
			end)
		end
	end)
end
function t.EnsureBackpackGridSized(p1) --[[ EnsureBackpackGridSized | Line: 4442 | Upvalues: ItemDatabase (copy) ]]
	local v1 = p1.BackpackSlot and p1.BackpackSlot.Item
	local v2 = if v1 then v1.Metadata and v1.Metadata.ID else v1

	if not v2 then
		return false
	end

	local v3 = ItemDatabase.GetItemData(v2)
	local v4 = if v3 then v3.SlotSize else v3

	if not v4 then
		return false
	end

	local v5 = p1.MainInventory and p1.MainInventory.GridSize

	if v5 and (v5.X == v4.X and v5.Y == v4.Y) then
		return false
	end

	p1._loadedBackpackID = nil
	p1:UpdateBackpackGridSize(v2)

	return true
end
function t.EnsureChestRigGridSized(p1) --[[ EnsureChestRigGridSized | Line: 4465 | Upvalues: ItemDatabase (copy) ]]
	local v1 = p1.BodySlot and p1.BodySlot.Item
	local v2 = if v1 then v1.Metadata and v1.Metadata.ID else v1

	if not v2 then
		return false
	end

	local v3 = ItemDatabase.GetItemData(v2)
	local v4 = if v3 then v3.SlotSize else v3

	if not v4 then
		return false
	end

	local v5 = p1.ChestRigInventory and p1.ChestRigInventory.GridSize

	if v5 and (v5.X == v4.X and v5.Y == v4.Y) then
		return false
	end

	p1._loadedBodyID = nil
	p1:UpdateChestRigGridSize(v2)

	return true
end
function t.EnsureBattleBeltGridSized(p1) --[[ EnsureBattleBeltGridSized | Line: 4479 | Upvalues: ItemDatabase (copy) ]]
	local v1 = p1.BeltGearSlot and p1.BeltGearSlot.Item
	local v2 = if v1 then v1.Metadata and v1.Metadata.ID else v1

	if not v2 then
		return false
	end

	local v3 = ItemDatabase.GetItemData(v2)
	local v4 = if v3 then v3.SlotSize else v3

	if not v4 then
		return false
	end

	local v5 = p1.BattleBeltInventory and p1.BattleBeltInventory.GridSize

	if v5 and (v5.X == v4.X and v5.Y == v4.Y) then
		return false
	end

	p1._loadedBeltGearID = nil
	p1:UpdateBattleBeltGridSize(v2)

	return true
end
function t.UpdateBackpackGridSize(p1, p2) --[[ UpdateBackpackGridSize | Line: 4495 | Upvalues: ItemDatabase (copy), GridPack (copy), Players (copy) ]]
	local v1 = if p2 then ItemDatabase.GetItemData(p2) else p2
	local v2 = v1 and v1.SlotSize or Vector2.new(0, 0)

	if p2 ~= nil and (p1._loadedBackpackID == p2 and p1.MainInventory) then
		return
	end

	p1._loadedBackpackID = p2

	if p1.MainInventory then
		p1:ClearGridPackInventory(p1.MainInventory)

		if p1.MainInventory.GuiElement then
			p1.MainInventory.GuiElement:Destroy()
		end

		p1.MainInventory = nil
	end

	if v2.X <= 0 or v2.Y <= 0 then
		print("Backpack internal grid hidden - no backpack equipped")
		p1:UpdateInventoryCanvas()
		p1:RepositionInventorySections()

		return
	end

	if p1.BackpackSectionFrame then
		p1.BackpackSectionFrame.ClipsDescendants = false
	end

	if p1.BackpackGridFrame then
		p1.BackpackGridFrame.ClipsDescendants = false
	end

	local t = {
		Visible = true,
		SlotAspectRatio = 1,
		Parent = p1.BackpackGridFrame,
		Assets = {
			Slot = game.ReplicatedStorage.GridPack.Slot
		},
		GridSize = v2,
		Size = UDim2.fromScale(v2.X, v2.Y),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 0, 0)
	}
	local t2 = {
		TiedInstance = "BackpackInternal_" .. Players.LocalPlayer.UserId
	}

	t2.MaxItemWidth = if v1 then v1.MaxItemWidth or nil else nil
	t.Metadata = t2
	p1.MainInventory = GridPack.createGrid(t)
	p1:PatchGridForOversizedItems(p1.MainInventory)
	p1:StyleGridContainer(p1.MainInventory)
	p1.MainInventory.IsColliding = p1:CreateGridIsColliding()
	p1.MainInventory:ConnectTransferLink(p1.TransferLink)
	print(string.format("Backpack internal grid created - GridSize: %s", (tostring(v2))))
	p1:RepositionInventorySections()
	p1:UpdateInventoryCanvas()
end
function t.UpdateChestRigGridSize(p1, p2) --[[ UpdateChestRigGridSize | Line: 4560 | Upvalues: ItemDatabase (copy), ItemIconStyle (copy), GridPack (copy), Players (copy) ]]
	local v1 = if p2 then ItemDatabase.GetItemData(p2) else p2
	local v2 = v1 and v1.SlotSize or Vector2.new(0, 0)

	if p2 ~= nil and (p1._loadedBodyID == p2 and p1.ChestRigInventory) then
		return
	end

	p1._loadedBodyID = p2

	if p1.ChestRigInventory then
		p1:ClearGridPackInventory(p1.ChestRigInventory)

		if p1.ChestRigInventory.GuiElement then
			p1.ChestRigInventory.GuiElement:Destroy()
		end

		p1.ChestRigInventory = nil
	end

	if v1 and v1.ImageID then
		p1.ChestRigPattern.Image = v1.ImageID
		p1.ChestRigPattern.ImageTransparency = 0.15
		p1.ChestRigPattern.ScaleType = ItemIconStyle.ScaleTypeFor(v1)
		p1.ChestRigPattern.Visible = true
	else
		p1.ChestRigPattern.Visible = false
	end

	if v2.X <= 0 or v2.Y <= 0 then
		print("Chest rig internal grid hidden - no body gear equipped")
	else
		local t = {
			Visible = true,
			SlotAspectRatio = 1,
			Parent = p1.ChestRigGridFrame,
			Assets = {
				Slot = game.ReplicatedStorage.GridPack.Slot
			},
			GridSize = v2,
			Size = UDim2.fromScale(v2.X, v2.Y),
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.new(0, 0, 0, 0)
		}
		local t2 = {
			TiedInstance = "ChestRigInternal_" .. Players.LocalPlayer.UserId
		}

		t2.MaxItemWidth = v1 and v1.MaxItemWidth or nil
		t.Metadata = t2
		p1.ChestRigInventory = GridPack.createGrid(t)
		p1:PatchGridForOversizedItems(p1.ChestRigInventory)
		p1:StyleGridContainer(p1.ChestRigInventory)
		p1.ChestRigInventory.IsColliding = p1:CreateGridIsColliding()
		p1.ChestRigInventory:ConnectTransferLink(p1.TransferLink)

		if v1 and (v1.MaxItemWidth and p1.ChestRigInventory.GuiElement) then
			p1:AddPouchDividers(p1.ChestRigInventory, v2, v1.MaxItemWidth)
		end

		print(string.format("Chest rig internal grid created - GridSize: %s", (tostring(v2))))
	end

	p1:RepositionInventorySections()
end
function t.UpdateBattleBeltGridSize(p1, p2) --[[ UpdateBattleBeltGridSize | Line: 4620 | Upvalues: ItemDatabase (copy), GridPack (copy), Players (copy) ]]
	local v1 = if p2 then ItemDatabase.GetItemData(p2) else p2
	local v2 = v1 and v1.SlotSize or Vector2.new(0, 0)

	if p2 ~= nil and (p1._loadedBeltGearID == p2 and p1.BattleBeltInventory) then
		return
	end

	p1._loadedBeltGearID = p2

	if p1.BattleBeltInventory then
		p1:ClearGridPackInventory(p1.BattleBeltInventory)

		if p1.BattleBeltInventory.GuiElement then
			p1.BattleBeltInventory.GuiElement:Destroy()
		end

		p1.BattleBeltInventory = nil
	end

	if v2.X <= 0 or v2.Y <= 0 then
		for k, v in pairs(p1.BattleBeltGridFrame:GetChildren()) do
			if v:IsA("CanvasGroup") then
				v:Destroy()
			end
		end

		print("Battle belt internal grid hidden - no belt gear equipped")
	else
		local t = {
			Visible = true,
			SlotAspectRatio = 1,
			Parent = p1.BattleBeltGridFrame,
			Assets = {
				Slot = game.ReplicatedStorage.GridPack.Slot
			},
			GridSize = v2,
			Size = UDim2.fromScale(v2.X, v2.Y),
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.new(0, 0, 0, 0)
		}
		local t2 = {
			TiedInstance = "BattleBeltInternal_" .. Players.LocalPlayer.UserId
		}

		t2.MaxItemWidth = v1 and v1.MaxItemWidth or nil
		t.Metadata = t2
		p1.BattleBeltInventory = GridPack.createGrid(t)
		p1:PatchGridForOversizedItems(p1.BattleBeltInventory)
		p1:StyleGridContainer(p1.BattleBeltInventory)
		p1.BattleBeltInventory.IsColliding = p1:CreateGridIsColliding()
		p1.BattleBeltInventory:ConnectTransferLink(p1.TransferLink)

		if v1 and (v1.MaxItemWidth and p1.BattleBeltInventory.GuiElement) then
			p1:AddPouchDividers(p1.BattleBeltInventory, v2, v1.MaxItemWidth)
		end

		print(string.format("Battle belt internal grid created - GridSize: %s", (tostring(v2))))
	end

	p1:RepositionInventorySections()
end
function t.RepositionInventorySections(p1) --[[ RepositionInventorySections | Line: 4676 ]] end
function t._startLootAudio(p1) --[[ _startLootAudio | Line: 4686 | Upvalues: ReplicatedStorage (copy), pickSound (copy), Players (copy) ]]
	local InventorySounds = ReplicatedStorage:FindFirstChild("InventorySounds")
	local v2 = InventorySounds and InventorySounds:FindFirstChild("Looting")

	if v2 then
		local function playInside(p1) --[[ playInside | Line: 4692 | Upvalues: pickSound (ref), v2 (ref), Players (ref) ]]
			local v1 = pickSound(v2, p1)

			if v1 then
				local v22 = v1:Clone()

				v22.Parent = Players.LocalPlayer.PlayerGui
				v22:Play()
				v22.Ended:Once(function() --[[ Line: 4698 | Upvalues: v22 (copy) ]]
					v22:Destroy()
				end)
				task.delay(3, function() --[[ Line: 4699 | Upvalues: v22 (copy) ]]
					if not v22.Parent then
						return
					end

					v22:Destroy()
				end)
			end
		end

		local t = {}

		for i, v in ipairs(v2:GetChildren()) do
			if v:IsA("Sound") and (v.Name:sub(1, 9) == "Searching" and v.SoundId ~= "") then
				table.insert(t, v.Name)
			end
		end

		local function playRandomSearch() --[[ playRandomSearch | Line: 4708 | Upvalues: t (copy), playInside (copy) ]]
			if #t ~= 0 then
				playInside(t[math.random(1, #t)])
			end
		end

		if #t ~= 0 then
			playInside(t[math.random(1, #t)])
		end

		p1._lootRummageActive = true
		task.delay(0.7, function() --[[ Line: 4722 | Upvalues: p1 (copy), playInside (copy) ]]
			if not p1._lootRummageActive then
				return
			end

			local count = 0

			if p1.StorageInventory and p1.StorageInventory.Items then
				for k in pairs(p1.StorageInventory.Items) do
					count = count + 1
				end
			end

			if not (count > 0) then
				return
			end

			playInside("Reveal")
		end)
		task.spawn(function() --[[ Line: 4731 | Upvalues: p1 (copy), t (copy), playInside (copy) ]]
			local count = 0

			if p1.StorageInventory and p1.StorageInventory.Items then
				for k in pairs(p1.StorageInventory.Items) do
					count = count + 1
				end
			end

			local v1 = os.clock() + math.random(3, 5)

			while p1._lootRummageActive do
				task.wait(0.4)

				if not p1._lootRummageActive then
					break
				end

				local v2 = os.clock()
				local count2 = 0

				if p1.StorageInventory and p1.StorageInventory.Items then
					for k in pairs(p1.StorageInventory.Items) do
						count2 = count2 + 1
					end
				end

				if count2 < count then
					if #t ~= 0 then
						playInside(t[math.random(1, #t)])
					end

					v1 = v2 + math.random(3, 5)
				end

				if v1 <= v2 then
					if #t ~= 0 then
						playInside(t[math.random(1, #t)])
					end

					v1 = v2 + math.random(3, 5)
				end

				count = count2
			end
		end)
	end
end
function t.CloseStorage(p1) --[[ CloseStorage | Line: 4758 | Upvalues: ReplicatedStorage (copy), Players (copy) ]]
	p1._lootRummageActive = false

	local OpenableContainer = require(ReplicatedStorage:WaitForChild("OpenableContainer"))
	local v1 = p1.StorageInventory and p1.StorageInventory.Metadata and p1.StorageInventory.Metadata.TiedInstance

	OpenableContainer.CloseForParent(v1)

	if p1.CurrentBodyTied and p1.CurrentBodyTied ~= v1 then
		OpenableContainer.CloseForParent(p1.CurrentBodyTied)
	end

	if p1.SellPanelFrame then
		pcall(function() --[[ Line: 4781 | Upvalues: ReplicatedStorage (ref) ]]
			ReplicatedStorage.Remotes.CloseTrader:FireServer()
		end)
		p1:DestroySellPanel()
		task.delay(0.15, function() --[[ Line: 4783 | Upvalues: p1 (copy) ]]
			p1:RefreshAllPlayerInventories()
		end)
	end

	if p1.BuyCartFrame then
		p1:DestroyBuyCart()
	end

	if p1.CartPanelFrame then
		p1:DestroyCartPanel()
	end

	p1.CurrentTraderNPC = nil
	p1.CurrentTraderProfile = nil

	if p1.StorageInventory then
		p1.StorageInventory:SetVisibility(false)
		p1:ClearGridPackInventory(p1.StorageInventory)

		if p1.StorageInventory.Metadata then
			p1.StorageInventory.Metadata.TiedInstance = nil
		end
	end

	local BodyScroll = p1.CrateGridFrame:FindFirstChild("BodyScroll")

	if BodyScroll then
		BodyScroll:Destroy()
	end

	local isNotCurrentStoragePart = p1.CurrentStoragePart ~= nil

	p1.CurrentStoragePart = nil

	if p1.CurrentBodyTied then
		ReplicatedStorage.Remotes.ReleaseBodyLock:FireServer(p1.CurrentBodyTied)
		p1.CurrentBodyTied = nil
	end

	pcall(function() --[[ Line: 4816 | Upvalues: ReplicatedStorage (ref) ]]
		ReplicatedStorage.Remotes.StorageInventoryClosed:FireServer()
	end)

	local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

	if not (isNotCurrentStoragePart and (InventoryGui and InventoryGui.Enabled)) then
		return
	end

	p1:LoadVicinity()
end
function t.LoadVicinity(p1) --[[ LoadVicinity | Line: 4827 | Upvalues: Players (copy), ReplicatedStorage (copy), GridPack (copy) ]]
	local isSafezoneTier = p1.SafezoneTier == "Full"
	local v1 = if isSafezoneTier then if p1.SafezoneViewMode == "stash" then true else false else isSafezoneTier

	Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.ContainerFrame.CrateFrame.Title.TextLabel.Text = if v1 then "PERSONAL STASH" else "VICINITY"
	p1._vicinityEpoch = (p1._vicinityEpoch or 0) + 1

	local _vicinityEpoch = p1._vicinityEpoch

	os.clock()

	local v3 = nil

	if v1 then
		local ok, result = pcall(function() --[[ Line: 4878 | Upvalues: ReplicatedStorage (ref) ]]
			return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer()
		end)

		if p1._vicinityEpoch ~= _vicinityEpoch then
			return
		end

		if ok and result then
			v3 = result
		end
	end

	if not v3 then
		local v4 = ReplicatedStorage.Remotes.GetVicinityItems:InvokeServer()

		if p1._vicinityEpoch ~= _vicinityEpoch then
			return
		end

		v3 = v4
	end

	if not (v3 and v3.Items) then
		v3 = {
			Items = {},
			GridSize = v1 and Vector2.new(4, 4) or Vector2.new(7, 12),
			TiedInstance = v1 and "Stash_" .. Players.LocalPlayer.UserId or "Vicinity_" .. Players.LocalPlayer.UserId
		}
	end

	if p1.StorageInventory and (p1.StorageInventory.Metadata and (p1.StorageInventory.Metadata.TiedInstance == v3.TiedInstance and (p1.StorageInventory.GridSize and (v3.GridSize and (p1.StorageInventory.GridSize.X == v3.GridSize.X and p1.StorageInventory.GridSize.Y == v3.GridSize.Y))))) then
		p1:LoadInventory(p1.StorageInventory, v3)
	else
		if p1.StorageInventory then
			p1:ClearGridPackInventory(p1.StorageInventory)

			if p1.StorageInventory.GuiElement then
				p1.StorageInventory.GuiElement:Destroy()
			end

			p1.StorageInventory = nil
		end

		for k, v in pairs(p1.CrateGridFrame:GetChildren()) do
			if v:IsA("CanvasGroup") then
				v:Destroy()
			end
		end

		local v7 = false

		for k, v in pairs(v3.Items) do
			if v then
				v7 = true

				break
			end
		end

		if v7 then
			local v8 = v3.GridSize or Vector2.new(4, 4)

			p1.StorageInventory = GridPack.createGrid({
				Visible = true,
				SlotAspectRatio = 1,
				Parent = p1.CrateGridFrame,
				Assets = {
					Slot = game.ReplicatedStorage.GridPack.Slot
				},
				GridSize = v8,
				Size = UDim2.fromScale(v8.X, v8.Y),
				AnchorPoint = Vector2.new(0, 0),
				Position = UDim2.new(0, 0, 0, 0),
				Metadata = {
					TiedInstance = v3.TiedInstance
				}
			})
			p1:PatchGridForOversizedItems(p1.StorageInventory)
			p1:StyleGridContainer(p1.StorageInventory)
			p1.StorageInventory.IsColliding = p1:CreateGridIsColliding()
			p1.StorageInventory:ConnectTransferLink(p1.TransferLink)
			p1:LoadInventory(p1.StorageInventory, v3)
		else
			local v9 = v3.GridSize or Vector2.new(7, 12)

			p1.StorageInventory = GridPack.createGrid({
				Visible = true,
				SlotAspectRatio = 1,
				Parent = p1.CrateGridFrame,
				Assets = {
					Slot = game.ReplicatedStorage.GridPack.Slot
				},
				GridSize = v9,
				Size = UDim2.fromScale(v9.X, v9.Y),
				AnchorPoint = Vector2.new(0, 0),
				Position = UDim2.new(0, 0, 0, 0),
				Metadata = {
					TiedInstance = v3.TiedInstance
				}
			})
			p1:PatchGridForOversizedItems(p1.StorageInventory)
			p1:StyleGridContainer(p1.StorageInventory)
			p1.StorageInventory.IsColliding = p1:CreateGridIsColliding()
			p1.StorageInventory:ConnectTransferLink(p1.TransferLink)
		end
	end

	if not (p1._expansionPanel and p1._expansionPanel.Visible) then
		return
	end

	p1:_refreshExpansionPanel()
end
function t.OpenBodyLoot(p1, p2) --[[ OpenBodyLoot | Line: 5039 | Upvalues: ReplicatedStorage (copy), Players (copy), UserInputService (copy), GridPack (copy) ]]
	local v1 = ReplicatedStorage.Remotes.LootBody:InvokeServer(p2)

	if v1 and v1.ok then
		local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

		if InventoryGui and not InventoryGui.Enabled then
			InventoryGui.Enabled = true

			local InventoryBlur = game.Lighting:FindFirstChild("InventoryBlur")

			if InventoryBlur then
				InventoryBlur.Enabled = true
			end

			require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():Disable()
			p1._savedCameraMode = Players.LocalPlayer.CameraMode
			Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic

			if p1._mouseUnlockConn then
				p1._mouseUnlockConn:Disconnect()
				p1._mouseUnlockConn = nil
			end

			p1._mouseUnlockConn = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 5069 | Upvalues: UserInputService (ref) ]]
				if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				end

				if UserInputService.MouseIconEnabled then
					return
				end

				UserInputService.MouseIconEnabled = true
			end)
		end

		p1.CurrentStoragePart = p2
		p1.CurrentBodyTied = v1.tiedInstance
		Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.ContainerFrame.CrateFrame.Title.TextLabel.Text = string.upper(v1.victimName) .. "\'S BODY"

		if p1.StorageInventory then
			p1:ClearGridPackInventory(p1.StorageInventory)

			if p1.StorageInventory.GuiElement then
				p1.StorageInventory.GuiElement:Destroy()
			end

			p1.StorageInventory = nil
		end

		for k, v in pairs(p1.CrateGridFrame:GetChildren()) do
			if v:IsA("CanvasGroup") then
				v:Destroy()
			end
		end

		local BodyScroll = p1.CrateGridFrame:FindFirstChild("BodyScroll")

		if BodyScroll then
			BodyScroll:Destroy()
		end

		local gridSize = v1.gridSize
		local CrateGridFrame = p1.CrateGridFrame
		local v2 = UDim2.fromScale(gridSize.X, gridSize.Y)

		if gridSize.Y > 10 then
			local BodyScroll2 = Instance.new("ScrollingFrame")

			BodyScroll2.Name = "BodyScroll"
			BodyScroll2.BackgroundTransparency = 1
			BodyScroll2.BorderSizePixel = 0
			BodyScroll2.ClipsDescendants = true
			BodyScroll2.Active = true
			BodyScroll2.ScrollingDirection = Enum.ScrollingDirection.Y
			BodyScroll2.ScrollBarThickness = 6
			BodyScroll2.ScrollBarImageTransparency = 0.4
			BodyScroll2.CanvasSize = UDim2.new()
			BodyScroll2.AutomaticCanvasSize = Enum.AutomaticSize.Y
			BodyScroll2.Size = UDim2.fromScale(gridSize.X, 10)
			BodyScroll2.Position = UDim2.new(0, 0, 0, 0)
			BodyScroll2.Parent = p1.CrateGridFrame
			CrateGridFrame, v2 = BodyScroll2, UDim2.fromScale(1, gridSize.Y / 10)
		end

		p1.StorageInventory = GridPack.createGrid({
			Visible = true,
			SlotAspectRatio = 1,
			Parent = CrateGridFrame,
			Assets = {
				Slot = game.ReplicatedStorage.GridPack.Slot
			},
			GridSize = v1.gridSize,
			Size = v2,
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.new(0, 0, 0, 0),
			Metadata = {
				TiedInstance = v1.tiedInstance
			}
		})
		p1:PatchGridForOversizedItems(p1.StorageInventory)
		p1:StyleGridContainer(p1.StorageInventory)
		p1.StorageInventory.IsColliding = p1:CreateGridIsColliding()
		p1.StorageInventory:ConnectTransferLink(p1.TransferLink)
		p1:LoadInventory(p1.StorageInventory, {
			Items = v1.items,
			GridSize = v1.gridSize,
			TiedInstance = v1.tiedInstance
		})
		p1:_startLootAudio()
	else
		local v4 = v1 and v1.reason or "missing"

		if v4:sub(1, 10) == "locked_by:" then
			p1:ShowToast("Being looted by " .. v4:sub(11))
		else
			p1:ShowToast("Body is gone")
		end
	end
end
function t.DestroyBuyCart(p1) --[[ DestroyBuyCart | Line: 5179 ]]
	if p1.BuyCartFrame then
		p1.BuyCartFrame:Destroy()
	end

	p1.BuyCartFrame = nil
	p1.BuyCartList = nil
	p1.BuyCartTotalLabel = nil
	p1.BuyCart = {}
	p1:_destroyCartGhosts()
end
function t._destroyCartGhosts(p1) --[[ _destroyCartGhosts | Line: 5188 ]]
	local v1 = ipairs

	for v3, v4 in v1(p1.BuyCartGhosts or {}) do
		if v4 and (v4.ghost and v4.ghost.Parent) then
			v4.ghost:Destroy()
		end
	end

	p1.BuyCartGhosts = {}
end
function t._predictCartGhostSlots(p1) --[[ _predictCartGhostSlots | Line: 5198 | Upvalues: dbgCartGhost (copy), ItemDatabase (copy) ]]
	local v1 = p1.BuyCart or {}

	if #v1 == 0 then
		return {}
	end

	local list = {
		{
			name = "Pockets",
			g = p1.LocalInventory
		},
		{
			name = "ChestRig",
			g = p1.ChestRigInventory
		},
		{
			name = "Belt",
			g = p1.BattleBeltInventory
		},
		{
			name = "Backpack",
			g = p1.MainInventory
		}
	}
	local t = {}

	for i, v in ipairs(list) do
		local g = v.g

		if g and g.GridSize then
			t[g] = {}

			if g.Items then
				for k, v2 in pairs(g.Items) do
					if v2 and v2.Metadata then
						local format = string.format

						dbgCartGhost(format("[Ghost] %s tile[%s] id=%s pos=%s metadataPos=%s", v.name, tostring(k), tostring(v2.Metadata.ID), tostring(v2.Position), (tostring(v2.Metadata.Position))))
					end

					if v2 and (v2.Metadata and v2.Position) then
						local v6 = ItemDatabase.GetItemData(v2.Metadata.ID)

						if v6 and v6.Size then
							local X = v2.Position.X
							local Y = v2.Position.Y
							local v7 = if v2.Rotation == 1 or (v2.Rotation == 3 or v2.Rotation == 90) then true else v2.Rotation == 270
							local X2 = v6.Size.X
							local Y2 = v6.Size.Y

							if v7 then
								Y2, X2 = X2, Y2
							end

							for i2 = 0, Y2 - 1 do
								for j = 0, X2 - 1 do
									t[g][X + j .. "," .. Y + i2] = true
								end
							end
						end
					end
				end
			end
		end
	end

	local t2 = {
		HeadGear = p1.HeadSlot,
		FaceWear = p1.FaceWearSlot,
		EyeWear = p1.EyeWearSlot,
		BodyGear = p1.BodySlot,
		BeltGear = p1.BeltGearSlot,
		Primary = p1.PrimarySlot,
		Secondary = p1.SecondarySlot,
		Sidearm = p1.SidearmSlot,
		Melee = p1.MeleeSlot,
		Uniform = p1.UniformSlot,
		Backpack = p1.BackpackSlot,
		NightOptical = p1.NightOpticalSlot
	}

	local function fitsAt(p1, p2, p3) --[[ fitsAt | Line: 5249 | Upvalues: t (copy) ]]
		if p2.X < 0 or p2.Y < 0 then
			return false
		end

		if p1.GridSize.X < p2.X + p3.X or p1.GridSize.Y < p2.Y + p3.Y then
			return false
		end

		for i = 0, p3.Y - 1 do
			for j = 0, p3.X - 1 do
				if t[p1][p2.X + j .. "," .. p2.Y + i] then
					return false
				end
			end
		end

		return true
	end

	local function markOccupied(p1, p2, p3) --[[ markOccupied | Line: 5260 | Upvalues: t (copy) ]]
		for i = 0, p3.Y - 1 do
			for j = 0, p3.X - 1 do
				t[p1][p2.X + j .. "," .. p2.Y + i] = true
			end
		end
	end

	local t3 = {}
	local t4 = {}

	for i, v in ipairs(v1) do
		local v8 = ItemDatabase.GetItemData(v.itemID)

		if v8 and v8.Size then
			for k = 1, v.qty or 1 do
				local v9 = false
				local v10 = t2[v8.ItemType]

				if not (if v10 then not v10.Item and not t3[v10] else v10) and v8.ItemType == "Primary" then
					v10 = t2.Secondary
				end

				if if v10 then not v10.Item and not t3[v10] else v10 then
					t3[v10] = true
					table.insert(t4, {
						slot = v10,
						dbInfo = v8,
						cartIndex = i
					})
					v9 = true
				end

				if not v9 and (({
					Backpack = true,
					BodyGear = true,
					BeltGear = true
				})[v8.ItemType] and (v10 and (v10.Item and not t3[v10]))) then
					t3[v10] = true
					table.insert(t4, {
						isSwap = true,
						slot = v10,
						dbInfo = v8,
						cartIndex = i
					})
					v9 = true
				end

				if not v9 then
					if v.preferredGrid and (v.preferredPos and (t[v.preferredGrid] and fitsAt(v.preferredGrid, v.preferredPos, v8.Size))) then
						markOccupied(v.preferredGrid, v.preferredPos, v8.Size)
						table.insert(t4, {
							grid = v.preferredGrid,
							position = v.preferredPos,
							dbInfo = v8,
							cartIndex = i
						})
						v9 = true
					end

					if not v9 then
						for i2, v2 in ipairs(list) do
							if v9 then
								break
							end

							local g = v2.g

							if g and (g.GridSize and t[g]) then
								local X = g.GridSize.X
								local Y = g.GridSize.Y
								local v13 = g.Metadata and g.Metadata.MaxItemWidth
								local X2 = v8.Size.X
								local Y2 = v8.Size.Y
								local v14 = 0
								local v15 = true

								if v13 and (v13 < X2 and v13 < Y2) then
									v15 = false
								elseif v13 and v13 < X2 then
									X2, Y2, v14 = Y2, X2, 1
								end

								if v15 then
									for n = 0, Y - 1 do
										if v9 then
											break
										end

										for m = 0, X - 1 do
											if m + X2 <= X and n + Y2 <= Y then
												local v16 = true

												for i3 = 0, Y2 - 1 do
													for i4 = 0, X2 - 1 do
														if t[g][m + i4 .. "," .. n + i3] then
															v16 = false

															break
														end
													end

													if not v16 then
														break
													end
												end

												if v16 then
													for i3 = 0, Y2 - 1 do
														for i4 = 0, X2 - 1 do
															t[g][m + i4 .. "," .. n + i3] = true
														end
													end

													table.insert(t4, {
														grid = g,
														position = Vector2.new(m, n),
														dbInfo = v8,
														cartIndex = i,
														rotation = v14
													})
													v9 = true

													break
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return t4
end
function t.RefreshCartGhosts(p1) --[[ RefreshCartGhosts | Line: 5372 | Upvalues: ScaleTypeFor (copy) ]]
	p1:_destroyCartGhosts()

	for i, v in ipairs((p1:_predictCartGhostSlots())) do
		if v.slot then
			local GuiElement = v.slot.GuiElement
			local v2 = if GuiElement then GuiElement.Parent else GuiElement

			if v2 then
				local BuyGhost = Instance.new("TextButton")

				BuyGhost.Name = "BuyGhost"
				BuyGhost.Text = ""
				BuyGhost.AutoButtonColor = false
				BuyGhost.AnchorPoint = Vector2.new(0, 0)
				BuyGhost.Position = UDim2.new(0, 0, 0, 0)
				BuyGhost.Size = UDim2.new(1, 0, 1, 0)
				BuyGhost.BackgroundColor3 = v.isSwap and Color3.fromRGB(70, 150, 185) or Color3.fromRGB(255, 220, 130)
				BuyGhost.BackgroundTransparency = 0.4
				BuyGhost.BorderSizePixel = 0
				BuyGhost.ZIndex = 50
				BuyGhost.Active = true
				BuyGhost.Parent = v2

				local UIStroke = Instance.new("UIStroke")

				UIStroke.Color = v.isSwap and Color3.fromRGB(140, 210, 235) or Color3.fromRGB(240, 220, 130)
				UIStroke.Thickness = 2
				UIStroke.Transparency = 0.1
				UIStroke.Parent = BuyGhost

				if v.dbInfo.ImageID and v.dbInfo.ImageID ~= "" then
					local ImageLabel = Instance.new("ImageLabel")

					ImageLabel.Size = UDim2.new(1, -4, 1, -4)
					ImageLabel.Position = UDim2.new(0, 2, 0, 2)
					ImageLabel.BackgroundTransparency = 1
					ImageLabel.Image = v.dbInfo.ImageID
					ImageLabel.ImageTransparency = 0.45
					ImageLabel.ScaleType = ScaleTypeFor(v.dbInfo)
					ImageLabel.Active = false
					ImageLabel.ZIndex = 51
					ImageLabel.Parent = BuyGhost
				end

				if v.isSwap then
					local SwapIcon = Instance.new("ImageLabel")

					SwapIcon.Name = "SwapIcon"
					SwapIcon.AnchorPoint = Vector2.new(0.5, 0.5)
					SwapIcon.Position = UDim2.fromScale(0.5, 0.5)
					SwapIcon.Size = UDim2.fromScale(0.55, 0.55)
					SwapIcon.BackgroundTransparency = 1
					SwapIcon.Image = "rbxassetid://136287433764119"
					SwapIcon.ScaleType = Enum.ScaleType.Fit
					SwapIcon.Active = false
					SwapIcon.ZIndex = 52
					SwapIcon.Parent = BuyGhost
				end

				local cartIndex = v.cartIndex

				BuyGhost.MouseButton2Click:Connect(function() --[[ Line: 5433 | Upvalues: p1 (copy), cartIndex (copy) ]]
					local v1 = p1.BuyCart and p1.BuyCart[cartIndex]

					if not v1 then
						return
					end

					if (v1.qty or 1) > 1 then
						v1.qty = v1.qty - 1
					else
						table.remove(p1.BuyCart, cartIndex)
					end

					p1:RefreshBuyCartRender()
				end)
				p1.BuyCartGhosts = p1.BuyCartGhosts or {}
				table.insert(p1.BuyCartGhosts, {
					ghost = BuyGhost,
					slot = v.slot
				})
			end

			continue
		end

		local GuiElement = v.grid.GuiElement

		if GuiElement and GuiElement.AbsoluteSize.X > 0 then
			local X2 = v.dbInfo.Size.X
			local Y2 = v.dbInfo.Size.Y

			if v.rotation == 1 then
				X2, Y2 = Y2, X2
			end

			local v6 = GuiElement.AbsoluteSize.X / v.grid.GridSize.X
			local v7 = GuiElement.AbsoluteSize.Y / v.grid.GridSize.Y
			local v8 = v.position.X * v6
			local v9 = v.position.Y * v7
			local v10 = X2 * v6
			local v11 = Y2 * v7
			local v12 = GuiElement.Parent

			if v12 then
				local AbsoluteSize = v12.AbsoluteSize
				local BuyGhost = Instance.new("TextButton")

				BuyGhost.Name = "BuyGhost"
				BuyGhost.Text = ""
				BuyGhost.AutoButtonColor = false
				BuyGhost.AnchorPoint = Vector2.new(0, 0)
				BuyGhost.Position = UDim2.fromOffset(GuiElement.AbsolutePosition.X - v12.AbsolutePosition.X + v8, GuiElement.AbsolutePosition.Y - v12.AbsolutePosition.Y + v9)
				BuyGhost.Size = UDim2.fromOffset(v10, v11)
				BuyGhost.BackgroundColor3 = Color3.fromRGB(255, 220, 130)
				BuyGhost.BackgroundTransparency = 0.4
				BuyGhost.BorderSizePixel = 0
				BuyGhost.ZIndex = 50
				BuyGhost.Active = true
				BuyGhost.Parent = v12

				local cartIndex = v.cartIndex

				BuyGhost.MouseButton2Click:Connect(function() --[[ Line: 5492 | Upvalues: p1 (copy), cartIndex (copy) ]]
					local v1 = p1.BuyCart and p1.BuyCart[cartIndex]

					if not v1 then
						return
					end

					if (v1.qty or 1) > 1 then
						v1.qty = v1.qty - 1
					else
						table.remove(p1.BuyCart, cartIndex)
					end

					p1:RefreshBuyCartRender()
				end)

				local UIStroke = Instance.new("UIStroke")

				UIStroke.Color = Color3.fromRGB(240, 220, 130)
				UIStroke.Thickness = 2
				UIStroke.Transparency = 0.1
				UIStroke.Parent = BuyGhost

				if v.dbInfo.ImageID and v.dbInfo.ImageID ~= "" then
					local ImageLabel = Instance.new("ImageLabel")

					ImageLabel.Size = UDim2.new(1, -4, 1, -4)
					ImageLabel.Position = UDim2.new(0, 2, 0, 2)
					ImageLabel.BackgroundTransparency = 1
					ImageLabel.Image = v.dbInfo.ImageID
					ImageLabel.ImageTransparency = 0.45
					ImageLabel.ScaleType = ScaleTypeFor(v.dbInfo)
					ImageLabel.Active = false
					ImageLabel.ZIndex = 51
					ImageLabel.Parent = BuyGhost
				end

				p1.BuyCartGhosts = p1.BuyCartGhosts or {}
				table.insert(p1.BuyCartGhosts, {
					ghost = BuyGhost,
					grid = v.grid,
					position = v.position,
					size = v.dbInfo.Size
				})
			end
		end
	end
end
function t.DestroyCartPanel(p1) --[[ DestroyCartPanel | Line: 5535 ]]
	if p1.CartPanelFrame then
		p1.CartPanelFrame:Destroy()
	end

	p1.CartPanelFrame = nil
	p1.CartTabBuyContent = nil
	p1.CartTabSellContent = nil
	p1.CartTabBuyButton = nil
	p1.CartTabSellButton = nil
end
function t.SwitchCartTab(p1, p2) --[[ SwitchCartTab | Line: 5544 ]]
	p1.ActiveCartTab = p2

	if p1.CartTabBuyContent then
		p1.CartTabBuyContent.Visible = p2 == "Buy"
	end

	if p1.CartTabSellContent then
		p1.CartTabSellContent.Visible = p2 == "Sell"
	end

	local v3 = Color3.fromRGB(60, 60, 60)
	local v4 = Color3.fromRGB(28, 28, 28)

	if p1.CartTabBuyButton then
		p1.CartTabBuyButton.BackgroundColor3 = if p2 == "Buy" and v3 then v3 else v4
	end

	if not p1.CartTabSellButton then
		return
	end

	p1.CartTabSellButton.BackgroundColor3 = if p2 == "Sell" then if v3 then v3 else v4 else v4
end
function t.CreateCartPanel(p1) --[[ CreateCartPanel | Line: 5559 | Upvalues: Players (copy) ]]
	p1:DestroyCartPanel()

	local InventoryGui = Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("InventoryGui")

	if not InventoryGui then
		return
	end

	local ContainerFrame = InventoryGui.MainFrame:FindFirstChild("ContainerFrame")

	if not ContainerFrame then
		return
	end

	local v1 = 60

	if p1.CrateGridFrame then
		local AbsoluteSize = p1.CrateGridFrame.AbsoluteSize

		if AbsoluteSize and (AbsoluteSize.X > 0 and AbsoluteSize.Y > 0) then
			v1 = math.min(AbsoluteSize.X, AbsoluteSize.Y)
		end
	end

	local TraderCartPanel = Instance.new("Frame")

	TraderCartPanel.Name = "TraderCartPanel"
	TraderCartPanel.AnchorPoint = Vector2.new(0.5, 1)
	TraderCartPanel.Position = UDim2.new(0.5, 0, 1, 0)
	TraderCartPanel.Size = UDim2.new(1, 0, 0, v1 * 3 + 28 + 40 + 16 + 28)
	TraderCartPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	TraderCartPanel.BackgroundTransparency = 0.15
	TraderCartPanel.BorderSizePixel = 0
	TraderCartPanel.ZIndex = 30
	TraderCartPanel.Parent = ContainerFrame
	p1.CartPanelFrame = TraderCartPanel

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 28)
	Frame.BackgroundTransparency = 1
	Frame.ZIndex = 31
	Frame.Parent = TraderCartPanel

	local TextButton = Instance.new("TextButton")

	TextButton.Size = UDim2.new(0.5, 0, 1, 0)
	TextButton.Position = UDim2.new(0, 0, 0, 0)
	TextButton.BorderSizePixel = 0
	TextButton.Text = "BUY"
	TextButton.TextColor3 = Color3.fromRGB(240, 220, 130)
	TextButton.Font = Enum.Font.GothamBold
	TextButton.TextSize = 14
	TextButton.AutoButtonColor = false
	TextButton.ZIndex = 32
	TextButton.Parent = Frame
	p1.CartTabBuyButton = TextButton

	local TextButton2 = Instance.new("TextButton")

	TextButton2.Size = UDim2.new(0.5, 0, 1, 0)
	TextButton2.Position = UDim2.new(0.5, 0, 0, 0)
	TextButton2.BorderSizePixel = 0
	TextButton2.Text = "SELL"
	TextButton2.TextColor3 = Color3.fromRGB(240, 220, 130)
	TextButton2.Font = Enum.Font.GothamBold
	TextButton2.TextSize = 14
	TextButton2.AutoButtonColor = false
	TextButton2.ZIndex = 32
	TextButton2.Parent = Frame
	p1.CartTabSellButton = TextButton2
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 5623 | Upvalues: p1 (copy) ]]
		p1:SwitchCartTab("Buy")
	end)
	TextButton2.MouseButton1Click:Connect(function() --[[ Line: 5624 | Upvalues: p1 (copy) ]]
		p1:SwitchCartTab("Sell")
	end)

	local BuyContent = Instance.new("Frame")

	BuyContent.Name = "BuyContent"
	BuyContent.Position = UDim2.new(0, 0, 0, 28)
	BuyContent.Size = UDim2.new(1, 0, 1, -28)
	BuyContent.BackgroundTransparency = 1
	BuyContent.ZIndex = 31
	BuyContent.Parent = TraderCartPanel
	p1.CartTabBuyContent = BuyContent

	local SellContent = Instance.new("Frame")

	SellContent.Name = "SellContent"
	SellContent.Position = UDim2.new(0, 0, 0, 28)
	SellContent.Size = UDim2.new(1, 0, 1, -28)
	SellContent.BackgroundTransparency = 1
	SellContent.ZIndex = 31
	SellContent.Parent = TraderCartPanel
	p1.CartTabSellContent = SellContent
	p1:SwitchCartTab("Buy")
end
function t.RefreshBuyCartRender(p1) --[[ RefreshBuyCartRender | Line: 5648 ]]
	if not p1.BuyCartList then
		return
	end

	for i, v in ipairs(p1.BuyCartList:GetChildren()) do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end

	local sum = 0
	local v1 = ipairs

	for v3, v4 in v1(p1.BuyCart or {}) do
		sum = sum + (v4.price or 0) * (v4.qty or 1)

		local Frame = Instance.new("Frame")

		Frame.Name = "CartRow_" .. v3
		Frame.Size = UDim2.new(1, -4, 0, 28)
		Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		Frame.BackgroundTransparency = 0.2
		Frame.BorderSizePixel = 0
		Frame.LayoutOrder = v3
		Frame.ZIndex = 32
		Frame.Parent = p1.BuyCartList

		local ImageLabel = Instance.new("ImageLabel")

		ImageLabel.Size = UDim2.new(0, 24, 0, 24)
		ImageLabel.Position = UDim2.new(0, 2, 0.5, 0)
		ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Image = v4.imageID or ""
		ImageLabel.ZIndex = 33
		ImageLabel.Parent = Frame

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.new(1, -120, 1, 0)
		TextLabel.Position = UDim2.new(0, 30, 0, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = (v4.name or v4.itemID) .. (v4.qty > 1 and " x" .. v4.qty or "")
		TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.Font = Enum.Font.RobotoMono
		TextLabel.TextSize = 13
		TextLabel.ZIndex = 33
		TextLabel.Parent = Frame

		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Size = UDim2.new(0, 80, 1, 0)
		TextLabel2.Position = UDim2.new(1, -110, 0, 0)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.Text = string.format("\226\130\189%d", (v4.price or 0) * (v4.qty or 1))
		TextLabel2.TextColor3 = Color3.fromRGB(240, 220, 130)
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Right
		TextLabel2.Font = Enum.Font.RobotoMono
		TextLabel2.TextSize = 13
		TextLabel2.ZIndex = 33
		TextLabel2.Parent = Frame

		local TextButton = Instance.new("TextButton")

		TextButton.Size = UDim2.new(0, 22, 1, -4)
		TextButton.Position = UDim2.new(1, -24, 0, 2)
		TextButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
		TextButton.BorderSizePixel = 0
		TextButton.Text = "X"
		TextButton.TextColor3 = Color3.fromRGB(255, 200, 200)
		TextButton.Font = Enum.Font.GothamBold
		TextButton.TextSize = 14
		TextButton.ZIndex = 34
		TextButton.Parent = Frame
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 5711 | Upvalues: p1 (copy), v3 (copy) ]]
			table.remove(p1.BuyCart, v3)
			p1:RefreshBuyCartRender()
		end)
	end

	if p1.BuyCartTotalLabel then
		p1.BuyCartTotalLabel.Text = string.format("TOTAL: \226\130\189%d", sum)
	end

	local UIListLayout = p1.BuyCartList:FindFirstChildOfClass("UIListLayout")

	if UIListLayout and p1.BuyCartList:IsA("ScrollingFrame") then
		p1.BuyCartList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 4)
	end

	p1:RefreshCartGhosts()
end
function t.CreateBuyCartPanel(p1, p2, p3) --[[ CreateBuyCartPanel | Line: 5727 | Upvalues: ReplicatedStorage (copy) ]]
	p1:DestroyBuyCart()
	p1.BuyCart = {}

	local CartTabBuyContent = p1.CartTabBuyContent

	if CartTabBuyContent then
		local TraderBuyCart = Instance.new("Frame")

		TraderBuyCart.Name = "TraderBuyCart"
		TraderBuyCart.Size = UDim2.new(1, 0, 1, 0)
		TraderBuyCart.BackgroundTransparency = 1
		TraderBuyCart.BorderSizePixel = 0
		TraderBuyCart.ZIndex = 30
		TraderBuyCart.Parent = CartTabBuyContent
		p1.BuyCartFrame = TraderBuyCart

		local CartList = Instance.new("ScrollingFrame")

		CartList.Name = "CartList"
		CartList.Position = UDim2.new(0, 4, 0, 4)
		CartList.Size = UDim2.new(1, -8, 1, -48)
		CartList.BackgroundTransparency = 1
		CartList.BorderSizePixel = 0
		CartList.ScrollBarThickness = 4
		CartList.ZIndex = 31
		CartList.Parent = TraderBuyCart

		local UIListLayout = Instance.new("UIListLayout")

		UIListLayout.Padding = UDim.new(0, 2)
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Parent = CartList
		p1.BuyCartList = CartList

		local Frame = Instance.new("Frame")

		Frame.AnchorPoint = Vector2.new(0, 1)
		Frame.Position = UDim2.new(0, 0, 1, 0)
		Frame.Size = UDim2.new(1, 0, 0, 40)
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderSizePixel = 0
		Frame.ZIndex = 31
		Frame.Parent = TraderBuyCart

		local UIGradient = Instance.new("UIGradient")

		UIGradient.Color = ColorSequence.new(Color3.fromRGB(35, 35, 35), Color3.fromRGB(20, 20, 20))
		UIGradient.Parent = Frame

		local TextLabel = Instance.new("TextLabel")

		TextLabel.AnchorPoint = Vector2.new(0, 0.5)
		TextLabel.Position = UDim2.new(0.02, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(0.5, -8, 0, 24)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = "TOTAL: \226\130\1890"
		TextLabel.TextColor3 = Color3.fromRGB(240, 220, 130)
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.TextSize = 16
		TextLabel.ZIndex = 32
		TextLabel.Parent = Frame
		p1.BuyCartTotalLabel = TextLabel

		local TextButton = Instance.new("TextButton")

		TextButton.AnchorPoint = Vector2.new(1, 0.5)
		TextButton.Position = UDim2.new(0.98, 0, 0.5, 0)
		TextButton.Size = UDim2.new(0.35, 0, 0, 28)
		TextButton.BackgroundColor3 = Color3.fromRGB(100, 90, 60)
		TextButton.BorderSizePixel = 0
		TextButton.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		TextButton.Font = Enum.Font.GothamBold
		TextButton.TextSize = 14
		TextButton.Text = "CONFIRM"
		TextButton.AutoButtonColor = true
		TextButton.ZIndex = 33
		TextButton.Parent = Frame
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 5798 | Upvalues: p1 (copy), ReplicatedStorage (ref), p2 (copy) ]]
			if not p1.BuyCart or #p1.BuyCart == 0 then
				return
			end

			local t = {}

			for i, v in ipairs(p1.BuyCart) do
				local t2 = {
					itemID = v.itemID,
					qty = v.qty or 1
				}

				if v.preferredGrid and (v.preferredPos and v.preferredGrid.Metadata) then
					t2.preferredTied = v.preferredGrid.Metadata.TiedInstance
					t2.preferredPos = {
						X = v.preferredPos.X,
						Y = v.preferredPos.Y
					}
				end

				t[i] = t2
			end

			local ok, result = pcall(function() --[[ Line: 5809 | Upvalues: ReplicatedStorage (ref), p2 (ref), t (copy) ]]
				return ReplicatedStorage.Remotes.BuyBulk:InvokeServer(p2, t)
			end)

			if not (ok and result) then
				p1:ShowToast("Buy failed")

				return
			end

			if not ((result.bought or 0) > 0) then
				return
			end

			p1:ShowToast(string.format("Bought %d items for \226\130\189%d", result.bought, result.totalCost or 0))
			p1.BuyCart = {}
			p1:RefreshBuyCartRender()
			p1:RefreshAllPlayerInventories()
		end)
	end
end
function t.AddToBuyCart(p1, p2, p3, p4, p5) --[[ AddToBuyCart | Line: 5825 | Upvalues: ItemDatabase (copy) ]]
	local v1 = ItemDatabase.GetItemData(p2)

	if not v1 then
		return
	end

	p1.BuyCart = p1.BuyCart or {}

	if not p4 then
		for i, v in ipairs(p1.BuyCart) do
			if v.itemID == p2 and (v.price == p3 and not v.preferredGrid) then
				v.qty = (v.qty or 1) + 1
				p1:RefreshBuyCartRender()

				return
			end
		end
	end

	table.insert(p1.BuyCart, {
		qty = 1,
		itemID = p2,
		name = v1.Name,
		price = p3,
		imageID = v1.ImageID,
		preferredGrid = p4,
		preferredPos = p5
	})
	p1:RefreshBuyCartRender()
end
function t.DestroySellPanel(p1) --[[ DestroySellPanel | Line: 5852 ]]
	if p1.SellPanelGrid then
		pcall(function() --[[ Line: 5854 | Upvalues: p1 (copy) ]]
			p1.SellPanelGrid:Destroy()
		end)
		p1.SellPanelGrid = nil
	end

	if p1.SellPanelFrame then
		p1.SellPanelFrame:Destroy()
		p1.SellPanelFrame = nil
	end

	p1.SellPanelTotalLabel = nil
end
function t.RefreshSellPanelTotal(p1) --[[ RefreshSellPanelTotal | Line: 5866 | Upvalues: ItemDatabase (copy) ]]
	if not p1.SellPanelTotalLabel then
		return
	end

	local sum = 0
	local CurrentTraderProfile = p1.CurrentTraderProfile
	local v1 = if CurrentTraderProfile then CurrentTraderProfile.BuybackMultiplier or 0.6 else 0.6
	local v2 = p1.SellPanelPriceLookup or {}

	if p1.SellPanelGrid and p1.SellPanelGrid.Items then
		for k, v in pairs(p1.SellPanelGrid.Items) do
			if v and (v.Metadata and v.Metadata.ID) then
				local ID = v.Metadata.ID
				local v3 = v2[ID]

				if not v3 then
					local v4 = ItemDatabase.GetItemData(ID)

					if v4 and v4.BaseSellValue then
						v3 = v4.BaseSellValue
					end
				end

				if v3 then
					sum = sum + math.floor(v3 * v1)
				end
			end
		end
	end

	p1.SellPanelTotalLabel.Text = string.format("TOTAL: \226\130\189%d", sum)
end
function t.RefreshAllPlayerInventories(p1) --[[ RefreshAllPlayerInventories | Line: 5890 | Upvalues: ReplicatedStorage (copy) ]]
	p1._refreshEpoch = (p1._refreshEpoch or 0) + 1

	local v1 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer()

	if p1._refreshEpoch ~= p1._refreshEpoch then
		return
	end

	if not v1 then
		return
	end

	if v1.Pockets and p1.LocalInventory then
		p1:LoadInventory(p1.LocalInventory, v1.Pockets)
	end

	if v1.ChestRig and p1.ChestRigInventory then
		p1:LoadInventory(p1.ChestRigInventory, v1.ChestRig)
	end

	if v1.BattleBelt and p1.BattleBeltInventory then
		p1:LoadInventory(p1.BattleBeltInventory, v1.BattleBelt)
	end

	if not (v1.Backpack and p1.MainInventory) then
		return
	end

	p1:LoadInventory(p1.MainInventory, v1.Backpack)
end
function t.CreateSellPanel(p1, p2, p3, p4, p5, p6) --[[ CreateSellPanel | Line: 5917 | Upvalues: GridPack (copy), ReplicatedStorage (copy) ]]
	p1:DestroySellPanel()
	p1.SellPanelPriceLookup = if p4 then p4 else {}

	local v2 = 60

	if p1.CrateGridFrame then
		local AbsoluteSize = p1.CrateGridFrame.AbsoluteSize

		if AbsoluteSize and (AbsoluteSize.X > 0 and AbsoluteSize.Y > 0) then
			v2 = math.min(AbsoluteSize.X, AbsoluteSize.Y)
		end
	end

	local v4 = if p6 then p6 else Vector2.new(8, 3)
	local CartTabSellContent = p1.CartTabSellContent

	if CartTabSellContent then
		local _ = v4.Y * v2
		local TraderSellPanel = Instance.new("Frame")

		TraderSellPanel.Name = "TraderSellPanel"
		TraderSellPanel.Size = UDim2.new(1, 0, 1, 0)
		TraderSellPanel.BackgroundTransparency = 1
		TraderSellPanel.BorderSizePixel = 0
		TraderSellPanel.ZIndex = 30
		TraderSellPanel.Parent = CartTabSellContent
		p1.SellPanelFrame = TraderSellPanel

		local GridFrame = Instance.new("Frame")

		GridFrame.Name = "GridFrame"
		GridFrame.Size = UDim2.fromOffset(v2, v2)
		GridFrame.AnchorPoint = Vector2.new(0, 0)
		GridFrame.Position = UDim2.new(0.5, -(v4.X * v2) / 2, 0, 4)
		GridFrame.BackgroundTransparency = 1
		GridFrame.ZIndex = 31
		GridFrame.Parent = TraderSellPanel

		local v6 = GridPack.createGrid({
			Visible = true,
			SlotAspectRatio = 1,
			Parent = GridFrame,
			Assets = {
				Slot = ReplicatedStorage.GridPack.Slot
			},
			GridSize = v4,
			Size = UDim2.fromScale(v4.X, v4.Y),
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.new(0, 0, 0, 0),
			Metadata = {
				TiedInstance = p5 or "SellPanel",
				TraderNPC = p2
			}
		})

		p1:PatchGridForOversizedItems(v6)
		p1:StyleGridContainer(v6)
		v6.IsColliding = p1:CreateGridIsColliding()
		v6:ConnectTransferLink(p1.TransferLink)
		v6.MoveMiddleware = p1:CreateMoveMiddleware()
		p1.SellPanelGrid = v6

		local Footer = Instance.new("Frame")

		Footer.Name = "Footer"
		Footer.AnchorPoint = Vector2.new(0, 1)
		Footer.Position = UDim2.new(0, 0, 1, 0)
		Footer.Size = UDim2.new(1, 0, 0, 40)
		Footer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Footer.BackgroundTransparency = 0
		Footer.BorderSizePixel = 0
		Footer.ZIndex = 31
		Footer.Parent = TraderSellPanel

		local UIGradient = Instance.new("UIGradient")

		UIGradient.Color = ColorSequence.new(Color3.fromRGB(35, 35, 35), Color3.fromRGB(20, 20, 20))
		UIGradient.Parent = Footer

		local TotalLabel = Instance.new("TextLabel")

		TotalLabel.Name = "TotalLabel"
		TotalLabel.AnchorPoint = Vector2.new(0, 0.5)
		TotalLabel.Position = UDim2.new(0.02, 0, 0.5, 0)
		TotalLabel.Size = UDim2.new(0.5, -8, 0, 24)
		TotalLabel.BackgroundTransparency = 1
		TotalLabel.Text = "TOTAL: \226\130\1890"
		TotalLabel.TextColor3 = Color3.fromRGB(240, 220, 130)
		TotalLabel.TextXAlignment = Enum.TextXAlignment.Left
		TotalLabel.Font = Enum.Font.GothamBold
		TotalLabel.TextSize = 16
		TotalLabel.ZIndex = 32
		TotalLabel.Parent = Footer
		p1.SellPanelTotalLabel = TotalLabel

		local SellButton = Instance.new("TextButton")

		SellButton.Name = "SellButton"
		SellButton.AnchorPoint = Vector2.new(1, 0.5)
		SellButton.Position = UDim2.new(0.98, 0, 0.5, 0)
		SellButton.Size = UDim2.new(0.35, 0, 0, 28)
		SellButton.BackgroundColor3 = Color3.fromRGB(70, 100, 70)
		SellButton.BorderSizePixel = 0
		SellButton.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		SellButton.Font = Enum.Font.GothamBold
		SellButton.TextSize = 14
		SellButton.Text = "SELL"
		SellButton.AutoButtonColor = true
		SellButton.ZIndex = 33
		SellButton.Parent = Footer
		SellButton.MouseButton1Click:Connect(function() --[[ Line: 6028 | Upvalues: ReplicatedStorage (ref), p2 (copy), p1 (copy) ]]
			local ok, result = pcall(function() --[[ Line: 6029 | Upvalues: ReplicatedStorage (ref), p2 (ref) ]]
				return ReplicatedStorage.Remotes.SellFinalize:InvokeServer(p2)
			end)

			if not (ok and result) then
				p1:ShowToast("Sell failed")

				return
			end

			if (result.sold or 0) > 0 then
				p1:ShowToast(string.format("Sold %d items for \226\130\189%d", result.sold, result.totalPayout or 0))
			end

			p1:RefreshSellPanelTotal()
		end)
	end
end
function t.ShowToast(p1, p2) --[[ ShowToast | Line: 6043 ]]
	warn("[Toast] " .. p2)
	require(game:GetService("ReplicatedStorage"):WaitForChild("ToastUI")).Show(p2, nil, "bottom-center")
end
function t.StartVicinityRefresh(p1) --[[ StartVicinityRefresh | Line: 6050 | Upvalues: Players (copy), ReplicatedStorage (copy), InventoryWire (copy) ]]
	p1:StopVicinityRefresh()
	p1._vicinityRefreshing = true
	task.spawn(function() --[[ Line: 6054 | Upvalues: p1 (copy), Players (ref), ReplicatedStorage (ref), InventoryWire (ref) ]]
		while p1._vicinityRefreshing do
			task.wait(1.5)

			if not p1._vicinityRefreshing or p1.CurrentStoragePart then
				break
			end

			local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

			if not (InventoryGui and InventoryGui.Enabled) then
				break
			end

			if p1.StorageInventory and p1.StorageInventory.Items then
				local v1 = false

				for k, v in pairs(p1.StorageInventory.Items) do
					if v and (v.ItemElement and v.ItemElement.Parent == InventoryGui) then
						v1 = true

						break
					end
				end

				if v1 then
					continue
				end
			end

			local v2 = ReplicatedStorage.Remotes.GetVicinityItems:InvokeServer()

			if not v2 then
				continue
			end

			local tbl = {}

			if p1.StorageInventory and p1.StorageInventory.Items then
				for k, v in pairs(p1.StorageInventory.Items) do
					if v and v.Metadata then
						tbl[v.Metadata.ID .. "_" .. (v.Metadata.ItemIndex or 0)] = true
					end
				end
			end

			local t = {}
			local v5 = false

			for k, v in pairs((InventoryWire.DecodeItems(v2.Items or {}))) do
				if v then
					local v6 = v.ID .. "_" .. k

					t[v6] = true

					if not tbl[v6] then
						v5 = true
					end
				end
			end

			local v7 = false

			for k in pairs(tbl) do
				if not t[k] then
					v7 = true

					break
				end
			end

			if v5 then
				p1:LoadVicinity()

				continue
			end

			if not (v7 and (p1.StorageInventory and p1.StorageInventory.Items)) then
				continue
			end

			for k, v in pairs(p1.StorageInventory.Items) do
				if v and (v.Metadata and not t[v.Metadata.ID .. "_" .. (v.Metadata.ItemIndex or 0)]) then
					pcall(function() --[[ Line: 6131 | Upvalues: p1 (ref), v (copy) ]]
						p1.StorageInventory:RemoveItem(v)
						v:Destroy()
					end)
				end
			end
		end
	end)
end
function t.StopVicinityRefresh(p1) --[[ StopVicinityRefresh | Line: 6144 ]]
	p1._vicinityRefreshing = false
end
function t.CreateEquipmentSlot(p1, p2, p3) --[[ CreateEquipmentSlot | Line: 6148 | Upvalues: GridPack (copy), ReplicatedStorage (copy), Players (copy) ]]
	local v1 = GridPack.createSingleSlot({
		Visible = true,
		Parent = p2,
		Assets = {
			Slot = ReplicatedStorage.GridPack.SingleSlot
		},
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.fromScale(1, 1)
	})

	v1.Metadata = {
		AcceptsType = p3,
		TiedInstance = ({
			HeadGear = "HeadGear_" .. Players.LocalPlayer.UserId,
			FaceWear = "FaceWear_" .. Players.LocalPlayer.UserId,
			EyeWear = "EyeWear_" .. Players.LocalPlayer.UserId,
			BodyGear = "BodyGear_" .. Players.LocalPlayer.UserId,
			BeltGear = "BeltGear_" .. Players.LocalPlayer.UserId,
			Primary = "Primary_" .. Players.LocalPlayer.UserId,
			Secondary = "Secondary_" .. Players.LocalPlayer.UserId,
			Sidearm = "Sidearm_" .. Players.LocalPlayer.UserId,
			Melee = "Melee_" .. Players.LocalPlayer.UserId,
			Uniform = "Uniform_" .. Players.LocalPlayer.UserId,
			Backpack = "BackpackSlot_" .. Players.LocalPlayer.UserId,
			NightOptical = "NightOptical_" .. Players.LocalPlayer.UserId
		})[p3]
	}
	function v1.IsColliding(p12, p2, p32, p4) --[[ Line: 6177 | Upvalues: p3 (copy), p1 (copy) ]]
		if not (p12.GuiElement and p12.GuiElement.Visible) then
			return true
		end

		local v1 = p3

		if p3 == "Secondary" then
			v1 = "Primary"
		end

		if p2.Metadata.ItemType ~= v1 then
			return true
		end

		if p12.Item and p12.Item ~= p2 then
			return true
		end

		local v2 = ipairs

		for v4, v5 in v2(p1.BuyCartGhosts or {}) do
			if v5.slot == p12 then
				return true
			end
		end

		return false
	end

	return v1
end
function t.CreateMoveMiddleware(p1) --[[ CreateMoveMiddleware | Line: 6204 | Upvalues: Players (copy), ItemDatabase (copy), ReplicatedStorage (copy), PlaceConfig (copy) ]]
	return function(p12, p2, p3, p4, p5) --[[ Line: 6207 | Upvalues: p1 (copy), Players (ref), ItemDatabase (ref), ReplicatedStorage (ref), PlaceConfig (ref) ]]
		local v1 = p5 or p4

		if p5 == p4 and (p4.ChangeItem and not p4.GridSize) then
			local StorageInventory = p1.StorageInventory

			if StorageInventory and (StorageInventory.GuiElement and StorageInventory.GuiElement.Visible) then
				local v2 = Players.LocalPlayer:GetMouse()
				local GuiElement = StorageInventory.GuiElement
				local AbsolutePosition = GuiElement.AbsolutePosition
				local AbsoluteSize = GuiElement.AbsoluteSize

				if v2.X >= AbsolutePosition.X and (v2.X <= AbsolutePosition.X + AbsoluteSize.X and (v2.Y >= AbsolutePosition.Y and v2.Y <= AbsolutePosition.Y + AbsoluteSize.Y)) then
					local ID = p12.Metadata.ID
					local v3 = ItemDatabase.GetItemData(ID)

					if v3 and v3.NonDroppable then
						ReplicatedStorage.Remotes.DropItem:FireServer(p12.Metadata.ItemIndex, p4.Metadata.TiedInstance, ID)

						return false
					end

					if not PlaceConfig.ItemDropsAllowed() then
						ReplicatedStorage.Remotes.DropItem:FireServer(p12.Metadata.ItemIndex, p4.Metadata.TiedInstance, ID)

						return false
					end

					local Character = Players.LocalPlayer.Character

					if Character then
						local Humanoid = Character:FindFirstChildOfClass("Humanoid")

						if Humanoid then
							Humanoid:UnequipTools()
						end
					end

					ReplicatedStorage.Remotes.DropItem:FireServer(p12.Metadata.ItemIndex, p4.Metadata.TiedInstance, ID)

					if p4 == p1.BackpackSlot then
						p1:UpdateBackpackGridSize(nil)
					elseif p4 == p1.BodySlot then
						p1:UpdateChestRigGridSize(nil)
					elseif p4 == p1.BeltGearSlot then
						p1:UpdateBattleBeltGridSize(nil)
					end

					if not p1.CurrentStoragePart then
						p1:PlaySound("Drop", p12.Metadata.ItemType)

						return false
					end

					p1:CloseInventoryUI()
					p1:PlaySound("Drop", p12.Metadata.ItemType)

					return false
				end
			end
		end

		if p12.Metadata.ItemType == "Backpack" and (p5 == p1.MainInventory and p4 == p1.BackpackSlot) then
			warn("Cannot place the equipped backpack inside its own inventory!")

			return false
		end

		if p12.Metadata.ItemType == "BodyGear" and (p5 == p1.ChestRigInventory and p4 == p1.BodySlot) then
			warn("Cannot place the equipped body gear inside its own chest rig!")

			return false
		end

		if p5 then
			local v4 = p5.Metadata and p5.Metadata.TiedInstance or ""

			if type(v4) == "string" and (v4:sub(1, 9) == "Vicinity_" and p4 ~= p5) then
				local ID = p12.Metadata.ID
				local v5 = ItemDatabase.GetItemData(ID)

				if v5 and v5.NonDroppable then
					ReplicatedStorage.Remotes.DropItem:FireServer(p12.Metadata.ItemIndex, p4.Metadata.TiedInstance, ID)

					return false
				end

				if not PlaceConfig.ItemDropsAllowed() then
					ReplicatedStorage.Remotes.DropItem:FireServer(p12.Metadata.ItemIndex, p4.Metadata.TiedInstance, ID)

					return false
				end

				local Character = Players.LocalPlayer.Character

				if Character then
					local Humanoid = Character:FindFirstChildOfClass("Humanoid")

					if Humanoid then
						Humanoid:UnequipTools()
					end
				end

				ReplicatedStorage.Remotes.DropItem:FireServer(p12.Metadata.ItemIndex, p4.Metadata.TiedInstance, ID)

				if p4 == p1.BackpackSlot then
					p1:UpdateBackpackGridSize(nil)
				elseif p4 == p1.BodySlot then
					p1:UpdateChestRigGridSize(nil)
				end

				if not p1.CurrentStoragePart then
					p1:PlaySound("Drop", p12.Metadata.ItemType)

					return true
				end

				p1:CloseInventoryUI()
				p1:PlaySound("Drop", p12.Metadata.ItemType)

				return true
			end

			if v1 and v1.GridSize then
				local v6 = ItemDatabase.GetItemData(p12.Metadata.ID)

				if v6 then
					local v7 = if p3 == 1 or (p3 == 3 or p3 == 90) then true elseif p3 == 270 then true else false
					local v8 = v7 and v6.Size.Y or v6.Size.X
					local v9 = v7 and v6.Size.X or v6.Size.Y

					if v1.GridSize.X < v8 or v1.GridSize.Y < v9 then
						return false
					end

					if p2.X + v8 > v1.GridSize.X or p2.Y + v9 > v1.GridSize.Y then
						return false
					end
				end
			end

			if p5.Items then
				local v10 = ItemDatabase.GetItemData(p12.Metadata.ID)

				if v10 and (v10.ItemType == "Ammo" or v10.ItemType == "AmmoPack") then
					for k, v in pairs(p5.Items) do
						if v and (v ~= p12 and v.Metadata) then
							local v11 = ItemDatabase.GetItemData(v.Metadata.ID)

							if v11 and (v11.ItemType == "Ammo" and v11.ammoType == v10.ammoType) then
								local v12 = if p3 == 1 or (p3 == 3 or p3 == 90) then true elseif p3 == 270 then true else false
								local v15 = v.Rotation or 0
								local v16 = if v15 == 1 or (v15 == 3 or v15 == 90) then true else v15 == 270
								local Position = v.Position

								if Position and not (p2.X + (v12 and v10.Size.Y or v10.Size.X) <= Position.X or (p2.X >= Position.X + (v16 and v11.Size.Y or v11.Size.X) or (p2.Y + (v12 and v10.Size.X or v10.Size.Y) <= Position.Y or p2.Y >= Position.Y + (v16 and v11.Size.X or v11.Size.Y)))) then
									ReplicatedStorage.Remotes.RepackMagazine:FireServer(p12.Metadata.ItemIndex, p4.Metadata and p4.Metadata.TiedInstance, v.Metadata.ItemIndex, p5.Metadata and p5.Metadata.TiedInstance)
									p1:PlaySound("Move", p12.Metadata.ItemType)

									return false
								end
							end
						end
					end
				end
			end

			local v21 = if p5.ChangeItem == nil then false else not p5.GridSize

			if v21 then
				local v22 = p3

				if v22 == nil then
					v22 = p12 and p12.Rotation or 0
				end

				if v22 == 0 then
					p3 = 0
				else
					if not (p1 and p1.ShowToast) then
						return false
					end

					p1:ShowToast("Rotate the item upright before equipping")

					return false
				end
			end

			if p5.Metadata and p5.Metadata.IsTrader then
				return false
			end

			if p4.Metadata and p4.Metadata.IsTrader then
				local ID = p12.Metadata.ID
				local Price = p12.Metadata.Price

				if not Price and p1.CurrentTraderProfile then
					local SellPanelPriceLookup = p1.SellPanelPriceLookup

					if SellPanelPriceLookup and SellPanelPriceLookup[ID] then
						Price = SellPanelPriceLookup[ID]
					end
				end

				local v24, v25

				if p5 == p1.LocalInventory or (p5 == p1.MainInventory or (p5 == p1.ChestRigInventory or p5 == p1.BattleBeltInventory)) then
					v24 = p5
					v25 = p2
				else
					v24 = nil
					v25 = nil
				end

				if not (ID and Price) then
					return false
				end

				p1:AddToBuyCart(ID, Price, v24, v25)

				return false
			end

			if p5.Metadata and p5.Metadata.IsBarterChip then
				local BarterItemId = p5.Metadata.BarterItemId
				local v26 = p4.Metadata and p4.Metadata.TiedInstance
				local ItemIndex = p12.Metadata.ItemIndex

				if p12.GuiElement then
					p12.GuiElement.Visible = false
				end

				task.spawn(function() --[[ Line: 6465 | Upvalues: ReplicatedStorage (ref), v26 (copy), ItemIndex (copy), BarterItemId (copy), p4 (copy), p12 (copy), p1 (ref) ]]
					local ok, result = pcall(function() --[[ Line: 6466 | Upvalues: ReplicatedStorage (ref), v26 (ref), ItemIndex (ref), BarterItemId (ref) ]]
						return ReplicatedStorage.Remotes.BarterContributeItem:InvokeServer(v26, ItemIndex, BarterItemId)
					end)

					if ok and (result and result.ok) then
						if p4 and (p4.RemoveItem and p12) then
							pcall(function() --[[ Line: 6475 | Upvalues: p4 (ref), p12 (ref) ]]
								p4:RemoveItem(p12)
							end)
						end

						p1:_updateBarterChipCount(result.itemId, result.newCount)
						p1:PlaySound("Move", "General")

						if type(v26) == "string" and v26:sub(1, 6) == "Stash_" then
							p1:LoadVicinity()
						end
					else
						if not (p12 and (p12.GuiElement and p12.GuiElement.Parent)) then
							return
						end

						p12.GuiElement.Visible = true
					end
				end)

				return false
			end

			local v27, v28 = ReplicatedStorage.Remotes.MoveItemAcrossItemManager:InvokeServer(p12.Metadata.ItemIndex, p4.Metadata.TiedInstance, p5.Metadata.TiedInstance, p2, p3)

			if v27 then
				p12.Metadata.ItemIndex = v28

				if p1.CurrentBodyTied then
					ReplicatedStorage.Remotes.BumpBodyLock:FireServer(p1.CurrentBodyTied)
				end

				local v29 = p4.Metadata and p4.Metadata.TiedInstance
				local v30 = p5.Metadata and p5.Metadata.TiedInstance

				if type(v29) == "string" and v29:sub(1, 5) == "Sell_" or type(v30) == "string" and v30:sub(1, 5) == "Sell_" then
					task.defer(function() --[[ Line: 6517 | Upvalues: p1 (ref) ]]
						p1:RefreshSellPanelTotal()
					end)
					task.delay(0.1, function() --[[ Line: 6518 | Upvalues: p1 (ref) ]]
						p1:RefreshSellPanelTotal()
					end)
				end

				local v31 = if p5 == p1.HeadSlot or (p5 == p1.BodySlot or (p5 == p1.PrimarySlot or (p5 == p1.SecondarySlot or (p5 == p1.SidearmSlot or (p5 == p1.MeleeSlot or p5 == p1.UniformSlot))))) then true elseif p5 == p1.BackpackSlot then true else false
				local v32 = if p4 == p1.StorageInventory then if type(p4.Metadata.TiedInstance) == "string" then if p4.Metadata.TiedInstance:sub(1, 9) == "Vicinity_" then true else false else false else false

				if v32 then
					p1:PlaySound("Pickup", p12.Metadata.ItemType)
				elseif v31 then
					p1:PlaySound("Equip", p12.Metadata.ItemType)
				else
					p1:PlaySound("Move", p12.Metadata.ItemType)
				end

				if p5 == p1.BackpackSlot then
					print("Backpack equipped, updating grid size")
					p1:UpdateBackpackGridSize(p12.Metadata.ID)
				elseif p4 == p1.BackpackSlot then
					print("Backpack unequipped, clearing grid")
					p1:UpdateBackpackGridSize(nil)
				end

				if p5 == p1.BodySlot then
					p1:UpdateChestRigGridSize(p12.Metadata.ID)
				elseif p4 == p1.BodySlot then
					p1:UpdateChestRigGridSize(nil)
				end

				if p5 == p1.BeltGearSlot then
					p1:UpdateBattleBeltGridSize(p12.Metadata.ID)
				elseif p4 == p1.BeltGearSlot then
					p1:UpdateBattleBeltGridSize(nil)
				end

				if p4 == p1.PrimarySlot and p5 ~= p1.PrimarySlot then
					local WeaponRoundsLabel = p1.PrimaryFrame:FindFirstChild("WeaponRoundsLabel")
					local WeaponLoadedLabel = p1.PrimaryFrame:FindFirstChild("WeaponLoadedLabel")

					if WeaponRoundsLabel then
						WeaponRoundsLabel:Destroy()
					end

					if WeaponLoadedLabel then
						WeaponLoadedLabel:Destroy()
					end
				end

				if p4 == p1.SecondarySlot and p5 ~= p1.SecondarySlot then
					local WeaponRoundsLabel = p1.SecondaryFrame:FindFirstChild("WeaponRoundsLabel")
					local WeaponLoadedLabel = p1.SecondaryFrame:FindFirstChild("WeaponLoadedLabel")

					if WeaponRoundsLabel then
						WeaponRoundsLabel:Destroy()
					end

					if WeaponLoadedLabel then
						WeaponLoadedLabel:Destroy()
					end
				end

				if p4 == p1.SidearmSlot and p5 ~= p1.SidearmSlot then
					local WeaponRoundsLabel = p1.SidearmFrame:FindFirstChild("WeaponRoundsLabel")
					local WeaponLoadedLabel = p1.SidearmFrame:FindFirstChild("WeaponLoadedLabel")

					if WeaponRoundsLabel then
						WeaponRoundsLabel:Destroy()
					end

					if WeaponLoadedLabel then
						WeaponLoadedLabel:Destroy()
					end
				end

				if p5.GridSize then
					task.defer(function() --[[ Line: 6581 | Upvalues: p1 (ref), p12 (copy) ]]
						p1:ConvertItemToScale(p12)
					end)

					return v27
				end

				if v21 and p12.ItemElement then
					p12.Rotation = 0

					local ItemElement = p12.ItemElement

					local function forceRot() --[[ forceRot | Line: 6589 | Upvalues: ItemElement (copy) ]]
						if not (ItemElement and ItemElement.Parent) then
							return
						end

						ItemElement.Rotation = 0
					end

					if not (ItemElement and ItemElement.Parent) then
						task.defer(forceRot)
						task.delay(0.05, forceRot)

						return v27
					end

					ItemElement.Rotation = 0
					task.defer(forceRot)
					task.delay(0.05, forceRot)

					return v27
				end
			else
				warn("Server rejected item move across managers")
			end

			return v27
		end

		if p4.Items then
			local v33 = ItemDatabase.GetItemData(p12.Metadata.ID)

			if v33 and (v33.ItemType == "Ammo" or v33.ItemType == "AmmoPack") then
				for k, v in pairs(p4.Items) do
					if v and (v ~= p12 and v.Metadata) then
						local v34 = ItemDatabase.GetItemData(v.Metadata.ID)
						local v35 = if v34 then if v34.ItemType == "Ammo" then if v34.ammoType == v33.ammoType then true else false else false else v34

						if v35 or v34 and (if v34.ItemType == "AmmoPack" and (v33.ItemType == "AmmoPack" and v34.ID == v33.ID) then if v.Metadata.ID == p12.Metadata.ID then true else false else false) then
							local v37 = if p3 == 1 or (p3 == 3 or p3 == 90) then true elseif p3 == 270 then true else false
							local v40 = v.Rotation or 0
							local v41 = if v40 == 1 or (v40 == 3 or v40 == 90) then true else v40 == 270
							local Position = v.Position

							if Position and not (p2.X + (v37 and v33.Size.Y or v33.Size.X) <= Position.X or (p2.X >= Position.X + (v41 and v34.Size.Y or v34.Size.X) or (p2.Y + (v37 and v33.Size.X or v33.Size.Y) <= Position.Y or p2.Y >= Position.Y + (v41 and v34.Size.X or v34.Size.Y)))) then
								local v44 = p4.Metadata and p4.Metadata.TiedInstance

								ReplicatedStorage.Remotes.RepackMagazine:FireServer(p12.Metadata.ItemIndex, v44, v.Metadata.ItemIndex, v44)
								p1:PlaySound("Move", p12.Metadata.ItemType)

								return false
							end
						end
					end
				end
			end
		end

		local v45 = ReplicatedStorage.Remotes.MoveItem:InvokeServer(p12.Metadata.ItemIndex, p4.Metadata.TiedInstance, p2, p3)

		if not v45 then
			warn("Server rejected item reposition within same grid")

			return v45
		end

		p1:PlaySound("Move", p12.Metadata.ItemType)

		if p1.CurrentBodyTied then
			ReplicatedStorage.Remotes.BumpBodyLock:FireServer(p1.CurrentBodyTied)
		end

		if not p4.GridSize then
			return v45
		end

		task.defer(function() --[[ Line: 6658 | Upvalues: p1 (ref), p12 (copy) ]]
			p1:ConvertItemToScale(p12)
		end)

		return v45
	end
end
function t.FindItemManager(p1, p2) --[[ FindItemManager | Line: 6668 ]]
	for i, v in ipairs({
		p1.LocalInventory,
		p1.MainInventory,
		p1.ChestRigInventory,
		p1.BattleBeltInventory,
		p1.StorageInventory
	}) do
		if v and v.Items then
			for k, v2 in pairs(v.Items) do
				if v2 == p2 then
					return v
				end
			end
		end
	end

	for i, v in ipairs({
		p1.HeadSlot,
		p1.FaceWearSlot,
		p1.EyeWearSlot,
		p1.BodySlot,
		p1.BeltGearSlot,
		p1.PrimarySlot,
		p1.SecondarySlot,
		p1.SidearmSlot,
		p1.MeleeSlot,
		p1.UniformSlot,
		p1.BackpackSlot,
		p1.NightOpticalSlot
	}) do
		if v and v.Item == p2 then
			return v
		end
	end

	return nil
end
function t.ShowContextMenu(p1, p2, p3) --[[ ShowContextMenu | Line: 6700 | Upvalues: Players (copy), ItemDatabase (copy), PlaceConfig (copy), ReplicatedStorage (copy), InventoryWire (copy), GridPack (copy), UserInputService (copy) ]]
	if not p1.IsUsingItem then
		local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

		if InventoryGui then
			local ContextMenu = InventoryGui:FindFirstChild("ContextMenu")

			if ContextMenu then
				p1:HideContextMenu()

				for i, v in ipairs(ContextMenu:GetChildren()) do
					if v:IsA("TextButton") and (typeof(v.Name) == "string" and v.Name:sub(1, 11) == "VialPicker_") then
						v:Destroy()
					end
				end

				for i, v in ipairs(ContextMenu:GetChildren()) do
					if v:IsA("TextButton") and (typeof(v.Name) == "string" and v.Name:sub(1, 12) == "QuickAssign_") then
						v:Destroy()
					end
				end

				for i, v in ipairs(ContextMenu:GetChildren()) do
					if v:IsA("TextButton") and (typeof(v.Name) == "string" and v.Name:sub(1, 10) == "ApplySkin_") then
						v:Destroy()
					end
				end

				local ID = p2.Metadata.ID
				local v4 = ItemDatabase.GetItemData(ID)

				if v4 then
					local v5 = p1:FindItemManager(p2) or p3

					if v5 then
						local v6 = v5
						local v7 = if v6.ChangeItem == nil then false else true
						local v8 = v6.Metadata and v6.Metadata.TiedInstance or ""
						local v9 = if type(v8) == "string" and type(v8) == "string" then if v8:sub(1, 9) == "Vicinity_" then true else false else false
						local v10 = false

						if not (v7 or v9) then
							local t = {}

							t[tostring(Players.LocalPlayer)] = true
							t["ChestRigInternal_" .. Players.LocalPlayer.UserId] = true
							t["BattleBeltInternal_" .. Players.LocalPlayer.UserId] = true
							t["BackpackInternal_" .. Players.LocalPlayer.UserId] = true

							if type(v8) == "string" and not t[v8] or type(v8) ~= "string" and v8 ~= Players.LocalPlayer then
								v10 = true
							end
						end

						local t = {
							HeadGear = true,
							FaceWear = true,
							EyeWear = true,
							BodyGear = true,
							BeltGear = true,
							Primary = true,
							Secondary = true,
							Uniform = true,
							Backpack = true,
							NightOptical = true
						}
						local v11 = false

						if t[v4.ItemType] and not v7 then
							local v12 = ({
								HeadGear = p1.HeadSlot,
								FaceWear = p1.FaceWearSlot,
								EyeWear = p1.EyeWearSlot,
								BodyGear = p1.BodySlot,
								BeltGear = p1.BeltGearSlot,
								Primary = p1.PrimarySlot,
								Secondary = p1.SecondarySlot,
								Sidearm = p1.SidearmSlot,
								Melee = p1.MeleeSlot,
								Uniform = p1.UniformSlot,
								Backpack = p1.BackpackSlot,
								NightOptical = p1.NightOpticalSlot
							})[v4.ItemType]

							if v12 and v12.Item then
								v11 = true
							end
						end

						local v13 = t[v4.ItemType] and (not v7 and not v11)
						local v14 = v6 and (v6.Metadata and v6.Metadata.IsTrader)
						local EquipButton = ContextMenu:FindFirstChild("EquipButton")
						local DropButton = ContextMenu:FindFirstChild("DropButton")
						local DetailsButton = ContextMenu:FindFirstChild("DetailsButton")
						local AddToCartButton = ContextMenu:FindFirstChild("AddToCartButton")
						local v15 = if v4.ItemType == "Ammo" then v4.maxRounds else false
						local UnloadButton = ContextMenu:FindFirstChild("UnloadButton")

						if UnloadButton and v15 then
							UnloadButton.Visible = if (p2.Metadata.CurrentRounds or v4.maxRounds) > 0 then true else false
						elseif UnloadButton then
							UnloadButton.Visible = false
						end

						local UseButton = ContextMenu:FindFirstChild("UseButton")
						local v18 = v4.RequiresVial or (if v4.ItemType == "Injector" then true else false)
						local _ = v4.HealAmount == nil and not (v4.HungerRestore or v4.ThirstRestore)
						local v19 = not v10 and not v9 or (if v18 then not v10 and not v9 else v18)

						if UseButton then
							UseButton.Visible = v19
						end

						if EquipButton then
							EquipButton.Visible = if v13 then not v14 else v13
						end

						if DropButton and v14 then
							DropButton.Visible = false
						elseif DropButton then
							if v10 or v9 then
								DropButton.Text = "Take"
							else
								DropButton.Text = "Drop"
							end

							DropButton.Visible = true
						end

						local DropToGroundButton = ContextMenu:FindFirstChild("DropToGroundButton")

						if DropToGroundButton then
							local v21 = p2.Metadata and (if p2.Metadata.TaskBound == true then true else false)

							DropToGroundButton.Visible = v10 and (not v9 and (not v14 and (not v21 and PlaceConfig.ItemDropsAllowed())))
						end

						if DetailsButton then
							DetailsButton.Visible = true
						end

						if AddToCartButton then
							AddToCartButton.Visible = v14
						end

						if v14 then
							if UseButton then
								UseButton.Visible = false
							end

							if UnloadButton then
								UnloadButton.Visible = false
							end
						end

						local v23 = p2.Metadata and (if p2.Metadata.TaskBound == true then true else false)

						if v23 then
							if EquipButton then
								EquipButton.Visible = false
							end

							if UseButton then
								UseButton.Visible = false
							end

							if UnloadButton then
								UnloadButton.Visible = false
							end

							if AddToCartButton then
								AddToCartButton.Visible = false
							end

							if DropButton then
								DropButton.Visible = true
								DropButton.Text = "Destroy"
								DropButton:SetAttribute("_ConfirmDestroy", false)
							end
						end

						if DropButton and (v4.NonDroppable and not v23) then
							DropButton.Visible = true
							DropButton.Text = "Discard"
							DropButton:SetAttribute("_ConfirmDiscard", false)
						elseif DropButton and not PlaceConfig.ItemDropsAllowed() then
							DropButton.Visible = false
						end

						local HeaderLabel = ContextMenu:FindFirstChild("HeaderLabel")

						if HeaderLabel then
							HeaderLabel.Text = " " .. (v4.Name or "Item")
						end

						local DropSeparator = ContextMenu:FindFirstChild("DropSeparator")
						local v24 = if DropButton then DropButton.Visible and (if DropButton.Text == "Drop" or DropButton.Text == "Destroy" then true elseif DropButton.Text == "Discard" then true else false) else DropButton

						if DropSeparator then
							DropSeparator.Visible = DropButton and DropButton.Visible or (DropToGroundButton and DropToGroundButton.Visible or false)
						end

						if DropButton and v24 then
							DropButton.BackgroundColor3 = Color3.fromRGB(50, 22, 22)
							DropButton.TextColor3 = Color3.fromRGB(230, 140, 130)
						elseif DropButton then
							DropButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
							DropButton.TextColor3 = Color3.fromRGB(200, 200, 200)
						end

						local v26 = Players.LocalPlayer:GetMouse()

						ContextMenu.Position = UDim2.new(0, v26.X, 0, v26.Y)
						ContextMenu.Visible = true

						if p1._contextMenuConnections then
							for i, v in ipairs(p1._contextMenuConnections) do
								v:Disconnect()
							end
						end

						p1._contextMenuConnections = {}

						if UseButton and v19 and v18 then
							local function f27() --[[ Line: 6922 | Upvalues: ReplicatedStorage (ref), InventoryWire (ref), ItemDatabase (ref), p1 (copy), ContextMenu (copy), v6 (ref), p2 (copy), UseButton (copy) ]]
								local v1 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer()
								local list = {}

								for i, v in ipairs({ "Pockets", "ChestRig", "BattleBelt", "Backpack" }) do
									local v2 = if v1 then v1[v] else v1

									if v2 and v2.Items then
										for v3, v4 in InventoryWire.Each(v2.Items) do
											if v4 and v4.ID then
												local v5 = ItemDatabase.GetItemData(v4.ID)

												if v5 and v5.ItemType == "Vial" then
													table.insert(list, {
														idx = v3,
														id = v4.ID,
														db = v5,
														tied = v2.TiedInstance
													})
												end
											end
										end
									end
								end

								if #list == 0 then
									p1:ShowToast("No vials available")
									p1:HideContextMenu()

									return
								end

								for i, v in ipairs(ContextMenu:GetChildren()) do
									if v:IsA("TextButton") then
										v.Visible = false
									end
								end

								local v62 = v6.Metadata and v6.Metadata.TiedInstance
								local ItemIndex = p2.Metadata.ItemIndex

								for i, v in ipairs(list) do
									local v7 = UseButton:Clone()

									v7.Name = "VialPicker_" .. i
									v7.Text = v.db and v.db.Name or v.id
									v7.LayoutOrder = i
									v7.Visible = true
									v7.Parent = ContextMenu

									local idx = v.idx
									local v9 = v.db and v.db.Name or "Vial"
									local _contextMenuConnections = p1._contextMenuConnections

									local function f10() --[[ Line: 6973 | Upvalues: p1 (ref), v9 (copy), ReplicatedStorage (ref), ItemIndex (copy), v62 (copy), idx (copy) ]]
										p1:ShowToast("Used " .. v9)
										ReplicatedStorage.Remotes.UseItem:FireServer(ItemIndex, v62, idx)
										p1:HideContextMenu()
									end

									table.insert(_contextMenuConnections, v7.MouseButton1Click:Connect(f10))
								end
							end

							table.insert(p1._contextMenuConnections, UseButton.MouseButton1Click:Connect(f27))
						elseif UseButton and v19 then
							local function f28() --[[ Line: 6981 | Upvalues: ContextMenu (copy), v6 (ref), p2 (copy), ReplicatedStorage (ref), p1 (copy) ]]
								ContextMenu.Visible = false
								pcall(function() --[[ Line: 6984 | Upvalues: v6 (ref), p2 (ref) ]]
									v6:RemoveItem(p2)
								end)

								local v1 = v6.Metadata and v6.Metadata.TiedInstance

								ReplicatedStorage.Remotes.UseItem:FireServer(p2.Metadata.ItemIndex, v1)
								p1:HideContextMenu()
							end

							table.insert(p1._contextMenuConnections, UseButton.MouseButton1Click:Connect(f28))
						end

						local v29 = if v4.ItemType == "Medical" or v4.ItemType == "FoodAndDrink" then not v10 and (not v9 and (not v14 and not v23)) else false

						if v29 and UseButton then
							local QuickAssign_Btn = UseButton:Clone()

							QuickAssign_Btn.Name = "QuickAssign_Btn"
							QuickAssign_Btn.Text = "Assign to Quick Slot"
							QuickAssign_Btn.Visible = true
							QuickAssign_Btn.LayoutOrder = (UseButton.LayoutOrder or 0) + 1
							QuickAssign_Btn.Parent = ContextMenu

							local function f30() --[[ Line: 7003 | Upvalues: ContextMenu (copy), UseButton (copy), p1 (copy), ReplicatedStorage (ref), ID (copy) ]]
								for i, v in ipairs(ContextMenu:GetChildren()) do
									if v:IsA("TextButton") then
										v.Visible = false
									end
								end

								for i = 1, 4 do
									local v1 = UseButton:Clone()

									v1.Name = "QuickAssign_Pick_" .. i
									v1.Text = "Quick Slot F" .. i
									v1.LayoutOrder = i
									v1.Visible = true
									v1.Parent = ContextMenu

									local _contextMenuConnections = p1._contextMenuConnections

									local function f2() --[[ Line: 7016 | Upvalues: ReplicatedStorage (ref), i (copy), ID (ref), p1 (ref) ]]
										ReplicatedStorage.Remotes.SaveQuickSlots:FireServer(i, ID)

										local ok, result = pcall(require, ReplicatedStorage:WaitForChild("HotbarController"))

										if ok and (result and result.SetQuickSlot) then
											result:SetQuickSlot(i, ID)
										end

										p1:ShowToast("Assigned to Quick Slot F" .. i)
										p1:HideContextMenu()
									end

									table.insert(_contextMenuConnections, v1.MouseButton1Click:Connect(f2))
								end
							end

							table.insert(p1._contextMenuConnections, QuickAssign_Btn.MouseButton1Click:Connect(f30))
						end

						local ok, result = pcall(require, ReplicatedStorage:WaitForChild("SkinCatalog", 1))
						local v31 = if ok and (result and (result.SUPPORTED_SLOTS and (result.SUPPORTED_SLOTS[v4.ItemType] and not (v14 or (v9 or (v10 or v23)))))) then true else false

						if v31 and UseButton then
							local ApplySkin_Btn = UseButton:Clone()

							ApplySkin_Btn.Name = "ApplySkin_Btn"
							ApplySkin_Btn.Text = "Apply Skin..."
							ApplySkin_Btn.Visible = true
							ApplySkin_Btn.LayoutOrder = (UseButton.LayoutOrder or 0) + 2
							ApplySkin_Btn.Parent = ContextMenu

							local ItemType = v4.ItemType

							local function f32() --[[ Line: 7050 | Upvalues: ReplicatedStorage (ref), ItemDatabase (ref), ItemType (copy), ContextMenu (copy), p1 (copy), UseButton (copy) ]]
								local ok, result = pcall(function() --[[ Line: 7051 | Upvalues: ReplicatedStorage (ref) ]]
									return ReplicatedStorage.Remotes.GetUnlockedSkins:InvokeServer()
								end)

								if not ok then
									result = {}
								end

								local list = {}

								for v3, v4 in ipairs(if result then result else {}) do
									local v5 = ItemDatabase.GetItemData(v4)

									if v5 and v5.ItemType == ItemType then
										table.insert(list, {
											id = v4,
											name = v5.Name or v4
										})
									end
								end

								for i, v in ipairs(ContextMenu:GetChildren()) do
									if v:IsA("TextButton") then
										v.Visible = false
									end
								end

								if #list == 0 then
									p1:ShowToast("No skins unlocked for " .. ItemType)
									p1:HideContextMenu()

									return
								end

								for i, v in ipairs(list) do
									local v6 = UseButton:Clone()

									v6.Name = "ApplySkin_Pick_" .. i
									v6.Text = v.name
									v6.TextTruncate = Enum.TextTruncate.AtEnd
									v6.LayoutOrder = i
									v6.Visible = true
									v6.Parent = ContextMenu

									local id = v.id
									local name = v.name
									local _contextMenuConnections = p1._contextMenuConnections

									local function f7() --[[ Line: 7080 | Upvalues: ReplicatedStorage (ref), ItemType (ref), id (copy), p1 (ref), name (copy) ]]
										ReplicatedStorage.Remotes.ApplySkin:FireServer(ItemType, id)
										p1:ShowToast("Applied " .. name)
										p1:HideContextMenu()
									end

									table.insert(_contextMenuConnections, v6.MouseButton1Click:Connect(f7))
								end

								local ApplySkin_Remove = UseButton:Clone()

								ApplySkin_Remove.Name = "ApplySkin_Remove"
								ApplySkin_Remove.Text = "Remove Skin"
								ApplySkin_Remove.LayoutOrder = #list + 1
								ApplySkin_Remove.Visible = true
								ApplySkin_Remove.Parent = ContextMenu

								local _contextMenuConnections = p1._contextMenuConnections

								local function f8() --[[ Line: 7092 | Upvalues: ReplicatedStorage (ref), ItemType (ref), p1 (ref) ]]
									ReplicatedStorage.Remotes.RemoveSkin:FireServer(ItemType)
									p1:ShowToast("Removed skin")
									p1:HideContextMenu()
								end

								table.insert(_contextMenuConnections, ApplySkin_Remove.MouseButton1Click:Connect(f8))
							end

							table.insert(p1._contextMenuConnections, ApplySkin_Btn.MouseButton1Click:Connect(f32))
						end

						if DropToGroundButton and DropToGroundButton.Visible then
							local function f33() --[[ Line: 7111 | Upvalues: ContextMenu (copy), v6 (ref), p1 (copy), v4 (copy), ReplicatedStorage (ref), p2 (copy), ID (copy) ]]
								ContextMenu.Visible = false

								local v1 = v6.Metadata and v6.Metadata.TiedInstance

								if not v1 then
									p1:HideContextMenu()

									return
								end

								p1:PlaySound("Drop", v4.ItemType)
								ReplicatedStorage.Remotes.DropItem:FireServer(p2.Metadata.ItemIndex, v1, ID)
								p1:HideContextMenu()
							end

							table.insert(p1._contextMenuConnections, DropToGroundButton.MouseButton1Click:Connect(f33))
						end

						if DropButton then
							local function f34() --[[ Line: 7124 | Upvalues: v23 (copy), DropButton (copy), p2 (copy), p1 (copy), ReplicatedStorage (ref), v4 (copy), v6 (ref), ID (copy), ContextMenu (copy), v10 (ref), v9 (copy), Players (ref) ]]
								if v23 then
									if DropButton:GetAttribute("_ConfirmDestroy") then
										DropButton:SetAttribute("_ConfirmDestroy", false)

										local v1 = p2.Metadata and p2.Metadata.TaskId

										p1:HideContextMenu()

										if not v1 then
											p1:ShowToast("Cannot destroy: this item has lost its task link")

											return
										end

										local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 2))

										if not (ok and result) then
											p1:ShowToast("Could not destroy: task system unavailable")

											return
										end

										local v2 = result:Abandon(v1)

										if v2 and v2.ok then
											return
										end

										p1:ShowToast("Could not destroy: " .. tostring(if v2 then v2.error or "no response" else "no response"))

										return
									end

									DropButton:SetAttribute("_ConfirmDestroy", true)
									DropButton.Text = "Confirm? quest fails"
									task.delay(3, function() --[[ Line: 7153 | Upvalues: DropButton (ref) ]]
										if not (DropButton and (DropButton.Parent and DropButton:GetAttribute("_ConfirmDestroy"))) then
											return
										end

										DropButton:SetAttribute("_ConfirmDestroy", false)
										DropButton.Text = "Destroy"
									end)
								else
									if v4.NonDroppable then
										if not DropButton:GetAttribute("_ConfirmDiscard") then
											DropButton:SetAttribute("_ConfirmDiscard", true)
											DropButton.Text = "Confirm? permanent"
											task.delay(3, function() --[[ Line: 7175 | Upvalues: DropButton (ref) ]]
												if not (DropButton and (DropButton.Parent and DropButton:GetAttribute("_ConfirmDiscard"))) then
													return
												end

												DropButton:SetAttribute("_ConfirmDiscard", false)
												DropButton.Text = "Discard"
											end)

											return
										end

										DropButton:SetAttribute("_ConfirmDiscard", false)

										local v62 = v6.Metadata and v6.Metadata.TiedInstance

										pcall(function() --[[ Line: 7169 | Upvalues: v6 (ref), p2 (ref) ]]
											v6:RemoveItem(p2)
										end)
										ReplicatedStorage.Remotes.DiscardItem:FireServer(p2.Metadata.ItemIndex, v62, ID)
									else
										ContextMenu.Visible = false

										if v10 or v9 then
											if v4.IsCurrency then
												local v7 = v6.Metadata and v6.Metadata.TiedInstance

												pcall(function() --[[ Line: 7193 | Upvalues: v6 (ref), p2 (ref) ]]
													v6:RemoveItem(p2)
												end)

												if not v7 then
													p1:HideContextMenu()

													return
												end

												ReplicatedStorage.Remotes.PickupCurrency:FireServer(v7, p2.Metadata.ItemIndex)
												p1:HideContextMenu()

												return
											end

											p1:PlaySound("Move", v4.ItemType)
											ReplicatedStorage.Remotes.ContextMenuAction:FireServer("Take", p2.Metadata.ItemIndex, v6.Metadata and v6.Metadata.TiedInstance, ID)
											task.delay(0.15, function() --[[ Line: 7214 | Upvalues: p1 (ref), ReplicatedStorage (ref) ]]
												p1._refreshEpoch = (p1._refreshEpoch or 0) + 1

												local v1 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer()

												if p1._refreshEpoch ~= p1._refreshEpoch then
													return
												end

												if not v1 then
													return
												end

												if v1.Pockets and p1.LocalInventory then
													p1:LoadInventory(p1.LocalInventory, v1.Pockets)
												end

												if v1.ChestRig and p1.ChestRigInventory then
													p1:LoadInventory(p1.ChestRigInventory, v1.ChestRig)
												end

												if v1.BattleBelt and p1.BattleBeltInventory then
													p1:LoadInventory(p1.BattleBeltInventory, v1.BattleBelt)
												end

												if not (v1.Backpack and p1.MainInventory) then
													return
												end

												p1:LoadInventory(p1.MainInventory, v1.Backpack)
											end)
										else
											p1:PlaySound("Drop", v4.ItemType)

											local Character = Players.LocalPlayer.Character

											if Character then
												local Humanoid = Character:FindFirstChildOfClass("Humanoid")

												if Humanoid then
													Humanoid:UnequipTools()
												end
											end

											pcall(function() --[[ Line: 7250 | Upvalues: v6 (ref), p2 (ref) ]]
												v6:RemoveItem(p2)
											end)

											local v92 = v6.Metadata and v6.Metadata.TiedInstance

											ReplicatedStorage.Remotes.DropItem:FireServer(p2.Metadata.ItemIndex, v92, ID)

											if not p1.CurrentStoragePart then
												p1:HideContextMenu()

												return
											end

											p1:CloseInventoryUI()
										end
									end

									p1:HideContextMenu()
								end
							end

							table.insert(p1._contextMenuConnections, DropButton.MouseButton1Click:Connect(f34))
						end

						if AddToCartButton and v14 then
							table.insert(p1._contextMenuConnections, AddToCartButton.MouseButton1Click:Connect(function() --[[ Line: 7268 | Upvalues: ContextMenu (copy), p2 (copy), p1 (copy) ]]
								ContextMenu.Visible = false

								local ID = p2.Metadata.ID
								local Price = p2.Metadata.Price

								if not Price and p1.SellPanelPriceLookup then
									Price = p1.SellPanelPriceLookup[ID]
								end

								if ID and Price then
									p1:AddToBuyCart(ID, Price)
								end

								p1:HideContextMenu()
							end))
						end

						if EquipButton and v13 then
							local function f35() --[[ Line: 7284 | Upvalues: ContextMenu (copy), p1 (copy), v4 (copy), v6 (ref), p2 (copy), GridPack (ref), ReplicatedStorage (ref), ID (copy) ]]
								ContextMenu.Visible = false
								p1:PlaySound("Move", v4.ItemType)
								pcall(function() --[[ Line: 7288 | Upvalues: v6 (ref), p2 (ref) ]]
									v6:RemoveItem(p2)
								end)

								local v1 = ({
									HeadGear = p1.HeadSlot,
									FaceWear = p1.FaceWearSlot,
									EyeWear = p1.EyeWearSlot,
									BodyGear = p1.BodySlot,
									BeltGear = p1.BeltGearSlot,
									Primary = p1.PrimarySlot,
									Secondary = p1.SecondarySlot,
									Sidearm = p1.SidearmSlot,
									Melee = p1.MeleeSlot,
									Uniform = p1.UniformSlot,
									Backpack = p1.BackpackSlot,
									NightOptical = p1.NightOpticalSlot
								})[v4.ItemType]

								if v1 then
									local v2 = p1:CreateMoveMiddleware()
									local v3 = GridPack.createItem({
										Rotation = 0,
										Assets = {
											Item = ReplicatedStorage.GridPack.Item
										},
										Position = Vector2.new(0, 0),
										Size = v4.Size,
										Metadata = {
											ItemIndex = 1,
											ItemType = v4.ItemType,
											ID = ID
										},
										MoveMiddleware = v2
									})

									if v3.ItemElement then
										v3.ItemElement.BackgroundColor3 = v4.BackgroundColor
										v3.ItemElement.BackgroundTransparency = v4.BackgroundTransparency or 0

										local ImageLabel = v3.ItemElement:FindFirstChildOfClass("ImageLabel")

										if ImageLabel then
											ImageLabel.Image = v4.ImageID
										end

										v3.ItemElement.Position = UDim2.new(0, 0, 0, 0)
									end

									pcall(function() --[[ Line: 7323 | Upvalues: v1 (copy), v3 (copy) ]]
										v1:ChangeItem(v3)
									end)

									if v3.ItemElement then
										local ItemElement = v3.ItemElement

										local function forcePosition() --[[ forcePosition | Line: 7327 | Upvalues: ItemElement (copy) ]]
											ItemElement.Position = UDim2.new(0, 0, 0, 0)
											ItemElement.Size = UDim2.new(1, 0, 1, 0)
											ItemElement.Rotation = 0
										end

										ItemElement.Position = UDim2.new(0, 0, 0, 0)
										ItemElement.Size = UDim2.new(1, 0, 1, 0)
										ItemElement.Rotation = 0
										task.defer(forcePosition)
										task.delay(0.05, forcePosition)
										task.delay(0.1, forcePosition)
									end

									p1:BindDropHandler(v3, v1)

									if v4.ItemType == "BodyGear" then
										p1:UpdateChestRigGridSize(ID)
									elseif v4.ItemType == "BeltGear" then
										p1:UpdateBattleBeltGridSize(ID)
									elseif v4.ItemType == "Backpack" then
										p1:UpdateBackpackGridSize(ID)
									end
								end

								local v42 = v6.Metadata and v6.Metadata.TiedInstance

								ReplicatedStorage.Remotes.ContextMenuAction:FireServer("Equip", p2.Metadata.ItemIndex, v42, ID)
								p1:HideContextMenu()
							end

							table.insert(p1._contextMenuConnections, EquipButton.MouseButton1Click:Connect(f35))
						end

						if UnloadButton and v15 then
							local function f36() --[[ Line: 7355 | Upvalues: ContextMenu (copy), v6 (ref), ReplicatedStorage (ref), p2 (copy), p1 (copy) ]]
								ContextMenu.Visible = false
								ReplicatedStorage.Remotes.UnloadMagazine:FireServer(p2.Metadata.ItemIndex, v6.Metadata and v6.Metadata.TiedInstance)
								p1:HideContextMenu()
							end

							table.insert(p1._contextMenuConnections, UnloadButton.MouseButton1Click:Connect(f36))
						end

						local OpenContainerButton = ContextMenu:FindFirstChild("OpenContainerButton")
						local v37 = p2.Metadata and (if p2.Metadata.DroppedContainerTied == nil then false else true)
						local v38 = if v6.ChangeItem == nil then false else true
						local v40 = v37 or not v38 and (if v4 then if v4.SlotSize == nil then false elseif v4.ItemType == "Backpack" or v4.ItemType == "BodyGear" then true elseif v4.ItemType == "BeltGear" then true else false else v4)

						if OpenContainerButton then
							OpenContainerButton.Visible = v40
						end

						if OpenContainerButton and v40 then
							local function f41() --[[ Line: 7380 | Upvalues: ContextMenu (copy), ReplicatedStorage (ref), v37 (copy), p2 (copy), v6 (ref), p1 (copy), ItemDatabase (ref) ]]
								ContextMenu.Visible = false

								local OpenableContainer = require(ReplicatedStorage:WaitForChild("OpenableContainer"))
								local v1 = if v37 then ReplicatedStorage.Remotes.RequestOpenContainer:InvokeServer(p2.Metadata.DroppedContainerTied) else ReplicatedStorage.Remotes.RequestOpenInventoryContainer:InvokeServer(v6.Metadata and v6.Metadata.TiedInstance, p2.Metadata.ItemIndex, p2.Metadata.ID)

								if not v1 then
									p1:ShowToast("Container is empty or missing")
								else
									local t = {
										tiedInstance = v1.tiedInstance,
										items = v1.items,
										gridSize = v1.gridSize
									}

									t.parentTied = v6.Metadata and v6.Metadata.TiedInstance
									t.title = v1.title or ItemDatabase.GetItemData(p2.Metadata.ID).Name or "Container"
									t.moveMiddleware = p1:CreateMoveMiddleware()
									function t.onClose() --[[ onClose | Line: 7408 | Upvalues: ReplicatedStorage (ref), v1 (ref) ]]
										local CloseNestedContainer = ReplicatedStorage.Remotes:FindFirstChild("CloseNestedContainer")

										if not CloseNestedContainer then
											return
										end

										CloseNestedContainer:FireServer(v1.tiedInstance)
									end

									local _, v5 = OpenableContainer.Open(t)

									if v5 then
										if v1.maxItemWidth then
											v5.Metadata.MaxItemWidth = v1.maxItemWidth
										end

										v5.IsColliding = p1:CreateGridIsColliding()
										v5:ConnectTransferLink(p1.TransferLink)
										p1:LoadInventory(v5, {
											Items = v1.items,
											GridSize = v1.gridSize,
											TiedInstance = v1.tiedInstance
										})
									end
								end

								p1:HideContextMenu()
							end

							table.insert(p1._contextMenuConnections, OpenContainerButton.MouseButton1Click:Connect(f41))
						end

						local UnloadMagButton = ContextMenu:FindFirstChild("UnloadMagButton")
						local v42 = false

						if v4.MagType and v38 then
							local Character = Players.LocalPlayer.Character

							if Character then
								local v43 = Character:FindFirstChild(v4.ToolName)

								if not v43 then
									local Backpack = Players.LocalPlayer:FindFirstChild("Backpack")

									if Backpack then
										v43 = Backpack:FindFirstChild(v4.ToolName)
									end
								end

								if v43 and not v43:GetAttribute("MagUnloaded") then
									v42 = true
								end
							end
						end

						if UnloadMagButton then
							UnloadMagButton.Visible = v42
						end

						if UnloadMagButton and v42 then
							local function f45() --[[ Line: 7449 | Upvalues: ContextMenu (copy), v6 (ref), p1 (copy), ReplicatedStorage (ref) ]]
								ContextMenu.Visible = false

								local v1 = nil
								local v2 = nil

								if v6 == p1.PrimarySlot then
									v2 = p1.PrimaryFrame
									v1 = "Primary"
								elseif v6 == p1.SecondarySlot then
									v2 = p1.SecondaryFrame
									v1 = "Secondary"
								elseif v6 == p1.SidearmSlot then
									v2 = p1.SidearmFrame
									v1 = "Sidearm"
								elseif v6 == p1.MeleeSlot then
									v2 = p1.MeleeFrame
									v1 = "Melee"
								end

								if v1 then
									ReplicatedStorage.Remotes.UnloadWeaponMag:FireServer(v1)

									if v2 then
										local v3 = v2:FindFirstChild("WeaponInfoStrip") or v2
										local WeaponRoundsLabel = v3:FindFirstChild("WeaponRoundsLabel")

										if WeaponRoundsLabel then
											WeaponRoundsLabel.Visible = false
										end

										local WeaponLoadedLabel = v3:FindFirstChild("WeaponLoadedLabel")

										if WeaponLoadedLabel then
											WeaponLoadedLabel.Text = "Unloaded"
											WeaponLoadedLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
										end
									end
								end

								p1:HideContextMenu()
							end

							table.insert(p1._contextMenuConnections, UnloadMagButton.MouseButton1Click:Connect(f45))
						end

						local LoadMagButton = ContextMenu:FindFirstChild("LoadMagButton")
						local v46 = false

						if v4.MagType and v38 then
							local Character = Players.LocalPlayer.Character

							if Character then
								local v47 = Character:FindFirstChild(v4.ToolName)

								if not v47 then
									local Backpack = Players.LocalPlayer:FindFirstChild("Backpack")

									if Backpack then
										v47 = Backpack:FindFirstChild(v4.ToolName)
									end
								end

								if v47 then
									local Ammo = v47:FindFirstChild("Ammo")
									local v49 = if Ammo then Ammo:FindFirstChild("MagAmmo") else Ammo

									if v49 and v49.Value <= 0 then
										v46 = true
									end
								end
							end
						end

						if LoadMagButton then
							LoadMagButton.Visible = v46
						end

						if LoadMagButton and v46 then
							local function f50() --[[ Line: 7507 | Upvalues: ContextMenu (copy), v6 (ref), p1 (copy), ReplicatedStorage (ref) ]]
								ContextMenu.Visible = false

								local v1 = nil
								local v2 = nil

								if v6 == p1.PrimarySlot then
									v2 = p1.PrimaryFrame
									v1 = "Primary"
								elseif v6 == p1.SecondarySlot then
									v2 = p1.SecondaryFrame
									v1 = "Secondary"
								elseif v6 == p1.SidearmSlot then
									v2 = p1.SidearmFrame
									v1 = "Sidearm"
								elseif v6 == p1.MeleeSlot then
									v2 = p1.MeleeFrame
									v1 = "Melee"
								end

								if v1 then
									ReplicatedStorage.Remotes.LoadWeaponMag:FireServer(v1)

									if v2 then
										local v3 = v2:FindFirstChild("WeaponInfoStrip") or v2
										local WeaponRoundsLabel = v3:FindFirstChild("WeaponRoundsLabel")

										if WeaponRoundsLabel then
											WeaponRoundsLabel.Text = "Full"
											WeaponRoundsLabel.TextColor3 = Color3.fromRGB(120, 220, 120)
											WeaponRoundsLabel.Visible = true
										end

										local WeaponLoadedLabel = v3:FindFirstChild("WeaponLoadedLabel")

										if WeaponLoadedLabel then
											WeaponLoadedLabel.Text = "Loaded"
											WeaponLoadedLabel.TextColor3 = Color3.fromRGB(120, 200, 120)
										end
									end
								end

								p1:HideContextMenu()
							end

							table.insert(p1._contextMenuConnections, LoadMagButton.MouseButton1Click:Connect(f50))
						end

						if DetailsButton then
							table.insert(p1._contextMenuConnections, DetailsButton.MouseButton1Click:Connect(function() --[[ Line: 7542 | Upvalues: p1 (copy), ID (copy), p2 (copy) ]]
								p1:HideContextMenu()
								p1:ShowDetailsPanel(ID, p2)
							end))
						end

						local v51 = p2.Metadata and p2.Metadata.NoteText
						local ReadButton = ContextMenu:FindFirstChild("ReadButton")

						if v51 and (not ReadButton and DetailsButton) then
							local ReadButton2 = DetailsButton:Clone()

							ReadButton2.Name = "ReadButton"
							ReadButton2.Text = "Read"
							ReadButton2.Parent = ContextMenu
							ReadButton = ReadButton2
						end

						if ReadButton then
							ReadButton.Visible = if v51 == nil then false else true

							if v51 then
								table.insert(p1._contextMenuConnections, ReadButton.MouseButton1Click:Connect(function() --[[ Line: 7570 | Upvalues: p1 (copy), p2 (copy) ]]
									p1:HideContextMenu()
									p1:ShowNotePanel(p2)
								end))
							end
						end

						local function f53(p12) --[[ Line: 7578 | Upvalues: ContextMenu (copy), Players (ref), p1 (copy) ]]
							if p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.MouseButton2 then
								task.defer(function() --[[ Line: 7580 | Upvalues: ContextMenu (ref), Players (ref), p1 (ref) ]]
									if not ContextMenu.Visible then
										return
									end

									local v1 = Players.LocalPlayer:GetMouse()
									local v2 = Vector2.new(v1.X, v1.Y)
									local AbsolutePosition = ContextMenu.AbsolutePosition
									local AbsoluteSize = ContextMenu.AbsoluteSize

									if not (v2.X < AbsolutePosition.X or (v2.X > AbsolutePosition.X + AbsoluteSize.X or (v2.Y < AbsolutePosition.Y or v2.Y > AbsolutePosition.Y + AbsoluteSize.Y))) then
										return
									end

									p1:HideContextMenu()
								end)
							end

							if p12.KeyCode ~= Enum.KeyCode.Escape then
								return
							end

							p1:HideContextMenu()
						end

						table.insert(p1._contextMenuConnections, UserInputService.InputBegan:Connect(f53))
					end
				end
			end
		end
	end
end
function t.ShowNotePanel(p1, p2) --[[ ShowNotePanel | Line: 7600 | Upvalues: Players (copy) ]]
	local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

	if not InventoryGui then
		return
	end

	local v1 = if p2 then p2.Metadata and p2.Metadata.NoteText else p2

	if not v1 then
		return
	end

	local v2 = p2.Metadata and p2.Metadata.NoteTitle or "Recovered note"
	local NotePanel = InventoryGui:FindFirstChild("NotePanel")

	if not NotePanel then
		local NotePanel2 = Instance.new("Frame")

		NotePanel2.Name = "NotePanel"
		NotePanel2.Size = UDim2.fromOffset(430, 300)
		NotePanel2.Position = UDim2.fromScale(0.5, 0.5)
		NotePanel2.AnchorPoint = Vector2.new(0.5, 0.5)
		NotePanel2.BackgroundColor3 = Color3.fromRGB(20, 20, 18)
		NotePanel2.BorderSizePixel = 0
		NotePanel2.ZIndex = 200
		NotePanel2.Visible = false
		NotePanel2.Parent = InventoryGui

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = Color3.fromRGB(78, 74, 60)
		UIStroke.Thickness = 1
		UIStroke.Parent = NotePanel2

		local UIPadding = Instance.new("UIPadding")

		UIPadding.PaddingTop = UDim.new(0, 12)
		UIPadding.PaddingBottom = UDim.new(0, 12)
		UIPadding.PaddingLeft = UDim.new(0, 14)
		UIPadding.PaddingRight = UDim.new(0, 14)
		UIPadding.Parent = NotePanel2

		local NoteTitle = Instance.new("TextLabel")

		NoteTitle.Name = "NoteTitle"
		NoteTitle.Size = UDim2.new(1, -28, 0, 22)
		NoteTitle.BackgroundTransparency = 1
		NoteTitle.Font = Enum.Font.GothamBold
		NoteTitle.TextSize = 15
		NoteTitle.TextColor3 = Color3.fromRGB(214, 198, 150)
		NoteTitle.TextXAlignment = Enum.TextXAlignment.Left
		NoteTitle.ZIndex = 201
		NoteTitle.Parent = NotePanel2

		local CloseButton = Instance.new("TextButton")

		CloseButton.Name = "CloseButton"
		CloseButton.Size = UDim2.fromOffset(22, 22)
		CloseButton.Position = UDim2.new(1, 0, 0, 0)
		CloseButton.AnchorPoint = Vector2.new(1, 0)
		CloseButton.BackgroundTransparency = 1
		CloseButton.Font = Enum.Font.GothamBold
		CloseButton.TextSize = 16
		CloseButton.Text = "X"
		CloseButton.TextColor3 = Color3.fromRGB(190, 190, 190)
		CloseButton.ZIndex = 202
		CloseButton.Parent = NotePanel2
		CloseButton.MouseButton1Click:Connect(function() --[[ Line: 7655 | Upvalues: p1 (copy) ]]
			p1:HideNotePanel()
		end)

		local Divider = Instance.new("Frame")

		Divider.Name = "Divider"
		Divider.Size = UDim2.new(1, 0, 0, 1)
		Divider.Position = UDim2.fromOffset(0, 30)
		Divider.BackgroundColor3 = Color3.fromRGB(78, 74, 60)
		Divider.BorderSizePixel = 0
		Divider.ZIndex = 201
		Divider.Parent = NotePanel2

		local Body = Instance.new("ScrollingFrame")

		Body.Name = "Body"
		Body.Size = UDim2.new(1, 0, 1, -42)
		Body.Position = UDim2.fromOffset(0, 40)
		Body.BackgroundTransparency = 1
		Body.BorderSizePixel = 0
		Body.ScrollBarThickness = 4
		Body.CanvasSize = UDim2.new()
		Body.AutomaticCanvasSize = Enum.AutomaticSize.Y
		Body.ZIndex = 201
		Body.Parent = NotePanel2

		local BodyText = Instance.new("TextLabel")

		BodyText.Name = "BodyText"
		BodyText.Size = UDim2.new(1, -8, 0, 0)
		BodyText.AutomaticSize = Enum.AutomaticSize.Y
		BodyText.BackgroundTransparency = 1
		BodyText.Font = Enum.Font.Gotham
		BodyText.TextSize = 14
		BodyText.TextColor3 = Color3.fromRGB(206, 206, 200)
		BodyText.TextXAlignment = Enum.TextXAlignment.Left
		BodyText.TextYAlignment = Enum.TextYAlignment.Top
		BodyText.TextWrapped = true
		BodyText.RichText = false
		BodyText.Text = ""
		BodyText.ZIndex = 201
		BodyText.Parent = Body
		NotePanel = NotePanel2
	end

	local NoteTitle = NotePanel:FindFirstChild("NoteTitle")

	if NoteTitle then
		NoteTitle.Text = v2
	end

	local Body = NotePanel:FindFirstChild("Body")
	local v3 = if Body then Body:FindFirstChild("BodyText") else Body

	if v3 then
		v3.Text = v1
	end

	if Body then
		Body.CanvasPosition = Vector2.new(0, 0)
	end

	NotePanel.Visible = true
end
function t.HideNotePanel(p1) --[[ HideNotePanel | Line: 7706 | Upvalues: Players (copy) ]]
	local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

	if not InventoryGui then
		return
	end

	local NotePanel = InventoryGui:FindFirstChild("NotePanel")

	if not NotePanel then
		return
	end

	NotePanel.Visible = false
end
function t.HideContextMenu(p1) --[[ HideContextMenu | Line: 7713 | Upvalues: Players (copy) ]]
	local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

	if not InventoryGui then
		return
	end

	local ContextMenu = InventoryGui:FindFirstChild("ContextMenu")

	if ContextMenu then
		ContextMenu.Visible = false
	end

	if p1._contextMenuConnections then
		for i, v in ipairs(p1._contextMenuConnections) do
			v:Disconnect()
		end

		p1._contextMenuConnections = nil
	end

	if not p1._refreshWeight then
		return
	end

	task.delay(0.5, p1._refreshWeight)
	task.delay(1.5, p1._refreshWeight)
end
function t.ShowDetailsPanel(p1, p2, p3) --[[ ShowDetailsPanel | Line: 7733 | Upvalues: Players (copy), ItemDatabase (copy), ReplicatedStorage (copy), UserInputService (copy) ]]
	local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

	if not InventoryGui then
		return
	end

	local DetailsPanel = InventoryGui:FindFirstChild("DetailsPanel")

	if not DetailsPanel then
		return
	end

	local v1 = ItemDatabase.GetItemData(p2)

	if not v1 then
		return
	end

	p1:HideDetailsPanel()

	local ItemName = DetailsPanel:FindFirstChild("ItemName")

	if ItemName then
		ItemName.Text = v1.Name or p2
	end

	local ItemType = DetailsPanel:FindFirstChild("ItemType")

	if ItemType then
		ItemType.Text = v1.ItemType or ""
	end

	local Description = DetailsPanel:FindFirstChild("Description")

	if Description then
		Description.Text = v1.Description or "No description available."
	end

	local StatsFrame = DetailsPanel:FindFirstChild("StatsFrame")

	if StatsFrame then
		for v2, v3 in StatsFrame:GetChildren() do
			if v3:IsA("TextLabel") then
				v3:Destroy()
			end
		end

		local count = 0

		local function addStat(p1, p2, p3) --[[ addStat | Line: 7767 | Upvalues: count (ref), StatsFrame (copy) ]]
			count = count + 1

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.new(1, 0, 0, 16)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = p1 .. ": " .. tostring(p2)
			TextLabel.TextColor3 = if p3 then p3 else Color3.fromRGB(200, 200, 200)
			TextLabel.Font = Enum.Font.Gotham
			TextLabel.TextSize = 12
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.ZIndex = 101
			TextLabel.LayoutOrder = count
			TextLabel.Parent = StatsFrame
		end

		local function addSectionHeader(p1) --[[ addSectionHeader | Line: 7782 | Upvalues: count (ref), StatsFrame (copy) ]]
			count = count + 1

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.new(1, 0, 0, 20)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = p1
			TextLabel.TextColor3 = Color3.fromRGB(220, 200, 120)
			TextLabel.Font = Enum.Font.GothamBold
			TextLabel.TextSize = 12
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.ZIndex = 101
			TextLabel.LayoutOrder = count
			TextLabel.Parent = StatsFrame
		end

		addStat("Size", v1.Size.X .. "x" .. v1.Size.Y)

		if v1.SlotSize then
			addStat("Storage", v1.SlotSize.X * v1.SlotSize.Y .. " slots (" .. v1.SlotSize.X .. "x" .. v1.SlotSize.Y .. ")")
		end

		if v1.MaxItemWidth then
			addStat("Max Item Width", v1.MaxItemWidth .. " slot(s)")
		end

		if v1.Weight then
			local sum = 0
			local v4 = nil

			if v1.ItemType == "BodyGear" and (p1.BodySlot and (p1.BodySlot.Item and p1.BodySlot.Item == p3)) then
				v4 = p1.ChestRigInventory
			elseif v1.ItemType == "BeltGear" and (v1.SlotSize and (p1.BeltGearSlot and (p1.BeltGearSlot.Item and p1.BeltGearSlot.Item == p3))) then
				v4 = p1.BattleBeltInventory
			elseif v1.ItemType == "Backpack" and (p1.BackpackSlot and (p1.BackpackSlot.Item and p1.BackpackSlot.Item == p3)) then
				v4 = p1.MainInventory
			end

			if v4 and v4.Items then
				for k, v in pairs(v4.Items) do
					if v and v.Metadata then
						local v5 = ItemDatabase.GetItemData(v.Metadata.ID)

						if v5 and v5.Weight then
							sum = sum + v5.Weight
						end
					end
				end
			end

			if sum > 0 then
				addStat("Weight", string.format("%.1f kg (+%.1f kg)", v1.Weight, sum))
			else
				addStat("Weight", string.format("%.1f kg", v1.Weight))
			end
		end

		if v1.ArmorClass then
			addStat("Armor Class", v1.ArmorClass, Color3.fromRGB(100, 180, 255))
		end

		if v1.ArmorMaxDurability then
			local v6 = p3.Metadata and p3.Metadata.CurrentDurability or v1.ArmorMaxDurability
			local v7 = false
			local v8 = nil

			if v1.ItemType == "BodyGear" and (p1.BodySlot and p1.BodySlot.Item == p3) then
				v7 = true
				v8 = "Body"
			elseif v1.ItemType == "HeadGear" and (p1.HeadSlot and p1.HeadSlot.Item == p3) then
				v7 = true
				v8 = "Head"
			end

			if v7 then
				local ok, result = pcall(function() --[[ Line: 7864 | Upvalues: ReplicatedStorage (ref), v8 (ref) ]]
					return ReplicatedStorage.Remotes.GetArmorDurability:InvokeServer(v8)
				end)

				if ok and result ~= nil then
					v6 = result
				end
			end

			local v9 = v6 / v1.ArmorMaxDurability
			local v10 = if v9 > 0.6 then Color3.fromRGB(100, 255, 100) elseif v9 > 0.3 then Color3.fromRGB(255, 220, 80) else Color3.fromRGB(255, 80, 80)

			addStat("Durability", math.floor(v6) .. " / " .. v1.ArmorMaxDurability, v10)
		end

		if v1.RadResist and v1.RadResist > 0 then
			local format = string.format

			addStat("Radiation Protection", format("%d%%", (math.floor(v1.RadResist * 100 + 0.5))), Color3.fromRGB(140, 220, 80))
		end

		if v1.ammoType then
			addStat("Ammo Type", v1.ammoType)
		end

		if v1.maxRounds then
			addStat("Capacity", v1.maxRounds .. " rounds")
		end

		if v1.stackSize then
			addStat("Stack Size", v1.stackSize .. " rounds")
		end

		if p3.Metadata and (p3.Metadata.LoadedRounds and #p3.Metadata.LoadedRounds > 0) then
			local t = {}
			local list = {}

			for i, v in ipairs(p3.Metadata.LoadedRounds) do
				if not t[v] then
					t[v] = 0
					table.insert(list, v)
				end

				t[v] = t[v] + 1
			end

			local t2 = {}

			for i, v in ipairs(list) do
				table.insert(t2, t[v] .. "x " .. (v:match("_(.+)$") or v))
			end

			addStat("Rounds", table.concat(t2, ", "))
		end

		if v1.MagType then
			local v17 = ItemDatabase.GetItemData(v1.MagType)

			addStat("Magazine", v17 and v17.Name or v1.MagType)
		end

		if if v1.ItemType == "FoodAndDrink" or (v1.ItemType == "Medical" or v1.ItemType == "Vial") then true elseif v1.ItemType == "Injector" then true else false then
			local v22 = Color3.fromRGB(140, 220, 80)
			local v23 = Color3.fromRGB(230, 110, 110)
			local v24 = Color3.fromRGB(180, 180, 180)
			local HungerRestore = v1.HungerRestore

			if not HungerRestore then
				HungerRestore = v1.ThirstRestore

				if not HungerRestore then
					HungerRestore = if v1.HealAmount and v1.HealAmount > 0 then true else v1.RadRemoveAmount or (v1.StaminaRestore or (v1.StaminaRegenBuff or (v1.WeightBonusBuff or (v1.RadResistBuff or (v1.DamageResistBuff or (v1.StopsBleeding or v1.BleedImmunity))))))
				end
			end

			if HungerRestore then
				addSectionHeader("EFFECTS")

				if v1.HungerRestore then
					addStat("Satiety", "+" .. v1.HungerRestore, v22)
				end

				if v1.ThirstRestore then
					addStat("Hydration", "+" .. v1.ThirstRestore, v22)
				end

				if v1.HealAmount and v1.HealAmount > 0 then
					if v1.HealOverTime then
						addStat("Health", string.format("+%d HP over %ds", v1.HealAmount, v1.HealDuration or 30), v22)
					else
						addStat("Health", "+" .. v1.HealAmount, v22)
					end
				end

				if v1.RadRemoveAmount then
					addStat("Radiation Removed", "-" .. v1.RadRemoveAmount, v22)
				end

				if v1.RadResistBuff and v1.EffectDuration then
					local format = string.format

					addStat("Rad Resist", format("+%d%% for %ds", math.floor(v1.RadResistBuff * 100), v1.EffectDuration), v22)
				end

				if v1.DamageResistBuff and v1.EffectDuration then
					local format = string.format

					addStat("Damage Resist", format("+%d%% for %ds", math.floor(v1.DamageResistBuff * 100), v1.EffectDuration), v22)
				end

				if v1.StaminaRestore then
					addStat("Stamina", "+" .. v1.StaminaRestore, v22)
				end

				if v1.StaminaRegenBuff and v1.StaminaRegenBuffDuration then
					addStat("Stamina Regen", string.format("x%.1f for %ds", v1.StaminaRegenBuff, v1.StaminaRegenBuffDuration), v22)
				end

				if v1.WeightBonusBuff and v1.WeightBonusBuffDuration then
					addStat("Carry Weight", string.format("+%d kg for %ds", v1.WeightBonusBuff, v1.WeightBonusBuffDuration), v22)
				end

				if v1.StopsBleeding then
					addStat("Stops Bleeding", "Yes", v22)
				end

				if v1.BleedImmunity then
					addStat("Bleed Immunity", v1.BleedImmunity .. "s", v22)
				end
			end

			if v1.HungerDrain or (v1.ThirstDrain or (v1.TipsyStacksPerUse or v1.SideEffect)) then
				addSectionHeader("SIDE EFFECTS")

				if v1.HungerDrain then
					addStat("Hunger", "-" .. v1.HungerDrain, v23)
				end

				if v1.ThirstDrain then
					addStat("Thirst", "-" .. v1.ThirstDrain, v23)
				end

				if v1.TipsyStacksPerUse then
					addStat("Diziness", "+" .. v1.TipsyStacksPerUse .. " stack(s) per sip", v23)
				end

				if v1.SideEffect then
					addStat("Vision", v1.SideEffect .. " for " .. (v1.SideEffectDuration or 30) .. "s", v23)
				end
			end

			if v1.MaxUses and v1.MaxUses > 1 then
				addStat("Uses", v1.MaxUses, v24)
			end
		end

		local v30 = if p3 then p3.Metadata and p3.Metadata.NoteText else p3

		if type(v30) == "string" and v30 ~= "" then
			local NoteExcerpt = p3.Metadata.NoteExcerpt

			if type(NoteExcerpt) ~= "string" or NoteExcerpt == "" then
				NoteExcerpt = v30

				if #NoteExcerpt > 160 then
					local v31 = string.sub(NoteExcerpt, 1, 160)
					local v32 = string.find(string.reverse(v31), "\n", 1, true)

					if v32 then
						v31 = string.sub(v31, 1, #v31 - v32)
					end

					NoteExcerpt = v31 .. "\n..."
				end
			end

			addSectionHeader("RECOVERED LOG")
			count = count + 1

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.new(1, 0, 0, 0)
			TextLabel.AutomaticSize = Enum.AutomaticSize.Y
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = NoteExcerpt
			TextLabel.TextColor3 = Color3.fromRGB(185, 182, 172)
			TextLabel.Font = Enum.Font.Gotham
			TextLabel.TextSize = 11
			TextLabel.TextWrapped = true
			TextLabel.RichText = false
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.TextYAlignment = Enum.TextYAlignment.Top
			TextLabel.ZIndex = 101
			TextLabel.LayoutOrder = count
			TextLabel.Parent = StatsFrame
			count = count + 1

			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.Size = UDim2.new(1, 0, 0, 14)
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.Text = "Full entry under READ"
			TextLabel2.TextColor3 = Color3.fromRGB(130, 128, 120)
			TextLabel2.Font = Enum.Font.Gotham
			TextLabel2.TextSize = 10
			TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel2.ZIndex = 101
			TextLabel2.LayoutOrder = count
			TextLabel2.Parent = StatsFrame
		end
	end

	if p3 and p3.ItemElement then
		local AbsolutePosition = p3.ItemElement.AbsolutePosition

		DetailsPanel.Position = UDim2.new(0, AbsolutePosition.X + p3.ItemElement.AbsoluteSize.X + 5, 0, AbsolutePosition.Y)
	else
		local v33 = Players.LocalPlayer:GetMouse()

		DetailsPanel.Position = UDim2.new(0, v33.X + 10, 0, v33.Y)
	end

	DetailsPanel.Visible = true
	p1._detailsPanelConn = UserInputService.InputBegan:Connect(function(p12) --[[ Line: 8082 | Upvalues: DetailsPanel (copy), Players (ref), p1 (copy) ]]
		if p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.MouseButton2 then
			task.defer(function() --[[ Line: 8084 | Upvalues: DetailsPanel (ref), Players (ref), p1 (ref) ]]
				if not DetailsPanel.Visible then
					return
				end

				local v1 = Players.LocalPlayer:GetMouse()
				local AbsolutePosition = DetailsPanel.AbsolutePosition
				local AbsoluteSize = DetailsPanel.AbsoluteSize

				if not (v1.X < AbsolutePosition.X or (v1.X > AbsolutePosition.X + AbsoluteSize.X or (v1.Y < AbsolutePosition.Y or v1.Y > AbsolutePosition.Y + AbsoluteSize.Y))) then
					return
				end

				p1:HideDetailsPanel()
			end)
		end

		if p12.KeyCode ~= Enum.KeyCode.Escape then
			return
		end

		p1:HideDetailsPanel()
	end)
end
function t.HideDetailsPanel(p1) --[[ HideDetailsPanel | Line: 8100 | Upvalues: Players (copy) ]]
	local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")

	if InventoryGui then
		local DetailsPanel = InventoryGui:FindFirstChild("DetailsPanel")

		if DetailsPanel then
			DetailsPanel.Visible = false
		end
	end

	if not p1._detailsPanelConn then
		return
	end

	p1._detailsPanelConn:Disconnect()
	p1._detailsPanelConn = nil
end
function t.AddPouchDividers(p1, p2, p3, p4) --[[ AddPouchDividers | Line: 8112 ]] end
function t.BindDropHandler(p1, p2, p3) --[[ BindDropHandler | Line: 8116 ]]
	if not p2.ItemElement then
		return
	end

	local InteractionButton = p2.ItemElement:FindFirstChild("InteractionButton")

	if not InteractionButton then
		return
	end

	InteractionButton.MouseButton2Click:Connect(function() --[[ Line: 8120 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		p1:ShowContextMenu(p2, p3)
	end)
end
function t.FindItemUnderMouse(p1, p2, p3) --[[ FindItemUnderMouse | Line: 8126 | Upvalues: Players (copy) ]]
	local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")

	if not PlayerGui then
		return nil
	end

	for i, v in ipairs((PlayerGui:GetGuiObjectsAtPosition(p2, p3))) do
		for i2, v2 in ipairs({
			p1.LocalInventory,
			p1.MainInventory,
			p1.ChestRigInventory,
			p1.BattleBeltInventory,
			p1.StorageInventory
		}) do
			if v2 and v2.Items then
				for k, v3 in pairs(v2.Items) do
					if v3 and (v3.ItemElement and (v == v3.ItemElement or v:IsDescendantOf(v3.ItemElement))) then
						return v3
					end
				end
			end
		end

		for i2, v2 in ipairs({
			p1.HeadSlot,
			p1.FaceWearSlot,
			p1.EyeWearSlot,
			p1.BodySlot,
			p1.BeltGearSlot,
			p1.PrimarySlot,
			p1.SecondarySlot,
			p1.SidearmSlot,
			p1.MeleeSlot,
			p1.UniformSlot,
			p1.BackpackSlot,
			p1.NightOpticalSlot
		}) do
			if v2 and (v2.Item and (v2.Item.ItemElement and (v == v2.Item.ItemElement or v:IsDescendantOf(v2.Item.ItemElement)))) then
				return v2.Item
			end
		end
	end

	return nil
end
function t.AttachViewportIcon(p1, p2, p3, p4) --[[ AttachViewportIcon | Line: 8161 | Upvalues: ReplicatedStorage (copy) ]]
	if not p2 then
		return
	end

	local ViewportIcon = p2:FindFirstChild("ViewportIcon")

	if ViewportIcon then
		ViewportIcon:Destroy()
	end

	local PlayerItems = ReplicatedStorage:FindFirstChild("PlayerItems")
	local v1 = if PlayerItems then PlayerItems:FindFirstChild(p3, true) else PlayerItems

	if not v1 then
		return
	end

	local ViewportIcon2 = Instance.new("ViewportFrame")

	ViewportIcon2.Name = "ViewportIcon"
	ViewportIcon2.Size = UDim2.fromScale(1, 1)
	ViewportIcon2.Position = UDim2.fromScale(0, 0)
	ViewportIcon2.BackgroundTransparency = 1
	ViewportIcon2.ZIndex = 2

	local WorldModel = Instance.new("WorldModel")

	WorldModel.Parent = ViewportIcon2

	local v2 = v1:Clone()

	if v2:IsA("Tool") then
		local Model = Instance.new("Model")

		Model.Name = v2.Name

		for i, v in ipairs(v2:GetChildren()) do
			v.Parent = Model
		end

		v2:Destroy()
		v2 = Model
	end

	for i, v in ipairs(v2:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = true
			v.CanCollide = false
		end
	end

	if p4 == "Uniform" then
		for i, v in ipairs(v2:GetDescendants()) do
			if v:IsA("BasePart") and (v.Name ~= "Middle" and v.Name ~= "Torso") then
				v:Destroy()
			end
		end
	end

	v2.Parent = WorldModel

	local Camera = Instance.new("Camera")

	Camera.FieldOfView = 40

	if p4 == "Uniform" then
		local function focusPart(p1) --[[ focusPart | Line: 8231 | Upvalues: v2 (ref) ]]
			local v1 = v2:FindFirstChild(p1, true)

			return if v1 and (v1:IsA("BasePart") and v1) then v1 else nil
		end

		local Torso = v2:FindFirstChild("Torso", true)
		local v3 = if Torso and (Torso:IsA("BasePart") and Torso) then Torso else nil

		if not v3 then
			local Middle = v2:FindFirstChild("Middle", true)

			v3 = (if Middle and (Middle:IsA("BasePart") and Middle) then Middle else nil) or v2:FindFirstChildWhichIsA("BasePart", true)
		end

		if not v3 then
			ViewportIcon2:Destroy()
		else
			Camera.CFrame = CFrame.lookAt(v3.Position + v3.CFrame.LookVector * 3, v3.Position, v3.CFrame.UpVector)
		end
	else
		local v5 = Vector3.new(inf, inf, inf)
		local v6 = Vector3.new(-inf, -inf, -inf)
		local v7 = false

		for i, v in ipairs(v2:GetDescendants()) do
			if v:IsA("BasePart") and v.Transparency < 1 then
				local v8 = v.CFrame
				local v9 = v.Size * 0.5

				v7 = true

				for i2 = -1, 1, 2 do
					for j = -1, 1, 2 do
						for k = -1, 1, 2 do
							local v13 = v8 * Vector3.new(i2 * v9.X, j * v9.Y, k * v9.Z)

							v5, v6 = v5:Min(v13), v6:Max(v13)
						end
					end
				end
			end
		end

		if not v7 then
			ViewportIcon2:Destroy()
		else
			local v16 = (v5 + v6) * 0.5
			local v17 = v6 - v5
			local v18 = v2:GetPivot()

			local function frameCam() --[[ frameCam | Line: 8264 | Upvalues: ViewportIcon2 (copy), Camera (copy), v17 (copy), v16 (copy), v18 (copy) ]]
				local AbsoluteSize = ViewportIcon2.AbsoluteSize
				local v1 = if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then AbsoluteSize.X / AbsoluteSize.Y or 1 else 1
				local v3 = math.tan(math.rad(Camera.FieldOfView) / 2)

				Camera.CFrame = CFrame.new(v16 + v18.LookVector * (math.max(v17.Y * 0.5 / v3, v17.X * 0.5 / (v3 * v1)) * 1.05), v16)
			end

			frameCam()
			task.defer(frameCam)
		end
	end

	Camera.Parent = ViewportIcon2
	ViewportIcon2.CurrentCamera = Camera
	ViewportIcon2.Parent = p2
end

local function _itemIdentityKey(p1) --[[ _itemIdentityKey | Line: 8305 ]]
	if not (p1 and p1.ID) then
		return nil
	end

	local Position = p1.Position
	local format = string.format
	local v2 = tostring(p1.ID)
	local v3 = Position and tostring(Position.X) or "?"
	local v4 = Position and tostring(Position.Y) or "?"

	return format("%s|%s,%s|%s|%s|%s|%s", v2, v3, v4, tostring(p1.Rotation or 0), tostring(p1.CurrentRounds), tostring(p1.Uses), (tostring(p1.Amount)))
end

local function _inventoryHash(p1) --[[ _inventoryHash | Line: 8332 | Upvalues: _itemIdentityKey (copy) ]]
	if not (p1 and p1.Items) then
		return ""
	end

	local t = {}

	for k, v in pairs(p1.Items) do
		if v then
			local v1 = _itemIdentityKey(v)

			if v1 then
				table.insert(t, v1)
			end
		end
	end

	table.sort(t)

	local v2 = p1.TiedInstance and tostring(p1.TiedInstance) or "?"

	return v2 .. "#" .. (p1.GridSize and p1.GridSize.X .. "x" .. p1.GridSize.Y or "?") .. "#" .. table.concat(t, "/")
end

local function _tileCensus(p1, p2) --[[ _tileCensus | Line: 8358 ]]
	local t = {}

	if not p1 then
		return t
	end

	for k, v in pairs(p1) do
		local v1

		v1 = if p2 then if v then v.Metadata and v.Metadata.ID else v elseif v then v.ID else v

		if v1 then
			t[v1] = (t[v1] or 0) + 1
		end
	end

	return t
end

local function _censusString(p1) --[[ _censusString | Line: 8373 ]]
	local t = {}

	for k, v in pairs(p1) do
		table.insert(t, tostring(k) .. "x" .. v)
	end

	table.sort(t)

	return if #t > 0 then table.concat(t, ", ") or "<empty>" else "<empty>"
end

local function _geomString(p1, p2, p3) --[[ _geomString | Line: 8385 | Upvalues: ItemDatabase (copy) ]]
	local t = {}
	local sum = 0

	for v8, v9 in pairs(if p1 then p1 else {}) do
		local v3, v4, v5, v6, v7

		if v9 and v9.ID then
			local v10 = ItemDatabase.GetItemData(v9.ID)
			local v11 = v10 and v10.Size and v10.Size.X or 0
			local v12 = v10 and v10.Size and v10.Size.Y or 0
			local v13 = v9.Rotation or 0
			local v14 = if v13 == 1 or (v13 == 3 or v13 == 90) then true elseif v13 == 270 then true else false

			v3 = if v14 and v12 then v12 else v11
			v4 = if v14 and v11 then v11 else v12
			sum = sum + v3 * v4

			local Position = v9.Position
			local format = string.format
			local v16 = tostring(v9.ID)

			if Position then
				v5 = tostring(Position.X)

				if v5 then
					v6 = t
				else
					v5 = "?"
					v6 = t
				end
			else
				v5 = "?"
				v6 = t
			end

			v7 = Position and tostring(Position.Y) or "?"
			table.insert(v6, format("%s@(%s,%s) rot=%s %dx%d", v16, v5, v7, tostring(v13), v3, v4))
		end
	end

	table.sort(t)

	return string.format("grid=%sx%s maxW=%s cells=%d/%d | %s", p2 and tostring(p2.X) or "?", p2 and tostring(p2.Y) or "?", tostring(p3), sum, p2 and p2.X * p2.Y or 0, table.concat(t, ", "))
end

local function _censusDiffers(p1, p2) --[[ _censusDiffers | Line: 8411 ]]
	for k, v in pairs(p1) do
		if (p2[k] or 0) ~= v then
			return true
		end
	end

	for k, v in pairs(p2) do
		if (p1[k] or 0) ~= v then
			return true
		end
	end

	return false
end

local function isUnsizedPlaceholder(p1, p2) --[[ isUnsizedPlaceholder | Line: 8430 ]]
	local v1 = if p1 then p1.GridSize else p1

	if not v1 or (v1.X > 1 or v1.Y > 1) then
		return false
	end

	if not (p2 and p2.Items) then
		return false
	end

	return next(p2.Items) ~= nil
end

function t.LoadInventory(p1, p2, p3) --[[ LoadInventory | Line: 8437 | Upvalues: InventoryWire (copy), _tileCensus (copy), _geomString (copy), _censusDiffers (copy), _censusString (copy), _itemIdentityKey (copy), ItemDatabase (copy), GridPack (copy), ReplicatedStorage (copy), ScaleTypeFor (copy) ]]
	local v1 = p3 and InventoryWire.IsEncoded(p3.Items) and InventoryWire.DecodeItems(p3.Items) or (if p3 then p3.Items else p3)

	if p2 == nil or p2 ~= p1.MainInventory then
		if p2 == nil or p2 ~= p1.ChestRigInventory then
			if p2 ~= nil and p2 == p1.BattleBeltInventory then
				if p1:EnsureBattleBeltGridSized() then
					p2 = p1.BattleBeltInventory
				end

				if p2 then
					local v2 = p2
					local v3 = v2 and v2.GridSize
					local v4 = if v3 and not (v3.X > 1 or v3.Y > 1) then if p3 and p3.Items then if next(p3.Items) == nil then false else true else false else false
				end
			end
		else
			if p1:EnsureChestRigGridSized() then
				p2 = p1.ChestRigInventory
			end

			if p2 then
				local v5 = p2
				local v6 = v5 and v5.GridSize
				local v7 = if v6 and not (v6.X > 1 or v6.Y > 1) then if p3 and p3.Items then if next(p3.Items) == nil then false else true else false else false
			end
		end
	else
		if p1:EnsureBackpackGridSized() then
			p2 = p1.MainInventory
		end

		if p2 then
			local v8 = p2
			local v9 = v8 and v8.GridSize
			local v10 = if v9 and not (v9.X > 1 or v9.Y > 1) then if p3 and p3.Items then if next(p3.Items) == nil then false else true else false else false
		end
	end

	local t = {
		n = 0,
		first = nil
	}
	local v11 = if p2.ChangeItem == nil then false elseif p2.GridSize == nil then true else false

	if not v11 then
		local v12 = _tileCensus(p2.Items, true)
		local v13 = _tileCensus(v1, false)
		local v14 = p2.Metadata and p2.Metadata.TiedInstance or "?"
		local v15 = tostring(v14)
		local v17 = p3 and p3.GridSize or p2.GridSize
		local v19 = p3 and p3.MaxItemWidth or p2.Metadata and p2.Metadata.MaxItemWidth
		local v20 = _geomString(v1, v17, v19)
		local GridSize = p2.GridSize
		local GuiElement = p2.GuiElement
		local format = string.format
		local v22 = GridSize and string.format("%sx%s", tostring(GridSize.X), (tostring(GridSize.Y))) or "NIL"
		local v24 = p2.Metadata and p2.Metadata.MaxItemWidth
		local v25 = tostring(v24)
		local v27 = GuiElement and tostring(GuiElement.Parent ~= nil) or "n/a"
		local Visible = p2.Visible
		local v28 = tostring(Visible)
		local v29 = if p2.Items == nil then false else true
		local v30 = format("cgrid=%s cmaxW=%s gui=%s guiParented=%s visible=%s items=%s", v22, v25, if GuiElement then "yes" else "NIL", v27, v28, (tostring(v29)))

		task.defer(function() --[[ Line: 8532 | Upvalues: _tileCensus (ref), p2 (ref), _censusDiffers (ref), v13 (copy), v15 (copy), _censusString (ref), v12 (copy), v20 (copy), v30 (copy), t (copy) ]]
			local ok, result = pcall(_tileCensus, p2.Items, true)

			if not (ok and _censusDiffers(result, v13)) then
				return
			end

			warn(string.format("[DUPDIAG] %s MISMATCH | before=[%s] server=[%s] after=[%s]", v15, _censusString(v12), _censusString(v13), (_censusString(result))))
			warn(string.format("[DUPDIAG] %s GEOM | %s", v15, v20))
			warn(string.format("[PAINTDIAG] %s CLIENT | %s | addFail=%d first=%s", v15, v30, t.n, (tostring(t.first))))
		end)
	end

	local t2 = {}

	if v1 then
		for k, v in pairs(v1) do
			local v31 = _itemIdentityKey(v)

			if v31 then
				t2[v31] = true
			end
		end
	end

	local list = {}

	if p2.Items then
		for k, v in pairs(p2.Items) do
			if v and v.Metadata then
				local Metadata = v.Metadata
				local v32 = _itemIdentityKey({
					ID = Metadata.ID,
					Position = v.Position,
					Rotation = v.Rotation,
					CurrentRounds = Metadata.CurrentRounds,
					Uses = Metadata.Uses,
					Amount = Metadata.Amount
				})

				if v32 and t2[v32] then
					t2[v32] = nil

					continue
				end

				table.insert(list, v)
			end
		end
	end

	for i, v in ipairs(list) do
		pcall(function() --[[ Line: 8718 | Upvalues: p2 (ref), v (copy) ]]
			p2:RemoveItem(v)
		end)
		pcall(function() --[[ Line: 8719 | Upvalues: v (copy) ]]
			v:Destroy()
		end)
	end

	if p2.GuiElement then
		local v33 = p2.GuiElement.Parent

		if v33 then
			for i, v in ipairs(v33:GetDescendants()) do
				if v.Name == "BarterGhostOverlay" then
					pcall(function() --[[ Line: 8732 | Upvalues: v (copy) ]]
						v:Destroy()
					end)
				end
			end
		end
	end

	if p3.TiedInstance then
		p2.Metadata.TiedInstance = p3.TiedInstance
	end

	local v34 = p1:CreateMoveMiddleware()

	for k, v in pairs(v1) do
		local v35

		if v then
			local v36 = _itemIdentityKey(v)

			if not v36 or t2[v36] then
				local v37 = ItemDatabase.GetItemData(v.ID)

				if v37 then
					local t3 = {
						Assets = {
							Item = ReplicatedStorage.GridPack.Item
						}
					}

					t3.Position = p2.ChangeItem and Vector2.new(0, 0) or v.Position
					t3.Size = v37.Size
					t3.Rotation = v.Rotation
					t3.Metadata = {
						ItemIndex = k,
						ItemType = v37.ItemType,
						ID = v.ID,
						CurrentRounds = v.CurrentRounds,
						CurrentDurability = v.CurrentDurability,
						LoadedRounds = v.LoadedRounds,
						Uses = v.Uses,
						DroppedContainerTied = v.DroppedContainerTied,
						Price = v.Price,
						Amount = v.Amount,
						TaskBound = v.TaskBound,
						TaskId = v.TaskId,
						NoteText = v.NoteText,
						NoteTitle = v.NoteTitle,
						NoteExcerpt = v.NoteExcerpt
					}
					t3.MoveMiddleware = v34

					local v39 = GridPack.createItem(t3)

					if v39.ItemElement then
						local v40 = v.CurrentRounds ~= nil and v.CurrentRounds or (v37.ItemType == "Ammo" and v37.maxRounds or (v37.ItemType == "AmmoPack" and v37.stackSize or nil))

						if v37.ItemType == "Ammo" or v37.ItemType == "AmmoPack" then
							if v40 == nil or not (v40 <= 0) then
								v39.ItemElement.BackgroundColor3 = v37.BackgroundColor
							else
								v39.ItemElement.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
							end
						else
							v39.ItemElement.BackgroundColor3 = v37.BackgroundColor
						end

						v39.ItemElement.BackgroundTransparency = v37.BackgroundTransparency or 0

						local ImageLabel = v39.ItemElement:FindFirstChildOfClass("ImageLabel")

						if ImageLabel then
							ImageLabel.Image = v37.ImageID or ""
							ImageLabel.ScaleType = ScaleTypeFor(v37)

							if (v37.ImageID == nil or v37.ImageID == "") and v37.Model then
								local ok, result = pcall(function() --[[ Line: 8805 | Upvalues: p1 (copy), v39 (copy), v37 (copy) ]]
									p1:AttachViewportIcon(v39.ItemElement, v37.Model, v37.ItemType)
								end)

								if ok then
									ImageLabel.ImageTransparency = 1
								else
									local v41 = warn

									v41("[InventoryController] AttachViewportIcon failed for " .. tostring(v37.Model) .. ": " .. tostring(result))
								end
							end
						end

						local v43 = string.upper(v37.Name or v.ID)
						local ItemNameStrip = Instance.new("Frame")

						ItemNameStrip.Name = "ItemNameStrip"
						ItemNameStrip.Size = UDim2.new(1, 0, 0, 16)
						ItemNameStrip.Position = UDim2.new(0, 0, 0, 0)
						ItemNameStrip.AnchorPoint = Vector2.new(0, 0)
						ItemNameStrip.BackgroundTransparency = 1
						ItemNameStrip.BorderSizePixel = 0
						ItemNameStrip.ZIndex = 5
						ItemNameStrip.Parent = v39.ItemElement

						local ItemNameTag = Instance.new("TextLabel")

						ItemNameTag.Name = "ItemNameTag"
						ItemNameTag.Size = UDim2.new(1, -4, 1, 0)
						ItemNameTag.Position = UDim2.new(0, 2, 0, 0)
						ItemNameTag.BackgroundTransparency = 1
						ItemNameTag.Text = v43
						ItemNameTag.TextColor3 = Color3.fromRGB(200, 200, 200)
						ItemNameTag.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
						ItemNameTag.TextSize = 14
						ItemNameTag.TextXAlignment = Enum.TextXAlignment.Left
						ItemNameTag.TextTruncate = Enum.TextTruncate.AtEnd
						ItemNameTag.ZIndex = 6
						ItemNameTag.Parent = ItemNameStrip

						if v37.ItemType == "Ammo" or v37.ItemType == "AmmoPack" then
							local v44 = v.CurrentRounds ~= nil and v.CurrentRounds or (v37.maxRounds or (v37.stackSize or 0))
							local RoundCount = Instance.new("TextLabel")

							RoundCount.Name = "RoundCount"
							RoundCount.Size = UDim2.fromScale(0.45, 0.25)
							RoundCount.Position = UDim2.fromScale(0.55, 0.75)
							RoundCount.AnchorPoint = Vector2.new(0, 0)
							RoundCount.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
							RoundCount.BackgroundTransparency = 0.4
							RoundCount.BorderSizePixel = 0
							RoundCount.Text = tostring(v44)
							RoundCount.TextColor3 = v44 > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 80, 80)
							RoundCount.TextScaled = true
							RoundCount.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
							RoundCount.ZIndex = 5
							RoundCount.Parent = v39.ItemElement
						end

						if v37.IsCurrency and (v.Amount and v.Amount > 0) then
							local CurrencyAmount = Instance.new("TextLabel")

							CurrencyAmount.Name = "CurrencyAmount"
							CurrencyAmount.AnchorPoint = Vector2.new(1, 1)
							CurrencyAmount.Position = UDim2.new(1, -2, 1, -2)
							CurrencyAmount.Size = UDim2.new(1, -4, 0, 16)
							CurrencyAmount.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
							CurrencyAmount.BackgroundTransparency = 0.35
							CurrencyAmount.BorderSizePixel = 0
							CurrencyAmount.TextColor3 = Color3.fromRGB(240, 220, 130)
							CurrencyAmount.TextStrokeTransparency = 0.6
							CurrencyAmount.TextSize = 13
							CurrencyAmount.Font = Enum.Font.GothamBold
							CurrencyAmount.TextXAlignment = Enum.TextXAlignment.Right
							CurrencyAmount.Text = string.format("\226\130\189%d", v.Amount)
							CurrencyAmount.ZIndex = 7
							CurrencyAmount.Parent = v39.ItemElement
						end

						if v.Quantity and v.Quantity > 1 then
							local StockOverlay = Instance.new("TextLabel")

							StockOverlay.Name = "StockOverlay"
							StockOverlay.AnchorPoint = Vector2.new(1, 0)
							StockOverlay.Position = UDim2.new(1, -2, 0, 18)
							StockOverlay.Size = UDim2.new(0, 40, 0, 16)
							StockOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
							StockOverlay.BackgroundTransparency = 0.35
							StockOverlay.BorderSizePixel = 0
							StockOverlay.TextColor3 = Color3.fromRGB(220, 220, 220)
							StockOverlay.TextStrokeTransparency = 0.6
							StockOverlay.TextSize = 13
							StockOverlay.Font = Enum.Font.RobotoMono
							StockOverlay.TextXAlignment = Enum.TextXAlignment.Right
							StockOverlay.Text = "x" .. tostring(v.Quantity)
							StockOverlay.ZIndex = 7
							StockOverlay.Parent = v39.ItemElement
						end

						if v.Price then
							local PriceOverlay = Instance.new("TextLabel")

							PriceOverlay.Name = "PriceOverlay"
							PriceOverlay.AnchorPoint = Vector2.new(0, 1)
							PriceOverlay.Position = UDim2.new(0, 2, 1, -2)
							PriceOverlay.Size = UDim2.new(0, 60, 0, 16)
							PriceOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
							PriceOverlay.BackgroundTransparency = 0.35
							PriceOverlay.BorderSizePixel = 0
							PriceOverlay.TextColor3 = Color3.fromRGB(240, 220, 130)
							PriceOverlay.TextStrokeTransparency = 0.6
							PriceOverlay.TextSize = 13
							PriceOverlay.Font = Enum.Font.RobotoMono
							PriceOverlay.TextXAlignment = Enum.TextXAlignment.Left
							PriceOverlay.Text = "\226\130\189" .. tostring(v.Price)
							PriceOverlay.ZIndex = 7
							PriceOverlay.Parent = v39.ItemElement
						end

						if v37.MaxUses and v37.MaxUses > 1 then
							local UsesCount = Instance.new("TextLabel")

							UsesCount.Name = "UsesCount"
							UsesCount.Size = UDim2.fromScale(0.45, 0.25)
							UsesCount.Position = UDim2.fromScale(0.55, 0.75)
							UsesCount.AnchorPoint = Vector2.new(0, 0)
							UsesCount.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
							UsesCount.BackgroundTransparency = 0.4
							UsesCount.BorderSizePixel = 0

							local v47 = tostring(v.Uses or v37.MaxUses)

							UsesCount.Text = v47 .. "/" .. tostring(v37.MaxUses)
							UsesCount.TextColor3 = Color3.fromRGB(255, 255, 255)
							UsesCount.TextScaled = true
							UsesCount.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
							UsesCount.ZIndex = 5
							UsesCount.Parent = v39.ItemElement
						end

						if v.Revealed == false then
							v39.ItemElement:SetAttribute("ItemIndex", k)

							local SilhouetteOverlay = Instance.new("Frame")

							SilhouetteOverlay.Name = "SilhouetteOverlay"
							SilhouetteOverlay.Size = UDim2.fromScale(1, 1)
							SilhouetteOverlay.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
							SilhouetteOverlay.BackgroundTransparency = 0
							SilhouetteOverlay.BorderSizePixel = 0
							SilhouetteOverlay.ZIndex = 50
							SilhouetteOverlay.Parent = v39.ItemElement

							local Glyph = Instance.new("TextLabel")

							Glyph.Name = "Glyph"
							Glyph.Size = UDim2.fromScale(1, 1)
							Glyph.BackgroundTransparency = 1
							Glyph.Text = "?"
							Glyph.TextColor3 = Color3.fromRGB(160, 160, 160)
							Glyph.TextScaled = true
							Glyph.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
							Glyph.TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255)
							Glyph.TextStrokeTransparency = 0.4
							Glyph.ZIndex = 51
							Glyph.Parent = SilhouetteOverlay
						end

						local t4 = {
							tl = {
								[0] = { 0, 0, 0, 0, 0 },
								[90] = { 0, 1, 0, 1, -90 },
								[180] = { 1, 1, 1, 1, 180 },
								[270] = { 1, 0, 1, 0, 90 }
							},
							tr = {
								[0] = { 1, 0, 1, 0, 0 },
								[90] = { 0, 0, 0, 0, -90 },
								[180] = { 0, 1, 0, 1, 180 },
								[270] = { 1, 1, 1, 1, 90 }
							},
							bl = {
								[0] = { 0, 1, 0, 1, 0 },
								[90] = { 1, 1, 1, 1, -90 },
								[180] = { 1, 0, 1, 0, 180 },
								[270] = { 0, 0, 0, 0, 90 }
							},
							br = {
								[0] = { 1, 1, 1, 1, 0 },
								[90] = { 1, 0, 1, 0, -90 },
								[180] = { 0, 0, 0, 0, 180 },
								[270] = { 0, 1, 0, 1, 90 }
							}
						}
						local t5 = {
							[0] = {
								0,
								0,
								0,
								0,
								0,
								0,
								UDim2.new(1, 0, 0, 16),
								0
							},
							[90] = {
								1,
								0,
								1,
								0,
								0,
								0,
								UDim2.new(0, 16, 1, 0),
								-90
							},
							[180] = {
								1,
								1,
								1,
								0,
								1,
								0,
								UDim2.new(1, 0, 0, 16),
								180
							},
							[270] = {
								0,
								0,
								0,
								0,
								0,
								0,
								UDim2.new(0, 16, 1, 0),
								90
							}
						}
						local t6 = {
							RoundCount = "br",
							UsesCount = "br",
							CurrencyAmount = "br",
							StockOverlay = "tr",
							PriceOverlay = "bl"
						}

						local function applyLayout() --[[ applyLayout | Line: 9011 | Upvalues: v39 (copy), t5 (copy), t6 (copy), t4 (copy) ]]
							local ItemElement = v39.ItemElement

							if not ItemElement then
								return
							end

							local sum = (ItemElement.Rotation or 0) % 360

							if sum < 0 then
								sum = sum + 360
							end

							local v1 = math.floor((sum + 45) / 90) * 90 % 360
							local ItemNameStrip = ItemElement:FindFirstChild("ItemNameStrip")

							if ItemNameStrip then
								local v2 = t5[v1]

								ItemNameStrip.AnchorPoint = Vector2.new(v2[1], v2[2])
								ItemNameStrip.Position = UDim2.new(v2[3], 0, v2[5], 0)
								ItemNameStrip.Size = v2[7]
								ItemNameStrip.Rotation = v2[8]
							end

							for k, v in pairs(t6) do
								local v3 = ItemElement:FindFirstChild(k, true)

								if v3 then
									local v4 = t4[v][v1]

									v3.AnchorPoint = Vector2.new(v4[1], v4[2])
									v3.Position = UDim2.new(v4[3], 0, v4[4], 0)
									v3.Rotation = v4[5]
								end
							end
						end

						applyLayout()
						v39.ItemElement:GetPropertyChangedSignal("Rotation"):Connect(applyLayout)
					end

					local ok, result = pcall(function() --[[ Line: 9045 | Upvalues: p2 (ref), v39 (copy) ]]
						if p2.ChangeItem then
							p2:ChangeItem(v39)
						else
							p2:AddItem(v39)
						end
					end)

					if not ok and (p2.GridSize and not p2.ChangeItem) then
						local X = p2.GridSize.X
						local Y = p2.GridSize.Y

						local function footprint(p1) --[[ footprint | Line: 9065 | Upvalues: v37 (copy) ]]
							if p1 == 1 then
								return v37.Size.Y, v37.Size.X
							end

							return v37.Size.X, v37.Size.Y
						end

						local v48 = v39.Rotation or 0

						v35 = if v48 == 1 or (v48 == 3 or (v48 == 90 or v48 == 270)) then 1 else 0

						local list2 = { v35 }

						if v37.Size.X ~= v37.Size.Y then
							table.insert(list2, 1 - v35)
						end

						for i, v2 in ipairs(list2) do
							local v49

							if ok then
								break
							end

							local v50

							if v2 == 1 then
								v50 = v37.Size.Y
								v49 = v37.Size.X
							else
								v50 = v37.Size.X
								v49 = v37.Size.Y
							end

							v39.Rotation = v2

							for i2 = 0, math.max(0, Y - v49) do
								if ok then
									break
								end

								for j = 0, math.max(0, X - v50) do
									v39.Position = Vector2.new(j, i2)

									if pcall(function() --[[ Line: 9081 | Upvalues: p2 (ref), v39 (copy) ]]
										p2:AddItem(v39)
									end) then
										ok = true

										break
									end
								end
							end
						end

						if not ok then
							v39.Rotation = v48
						end
					end

					if ok then
						if p2.GridSize then
							task.defer(function() --[[ Line: 9111 | Upvalues: p1 (copy), v39 (copy) ]]
								p1:ConvertItemToScale(v39)
							end)
						else
							task.defer(function() --[[ Line: 9121 | Upvalues: v39 (copy), p2 (ref) ]]
								local ItemElement = v39.ItemElement

								if not ItemElement then
									return
								end

								local v1 = false
								local v2 = nil
								local v3 = nil

								local function disconnect() --[[ disconnect | Line: 9126 | Upvalues: v2 (ref), v3 (ref) ]]
									if v2 then
										v2:Disconnect()
										v2 = nil
									end

									if not v3 then
										return
									end

									v3:Disconnect()
									v3 = nil
								end

								local function enforce() --[[ enforce | Line: 9130 | Upvalues: v1 (ref), v39 (ref), p2 (ref), v2 (ref), v3 (ref), ItemElement (copy) ]]
									if v1 then
										return
									end

									if v39.IsDragging then
										return
									end

									if p2.Item == v39 then
										v1 = true
										ItemElement.Size = UDim2.fromScale(1, 1)
										ItemElement.Position = UDim2.fromScale(0, 0)
										v1 = false

										return
									end

									if v2 then
										v2:Disconnect()
										v2 = nil
									end

									if not v3 then
										return
									end

									v3:Disconnect()
									v3 = nil
								end

								if not (v1 or v39.IsDragging) then
									if p2.Item == v39 then
										v1 = true
										ItemElement.Size = UDim2.fromScale(1, 1)
										ItemElement.Position = UDim2.fromScale(0, 0)
										v1 = false
									else
										if v2 then
											v2:Disconnect()
											v2 = nil
										end

										if v3 then
											v3:Disconnect()
											v3 = nil
										end
									end
								end

								v2 = ItemElement:GetPropertyChangedSignal("Size"):Connect(enforce)
								v3 = ItemElement:GetPropertyChangedSignal("Position"):Connect(enforce)
							end)
						end

						p1:BindDropHandler(v39, p2)

						continue
					end

					t.n = t.n + 1

					if t.first == nil then
						t.first = string.format("%s@%s: %s", tostring(v.ID), tostring(v.Position), (tostring(result)))
					end

					local v52 = warn
					local v53 = tostring(v.Position)
					local GridSize = p2.GridSize

					v52("Failed to add item to grid:", v.ID, "at index:", k, "| server pos:", v53, "| grid size:", tostring(GridSize), "| err:", (tostring(result)))

					continue
				end

				warn("Failed to load item - no database entry for:", v.ID)
			end
		end
	end
end
function t.BindEquipHint(p1, p2) --[[ BindEquipHint | Line: 9159 ]]
	if not (p2 and p2.ItemElement) then
		return
	end

	local v1 = p2.Metadata and p2.Metadata.ItemType

	if not v1 then
		return
	end

	local v2 = ({
		HeadGear = p1.HeadSlot,
		FaceWear = p1.FaceWearSlot,
		EyeWear = p1.EyeWearSlot,
		BodyGear = p1.BodySlot,
		BeltGear = p1.BeltGearSlot,
		Primary = p1.PrimarySlot,
		Secondary = p1.SecondarySlot,
		Sidearm = p1.SidearmSlot,
		Melee = p1.MeleeSlot,
		Uniform = p1.UniformSlot,
		Backpack = p1.BackpackSlot,
		NightOptical = p1.NightOpticalSlot
	})[v1]
	local v3 = v1 == "Primary" and p1.SecondarySlot or nil

	if not v2 then
		return
	end

	local v4 = nil
	local v5 = nil
	local t = {}

	local function createHint(p1) --[[ createHint | Line: 9188 | Upvalues: t (ref) ]]
		if not (p1 and p1.GuiElement) then
			return nil
		end

		local GuiElement = p1.GuiElement

		if GuiElement.Parent and GuiElement.Parent:IsA("GuiObject") then
			GuiElement = GuiElement.Parent
		end

		local EquipHintStroke = GuiElement:FindFirstChild("EquipHintStroke")
		local EquipHintStroke2

		if not EquipHintStroke then
			local v1

			EquipHintStroke2 = Instance.new("UIStroke")
			EquipHintStroke2.Name = "EquipHintStroke"
			EquipHintStroke2.Color = Color3.fromRGB(220, 200, 50)
			EquipHintStroke2.Thickness = 3
			EquipHintStroke2.Transparency = 0
			EquipHintStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			EquipHintStroke2.Parent = GuiElement
			v1 = t
			table.insert(t, EquipHintStroke2)

			return EquipHintStroke2
		end

		EquipHintStroke:Destroy()
		EquipHintStroke2 = Instance.new("UIStroke")
		EquipHintStroke2.Name = "EquipHintStroke"
		EquipHintStroke2.Color = Color3.fromRGB(220, 200, 50)
		EquipHintStroke2.Thickness = 3
		EquipHintStroke2.Transparency = 0
		EquipHintStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		EquipHintStroke2.Parent = GuiElement
		table.insert(t, EquipHintStroke2)

		return EquipHintStroke2
	end

	local function removeHints() --[[ removeHints | Line: 9209 | Upvalues: t (ref), v4 (ref), v5 (ref) ]]
		for i, v in ipairs(t) do
			if v and v.Parent then
				v:Destroy()
			end
		end

		t = {}
		v4 = nil
		v5 = nil
	end

	local InteractionButton = p2.ItemElement:FindFirstChild("InteractionButton")

	if InteractionButton then
		InteractionButton.MouseButton1Down:Connect(function() --[[ Line: 9221 | Upvalues: p2 (copy), v4 (ref), createHint (copy), v2 (copy), v3 (copy), v5 (ref), v1 (copy) ]]
			task.defer(function() --[[ Line: 9222 | Upvalues: p2 (ref), v4 (ref), createHint (ref), v2 (ref), v3 (ref), v5 (ref), v1 (ref) ]]
				task.wait()

				if not p2.IsDragging then
					return
				end

				v4 = createHint(v2)

				if v3 then
					v5 = createHint(v3)
				end

				print("[Hint] showing for", v1, "target=", v4 and v4:GetFullName())
			end)
		end)
		InteractionButton.MouseButton1Up:Connect(function() --[[ Line: 9232 | Upvalues: removeHints (copy) ]]
			removeHints()
		end)
		p2.ItemElement:GetPropertyChangedSignal("GroupTransparency"):Connect(function() --[[ Line: 9237 | Upvalues: p2 (copy), removeHints (copy) ]]
			if not (p2.ItemElement.GroupTransparency < 0.1) then
				return
			end

			removeHints()
		end)
	end
end

local function parentSizeInCells(p1) --[[ parentSizeInCells | Line: 9281 ]]
	local ItemManager = p1.ItemManager

	if not (ItemManager and (ItemManager.GridSize and ItemManager.GuiElement)) then
		return 1, 1
	end

	local Size = ItemManager.GuiElement.Size
	local v1 = 1
	local v2 = if Size.X.Scale > 0 then ItemManager.GridSize.X / Size.X.Scale else 1

	if Size.Y.Scale > 0 then
		v1 = ItemManager.GridSize.Y / Size.Y.Scale
	end

	if v2 <= 0 then
		v2 = 1
	end

	if v1 <= 0 then
		v1 = 1
	end

	return v2, v1
end

function t.ConvertItemToScale(p1, p2) --[[ ConvertItemToScale | Line: 9293 | Upvalues: parentSizeInCells (copy) ]]
	if not (p2 and p2.ItemElement) then
		return
	end

	task.wait(0.3)

	local v1 = p2.Position or Vector2.new(0, 0)
	local v2 = p2.Size or Vector2.new(1, 1)
	local v3 = p2.Rotation or 0
	local X2 = v1.X
	local Y2 = v1.Y

	if v3 == 90 or v3 == 1 then
		X2 = v1.X + (v2.Y - v2.X) / 2
		Y2 = v1.Y + (v2.X - v2.Y) / 2
	elseif v3 == 180 or v3 == 2 then
		X2 = v1.X
		Y2 = v1.Y
	elseif v3 == 270 or v3 == 3 then
		X2 = v1.X + (v2.Y - v2.X) / 2
		Y2 = v1.Y + (v2.X - v2.Y) / 2
	end

	local v4, v5 = parentSizeInCells(p2)

	p2.ItemElement.Position = UDim2.fromScale(X2 / v4, Y2 / v5)
	p2.ItemElement.Size = UDim2.fromScale(v2.X / v4, v2.Y / v5)
end
function t.CreateGridIsColliding(p1) --[[ CreateGridIsColliding | Line: 9341 | Upvalues: ItemDatabase (copy) ]]
	return function(p12, p2, p3, p4, p5) --[[ Line: 9342 | Upvalues: ItemDatabase (ref), p1 (copy) ]]
		if not p12.GuiElement then
			return true
		end

		local v1 = ItemDatabase.GetItemData(p2.Metadata.ID)

		if not v1 then
			return true
		end

		local v2 = if p5 == nil then if p2.PotentialRotation == nil then p2.Rotation or 0 else p2.PotentialRotation else p5
		local v3 = if v2 == 1 or (v2 == 3 or v2 == 90) then true else v2 == 270
		local v4 = v3 and v1.Size.Y or v1.Size.X
		local v5 = v3 and v1.Size.X or v1.Size.Y

		if p12.GridSize.X < v4 or p12.GridSize.Y < v5 then
			return true
		end

		local v6 = p12.Metadata and p12.Metadata.MaxItemWidth

		if v6 and v6 < v4 then
			return true
		end

		local v7 = if p4 then p4 else p2.Position

		if not v7 then
			return true
		end

		if v7.X < 0 or v7.Y < 0 then
			return true
		end

		if v7.X + v4 > p12.GridSize.X or v7.Y + v5 > p12.GridSize.Y then
			return true
		end

		local t = {}

		if p3 then
			for k, v in pairs(p3) do
				t[v] = true
			end
		end

		t[p2] = true

		local v8 = pairs

		for v10, v11 in v8(p12.Items or {}) do
			if not t[v11] then
				local v12 = ItemDatabase.GetItemData(v11.Metadata.ID)

				if v12 and v11.Position then
					local v13 = v11.Rotation or 0
					local v14 = if v13 == 1 or (v13 == 3 or v13 == 90) then true else v13 == 270
					local X = v7.X
					local Y = v7.Y
					local X2 = v11.Position.X
					local Y2 = v11.Position.Y

					if not (X + v4 <= X2 or (X2 + (v14 and v12.Size.Y or v12.Size.X) <= X or (Y + v5 <= Y2 or Y2 + (v14 and v12.Size.X or v12.Size.Y) <= Y))) then
						if (p2.IsDragging or p2.IsDropping) and ((v1.ItemType == "Ammo" or v1.ItemType == "AmmoPack") and (v12.ItemType == "Ammo" and v1.ammoType == v12.ammoType)) then
							continue
						end

						if not (p2.IsDragging or p2.IsDropping) then
							return true
						end

						if v1.ItemType ~= "AmmoPack" or (v12.ItemType ~= "AmmoPack" or p2.Metadata.ID ~= v11.Metadata.ID) then
							return true
						end
					end
				end
			end
		end

		local v17 = ipairs

		for v19, v20 in v17(p1.BuyCartGhosts or {}) do
			if v20.grid == p12 and (v20.position and v20.size) then
				local X = v7.X
				local Y = v7.Y
				local X2 = v20.position.X
				local Y2 = v20.position.Y

				if not (X + v4 <= X2 or (X2 + v20.size.X <= X or (Y + v5 <= Y2 or Y2 + v20.size.Y <= Y))) then
					return true
				end
			end
		end

		return false
	end
end
function t.ClearGridPackInventory(p1, p2) --[[ ClearGridPackInventory | Line: 9507 ]]
	if not p2 then
		return
	end

	for k, v in pairs((table.clone(p2.Items or {}))) do
		pcall(function() --[[ Line: 9519 | Upvalues: p2 (copy), v (copy) ]]
			p2:RemoveItem(v)
		end)
		pcall(function() --[[ Line: 9520 | Upvalues: v (copy) ]]
			v:Destroy()
		end)
	end

	if not p2.ClearItems then
		return
	end

	pcall(function() --[[ Line: 9524 | Upvalues: p2 (copy) ]]
		p2:ClearItems(false)
	end)
end

return t