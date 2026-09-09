-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local v1 = script.Parent
local States = require(ReplicatedStorage.Modules.DirectionalAnimation.States)
local Xanimator = require(ReplicatedStorage.Modules.DirectionalAnimation.Xanimator)
local Humanoid = v1:WaitForChild("Humanoid", 10)

if not Humanoid then
	return
end

local v2 = Humanoid:FindFirstChildOfClass("Animator") or Humanoid:WaitForChild("Animator", 10)

if not v2 then
	return
end

local v3 = nil
local v4 = nil
local v5 = nil

local function cleanup() --[[ cleanup | Line: 23 | Upvalues: v5 (ref), v4 (ref), v3 (ref) ]]
	if v5 then
		v5:Disconnect()
		v5 = nil
	end

	if v4 then
		pcall(function() --[[ Line: 29 | Upvalues: v4 (ref) ]]
			v4:destroy()
		end)
		v4 = nil
	end

	if not v3 then
		return
	end

	pcall(function() --[[ Line: 33 | Upvalues: v3 (ref) ]]
		v3:Destroy()
	end)
	v3 = nil
end

local ContentProvider = game:GetService("ContentProvider")
local AnimationManager = require(ReplicatedStorage.Modules.DirectionalAnimation.States.Modules.AnimationManager)
local t = {}
local v6 = pairs

for v8, v9 in v6(AnimationManager.ANIMATION_IDS or {}) do
	if v9 and v9 ~= "" then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = v9
		table.insert(t, Animation)
	end
end

if #t > 0 then
	pcall(function() --[[ Line: 58 | Upvalues: ContentProvider (copy), t (copy) ]]
		ContentProvider:PreloadAsync(t)
	end)
end

local v10 = false

for i = 1, 5 do
	task.wait((i - 1) * 0.5 + 0.5)

	if not v1.Parent then
		return
	end

	local ok, result = pcall(function() --[[ Line: 69 | Upvalues: v3 (ref), Xanimator (copy), v2 (copy), v4 (ref), States (copy), v1 (copy) ]]
		v3 = Xanimator.new(v2)
		v4 = States.new(v1, v3)
		v4:loadAnimations()
	end)

	if ok then
		v10 = true

		break
	end

	warn("[DirAnim] Init attempt", i, "failed:", result)
	cleanup()
end

if v10 then
	v5 = RunService.PreAnimation:Connect(function(p1) --[[ Line: 89 | Upvalues: v4 (ref), v3 (ref), v1 (copy) ]]
		if v4 and (v3 and v1.Parent) then
			pcall(function() --[[ Line: 91 | Upvalues: v3 (ref), p1 (copy) ]]
				v3:Update(p1)
			end)
			pcall(function() --[[ Line: 92 | Upvalues: v4 (ref), p1 (copy) ]]
				v4:update(p1)
			end)
		end
	end)
	script.Destroying:Connect(cleanup)
	print("[DirAnim] Initialized")
else
	warn("[DirAnim] Failed after", 5, "attempts")
end