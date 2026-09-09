-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local v1 = Color3.fromRGB(255, 200, 100)
local bulletTracer = ReplicatedStorage:WaitForChild("miscEvents"):WaitForChild("bulletTracer")
local v2 = RaycastParams.new()

v2.FilterType = Enum.RaycastFilterType.Exclude
v2.IgnoreWater = true
bulletTracer.OnClientEvent:Connect(function(p1, p2) --[[ Line: 27 | Upvalues: v2 (copy), v1 (copy), TweenService (copy), Debris (copy) ]]
	if typeof(p1) ~= "Vector3" or typeof(p2) ~= "Vector3" then
		return
	end

	if p2.Magnitude < 0.001 then
		return
	end

	local Unit = p2.Unit
	local v12 = workspace:Raycast(p1, Unit * 300, v2)
	local v22 = if v12 then v12.Position else p1 + Unit * 300
	local Magnitude = (v22 - p1).Magnitude

	if not (Magnitude < 0.5) then
		local Part = Instance.new("Part")

		Part.Anchored = true
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.Material = Enum.Material.Neon
		Part.Color = v1
		Part.Size = Vector3.new(0.08, 0.08, Magnitude)
		Part.CFrame = CFrame.lookAt((p1 + v22) / 2, v22)
		Part.Transparency = 0.25
		Part.Parent = workspace
		TweenService:Create(Part, TweenInfo.new(0.08), {
			Transparency = 1
		}):Play()
		Debris:AddItem(Part, 0.13)
	end
end)