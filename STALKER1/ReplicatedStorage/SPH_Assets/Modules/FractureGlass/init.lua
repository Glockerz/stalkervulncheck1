-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local glassShardDespawnTime = require(game.ReplicatedStorage.SPH_Assets.GameConfig).glassShardDespawnTime
local Terrain = game.Workspace.Terrain
local v1 = nil
local GlassFragment = Instance.new("WedgePart")

GlassFragment.Name = "GlassFragment"
GlassFragment.Anchored = true
GlassFragment.CanCollide = true
GlassFragment.CanTouch = false
GlassFragment.TopSurface = Enum.SurfaceType.Smooth
GlassFragment.BottomSurface = Enum.SurfaceType.Smooth

local function DrawTriangle(p1, p2, p3, p4, p5) --[[ DrawTriangle | Line: 63 | Upvalues: GlassFragment (copy), Terrain (copy) ]]
	local v1 = p2 - p1
	local v2 = p3 - p1
	local v3 = p3 - p2
	local v4 = v1:Dot(v1)
	local v5 = v2:Dot(v2)
	local v6 = v3:Dot(v3)

	if v5 < v4 and v6 < v4 then
		p1, p3 = p3, p1
	elseif v6 < v5 and v4 < v5 then
		p2, p1 = p1, p2
	end

	local v8 = p2 - p1
	local v9 = p3 - p1
	local v10 = p3 - p2
	local unit = v9:Cross(v8).unit
	local unit2 = v10:Cross(unit).unit
	local unit3 = v10.unit
	local v12 = math.abs((v8:Dot(unit2)))
	local v13 = GlassFragment:Clone()

	v13.Size = Vector3.new(p4.Size.Z, v12, (math.abs((v8:Dot(unit3)))))
	v13.CFrame = p4.CFrame * CFrame.new((p1 + p2) * 0.5 - p4.Position) * CFrame.fromMatrix(Vector3.new(), unit, unit2, unit3)
	v13.Color = p4.Color
	v13.Material = p4.Material
	v13.Transparency = p4.Transparency
	v13.CastShadow = p4.CastShadow
	v13.Velocity = p5
	v13.Parent = Terrain

	local v16 = GlassFragment:Clone()

	v16.Size = Vector3.new(p4.Size.Z, v12, (math.abs((v9:Dot(unit3)))))
	v16.CFrame = p4.CFrame * CFrame.new((p1 + p3) * 0.5 - p4.Position) * CFrame.fromMatrix(Vector3.new(), -unit, unit2, -unit3)
	v16.Color = p4.Color
	v16.Material = p4.Material
	v16.Transparency = p4.Transparency
	v16.CastShadow = p4.CastShadow
	v16.Velocity = p5
	v16.Parent = Terrain

	return v13, v16
end

local function FindIntersectionV(p1, p2, p3) --[[ FindIntersectionV | Line: 111 ]]
	return p1:Lerp(p2, (p1.X - p3) / (p1.X - p2.X))
end

local function FindIntersectionH(p1, p2, p3) --[[ FindIntersectionH | Line: 115 ]]
	return p1:Lerp(p2, (p1.Y - p3) / (p1.Y - p2.Y))
end

local function FindIntersectionD(p1, p2, p3, p4) --[[ FindIntersectionD | Line: 119 ]]
	local v1 = (p2.Y - p1.Y) / (p2.X - p1.X)
	local v2 = (p4 - (p1.Y - p1.X * v1)) / (v1 - p3)

	return Vector3.new(v2, v2 * p3 + p4, p1.Z)
end

