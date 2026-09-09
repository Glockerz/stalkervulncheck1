-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")

game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local v1 = Color3.fromRGB(102, 204, 102)

local function showSystemMessage(p1) --[[ showSystemMessage | Line: 28 | Upvalues: TextChatService (copy), StarterGui (copy), v1 (copy) ]]
	local v12 = nil

	pcall(function() --[[ Line: 32 | Upvalues: v12 (ref), TextChatService (ref) ]]
		v12 = TextChatService.TextChannels:FindFirstChild("RBXSystem")
	end)

	if v12 then
		local v2 = string.format("<font color=\"%s\">%s</font>", "rgb(102, 204, 102)", p1)

		pcall(function() --[[ Line: 35 | Upvalues: v12 (ref), v2 (copy) ]]
			v12:DisplaySystemMessage(v2)
		end)
	end

	pcall(function() --[[ Line: 37 | Upvalues: StarterGui (ref), p1 (copy), v1 (ref) ]]
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = p1,
			Color = v1,
			Font = Enum.Font.GothamBold
		})
	end)
end

local function showNotification(p1, p2, p3) --[[ showNotification | Line: 46 | Upvalues: StarterGui (copy) ]]
	pcall(function() --[[ Line: 47 | Upvalues: StarterGui (ref), p1 (copy), p2 (copy), p3 (copy) ]]
		StarterGui:SetCore("SendNotification", {
			Title = p1,
			Text = p2,
			Duration = p3 or 8
		})
	end)
end

local function playerEngagedFromSpawn() --[[ playerEngagedFromSpawn | Line: 56 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
	local SpawnLocation = workspace:FindFirstChild("SpawnLocation")

	if not (v1 and SpawnLocation) then
		return false
	end

	return (v1.Position - SpawnLocation.Position).Magnitude > 50
end

task.wait(4)
showSystemMessage("Welcome to the warehouse. Step into any lobby to host a party - pick your map, choose Open or Friends Only, and hit START when you\'re ready.")

local v2 = "Welcome to the Zone, Stalker."
local v3 = 8
local v4 = nil

pcall(function() --[[ Line: 47 | Upvalues: StarterGui (copy), v2 (copy), v3 (copy), v4 (copy) ]]
	StarterGui:SetCore("SendNotification", {
		Title = v2,
		Text = v3,
		Duration = v4 or 8
	})
end)
task.wait(45)

local Character = LocalPlayer.Character
local v5 = Character and Character:FindFirstChild("HumanoidRootPart")
local SpawnLocation = workspace:FindFirstChild("SpawnLocation")

if if v5 and SpawnLocation then if (v5.Position - SpawnLocation.Position).Magnitude > 50 then true else false else false then
	return
end

showSystemMessage("Ready to head out? Step into a garage. You\'ll host - friends can join before you start.")