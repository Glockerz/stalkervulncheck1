-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

game:GetService("Players")
function t.armorDamage(p1, p2, p3, p4) --[[ armorDamage | Line: 4 ]]
	local v1 = if p4.SPH_Weapon:FindFirstChild("BulletPhysics") then require(p4.SPH_Weapon.BulletPhysics).armorPen or 10 else 10

	if p1 then
		local v3 = p1[if p3.Name == "Head" then "helmetProtection" else "vestProtection"].Value

		if v1 < v3 then
			p2 = math.max(0.5, p2 * (v1 / v3))
		end
	end

	return p2
end
function t.equipArmor(p1, p2, p3, p4) --[[ equipArmor | Line: 20 ]]
	local v1 = p1.Parent
	local Type = p2.Type.Value

	if v1:FindFirstChild(Type) then
		return
	end

	weldArmor(p1, Type, p2.Model, p2.Target.Value, p3)

	if Type == "Helmet" or p2.Target.Value == "Head" then
		HideHats(v1)
	end

	GiveArmorValue(p1, p2)
	p1:UnequipTools()
	p4:Destroy()
end
function t.removeArmor(p1, p2) --[[ removeArmor | Line: 37 ]]
	print(p1)
	print(p2)

	local Preset = p2.Preset.Value
	local Character = p1.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChild("Humanoid")

	if not Humanoid then
		return
	end

	local Type = Preset.Type.Value
	local v1 = Character:FindFirstChild(Type)

	if not v1 then
		return
	end

	v1:Destroy()

	if (Type == "Helmet" or Preset.Target.Value == "Head") and not (Character:FindFirstChild("Eyes") or Character:FindFirstChild("Helmet")) then
		ShowHats(Character)
	end

	Humanoid:UnequipTools()

	local v2 = script.armorToolTemplate:Clone()

	v2.Preset.Value = Preset
	v2.Name = Preset.Name
	LoseArmorValue(Humanoid, Preset)
	v2.Parent = p1.Backpack
end
function weldArmor(p1, p2, p3, p4, p5) --[[ weldArmor | Line: 81 ]]
	local v1 = p1.Parent

	if v1:FindFirstChild(p2) then
		return
	end

	local v2 = p3:Clone()

	v2.Name = p2
	v2.Parent = v1

	local Middle = v2.Middle
	local v3 = Middle.CFrame:Inverse()

	for i, v in ipairs(v2:GetChildren()) do
		if v:IsA("BasePart") then
			local Weld = Instance.new("Weld")

			Weld.Part0 = Middle
			Weld.Part1 = v

			local v4 = CFrame.new(Middle.Position)

			Weld.C0 = v3 * v4
			Weld.C1 = v.CFrame:Inverse() * v4
			Weld.Parent = Middle
			v.Anchored = false
			v.CanCollide = false

			continue
		end

		if v:IsA("Script") then
			v.Enabled = true
		end
	end

	local v5 = v1:FindFirstChild(p4)

	if v5 then
		local Weld = Instance.new("Weld")

		Weld.Part0 = v5
		Weld.Part1 = Middle
		Weld.C0 = CFrame.identity
		Weld.Parent = v5
	end

	if p5 == 0 then
		return
	end

	local Patch = v2:FindFirstChild("Patch")
	local v6 = if Patch then Patch:FindFirstChild("Patch") else Patch

	if not v6 then
		return
	end

	v6.Texture = "rbxassetid://" .. p5
end
function GiveArmorValue(p1, p2) --[[ GiveArmorValue | Line: 127 ]]
	local armorFolder = p1.Parent:FindFirstChild("armorFolder")

	if not armorFolder then
		return
	end

	local HelmetProtect = p2:FindFirstChild("HelmetProtect")
	local VestProtect = p2:FindFirstChild("VestProtect")

	if HelmetProtect then
		armorFolder.helmetProtection.Value = HelmetProtect.Value

		return
	end

	if not VestProtect then
		return
	end

	armorFolder.vestProtection.Value = VestProtect.Value
end
function LoseArmorValue(p1, p2) --[[ LoseArmorValue | Line: 141 ]]
	local armorFolder = p1.Parent:FindFirstChild("armorFolder")

	if not armorFolder then
		return
	end

	if p2.Type.Value == "Helmet" then
		armorFolder.helmetProtection.Value = 0

		return
	end

	if p2.Type.Value ~= "Vest" then
		return
	end

	armorFolder.vestProtection.Value = 0
end
function HideHats(p1) --[[ HideHats | Line: 152 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("Accessory") then
			for i2, v2 in ipairs(v:GetChildren()) do
				if v2:IsA("BasePart") then
					v2.Transparency = 1
				end
			end
		end
	end
end
function ShowHats(p1) --[[ ShowHats | Line: 164 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("Accessory") then
			for i2, v2 in ipairs(v:GetChildren()) do
				if v2:IsA("BasePart") then
					v2.Transparency = 0
				end
			end
		end
	end
end
function t.armorSetup() --[[ armorSetup | Line: 176 ]]
	for i, v in ipairs(script.armorConfigFolder:GetChildren()) do
		local Model = v:FindFirstChild("Model")

		if Model and not Model:FindFirstChild("Preset") then
			local Preset = Instance.new("ObjectValue")

			Preset.Name = "Preset"
			Preset.Value = v
			Preset.Parent = Model
		end
	end
end

return t