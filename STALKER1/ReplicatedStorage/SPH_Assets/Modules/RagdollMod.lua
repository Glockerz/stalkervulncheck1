-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	MakeCorpse = function(p1) --[[ Line: 3 ]]
		local Humanoid = p1:FindFirstChildOfClass("Humanoid")

		if Humanoid then
			local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

			if not HumanoidRootPart then
				warn(string.format("[RagdollMod] MakeCorpse: no HumanoidRootPart in \'%s\'", p1.Name))

				return nil
			end

			local Model = Instance.new("Model")

			Model.Parent = workspace
			Model.Name = p1.Name .. "_Dead"

			for k, v in pairs(p1:GetDescendants()) do
				if v:IsA("Motor6D") and v.Part0 and v.Part1 then
					if v.Part0.Name == "HumanoidRootPart" or v.Part1.Name == "HumanoidRootPart" then
						v.Enabled = false

						continue
					end

					if v.Part0.Parent == p1 or v.Part1.Parent == p1 then
						local Attachment = Instance.new("Attachment")
						local Attachment2 = Instance.new("Attachment")

						Attachment.CFrame = v.C0
						Attachment2.CFrame = v.C1
						Attachment.Parent = v.Part0
						Attachment2.Parent = v.Part1

						if Humanoid.RigType == Enum.HumanoidRigType.R6 then
							if v.Part1.Name == "Left Leg" then
								Attachment2.Position = Attachment2.Position - Vector3.new(-0.5, 0, 0)
								Attachment.Position = Attachment.Position - Vector3.new(-0.5, 0, 0)
							elseif v.Part1.Name == "Right Leg" then
								Attachment2.Position = Attachment2.Position - Vector3.new(0.5, 0, 0)
								Attachment.Position = Attachment.Position - Vector3.new(0.5, 0, 0)
							end
						end

						local BallSocketConstraint = Instance.new("BallSocketConstraint")

						BallSocketConstraint.Attachment0 = Attachment
						BallSocketConstraint.Attachment1 = Attachment2
						BallSocketConstraint.Parent = v.Part0
						v:Destroy()
					end
				end
			end

			local v2 = p1:FindFirstChildWhichIsA("Shirt")

			if v2 then
				v2.Parent = Model
			end

			local v3 = p1:FindFirstChildWhichIsA("Pants")

			if v3 then
				v3.Parent = Model
			end

			local LimbHealth = p1:FindFirstChild("LimbHealth")

			if LimbHealth then
				LimbHealth.Parent = Model
			end

			for k, v in pairs(p1:GetChildren()) do
				if v:IsA("Part") then
					v.Parent = Model

					local ok, result = pcall(function() --[[ Line: 97 | Upvalues: v (copy) ]]
						if not v.Anchored then
							v:SetNetworkOwner()
						end

						local v1 = v:FindFirstChild(v.Name)

						if v1 then
							v1.CFrame = v.CFrame
							v1.CanCollide = false
							v.CanCollide = false
							v1.skin.CanCollide = true

							local WeldConstraint = Instance.new("WeldConstraint")

							WeldConstraint.Name = "ActualWeld_Between_" .. v.Name .. "_And_" .. v1.Name
							WeldConstraint.Part0 = v
							WeldConstraint.Part1 = v1
							WeldConstraint.Parent = v
						end

						if v.Name == "HumanoidRootPart" then
							return
						end

						local Part = Instance.new("Part")

						Part.Size = v.Size * 0.5
						Part.Transparency = 1
						Part.Massless = true

						local Weld = Instance.new("Weld")

						Weld.Part0 = v
						Weld.Part1 = Part
						Weld.Parent = Part
						Part.Parent = v
					end)

					if not ok then
						warn(string.format("[RagdollMod] corpse part \'%s\' failed to transfer: %s -- skipped, the rest of the corpse is unaffected", v.Name, (tostring(result))))
					end
				end
			end

			Humanoid.Parent = Model
			Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

			local Humanoid2 = Instance.new("Humanoid")

			Humanoid2.MaxHealth = 0
			Humanoid2.Parent = p1

			for k, v in pairs(p1:GetChildren()) do
				if v:IsA("Accoutrement") then
					local ok, result = pcall(function() --[[ Line: 150 | Upvalues: v (copy), Model (copy), Humanoid (copy) ]]
						v.Parent = Model
						Humanoid:AddAccessory(v:Clone())
						v:Destroy()
					end)

					if not ok then
						warn(string.format("[RagdollMod] accessory \'%s\' failed to transfer: %s -- skipped, remaining gear still transfers", v.Name, (tostring(result))))
					end

					continue
				end

				if v:IsA("Model") then
					local ok, result = pcall(function() --[[ Line: 161 | Upvalues: v (copy), Model (copy) ]]
						v.Parent = Model
					end)

					if not ok then
						warn(string.format("[RagdollMod] gear model \'%s\' failed to transfer: %s", v.Name, (tostring(result))))
					end
				end
			end

			for i, v in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
				if v ~= Enum.HumanoidStateType.None then
					Humanoid:SetStateEnabled(v, false)
				end
			end

			HumanoidRootPart.Anchored = true
			HumanoidRootPart.CanCollide = false
			HumanoidRootPart.CanQuery = false
			HumanoidRootPart.CanTouch = false

			return Model
		end

		local t = {}

		for i, v in ipairs(p1:GetChildren()) do
			table.insert(t, v.ClassName .. ":" .. v.Name)
		end

		warn(string.format("[RagdollMod] MakeCorpse: no Humanoid in \'%s\'. Children: %s", p1.Name, table.concat(t, ", ")))

		return nil
	end
}