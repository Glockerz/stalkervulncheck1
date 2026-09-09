-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local OctreeNode = require(script.OctreeNode)
local OctreeRegionUtils = require(script.OctreeRegionUtils)
local t = {
	{ 0.25, 0.25, -0.25 },
	{ -0.25, 0.25, -0.25 },
	{ 0.25, 0.25, 0.25 },
	{ -0.25, 0.25, 0.25 },
	{ 0.25, -0.25, -0.25 },
	{ -0.25, -0.25, -0.25 },
	{ 0.25, -0.25, 0.25 },
	{ -0.25, -0.25, 0.25 }
}
local t2 = {
	ClassName = "Octree"
}

t2.__index = t2

local v1 = OctreeNode.new
local GetNeighborsWithinRadius = OctreeRegionUtils.GetNeighborsWithinRadius

function t2.new() --[[ new | Line: 28 | Upvalues: t2 (copy) ]]
	return setmetatable({
		MaxDepth = 4,
		MaxRegionSize = table.create(3, 512),
		RegionHashMap = {}
	}, t2)
end
function t2.ClearNodes(p1) --[[ ClearNodes | Line: 36 ]]
	p1.MaxDepth = 4
	p1.MaxRegionSize = table.create(3, 512)
	table.clear(p1.RegionHashMap)
end
function t2.GetAllNodes(p1) --[[ GetAllNodes | Line: 42 ]]
	local count = 0
	local t = {}

	for v1, v2 in next, p1.RegionHashMap do
		for i, v in ipairs(v2) do
			for v3 in next, v.Nodes do
				count = count + 1
				t[count] = v3
			end
		end
	end

	return t
end
function t2.CreateNode(p1, p2, p3) --[[ CreateNode | Line: 58 | Upvalues: v1 (copy) ]]
	if typeof(p2) ~= "Vector3" then
		error("Bad position value")
	end

	if p3 then
		local v12

		v12 = v1(p1, p3)
		v12:SetPosition(p2)

		return v12
	end

	error("Bad object value.")
end
function t2.RadiusSearch(p1, p2, p3) --[[ RadiusSearch | Line: 72 | Upvalues: GetNeighborsWithinRadius (copy) ]]
	if typeof(p2) ~= "Vector3" then
		error("Bad position value")
	end

	if type(p3) ~= "number" then
		error("Bad radius value")
	end

	local X = p2.X
	local Y = p2.Y
	local Z = p2.Z
	local v1 = p3 + 0.8660254037844386 * p1.MaxRegionSize[1]
	local v2 = v1 * v1 + 1e-9
	local v3 = 0
	local v4 = 0
	local t = {}
	local t2 = {}

	for v5, v6 in next, p1.RegionHashMap do
		for i, v in ipairs(v6) do
			local Position = v.Position
			local v8 = X - Position[1]
			local v9 = Y - Position[2]
			local v10 = Z - Position[3]

			if v8 * v8 + v9 * v9 + v10 * v10 <= v2 then
				local v11, v12 = GetNeighborsWithinRadius(v, p3, X, Y, Z, t, t2, p1.MaxDepth, v3, v4)

				v3 = v11
				v4 = v12
			end
		end
	end

	return t, t2
end

local function NearestNeighborSort(p1, p2) --[[ NearestNeighborSort | Line: 122 ]]
	return p1.Distance2 < p2.Distance2
end

function t2.KNearestNeighborsSearch(p1, p2, p3, p4) --[[ KNearestNeighborsSearch | Line: 126 | Upvalues: GetNeighborsWithinRadius (copy), NearestNeighborSort (copy) ]]
	if typeof(p2) ~= "Vector3" then
		error("Bad position value")
	end

	if type(p4) ~= "number" then
		error("Bad radius value")
	end

	local X = p2.X
	local Y = p2.Y
	local Z = p2.Z
	local v1 = p4 + 0.8660254037844386 * p1.MaxRegionSize[1]
	local v2 = v1 * v1 + 1e-9
	local v3 = 0
	local v4 = 0
	local t = {}
	local list = {}

	for v5, v6 in next, p1.RegionHashMap do
		for i, v in ipairs(v6) do
			local Position = v.Position
			local v7 = X - Position[1]
			local v8 = Y - Position[2]
			local v9 = Z - Position[3]

			if v7 * v7 + v8 * v8 + v9 * v9 <= v2 then
				local v10, v11 = GetNeighborsWithinRadius(v, p4, X, Y, Z, t, list, p1.MaxDepth, v3, v4)

				v3 = v10
				v4 = v11
			end
		end
	end

	local v12 = table.create(v4)

	for i, v in ipairs(list) do
		v12[i] = {
			Distance2 = v,
			Index = i
		}
	end

	table.sort(v12, NearestNeighborSort)

	local v13 = math.min(v4, p3)
	local v14 = table.create(v13)
	local v15 = table.create(v13)

	for i = 1, v13 do
		local v16 = v12[i]

		v15[i] = v16.Distance2
		v14[i] = t[v16.Index]
	end

	return v14, v15
