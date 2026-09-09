-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"))
local v1 = Color3.fromRGB(140, 220, 120)
local v2 = Color3.fromRGB(160, 160, 160)
local v3 = Color3.fromRGB(140, 220, 120)
local v4 = Color3.fromRGB(235, 200, 90)
local v5 = Color3.fromRGB(225, 95, 95)
local v6 = Color3.fromRGB(150, 150, 150)

local function toHex(p1) --[[ toHex | Line: 22 ]]
	return string.format("#%02X%02X%02X", math.floor(p1.R * 255 + 0.5), math.floor(p1.G * 255 + 0.5), (math.floor(p1.B * 255 + 0.5)))
end

local function statusFor(p1) --[[ statusFor | Line: 29 | Upvalues: v3 (copy), v6 (copy), v5 (copy), v4 (copy) ]]
	if not p1 then
		return "Healthy", v3
	end

	if p1.Health <= 0 then
		return "Dead", v6
	end

	local MaxHealth = p1.MaxHealth
	local v1 = if MaxHealth and MaxHealth > 0 then p1.Health / MaxHealth or 1 else 1

	if v1 <= 0.25 then
		return "Critical", v5
	end

	if v1 <= 0.6 then
		return "Injured", v4
	end

	return "Healthy", v3
end

local t = {
	_squadIds = {},
	_initialized = false
}

local function v7(p1) --[[ ensureIndicator | Line: 43 | Upvalues: Players (copy), t (copy), LocalPlayer (copy), v7 (copy), v1 (copy), v3 (copy), v6 (copy), v5 (copy), v4 (copy), v2 (copy), RunService (copy) ]]
	if not p1 then
		return
	end

	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		task.spawn(function() --[[ Line: 51 | Upvalues: p1 (copy), Players (ref), t (ref), LocalPlayer (ref), v7 (ref) ]]
			if not p1:WaitForChild("HumanoidRootPart", 10) then
				return
			end

			local v1 = Players:GetPlayerFromCharacter(p1)

			if not v1 or v1.Character ~= p1 then
				return
			end

			if t._squadIds[v1.UserId] and v1 ~= LocalPlayer then
				v7(p1)
			end
		end)

		return
	end

	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		Humanoid = p1:WaitForChild("Humanoid", 2)
	end

	if Humanoid then
		Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	end

	if HumanoidRootPart:FindFirstChild("SquadNametag") then
		return
	end

	local v12 = Players:GetPlayerFromCharacter(p1)
	local v22 = if v12 then v12.DisplayName or "Squadmate" else "Squadmate"
	local SquadNametag = Instance.new("BillboardGui")

	SquadNametag.Name = "SquadNametag"
	SquadNametag.Size = UDim2.fromOffset(140, 36)
	SquadNametag.StudsOffsetWorldSpace = Vector3.new(0, 3.5, 0)
	SquadNametag.AlwaysOnTop = true
	SquadNametag.LightInfluence = 0
	SquadNametag.MaxDistance = 200
	SquadNametag.Adornee = HumanoidRootPart
	SquadNametag.Parent = HumanoidRootPart

	local Name = Instance.new("TextLabel")

	Name.Name = "Name"
	Name.Size = UDim2.fromScale(1, 0.58)
	Name.Position = UDim2.fromScale(0, 0)
	Name.BackgroundTransparency = 1
	Name.Font = Enum.Font.GothamBold
	Name.TextScaled = true
	Name.TextColor3 = v1
	Name.TextStrokeTransparency = 0.5
	Name.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Name.TextXAlignment = Enum.TextXAlignment.Center
	Name.TextYAlignment = Enum.TextYAlignment.Bottom
	Name.Text = v22
	Name.Parent = SquadNametag

	local Status = Instance.new("TextLabel")

	Status.Name = "Status"
	Status.Size = UDim2.fromScale(1, 0.34)
	Status.Position = UDim2.fromScale(0, 0.62)
	Status.BackgroundTransparency = 1
	Status.Font = Enum.Font.GothamMedium
	Status.TextScaled = true
	Status.RichText = true
	Status.TextStrokeTransparency = 0.6
	Status.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Status.TextColor3 = Color3.fromRGB(220, 220, 220)
	Status.TextXAlignment = Enum.TextXAlignment.Center
	Status.TextYAlignment = Enum.TextYAlignment.Top
	Status.Text = ""
	Status.Parent = SquadNametag
	task.spawn(function() --[[ Line: 128 | Upvalues: SquadNametag (copy), LocalPlayer (ref), HumanoidRootPart (copy), p1 (copy), v3 (ref), v6 (ref), v5 (ref), v4 (ref), Status (copy), v2 (ref), RunService (ref) ]]
		local sum = (1 / 0)

		while SquadNametag.Parent do
			local v1, v22
			local v32 = nil
			local Character = LocalPlayer.Character
			local v42 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

			if v42 and HumanoidRootPart.Parent then
				v32 = (v42.Position - HumanoidRootPart.Position).Magnitude
			end

			if v32 then
				local v62 = math.clamp(340 / math.max(v32, 1), 15, 38)

				SquadNametag.Size = UDim2.fromOffset(math.floor(v62 * 4), (math.floor(v62)))
			end

			if sum >= 0.2 then
				sum = 0

				local Humanoid = p1:FindFirstChildOfClass("Humanoid")

				if Humanoid then
					if Humanoid.Health <= 0 then
						v1 = v6
						v22 = "Dead"
					else
						local MaxHealth = Humanoid.MaxHealth
						local v7 = if MaxHealth and MaxHealth > 0 then Humanoid.Health / MaxHealth or 1 else 1

						if v7 <= 0.25 then
							v1 = v5
							v22 = "Critical"
						elseif v7 <= 0.6 then
							v1 = v4
							v22 = "Injured"
						else
							v1 = v3
							v22 = "Healthy"
						end
					end
				else
					v1 = v3
					v22 = "Healthy"
				end

				local v8 = v32 and string.format("%dm", (math.floor(v32 + 0.5))) or ""

				if v8 == "" then
					local format = string.format

					Status.Text = format("<font color=\"%s\">%s</font>", string.format("#%02X%02X%02X", math.floor(v1.R * 255 + 0.5), math.floor(v1.G * 255 + 0.5), (math.floor(v1.B * 255 + 0.5))), v22)
				else
					local format = string.format
					local v21 = string.format("#%02X%02X%02X", math.floor(v1.R * 255 + 0.5), math.floor(v1.G * 255 + 0.5), (math.floor(v1.B * 255 + 0.5)))
					local v222 = v2

					Status.Text = format("<font color=\"%s\">%s</font>  <font color=\"%s\">%s</font>", v21, v22, string.format("#%02X%02X%02X", math.floor(v222.R * 255 + 0.5), math.floor(v222.G * 255 + 0.5), (math.floor(v222.B * 255 + 0.5))), v8)
				end
			end

			sum = sum + RunService.Heartbeat:Wait()
		end
	end)
