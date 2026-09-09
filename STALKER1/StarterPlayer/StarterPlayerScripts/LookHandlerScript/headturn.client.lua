-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Arms = script.Arms
local CharacterLookController = require(game.ReplicatedStorage.CharacterLookSystem.ReplicatedStorage.CharacterLookController)
local LocalPlayer = game.Players.LocalPlayer
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local function updateArmsLook() --[[ updateArmsLook | Line: 13 | Upvalues: LocalPlayer (copy), CharacterLookController (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local v1 = false

	for v2, v3 in Character:GetChildren() do
		if v3:IsA("Tool") then
			v1 = true

			break
		end
	end

	CharacterLookController.ArmsLook = v1
end

local function bindCharacter(p1) --[[ bindCharacter | Line: 23 | Upvalues: updateArmsLook (copy) ]]
	p1.ChildAdded:Connect(function(p1) --[[ Line: 24 | Upvalues: updateArmsLook (ref) ]]
		if not p1:IsA("Tool") then
			return
		end

		updateArmsLook()
	end)
	p1.ChildRemoved:Connect(function(p1) --[[ Line: 27 | Upvalues: updateArmsLook (ref) ]]
		if not p1:IsA("Tool") then
			return
		end

		updateArmsLook()
	end)
	updateArmsLook()
end

bindCharacter(v1)
LocalPlayer.CharacterAdded:Connect(bindCharacter)
CharacterLookController:Commence("Camera", false, Arms.Value, 0.1)