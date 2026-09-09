-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local t = {}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = Color3.fromRGB(255, 200, 90)

function t.Enter(p1, p2) --[[ Enter | Line: 33 | Upvalues: v2 (ref), Players (copy), v1 (ref), v4 (copy), v3 (ref) ]]
	v2 = Players.LocalPlayer:GetMouse()
	v1 = Instance.new("Highlight")
	v1.Name = "CinematicHoverHighlight"
	v1.FillTransparency = 1
	v1.OutlineColor = v4
	v1.OutlineTransparency = 0.4
	v1.DepthMode = Enum.HighlightDepthMode.Occluded
	v1.Enabled = false

	local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

	v1.Parent = if PlayerGui then PlayerGui else Players.LocalPlayer
	v3 = nil
end
function t.Tick(p1, p2, p3) --[[ Tick | Line: 50 | Upvalues: v1 (ref), v3 (ref), v2 (ref), Players (copy) ]]
	if not v1 then
		return
	end

	if p2.hudHidden or not p2.overlays.hoverHighlight then
		if not v3 then
			return
		end

		v1.Adornee = nil
		v1.Enabled = false
		v3 = nil
	else
		local v12 = RaycastParams.new()

		v12.FilterType = Enum.RaycastFilterType.Exclude

		local t = {}
		local Character = Players.LocalPlayer.Character

		if Character then
			table.insert(t, Character)
		end

		if p2.lockTarget then
			table.insert(t, p2.lockTarget)
		end

		if p2.focus.target then
			table.insert(t, p2.focus.target)
		end

		v12.FilterDescendantsInstances = t

		local v22 = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, v2.UnitRay.Direction * 500, v12)
		local v32 = if v22 then v22.Instance else v22

		if v32 and not v32:IsA("BasePart") then
			v32 = nil
		end

		if v32 == v3 then
			return
		end

		v3 = v32

		if v32 then
			v1.Adornee = v32
			v1.Enabled = true

			return
		end

		v1.Adornee = nil
		v1.Enabled = false
	end
end
function t.Exit(p1) --[[ Exit | Line: 90 | Upvalues: v1 (ref), v3 (ref) ]]
	if v1 then
		v1:Destroy()
		v1 = nil
	end

	v3 = nil
end

return t