-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local v1 = LocalPlayer:GetMouse()
local ChargeBar = script:WaitForChild("ChargeBar")
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = false
local v6 = false

function t.Init() --[[ Init | Line: 21 | Upvalues: v2 (ref), ChargeBar (copy), v3 (ref), v4 (ref) ]]
	v2 = ChargeBar:Clone()
	v3 = v2:WaitForChild("Frame")
	v4 = v3:WaitForChild("Bar")
end
function t.StartTracking() --[[ StartTracking | Line: 28 | Upvalues: v2 (ref), LocalPlayer (copy), v5 (ref), RunService (copy), v3 (ref), v1 (copy), v4 (ref), v6 (ref) ]]
	v2.Parent = LocalPlayer.PlayerGui
	v5 = true
	v2.Enabled = true
	RunService:BindToRenderStep("ChargeBarFollow", Enum.RenderPriority.Input.Value, function() --[[ Line: 33 | Upvalues: v5 (ref), v3 (ref), v1 (ref), v4 (ref), v6 (ref), v2 (ref) ]]
		if not v5 then
			return
		end

		v3.Position = UDim2.new(0, v1.X, 0, v1.Y - 5)

		if not (v4.Size.X.Scale < 1 or v6) then
			v2.Enabled = false

			return
		end

		v3.BackgroundColor3 = v6 and Color3.fromRGB(255, 170, 0) or Color3.fromRGB(255, 255, 255)
	end)
end
function t.StopTracking() --[[ StopTracking | Line: 46 | Upvalues: v2 (ref), v5 (ref), RunService (copy) ]]
	v2.Parent = script
	v5 = false
	v2.Enabled = false
	RunService:UnbindFromRenderStep("ChargeBarFollow")
end
function t.Charge(p1) --[[ Charge | Line: 54 | Upvalues: v6 (ref), v4 (ref), v2 (ref), TweenService (copy) ]]
	if p1 or v6 then
		v6 = true
		v4.Size = UDim2.new(0, 0, 1, 0)
		v2.Enabled = true
		TweenService:Create(v4, TweenInfo.new(p1, Enum.EasingStyle.Linear), {
			Size = UDim2.new(1, 0, 1, 0)
		}):Play()
		task.delay(p1, function() --[[ Line: 64 | Upvalues: v6 (ref) ]]
			v6 = false
		end)
	end
end

return t