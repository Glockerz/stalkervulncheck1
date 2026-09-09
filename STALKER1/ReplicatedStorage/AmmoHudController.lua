-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"))
local InventoryWire = require(ReplicatedStorage:WaitForChild("InventoryWire"))
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)

local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v2 = Color3.fromRGB(24, 26, 24)
local v3 = Color3.fromRGB(255, 200, 90)
local v4 = Color3.fromRGB(228, 96, 96)

Color3.fromRGB(235, 235, 235)

local v5 = Color3.fromRGB(70, 70, 70)
local t = {}

for k, v in pairs(ItemDatabase) do
	if type(v) == "table" and v.ToolName then
		t[v.ToolName] = k
	end
end

local t2 = {
	_started = false
}
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil

local function ensureGui() --[[ ensureGui | Line: 38 | Upvalues: v6 (ref), LocalPlayer (copy), v9 (ref), v2 (copy), v5 (copy), v7 (ref), v3 (copy), v8 (ref), v1 (copy) ]]
	if v6 and v6.Parent then
		return
	end

	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local AmmoHud = PlayerGui:FindFirstChild("AmmoHud")
	local MagBody, v12, v22, Track, v32, v4

	if AmmoHud then
		AmmoHud:Destroy()
	end

	v6 = Instance.new("ScreenGui")
	v6.Name = "AmmoHud"
	v6.ResetOnSpawn = false
	v6.IgnoreGuiInset = true
	v6.DisplayOrder = 9
	v6.Enabled = false
	v6.Parent = PlayerGui
	v9 = Instance.new("Frame")
	v9.Name = "Root"
	v9.AnchorPoint = Vector2.new(0.5, 0.5)
	v9.Position = UDim2.new(0.89, 0, 0.86, 0)
	v9.Size = UDim2.fromOffset(120, 80)
	v9.BackgroundTransparency = 1
	v9.Parent = v6
	MagBody = Instance.new("Frame")
	MagBody.Name = "MagBody"
	MagBody.AnchorPoint = Vector2.new(0, 0.5)
	MagBody.Position = UDim2.new(0, 0, 0.5, 0)
	MagBody.Size = UDim2.fromOffset(34, 72)
	MagBody.BackgroundColor3 = v2
	MagBody.BackgroundTransparency = 0.2
	MagBody.BorderSizePixel = 0
	MagBody.Parent = v9
	v12 = Instance.new("UICorner")
	v12.CornerRadius = UDim.new(0, 5)
	v12.Parent = MagBody
	v22 = Instance.new("UIStroke")
	v22.Color = v5
	v22.Thickness = 1
	v22.Transparency = 0.3
	v22.Parent = MagBody
	Track = Instance.new("Frame")
	Track.Name = "Track"
	Track.AnchorPoint = Vector2.new(0.5, 0.5)
	Track.Position = UDim2.new(0.5, 0, 0.5, 0)
	Track.Size = UDim2.new(1, -8, 1, -8)
	Track.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Track.BackgroundTransparency = 0.55
	Track.BorderSizePixel = 0
	Track.ClipsDescendants = true
	Track.Parent = MagBody
	v32 = Instance.new("UICorner")
	v32.CornerRadius = UDim.new(0, 3)
	v32.Parent = Track
	v7 = Instance.new("Frame")
	v7.Name = "Fill"
	v7.AnchorPoint = Vector2.new(0.5, 1)
	v7.Position = UDim2.new(0.5, 0, 1, 0)
	v7.Size = UDim2.new(1, 0, 1, 0)
	v7.BackgroundColor3 = v3
	v7.BorderSizePixel = 0
	v7.Parent = Track
	v4 = Instance.new("UICorner")
	v4.CornerRadius = UDim.new(0, 3)
	v4.Parent = v7
	v8 = Instance.new("TextLabel")
	v8.Name = "Spare"
	v8.AnchorPoint = Vector2.new(0, 0.5)
	v8.Position = UDim2.new(0, 44, 0.5, 0)
	v8.Size = UDim2.fromOffset(80, 24)
	v8.BackgroundTransparency = 1
	v8.FontFace = v1
	v8.TextSize = 18
	v8.TextColor3 = v3
	v8.TextXAlignment = Enum.TextXAlignment.Left
	v8.Text = "x0"
	v8.Parent = v9
end

local function setFill(p1) --[[ setFill | Line: 108 | Upvalues: v7 (ref), v4 (copy), v3 (copy) ]]
	local v1 = math.clamp(p1, 0, 1)

	v7.Size = UDim2.new(1, 0, v1, 0)
	v7.BackgroundColor3 = v1 <= 0.25 and v4 or v3
