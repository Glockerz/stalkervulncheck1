-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local v1 = LocalPlayer:GetMouse()
local Update = script.Update
local t = {
	LookMode = "Camera",
	HeadLook = false,
	ArmsLook = false
}
local t2 = {}

local function getNeck(p1, p2) --[[ getNeck | Line: 17 ]]
	if not (p1 and p2) then
		return
	end

	if p2.RigType == Enum.HumanoidRigType.R6 then
		local Torso = p1:FindFirstChild("Torso")

		return if Torso then Torso:FindFirstChild("Neck") else Torso
	end

	if p2.RigType ~= Enum.HumanoidRigType.R15 then
		return
	end

	local Head = p1:FindFirstChild("Head")

	return if Head then Head:FindFirstChild("Neck") else Head
end

local function getShoulders(p1, p2) --[[ getShoulders | Line: 30 ]]
	if not (p1 and p2) then
		return
	end

	if p2.RigType == Enum.HumanoidRigType.R6 then
		local Torso = p1:FindFirstChild("Torso")
		local v1 = if Torso then Torso:FindFirstChild("Left Shoulder") else Torso

		return v1, if Torso then Torso:FindFirstChild("Right Shoulder") else Torso
	end

	if p2.RigType ~= Enum.HumanoidRigType.R15 then
		return
	end

	local LeftUpperArm = p1:FindFirstChild("LeftUpperArm")
	local RightUpperArm = p1:FindFirstChild("RightUpperArm")

	return if LeftUpperArm then LeftUpperArm:FindFirstChild("LeftShoulder") else LeftUpperArm, if RightUpperArm then RightUpperArm:FindFirstChild("RightShoulder") else RightUpperArm
end

local function getLookDirection(p1) --[[ getLookDirection | Line: 48 | Upvalues: v1 (copy), t (copy) ]]
	local LookVector = p1.CFrame:ToObjectSpace(workspace.CurrentCamera.CFrame).LookVector
	local LookVector2 = p1.CFrame:ToObjectSpace(CFrame.lookAt(p1.CFrame.Position, v1.Hit.Position)).LookVector
	local v12 = Vector3.new(0, 0, -1)

	if t.LookMode == "Camera" then
		return LookVector
	end

	if t.LookMode == "Mouse" then
		v12 = LookVector2
	end

	return v12
end

