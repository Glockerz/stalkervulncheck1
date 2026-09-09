-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

function ReturnNormal(p1, p2) --[[ ReturnNormal | Line: 6 ]]
	if p1.lookVector - p2 == Vector3.new(0, 0, 0) then
		return "Front", 5
	end

	if p1.lookVector + p2 == Vector3.new(0, 0, 0) then
		return "Back", 2
	end

	local _, _2, _3, v1, v2, _4, v3, v4, _5, v5, v6, _6 = p1:components()

	if Vector3.new(v2, v4, v6) == p2 then
		return "Top", 1
	end

	if Vector3.new(-v2, -v4, -v6) == p2 then
		return "Bottom", 4
	end

	if Vector3.new(-v1, -v3, -v5) == p2 then
		return "Left", 3
	end

	if Vector3.new(v1, v3, v5) == p2 then
		return "Right", 0
	end
end
function SecondaryTex(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) --[[ SecondaryTex | Line: 25 ]]
	local v1 = math.random(script.Blood[p10].Decal.MinSize.Value, script.Blood[p10].Decal.MaxSize.Value)
	local X = p4.Size.X
	local Y = p4.Size.Y
	local v2 = nil
	local v3 = nil
	local _ = -X + p4.CFrame:toObjectSpace(CFrame.new(p5)).p.Z / X

	if p3 == 1 then
		if p1 == "Front" then
			v3 = 0
			v2 = "Right"
		elseif p1 == "Right" then
			v3 = 2
			v2 = "Back"
		elseif p1 == "Left" then
			v3 = 5
			v2 = "Front"
		elseif p1 == "Back" then
			v3 = 3
			v2 = "Left"
		end
	elseif p1 == "Front" then
		v3 = 3
		v2 = "Left"
	elseif p1 == "Right" then
		v3 = 5
		v2 = "Front"
	elseif p1 == "Left" then
		v3 = 2
		v2 = "Back"
	elseif p1 == "Back" then
		v3 = 0
		v2 = "Right"
	end

	if v2 == "Right" or v2 == "Left" then
		X = p4.Size.Z
		Y = p4.Size.Y

		local _2 = -X + p4.CFrame:toObjectSpace(CFrame.new(p5)).p.X / X
	end

	local v5 = nil
	local v6 = nil

	if v2 == nil then
		return
	end

	for k, v in pairs(p4:GetChildren()) do
		if v:IsA("SurfaceGui") and v.Face == Enum.NormalId[v2] then
			v6 = v.Framey
			print(v.Face, "Found")
			v5 = v
		end
	end

	if v5 == nil and p4.Parent:FindFirstChild("Humanoid") == nil then
		local SurfaceGui = Instance.new("SurfaceGui", p4)

		SurfaceGui.CanvasSize = Vector2.new(X * 10, Y * 10)
		SurfaceGui.Face = v3
		print(SurfaceGui.Face, "Made")

		local Framey = Instance.new("Frame", SurfaceGui)

		Framey.Name = "Framey"
		Framey.Size = UDim2.new(1, 0, 1, 0)
		Framey.BackgroundColor = BrickColor.new(170, 0, 0)
		Framey.ClipsDescendants = true
		Framey.BackgroundTransparency = 1
		v6 = Framey
	end

	local ImageLabel = Instance.new("ImageLabel", v6)

	ImageLabel.Image = p9
	ImageLabel.Size = UDim2.new(0, v1, 0, v1)
	ImageLabel.ImageColor3 = Color3.new(0.666667, 0, 0)
	ImageLabel.BackgroundTransparency = 1

	if p3 == 0 then
		ImageLabel.Position = UDim2.new(0, p3 - (p6 - p7), p2.Y.Scale, p2.Y.Offset)
	else
		ImageLabel.Position = UDim2.new(1, p7, p2.Y.Scale, p2.Y.Offset)
	end

	game.Debris:AddItem(ImageLabel, 200)
