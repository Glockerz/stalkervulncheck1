-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Buttons = require(script:WaitForChild("Buttons"))
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

game:GetService("UserInputService")

local ProximityPromptService = game:GetService("ProximityPromptService")

game:GetService("TextService")

local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v1 = nil

local function getScreenGui() --[[ getScreenGui | Line: 22 | Upvalues: PlayerGui (copy) ]]
	local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")

	if ProximityPrompts == nil then
		local ProximityPrompts2 = Instance.new("ScreenGui")

		ProximityPrompts2.Name = "ProximityPrompts"
		ProximityPrompts2.ResetOnSpawn = false
		ProximityPrompts2.Parent = PlayerGui
		ProximityPrompts = ProximityPrompts2
	end

	return ProximityPrompts
end

local function DisconnectFunction(p1) --[[ DisconnectFunction | Line: 33 ]]
	if not p1 then
		return
	end

	p1:Disconnect()
end

local function Update_yScale(p1, p2, p3, p4, p5) --[[ Update_yScale | Line: 37 ]]
	if not (p3 and p4) and p5 then
		p5:Disconnect()
	end

	local v2 = (math.clamp(tick(), p1, p2) - p1) / p3.HoldDuration

	p4.Frame.ProgressBar.Size = UDim2.new(1, 0, v2, 0)

	if not (v2 >= 1) then
		return
	end

	p4.Frame.ProgressBar.Size = UDim2.new(1, 0, 0, 0)

	if not p5 then
		return
	end

	p5:Disconnect()
end

local function GetStringFromKey(p1) --[[ GetStringFromKey | Line: 52 | Upvalues: Buttons (copy) ]]
	for k, v in pairs(Buttons) do
		if v == p1 then
			return k
		end
	end
end

local function AnimatePromptIn(p1) --[[ AnimatePromptIn | Line: 60 | Upvalues: TweenService (copy) ]]
	orignalSize = p1.Frame.Size
	p1.Frame.Size = UDim2.new(0, 0, 0, 0)
	p1.Frame.BackgroundTransparency = 1
	TweenService:Create(p1.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0.25,
		Size = orignalSize
	}):Play()
end

local function AnimatePromptOut(p1) --[[ AnimatePromptOut | Line: 72 | Upvalues: TweenService (copy) ]]
	local v1 = TweenService:Create(p1.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 0, 0, 0)
	})

	v1:Play()
	v1.Completed:Wait()
end

