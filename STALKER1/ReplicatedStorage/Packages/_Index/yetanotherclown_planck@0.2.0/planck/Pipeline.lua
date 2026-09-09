-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local DependencyGraph = require(script.Parent.DependencyGraph)
local Phase = require(script.Parent.Phase)
local t = {}

t.__index = t
function t.__tostring(p1) --[[ __tostring | Line: 13 ]]
	return p1._name
end
function t.insert(p1, p2) --[[ insert | Line: 23 ]]
	p1.dependencyGraph:insert(p2)

	return p1
end
function t.insertAfter(p1, p2, p3) --[[ insertAfter | Line: 35 ]]
	assert(table.find(p1.dependencyGraph.nodes, p3), "Unknown Phase in Pipeline:insertAfter(_, unknown), try adding this Phase to the Pipeline.")
	p1.dependencyGraph:insertAfter(p2, p3)

	return p1
end
function t.insertBefore(p1, p2, p3) --[[ insertBefore | Line: 53 ]]
	assert(table.find(p1.dependencyGraph.nodes, p3), "Unknown Phase in Pipeline:insertBefore(_, unknown), try adding this Phase to the Pipeline.")
	p1.dependencyGraph:insertBefore(p2, p3)

	return p1
end
function t.new(p1) --[[ new | Line: 68 | Upvalues: DependencyGraph (copy), t (copy) ]]
	local v1 = if p1 then p1 else debug.info(2, "sl")

	return setmetatable({
		_type = "pipeline",
		_name = v1,
		dependencyGraph = DependencyGraph.new()
	}, t)
end
t.Startup = t.new():insert(Phase.PreStartup):insert(Phase.Startup):insert(Phase.PostStartup)

return t