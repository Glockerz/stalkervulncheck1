-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local signal = require(script.Parent.Parent.Parent.signal)
local v1 = require(script.Parent)

require(script.Parent.Parent.Types)

local v2 = setmetatable({}, v1)

v2.__index = v2
function v2.new(p1) --[[ new | Line: 67 | Upvalues: v1 (copy), v2 (copy), signal (copy), RunService (copy) ]]
	local v3 = setmetatable(v1.new(p1), v2)
	local v4, v5 = v3:_createGuiElement(p1)

	v3.GuiElement = v4
	v3.SlotElements = v5
	v3.GridSize = p1.GridSize
	v3.SlotAspectRatio = p1.SlotAspectRatio
	v3.Items = {}
	v3.ItemAdded = signal.new()
	v3.ItemRemoved = signal.new()
	v3:_updateGuiGrid()
	v3._trove:Add(RunService.RenderStepped:Connect(function() --[[ Line: 80 | Upvalues: v3 (copy) ]]
		for k, v in pairs(v3.SlotElements) do
			v.GroupColor3 = Color3.new(0.105882, 0.105882, 0.105882)
		end

		for v1, v2 in v3.Highlights do
			for i = v2.Position.X + 1, v2.Position.X + v2.Size.X do
				for j = v2.Position.Y + 1, v2.Position.Y + v2.Size.Y do
					local v32 = v3.SlotElements[i .. ", " .. j]

					if v32 then
						v32.GroupColor3 = v2.Color
					end
				end
			end
		end
	end))

	return v3
end
function v2._createGuiElement(p1, p2) --[[ _createGuiElement | Line: 106 ]]
	local GridContainer = p1._trove:Add(Instance.new("CanvasGroup"))

	GridContainer.Name = "GridContainer"
	GridContainer.BackgroundTransparency = 1
	GridContainer.AnchorPoint = p2.AnchorPoint
	GridContainer.Position = p2.Position
	GridContainer.Size = p2.Size

	local v1 = p1._trove:Add(Instance.new("UIGridLayout"))

	v1.CellPadding = UDim2.fromOffset(0, 0)
	v1.SortOrder = Enum.SortOrder.LayoutOrder

	local count = 1
	local t = {}

	for i = 1, p2.GridSize.Y do
		for j = 1, p2.GridSize.X do
			local v2 = p1._trove:Add(p1.Assets.Slot:Clone())

			v2.Name = count
			v2.LayoutOrder = count
			t[j .. ", " .. i] = v2
			v2.Parent = GridContainer
			count = count + 1
		end
	end

	GridContainer.Visible = p1.Visible
	v1.Parent = GridContainer
	GridContainer.Parent = p2.Parent

	return GridContainer, t
end
function v2._updateGuiGrid(p1) --[[ _updateGuiGrid | Line: 151 ]]
	p1.GuiElement.UIGridLayout.CellSize = UDim2.fromScale(1 / p1.GridSize.X, 1 / p1.GridSize.Y)

	if p1.SlotAspectRatio then
		local UIAspectRatioConstraint = p1.GuiElement:FindFirstChildOfClass("UIAspectRatioConstraint")

		if UIAspectRatioConstraint then
			UIAspectRatioConstraint.AspectRatio = p1.GridSize.X / p1.GridSize.Y * p1.SlotAspectRatio
		else
			local UIAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")

			UIAspectRatioConstraint2.AspectRatio = p1.GridSize.X / p1.GridSize.Y * p1.SlotAspectRatio
			UIAspectRatioConstraint2.Parent = p1.GuiElement
		end
	else
		local UIAspectRatioConstraint = p1.GuiElement:FindFirstChildOfClass("UIAspectRatioConstraint")

		if not UIAspectRatioConstraint then
			return
		end

		UIAspectRatioConstraint:Destroy()
	end
end
function v2.GetSizeScale(p1) --[[ GetSizeScale | Line: 178 ]]
	return p1.GuiElement.UIGridLayout.AbsoluteCellSize
end
function v2.GetAbsoluteSizeFromItemSize(p1, p2, p3) --[[ GetAbsoluteSizeFromItemSize | Line: 188 ]]
	local v1 = p1:GetSizeScale()

	return Vector2.new(math.round(v1.X), (math.round(v1.Y))) * p2
