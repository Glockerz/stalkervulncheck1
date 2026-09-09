-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local signal = require(script.Parent.Parent.signal)
local trove = require(script.Parent.Parent.trove)

require(script.Parent.Types)

local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 54 | Upvalues: t (copy), trove (copy), signal (copy) ]]
	local v2 = setmetatable({}, t)

	v2._trove = trove.new()
	v2.Position = p1.Position or Vector2.new(0, 0)
	v2.Size = p1.Size or Vector2.new(1, 1)
	v2.Color = p1.Color or Color3.new(255/255, 255/255, 255/255)
	v2.ItemManager = nil
	v2.ItemManagerChanged = signal.new()
	v2._trove:Add(function() --[[ Line: 65 | Upvalues: v2 (copy) ]]
		if v2.ItemManager then
			v2.ItemManager:RemoveHighlight(v2)
		end

		v2.ItemManagerChanged:Fire(nil)
	end)

	return v2
end
function t.SetItemManager(p1, p2, p3) --[[ SetItemManager | Line: 81 ]]
	p1.ItemManager = p3
	p1.ItemManagerChanged:Fire(p3)
	p1.ItemManager:AddHighlight(p2, p1)
end
function t.Destroy(p1) --[[ Destroy | Line: 93 ]]
	p1._trove:Destroy()
end

return t