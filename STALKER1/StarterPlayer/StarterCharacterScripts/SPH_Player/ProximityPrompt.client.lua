-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
for i, v in ipairs(script:GetChildren()) do
	if v:IsA("BillboardGui") then
		v.Enabled = false
	end
end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local GameConfig = require(game:GetService("ReplicatedStorage").SPH_Assets.GameConfig)
local LocalPlayer = game:GetService("Players").LocalPlayer
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local CanView = script.CanView
local PickUpUI = LocalPlayer.PlayerGui:WaitForChild("SPH_UI").PickUpUI

local function ShowPrompt(p1) --[[ ShowPrompt | Line: 26 | Upvalues: CanView (copy), v1 (ref), TweenService (copy) ]]
	if not (CanView.Value and (v1 and v1.Humanoid.Health > 0)) then
		return
	end

	local PromptUI = p1.PromptUI
	local Input = PromptUI.Main.Input
	local Frame = PromptUI.Main.Input.Key.Frame

	PromptUI.Enabled = true
	Frame.BackgroundTransparency = 0
	PromptUI.Main.Size = UDim2.fromScale(0, 0)
	PromptUI.Main.White.BackgroundTransparency = 0
	PromptUI.Main.Input.Frame.Visible = false
	PromptUI.Main.Input.Key.Visible = false

	for i, v in ipairs(Input:GetChildren()) do
		if v:IsA("TextLabel") then
			v.Visible = false
		end
	end

	TweenService:Create(PromptUI.Main, TweenInfo.new(0.2), {
		Size = UDim2.fromScale(1, 0.05)
	}):Play()
	task.wait(0.25)
	TweenService:Create(PromptUI.Main, TweenInfo.new(0.2), {
		Size = UDim2.fromScale(1, 1)
	}):Play()
	TweenService:Create(PromptUI.Main.White, TweenInfo.new(0.2), {
		BackgroundTransparency = 1
	}):Play()
	PromptUI.Main.Input.Frame.Visible = true
	PromptUI.Main.Input.Key.Visible = true

	for i, v in ipairs(Input:GetChildren()) do
		if v:IsA("TextLabel") then
			v.Visible = true
		end
	end
end

local function HidePrompt(p1) --[[ HidePrompt | Line: 66 | Upvalues: TweenService (copy) ]]
	local PromptUI = p1.PromptUI

	PromptUI.Main.Input.Key.Frame.BackgroundTransparency = 1
	TweenService:Create(PromptUI.Main, TweenInfo.new(0.2), {
		Size = UDim2.fromScale(1, 0.05)
	}):Play()
	TweenService:Create(PromptUI.Main.White, TweenInfo.new(0.2), {
		BackgroundTransparency = 0
	}):Play()
	PromptUI.Main.Input.Frame.Visible = false
	PromptUI.Main.Input.Key.Visible = false

	for i, v in ipairs(PromptUI.Main.Input:GetChildren()) do
		if v:IsA("TextLabel") then
			v.Visible = false
		end
	end

	task.wait(0.25)
	TweenService:Create(PromptUI.Main, TweenInfo.new(0.2), {
		Size = UDim2.fromScale(0, 0.05)
	}):Play()
	task.wait(0.2)
	PromptUI.Enabled = false
end

