-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent
local Torso = v1:WaitForChild("Torso")
local v2 = Torso:WaitForChild("Right Shoulder")
local v3 = Torso:WaitForChild("Left Shoulder")
local v4 = Torso:WaitForChild("Right Hip")
local v5 = Torso:WaitForChild("Left Hip")

Torso:WaitForChild("Neck")

local Humanoid = v1:WaitForChild("Humanoid")
local ReplicatedStorage = game.ReplicatedStorage
local StarterPlayer = game.StarterPlayer
local _ = script.Parent
local v6, v7

if game.ReplicatedStorage:FindFirstChild("SPH_Assets") then
	local SPH_Assets = game.ReplicatedStorage.SPH_Assets
	local GameConfig = require(SPH_Assets:WaitForChild("GameConfig"))

	animconfig = require(SPH_Assets:FindFirstChild("GameConfig"):WaitForChild("AnimationsConfig"))
	v6 = GameConfig.walkSpeed
	v7 = GameConfig.fallDamageDist
else
	animconfig = require(game.ReplicatedStorage:WaitForChild("AnimationsConfig"))
	v6 = Humanoid.WalkSpeed
	v7 = animconfig["Landing Mechanics"].RevertToDefaultFallDamageDistance
end

local idleSpeedSafetyRange = animconfig["Velocity Mechanics"].idleSpeedSafetyRange
local walkSpeedSafetyRange = animconfig["Velocity Mechanics"].walkSpeedSafetyRange
local Animations = animconfig.Animations
local ok, result = pcall(function() --[[ Line: 39 ]]
	return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v8 = ok and result

local function getRigScale() --[[ getRigScale | Line: 42 | Upvalues: v8 (copy), v1 (copy) ]]
	if v8 then
		return v1:GetScale()
	end

	return 1
end

local t = {
	pose = "Standing",
	currentAnim = "",
	currentAnimInstance = nil,
	currentAnimTrack = nil,
	currentAnimKeyframeHandler = nil,
	currentAnimLength = 0,
	currentAnimSpeed = 1,
	animTable = {},
	animNames = {
		idle = {
			{
				defaultid = "rbxassetid://180435571",
				weight = 9
			},
			{
				defaultid = "rbxassetid://180435792",
				weight = 1
			}
		},
		swim = {
			{
				defaultid = "rbxassetid://0",
				weight = 10
			}
		},
		swimidle = {
			{
				defaultid = "rbxassetid://0",
				weight = 10
			}
		},
		walk = {
			{
				defaultid = "rbxassetid://180426354",
				weight = 10
			}
		},
		run = {
			{
				defaultid = "run.xml",
				weight = 10
			}
		},
		jump = {
			{
				defaultid = "rbxassetid://125750702",
				weight = 10
			}
		},
		fall = {
			{
				defaultid = "rbxassetid://180436148",
				weight = 10
			}
		},
		land = {
			{
				defaultid = "rbxassetid://0",
				weight = 10
			}
		},
		climb = {
			{
				defaultid = "rbxassetid://180436334",
				weight = 10
			}
		},
		sit = {
			{
				defaultid = "rbxassetid://178130996",
				weight = 10
			}
		},
		toolnone = {
			{
				defaultid = "rbxassetid://182393478",
				weight = 10
			}
		},
		toolslash = {
			{
				defaultid = "rbxassetid://129967390",
				weight = 10
			}
		},
		toollunge = {
			{
				defaultid = "rbxassetid://129967478",
				weight = 10
			}
		},
		wave = {
			{
				defaultid = "rbxassetid://128777973",
				weight = 10
			}
		},
		point = {
			{
				defaultid = "rbxassetid://128853357",
				weight = 10
			}
		},
		dance1 = {
			{
				defaultid = "rbxassetid://182435998",
				weight = 10
			},
			{
				defaultid = "rbxassetid://182491037",
				weight = 10
			},
			{
				defaultid = "rbxassetid://182491065",
				weight = 10
			}
		},
		dance2 = {
			{
				defaultid = "rbxassetid://182436842",
				weight = 10
			},
			{
				defaultid = "rbxassetid://182491248",
				weight = 10
			},
			{
				defaultid = "rbxassetid://182491277",
				weight = 10
			}
		},
		dance3 = {
			{
				defaultid = "rbxassetid://182436935",
				weight = 10
			},
			{
				defaultid = "rbxassetid://182491368",
				weight = 10
			},
			{
				defaultid = "rbxassetid://182491423",
				weight = 10
			}
		},
		laugh = {
			{
				defaultid = "rbxassetid://129423131",
				weight = 10
			}
		},
		cheer = {
			{
				defaultid = "rbxassetid://129423030",
				weight = 10
			}
		}
	},
	dances = { "dance1", "dance2", "dance3" },
	emoteNames = {
		wave = false,
		point = false,
		dance1 = true,
		dance2 = true,
		dance3 = true,
		laugh = false,
		cheer = false
	}
}
local pose = t.pose
local currentAnim = t.currentAnim
local currentAnimInstance = t.currentAnimInstance
local currentAnimTrack = t.currentAnimTrack
local currentAnimKeyframeHandler = t.currentAnimKeyframeHandler
local currentAnimLength = t.currentAnimLength
local currentAnimSpeed = t.currentAnimSpeed
local v9 = nil
local animTable = t.animTable
local animNames = t.animNames
local dances = t.dances
local emoteNames = t.emoteNames
local RunService = game:GetService("RunService")
local Humanoid2 = v1:WaitForChild("Humanoid")
local HumanoidRootPart = v1:WaitForChild("HumanoidRootPart")
local Y = HumanoidRootPart.Position.Y
local RevertToDefaultLandDelay = animconfig["Landing Mechanics"].RevertToDefaultLandDelay
local v10 = RaycastParams.new()

v10.IgnoreWater = false
v10.RespectCanCollide = false
v10.FilterType = Enum.RaycastFilterType.Exclude
v10.FilterDescendantsInstances = { v1 }

local v11 = 0
local v12 = false

task.wait()

if script:FindFirstChild("land").LandAnim.AnimationId ~= "rbxassetid://" .. 0 then
	RunService.RenderStepped:Connect(function() --[[ Line: 172 | Upvalues: pose (ref), Humanoid2 (copy), v11 (ref), HumanoidRootPart (copy), v10 (copy), v12 (ref), v7 (ref), Humanoid (copy), RevertToDefaultLandDelay (ref), currentAnimLength (ref), v1 (copy), Y (ref) ]]
		if pose == "Dead" then
			return
		end

		if Humanoid2.Sit then
			v11 = 0
		end

		local v13 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -3.1, 0), v10)

		if v13 and v13.Instance then
			if v12 then
				v12 = false

				if v11 > v7 + animconfig["Landing Mechanics"].FallDistanceAddition and pose ~= "Landing" then
					pose = "Landing"
					playAnimation("land", 0.1, Humanoid)
					RevertToDefaultLandDelay = currentAnimLength

					if RevertToDefaultLandDelay == 0 then
						RevertToDefaultLandDelay = animconfig["Landing Mechanics"].RevertToDefaultLandDelay
					end

					if animconfig["Landing Mechanics"].FindDefaultLandDelay then
						if currentAnimLength == 0 then
							warn("FIND LAND DELAY |", "Animation Loading... LAND AGAIN.")
						else
							warn("FIND LAND DELAY |", RevertToDefaultLandDelay, "- Use as Default LandDelay")
						end
					end

					task.wait(RevertToDefaultLandDelay)
					pose = "Standing"
					onMoving(v1.PrimaryPart.Velocity.Magnitude)
				end

				v11 = 0
			end
		else
			v12 = true
		end

		local Y2 = HumanoidRootPart.Position.Y

		v11 = if Y2 < Y and v12 then v11 + (Y - Y2) else 0
		Y = Y2
	end)
