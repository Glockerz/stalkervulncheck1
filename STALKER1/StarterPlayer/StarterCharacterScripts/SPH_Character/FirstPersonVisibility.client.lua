-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local GameConfig = require(game:GetService("ReplicatedStorage").SPH_Assets.GameConfig)

game:GetService("UserInputService")

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local v1 = false
local v2 = false
local v3 = script.Parent.Parent
local Humanoid = v3:WaitForChild("Humanoid")
local v4 = if Humanoid.RigType == Enum.HumanoidRigType.R6 then v3:WaitForChild("Torso") else v3:WaitForChild("UpperTorso")
local Head = v3:FindFirstChild("Head")
local HumanoidRootPart = v3:FindFirstChild("HumanoidRootPart")
local v5 = v4:FindFirstChild("Left Shoulder")
local v6 = nil

Humanoid.Died:Connect(function() --[[ Line: 27 | Upvalues: v1 (ref) ]]
	v1 = true
end)
Humanoid.Seated:Connect(function(p1, p2) --[[ Line: 31 | Upvalues: v2 (ref) ]]
	v2 = p1 and p2:IsA("VehicleSeat") and true or false
end)

local function CheckForBodyPartNames(p1, p2) --[[ CheckForBodyPartNames | Line: 40 | Upvalues: v3 (copy) ]]
	for i, v in ipairs(p1:GetChildren()) do
		local v1 = v3:FindFirstChild(v.Name)

		if v1 and (v1:IsA("BasePart") and not (string.find(v1.Name, "Arm") and p2)) then
			return v
		end
	end
end

local t = {}

