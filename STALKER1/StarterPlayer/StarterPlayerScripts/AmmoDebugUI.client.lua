-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local AmmoDebugUI = Instance.new("ScreenGui")

AmmoDebugUI.Name = "AmmoDebugUI"
AmmoDebugUI.ResetOnSpawn = false
AmmoDebugUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

local AmmoDebug = Instance.new("TextLabel")

AmmoDebug.Name = "AmmoDebug"
AmmoDebug.Size = UDim2.new(0, 350, 0, 200)
AmmoDebug.Position = UDim2.new(1, -360, 0, 10)
AmmoDebug.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AmmoDebug.BackgroundTransparency = 0.4
AmmoDebug.TextColor3 = Color3.fromRGB(255, 255, 255)
AmmoDebug.Font = Enum.Font.RobotoMono
AmmoDebug.TextSize = 12
AmmoDebug.TextXAlignment = Enum.TextXAlignment.Left
AmmoDebug.TextYAlignment = Enum.TextYAlignment.Top
AmmoDebug.TextWrapped = true
AmmoDebug.Parent = AmmoDebugUI

local UICorner = Instance.new("UICorner")

UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = AmmoDebug

local UIPadding = Instance.new("UIPadding")

UIPadding.PaddingLeft = UDim.new(0, 6)
UIPadding.PaddingTop = UDim.new(0, 4)
UIPadding.Parent = AmmoDebug
RunService.Heartbeat:Connect(function() --[[ Line: 33 | Upvalues: LocalPlayer (copy), AmmoDebug (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		AmmoDebug.Text = "No character"

		return
	end

	local v1 = nil

	for i, v in ipairs(Character:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("SPH_Weapon") then
			v1 = v

			break
		end
	end

	if not v1 then
		for i, v in ipairs(LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") and v:FindFirstChild("SPH_Weapon") then
				v1 = v

				break
			end
		end
	end

	if not v1 then
		AmmoDebug.Text = "No weapon"

		return
	end

	local t = { "[" .. v1.Name .. "]" }
	local Ammo = v1:FindFirstChild("Ammo")
	local v2 = if Ammo then Ammo:FindFirstChild("MagAmmo") else Ammo

	table.insert(t, "MagAmmo: " .. (v2 and tostring(v2.Value) or "nil"))

	local Chambered = v1:FindFirstChild("Chambered")

	table.insert(t, "Chambered: " .. (Chambered and tostring(Chambered.Value) or "nil"))
	table.insert(t, "MagUnloaded: " .. tostring(v1:GetAttribute("MagUnloaded") or false))

	local v11 = v1:GetAttribute("LoadedRounds")

	if v11 then
		local HttpService = game:GetService("HttpService")
		local ok, result = pcall(function() --[[ Line: 76 | Upvalues: HttpService (copy), v11 (copy) ]]
			return HttpService:JSONDecode(v11)
		end)

		if ok and result then
			table.insert(t, "LoadedRounds: " .. #result .. " total")

			local t2 = {}
			local list = {}

			for i, v in ipairs(result) do
				if not t2[v] then
					t2[v] = 0
					table.insert(list, v)
				end

				t2[v] = t2[v] + 1
			end

			for i, v in ipairs(list) do
				table.insert(t, "  " .. t2[v] .. "x " .. (v:match("_(.+)$") or v))
			end

			table.insert(t, "")
			table.insert(t, "Next to fire:")

			for i = #result, math.max(1, #result - 2), -1 do
				table.insert(t, "  > " .. (result[i]:match("_(.+)$") or result[i]))
			end
		else
			table.insert(t, "LoadedRounds: (parse error)")
		end
	else
		table.insert(t, "LoadedRounds: nil (legacy)")
	end

	AmmoDebug.Text = table.concat(t, "\n")
end)