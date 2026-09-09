-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"))
local t = {
	_initialized = false
}

local function shouldShowInvite(p1) --[[ shouldShowInvite | Line: 15 | Upvalues: LocalPlayer (copy), SquadController (copy) ]]
	if p1 == LocalPlayer then
		return false
	end

	if not p1.Character then
		return false
	end

	local v1 = SquadController:GetSquad()

	if v1 and not SquadController:IsLeader() then
		return false
	end

	if not v1 then
		return true
	end

	if v1.members[p1.UserId] then
		return false
	end

	if v1.members[tostring(p1.UserId)] then
		return false
	end

	return true
end

local function shouldShowTrade(p1) --[[ shouldShowTrade | Line: 30 | Upvalues: LocalPlayer (copy) ]]
	if p1 == LocalPlayer then
		return false
	end

	return p1.Character and true or false
end

local function getPromptAnchor(p1) --[[ getPromptAnchor | Line: 36 ]]
	return p1:FindFirstChild("UpperTorso") or (p1:FindFirstChild("Torso") or (p1:FindFirstChild("HumanoidRootPart") or p1.PrimaryPart))
end

local function ensurePrompts(p1) --[[ ensurePrompts | Line: 43 | Upvalues: LocalPlayer (copy), SquadController (copy) ]]
	if not p1.Character then
		return
	end

	local Character = p1.Character
	local UpperTorso = Character:FindFirstChild("UpperTorso")
	local v1

	if UpperTorso then
		v1 = UpperTorso
	else
		local Torso = Character:FindFirstChild("Torso")

		if Torso then
			v1 = Torso
		else
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

			v1 = if HumanoidRootPart then HumanoidRootPart else Character.PrimaryPart
		end
	end

	if not v1 then
		return
	end

	local SquadInvitePrompt = v1:FindFirstChild("SquadInvitePrompt")

	if SquadInvitePrompt then
		local v2

		if p1 == LocalPlayer or not p1.Character then
			v2 = false
		else
			local v3 = SquadController:GetSquad()

			v2 = if v3 and not SquadController:IsLeader() then false elseif v3 then if v3.members[p1.UserId] then false else not v3.members[tostring(p1.UserId)] else true
		end

		SquadInvitePrompt.Enabled = v2
	else
		local SquadInvitePrompt2 = Instance.new("ProximityPrompt")

		SquadInvitePrompt2.Name = "SquadInvitePrompt"
		SquadInvitePrompt2.ActionText = "Invite to Squad"
		SquadInvitePrompt2.ObjectText = p1.DisplayName
		SquadInvitePrompt2.HoldDuration = 0.3
		SquadInvitePrompt2.MaxActivationDistance = 6
		SquadInvitePrompt2.RequiresLineOfSight = false
		SquadInvitePrompt2.Style = Enum.ProximityPromptStyle.Custom
		SquadInvitePrompt2.KeyboardKeyCode = Enum.KeyCode.F
		SquadInvitePrompt2.UIOffset = Vector2.new(0, -15)

		local v4, v5

		if p1 == LocalPlayer or not p1.Character then
			v4 = SquadInvitePrompt2
			v5 = false
		else
			local v6 = SquadController:GetSquad()

			if v6 and not SquadController:IsLeader() then
				v4 = SquadInvitePrompt2
				v5 = false
			elseif v6 and v6.members[p1.UserId] or v6 and v6.members[tostring(p1.UserId)] then
				v4 = SquadInvitePrompt2
				v5 = false
			else
				v4 = SquadInvitePrompt2
				v5 = true
			end
		end

		v4.Enabled = v5
		v4.Parent = v1
		v4.Triggered:Connect(function(p12) --[[ Line: 66 | Upvalues: LocalPlayer (ref), SquadController (ref), p1 (copy) ]]
			if p12 ~= LocalPlayer then
				return
			end

			local v1 = SquadController:Invite(p1.UserId)

			if v1 and v1.ok then
				return
			end

			local v2 = if v1 then v1.error else v1

			if v2 == "target_already_in_squad" then
				SquadController:ShowToast(p1.DisplayName .. " is already in a squad.")

				return
			end

			warn("[PlayerInteractionController] Invite failed: " .. tostring(v2))
		end)
	end

	local PlayerTradePrompt = v1:FindFirstChild("PlayerTradePrompt")

	if PlayerTradePrompt then
		PlayerTradePrompt.Enabled = if p1 == LocalPlayer then false else p1.Character and true or false
	else
		local PlayerTradePrompt2 = Instance.new("ProximityPrompt")

		PlayerTradePrompt2.Name = "PlayerTradePrompt"
		PlayerTradePrompt2.ActionText = "Trade"
		PlayerTradePrompt2.ObjectText = p1.DisplayName
		PlayerTradePrompt2.HoldDuration = 0.3
		PlayerTradePrompt2.MaxActivationDistance = 6
		PlayerTradePrompt2.RequiresLineOfSight = false
		PlayerTradePrompt2.Style = Enum.ProximityPromptStyle.Custom
		PlayerTradePrompt2.KeyboardKeyCode = Enum.KeyCode.T
		PlayerTradePrompt2.UIOffset = Vector2.new(0, 15)
		PlayerTradePrompt2.Enabled = if p1 == LocalPlayer then false else p1.Character and true or false
		PlayerTradePrompt2.Parent = v1
		PlayerTradePrompt2.Triggered:Connect(function(p1) --[[ Line: 98 | Upvalues: LocalPlayer (ref), SquadController (ref) ]]
			if p1 == LocalPlayer then
				SquadController:ShowToast("Player trading -- Work in Progress.")
			end
		end)
	end