end
function v2.GetItemManagerPositionFromAbsolutePosition(p1, p2, p3, p4) --[[ GetItemManagerPositionFromAbsolutePosition | Line: 200 ]]
	local AbsolutePosition = p1.GuiElement.AbsolutePosition
	local v1 = p1:GetSizeScale()
	local zero = Vector2.zero

	if p4 % 2 == 1 then
		zero = Vector2.new(p3.Y, p3.X) / 2 - p3 / 2
		p3 = Vector2.new(p3.Y, p3.X)
	end

	local v4 = math.floor((p2.X - AbsolutePosition.X) / v1.X - zero.X + 0.5)
	local v6 = math.floor((p2.Y - AbsolutePosition.Y) / v1.Y - zero.Y + 0.5)

	return Vector2.new(math.clamp(v4, 0, p1.GridSize.X - p3.X), (math.clamp(v6, 0, p1.GridSize.Y - p3.Y)))
end
function v2.GetNextFreePositionForItem(p1, p2) --[[ GetNextFreePositionForItem | Line: 224 ]]
	for i = 0, p1.GridSize.Y - 1 do
		for j = 0, p1.GridSize.X - 1 do
			local v1 = Vector2.new(j, i)
			local v2 = p1:IsRegionInBounds(v1, p2.Size, p2.Rotation)

			if #p1:GetItemsInRegion(v1, p2.Size, p2.Rotation, { p2 }) == 0 and v2 then
				return v1
			end
		end
	end

	return nil
end
function v2.GetItemsInRegion(p1, p2, p3, p4, p5) --[[ GetItemsInRegion | Line: 244 ]]
	local v1 = if p4 % 2 == 1 then p2 + Vector2.new(p3.Y, p3.X) else p2 + p3
	local t = {}

	for i, v in ipairs(p1.Items) do
		if table.find(p5, v) == nil then
			local Position = v.Position
			local Size = v.Size

			if v.Rotation % 2 == 1 then
				Size = Vector2.new(v.Size.Y, v.Size.X)
			end

			local v3 = Position + Size
			local v4 = if p2.X < v3.X then if v1.X > Position.X then true else false else false

			if v4 and (if p2.Y < v3.Y then if v1.Y > Position.Y then true else false else false) then
				table.insert(t, v)
			end
		end
	end

	return t
end
function v2.IsColliding(p1, p2, p3, p4, p5) --[[ IsColliding | Line: 278 ]]
	return #p1:GetItemsInRegion(if p4 then p4 else p2.Position, p2.Size, if p5 then p5 else p2.Rotation, p3) > 0
end
function v2.IsRegionInBounds(p1, p2, p3, p4) --[[ IsRegionInBounds | Line: 288 ]]
	local v1 = if p4 % 2 == 1 then p2 + Vector2.new(p3.Y, p3.X) else p2 + p3
	local v2 = if p2.X < 0 then true elseif v1.X > p1.GridSize.X then true else false

	return not (v2 or (if p2.Y < 0 then true else v1.Y > p1.GridSize.Y))
end
function v2.SortItemsByVolume(p1) --[[ SortItemsByVolume | Line: 308 ]]
	local v1 = table.clone(p1.Items)

	table.sort(v1, function(p1, p2) --[[ Line: 310 ]]
		return p1.Size.X * p1.Size.Y > p2.Size.X * p2.Size.Y
	end)

	for i, v in ipairs(v1) do
		p1:RemoveItem(v)
	end

	task.wait()

	for i, v in ipairs(v1) do
		p1:AddItem(v, p1:GetNextFreePositionForItem(v), true)
	end
end
function v2.AddItem(p1, p2, p3, p4) --[[ AddItem | Line: 334 ]]
	local v1 = if p3 then p3 else p2.Position

	assert(if p2.ItemManager == nil then true else false, "Could not add item: Item is already in another ItemManager")
	assert(if p1:IsColliding(p2, { p2 }, v1) == false then true else false, "Could not add item: Item is colliding with an already added item")
	assert(if p1:IsRegionInBounds(v1, p2.Size, p2.Rotation) == true then true else false, "Could not add item: Item is out of the grid\'s bounds")
	p2.Position = v1
	table.insert(p1.Items, p2)
	p1.ItemAdded:Fire(p2)
	p2.ItemManagerChanged:Fire(p1, p4)
end
function v2.RemoveItem(p1, p2) --[[ RemoveItem | Line: 353 ]]
	local v1 = table.find(p1.Items, p2)

	if v1 then
		table.remove(p1.Items, v1)
		p1.ItemRemoved:Fire(p2)
		p2.ItemManagerChanged:Fire(nil)
	else
		error("Unable to remove item: Item could not be found in ItemManager")
	end
end
function v2.ClearItems(p1, p2) --[[ ClearItems | Line: 370 ]]
	for i, v in ipairs(p1.Items) do
		if p2 then
			v:Destroy()
		end

		p1.Items[i] = nil
		p1.ItemRemoved:Fire(v)
		v.ItemManagerChanged:Fire(nil)
	end
end

return v2