-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local v1 = Color3.fromRGB(220, 170, 55)
local v2 = Color3.fromRGB(245, 240, 230)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local LocationChanged = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LocationChanged")
local SoundService = game:GetService("SoundService")

local function playDiscoverySound() --[[ playDiscoverySound | Line: 29 | Upvalues: SoundService (copy) ]]
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://97573804165364"
	Sound.Volume = 0.5
	Sound.Parent = SoundService
	Sound:Play()
	Sound.Ended:Connect(function() --[[ Line: 35 | Upvalues: Sound (copy) ]]
		Sound:Destroy()
	end)
	task.delay(5, function() --[[ Line: 36 | Upvalues: Sound (copy) ]]
		if not Sound.Parent then
			return
		end

		Sound:Destroy()
	end)
end

local LocationHUD = Instance.new("ScreenGui")

LocationHUD.Name = "LocationHUD"
LocationHUD.ResetOnSpawn = false
LocationHUD.DisplayOrder = 50
LocationHUD.IgnoreGuiInset = true
LocationHUD.Parent = PlayerGui

local Frame = Instance.new("Frame")

Frame.AnchorPoint = Vector2.new(0.5, 0)
Frame.Position = UDim2.new(0.5, 0, 0, 130)
Frame.Size = UDim2.fromOffset(440, 78)
Frame.BackgroundTransparency = 1
Frame.Parent = LocationHUD

local Sub = Instance.new("TextLabel")

Sub.Name = "Sub"
Sub.Size = UDim2.new(1, 0, 0, 24)
Sub.Position = UDim2.new(0, 0, 0, 0)
Sub.BackgroundTransparency = 1
Sub.Text = "N O W   E N T E R I N G"
Sub.TextColor3 = v1
Sub.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
Sub.TextSize = 20
Sub.TextTransparency = 1
Sub.Parent = Frame

local Name = Instance.new("TextLabel")

Name.Name = "Name"
Name.Size = UDim2.new(1, 0, 0, 38)
Name.Position = UDim2.new(0, 0, 0, 30)
Name.BackgroundTransparency = 1
Name.Text = ""
Name.TextColor3 = v2
Name.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
Name.TextSize = 30
Name.TextTransparency = 1
Name.TextStrokeTransparency = 0.6
Name.TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255)
Name.Parent = Frame

local v3 = 0

local function fade(p1, p2, p3) --[[ fade | Line: 86 | Upvalues: TweenService (copy) ]]
	TweenService:Create(p1, TweenInfo.new(p3, Enum.EasingStyle.Sine), {
		TextTransparency = p2
	}):Play()
end

local function showLocation(p1) --[[ showLocation | Line: 90 | Upvalues: v3 (ref), playDiscoverySound (copy), Name (copy), fade (copy), Sub (copy) ]]
	v3 = v3 + 1
	playDiscoverySound()
	Name.Text = string.upper(p1)
	fade(Sub, 0, 0.4)
	fade(Name, 0, 0.4)
	task.wait(4)

	if v3 == v3 then
		fade(Sub, 1, 0.8)
		fade(Name, 1, 0.8)
	end
end

LocationChanged.OnClientEvent:Connect(function(p1) --[[ Line: 107 | Upvalues: showLocation (copy) ]]
	task.spawn(showLocation, p1)
end)