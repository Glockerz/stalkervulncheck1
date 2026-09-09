-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")

return {
	CreateBubble = function(p1, p2, p3, p4, p5) --[[ CreateBubble | Line: 9 | Upvalues: TweenService (copy) ]]
		local v1 = game.ReplicatedStorage.BubbleModule.Mesh:Clone()

		v1.CFrame = p1
		v1.Anchored = true
		v1.CanCollide = false
		v1.Massless = true
		v1.Parent = workspace:FindFirstChild("Effects") or workspace
		v1.Material = Enum.Material.Glass
		v1.Size = p2
		v1.Transparency = p3

		local Highlight = Instance.new("Highlight")

		Highlight.Enabled = false
		Highlight.Parent = v1
		game.Debris:addItem(v1, p5)
		TweenService:Create(v1, TweenInfo.new(p5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
			Transparency = 1,
			Size = p4
		}):Play()
	end
}