end

local function removePrompts(p1) --[[ removePrompts | Line: 108 ]]
	if not p1.Character then
		return
	end

	local Character = p1.Character
	local UpperTorso = Character:FindFirstChild("UpperTorso")
	local v1

	if UpperTorso then
		v1 = UpperTorso
	else
		local Torso = Character:FindFirstChild("Torso")

		if Torso then
			v1 = Torso
		else
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

			v1 = if HumanoidRootPart then HumanoidRootPart else Character.PrimaryPart
		end
	end

	if not v1 then
		return
	end

	local SquadInvitePrompt = v1:FindFirstChild("SquadInvitePrompt")

	if SquadInvitePrompt then
		SquadInvitePrompt:Destroy()
	end

	local PlayerTradePrompt = v1:FindFirstChild("PlayerTradePrompt")

	if not PlayerTradePrompt then
		return
	end

	PlayerTradePrompt:Destroy()
end

local function refreshAll() --[[ refreshAll | Line: 118 | Upvalues: Players (copy), LocalPlayer (copy), ensurePrompts (copy) ]]
	for i, v in ipairs(Players:GetPlayers()) do
		if v ~= LocalPlayer then
			ensurePrompts(v)
		end
	end
end

function t.Init(p1) --[[ Init | Line: 126 | Upvalues: SquadController (copy), refreshAll (copy), Players (copy), ensurePrompts (copy), LocalPlayer (copy) ]]
	if p1._initialized then
		return
	end

	p1._initialized = true
	SquadController:OnChanged(refreshAll)
	Players.PlayerAdded:Connect(function(p1) --[[ Line: 132 | Upvalues: ensurePrompts (ref) ]]
		p1.CharacterAdded:Connect(function() --[[ Line: 133 | Upvalues: ensurePrompts (ref), p1 (copy) ]]
			ensurePrompts(p1)
		end)
	end)

	for i, v in ipairs(Players:GetPlayers()) do
		if v ~= LocalPlayer then
			v.CharacterAdded:Connect(function() --[[ Line: 137 | Upvalues: ensurePrompts (ref), v (copy) ]]
				ensurePrompts(v)
			end)

			if v.Character then
				ensurePrompts(v)
			end
		end
	end
end

return t