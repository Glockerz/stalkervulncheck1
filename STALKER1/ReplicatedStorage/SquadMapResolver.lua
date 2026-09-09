-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"))

return {
	COLOR_SQUAD = Color3.fromRGB(80, 220, 100),
	Resolve = function() --[[ Resolve | Line: 19 | Upvalues: Players (copy), SquadController (copy) ]]
		local t = {}
		local LocalPlayer = Players.LocalPlayer

		if not LocalPlayer then
			return t
		end

		local v1 = SquadController:GetMemberIds() or {}

		if #v1 < 2 then
			return t
		end

		for i, v in ipairs(v1) do
			if v ~= LocalPlayer.UserId then
				local v2 = tostring(v)

				if v2 ~= tostring(LocalPlayer.UserId) then
					local v3 = Players:GetPlayerByUserId(tonumber(v) or v)
					local v4 = if v3 then v3.Character else v3
					local v5 = if v4 then v4:FindFirstChild("HumanoidRootPart") else v4

					if v5 then
						t[#t + 1] = {
							pos = v5.Position
						}
					end
				end
			end
		end

		return t
	end
}