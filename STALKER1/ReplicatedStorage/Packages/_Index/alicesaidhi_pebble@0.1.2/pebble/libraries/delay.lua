-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local vide = require(script.Parent.Parent.Parent.vide)
local source = vide.source
local effect = vide.effect
local cleanup = vide.cleanup

return function(p1, p2) --[[ Line: 9 | Upvalues: source (copy), effect (copy), cleanup (copy), RunService (copy) ]]
	local v1 = source(p2())

	effect(function() --[[ Line: 12 | Upvalues: p2 (copy), p1 (copy), cleanup (ref), RunService (ref), v1 (copy) ]]
		local v12 = p2()
		local v2 = p1

		cleanup(RunService.Heartbeat:Connect(function(p1) --[[ Line: 16 | Upvalues: v2 (ref), v1 (ref), v12 (copy) ]]
			v2 = v2 - p1

			if not (v2 > 0) then
				v1(v12)
			end
		end))
	end)

	return v1
end