end

local function GetOrCreateRegion(p1, p2, p3, p4) --[[ GetOrCreateRegion | Line: 195 ]]
	local RegionHashMap = p1.RegionHashMap
	local MaxRegionSize = p1.MaxRegionSize
	local v1 = MaxRegionSize[1]
	local v2 = MaxRegionSize[2]
	local v3 = MaxRegionSize[3]
	local v4 = math.floor(p2 / v1 + 0.5)
	local v5 = math.floor(p3 / v2 + 0.5)
	local v6 = math.floor(p4 / v3 + 0.5)
	local v7 = v4 * 73856093 + v5 * 19351301 + v6 * 83492791
	local v8 = RegionHashMap[v7]

	if not v8 then
		v8 = {}
		RegionHashMap[v7] = v8
	end

	local v9 = v1 * v4
	local v10 = v2 * v5
	local v11 = v3 * v6

	for i, v in ipairs(v8) do
		local Position = v.Position

		if Position[1] == v9 and (Position[2] == v10 and Position[3] == v11) then
			return v
		end
	end

	local v12 = v1 / 2
	local v13 = v2 / 2
	local v14 = v3 / 2
	local t = {
		Depth = 1,
		NodeCount = 0,
		Parent = nil,
		ParentIndex = nil,
		LowerBounds = { v9 - v12, v10 - v13, v11 - v14 },
		Nodes = {},
		Position = { v9, v10, v11 },
		Size = { v1, v2, v3 },
		SubRegions = {},
		UpperBounds = { v9 + v12, v10 + v13, v11 + v14 }
	}

	table.insert(v8, t)

	return t
end

function t2.GetOrCreateLowestSubRegion(p1, p2, p3, p4) --[[ GetOrCreateLowestSubRegion | Line: 240 | Upvalues: GetOrCreateRegion (copy), t (copy) ]]
	local v1 = GetOrCreateRegion(p1, p2, p3, p4)
	local v2 = v1

	for i = v1.Depth, p1.MaxDepth do
		local Position = v2.Position
		local sum = if Position[1] < p2 then 1 else 2

		if p3 <= Position[2] then
			sum = sum + 4
		end

		if Position[3] <= p4 then
			sum = sum + 2
		end

		local SubRegions = v2.SubRegions
		local v3 = SubRegions[sum]

		if not v3 then
			local Size = v2.Size
			local v4 = t[sum]
			local v5 = Size[1]
			local v6 = Size[2]
			local v7 = Size[3]
			local v8 = Position[1] + v4[1] * v5
			local v9 = Position[2] + v4[2] * v6
			local v10 = Position[3] + v4[3] * v7
			local v11 = v5 / 2
			local v12 = v6 / 2
			local v13 = v7 / 2
			local v14 = v11 / 2
			local v15 = v12 / 2
			local v16 = v13 / 2
			local t6 = {
				NodeCount = 0
			}

			t6.Depth = v2 and v2.Depth + 1 or 1
			t6.LowerBounds = { v8 - v14, v9 - v15, v10 - v16 }
			t6.Nodes = {}
			t6.Parent = v2
			t6.ParentIndex = sum
			t6.Position = { v8, v9, v10 }
			t6.Size = { v11, v12, v13 }
			t6.SubRegions = {}
			t6.UpperBounds = { v8 + v14, v9 + v15, v10 + v16 }
			SubRegions[sum] = t6
			v3 = t6
		end

		v2 = v3
	end

	return v2
end

return t2