local function getDefaultNeckCFrame(p1) --[[ getDefaultNeckCFrame | Line: 62 ]]
	if p1.RigType == Enum.HumanoidRigType.R6 then
		return CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
	end

	if p1.RigType == Enum.HumanoidRigType.R15 then
		return CFrame.new(-5.96046448e-8, 0.800017118, 1.1920929e-7, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	end
end

local function getDefaultShoulderCFrames(p1) --[[ getDefaultShoulderCFrames | Line: 70 ]]
	if p1.RigType == Enum.HumanoidRigType.R6 then
		return CFrame.new(-1, 0.5, 0) * CFrame.Angles(0, -1.55, 0), CFrame.new(1, 0.5, 0) * CFrame.Angles(0, 1.55, 0)
	end

	if p1.RigType == Enum.HumanoidRigType.R15 then
		return CFrame.new(-1, 0.56301713, 1.1920929e-7, 1, 0, 0, 0, 1, 0, 0, 0, 1), CFrame.new(0.99999994, 0.56301713, 1.1920929e-7, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	end
end

local function getNeckTransformerCFrame(p1, p2) --[[ getNeckTransformerCFrame | Line: 82 ]]
	if p1.RigType == Enum.HumanoidRigType.R6 then
		return CFrame.Angles(-math.asin(p2.Y), 0, -math.asin(p2.X))
	end

	if p1.RigType == Enum.HumanoidRigType.R15 then
		return CFrame.Angles(math.asin(p2.Y), -math.asin(p2.X), 0)
	end
end

local function getShoulderTransformerCFrames(p1, p2) --[[ getShoulderTransformerCFrames | Line: 90 ]]
	if p1.RigType == Enum.HumanoidRigType.R6 then
		return CFrame.Angles(0, 0, -math.asin(p2.Unit.Y)), CFrame.Angles(0, 0, (math.asin(p2.Unit.Y)))
	end

	if p1.RigType == Enum.HumanoidRigType.R15 then
		return CFrame.Angles(math.asin(p2.Unit.Y), 0, 0), CFrame.Angles(math.asin(p2.Unit.Y), 0, 0)
	end
end

local function updatePlayer(p1, p2, p3, p4) --[[ updatePlayer | Line: 102 | Upvalues: getNeck (copy), getShoulders (copy), getDefaultNeckCFrame (copy), getNeckTransformerCFrame (copy), TweenService (copy), getDefaultShoulderCFrames (copy), getShoulderTransformerCFrames (copy) ]]
	local Character = p1.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChild("Humanoid")
	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	local v1 = getNeck(Character, Humanoid)
	local v2, v3 = getShoulders(Character, Humanoid)

	if not (Humanoid and (HumanoidRootPart and (v1 and (v2 and v3)))) then
		return
	end

	local v4 = Character:GetAttribute("LowReady") or 0

	if v4 > 0 and p4 then
		p2 = (CFrame.new() * CFrame.Angles(-0.13962634015954636 * v4, 0, 0)):VectorToWorldSpace(p2)
	end

	local v6 = TweenInfo.new(0.1)

	if p3 then
		TweenService:Create(v1, v6, {
			C0 = getDefaultNeckCFrame(Humanoid) * getNeckTransformerCFrame(Humanoid, p2)
		}):Play()
	else
		local v7 = getDefaultNeckCFrame(Humanoid)

		if v1.C0 ~= v7 then
			TweenService:Create(v1, v6, {
				C0 = v7
			}):Play()
		end
	end

	if p4 then
		local v8, v9 = getDefaultShoulderCFrames(Humanoid)
		local v10, v11 = getShoulderTransformerCFrames(Humanoid, p2)

		TweenService:Create(v2, v6, {
			C0 = v8 * v10
		}):Play()
		TweenService:Create(v3, v6, {
			C0 = v9 * v11
		}):Play()

		return
	end

	local v12, v13 = getDefaultShoulderCFrames(Humanoid)

	if v2.C0 ~= v12 then
		TweenService:Create(v2, v6, {
			C0 = v12
		}):Play()
	end

	if v3.C0 == v13 then
		return
	end

	TweenService:Create(v3, v6, {
		C0 = v13
	}):Play()
end

function t.Commence(p1, p2, p3, p4, p5) --[[ Commence | Line: 152 | Upvalues: t (copy), Update (copy), t2 (copy), RunService (copy), LocalPlayer (copy), getLookDirection (copy), updatePlayer (copy) ]]
	t.LookMode = p2 or "Camera"
	t.HeadLook = p3 or false
	t.ArmsLook = p4 or false
	Update.OnClientEvent:Connect(function(p1, ...) --[[ Line: 157 | Upvalues: t2 (ref) ]]
		t2[p1] = { ... }
	end)

	local v1 = 0

	RunService:BindToRenderStep("Update", Enum.RenderPriority.Character.Value + 10, function(p1) --[[ Line: 163 | Upvalues: LocalPlayer (ref), getLookDirection (ref), updatePlayer (ref), t (ref), v1 (ref), p5 (copy), Update (ref), t2 (ref) ]]
		local Character = LocalPlayer.Character

		if not Character then
			warn("1")

			return
		end

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			warn("1")

			return
		end

		local v12 = getLookDirection(HumanoidRootPart)

		updatePlayer(LocalPlayer, v12, t.HeadLook, t.ArmsLook)

		if (p5 or 0.1) <= v1 + 1 / 60 then
			v1 = 0
			Update:FireServer(v12, { t.HeadLook, t.ArmsLook })

			for k, v in pairs(t2) do
				updatePlayer(k, v[1], unpack(v[2]))
			end
		end

		v1 = v1 + p1
	end)

	return t
end

return t