local function CreatePolygon(p1, p2, p3) --[[ CreatePolygon | Line: 126 | Upvalues: FindIntersectionV (copy), FindIntersectionH (copy), DrawTriangle (copy) ]]
	local v1 = p2.Size * 0.5
	local list = {}
	local v2 = p2.Position.Y + v1.Y
	local v3 = p2.Position.Y - v1.Y
	local v4 = p2.Position.X - v1.X
	local v5 = p2.Position.X + v1.X

	if p2.Shape == Enum.PartType.Wedge then
		local v6 = Vector2.new(p2.Position.X - v1.X, p2.Position.Y + v1.Y)
		local v7 = Vector2.new(p2.Position.X + v1.X, p2.Position.Y - v1.Y)
		local v8 = (v7.Y - v6.Y) / (v7.X - v6.X)
		local v9 = v6.Y - v6.X * v8

		for i, v in ipairs(p1) do
			local v10 = p1[i % #p1 + 1]
			local v11 = if v.Y <= v.X * v8 + v9 then true else false
			local v12 = if v10.Y <= v10.X * v8 + v9 then true else false

			if v11 and v12 then
				table.insert(list, v10)

				continue
			end

			if v11 or not v12 then
				if v11 and not v12 then
					local v13 = (v10.Y - v.Y) / (v10.X - v.X)
					local v14 = (v9 - (v.Y - v.X * v13)) / (v13 - v8)

					table.insert(list, (Vector3.new(v14, v14 * v8 + v9, v.Z)))
				end

				continue
			end

			local v16 = (v10.Y - v.Y) / (v10.X - v.X)
			local v17 = (v9 - (v.Y - v.X * v16)) / (v16 - v8)

			table.insert(list, (Vector3.new(v17, v17 * v8 + v9, v.Z)))
			table.insert(list, v10)
		end
	else
		for i, v in ipairs(p1) do
			local v19 = p1[i % #p1 + 1]
			local v20 = if v.X <= v5 then true else false
			local v21 = if v19.X <= v5 then true else false

			if v20 and v21 then
				table.insert(list, v19)

				continue
			end

			if v20 or not v21 then
				if v20 and not v21 then
					table.insert(list, FindIntersectionV(v, v19, v5))
				end

				continue
			end

			table.insert(list, FindIntersectionV(v, v19, v5))
			table.insert(list, v19)
		end

		local v24

		v24, list = list, {}

		for i, v in ipairs(list) do
			local v25 = v24[i % #v24 + 1]
			local v26 = v.Y <= v2
			local v27 = if v25.Y <= v2 then true else false

			if v26 and v27 then
				table.insert(list, v25)

				continue
			end

			if v26 or not v27 then
				if v26 and not v27 then
					table.insert(list, FindIntersectionH(v, v25, v2))
				end

				continue
			end

			table.insert(list, FindIntersectionH(v, v25, v2))
			table.insert(list, v25)
		end
	end

	local v30, v31 = list, {}

	for i, v in ipairs(list) do
		local v32 = v30[i % #v30 + 1]
		local v33 = if v4 <= v.X then true else false
		local v34 = if v4 <= v32.X then true else false

		if v33 and v34 then
			table.insert(v31, v32)

			continue
		end

		if v33 or not v34 then
			if v33 and not v34 then
				table.insert(v31, FindIntersectionV(v, v32, v4))
			end

			continue
		end

		table.insert(v31, FindIntersectionV(v, v32, v4))
		table.insert(v31, v32)
	end

	local v37, v38 = v31, {}

	for i, v in ipairs(v31) do
		local v39 = v37[i % #v37 + 1]
		local v40 = if v3 <= v.Y then true else false
		local v41 = if v3 <= v39.Y then true else false

		if v40 and v41 then
			table.insert(v38, v39)

			continue
		end

		if v40 or not v41 then
			if v40 and not v41 then
				table.insert(v38, FindIntersectionH(v, v39, v3))
			end

			continue
		end

		table.insert(v38, FindIntersectionH(v, v39, v3))
		table.insert(v38, v39)
	end

	local t = {}

	for i = 3, #v38 do
		local v44, v45 = DrawTriangle(v38[1], v38[i - 1], v38[i], p2, p3)

		table.insert(t, v44)
		table.insert(t, v45)
	end

	return t
end

local function IsInCircle(p1, p2, p3) --[[ IsInCircle | Line: 238 ]]
	return (p1.X - p2.X) ^ 2 + (p1.Y - p2.Y) ^ 2 < p3 * p3
end

local function CreateCracks(p1, p2, p3) --[[ CreateCracks | Line: 242 | Upvalues: CreatePolygon (copy) ]]
	local v1 = p1.Size * 0.5
	local Magnitude = (Vector2.new(6.123233995736766e-17, 1) * 0.5 + Vector2.new(0.5, 0)).Magnitude
	local count = 1
	local v2 = 1
	local t = {}
	local t2 = {}

	repeat
		count = count + 1
		v2 = v2 * 2

		local v4 = p1.Position + Vector3.new(-v1.X, -v1, 0)
		local v5 = v2 * Magnitude
		local v6 = if (v4.X - p2.X) ^ 2 + (v4.Y - p2.Y) ^ 2 < v5 * v5 then true else false

		if v6 then
			local v8 = p1.Position + Vector3.new(-v1.X, v1.Y, 0)
			local v9 = v2 * Magnitude

			if if (v8.X - p2.X) ^ 2 + (v8.Y - p2.Y) ^ 2 < v9 * v9 then true else false then
				local v11 = p1.Position + Vector3.new(v1.X, v1.Y, 0)
				local v12 = v2 * Magnitude

				if if (v11.X - p2.X) ^ 2 + (v11.Y - p2.Y) ^ 2 < v12 * v12 then true else false then
					local v15 = p1.Position + Vector3.new(v1.X, -v1.Y, 0)
					local v16 = v2 * Magnitude

					if if (v15.X - p2.X) ^ 2 + (v15.Y - p2.Y) ^ 2 < v16 * v16 then true else false then
						for i = 1, 6 do
							t[i] = {}

							for j = 1, count do
								t[i][j] = 1.0471975511965976 * (i + (math.random() - 0.5) * 0.5)
							end
						end

						for k = 1, 6 do
							for n = 1, count do
								local v19 = (k + 6 - 2) % 6 + 1

								if n == 1 then
									for i, v in ipairs((CreatePolygon({ p2, (CFrame.new(p2) * CFrame.Angles(0, 0, t[k][n]) * CFrame.new(0, 1, 0)).Position, (CFrame.new(p2) * CFrame.Angles(0, 0, t[v19][n]) * CFrame.new(0, 1, 0)).Position }, p1, p3))) do
										table.insert(t2, v)
										v.Anchored = false
									end

									continue
								end

								local v20 = CreatePolygon({
									(CFrame.new(p2) * CFrame.Angles(0, 0, t[k][n]) * CFrame.new(0, 2 ^ (n - 1) * 1, 0)).Position,
									(CFrame.new(p2) * CFrame.Angles(0, 0, t[k][n - 1]) * CFrame.new(0, 2 ^ (n - 2) * 1, 0)).Position,
									(CFrame.new(p2) * CFrame.Angles(0, 0, t[v19][n - 1]) * CFrame.new(0, 2 ^ (n - 2) * 1, 0)).Position,
									(CFrame.new(p2) * CFrame.Angles(0, 0, t[v19][n]) * CFrame.new(0, 2 ^ (n - 1) * 1, 0)).Position
								}, p1, p3)

								for i, v in ipairs(v20) do
									table.insert(t2, v)
								end

								task.delay((k - 1) * 0.015 + n * 0.005, function() --[[ Line: 300 | Upvalues: v20 (copy) ]]
									for i, v in ipairs(v20) do
										v.Anchored = false
									end
								end)
							end
						end

						return t2, count * 0.005 + 0.075
					end
				end
			end
		end
	until not v6
end

return function(p1, p2, p3, ...) --[[ Line: 312 | Upvalues: v1 (ref), CreateCracks (copy), glassShardDespawnTime (copy) ]]
	if not ... then
		assert(p1, "Parameter \'part\' was nil, expected BasePart.")

		local v12 = p2 or p1.Position
		local v2 = p3 or Vector3.new()

		if p1.Shape == Enum.PartType.Wedge then
			p1.Size = Vector3.new(p1.Size.Z, p1.Size.Y, p1.Size.X)
			p1.CFrame = p1.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
		else
			local v3 = math.min(p1.Size.X, p1.Size.Y, p1.Size.Z)

			if v3 == p1.Size.X then
				p1.Size = Vector3.new(p1.Size.Z, p1.Size.Y, p1.Size.X)
				p1.CFrame = p1.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
			elseif v3 == p1.Size.Y then
				p1.Size = Vector3.new(p1.Size.X, p1.Size.Z, p1.Size.Y)
				p1.CFrame = p1.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
			end
		end

		local v5 = p1.CFrame:ToObjectSpace(CFrame.new(v12)).Position + p1.Position
		local v6 = Vector3.new(v5.X, v5.Y, p1.Position.Z)

		if v1 then
			v1:Clone().Parent = p1
		end

		p2 = v6
		p3 = v2
	end

	if not (game.Players.LocalPlayer or ...) then
		script:WaitForChild("RenderGlass"):FireAllClients({
			Position = p1.Position,
			CFrame = p1.CFrame,
			Size = p1.Size,
			Color = p1.Color,
			Material = p1.Material,
			Transparency = p1.Transparency,
			CastShadow = p1.CastShadow,
			Shape = p1.Shape
		}, p2, p3)
		p1:Destroy()

		return
	end

	local v7, v8 = CreateCracks(p1, p2, p3)
	local v9 = false

	task.delay(glassShardDespawnTime, function() --[[ Line: 359 | Upvalues: v7 (copy), v9 (ref) ]]
		for i, v in ipairs(v7) do
			v:Destroy()
		end

		v9 = true
	end)
	task.delay(v8 + 0.1, function() --[[ Line: 374 | Upvalues: v7 (copy), v9 (ref) ]]
		local v1 = table.clone(v7)

		while not v9 do
			for i = #v1, 1, -1 do
				local v2 = v1[i]

				if not (v2.Velocity.Y < math.min(-1 + (v2.Size.X + v2.Size.Y) * 0.1, 0)) or v2.Anchored then
					v2.Anchored = true
					v2.CanCollide = false
					table.remove(v1, i)
				end
			end

			task.wait(0.1)
		end
	end)

	if typeof(p1) ~= "table" then
		p1:Destroy()
	end
end