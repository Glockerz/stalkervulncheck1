-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RespawnTime = game.Players.RespawnTime
local LocalPlayer = game.Players.LocalPlayer
local v1 = script.Parent
local v2 = script.Parent.Parent
local Blackout = script.Parent.Parent.Blackout
local TweenService = game:GetService("TweenService")
local v3 = false
local v4 = false

repeat
	task.wait()
until LocalPlayer.Character

LocalPlayer.Character:WaitForChild("Humanoid")
LocalPlayer.Character.Humanoid.Died:Connect(function() --[[ Line: 14 | Upvalues: v3 (ref), TweenService (copy), v2 (copy), v1 (copy) ]]
	v3 = true

	local v12 = TweenInfo.new(1, Enum.EasingStyle.Quint)

	TweenService:Create(v2, v12, {
		BackgroundTransparency = 0,
		Position = UDim2.fromScale(0, 0)
	}):Play()
	TweenService:Create(v1, v12, {
		TextTransparency = 0
	}):Play()
end)
game:GetService("RunService").RenderStepped:Connect(function(p1) --[[ Line: 21 | Upvalues: v3 (ref), RespawnTime (ref), v4 (ref), TweenService (copy), v1 (copy), Blackout (copy) ]]
	if not v3 then
		return
	end

	RespawnTime = RespawnTime - p1

	if RespawnTime < 1 and not v4 then
		v4 = true

		local v12 = TweenInfo.new(0.5)

		TweenService:Create(v1, v12, {
			TextTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.15)
		}):Play()
		TweenService:Create(Blackout, v12, {
			BackgroundTransparency = 0
		}):Play()
	end

	local v2

	if RespawnTime > 0.01 then
		local v42 = tostring(RespawnTime)

		if RespawnTime < 10 then
			v42 = "0" .. v42
		end

		local v5 = string.sub(v42, 1, 2) .. "."
		local v6 = if #v42 >= 4 then v5 .. string.sub(v42, 4, 4) else v5 .. "00"

		v2 = if #v42 >= 5 then v6 .. string.sub(v42, 5, 5) else v6 .. "0"
	else
		v2 = "00.00"
	end

	v1.Text = v2
end)