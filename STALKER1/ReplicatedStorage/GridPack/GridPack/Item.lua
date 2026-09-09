-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local signal = require(script.Parent.Parent.signal)
local trove = require(script.Parent.Parent.trove)
local v1 = GuiService:GetGuiInset()

require(script.Parent.Types)

local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 99 | Upvalues: t (copy), trove (copy), signal (copy), UserInputService (copy), v1 (copy), TweenService (copy) ]]
	local v2 = setmetatable({}, t)

	v2._trove = trove.new()
	v2._itemManagerTrove = v2._trove:Add(trove.new())
	v2._draggingTrove = v2._trove:Add(trove.new())
	v2.Assets = p1.Assets or {}

	if v2.Assets.Item == nil then
		v2.Assets.Item = v2:_createDefaultItemAsset()
	end

	v2.Position = p1.Position or Vector2.zero
	v2.LastItemManagerParentAbsolutePosition = Vector2.zero
	v2.PositionChanged = signal.new()
	v2.Size = p1.Size or Vector2.new(2, 2)
	v2.Rotation = p1.Rotation or 0
	v2.PotentialRotation = v2.Rotation
	v2.ItemElement = v2:_generateItemElement()
	v2.ItemManager = nil
	v2.ItemManagerChanged = signal.new()
	v2.HoveringItemManager = nil
	v2.HoveringItemManagerChanged = signal.new()
	v2.MoveMiddleware = p1.MoveMiddleware
	v2.RenderMiddleware = p1.RenderMiddleware
	v2.IsDraggable = true
	v2.IsDragging = false
	v2.MouseDraggingPivot = Vector2.zero
	v2.RotateKeyCode = Enum.KeyCode.R
	v2.Metadata = p1.Metadata or {}
	v2._trove:Add(function() --[[ Line: 136 | Upvalues: v2 (copy) ]]
		if not v2.ItemManager then
			return
		end

		v2.ItemManager:RemoveItem(v2)
	end)
	v2._trove:Add(v2.ItemManagerChanged:Connect(function(p1, p2) --[[ Line: 143 | Upvalues: v2 (copy) ]]
		v2._itemManagerTrove:Clean()

		if v2.ItemManager then
			v2.LastItemManagerParentAbsolutePosition = v2.ItemManager.GuiElement.Parent.AbsolutePosition
		end

		v2.ItemManager = p1

		if v2.ItemManager == nil then
			v2.ItemElement.Parent = nil
		else
			v2.ItemElement.Visible = v2.ItemManager.Visible

			local v1 = v2.ItemManager.GuiElement.Parent.AbsolutePosition - v2.LastItemManagerParentAbsolutePosition

			v2.ItemElement.Position = UDim2.fromOffset(v2.ItemElement.Position.X.Offset - v1.X, v2.ItemElement.Position.Y.Offset - v1.Y)
			v2:_updateItemToItemManagerDimentions(true, true, p2, p2)
			v2._itemManagerTrove:Add(v2.ItemManager.GuiElement:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() --[[ Line: 160 | Upvalues: v2 (ref) ]]
				v2:_updateItemToItemManagerDimentions(true, false, false, false)
			end))
			v2._itemManagerTrove:Add(v2.ItemManager.GuiElement:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 163 | Upvalues: v2 (ref) ]]
				v2:_updateItemToItemManagerDimentions(true, true, false, false)
			end))
			v2._itemManagerTrove:Add(v2.ItemManager.VisibilityChanged:Connect(function(p1) --[[ Line: 167 | Upvalues: v2 (ref) ]]
				v2.ItemElement.Visible = p1
			end))
			v2.ItemElement.Parent = v2.ItemManager.GuiElement.Parent
		end
	end))
	v2._trove:Add(v2.ItemElement:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 178 | Upvalues: v2 (copy) ]]
		if not v2.IsDragging then
			return
		end

		v2:_updateDraggingPosition()
	end))

	local InteractionButton = v2.ItemElement:FindFirstChild("InteractionButton")

	assert(InteractionButton, "Couldn\'t find a button named \"InteractionButton\" in the ItemElement")
	v2._highlight = nil
	v2._trove:Add(InteractionButton.MouseButton1Down:Connect(function() --[[ Line: 188 | Upvalues: v2 (copy), UserInputService (ref), v1 (ref), TweenService (ref) ]]
		if v2.ItemManager == nil or not v2.IsDraggable then
			return
		end

		v2.IsDraggable = false
		v2.IsDragging = true

		local v12 = UserInputService:GetMouseLocation() - v1
		local AbsolutePosition = v2.ItemElement.AbsolutePosition

		v2.MouseDraggingPivot = (v12 - AbsolutePosition) / (AbsolutePosition + v2.ItemElement.AbsoluteSize - AbsolutePosition)
		TweenService:Create(v2.ItemElement, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			GroupTransparency = 0.5
		}):Play()

		local ItemElement = v2.ItemElement

		ItemElement.ZIndex = ItemElement.ZIndex + 1
		v2._draggingTrove:Add(UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 203 | Upvalues: v2 (ref) ]]
			if p2 ~= false or (p1.KeyCode ~= v2.RotateKeyCode or not v2.IsDragging) then
				return
			end

			if v2.ItemManager and not v2.ItemManager.GridSize then
				return
			end

			v2:Rotate(1)
		end))

		local Size = v2.Size

		if v2.PotentialRotation % 2 == 1 then
			Size = Vector2.new(v2.Size.Y, v2.Size.X)
		end

		local v3 = v2.ItemManager:GetItemManagerPositionFromAbsolutePosition(v2.ItemElement.AbsolutePosition, v2.Size, v2.PotentialRotation)

		v2._highlight = v2._draggingTrove:Add(v2.ItemManager:CreateHighlight(100, v3, Size, Color3.new(0, 0.666667, 0)))
		v2:_updateDraggingPosition()
	end))
	v2._trove:Add(UserInputService.InputChanged:Connect(function(p1) --[[ Line: 235 | Upvalues: v2 (copy) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseMovement or (v2.IsDragging ~= true or v2.ItemManager == nil) then
			return
		end

		if next(v2.ItemManager.ConnectedTransferLinks) ~= nil then
			for k, v in pairs(v2.ItemManager.ConnectedTransferLinks) do
				local v1 = v:GetClosestItemOverlappingItemManagers(v2)[1]

				if v1 ~= nil and v2.HoveringItemManager ~= v1 then
					v2.HoveringItemManager = v1
					v2.HoveringItemManagerChanged:Fire(v2.HoveringItemManager)
					v2._highlight:SetItemManager(100, v2.HoveringItemManager)
					v2:_updateItemToItemManagerDimentions(false, true, false, true, v2.HoveringItemManager)

					break
				end
			end
		end

		if not (v2.HoveringItemManager or v2.ItemManager) then
			return
		end

		v2:_updateDraggingPosition()
	end))
	v2._trove:Add(UserInputService.InputEnded:Connect(function(p1) --[[ Line: 261 | Upvalues: v2 (copy), TweenService (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 or (v2.IsDragging ~= true or v2.ItemManager == nil) then
			return
		end

		v2.IsDragging = false
		v2.IsDropping = true

		local v1 = v2.HoveringItemManager or v2.ItemManager
		local v22 = v1:GetItemManagerPositionFromAbsolutePosition(v2.ItemElement.AbsolutePosition, v2.Size, v2.PotentialRotation)

		if v1:IsColliding(v2, { v2 }, v22, v2.PotentialRotation) == false then
			local v3 = if v2.HoveringItemManager and v2.HoveringItemManager ~= v2.ItemManager then v2.HoveringItemManager else nil
			local v4 = if v2.MoveMiddleware then v2.MoveMiddleware(v2, v22, v2.PotentialRotation, v2.ItemManager, v3) else nil

			if v4 == true or v4 == nil then
				v2.Position = v22
				v2.PositionChanged:Fire(v22)
				v2.Rotation = v2.PotentialRotation

				if v3 then
					v2:SetItemManager(v2.HoveringItemManager)
				end
			end
		end

		v2.PotentialRotation = v2.Rotation
		v2.HoveringItemManager = nil
		v2.HoveringItemManagerChanged:Fire(v2.HoveringItemManager)
		v2:_updateItemToItemManagerDimentions(true, true, true, true)
		TweenService:Create(v2.ItemElement, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			GroupTransparency = 0
		}):Play()

		local ItemElement = v2.ItemElement

		ItemElement.ZIndex = ItemElement.ZIndex - 1
		v2._draggingTrove:Clean()
		v2.IsDropping = false
		v2.IsDraggable = true
	end))

	if v2.RenderMiddleware then
		v2.RenderMiddleware(v2.ItemElement)
	end

	return v2
end
function t._createDefaultItemAsset(p1) --[[ _createDefaultItemAsset | Line: 333 ]]
	local ItemElement = Instance.new("CanvasGroup")

	ItemElement.Name = "ItemElement"
	ItemElement.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	ItemElement.BorderSizePixel = 0
	ItemElement.Size = UDim2.fromOffset(140, 140)
	ItemElement.ZIndex = 2

	local Image = Instance.new("ImageLabel")

	Image.Name = "Image"
	Image.Image = ""
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Image.BackgroundTransparency = 1
	Image.BorderSizePixel = 0
	Image.Size = UDim2.fromScale(1, 1)
	Image.Parent = ItemElement

	local InteractionButton = Instance.new("TextButton")

	InteractionButton.Name = "InteractionButton"
	InteractionButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	InteractionButton.Text = ""
	InteractionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	InteractionButton.TextSize = 14
	InteractionButton.TextTransparency = 1
	InteractionButton.AutoButtonColor = false
	InteractionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	InteractionButton.BackgroundTransparency = 1
	InteractionButton.Size = UDim2.fromScale(1, 1)
	InteractionButton.Parent = ItemElement

	local UICorner = Instance.new("UICorner")

	UICorner.Name = "UICorner"
	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = ItemElement

	return ItemElement
end
function t._generateItemElement(p1) --[[ _generateItemElement | Line: 377 ]]
	local v1 = p1._trove:Add(p1.Assets.Item:Clone())

	if p1.ItemManager then
		v1.Visible = p1.ItemManager.Visible
	end

	return v1
end
function t._updateDraggingPosition(p1) --[[ _updateDraggingPosition | Line: 392 | Upvalues: UserInputService (copy), v1 (copy) ]]
	local v12 = UserInputService:GetMouseLocation() - v1
	local AbsolutePosition = p1.ItemManager.GuiElement.Parent.AbsolutePosition

	if p1.HoveringItemManager then
		local isHoveringItemManager = p1.ItemManager == p1.HoveringItemManager
	end

	p1.ItemElement.Position = UDim2.fromOffset(v12.X - p1.MouseDraggingPivot.X * p1.ItemElement.AbsoluteSize.X - AbsolutePosition.X, v12.Y - p1.MouseDraggingPivot.Y * p1.ItemElement.AbsoluteSize.Y - AbsolutePosition.Y)

	if not p1._highlight then
		return
	end

	local v2 = p1.HoveringItemManager or p1.ItemManager
	local v3 = v2:GetItemManagerPositionFromAbsolutePosition(p1.ItemElement.AbsolutePosition, p1.Size, p1.PotentialRotation)

	p1._highlight.Position = v3

	if v2:IsColliding(p1, { p1 }, v3, p1.PotentialRotation) == true then
		p1._highlight.Color = Color3.new(255/255, 0/255, 0/255)
	else
		p1._highlight.Color = Color3.new(0, 0.666667, 0)
	end
end
function t._updateItemToItemManagerDimentions(p1, p2, p3, p4, p5, p6) --[[ _updateItemToItemManagerDimentions | Line: 430 | Upvalues: TweenService (copy) ]]
	local v1 = if p6 then p6 else p1.ItemManager

	if p2 then
		local zero = Vector2.zero

		if p1.Rotation % 2 == 1 then
			zero = Vector2.new(p1.Size.Y, p1.Size.X) / 2 - p1.Size / 2
		end

		local v2 = v1:GetOffset(p1.Rotation)
		local v3 = v1:GetSizeScale()
		local v4 = UDim2.fromOffset((p1.Position.X + zero.X) * v3.X + v2.X - p1.ItemManager.GuiElement.Parent.AbsolutePosition.X, (p1.Position.Y + zero.Y) * v3.Y + v2.Y - p1.ItemManager.GuiElement.Parent.AbsolutePosition.Y)

		if p4 then
			TweenService:Create(p1.ItemElement, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				Position = v4,
				Rotation = p1.Rotation * 90
			}):Play()
		else
			p1.ItemElement.Position = v4
			p1.ItemElement.Rotation = p1.Rotation * 90
		end
	end

	if not p3 then
		return
	end

	local v5 = v1:GetAbsoluteSizeFromItemSize(p1.Size, p1.Rotation)
	local v6 = UDim2.fromOffset(v5.X, v5.Y)

	if p5 then
		TweenService:Create(p1.ItemElement, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Size = v6
		}):Play()

		return
	end

	p1.ItemElement.Size = v6
end
function t.Rotate(p1, p2) --[[ Rotate | Line: 466 | Upvalues: TweenService (copy) ]]
	assert(p1.IsDragging, "Must be dragging to rotate an item!")
	p1.PotentialRotation = p1.PotentialRotation + p2

	if p1.PotentialRotation > 3 then
		p1.ItemElement.Rotation = -90
		p1.PotentialRotation = p1.PotentialRotation - 4
	elseif p1.PotentialRotation < 0 then
		p1.ItemElement.Rotation = 360
		p1.PotentialRotation = p1.PotentialRotation + 4
	end

	if p1._highlight then
		p1._highlight.Position = (p1.HoveringItemManager or p1.ItemManager):GetItemManagerPositionFromAbsolutePosition(p1.ItemElement.AbsolutePosition, p1.Size, p1.PotentialRotation)

		if p1.PotentialRotation % 2 == 1 then
			p1._highlight.Size = Vector2.new(p1.Size.Y, p1.Size.X)
		else
			p1._highlight.Size = p1.Size
		end
	end

	TweenService:Create(p1.ItemElement, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
		Rotation = p1.PotentialRotation * 90
	}):Play()
end
function t.SetItemManager(p1, p2) --[[ SetItemManager | Line: 498 ]]
	if p1.ItemManager ~= nil then
		p1.ItemManager:RemoveItem(p1)
	end

	repeat
		task.wait()
	until p1.ItemManager == nil

	if p2.Items then
		p2:AddItem(p1, nil, true)
	else
		p2:ChangeItem(p1, nil, true)
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 519 ]]
	p1._trove:Destroy()
end

return t