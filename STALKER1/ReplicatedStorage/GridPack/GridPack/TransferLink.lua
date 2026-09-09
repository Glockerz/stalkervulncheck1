-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local v1 = game:GetService("GuiService"):GetGuiInset()

require(script.Parent.Types)

local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 32 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.ConnectedItemManagers = p1.ConnectedItemManagers or {}

	return v2
end
function t.AddItemManager(p1, p2) --[[ AddItemManager | Line: 40 ]]
	table.insert(p1.ConnectedItemManagers, p2)
end
function t.RemoveItemManager(p1, p2) --[[ RemoveItemManager | Line: 45 ]]
	local v1 = table.find(p1.ConnectedItemManagers, p2)

	assert(v1, "Failed to remove ItemManager connection: Could not find connected ItemManager in TransferLink")
	table.remove(p1.ConnectedItemManagers, v1)
end
function t.GetItemOverlappingItemManagers(p1, p2) --[[ GetItemOverlappingItemManagers | Line: 57 ]]
	local AbsolutePosition = p2.ItemElement.AbsolutePosition
	local v1 = AbsolutePosition + p2.ItemElement.AbsoluteSize
	local t = {}

	for k, v in pairs(p1.ConnectedItemManagers) do
		if v.Visible then
			local AbsolutePosition2 = v.GuiElement.AbsolutePosition
			local v2 = AbsolutePosition2 + v.GuiElement.AbsoluteSize
			local v3 = if AbsolutePosition.X <= v2.X then if v1.X >= AbsolutePosition2.X then true else false else false

			if v3 and (if AbsolutePosition.Y <= v2.Y then if v1.Y >= AbsolutePosition2.Y then true else false else false) then
				table.insert(t, v)
			end
		end
	end

	return t
end
function t.GetClosestItemOverlappingItemManagers(p1, p2) --[[ GetClosestItemOverlappingItemManagers | Line: 83 | Upvalues: UserInputService (copy), v1 (copy) ]]
	local v12 = p1:GetItemOverlappingItemManagers(p2)
	local v2 = UserInputService:GetMouseLocation() - v1

	table.sort(v12, function(p1, p2) --[[ Line: 87 | Upvalues: v2 (copy) ]]
		local v5 = Vector2.new(math.clamp(v2.X, p1.GuiElement.AbsolutePosition.X, p1.GuiElement.AbsolutePosition.X + p1.GuiElement.AbsoluteSize.X), (math.clamp(v2.Y, p1.GuiElement.AbsolutePosition.Y, p1.GuiElement.AbsolutePosition.Y + p1.GuiElement.AbsoluteSize.Y)))

		return (v5 - v2).Magnitude < (Vector2.new(math.clamp(v2.X, p2.GuiElement.AbsolutePosition.X, p2.GuiElement.AbsolutePosition.X + p2.GuiElement.AbsoluteSize.X), (math.clamp(v2.Y, p2.GuiElement.AbsolutePosition.Y, p2.GuiElement.AbsolutePosition.Y + p2.GuiElement.AbsoluteSize.Y))) - v2).Magnitude
	end)

	return v12
end

return t