end
function t.MakeDecalOnSurface(p1, p2, p3, p4, p5) --[[ MakeDecalOnSurface | Line: 101 ]]
	if not (p3 and p1) then
		warn("Invalid arguments: part or package missing")

		return
	end

	local v1 = script:FindFirstChild(p1)

	if not v1 then
		warn("Package not found:", p1)

		return
	end

	local v2 = v1:FindFirstChild(p5)

	if not v2 then
		warn("Size folder not found in package:", p5)

		return
	end

	local v3 = v2:GetChildren()

	if #v3 == 0 then
		warn("No images found in package/size folder")

		return
	end

	local v4 = v3[math.random(1, #v3)]

	if not v4 then
		warn("Random image selection failed")

		return
	end

	local v5 = math.random(script.Blood[p5].Decal.MinSize.Value, script.Blood[p5].Decal.MaxSize.Value)
	local v6, v7 = ReturnNormal(p3.CFrame, p2)

	if not v6 then
		warn("Could not determine face for normal", p2)

		return
	end

	local v8 = nil
	local v9 = nil

	for i, v in ipairs(p3:GetChildren()) do
		if v:IsA("SurfaceGui") and v.Face == Enum.NormalId[v6] then
			local Framey = v:FindFirstChild("Framey")

			v8 = v
			v9 = Framey

			break
		end
	end

	local X = p3.Size.X
	local Y = p3.Size.Y

	if v6 == "Top" or v6 == "Bottom" then
		X = p3.Size.Z
		Y = p3.Size.X
	elseif v6 == "Right" or v6 == "Left" then
		X = p3.Size.Z
		Y = p3.Size.Y
	end

	if not (v8 or p3.Parent:FindFirstChild("Humanoid")) then
		local BloodSurface = Instance.new("SurfaceGui")

		BloodSurface.Name = "BloodSurface"
		BloodSurface.Face = v7
		BloodSurface.CanvasSize = Vector2.new(X * 10, Y * 10)
		BloodSurface.Parent = p3

		local Framey = Instance.new("Frame")

		Framey.Name = "Framey"
		Framey.Size = UDim2.new(1, 0, 1, 0)
		Framey.BackgroundTransparency = 1
		Framey.ClipsDescendants = true
		Framey.Parent = BloodSurface
		v8 = BloodSurface
		v9 = Framey
	end

	if v8 and not v9 then
		local Framey = Instance.new("Frame")

		Framey.Name = "Framey"
		Framey.Size = UDim2.new(1, 0, 1, 0)
		Framey.BackgroundTransparency = 1
		Framey.ClipsDescendants = true
		Framey.Parent = v8
		v9 = Framey
	end

	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.Image = v4.Value
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.ImageColor3 = Color3.new(0.666667, 0, 0)
	ImageLabel.Parent = v9

	local v10 = X / Y

	if v10 > 1 then
		ImageLabel.Size = UDim2.new(0, v5, 0, v5 / v10)
	else
		ImageLabel.Size = UDim2.new(0, v5 * v10, 0, v5)
	end

	local v11 = -p3.CFrame:toObjectSpace(CFrame.new(p4)).p

	if v6 == "Front" then
		ImageLabel.Position = UDim2.new(0.5 + v11.X / X, -v5 / 2, 0.5 + v11.Y / Y, -v5 / 2)
	elseif v6 == "Back" then
		ImageLabel.Position = UDim2.new(0.5 + -v11.X / X, -v5 / 2, 0.5 + v11.Y / Y, -v5 / 2)
	elseif v6 == "Right" then
		ImageLabel.Position = UDim2.new(0.5 + v11.Z / X, -v5 / 2, 0.5 + v11.Y / Y, -v5 / 2)
	elseif v6 == "Left" then
		ImageLabel.Position = UDim2.new(0.5 + -v11.Z / X, -v5 / 2, 0.5 + v11.Y / Y, -v5 / 2)
	elseif v6 == "Top" then
		ImageLabel.Position = UDim2.new(0.5 + v11.Z / X, -v5 / 2, 0.5 + -v11.X / Y, -v5 / 2)
	elseif v6 == "Bottom" then
		ImageLabel.Position = UDim2.new(0.5 + v11.Z / X, -v5 / 2, 0.5 + v11.X / Y, -v5 / 2)
	end

	if ImageLabel.AbsolutePosition.X > v8.AbsoluteSize.X - v5 then
		SecondaryTex(v6, ImageLabel.Position, 0, p3, p4, v8.AbsoluteSize.X, ImageLabel.AbsolutePosition.X, v5, v4.Value, p5)
	elseif ImageLabel.AbsolutePosition.X < v5 / 2 then
		SecondaryTex(v6, ImageLabel.Position, 1, p3, p4, v8.AbsoluteSize.X, ImageLabel.AbsolutePosition.X, v5, v4.Value, p5)
	end

	game.Debris:AddItem(ImageLabel, 200)
end

return t