end

function configureAnimationSet(p1, p2) --[[ configureAnimationSet | Line: 218 | Upvalues: animTable (copy) ]]
	if animTable[p1] ~= nil then
		for k, v in pairs(animTable[p1].connections) do
			v:Disconnect()
		end
	end

	animTable[p1] = {}
	animTable[p1].count = 0
	animTable[p1].totalWeight = 0
	animTable[p1].connections = {}

	local v1 = script:FindFirstChild(p1)

	if v1 ~= nil then
		table.insert(animTable[p1].connections, v1.ChildAdded:Connect(function(p12) --[[ Line: 233 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))
		table.insert(animTable[p1].connections, v1.ChildRemoved:Connect(function(p12) --[[ Line: 234 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))

		local count = 1

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("Animation") then
				table.insert(animTable[p1].connections, v.Changed:Connect(function(p12) --[[ Line: 238 | Upvalues: p1 (copy), p2 (copy) ]]
					configureAnimationSet(p1, p2)
				end))
				animTable[p1][count] = {}
				animTable[p1][count].anim = v

				local Weight = v:FindFirstChild("Weight")

				if Weight == nil then
					animTable[p1][count].weight = 1
				else
					animTable[p1][count].weight = Weight.Value
				end

				animTable[p1].count = animTable[p1].count + 1
				animTable[p1].totalWeight = animTable[p1].totalWeight + animTable[p1][count].weight
				count = count + 1
			end
		end
	end

	if not (animTable[p1].count <= 0) then
		return
	end

	for k, v in pairs(p2) do
		animTable[p1][k] = {}
		animTable[p1][k].anim = Instance.new("Animation")
		animTable[p1][k].anim.Name = p1
		animTable[p1][k].anim.AnimationId = v.defaultid
		animTable[p1][k].weight = v.weight
		animTable[p1].count = animTable[p1].count + 1
		animTable[p1].totalWeight = animTable[p1].totalWeight + v.weight
	end
end
function scriptChildModified(p1) --[[ scriptChildModified | Line: 271 | Upvalues: animNames (copy) ]]
	local v1 = animNames[p1.Name]

	if v1 == nil then
		return
	end

	configureAnimationSet(p1.Name, v1)
end
script.ChildAdded:Connect(scriptChildModified)
script.ChildRemoved:Connect(scriptChildModified)

local v13 = if Humanoid then Humanoid:FindFirstChildOfClass("Animator") else nil

if v13 then
	for i, v in ipairs((v13:GetPlayingAnimationTracks())) do
		v:Stop(0)
		v:Destroy()
	end
end

for k, v in pairs(animNames) do
	configureAnimationSet(k, v)
end

local v15 = "None"
local v16 = 0
local v17 = 0

function stopAllAnimations() --[[ stopAllAnimations | Line: 312 | Upvalues: currentAnim (ref), emoteNames (copy), currentAnimInstance (ref), currentAnimKeyframeHandler (ref), currentAnimTrack (ref) ]]
	local v1 = currentAnim

	if emoteNames[v1] ~= nil and emoteNames[v1] == false then
		v1 = "idle"
	end

	currentAnim = ""
	currentAnimInstance = nil

	if currentAnimKeyframeHandler ~= nil then
		currentAnimKeyframeHandler:Disconnect()
	end

	if currentAnimTrack == nil then
		return v1
	end

	currentAnimTrack:Stop()
	currentAnimTrack:Destroy()
	currentAnimTrack = nil

	return v1
end
function setAnimationSpeed(p1) --[[ setAnimationSpeed | Line: 334 | Upvalues: currentAnimSpeed (ref), currentAnimTrack (ref) ]]
	if p1 == currentAnimSpeed then
		return
	end

	currentAnimSpeed = p1
	currentAnimTrack:AdjustSpeed(p1)
end
function keyFrameReachedFunc(p1) --[[ keyFrameReachedFunc | Line: 354 | Upvalues: currentAnim (ref), emoteNames (copy), currentAnimSpeed (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	local v1 = currentAnim

	if emoteNames[v1] ~= nil and emoteNames[v1] == false then
		v1 = "idle"
	end

	playAnimation(v1, 0, Humanoid)
	setAnimationSpeed(currentAnimSpeed)
end
function playAnimation(p1, p2, p3) --[[ playAnimation | Line: 370 | Upvalues: animTable (copy), currentAnimInstance (ref), currentAnimTrack (ref), currentAnimSpeed (ref), v9 (ref), currentAnimLength (ref), currentAnim (ref), currentAnimKeyframeHandler (ref) ]]
	local sum = math.random(1, animTable[p1].totalWeight)
	local count = 1

	while animTable[p1][count].weight < sum do
		sum = sum - animTable[p1][count].weight
		count = count + 1
	end

	local anim = animTable[p1][count].anim

	if anim == currentAnimInstance then
		return
	end

	if currentAnimTrack ~= nil then
		currentAnimTrack:Stop(p2)
		currentAnimTrack:Destroy()
	end

	currentAnimTrack = p3:LoadAnimation(anim)
	currentAnimSpeed = 1
	v9 = currentAnimTrack.Priority
	currentAnimTrack.Priority = Enum.AnimationPriority.Core
	currentAnimLength = currentAnimTrack.Length / currentAnimSpeed
	currentAnimTrack:Play(p2)
	currentAnim = p1
	currentAnimInstance = anim

	if currentAnimKeyframeHandler ~= nil then
		currentAnimKeyframeHandler:Disconnect()
	end

	currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:Connect(keyFrameReachedFunc)
end

local v18 = ""
local v19 = nil
local v20 = nil
local v21 = nil

function toolKeyFrameReachedFunc(p1) --[[ toolKeyFrameReachedFunc | Line: 442 | Upvalues: v18 (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	playToolAnimation(v18, 0, Humanoid)
end
function playToolAnimation(p1, p2, p3, p4) --[[ playToolAnimation | Line: 450 | Upvalues: animTable (copy), v20 (ref), v19 (ref), v18 (ref), v21 (ref) ]]
	local sum = math.random(1, animTable[p1].totalWeight)
	local count = 1

	while animTable[p1][count].weight < sum do
		sum = sum - animTable[p1][count].weight
		count = count + 1
	end

	local anim = animTable[p1][count].anim

	if v20 == anim then
		return
	end

	if v19 ~= nil then
		v19:Stop()
		v19:Destroy()
		p2 = 0
	end

	v19 = p3:LoadAnimation(anim)

	if p4 then
		v19.Priority = p4
	end

	v19:Play(p2)
	v18 = p1
	v20 = anim
	v21 = v19.KeyframeReached:Connect(toolKeyFrameReachedFunc)
end
function stopToolAnimations() --[[ stopToolAnimations | Line: 485 | Upvalues: v18 (ref), v21 (ref), v20 (ref), v19 (ref) ]]
	local v1 = v18

	if v21 ~= nil then
		v21:Disconnect()
	end

	v18 = ""
	v20 = nil

	if v19 == nil then
		return v1
	end

	v19:Stop()
	v19:Destroy()
	v19 = nil

	return v1
end
function onMoving(p1) --[[ onMoving | Line: 508 | Upvalues: pose (ref), v8 (copy), v1 (copy), idleSpeedSafetyRange (copy), Humanoid (copy), emoteNames (copy), currentAnim (ref), v6 (ref), walkSpeedSafetyRange (copy), currentAnimInstance (ref) ]]
	if pose == "Landing" then
		return
	end

	local v2 = p1 / (if v8 then v1:GetScale() else 1)

	if v2 <= idleSpeedSafetyRange or Humanoid.MoveDirection.Magnitude <= 0.01 then
		if emoteNames[currentAnim] == nil then
			playAnimation("idle", 0.1, Humanoid)
			pose = "Standing"
		end
	else
		if v2 <= v6 + walkSpeedSafetyRange and idleSpeedSafetyRange < v2 then
			playAnimation("walk", 0.1, Humanoid)

			if not currentAnimInstance or currentAnimInstance.AnimationId ~= "rbxassetid://180426354" then
				pose = "Walking"

				return
			end

			setAnimationSpeed(v2 / 14.5)
			pose = "Walking"

			return
		end

		if not (v6 + walkSpeedSafetyRange < v2) then
			return
		end

		playAnimation("run", 0.1, Humanoid)

		if currentAnimInstance and currentAnimInstance.AnimationId == "run.xml" then
			setAnimationSpeed(v2 / 14.5)
		end

		pose = "Running"
	end
end
function onDied() --[[ onDied | Line: 531 | Upvalues: pose (ref) ]]
	pose = "Dead"
	task.wait(1)

	if not script then
		return
	end

	script:Destroy()
end
function onJumping() --[[ onJumping | Line: 539 | Upvalues: Humanoid (copy), v17 (ref), pose (ref) ]]
	playAnimation("jump", 0.1, Humanoid)
	v17 = 0.3
	pose = "Jumping"
end
function onClimbing(p1) --[[ onClimbing | Line: 545 | Upvalues: v8 (copy), v1 (copy), Humanoid (copy), pose (ref), v11 (ref) ]]
	local v12 = if v8 then v1:GetScale() else 1

	playAnimation("climb", 0.1, Humanoid)
	setAnimationSpeed(p1 / v12 / 12)
	pose = "Climbing"
	v11 = 0
end
function onGettingUp() --[[ onGettingUp | Line: 554 | Upvalues: pose (ref) ]]
	pose = "GettingUp"
end
function onFreeFall() --[[ onFreeFall | Line: 558 | Upvalues: pose (ref), v17 (ref), Humanoid (copy) ]]
	if pose == "Landing" then
		return
	end

	if not (v17 <= 0) then
		pose = "FreeFall"

		return
	end

	playAnimation("fall", 0.3, Humanoid)
	pose = "FreeFall"
end
function onFallingDown() --[[ onFallingDown | Line: 566 | Upvalues: pose (ref) ]]
	pose = "FallingDown"
end
function onSeated() --[[ onSeated | Line: 570 | Upvalues: pose (ref) ]]
	pose = "Seated"
end
function onPlatformStanding() --[[ onPlatformStanding | Line: 574 | Upvalues: pose (ref) ]]
	pose = "PlatformStanding"
end
function onSwimming(p1) --[[ onSwimming | Line: 578 | Upvalues: Humanoid (copy), pose (ref) ]]
	pose = if Humanoid.MoveDirection.Magnitude == 0 then if script:FindFirstChild("swimidle").SwimIdleAnim.AnimationId == "rbxassetid://" .. 0 then "Standing" else "SwimmingIdle" elseif script:FindFirstChild("swim").SwimAnim.AnimationId == "rbxassetid://" .. 0 then "Running" else "Swimming"
end
function getTool() --[[ getTool | Line: 594 | Upvalues: v1 (copy) ]]
	for i, v in ipairs(v1:GetChildren()) do
		if v.className == "Tool" then
			return v
		end
	end

	return nil
end
function getToolAnim(p1) --[[ getToolAnim | Line: 601 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v.Name == "toolanim" and v.className == "StringValue" then
			return v
		end
	end

	return nil
end
function animateTool() --[[ animateTool | Line: 610 | Upvalues: v15 (ref), Humanoid (copy) ]]
	if v15 == "None" then
		playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)

		return
	end

	if v15 == "Slash" then
		playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)

		return
	end

	if v15 == "Lunge" then
		playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
	end
end
function moveSit() --[[ moveSit | Line: 628 | Upvalues: v2 (copy), v3 (copy), v4 (copy), v5 (copy) ]]
	v2.MaxVelocity = 0.15
	v3.MaxVelocity = 0.15
	v2:SetDesiredAngle(1.57)
	v3:SetDesiredAngle(-1.57)
	v4:SetDesiredAngle(1.57)
	v5:SetDesiredAngle(-1.57)
end

local v22 = 0

function move(p1) --[[ move | Line: 639 | Upvalues: v22 (ref), v17 (ref), pose (ref), Humanoid (copy), v2 (copy), v3 (copy), v4 (copy), v5 (copy), v15 (ref), v16 (ref), v20 (ref) ]]
	local v1 = 1
	local v23 = 1
	local v32 = p1 - v22

	v22 = p1

	local v42 = false

	if v17 > 0 then
		v17 = v17 - v32
	end

	if animconfig.DEBUG["Pose Warns"] then
		warn(pose)
	end

	if pose == "Landing" then
		return
	end

	if pose == "FreeFall" and v17 <= 0 then
		playAnimation("fall", 0.3, Humanoid)
	else
		if pose == "Seated" then
			playAnimation("sit", 0.5, Humanoid)

			return
		end

		if pose == "Walking" then
			playAnimation("walk", 0.1, Humanoid)
		elseif pose == "Running" then
			playAnimation("run", 0.1, Humanoid)
		elseif pose == "Swimming" then
			playAnimation("swim", 0.1, Humanoid)
		elseif pose == "SwimmingIdle" then
			playAnimation("swimidle", 0.1, Humanoid)
		elseif pose == "Dead" or (pose == "GettingUp" or (pose == "FallingDown" or (pose == "Seated" or pose == "PlatformStanding"))) then
			stopAllAnimations()
			v42 = true
			v23 = 1
			v1 = 0.1
		end
	end

	if v42 then
		local v52 = v1 * math.sin(p1 * v23)

		v2:SetDesiredAngle(v52 + 0)
		v3:SetDesiredAngle(v52 - 0)
		v4:SetDesiredAngle(-v52)
		v5:SetDesiredAngle(-v52)
	end

	local v6 = getTool()

	if not (v6 and v6:FindFirstChild("Handle")) then
		stopToolAnimations()
		v15 = "None"
		v20 = nil
		v16 = 0

		return
	end

	local v7 = getToolAnim(v6)

	if v7 then
		v15 = v7.Value
		v7.Parent = nil
		v16 = p1 + 0.3
	end

	if not (v16 < p1) then
		animateTool()

		return
	end

	v16 = 0
	v15 = "None"
	animateTool()
end
Humanoid.Died:Connect(onDied)
Humanoid.Running:Connect(onMoving)
Humanoid.Jumping:Connect(onJumping)
Humanoid.Climbing:Connect(onClimbing)
Humanoid.GettingUp:Connect(onGettingUp)
Humanoid.FreeFalling:Connect(onFreeFall)
Humanoid.FallingDown:Connect(onFallingDown)
Humanoid.Seated:Connect(onSeated)
Humanoid.PlatformStanding:Connect(onPlatformStanding)
Humanoid.Swimming:Connect(onSwimming)
game:GetService("Players").LocalPlayer.Chatted:Connect(function(p1) --[[ Line: 725 | Upvalues: dances (copy), pose (ref), emoteNames (copy), Humanoid (copy) ]]
	local v1 = ""

	if p1 == "/e dance" then
		v1 = dances[math.random(1, #dances)]
	elseif string.sub(p1, 1, 3) == "/e " then
		v1 = string.sub(p1, 4)
	elseif string.sub(p1, 1, 7) == "/emote " then
		v1 = string.sub(p1, 8)
	end

	if pose ~= "Standing" or emoteNames[v1] == nil then
		return
	end

	playAnimation(v1, 0.1, Humanoid)
end)
script:WaitForChild("PlayEmote").OnInvoke = function(p1) --[[ Line: 742 | Upvalues: pose (ref), emoteNames (copy), Humanoid (copy), currentAnimTrack (ref) ]]
	if pose ~= "Standing" then
		return
	end

	if emoteNames[p1] == nil then
		return false
	end

	playAnimation(p1, 0.1, Humanoid)

	return true, currentAnimTrack
end
playAnimation("idle", 0.1, Humanoid)

while v1.Parent ~= nil do
	local _3, v23 = wait(0.1)

	move(v23)
end