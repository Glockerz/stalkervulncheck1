-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local Update = script.CharacterLookClient.Value.Update
local t = {}

function t.Commence(p1) --[[ Commence | Line: 8 | Upvalues: Update (copy), Players (copy), t (copy) ]]
	Update.OnServerEvent:Connect(function(p1, p2, p3) --[[ Line: 9 | Upvalues: Update (ref), Players (ref) ]]
		if typeof(p2) ~= "Vector3" then
			warn(string.format("[%s]: %s is acting sus... Did not give the server the right type of cameraDirection (gave %s, %s required.)", Update.Name, p1.Name, typeof(cameraDirection), "Vector3"))

			return
		end

		for k, v in pairs(Players:GetPlayers()) do
			if v ~= p1 then
				Update:FireClient(v, p1, p2, p3)
			end
		end
	end)

	return t
end

return t