local function CreatePrompt(p1, p2, p3) --[[ CreatePrompt | Line: 81 | Upvalues: Buttons (copy), AnimatePromptIn (copy), TweenService (copy), RunService (copy), Update_yScale (copy), AnimatePromptOut (copy) ]]
	local v1 = script:WaitForChild("Prompt"):Clone()

	v1.Enabled = true
	v1.Adornee = p1.Parent
	v1.Parent = p3

	local KeyboardKeyCode = p1.KeyboardKeyCode
	local v2 = nil

	for k, v in pairs(Buttons) do
		if v == KeyboardKeyCode then
			v2 = k

			break
		end
	end

	v1.Frame.ButtonText.Text = v2
	v1.Frame.ActionText.Text = p1.ActionText
	v1.Frame.ObjectText.Text = p1.ObjectText

	local UIOffset = p1.UIOffset

	if UIOffset.X ~= 0 or UIOffset.Y ~= 0 then
		v1.StudsOffset = v1.StudsOffset + Vector3.new(UIOffset.X / 50, -UIOffset.Y / 50, 0)
	end

	AnimatePromptIn(v1)

	local v5

	if p1:GetAttribute("Highlight_Enabled") == true then
		local v6 = p1:GetAttribute("Highlight_BackgroundColor")
		local v7 = p1:GetAttribute("Highlight_BorderColor")
		local v8 = p1:GetAttribute("Highlight_BackgroundTransparency")
		local v9 = p1:GetAttribute("Highlight_BorderTransparency")
		local Highlight = p1:FindFirstChild("Highlight")
		local Highlight2 = Instance.new("Highlight")

		Highlight2.Name = p1.Name
		Highlight2.FillColor = v6
		Highlight2.FillTransparency = v8
		Highlight2.OutlineColor = v7
		Highlight2.OutlineTransparency = v9
		v5 = Highlight2
		Highlight2.Adornee = Highlight and Highlight.Value or p1.Parent
		Highlight2.Parent = p1
		Highlight2.Enabled = true
	else
		v5 = nil
	end

	local v11 = p1.Triggered:Connect(function() --[[ Line: 120 | Upvalues: p1 (copy), TweenService (ref), v1 (copy) ]]
		if p1.HoldDuration ~= 0 then
			TweenService:Create(v1.Frame, TweenInfo.new(0.25), {
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
			}):Play()
		end
	end)
	local v12 = p1.PromptButtonHoldBegan:Connect(function() --[[ Line: 125 | Upvalues: p1 (copy), RunService (ref), Update_yScale (ref), v1 (copy), TweenService (ref) ]]
		local v12 = tick()
		local v2 = v12 + p1.HoldDuration
		local v3 = nil

		v3 = RunService.RenderStepped:Connect(function() --[[ Line: 130 | Upvalues: Update_yScale (ref), v12 (copy), v2 (copy), p1 (ref), v1 (ref), v3 (ref) ]]
			Update_yScale(v12, v2, p1, v1, v3)
		end)

		local v4 = nil

		v4 = p1.PromptButtonHoldEnded:Connect(function() --[[ Line: 135 | Upvalues: v3 (ref), v4 (ref), TweenService (ref), v1 (ref) ]]
			local v12 = v3

			if v12 then
				v12:Disconnect()
			end

			local v2 = v4

			if v2 then
				v2:Disconnect()
			end

			TweenService:Create(v1.Frame.ProgressBar, TweenInfo.new(0.25), {
				BackgroundTransparency = 1
			}):Play()
			task.wait(0.25)

			if not (v1 and v1:FindFirstChild("Frame")) then
				return
			end

			v1.Frame.ProgressBar.BackgroundTransparency = 0.5
			v1.Frame.ProgressBar.Size = UDim2.new(1, 0, 0, 0)
		end)
	end)
	local v13 = v1.TextButton.MouseButton1Down:Connect(function() --[[ Line: 149 | Upvalues: p1 (copy), RunService (ref), Update_yScale (ref), v1 (copy) ]]
		p1:InputHoldBegin()

		local v12 = tick()
		local v2 = v12 + p1.HoldDuration
		local v3 = nil

		v3 = RunService.RenderStepped:Connect(function() --[[ Line: 156 | Upvalues: Update_yScale (ref), v12 (copy), v2 (copy), p1 (ref), v1 (ref), v3 (ref) ]]
			Update_yScale(v12, v2, p1, v1, v3)
		end)

		local v4 = nil

		v4 = v1.TextButton.MouseButton1Up:Connect(function() --[[ Line: 161 | Upvalues: p1 (ref), v1 (ref), v3 (ref), v4 (ref) ]]
			p1:InputHoldEnd()
			v1.Frame.ProgressBar.Size = UDim2.new(1, 0, 0, 0)

			local v12 = v3

			if v12 then
				v12:Disconnect()
			end

			local v2 = v4

			if not v2 then
				return
			end

			v2:Disconnect()
		end)
	end)

	p1.PromptHidden:Wait()
	AnimatePromptOut(v1)
	v1:Destroy()

	if v5 then
		v5:Destroy()
	end

	if v11 then
		v11:Disconnect()
	end

	if v12 then
		v12:Disconnect()
	end

	if not v13 then
		return
	end

	v13:Disconnect()
end

local function onSit(p1) --[[ onSit | Line: 180 | Upvalues: ProximityPromptService (copy) ]]
	ProximityPromptService.Enabled = not p1
end

local function onLoad() --[[ onLoad | Line: 184 | Upvalues: ProximityPromptService (copy), v1 (ref), LocalPlayer (copy), onSit (copy), PlayerGui (copy), CreatePrompt (copy) ]]
	ProximityPromptService.PromptShown:Connect(function(p1, p2) --[[ Line: 185 | Upvalues: v1 (ref), LocalPlayer (ref), onSit (ref), PlayerGui (ref), CreatePrompt (ref) ]]
		if p1.Style == Enum.ProximityPromptStyle.Default or p1:FindFirstChild("SPH_PromptConfig") then
			return
		end

		if not v1 and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")) then
			v1 = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Seated:Connect(onSit)
		end

		local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")

		if ProximityPrompts == nil then
			local ProximityPrompts2 = Instance.new("ScreenGui")

			ProximityPrompts2.Name = "ProximityPrompts"
			ProximityPrompts2.ResetOnSpawn = false
			ProximityPrompts2.Parent = PlayerGui
			ProximityPrompts = ProximityPrompts2
		end

		CreatePrompt(p1, p2, ProximityPrompts)
	end)
	task.wait(5)

	if v1 or not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")) then
		return
	end

	v1 = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Seated:Connect(onSit)
end

LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 201 | Upvalues: LocalPlayer (copy), v1 (ref), onSit (copy), ProximityPromptService (copy) ]]
	local v12 = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")

	if not v12 then
		warn("CustomPrompt - No Humanoid Found for " .. LocalPlayer.Name .. "\'s character!")

		return
	end

	v1 = v12.Seated:Connect(onSit)
	ProximityPromptService.Enabled = true
	task.wait(10)

	if v1 or not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")) then
		return
	end

	v1 = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Seated:Connect(onSit)
end)
LocalPlayer.CharacterAppearanceLoaded:Connect(function() --[[ Line: 214 | Upvalues: v1 (ref), LocalPlayer (copy), onSit (copy) ]]
	if v1 or not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")) then
		return
	end

	v1 = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Seated:Connect(onSit)
end)
onLoad()