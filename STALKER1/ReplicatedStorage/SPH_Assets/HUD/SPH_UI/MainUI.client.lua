-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SPH_Assets = game:GetService("ReplicatedStorage").SPH_Assets
local LocalPlayer = Players.LocalPlayer
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAppearanceLoaded:Wait()
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = false
local v6 = nil
local Ammo = script.Parent.Ammo

script.Parent.Version.Text = "Spearhead " .. require(SPH_Assets.GameConfig).version

local AmmoLabel = Ammo.Ammo.Ammo.AmmoLabel
local MagazineLabel = Ammo.Ammo.Ammo.MagazineLabel
local AmmoType = Ammo.Other.AmmoType
local Firemode = Ammo.Firemode.Firemode
local Chambered = Ammo.Ammo.Ammo.Chambered
local t = { "SAFE", "[SEMI]", "[AUTO]", "[BURST]", "[MANUAL]" }
local UserInputService = game:GetService("UserInputService")
local Sens = Ammo.Firemode.Sens

function splitNumber(p1) --[[ splitNumber | Line: 28 ]]
	local v1 = tostring(p1)
	local v2 = ""
	local v3 = 3 - #v1
	local v4

	if v3 > 0 then
		for i = 1, v3 do
			v2 = v2 .. "0"
		end
	end

	if #v1 > 3 then
		v2, v4 = "", v1:sub(-3)
	end

	return { v2, v4 }
end
v1.ChildAdded:Connect(function(p1) --[[ Line: 54 | Upvalues: SPH_Assets (copy), v5 (ref), v2 (ref), v3 (ref), v6 (ref), AmmoType (copy), v1 (copy), v4 (ref) ]]
	if not p1:FindFirstChild("SPH_Weapon") or (not SPH_Assets.WeaponModels:FindFirstChild(p1.Name) or v5) then
		return
	end

	v2 = p1
	v3 = p1:WaitForChild("Ammo").MagAmmo
	v6 = require(p1.SPH_Weapon.WeaponStats)
	AmmoType.Text = v6.ammoType
	v4 = (v1.AmmoPool:FindFirstChild(v6.ammoType) or v1.AmmoPool.Universal).CurrentValue
end)
v1.ChildRemoved:Connect(function(p1) --[[ Line: 67 | Upvalues: v2 (ref) ]]
	if p1 ~= v2 then
		return
	end

	v2 = nil
end)
RunService.Heartbeat:Connect(function() --[[ Line: 73 | Upvalues: v2 (ref), v6 (ref), v3 (ref), v5 (ref), Ammo (copy), AmmoLabel (copy), MagazineLabel (copy), v4 (ref), Chambered (copy), Firemode (copy), t (copy), Sens (copy), UserInputService (copy), LocalPlayer (copy) ]]
	if v2 and (v2:FindFirstChild("Chambered") or v6.openBolt) and (v3 and not v5) then
		Ammo.Visible = true

		if v6.operationType then
			if type(v6.operationType) == "string" then
				v6.operationType = 1
			end
		else
			v6.operationType = 1
		end

		if v6.operationType == 4 and v2.Chambered.Value then
			local v1 = splitNumber(v3.Value + 1)

			AmmoLabel.Text = "<font transparency=\"0.5\">" .. v1[1] .. "</font>" .. v1[2]
		else
			local v22 = splitNumber(v3.Value)

			AmmoLabel.Text = "<font transparency=\"0.5\">" .. v22[1] .. "</font>" .. v22[2]
		end

		MagazineLabel.Text = "/"

		if v6.infiniteAmmo then
			MagazineLabel.Text = MagazineLabel.Text .. "INF"
		else
			MagazineLabel.Text = MagazineLabel.Text .. v4.Value
		end

		if v2.FireMode.Value == 0 then
			AmmoLabel.TextColor3 = Color3.new(0.5, 0.5, 0.5)
		elseif v6.openBolt and v3.Value > 0 or not v6.openBolt and v2.Chambered.Value then
			if v6.openBolt then
				Chambered.TextTransparency = 1
			else
				Chambered.TextTransparency = 0
			end

			AmmoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			Chambered.TextTransparency = 1
			AmmoLabel.TextColor3 = Color3.new(255/255, 0/255, 0/255)
		end

		Firemode.Text = t[v2.FireMode.Value + 1]
		Sens.Text = string.format("%.2f", UserInputService.MouseDeltaSensitivity)

		local v32 = nil
		local v42 = if v6.SightAtt then game.Workspace.Camera.WeaponRig.Weapon[v2.Name]:FindFirstChild(v6.SightAtt) else game.Workspace.Camera.WeaponRig.Weapon[v2.Name]

		if v42 and (v42:FindFirstChild("SightReticle") and v42.SightReticle.SurfaceGui.Frame.Reticle:FindFirstChild("Frame")) then
			v32 = v42.SightReticle.SurfaceGui.Frame.Reticle.Frame.Range
		end

		if LocalPlayer:GetAttribute("rangefinderActive") then
			Ammo.TargetRange.Visible = true

			if v32 then
				v32.Visible = true
			end

			if LocalPlayer:GetAttribute("tgtDistance") then
				Ammo.TargetRange.Text = "Distance: " .. math.floor((LocalPlayer:GetAttribute("tgtDistance"))) .. " m"

				if v32 then
					v32.Text = math.floor((LocalPlayer:GetAttribute("tgtDistance")))
				end
			else
				Ammo.TargetRange.Text = "Distance: --- m"

				if v32 then
					v32.Text = "--"
				end
			end
		else
			Ammo.TargetRange.Visible = false

			if v32 then
				v32.Visible = false
			end
		end
	else
		Ammo.Visible = false
	end
end)
v1.Humanoid.Died:Connect(function() --[[ Line: 149 | Upvalues: v5 (ref) ]]
	v5 = true
end)