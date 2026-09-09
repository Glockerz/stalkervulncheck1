-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	ClassName = "OctreeNode"
}

t.__index = t
function t.new(p1, p2) --[[ new | Line: 7 | Upvalues: t (copy) ]]
	local t2 = {
		CurrentLowestRegion = nil,
		Position = nil,
		PositionX = nil,
		PositionY = nil,
		PositionZ = nil
	}

	t2.Octree = if p1 then p1 else error("No octree")
	t2.Object = if p2 then p2 else error("No object")

	return setmetatable(t2, t)
end
function t.KNearestNeighborsSearch(p1, p2, p3) --[[ KNearestNeighborsSearch | Line: 20 ]]
	return p1.Octree:KNearestNeighborsSearch(p1.Position, p2, p3)
end
function t.GetObject(p1) --[[ GetObject | Line: 24 ]]
	warn("OctreeNode:GetObject is deprecated.")

	return p1.Object
end
function t.RadiusSearch(p1, p2) --[[ RadiusSearch | Line: 29 ]]
	return p1.Octree:RadiusSearch(p1.Position, p2)
end
function t.GetPosition(p1) --[[ GetPosition | Line: 33 ]]
	warn("OctreeNode:GetPosition is deprecated.")

	return p1.Position
end
function t.GetRawPosition(p1) --[[ GetRawPosition | Line: 38 ]]
	return p1.PositionX, p1.PositionY, p1.PositionZ
end
function t.SetPosition(p1, p2) --[[ SetPosition | Line: 42 ]]
	if p1.Position == p2 then
		return
	end

	local X = p2.X
	local Y = p2.Y
	local Z = p2.Z

	p1.PositionX = X
	p1.PositionY = Y
	p1.PositionZ = Z
	p1.Position = p2

	if p1.CurrentLowestRegion then
		local CurrentLowestRegion = p1.CurrentLowestRegion
		local LowerBounds = CurrentLowestRegion.LowerBounds
		local UpperBounds = CurrentLowestRegion.UpperBounds

		if LowerBounds[1] <= X and (X <= UpperBounds[1] and (LowerBounds[2] <= Y and (Y <= UpperBounds[2] and (LowerBounds[3] <= Z and Z <= UpperBounds[3])))) then
			return
		end
	end

	local v1 = p1.Octree:GetOrCreateLowestSubRegion(X, Y, Z)

	if p1.CurrentLowestRegion then
		local CurrentLowestRegion = p1.CurrentLowestRegion

		if CurrentLowestRegion.Depth ~= v1.Depth then
			error("fromLowest.Depth ~= toLowest.Depth")
		end

		if CurrentLowestRegion == v1 then
			error("fromLowest == toLowest")
		end

		v2 = CurrentLowestRegion
		v3 = v1

		while v2 ~= v3 do
			local Nodes = v2.Nodes

			if not Nodes[p1] then
				error("CurrentFrom.Nodes doesn\'t have a node here.")
			end

			local NodeCount = v2.NodeCount

			if NodeCount <= 0 then
				error("NodeCount is <= 0.")
			end

			local v4 = NodeCount - 1

			Nodes[p1] = nil
			v2.NodeCount = v4

			local ParentIndex = v2.ParentIndex

			if v4 <= 0 and ParentIndex then
				local v5 = v2.Parent

				if not v5 then
					error("CurrentFrom.Parent doesn\'t exist.")
				end

				local SubRegions = v5.SubRegions

				if SubRegions[ParentIndex] ~= v2 then
					error("Failed equality check.")
				end

				SubRegions[ParentIndex] = nil
			end

			local Nodes2 = v3.Nodes

			if Nodes2[p1] then
				error("CurrentTo.Nodes already has a node here.")
			end

			Nodes2[p1] = p1
			v3.NodeCount = v3.NodeCount + 1
			v2 = v2.Parent
			v3 = v3.Parent
		end
	else
		local v6 = v1

		while v6 do
			local Nodes = v6.Nodes

			if not Nodes[p1] then
				Nodes[p1] = p1
				v6.NodeCount = v6.NodeCount + 1
			end

			v6 = v6.Parent
		end
	end

	p1.CurrentLowestRegion = v1
end
function t.Destroy(p1) --[[ Destroy | Line: 144 ]]
	local CurrentLowestRegion = p1.CurrentLowestRegion

	if not CurrentLowestRegion then
		return
	end

	local v1 = CurrentLowestRegion

	while v1 do
		local Nodes = v1.Nodes

		if not Nodes[p1] then
			error("CurrentFrom.Nodes doesn\'t have a node here.")
		end

		local NodeCount = v1.NodeCount

		if NodeCount <= 0 then
			error("NodeCount is <= 0.")
		end

		local v2 = NodeCount - 1

		Nodes[p1] = nil
		v1.NodeCount = v2

		local v3 = v1.Parent
		local ParentIndex = v1.ParentIndex

		if v2 <= 0 and ParentIndex then
			if not v3 then
				error("Current.Parent doesn\'t exist.")
			end

			local SubRegions = v3.SubRegions

			if SubRegions[ParentIndex] ~= v1 then
				error("Failed equality check.")
			end

			SubRegions[ParentIndex] = nil
		end

		v1 = v3
	end
end

return t