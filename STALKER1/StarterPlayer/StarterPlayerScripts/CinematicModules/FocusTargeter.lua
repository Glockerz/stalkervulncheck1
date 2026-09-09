-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CinematicCameraConfig = require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"))
local t = {}
local v1 = nil

function t.Enter(p1, p2) --[[ Enter | Line: 34 | Upvalues: v1 (ref), Players (copy), CinematicCameraConfig (copy) ]]
	v1 = Players.LocalPlayer:GetMouse()
	p2.focus.target = nil
	p2.focus.distance = CinematicCameraConfig.Focus.DefaultDistance
	p2.focus.distanceOffset = 0
	p2.focus.locked = false
	p2.lockTarget = nil
end
function t.Tick(p1, p2, p3) --[[ Tick | Line: 43 | Upvalues: v1 (ref), Players (copy), CinematicCameraConfig (copy) ]]
	local CurrentCamera = workspace.CurrentCamera
	local actions = p2.actions

	if actions.focusPickThisFrame then
		local v12 = RaycastParams.new()

		v12.FilterType = Enum.RaycastFilterType.Exclude

		local Character = Players.LocalPlayer.Character

		v12.FilterDescendantsInstances = if Character then { Character } or {} else {}

		local v3 = workspace:Raycast(CurrentCamera.CFrame.Position, v1.UnitRay.Direction * 500, v12)

		if v3 and (v3.Instance and v3.Instance:IsA("BasePart")) then
			if actions.focusPickShiftHeld then
				p2.focus.target = v3.Instance
				p2.focus.distance = v3.Distance
				p2.focus.distanceOffset = 0
				p2.focus.locked = true
			else
				p2.lockTarget = v3.Instance
			end
		end
	end

	if actions.breakFocusThisFrame then
		p2.focus.target = nil
		p2.focus.distance = CinematicCameraConfig.Focus.DefaultDistance
		p2.focus.distanceOffset = 0
		p2.focus.locked = false
		p2.lockTarget = nil
	end

	if p2.focus.locked then
		local target = p2.focus.target

		if target and target.Parent then
			p2.focus.distance = (CurrentCamera.CFrame.Position - target.Position).Magnitude

			if actions.scroll ~= 0 then
				local focus = p2.focus

				focus.distanceOffset = focus.distanceOffset + actions.scroll * CinematicCameraConfig.Focus.ScrollFineStep
			end
		else
			p2.focus.target = nil
			p2.focus.locked = false
			p2.focus.distanceOffset = 0
		end
	end

	if not p2.lockTarget or p2.lockTarget.Parent then
		return
	end

	p2.lockTarget = nil
end
function t.Exit(p1) --[[ Exit | Line: 98 ]] end

return t