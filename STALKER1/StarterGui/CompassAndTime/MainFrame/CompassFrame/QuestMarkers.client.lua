-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local v1 = script.Parent
local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"))
local TaskTargetResolver = require(ReplicatedStorage:WaitForChild("TaskTargetResolver"))
local SquadMapResolver = require(ReplicatedStorage:WaitForChild("SquadMapResolver"))
local PdaMapData = require(ReplicatedStorage:WaitForChild("PdaMapData"))

TaskController:Init()
SquadController:Init()

local v2 = Color3.fromRGB(220, 50, 50)
local v3 = Color3.fromRGB(255, 205, 60)
local v4 = Color3.fromRGB(255, 150, 50)
local v5 = Color3.fromRGB(220, 50, 50)
local t = {}

for i = 1, 32 do
	local TextLabel = Instance.new("TextLabel")

	TextLabel.Name = "QuestMarker" .. i
	TextLabel.Size = UDim2.fromOffset(22, 18)
	TextLabel.AnchorPoint = Vector2.new(0.5, 1)
	TextLabel.Position = UDim2.new(0.5, 0, 0, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = "\226\150\188"
	TextLabel.TextColor3 = v2
	TextLabel.TextScaled = true
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.ZIndex = 10
	TextLabel.Visible = false

	local Stroke = Instance.new("UIStroke")

	Stroke.Name = "Stroke"
	Stroke.Color = Color3.fromRGB(0, 0, 0)
	Stroke.Thickness = 1
	Stroke.Transparency = 0.25
	Stroke.Parent = TextLabel
	TextLabel.Parent = v1
	t[i] = TextLabel
end

local function getAlwaysOnTargets() --[[ getAlwaysOnTargets | Line: 62 | Upvalues: Players (copy), Workspace (copy), SquadMapResolver (copy), PdaMapData (copy), v3 (copy), v4 (copy), v5 (copy) ]]
	local t = {}

	local function add(p1, p2, p3) --[[ add | Line: 64 | Upvalues: t (copy) ]]
		if not p1 then
			return
		end

		t[#t + 1] = {
			pos = p1,
			color = p2,
			transparency = p3 or 0
		}
	end

	local LocalPlayer = Players.LocalPlayer
	local v1 = Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame.Position or Vector3.new()

	for i, v in ipairs(SquadMapResolver.Resolve()) do
		local pos = v.pos
		local COLOR_SQUAD = SquadMapResolver.COLOR_SQUAD

		if pos then
			t[#t + 1] = {
				transparency = 0,
				pos = pos,
				color = COLOR_SQUAD
			}
		end
	end

	if Players.LocalPlayer:GetAttribute("_TutorialPending") then
		local v2 = PdaMapData.GetRegion(Players.LocalPlayer:GetAttribute("Zone") or "Cordon")

		if v2 and v2.Traders then
			for i, v in ipairs(v2.Traders) do
				if v.Id == "Crow" then
					local WorldPos = v.WorldPos
					local v32 = v3

					if WorldPos then
						t[#t + 1] = {
							transparency = 0,
							pos = WorldPos,
							color = v32
						}
					end
				end
			end
		end
	end

	local PlayerCharacters = Workspace:FindFirstChild("PlayerCharacters")
	local v42 = if PlayerCharacters then PlayerCharacters:FindFirstChild("HostileNPCs") else PlayerCharacters

	if v42 then
		for i, v in ipairs(v42:GetChildren()) do
			if v:IsA("Model") then
				local Humanoid = v:FindFirstChildOfClass("Humanoid")
				local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart")

				if Humanoid and (Humanoid.Health > 0 and HumanoidRootPart) then
					local Magnitude = (HumanoidRootPart.Position - v1).Magnitude
					local v52 = v:GetAttribute("Faction")

					if v52 == "Loner" then
						if Magnitude <= 250 then
							local Position = HumanoidRootPart.Position
							local v6 = v4

							if Position then
								t[#t + 1] = {
									transparency = 0,
									pos = Position,
									color = v6
								}
							end
						end

						continue
					end

					if v52 and Magnitude <= 250 then
						local Position = HumanoidRootPart.Position
						local v7 = v5

						if Position then
							t[#t + 1] = {
								transparency = 0.55,
								pos = Position,
								color = v7
							}
						end
					end
				end
			end
		end
	end

	return t
end

RunService.Heartbeat:Connect(function() --[[ Line: 120 | Upvalues: TaskTargetResolver (copy), getAlwaysOnTargets (copy), Workspace (copy), t (copy) ]]
	local v2 = TaskTargetResolver.Resolve((TaskTargetResolver.GetTrackedTask()))
	local v3 = getAlwaysOnTargets()
	local t2 = {}

	for i, v in ipairs(v2) do
		t2[#t2 + 1] = v
	end

	for i, v in ipairs(v3) do
		t2[#t2 + 1] = v
	end

	local CurrentCamera = Workspace.CurrentCamera

	if CurrentCamera then
		local Position = CurrentCamera.CFrame.Position

		for i = 1, 32 do
			local v4 = t2[i]
			local v5 = t[i]

			if v4 then
				local v6 = v4.pos - Position
				local v7 = Vector3.new(v6.X, 0, v6.Z)

				if v7.Magnitude < 0.01 then
					if v5.Visible then
						v5.Visible = false
					end

					continue
				end

				local v8 = CurrentCamera.CFrame:VectorToObjectSpace(v7.Unit)
				local v10 = math.atan2(v8.X, -v8.Z) * 238.09579486547543

				if v10 > 237 then
					v10 = 237
				elseif v10 < -237 then
					v10 = -237
				end

				v5.Position = UDim2.new(0.5, v10, 0, 0)

				if v5.TextColor3 ~= v4.color then
					v5.TextColor3 = v4.color
				end

				local v11 = v4.transparency or 0

				if v5.TextTransparency ~= v11 then
					v5.TextTransparency = v11
				end

				local Stroke = v5:FindFirstChild("Stroke")

				if Stroke then
					local v12 = math.min(1, 0.25 + v11 * 0.5)

					if Stroke.Transparency ~= v12 then
						Stroke.Transparency = v12
					end
				end

				if not v5.Visible then
					v5.Visible = true
				end

				continue
			end

			if v5.Visible then
				v5.Visible = false
			end
		end
	else
		for j = 1, 32 do
			if t[j].Visible then
				t[j].Visible = false
			end
		end
	end
end)