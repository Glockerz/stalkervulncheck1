-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RaycastHitboxV4 = require(game:GetService("ReplicatedStorage").RaycastHitboxV4)
local MeleeSystemReplicated = game:GetService("ReplicatedStorage"):WaitForChild("MeleeSystemReplicated")
local ShakeFunction = require(MeleeSystemReplicated.ShakeFunction)
local ChargeBar = require(MeleeSystemReplicated.ChargeBar)

return {
	Init = function(p1) --[[ Init | Line: 12 | Upvalues: ChargeBar (copy), ShakeFunction (copy), Players (copy), RaycastHitboxV4 (copy), MeleeSystemReplicated (copy), UserInputService (copy) ]]
		local MeleeConfig = require(p1:WaitForChild("MeleeConfig"))

		ChargeBar.Init()
		ShakeFunction.Init()

		local LocalPlayer = Players.LocalPlayer
		local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local F = Enum.KeyCode.F
		local V = Enum.KeyCode.V
		local v2 = nil
		local v3 = nil
		local Remotes = p1:WaitForChild("Remotes")

		Remotes:WaitForChild("Finish")
		Remotes:WaitForChild("Inspect")

		local RemoteEventMelee = Remotes:WaitForChild("RemoteEventMelee")
		local SwingStart = Remotes:WaitForChild("SwingStart")
		local SwingEnd = Remotes:WaitForChild("SwingEnd")
		local dualWield = MeleeConfig.dualWield
		local v4 = RaycastHitboxV4.new(p1)

		v4.DetectionMode = RaycastHitboxV4.DetectionMode.PartMode
		v4.Visualizer = true

		local v5 = nil
		local v6 = false
		local v7 = false
		local v8 = false
		local v9 = 0
		local Handle = p1.Handle
		local MotorGrip = p1:FindFirstChild("MotorGrip")
		local v10 = nil
		local v11 = p1:WaitForChild("SwingAnims"):GetChildren()
		local v12 = MeleeConfig.coolDown or 0

		local function connectHitbox(p1) --[[ connectHitbox | Line: 57 | Upvalues: v8 (ref), v1 (copy), Players (ref), LocalPlayer (copy), Handle (ref), v9 (ref), MeleeConfig (copy), RemoteEventMelee (copy) ]]
			p1.OnHit:Connect(function(p13, p2, p3) --[[ Line: 58 | Upvalues: v8 (ref), v1 (ref), Players (ref), LocalPlayer (ref), Handle (ref), v9 (ref), MeleeConfig (ref), p1 (copy), RemoteEventMelee (ref) ]]
				if not (p13 and (p13.Parent and v8)) then
					return
				end

				if p13:IsDescendantOf(v1) or p13.Parent:IsA("Tool") then
					return
				end

				local v122 = Players:GetPlayerFromCharacter(p13.Parent)

				if v122 and v122 == LocalPlayer then
					return
				end

				if p13.Parent ~= workspace and p13:IsDescendantOf(Handle.Parent) then
					return
				end

				if p13.Parent:IsA("Accessory") then
					return
				end

				Handle = p13

				if v9 > MeleeConfig.consecutiveHits then
					p1:HitStop()
				else
					v9 = v9 + 1
					RemoteEventMelee:FireServer(p13, p3.Position, p3.Normal)
				end
			end)
		end

		p1.Equipped:Connect(function() --[[ Line: 82 | Upvalues: MeleeConfig (copy), ChargeBar (ref), MotorGrip (copy), MeleeSystemReplicated (ref), p1 (copy), dualWield (copy), v5 (ref), RaycastHitboxV4 (ref), v8 (ref), v2 (ref), v3 (ref), v10 (ref), v1 (copy), v6 (ref), v7 (ref), v4 (copy), Players (ref), LocalPlayer (copy), Handle (ref), v9 (ref), RemoteEventMelee (copy) ]]
			if MeleeConfig.displayChargeBar then
				ChargeBar.StartTracking()
			end

			if MotorGrip and MotorGrip.Value == true then
				MeleeSystemReplicated.ConnectM6D:FireServer(p1.Handle)
			end

			if dualWield then
				MeleeSystemReplicated.ConnectM6D:FireServer(p1.Handle, dualWield)
				p1:WaitForChild("Handle2")
				v5 = RaycastHitboxV4.new(p1.Handle2)
				v5.DetectionMode = RaycastHitboxV4.DetectionMode.PartMode
				v5.Visualizer = true
			end

			v8 = false

			if v2 then
				v2:Stop()
			end

			if v3 then
				v3:Stop()
			end

			if v10 then
				v10:Stop()
			end

			v2 = v1.Humanoid:LoadAnimation(p1.Anims:WaitForChild("idle"))
			v2.Priority = Enum.AnimationPriority.Action
			v2.Looped = true
			v2:Play()
			v10 = v1.Humanoid:LoadAnimation(p1.Anims.Equip)
			v10:Play()
			p1.Handle.Equip:Play()
			v6 = false
			v7 = false
			ChargeBar.Charge(v10.Length)
			task.delay(v10.Length, function() --[[ Line: 117 | Upvalues: v6 (ref), v8 (ref) ]]
				v6 = true
				v8 = true
			end)

			local v12 = v4

			v12.OnHit:Connect(function(p13, p2, p3) --[[ Line: 58 | Upvalues: v8 (ref), v1 (ref), Players (ref), LocalPlayer (ref), Handle (ref), v9 (ref), MeleeConfig (ref), v12 (copy), RemoteEventMelee (ref) ]]
				if not (p13 and (p13.Parent and v8)) then
					return
				end

				if p13:IsDescendantOf(v1) or p13.Parent:IsA("Tool") then
					return
				end

				local v122 = Players:GetPlayerFromCharacter(p13.Parent)

				if v122 and v122 == LocalPlayer then
					return
				end

				if p13.Parent ~= workspace and p13:IsDescendantOf(Handle.Parent) then
					return
				end

				if p13.Parent:IsA("Accessory") then
					return
				end

				Handle = p13

				if v9 > MeleeConfig.consecutiveHits then
					v12:HitStop()
				else
					v9 = v9 + 1
					RemoteEventMelee:FireServer(p13, p3.Position, p3.Normal)
				end
			end)

			if not v5 then
				return
			end

			local v22 = v5

			v22.OnHit:Connect(function(p13, p2, p3) --[[ Line: 58 | Upvalues: v8 (ref), v1 (ref), Players (ref), LocalPlayer (ref), Handle (ref), v9 (ref), MeleeConfig (ref), v22 (copy), RemoteEventMelee (ref) ]]
				if not (p13 and (p13.Parent and v8)) then
					return
				end

				if p13:IsDescendantOf(v1) or p13.Parent:IsA("Tool") then
					return
				end

				local v122 = Players:GetPlayerFromCharacter(p13.Parent)

				if v122 and v122 == LocalPlayer then
					return
				end

				if p13.Parent ~= workspace and p13:IsDescendantOf(Handle.Parent) then
					return
				end

				if p13.Parent:IsA("Accessory") then
					return
				end

				Handle = p13

				if v9 > MeleeConfig.consecutiveHits then
					v22:HitStop()
				else
					v9 = v9 + 1
					RemoteEventMelee:FireServer(p13, p3.Position, p3.Normal)
				end
			end)
		end)
		p1.Unequipped:Connect(function() --[[ Line: 129 | Upvalues: v8 (ref), v6 (ref), v7 (ref), v2 (ref), v10 (ref), v3 (ref), v5 (ref), MotorGrip (copy), MeleeSystemReplicated (ref), p1 (copy), v4 (copy), MeleeConfig (copy), ChargeBar (ref) ]]
			v8 = false
			v6 = false
			v7 = false

			if v2 then
				v2:Stop()
			end

			if v10 then
				v10:Stop()
			end

			if v3 then
				v3:Stop()
			end

			if v5 then
				v5:HitStop()
				v5:Destroy()
			end

			if MotorGrip and MotorGrip.Value == true then
				MeleeSystemReplicated.DisconnectM6D:FireServer(p1.Handle)
			end

			v4:HitStop()

			if not MeleeConfig.displayChargeBar then
				return
			end

			ChargeBar.StopTracking()
		end)

		local function swing() --[[ swing | Line: 152 | Upvalues: v10 (ref), v6 (ref), v7 (ref), v8 (ref), v11 (copy), v3 (ref), v1 (copy), MeleeConfig (copy), ShakeFunction (ref), ChargeBar (ref), v12 (copy), v4 (copy), SwingStart (copy), p1 (copy), SwingEnd (copy), v5 (ref), v9 (ref), Handle (ref) ]]
			if v10 and v10.IsPlaying then
				return
			end

			if not v6 or (v7 or not v8) then
				return
			end

			v7 = true
			v6 = false
			v3 = v1.Humanoid:LoadAnimation(v11[math.random(1, #v11)])

			local v2 = false

			if MeleeConfig.shakeCamera then
				ShakeFunction.Shake(MeleeConfig.camShakeSettings)
			end

			ChargeBar.Charge(v3.Length + v12)
			v3:GetMarkerReachedSignal("HitStart"):Connect(function() --[[ Line: 169 | Upvalues: v2 (ref), v4 (ref), SwingStart (ref), p1 (ref) ]]
				if v2 then
					return
				end

				v2 = true
				v4:HitStart()
				SwingStart:FireServer(p1)
			end)
			v3:GetMarkerReachedSignal("HitEnd"):Connect(function() --[[ Line: 177 | Upvalues: v4 (ref), SwingEnd (ref), p1 (ref) ]]
				v4:HitStop()
				SwingEnd:FireServer(p1)
			end)
			v3:GetMarkerReachedSignal("HitStart2"):Connect(function() --[[ Line: 182 | Upvalues: v5 (ref), v2 (ref), SwingStart (ref), p1 (ref) ]]
				if not v5 or v2 then
					return
				end

				v2 = true
				v5:HitStart()
				SwingStart:FireServer(p1)
			end)
			v3:GetMarkerReachedSignal("HitEnd2"):Connect(function() --[[ Line: 190 | Upvalues: v5 (ref), SwingEnd (ref), p1 (ref) ]]
				if not v5 then
					return
				end

				v5:HitStop()
				SwingEnd:FireServer(p1)
			end)
			v3:Play()
			v3.Stopped:Connect(function() --[[ Line: 198 | Upvalues: v12 (ref), v7 (ref), v6 (ref), v9 (ref), Handle (ref), p1 (ref) ]]
				task.wait(v12)
				v7 = false
				v6 = true
				v9 = 0
				Handle = p1.Handle
			end)
		end

		p1.Activated:Connect(swing)
		UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 209 | Upvalues: F (copy), V (copy) ]]
			if p2 then
				return
			end

			if p1.KeyCode ~= F then
				local isKeyCode = p1.KeyCode == V
			end
		end)
	end
}