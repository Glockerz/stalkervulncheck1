-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent)

script.Parent:WaitForChild("RenderGlass").OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 6 | Upvalues: v1 (copy) ]]
	v1(p1, p2, p3, true)
end)