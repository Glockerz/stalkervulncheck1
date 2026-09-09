-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local signal = require(script.Parent.Parent.signal)
local trove = require(script.Parent.Parent.trove)
local Highlight = require(script.Parent.Highlight)

require(script.Parent.Types)

local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 77 | Upvalues: t (copy), trove (copy), signal (copy) ]]
	local v2 = setmetatable({}, t)

	v2._trove = trove.new()
	v2.Assets = p1.Assets or {}

	if v2.Assets.Slot == nil then
		v2.Assets.Slot = v2:_createDefaultSlotAsset()
	end

	v2.Visible = p1.Visible or false
	v2.VisibilityChanged = signal.new()
	v2.Highlights = {}
	v2.ConnectedTransferLinks = {}
	v2.TransferLinkConnected = signal.new()
	v2.TransferLinkDisconnected = signal.new()
	v2.Metadata = p1.Metadata or {}

	return v2
end
function t._createDefaultSlotAsset(p1) --[[ _createDefaultSlotAsset | Line: 100 ]]
	local SlotElement = Instance.new("CanvasGroup")

	SlotElement.Name = "SlotElement"
	SlotElement.GroupColor3 = Color3.fromRGB(0, 0, 0)
	SlotElement.GroupTransparency = 0.5
	SlotElement.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SlotElement.BackgroundTransparency = 1
	SlotElement.BorderSizePixel = 0
	SlotElement.Size = UDim2.fromOffset(10, 10)

	local Frame = Instance.new("Frame")

	Frame.Name = "Frame"
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.fromScale(0.5, 0.5)
	Frame.Size = UDim2.fromScale(0.9, 0.9)
	Frame.Parent = SlotElement

	local UICorner = Instance.new("UICorner")

	UICorner.Name = "UICorner"
	UICorner.Parent = Frame

	return SlotElement
end
function t.GetOffset(p1, p2) --[[ GetOffset | Line: 131 ]]
	return p1.GuiElement.AbsolutePosition
end
function t.GetSizeScale(p1) --[[ GetSizeScale | Line: 140 ]]
	return Vector2.zero
end
function t.GetAbsoluteSizeFromItemSize(p1, p2, p3) --[[ GetAbsoluteSizeFromItemSize | Line: 149 ]]
	return Vector2.zero
end
function t.GetItemManagerPositionFromAbsolutePosition(p1, p2, p3, p4) --[[ GetItemManagerPositionFromAbsolutePosition | Line: 158 ]]
	return Vector2.zero
end
function t.IsColliding(p1, p2, p3, p4) --[[ IsColliding | Line: 167 ]]
	return true
end
function t.RemoveItem(p1, p2) --[[ RemoveItem | Line: 176 ]] end
function t.SetVisibility(p1, p2) --[[ SetVisibility | Line: 183 ]]
	if p2 == p1.Visible then
		return
	end

	p1.Visible = p2

	if p1.GuiElement then
		p1.GuiElement.Visible = p1.Visible
	end

	p1.VisibilityChanged:Fire(p1.Visible)
end
function t.ConnectTransferLink(p1, p2) --[[ ConnectTransferLink | Line: 200 ]]
	table.insert(p1.ConnectedTransferLinks, p2)
	p1.TransferLinkConnected:Fire(p2)
	p2:AddItemManager(p1)
end
function t.DisconnectTransferLink(p1, p2) --[[ DisconnectTransferLink | Line: 212 ]]
	p2:RemoveItemManager(p1)

	local v1 = table.find(p1.ConnectedTransferLinks, p2)

	assert(v1, "Failed to disconnect TransferLink: Could not find a matching TransferLink that was connected")
	table.remove(p1.ConnectedTransferLinks, v1)
	p1.TransferLinkDisconnected:Fire(p2)
end
function t.CreateHighlight(p1, p2, p3, p4, p5) --[[ CreateHighlight | Line: 229 | Upvalues: Highlight (copy) ]]
	local v1 = Highlight.new({
		Position = p3,
		Size = p4,
		Color = p5
	})
	local count = p2 or 1

	while p1.Highlights[count] ~= nil do
		count = count + 1
	end

	local v2 = nil

	v2 = v1.ItemManagerChanged:Connect(function() --[[ Line: 243 | Upvalues: p1 (copy), count (ref), v2 (ref) ]]
		p1.Highlights[count] = nil
		v2:Disconnect()
		v2 = nil
	end)
	p1.Highlights[count] = v1

	return v1
end
function t.AddHighlight(p1, p2, p3) --[[ AddHighlight | Line: 260 ]]
	local count = p2 or 1

	while p1.Highlights[count] ~= nil do
		count = count + 1
	end

	local v1 = nil

	v1 = p3.ItemManagerChanged:Connect(function() --[[ Line: 267 | Upvalues: p1 (copy), count (ref), v1 (ref) ]]
		p1.Highlights[count] = nil
		v1:Disconnect()
		v1 = nil
	end)
	p1.Highlights[count] = p3
end
function t.RemoveHighlight(p1, p2) --[[ RemoveHighlight | Line: 282 ]]
	local v1 = table.find(p1.Highlights, p2)

	if not v1 then
		return
	end

	p1.Highlights[v1] = nil
	p2.ItemManagerChanged:Fire(nil)
end
function t.Destroy(p1) --[[ Destroy | Line: 296 ]]
	p1._trove:Destroy()
end

return t