end

local function removeIndicator(p1) --[[ removeIndicator | Line: 161 ]]
	if not p1 then
		return
	end

	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
	end

	local function removeFrom(p1) --[[ removeFrom | Line: 171 ]]
		if not p1 then
			return
		end

		local SquadNametag = p1:FindFirstChild("SquadNametag")

		if not SquadNametag then
			return
		end

		SquadNametag:Destroy()
	end

	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		local SquadNametag = HumanoidRootPart:FindFirstChild("SquadNametag")

		if SquadNametag then
			SquadNametag:Destroy()
		end
	end

	local Head = p1:FindFirstChild("Head")

	if Head then
		local SquadNametag = Head:FindFirstChild("SquadNametag")

		if SquadNametag then
			SquadNametag:Destroy()
		end
	end

	local PrimaryPart = p1.PrimaryPart

	if not PrimaryPart then
		return
	end

	local SquadNametag = PrimaryPart:FindFirstChild("SquadNametag")

	if not SquadNametag then
		return
	end

	SquadNametag:Destroy()
end

local function refreshPlayer(p1) --[[ refreshPlayer | Line: 181 | Upvalues: t (copy), LocalPlayer (copy), v7 (copy), removeIndicator (copy) ]]
	if not p1.Character then
		return
	end

	if t._squadIds[p1.UserId] and p1 ~= LocalPlayer then
		v7(p1.Character)

		return
	end

	removeIndicator(p1.Character)
end

local function refreshAll() --[[ refreshAll | Line: 190 | Upvalues: Players (copy), t (copy), LocalPlayer (copy), v7 (copy), removeIndicator (copy) ]]
	for i, v in ipairs(Players:GetPlayers()) do
		if v.Character then
			if t._squadIds[v.UserId] and v ~= LocalPlayer then
				v7(v.Character)

				continue
			end

			removeIndicator(v.Character)
		end
	end
end

function t.Init(p1) --[[ Init | Line: 196 | Upvalues: SquadController (copy), LocalPlayer (copy), Players (copy), t (copy), v7 (copy), removeIndicator (copy) ]]
	if p1._initialized then
		return
	end

	p1._initialized = true
	SquadController:OnChanged(function(p12) --[[ Line: 200 | Upvalues: p1 (copy), LocalPlayer (ref), Players (ref), t (ref), v7 (ref), removeIndicator (ref) ]]
		p1._squadIds = {}

		if p12 then
			for k in pairs(p12.members) do
				local v1 = tonumber(k)

				if v1 and v1 ~= LocalPlayer.UserId then
					p1._squadIds[v1] = true
				end
			end
		end

		for i, v in ipairs(Players:GetPlayers()) do
			if v.Character then
				if t._squadIds[v.UserId] and v ~= LocalPlayer then
					v7(v.Character)

					continue
				end

				removeIndicator(v.Character)
			end
		end
	end)
	Players.PlayerAdded:Connect(function(p1) --[[ Line: 214 | Upvalues: t (ref), LocalPlayer (ref), v7 (ref), removeIndicator (ref) ]]
		p1.CharacterAdded:Connect(function() --[[ Line: 215 | Upvalues: p1 (copy), t (ref), LocalPlayer (ref), v7 (ref), removeIndicator (ref) ]]
			local v1 = p1

			if not v1.Character then
				return
			end

			if t._squadIds[v1.UserId] and v1 ~= LocalPlayer then
				v7(v1.Character)

				return
			end

			removeIndicator(v1.Character)
		end)
	end)

	for i, v in ipairs(Players:GetPlayers()) do
		v.CharacterAdded:Connect(function() --[[ Line: 218 | Upvalues: v (copy), t (ref), LocalPlayer (ref), v7 (ref), removeIndicator (ref) ]]
			local v1 = v

			if not v1.Character then
				return
			end

			if t._squadIds[v1.UserId] and v1 ~= LocalPlayer then
				v7(v1.Character)

				return
			end

			removeIndicator(v1.Character)
		end)

		if v.Character and v.Character then
			if t._squadIds[v.UserId] and v ~= LocalPlayer then
				v7(v.Character)

				continue
			end

			removeIndicator(v.Character)
		end
	end
end

return t