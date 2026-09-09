-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes)

return function(p1) --[[ Line: 14 | Upvalues: UserInputService (copy), remotes (copy) ]]
	if p1.enable_pick() ~= false then
		local v1 = UserInputService:GetMouseLocation()
		local v2 = workspace.CurrentCamera:ViewportPointToRay(v1.X, v1.Y)

		remotes.send_mouse_pointer:fire({
			host = p1.host,
			to_vm = p1.vm
		}, p1.id, v2.Origin, v2.Direction)
	end
end