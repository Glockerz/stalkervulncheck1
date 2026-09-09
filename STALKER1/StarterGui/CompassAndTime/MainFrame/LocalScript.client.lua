-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local v1 = script.Parent
local Position = v1.Position
local v2 = Position
local t = {
	Goal = 0,
	Tween = nil,
	Value = Instance.new("NumberValue")
}
local t2 = {
	Goal = 0,
	Tween = nil,
	Value = Instance.new("NumberValue")
}

RunService.RenderStepped:Connect(function(p1) --[[ Line: 11 | Upvalues: UserInputService (copy), t (copy), TweenService (copy), t2 (copy), v2 (ref), v1 (copy), Position (copy) ]]
	local v12 = UserInputService:GetMouseDelta() * 0.5

	if t.Goal ~= v12.X then
		if t.Tween then
			t.Tween:Pause()
		end

		t.Goal = v12.X
		t.Tween = TweenService:Create(t.Value, TweenInfo.new(0.2), {
			Value = v12.X
		})
		t.Tween:Play()
	end

	if t2.Goal ~= v12.Y then
		if t2.Tween then
			t2.Tween:Pause()
		end

		t2.Goal = v12.Y
		t2.Tween = TweenService:Create(t2.Value, TweenInfo.new(0.2), {
			Value = v12.Y
		})
		t2.Tween:Play()
	end

	v2 = UDim2.fromOffset(t.Value.Value, t2.Value.Value)
	v1.Position = Position + v2
end)