end

local function updateMag() --[[ updateMag | Line: 114 | Upvalues: v11 (ref), v13 (ref), ItemDatabase (copy), v7 (ref), v4 (copy), v3 (copy) ]]
	if not v11 then
		return
	end

	local v1 = v11.Value
	local MaxValue = v11.MaxValue

	if MaxValue <= 0 then
		local v2 = v13 and ItemDatabase.GetItemData(v13)

		MaxValue = v2 and v2.maxRounds or math.max(v1, 1)
	end

	local v42 = math.clamp(v1 / MaxValue, 0, 1)

	v7.Size = UDim2.new(1, 0, v42, 0)
	v7.BackgroundColor3 = v42 <= 0.25 and v4 or v3
end

local function countSpareMags(p1) --[[ countSpareMags | Line: 125 | Upvalues: Remotes (copy), InventoryWire (copy), ItemDatabase (copy) ]]
	local ok, result = pcall(function() --[[ Line: 126 | Upvalues: Remotes (ref) ]]
		return Remotes.GetAllInventories:InvokeServer()
	end)

	if not ok or type(result) ~= "table" then
		return 0
	end

	local count = 0

	for k, v in pairs(result) do
		if type(v) == "table" and v.Items then
			for v1, v2 in InventoryWire.Each(v.Items) do
				if v2 and ItemDatabase.MagFits(p1, v2.ID) then
					count = count + 1
				end
			end
		end
	end

	return count
end

local function updateSpare() --[[ updateSpare | Line: 146 | Upvalues: v10 (ref), v14 (ref), LocalPlayer (copy), v15 (ref), v8 (ref), v13 (ref), countSpareMags (copy) ]]
	if not v10 then
		return
	end

	if v14 then
		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChild("AmmoPool") else Character
		local v2 = if v1 then v15 and v1:FindFirstChild(v15) else v1

		v8.Text = (v2 and tostring(v2.Value) or "0") .. " rds"
	elseif v13 then
		v8.Text = "x" .. countSpareMags(v13)
	else
		v8.Text = ""
	end
end

local function unbind() --[[ unbind | Line: 160 | Upvalues: v12 (ref), v10 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref), v6 (ref) ]]
	if v12 then
		v12:Disconnect()
		v12 = nil
	end

	v10 = nil
	v11 = nil
	v13 = nil
	v14 = nil
	v15 = nil

	if not v6 then
		return
	end

	v6.Enabled = false
end

local function bind(p1) --[[ bind | Line: 166 | Upvalues: v10 (ref), v12 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref), v6 (ref), t (copy), ItemDatabase (copy), ensureGui (copy), updateMag (copy), v7 (ref), v4 (copy), v3 (copy), updateSpare (copy) ]]
	if v10 == p1 then
		return
	end

	if v12 then
		v12:Disconnect()
		v12 = nil
	end

	v10 = nil
	v11 = nil
	v13 = nil
	v14 = nil
	v15 = nil

	if v6 then
		v6.Enabled = false
	end

	if not (p1 and p1:FindFirstChild("SPH_Weapon")) then
		return
	end

	local v1 = t[p1.Name]
	local v2 = if v1 then ItemDatabase.GetItemData(v1) else v1

	v13 = v2 and v2.MagType or nil

	local v42 = nil
	local WeaponStats = p1.SPH_Weapon:FindFirstChild("WeaponStats")

	if WeaponStats then
		local ok, result = pcall(require, WeaponStats)

		if ok then
			v42 = result
		end
	end

	local v5 = if v42 then v42.magType else v42

	v14 = if v5 == 2 or v5 == 3 then true else v13 == nil
	v15 = v42 and v42.ammoType or (if v2 then v2.ammoType else v2)

	local Ammo = p1:WaitForChild("Ammo", 3)

	v11 = if Ammo then Ammo:WaitForChild("MagAmmo", 3) else Ammo

	if v11 then
		v10 = p1
		ensureGui()
		v6.Enabled = true
		v12 = v11.Changed:Connect(updateMag)

		if not v11 then
			updateSpare()

			return
		end

		local v9 = v11.Value
		local MaxValue = v11.MaxValue

		if MaxValue <= 0 then
			local v102 = v13 and ItemDatabase.GetItemData(v13)

			MaxValue = v102 and v102.maxRounds or math.max(v9, 1)
		end

		local v122 = math.clamp(v9 / MaxValue, 0, 1)

		v7.Size = UDim2.new(1, 0, v122, 0)
		v7.BackgroundColor3 = v122 <= 0.25 and v4 or v3
		updateSpare()
	else
		if v12 then
			v12:Disconnect()
			v12 = nil
		end

		v10 = nil
		v11 = nil
		v13 = nil
		v14 = nil
		v15 = nil

		if not v6 then
			return
		end

		v6.Enabled = false
	end