local function addDescendantsToList(p1, p2) --[[ addDescendantsToList | Line: 61 ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") or (v:IsA("Texture") or v:IsA("Decal")) then
			table.insert(p2, v)
		end
	end
end

local function buildEntry(p1) --[[ buildEntry | Line: 72 | Upvalues: CheckForBodyPartNames (copy), v6 (ref), GameConfig (copy), Head (copy), addDescendantsToList (copy) ]]
	if p1:IsA("BasePart") then
		local v1 = p1.Name
		local v2 = string.find(v1, "Arm") ~= nil

		if v2 or (string.find(v1, "Leg") or (string.find(v1, "Torso") or string.find(v1, "Foot"))) then
			return {
				kind = "bodyPart",
				part = p1,
				armGated = v2
			}
		end

		return nil
	end

	if not p1:IsA("Model") then
		return nil
	end

	if not p1:FindFirstChildWhichIsA("BasePart") then
		return nil
	end

	local Middle = p1:FindFirstChild("Middle")

	if not Middle then
		Middle = p1:FindFirstChild("Grip")

		if not Middle then
			Middle = CheckForBodyPartNames(p1, v6 ~= nil)
		end
	end

	if Middle and p1.Name ~= "WeaponRig" then
		if string.find(p1.Name, "Holster_") and not GameConfig.firstPersonHolsters then
			return nil
		end

		local v62 = false
		local v7 = false

		for i, v in ipairs((Middle:GetJoints())) do
			if v.Part0 == Head or v.Part1 == Head then
				v62 = true

				break
			elseif string.find(v.Part0.Name, "Arm") or string.find(v.Part1.Name, "Arm") then
				v7 = true
			end
		end

		if v62 then
			return {
				kind = "gear",
				badMorphHead = true,
				parts = {},
				hasArmWeld = v7
			}
		end

		local t = {}

		addDescendantsToList(p1, t)

		return {
			kind = "gear",
			badMorphHead = false,
			parts = t,
			hasArmWeld = v7
		}
	end

	if string.find(p1.Name, "Arm") then
		local t = {}

		for i, v in ipairs(p1:GetChildren()) do
			if v:IsA("BasePart") then
				table.insert(t, v)
			end
		end

		return {
			kind = "armModel",
			parts = t
		}
	end

	if #p1:GetChildren() ~= 1 then
		return nil
	end

	local v8 = p1:FindFirstChildWhichIsA("BasePart")

	if not v8 then
		return nil
	end

	for i, v in ipairs((v8:GetJoints())) do
		if v.Part0 == Head or v.Part1 == Head then
			return nil
		end
	end

	local t = { v8 }

	for i, v in ipairs(v8:GetChildren()) do
		if v:IsA("Texture") or v:IsA("Decal") then
			table.insert(t, v)
		end
	end

	return {
		kind = "singlePart",
		parts = t
	}
end

local function cacheChild(p1) --[[ cacheChild | Line: 148 | Upvalues: buildEntry (copy), t (copy) ]]
	local v1 = buildEntry(p1)

	if not v1 then
		return
	end

	t[p1] = v1
end

local function rebuildAllCache() --[[ rebuildAllCache | Line: 153 | Upvalues: t (copy), v3 (copy), buildEntry (copy) ]]
	table.clear(t)

	for i, v in ipairs(v3:GetChildren()) do
		local v1 = buildEntry(v)

		if v1 then
			t[v] = v1
		end
	end
end

local function refreshGunEquipped() --[[ refreshGunEquipped | Line: 163 | Upvalues: v6 (ref), v3 (copy), rebuildAllCache (copy) ]]
	local v1 = v6
	local v2 = v3:FindFirstChildWhichIsA("Tool")

	v6 = if v2 and v2:FindFirstChild("SPH_Weapon") then v2 else nil

	if v1 ~= nil == (if v6 == nil then false else true) then
		return
	end

	rebuildAllCache()
end

v3.ChildAdded:Connect(function(p1) --[[ Line: 181 | Upvalues: v6 (ref), v3 (copy), rebuildAllCache (copy), buildEntry (copy), t (copy) ]]
	if p1:IsA("Tool") then
		local v1 = v6
		local v2 = v3:FindFirstChildWhichIsA("Tool")

		v6 = if v2 and v2:FindFirstChild("SPH_Weapon") then v2 else nil

		local v4 = if v6 == nil then false else true

		if (if v1 == nil then false else true) == v4 then
			p1.ChildAdded:Connect(function(p13) --[[ Line: 185 | Upvalues: v6 (ref), v3 (ref), rebuildAllCache (ref) ]]
				if p13.Name ~= "SPH_Weapon" then
					return
				end

				local v1 = v6
				local v2 = v3:FindFirstChildWhichIsA("Tool")

				v6 = if v2 and v2:FindFirstChild("SPH_Weapon") then v2 else nil

				if v1 ~= nil == (if v6 == nil then false else true) then
					return
				end

				rebuildAllCache()
			end)

			return
		end

		rebuildAllCache()
		p1.ChildAdded:Connect(function(p13) --[[ Line: 185 | Upvalues: v6 (ref), v3 (ref), rebuildAllCache (ref) ]]
			if p13.Name ~= "SPH_Weapon" then
				return
			end

			local v1 = v6
			local v2 = v3:FindFirstChildWhichIsA("Tool")

			v6 = if v2 and v2:FindFirstChild("SPH_Weapon") then v2 else nil

			if v1 ~= nil == (if v6 == nil then false else true) then
				return
			end

			rebuildAllCache()
		end)
	else
		local v5 = buildEntry(p1)

		if not v5 then
			return
		end

		t[p1] = v5
	end
end)
v3.ChildRemoved:Connect(function(p1) --[[ Line: 193 | Upvalues: v6 (ref), v3 (copy), rebuildAllCache (copy), t (copy) ]]
	if p1:IsA("Tool") then
		local v1 = v6
		local v2 = v3:FindFirstChildWhichIsA("Tool")

		v6 = if v2 and v2:FindFirstChild("SPH_Weapon") then v2 else nil

		if v1 ~= nil ~= (if v6 == nil then false else true) then
			rebuildAllCache()
		end
	else
		t[p1] = nil
	end
end)

local v7 = v6
local v8 = v3:FindFirstChildWhichIsA("Tool")

v6 = if v8 and v8:FindFirstChild("SPH_Weapon") then v8 else nil

local v10 = if v6 == nil then false else true

if (if v7 == nil then false else true) ~= v10 then
	rebuildAllCache()
end

rebuildAllCache()
RunService.RenderStepped:Connect(function() --[[ Line: 208 | Upvalues: v3 (copy), v1 (ref), v2 (ref), Head (copy), Workspace (copy), HumanoidRootPart (copy), v5 (copy), t (copy) ]]
	if not (v3:FindFirstChild("Torso") or v3:FindFirstChild("UpperTorso")) or (v1 or v2) then
		return
	end

	if Head and Head.LocalTransparencyModifier == 0 then
		return
	end

	local CurrentCamera = Workspace.CurrentCamera

	if not (CurrentCamera and HumanoidRootPart) then
		return
	end

	if (CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Magnitude > 3 then
		return
	end

	local v12 = v5 and v5.Enabled

	for k, v in pairs(t) do
		local kind = v.kind

		if kind == "bodyPart" then
			if not v.armGated or v12 then
				local part = v.part

				if part.LocalTransparencyModifier ~= 0 then
					part.LocalTransparencyModifier = 0
				end
			end

			continue
		end

		if kind == "gear" or kind == "singlePart" then
			local parts = v.parts

			for i = 1, #parts do
				local v22 = parts[i]

				if v22.LocalTransparencyModifier ~= 1 then
					v22.LocalTransparencyModifier = 1
				end
			end

			continue
		end

		if kind == "armModel" and v12 then
			local parts = v.parts

			for j = 1, #parts do
				local v32 = parts[j]

				if v32.LocalTransparencyModifier ~= 0 then
					v32.LocalTransparencyModifier = 0
				end
			end
		end
	end
end)