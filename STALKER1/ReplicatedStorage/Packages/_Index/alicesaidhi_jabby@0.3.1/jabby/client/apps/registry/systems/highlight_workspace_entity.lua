-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes)

return function(p1) --[[ Line: 16 | Upvalues: queue (copy), remotes (copy) ]]
	local v1 = queue(remotes.send_mouse_entity)

	return function() --[[ Line: 20 | Upvalues: v1 (copy), p1 (copy) ]]
		for v12, v2, v3, v4, v5 in v1:iter() do
			if v12.host == p1.host and (v12.from_vm == p1.vm and (v2 == p1.id and p1.enable_pick() ~= false)) then
				p1.hovering_over(v3)
				p1.entity_hovering_over(v5)
				p1.set_entity(v4)
			end
		end
	end
end