end

local function currentSphTool(p1) --[[ currentSphTool | Line: 197 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("SPH_Weapon") then
			return v
		end
	end

	return nil
end

local function hookCharacter(p1) --[[ hookCharacter | Line: 204 | Upvalues: currentSphTool (copy), bind (copy), v10 (ref), v12 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref), v6 (ref) ]]
	local v1 = currentSphTool(p1)

	if not v1 then
		p1.ChildAdded:Connect(function(p13) --[[ Line: 207 | Upvalues: bind (ref) ]]
			if not (p13:IsA("Tool") and p13:FindFirstChild("SPH_Weapon")) then
				return
			end

			task.defer(function() --[[ Line: 209 | Upvalues: bind (ref), p13 (copy) ]]
				bind(p13)
			end)
		end)
		p1.ChildRemoved:Connect(function(p13) --[[ Line: 212 | Upvalues: v10 (ref), v12 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref), v6 (ref) ]]
			if p13 ~= v10 then
				return
			end

			if v12 then
				v12:Disconnect()
				v12 = nil
			end

			v10 = nil
			v11 = nil
			v13 = nil
			v14 = nil
			v15 = nil

			if not v6 then
				return
			end

			v6.Enabled = false
		end)

		return
	end

	bind(v1)
	p1.ChildAdded:Connect(function(p13) --[[ Line: 207 | Upvalues: bind (ref) ]]
		if not (p13:IsA("Tool") and p13:FindFirstChild("SPH_Weapon")) then
			return
		end

		task.defer(function() --[[ Line: 209 | Upvalues: bind (ref), p13 (copy) ]]
			bind(p13)
		end)
	end)
	p1.ChildRemoved:Connect(function(p13) --[[ Line: 212 | Upvalues: v10 (ref), v12 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref), v6 (ref) ]]
		if p13 ~= v10 then
			return
		end

		if v12 then
			v12:Disconnect()
			v12 = nil
		end

		v10 = nil
		v11 = nil
		v13 = nil
		v14 = nil
		v15 = nil

		if not v6 then
			return
		end

		v6.Enabled = false
	end)
end

function t2.Init(p1) --[[ Init | Line: 217 | Upvalues: ensureGui (copy), LocalPlayer (copy), hookCharacter (copy), v12 (ref), v10 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref), v6 (ref), Remotes (copy), updateSpare (copy) ]]
	if p1._started then
		return
	end

	p1._started = true
	ensureGui()

	if not LocalPlayer.Character then
		LocalPlayer.CharacterAdded:Connect(function(p13) --[[ Line: 222 | Upvalues: v12 (ref), v10 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref), v6 (ref), hookCharacter (ref) ]]
			if v12 then
				v12:Disconnect()
				v12 = nil
			end

			v10 = nil
			v11 = nil
			v13 = nil
			v14 = nil
			v15 = nil

			if v6 then
				v6.Enabled = false
			end

			hookCharacter(p13)
		end)
		Remotes.RefreshInventory.OnClientEvent:Connect(function() --[[ Line: 226 | Upvalues: v10 (ref), updateSpare (ref) ]]
			if not v10 then
				return
			end

			updateSpare()
		end)

		return
	end

	hookCharacter(LocalPlayer.Character)
	LocalPlayer.CharacterAdded:Connect(function(p13) --[[ Line: 222 | Upvalues: v12 (ref), v10 (ref), v11 (ref), v13 (ref), v14 (ref), v15 (ref), v6 (ref), hookCharacter (ref) ]]
		if v12 then
			v12:Disconnect()
			v12 = nil
		end

		v10 = nil
		v11 = nil
		v13 = nil
		v14 = nil
		v15 = nil

		if v6 then
			v6.Enabled = false
		end

		hookCharacter(p13)
	end)
	Remotes.RefreshInventory.OnClientEvent:Connect(function() --[[ Line: 226 | Upvalues: v10 (ref), updateSpare (ref) ]]
		if not v10 then
			return
		end

		updateSpare()
	end)
end

return t2