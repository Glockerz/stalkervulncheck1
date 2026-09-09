-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage:WaitForChild("TalkController")):Init()

local PlayVoicelineClient = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayVoicelineClient", 10)

if not PlayVoicelineClient then
	return
end

PlayVoicelineClient.OnClientEvent:Connect(function(p1, p2) --[[ Line: 14 ]]
	if not (p1 and (p1.Parent and (p2 and p2.Parent))) then
		return
	end

	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart", true)

	if HumanoidRootPart then
		local v1 = p2:Clone()

		v1.Parent = HumanoidRootPart
		v1:Play()
		v1.Ended:Connect(function() --[[ Line: 21 | Upvalues: v1 (copy) ]]
			v1:Destroy()
		end)
		task.delay(30, function() --[[ Line: 23 | Upvalues: v1 (copy) ]]
			if not (v1 and v1.Parent) then
				return
			end

			v1:Destroy()
		end)
	end
end)