local function SetupPrompt(p1) --[[ SetupPrompt | Line: 95 | Upvalues: UserInputService (copy), TweenService (copy) ]]
	local v1 = p1:FindFirstChildWhichIsA("ProximityPrompt")
	local SPH_PromptConfig = v1.SPH_PromptConfig
	local PromptUI = script[SPH_PromptConfig.ProxType.Value]:Clone()

	PromptUI.Name = "PromptUI"
	PromptUI.Parent = p1
	PromptUI.Enabled = false
	PromptUI.Main.HoldBar.Visible = v1.HoldDuration > 0
	PromptUI.Main.HoldBar.Bar.Size = UDim2.fromScale(0, 1)

	local Input = PromptUI.Main.Input

	Input.Key.KeyText.Text = UserInputService:GetStringForKeyCode(v1.KeyboardKeyCode)

	if SPH_PromptConfig:FindFirstChild("AmmoType") then
		Input.AmmoType.Text = SPH_PromptConfig.AmmoType.Value

		if SPH_PromptConfig.InfAmmo.Value then
			Input.AmmoPool.Text = "INF"
		else
			Input.AmmoPool.Text = SPH_PromptConfig.AmmoPool.Value .. " / " .. SPH_PromptConfig.AmmoPool.MaxValue
			SPH_PromptConfig.AmmoPool.Changed:Connect(function() --[[ Line: 114 | Upvalues: Input (copy), SPH_PromptConfig (copy) ]]
				Input.AmmoPool.Text = SPH_PromptConfig.AmmoPool.Value .. " / " .. SPH_PromptConfig.AmmoPool.MaxValue
			end)
		end
	elseif SPH_PromptConfig:FindFirstChild("GunPool") then
		Input.GunName.Text = v1:FindFirstChildWhichIsA("Tool").Name

		if SPH_PromptConfig.InfGuns.Value then
			Input.Remaining.Text = "INF"
		elseif SPH_PromptConfig.GunPool.MaxValue > 1 then
			Input.Remaining.Text = SPH_PromptConfig.GunPool.Value .. " / " .. SPH_PromptConfig.GunPool.MaxValue .. " REMAINING"
			SPH_PromptConfig.GunPool.Changed:Connect(function() --[[ Line: 125 | Upvalues: Input (copy), SPH_PromptConfig (copy) ]]
				Input.Remaining.Text = SPH_PromptConfig.GunPool.Value .. " / " .. SPH_PromptConfig.GunPool.MaxValue .. " REMAINING"
			end)
		else
			Input.Remaining.Text = ""
		end
	end

	local Frame = PromptUI.Main.Input.Key.Frame
	local v4 = TweenService:Create(Frame, TweenInfo.new(0.3), {
		BackgroundTransparency = 0.7,
		Size = UDim2.fromScale(1, 1)
	})
	local v5 = TweenService:Create(Frame, TweenInfo.new(0.1), {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(0, 0)
	})

	if v1.HoldDuration <= 0 then
		v1.Triggered:Connect(function() --[[ Line: 140 | Upvalues: Frame (copy) ]]
			Frame.Size = UDim2.fromScale(1, 1)
			Frame.BackgroundTransparency = 0.7
		end)
		v1.TriggerEnded:Connect(function() --[[ Line: 144 | Upvalues: v5 (copy) ]]
			v5:Play()
		end)
	else
		local Bar = PromptUI.Main.HoldBar.Bar
		local v6 = TweenService:Create(Bar, TweenInfo.new(v1.HoldDuration, Enum.EasingStyle.Linear), {
			Size = UDim2.fromScale(1, 1)
		})
		local v7 = TweenService:Create(Bar, TweenInfo.new(0.1), {
			Size = UDim2.fromScale(0, 1)
		})

		v1.PromptButtonHoldBegan:Connect(function() --[[ Line: 155 | Upvalues: v4 (copy), v7 (copy), Bar (copy), v6 (copy) ]]
			v4:Play()
			v7:Pause()
			Bar.Size = UDim2.fromScale(0, 1)
			v6:Play()
		end)
		v1.PromptButtonHoldEnded:Connect(function() --[[ Line: 164 | Upvalues: v5 (copy), Frame (copy), v6 (copy), v7 (copy) ]]
			v5:Play()
			Frame.Size = UDim2.fromScale(0, 0)
			v6:Pause()
			v7:Play()
		end)
	end
end

LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 175 | Upvalues: v1 (ref), PickUpUI (ref), LocalPlayer (copy), ProximityPromptService (copy) ]]
	local Humanoid = p1:WaitForChild("Humanoid")

	v1 = p1
	PickUpUI = LocalPlayer.PlayerGui:WaitForChild("SPH_UI").PickUpUI
	ProximityPromptService.Enabled = true
	Humanoid.Died:Connect(function() --[[ Line: 182 | Upvalues: ProximityPromptService (ref) ]]
		ProximityPromptService.Enabled = false
	end)
end)
ProximityPromptService.PromptShown:Connect(function(p1) --[[ Line: 187 | Upvalues: SetupPrompt (copy), ShowPrompt (copy), PickUpUI (ref), GameConfig (copy) ]]
	if p1:FindFirstChild("SPH_PromptConfig") then
		if not p1.Parent:FindFirstChild("PromptUI") then
			SetupPrompt(p1.Parent)
		end

		ShowPrompt(p1.Parent)
	else
		if not (PickUpUI:FindFirstChild("ItemName") and p1.Parent.Parent:FindFirstChild("PickupHighlight")) then
			return
		end

		p1.Parent.Parent.PickupHighlight.Enabled = true
		PickUpUI.Visible = true
		PickUpUI.ItemName.Text = "[" .. string.upper(GameConfig.pickupKey[1].Name) .. "] " .. p1.Parent.Parent.Name

		local v1 = p1.Parent.Parent:FindFirstChildWhichIsA("Tool")

		if not (v1 and v1:FindFirstChild("SPH_Weapon")) then
			return
		end

		local WeaponStats = require(v1.SPH_Weapon.WeaponStats)

		PickUpUI.ItemName.Text = PickUpUI.ItemName.Text .. " " .. WeaponStats.ammoType
	end
end)
ProximityPromptService.PromptHidden:Connect(function(p1) --[[ Line: 206 | Upvalues: SetupPrompt (copy), HidePrompt (copy), PickUpUI (ref) ]]
	if p1:FindFirstChild("SPH_PromptConfig") then
		if not p1.Parent:FindFirstChild("PromptUI") then
			SetupPrompt(p1.Parent)
		end

		HidePrompt(p1.Parent)
	else
		if p1.Parent and p1.Parent.Parent:FindFirstChild("PickupHighlight") then
			p1.Parent.Parent.PickupHighlight.Enabled = false
		end

		PickUpUI.Visible = false
	end
end)