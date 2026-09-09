-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.__tostring(p1) --[[ __tostring | Line: 16 ]]
	local v1 = "\n"

	for i = 1, p1.length do
		if i == 1 then
			v1 = v1 .. "\n"
		end

		local v2 = ""

		for j = 1, p1.width do
			v2 = if j == p1.width then v2 .. ("%*"):format(p1.matrix[i][j]) else v2 .. ("%*, "):format(p1.matrix[i][j])
		end

		v1 = v1 .. v2 .. "\n"
	end

	return v1
end
function t.extend(p1) --[[ extend | Line: 41 ]]
	p1.length = p1.length + 1
	p1.width = p1.length + 1
	p1.matrix[p1.length] = {}

	for i = 1, p1.width do
		p1.matrix[p1.length][i] = 0
	end

	for j = 1, p1.length do
		p1.matrix[j][p1.width] = 0
	end
end
function t.setEdge(p1, p2, p3, p4) --[[ setEdge | Line: 55 ]]
	p1.matrix[p2][p3] = p4
end
function t.toAdjacencyList(p1) --[[ toAdjacencyList | Line: 59 ]]
	local t = {}

	for i = 1, p1.length do
		t[i] = {}

		for j = 1, p1.width do
			if p1.matrix[i][j] ~= 0 then
				table.insert(t[i], j)
			end
		end
	end

	return t
end
function t.topologicalSort(p1) --[[ topologicalSort | Line: 74 ]]
	local v1 = p1:toAdjacencyList()
	local v2 = table.create(p1.length, 0)
	local t = {}

	for i = 1, p1.length do
		for v3, v4 in v1[i] do
			v2[v4] = v2[v4] + 1
		end
	end

	local t2 = {}

	for j = 1, p1.length do
		if v2[j] == 0 then
			table.insert(t2, j)
		end
	end

	while #t2 ~= 0 do
		local v5 = table.remove(t2, 1)

		table.insert(t, v5)

		for v6, v7 in v1[v5] do
			v2[v7] = v2[v7] - 1

			if v2[v7] == 0 then
				table.insert(t2, v7)
			end
		end
	end

	if #t == p1.length then
		return t
	end

	return nil
end
function t.new() --[[ new | Line: 112 | Upvalues: t (copy) ]]
	return setmetatable({
		length = 0,
		width = 0,
		matrix = {}
	}, t)
end

local t2 = {}

t2.__index = t2
function t2.getOrderedList(p1) --[[ getOrderedList | Line: 144 ]]
	local t = {}
	local v1 = p1.matrix:topologicalSort()

	if not v1 then
		return nil
	end

	for v2, v3 in v1 do
		table.insert(t, p1.nodes[v3])
	end

	return t
end
function t2.insertBefore(p1, p2, p3) --[[ insertBefore | Line: 159 ]]
	if not table.find(p1.nodes, p3) then
		error("Node not found in DependencyGraph:insertBefore(_, unknown)")
	end

	local v1 = table.find(p1.nodes, p2)

	if not v1 then
		table.insert(p1.nodes, p2)
		v1 = #p1.nodes
	end

	local v2 = table.find(p1.nodes, p3)

	p1.matrix:extend()
	p1.matrix:setEdge(v1, v2, 1)

	return p1
end
function t2.insertAfter(p1, p2, p3) --[[ insertAfter | Line: 178 ]]
	if not table.find(p1.nodes, p3) then
		error("Node not found in DependencyGraph:insertAfter(_, unknown)")
	end

	local v1 = table.find(p1.nodes, p2)

	if not v1 then
		table.insert(p1.nodes, p2)
		v1 = #p1.nodes
	end

	local v2 = table.find(p1.nodes, p3)

	p1.matrix:extend()
	p1.matrix:setEdge(v2, v1, 1)

	return p1
end
function t2.insert(p1, p2) --[[ insert | Line: 197 ]]
	local v1 = #p1.nodes

	table.insert(p1.nodes, p2)

	local v2 = #p1.nodes

	p1.matrix:extend()

	if v1 ~= 0 then
		p1.matrix:setEdge(v1, v2, 1)
	end

	return p1
end
function t2.new() --[[ new | Line: 211 | Upvalues: t (copy), t2 (copy) ]]
	return setmetatable({
		length = 0,
		width = 0,
		nodes = {},
		matrix = t.new()
	}, t2)
end

return t2