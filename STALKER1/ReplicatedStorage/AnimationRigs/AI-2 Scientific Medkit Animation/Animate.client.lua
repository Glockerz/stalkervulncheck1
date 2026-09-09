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
local v6 = "Standing"
local ok, result = pcall(function() --[[ Line: 15 ]]
	return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v7 = ok and result

local function getRigScale() --[[ getRigScale | Line: 18 | Upvalues: v7 (copy), v1 (copy) ]]
	if v7 then
		return v1:GetScale()
	end

	return 1
end

local v8 = ""
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = 1
local t = {}
local tbl = {
	idle = {
		{
			id = "http://www.roblox.com/asset/?id=180435571",
			weight = 9
		},
		{
			id = "http://www.roblox.com/asset/?id=180435792",
			weight = 1
		}
	},
	walk = {
		{
			id = "http://www.roblox.com/asset/?id=180426354",
			weight = 10
		}
	},
	run = {
		{
			id = "run.xml",
			weight = 10
		}
	},
	jump = {
		{
			id = "http://www.roblox.com/asset/?id=125750702",
			weight = 10
		}
	},
	fall = {
		{
			id = "http://www.roblox.com/asset/?id=180436148",
			weight = 10
		}
	},
	climb = {
		{
			id = "http://www.roblox.com/asset/?id=180436334",
			weight = 10
		}
	},
	sit = {
		{
			id = "http://www.roblox.com/asset/?id=178130996",
			weight = 10
		}
	},
	toolnone = {
		{
			id = "http://www.roblox.com/asset/?id=182393478",
			weight = 10
		}
	},
	toolslash = {
		{
			id = "http://www.roblox.com/asset/?id=129967390",
			weight = 10
		}
	},
	toollunge = {
		{
			id = "http://www.roblox.com/asset/?id=129967478",
			weight = 10
		}
	},
	wave = {
		{
			id = "http://www.roblox.com/asset/?id=128777973",
			weight = 10
		}
	},
	point = {
		{
			id = "http://www.roblox.com/asset/?id=128853357",
			weight = 10
		}
	},
	dance1 = {
		{
			id = "http://www.roblox.com/asset/?id=182435998",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=182491037",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=182491065",
			weight = 10
		}
	},
	dance2 = {
		{
			id = "http://www.roblox.com/asset/?id=182436842",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=182491248",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=182491277",
			weight = 10
		}
	},
	dance3 = {
		{
			id = "http://www.roblox.com/asset/?id=182436935",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=182491368",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=182491423",
			weight = 10
		}
	},
	laugh = {
		{
			id = "http://www.roblox.com/asset/?id=129423131",
			weight = 10
		}
	},
	cheer = {
		{
			id = "http://www.roblox.com/asset/?id=129423030",
			weight = 10
		}
	}
}
local t2 = { "dance1", "dance2", "dance3" }
local t3 = {
	wave = false,
	point = false,
	dance1 = true,
	dance2 = true,
	dance3 = true,
	laugh = false,
	cheer = false
}

function configureAnimationSet(p1, p2) --[[ configureAnimationSet | Line: 98 | Upvalues: t (copy) ]]
	if t[p1] ~= nil then
		for k, v in pairs(t[p1].connections) do
			v:disconnect()
		end
	end

	t[p1] = {}
	t[p1].count = 0
	t[p1].totalWeight = 0
	t[p1].connections = {}

	local v1 = script:FindFirstChild(p1)

	if v1 ~= nil then
		table.insert(t[p1].connections, v1.ChildAdded:connect(function(p12) --[[ Line: 113 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))
		table.insert(t[p1].connections, v1.ChildRemoved:connect(function(p12) --[[ Line: 114 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))

		local count = 1

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("Animation") then
				table.insert(t[p1].connections, v.Changed:connect(function(p12) --[[ Line: 118 | Upvalues: p1 (copy), p2 (copy) ]]
					configureAnimationSet(p1, p2)
				end))
				t[p1][count] = {}
				t[p1][count].anim = v

				local Weight = v:FindFirstChild("Weight")

				if Weight == nil then
					t[p1][count].weight = 1
				else
					t[p1][count].weight = Weight.Value
				end

				t[p1].count = t[p1].count + 1
				t[p1].totalWeight = t[p1].totalWeight + t[p1][count].weight
				count = count + 1
			end
		end
	end

	if not (t[p1].count <= 0) then
		return
	end

	for k, v in pairs(p2) do
		t[p1][k] = {}
		t[p1][k].anim = Instance.new("Animation")
		t[p1][k].anim.Name = p1
		t[p1][k].anim.AnimationId = v.id
		t[p1][k].weight = v.weight
		t[p1].count = t[p1].count + 1
		t[p1].totalWeight = t[p1].totalWeight + v.weight
	end
end
function scriptChildModified(p1) --[[ scriptChildModified | Line: 151 | Upvalues: tbl (copy) ]]
	local v1 = tbl[p1.Name]

	if v1 == nil then
		return
	end

	configureAnimationSet(p1.Name, v1)
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)

local v13 = if Humanoid then Humanoid:FindFirstChildOfClass("Animator") else nil

if v13 then
	for i, v in ipairs((v13:GetPlayingAnimationTracks())) do
		v:Stop(0)
		v:Destroy()
	end
end

for k, v in pairs(tbl) do
	configureAnimationSet(k, v)
end

local v15 = "None"
local v16 = 0
local v17 = 0

function stopAllAnimations() --[[ stopAllAnimations | Line: 192 | Upvalues: v8 (ref), t3 (copy), v9 (ref), v11 (ref), v10 (ref) ]]
	local v1 = v8

	if t3[v1] ~= nil and t3[v1] == false then
		v1 = "idle"
	end

	v8 = ""
	v9 = nil

	if v11 ~= nil then
		v11:disconnect()
	end

	if v10 == nil then
		return v1
	end

	v10:Stop()
	v10:Destroy()
	v10 = nil

	return v1
end
function setAnimationSpeed(p1) --[[ setAnimationSpeed | Line: 214 | Upvalues: v12 (ref), v10 (ref) ]]
	if p1 == v12 then
		return
	end

	v12 = p1
	v10:AdjustSpeed(p1)
end
function keyFrameReachedFunc(p1) --[[ keyFrameReachedFunc | Line: 221 | Upvalues: v8 (ref), t3 (copy), v12 (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	local v1 = v8

	if t3[v1] ~= nil and t3[v1] == false then
		v1 = "idle"
	end

	playAnimation(v1, 0, Humanoid)
	setAnimationSpeed(v12)
end
function playAnimation(p1, p2, p3) --[[ playAnimation | Line: 237 | Upvalues: t (copy), v9 (ref), v10 (ref), v12 (ref), v8 (ref), v11 (ref) ]]
	local sum = math.random(1, t[p1].totalWeight)
	local count = 1

	while t[p1][count].weight < sum do
		sum = sum - t[p1][count].weight
		count = count + 1
	end

	local anim = t[p1][count].anim

	if anim == v9 then
		return
	end

	if v10 ~= nil then
		v10:Stop(p2)
		v10:Destroy()
	end

	v12 = 1
	v10 = p3:LoadAnimation(anim)
	v10.Priority = Enum.AnimationPriority.Core
	v10:Play(p2)
	v8 = p1
	v9 = anim

	if v11 ~= nil then
		v11:disconnect()
	end

	v11 = v10.KeyframeReached:connect(keyFrameReachedFunc)
end

local v18 = ""
local v19 = nil
local v20 = nil
local v21 = nil

function toolKeyFrameReachedFunc(p1) --[[ toolKeyFrameReachedFunc | Line: 286 | Upvalues: v18 (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	playToolAnimation(v18, 0, Humanoid)
end
function playToolAnimation(p1, p2, p3, p4) --[[ playToolAnimation | Line: 294 | Upvalues: t (copy), v20 (ref), v19 (ref), v18 (ref), v21 (ref) ]]
	local sum = math.random(1, t[p1].totalWeight)
	local count = 1

	while t[p1][count].weight < sum do
		sum = sum - t[p1][count].weight
		count = count + 1
	end

	local anim = t[p1][count].anim

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
	v21 = v19.KeyframeReached:connect(toolKeyFrameReachedFunc)
end
function stopToolAnimations() --[[ stopToolAnimations | Line: 329 | Upvalues: v18 (ref), v21 (ref), v20 (ref), v19 (ref) ]]
	local v1 = v18

	if v21 ~= nil then
		v21:disconnect()
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
function onRunning(p1) --[[ onRunning | Line: 352 | Upvalues: v7 (copy), v1 (copy), Humanoid (copy), v9 (ref), v6 (ref), t3 (copy), v8 (ref) ]]
	local v2 = p1 / (if v7 then v1:GetScale() else 1)

	if v2 > 0.01 then
		playAnimation("walk", 0.1, Humanoid)

		if v9 and v9.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
			setAnimationSpeed(v2 / 14.5)
		end

		v6 = "Running"
	else
		if t3[v8] ~= nil then
			return
		end

		playAnimation("idle", 0.1, Humanoid)
		v6 = "Standing"
	end
end
function onDied() --[[ onDied | Line: 369 | Upvalues: v6 (ref) ]]
	v6 = "Dead"
end
function onJumping() --[[ onJumping | Line: 373 | Upvalues: Humanoid (copy), v17 (ref), v6 (ref) ]]
	playAnimation("jump", 0.1, Humanoid)
	v17 = 0.3
	v6 = "Jumping"
end
function onClimbing(p1) --[[ onClimbing | Line: 379 | Upvalues: v7 (copy), v1 (copy), Humanoid (copy), v6 (ref) ]]
	local v12 = if v7 then v1:GetScale() else 1

	playAnimation("climb", 0.1, Humanoid)
	setAnimationSpeed(p1 / v12 / 12)
	v6 = "Climbing"
end
function onGettingUp() --[[ onGettingUp | Line: 387 | Upvalues: v6 (ref) ]]
	v6 = "GettingUp"
end
function onFreeFall() --[[ onFreeFall | Line: 391 | Upvalues: v17 (ref), Humanoid (copy), v6 (ref) ]]
	if not (v17 <= 0) then
		v6 = "FreeFall"

		return
	end

	playAnimation("fall", 0.3, Humanoid)
	v6 = "FreeFall"
end
function onFallingDown() --[[ onFallingDown | Line: 398 | Upvalues: v6 (ref) ]]
	v6 = "FallingDown"
end
function onSeated() --[[ onSeated | Line: 402 | Upvalues: v6 (ref) ]]
	v6 = "Seated"
end
function onPlatformStanding() --[[ onPlatformStanding | Line: 406 | Upvalues: v6 (ref) ]]
	v6 = "PlatformStanding"
end
function onSwimming(p1) --[[ onSwimming | Line: 410 | Upvalues: v6 (ref) ]]
	v6 = if p1 > 0 then "Running" else "Standing"
end
function getTool() --[[ getTool | Line: 418 | Upvalues: v1 (copy) ]]
	for i, v in ipairs(v1:GetChildren()) do
		if v.className == "Tool" then
			return v
		end
	end

	return nil
end
function getToolAnim(p1) --[[ getToolAnim | Line: 425 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v.Name == "toolanim" and v.className == "StringValue" then
			return v
		end
	end

	return nil
end
function animateTool() --[[ animateTool | Line: 434 | Upvalues: v15 (ref), Humanoid (copy) ]]
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
function moveSit() --[[ moveSit | Line: 452 | Upvalues: v2 (copy), v3 (copy), v4 (copy), v5 (copy) ]]
	v2.MaxVelocity = 0.15
	v3.MaxVelocity = 0.15
	v2:SetDesiredAngle(1.57)
	v3:SetDesiredAngle(-1.57)
	v4:SetDesiredAngle(1.57)
	v5:SetDesiredAngle(-1.57)
end

local v22 = 0

function move(p1) --[[ move | Line: 463 | Upvalues: v22 (ref), v17 (ref), v6 (ref), Humanoid (copy), v2 (copy), v3 (copy), v4 (copy), v5 (copy), v15 (ref), v16 (ref), v20 (ref) ]]
	local v1 = 1
	local v23 = 1
	local v32 = p1 - v22

	v22 = p1

	local v42 = false

	if v17 > 0 then
		v17 = v17 - v32
	end

	if v6 == "FreeFall" and v17 <= 0 then
		playAnimation("fall", 0.3, Humanoid)
	else
		if v6 == "Seated" then
			playAnimation("sit", 0.5, Humanoid)

			return
		end

		if v6 == "Running" then
			playAnimation("walk", 0.1, Humanoid)
		elseif v6 == "Dead" or (v6 == "GettingUp" or (v6 == "FallingDown" or (v6 == "Seated" or v6 == "PlatformStanding"))) then
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

	local v62 = getTool()

	if not (v62 and v62:FindFirstChild("Handle")) then
		stopToolAnimations()
		v15 = "None"
		v20 = nil
		v16 = 0

		return
	end

	local v7 = getToolAnim(v62)

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
Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)
Humanoid.Swimming:connect(onSwimming)
game:GetService("Players").LocalPlayer.Chatted:connect(function(p1) --[[ Line: 540 | Upvalues: t2 (copy), v6 (ref), t3 (copy), Humanoid (copy) ]]
	local v1 = ""

	if p1 == "/e dance" then
		v1 = t2[math.random(1, #t2)]
	elseif string.sub(p1, 1, 3) == "/e " then
		v1 = string.sub(p1, 4)
	elseif string.sub(p1, 1, 7) == "/emote " then
		v1 = string.sub(p1, 8)
	end

	if v6 ~= "Standing" or t3[v1] == nil then
		return
	end

	playAnimation(v1, 0.1, Humanoid)
end)
script:WaitForChild("PlayEmote").OnInvoke = function(p1) --[[ Line: 557 | Upvalues: v6 (ref), t3 (copy), Humanoid (copy), v10 (ref) ]]
	if v6 ~= "Standing" then
		return
	end

	if t3[p1] == nil then
		return false
	end

	playAnimation(p1, 0.1, Humanoid)

	return true, v10
end
playAnimation("idle", 0.1, Humanoid)

while v1.Parent ~= nil do
	local _2, v23 = wait(0.1)

	move(v23)
end