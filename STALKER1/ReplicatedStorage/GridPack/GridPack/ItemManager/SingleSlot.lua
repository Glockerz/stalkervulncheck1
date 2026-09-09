-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local v1 = require(script.Parent)
local signal = require(script.Parent.Parent.Parent.signal)

require(script.Parent.Parent.Types)

local v2 = setmetatable({}, v1)

v2.__index = v2
function v2.new(p1) --[[ new | Line: 48 | Upvalues: v1 (copy), v2 (copy), signal (copy), RunService (copy) ]]
	local v3 = setmetatable(v1.new(p1), v2)

	v3.GuiElement = v3:_createGuiElement(p1)
	v3.Item = nil
	v3.ItemChanged = signal.new()
	v3._trove:Add(RunService.RenderStepped:Connect(function() --[[ Line: 55 | Upvalues: v3 (copy) ]]
		v3.GuiElement.GroupColor3 = Color3.new(0.105882, 0.105882, 0.105882)

		for v1, v2 in v3.Highlights do
			v3.GuiElement.GroupColor3 = v2.Color
		end
	end))

	return v3
end
function v2._createGuiElement(p1, p2) --[[ _createGuiElement | Line: 72 ]]
	local SingleSlot = p1._trove:Add(p1.Assets.Slot:Clone())

	SingleSlot.Name = "SingleSlot"
	SingleSlot.AnchorPoint = p2.AnchorPoint
	SingleSlot.Position = p2.Position
	SingleSlot.Size = p2.Size
	SingleSlot.Visible = p1.Visible
	SingleSlot.Parent = p2.Parent

	return SingleSlot
end
function v2.GetOffset(p1, p2) --[[ GetOffset | Line: 93 ]]
	local zero = Vector2.zero

	if p2 % 2 == 1 then
		zero = Vector2.new(p1.GuiElement.AbsoluteSize.Y, p1.GuiElement.AbsoluteSize.X) / 2 - p1.GuiElement.AbsoluteSize / 2
	end

	return p1.GuiElement.AbsolutePosition - zero
end
function v2.GetSizeScale(p1) --[[ GetSizeScale | Line: 108 ]]
	return p1.GuiElement.AbsoluteSize
end
function v2.GetAbsoluteSizeFromItemSize(p1, p2, p3) --[[ GetAbsoluteSizeFromItemSize | Line: 118 ]]
	if p3 % 2 == 1 then
		return Vector2.new(p1.GuiElement.AbsoluteSize.Y, p1.GuiElement.AbsoluteSize.X)
	end

	return p1.GuiElement.AbsoluteSize
end
function v2.GetItemManagerPositionFromAbsolutePosition(p1, p2, p3, p4) --[[ GetItemManagerPositionFromAbsolutePosition | Line: 132 ]]
	local zero = Vector2.zero

	if p4 % 2 == 1 then
		zero = Vector2.new(p3.Y, p3.X) / 2 - p3 / 2
	end

	return -zero
end
function v2.IsColliding(p1, p2, p3, p4) --[[ IsColliding | Line: 147 ]]
	if table.find(p3, p1.Item) then
		return false
	end

	return p1.Item ~= nil
end
function v2.ChangeItem(p1, p2) --[[ ChangeItem | Line: 161 ]]
	assert(if p2.ItemManager == nil then true else false, "Could not add item: Item is already in another ItemManager")

	if p1.Item then
		p1:RemoveItem()
	end

	p1.Item = p2
	p1.ItemChanged:Fire(p2)
	p2.ItemManagerChanged:Fire(p1, true)
end
function v2.RemoveItem(p1) --[[ RemoveItem | Line: 180 ]]
	if p1.Item then
		p1.Item.ItemManagerChanged:Fire(nil)
	end

	p1.Item = nil
	p1.ItemChanged:Fire(nil)
end

return v2