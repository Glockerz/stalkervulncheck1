-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CinematicCameraConfig = require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"))
local t = {}
local v1 = Vector2.new()
local v2 = 0
local v3 = false
local v4 = false
local v5 = false
local v6 = false
local v7 = CinematicCameraConfig.Mouse and CinematicCameraConfig.Mouse.Sensitivity or 0.0025
local t2 = { "off", "16:9", "2.35:1", "2.39:1" }
local t3 = { "Raw", "Smoothed", "Handheld" }

local function cycle(p1, p2) --[[ cycle | Line: 41 ]]
	for i, v in ipairs(p1) do
		if v == p2 then
			return p1[i % #p1 + 1]
		end
	end

	return p1[1]
end

local v8 = nil
local v9 = nil
local t4 = {}

function t.Enter(p1, p2) --[[ Enter | Line: 52 | Upvalues: v8 (ref), UserInputService (copy), v9 (ref), v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), t4 (ref), v7 (copy), CinematicCameraConfig (copy), t3 (copy), t2 (copy) ]]
	v8 = UserInputService.MouseBehavior
	v9 = UserInputService.MouseIconEnabled
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	UserInputService.MouseIconEnabled = false
	v1 = Vector2.new()
	v2 = 0
	v3 = false
	v4 = false
	v5 = false
	v6 = false

	local InputChanged = UserInputService.InputChanged

	local function f2(p1) --[[ Line: 64 | Upvalues: p2 (copy), v7 (ref), v1 (ref), v2 (ref) ]]
		if p1.UserInputType == Enum.UserInputType.MouseMovement then
			if not p2.cursorFree then
				local v12 = v7 * (p2.mouseSensitivityMult or 1)

				v1 = v1 + Vector2.new(-p1.Delta.X * v12, -p1.Delta.Y * v12)
			end
		else
			if p1.UserInputType ~= Enum.UserInputType.MouseWheel then
				return
			end

			v2 = v2 + (if p1.Position.Z > 0 then 1 else -1)
		end
	end

	table.insert(t4, InputChanged:Connect(f2))

	local InputBegan = UserInputService.InputBegan

	local function f4(p1, p22) --[[ Line: 77 | Upvalues: v3 (ref), v4 (ref), UserInputService (ref), v5 (ref), CinematicCameraConfig (ref), p2 (copy), t3 (ref), t2 (ref), v6 (ref) ]]
		if p22 then
			return
		end

		if p1.UserInputType == Enum.UserInputType.MouseButton1 then
			v3 = true
			v4 = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
		else
			if p1.UserInputType == Enum.UserInputType.MouseButton2 then
				v5 = true

				return
			end

			if p1.KeyCode == CinematicCameraConfig.Keys.CycleMotion then
				local v32 = t3
				local mode = p2.mode
				local v42

				do
					local __inline_returned = false

					for i, v in ipairs(v32) do
						if v == mode then
							v42 = v32[i % #v32 + 1]
							__inline_returned = true

							break
						end
					end

					if not __inline_returned then
						v42 = v32[1]
					end
				end

				p2.mode = v42
			else
				if p1.KeyCode == CinematicCameraConfig.Keys.Overlays.Grid then
					p2.overlays.thirds = not p2.overlays.thirds

					return
				end

				if p1.KeyCode == CinematicCameraConfig.Keys.Overlays.Letterbox then
					local v52 = t2
					local letterbox = p2.overlays.letterbox
					local v62

					do
						local __inline_returned = false

						for i, v in ipairs(v52) do
							if v == letterbox then
								v62 = v52[i % #v52 + 1]
								__inline_returned = true

								break
							end
						end

						if not __inline_returned then
							v62 = v52[1]
						end
					end

					p2.overlays.letterbox = v62
				else
					if p1.KeyCode == CinematicCameraConfig.Keys.Overlays.Level then
						p2.overlays.level = not p2.overlays.level

						return
					end

					if p1.KeyCode == CinematicCameraConfig.Keys.Overlays.Info then
						p2.overlays.info = not p2.overlays.info

						return
					end

					if p1.KeyCode == CinematicCameraConfig.Keys.Overlays.FocusRect then
						p2.overlays.focusRect = not p2.overlays.focusRect

						return
					end

					if p1.KeyCode == CinematicCameraConfig.Keys.Overlays.LightingPanel then
						p2.overlays.lightingPanel = not p2.overlays.lightingPanel

						return
					end

					if p1.KeyCode == CinematicCameraConfig.Keys.Overlays.ControlPanel then
						p2.overlays.controlPanel = not p2.overlays.controlPanel

						return
					end

					if p1.KeyCode == CinematicCameraConfig.Keys.Overlays.HoverHighlight then
						p2.overlays.hoverHighlight = not p2.overlays.hoverHighlight

						return
					end

					if p1.KeyCode == CinematicCameraConfig.Keys.HideUI then
						p2.hudHidden = not p2.hudHidden

						return
					end

					if p1.KeyCode == CinematicCameraConfig.Keys.CursorFree then
						p2.cursorFree = not p2.cursorFree

						return
					end

					if p1.KeyCode == CinematicCameraConfig.Keys.FovDown then
						p2.fov = math.clamp(p2.fov - 5, CinematicCameraConfig.Camera.MinFOV, CinematicCameraConfig.Camera.MaxFOV)

						return
					end

					if p1.KeyCode == CinematicCameraConfig.Keys.FovUp then
						p2.fov = math.clamp(p2.fov + 5, CinematicCameraConfig.Camera.MinFOV, CinematicCameraConfig.Camera.MaxFOV)

						return
					end

					if p1.KeyCode ~= CinematicCameraConfig.Keys.Reset then
						return
					end

					v6 = true
				end
			end
		end
	end

	table.insert(t4, InputBegan:Connect(f4))
end
function t.Tick(p1, p2, p3) --[[ Tick | Line: 121 | Upvalues: UserInputService (copy), v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), CinematicCameraConfig (copy) ]]
	if p2.cursorFree then
		if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end

		if UserInputService.MouseIconEnabled ~= true then
			UserInputService.MouseIconEnabled = true
		end
	else
		if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		end

		if UserInputService.MouseIconEnabled ~= false then
			UserInputService.MouseIconEnabled = false
		end
	end

	local actions = p2.actions
	local count = 0
	local count2 = 0
	local count3 = 0

	if UserInputService:IsKeyDown(Enum.KeyCode.W) then
		count3 = count3 + 1
	end

	if UserInputService:IsKeyDown(Enum.KeyCode.S) then
		count3 = count3 - 1
	end

	if UserInputService:IsKeyDown(Enum.KeyCode.A) then
		count = count - 1
	end

	if UserInputService:IsKeyDown(Enum.KeyCode.D) then
		count = count + 1
	end

	if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
		count2 = count2 - 1
	end

	if UserInputService:IsKeyDown(Enum.KeyCode.E) then
		count2 = count2 + 1
	end

	actions.move = Vector3.new(count, count2, count3)
	actions.look = v1
	v1 = Vector2.new()
	actions.scroll = v2
	v2 = 0
	actions.boost = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
	actions.precise = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
	actions.focusPickThisFrame = v3
	v3 = false
	actions.focusPickShiftHeld = v4

	if actions.focusPickThisFrame == false then
		v4 = false
	end

	actions.breakFocusThisFrame = v5
	v5 = false
	actions.resetRequested = actions.resetRequested or v6
	v6 = false

	if actions.scroll == 0 then
		return
	end

	local FovFineModifier = CinematicCameraConfig.Keys.FovFineModifier

	if if FovFineModifier then UserInputService:IsKeyDown(FovFineModifier) or (if FovFineModifier == Enum.KeyCode.LeftAlt then UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) else false) else FovFineModifier then
		p2.fov = math.clamp(p2.fov + actions.scroll, CinematicCameraConfig.Camera.MinFOV, CinematicCameraConfig.Camera.MaxFOV)
		actions.scroll = 0

		return
	end

	if p2.focus.locked then
		return
	end

	p2.speed = math.clamp(p2.speed * (1 + actions.scroll * CinematicCameraConfig.Speed.ScrollStep), 2, 400)
end
function t.Exit(p1) --[[ Exit | Line: 190 | Upvalues: t4 (ref), v8 (ref), UserInputService (copy), v9 (ref) ]]
	for i, v in ipairs(t4) do
		v:Disconnect()
	end

	t4 = {}

	if v8 then
		UserInputService.MouseBehavior = v8
	end

	if v9 == nil then
		return
	end

	UserInputService.MouseIconEnabled = v9
end

return t