-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local DependencyGraph = require(script.Parent.DependencyGraph)
local Pipeline = require(script.Parent.Pipeline)
local Phase = require(script.Parent.Phase)
local utils = require(script.Parent.utils)
local hooks = require(script.Parent.hooks)
local conditions = require(script.Parent.conditions)
local getSystem = utils.getSystem
local getSystemName = utils.getSystemName
local isPhase = utils.isPhase
local isPipeline = utils.isPipeline
local isValidEvent = utils.isValidEvent
local getEventIdentifier = utils.getEventIdentifier
local t = {}
local v1 = os.clock()
local t2 = {}

t2.__index = t2
t2.Hooks = hooks.Hooks
function t2.addPlugin(p1, p2) --[[ addPlugin | Line: 51 ]]
	p2:build(p1)
	table.insert(p1._plugins, p2)

	return p1
end
function t2._addHook(p1, p2, p3) --[[ _addHook | Line: 57 ]]
	assert(p1._hooks[p2], (("Unknown Hook: %*"):format(p2)))
	table.insert(p1._hooks[p2], p3)
end
function t2.getDeltaTime(p1) --[[ getDeltaTime | Line: 68 ]]
	local v1 = debug.info(2, "f")

	if not (v1 and p1._systemInfo[v1]) then
		error("Scheduler:getDeltaTime() must be used within a registered system")
	end

	return p1._systemInfo[v1].deltaTime or 0
end
function t2._handleLogs(p1, p2) --[[ _handleLogs | Line: 80 ]]
	if not p2.timeLastLogged then
		p2.timeLastLogged = os.clock()
	end

	if not p2.recentLogs then
		p2.recentLogs = {}
	end

	if os.clock() - p2.timeLastLogged > 10 then
		p2.timeLastLogged = os.clock()
		p2.recentLogs = {}
	end

	local v1 = debug.info(p2.system, "n")

	for v2, v3 in p2.logs do
		if not p2.recentLogs[v3] then
			task.spawn(error, v3, 0)
			warn((("Planck: Error occurred in system%*, this error will be ignored for 10 seconds"):format(string.len(v1) > 0 and (" \'%*\'"):format(v1) or "")))
			p2.recentLogs[v3] = true
		end
	end

	table.clear(p2.logs)
end
function t2.runSystem(p1, p2) --[[ runSystem | Line: 109 | Upvalues: hooks (copy), v1 (ref), t (ref) ]]
	if p1:_canRun(p2) == false then
		return
	end

	local v12 = p1._systemInfo[p2]
	local v2 = os.clock()

	v12.deltaTime = v2 - (v12.lastTime or v2)
	v12.lastTime = v2

	if not p1._thread then
		p1._thread = coroutine.create(function() --[[ Line: 121 | Upvalues: p1 (copy) ]]
			while true do
				local v1 = coroutine.yield()

				p1._yielded = true
				v1()
				p1._yielded = false
			end
		end)
		coroutine.resume(p1._thread)
	end

	local v3 = false

	local function systemCall() --[[ systemCall | Line: 135 | Upvalues: p1 (copy), p2 (copy), v3 (ref), v12 (copy), hooks (ref) ]]
		local function noYield() --[[ noYield | Line: 136 | Upvalues: p1 (ref), p2 (ref), v3 (ref), v12 (ref), hooks (ref) ]]
			local v1 = nil
			local v2 = nil

			coroutine.resume(p1._thread, function() --[[ Line: 138 | Upvalues: v1 (ref), v2 (ref), p2 (ref), p1 (ref) ]]
				local v3, v4 = xpcall(p2, function(p1) --[[ Line: 139 ]]
					return debug.traceback(p1)
				end, table.unpack(p1._vargs))

				v1 = v3
				v2 = v4
			end)

			if v1 == false then
				v3 = true
				table.insert(v12.logs, v2)
				hooks.systemError(p1, v12, v2)
			elseif p1._yielded then
				v3 = true

				local v4, v5 = debug.info(p1._thread, 1, "sl")
				local v6 = ("%*:%*: System yielded"):format(v4, v5)

				table.insert(v12.logs, debug.traceback(p1._thread, v6, 2))
				hooks.systemError(p1, v12, debug.traceback(p1._thread, v6, 2))
			end
		end

		hooks.systemCall(p1, "SystemCall", v12, noYield)
	end

	local function inner() --[[ inner | Line: 170 | Upvalues: hooks (ref), p1 (copy), v12 (copy), systemCall (copy) ]]
		hooks.systemCall(p1, "InnerSystemCall", v12, systemCall)
	end

	local function outer() --[[ outer | Line: 174 | Upvalues: hooks (ref), p1 (copy), v12 (copy), inner (copy) ]]
		hooks.systemCall(p1, "OuterSystemCall", v12, inner)
	end

	if os.clock() - v1 > 10 then
		v1 = os.clock()
		t = {}
	end

	local ok, result = pcall(outer)

	if not (ok or t[result]) then
		task.spawn(error, result, 0)
		warn("Planck: Error occurred while running hooks, this error will be ignored for 10 seconds")
		hooks.systemError(p1, v12, (("Error occurred while running hooks: %*"):format(result)))
		t[result] = true
	end

	if v3 then
		coroutine.close(p1._thread)
		p1._thread = coroutine.create(function() --[[ Line: 200 | Upvalues: p1 (copy) ]]
			while true do
				local v1 = coroutine.yield()

				p1._yielded = true
				v1()
				p1._yielded = false
			end
		end)
		coroutine.resume(p1._thread)
	end

	p1:_handleLogs(v12)
end
function t2.runPhase(p1, p2) --[[ runPhase | Line: 215 | Upvalues: hooks (copy) ]]
	if p1:_canRun(p2) == false then
		return
	end

	hooks.phaseBegan(p1, p2)

	if not p1._phaseToSystems[p2] then
		p1._phaseToSystems[p2] = {}
	end

	for v1, v2 in p1._phaseToSystems[p2] do
		p1:runSystem(v2)
	end
end
function t2.runPipeline(p1, p2) --[[ runPipeline | Line: 231 ]]
	if p1:_canRun(p2) == false then
		return
	end

	local v1 = p2.dependencyGraph:getOrderedList()

	assert(v1, (("Pipeline %* contains a circular dependency, check it\'s Phases"):format(p2)))

	for v3, v4 in v1 do
		p1:runPhase(v4)
	end
end
function t2._canRun(p1, p2) --[[ _canRun | Line: 247 ]]
	local v1 = p1._runIfConditions[p2]

	if not v1 then
		return true
	end

	for v2, v3 in v1 do
		if v3(table.unpack(p1._vargs)) == false then
			return false
		end
	end

	return true
end
function t2.run(p1, p2) --[[ run | Line: 282 | Upvalues: Pipeline (copy), getSystem (copy), isPhase (copy), isPipeline (copy) ]]
	if not p2 then
		error("No dependent specified in Scheduler:run(_)")
	end

	p1:runPipeline(Pipeline.Startup)

	if getSystem(p2) then
		p1:runSystem(p2)

		return p1
	end

	if isPhase(p2) then
		p1:runPhase(p2)

		return p1
	end

	if isPipeline(p2) then
		p1:runPipeline(p2)
	else
		error("Unknown dependent passed into Scheduler:run(unknown)")
	end

	return p1
end
function t2.runAll(p1) --[[ runAll | Line: 320 ]]
	local v1 = p1._defaultDependencyGraph:getOrderedList()

	assert(v1, "Default Group contains a circular dependency, check your Pipelines/Phases")

	for v2, v3 in v1 do
		p1:run(v3)
	end

	for v4, v5 in p1._eventDependencyGraphs do
		local v6 = v5:getOrderedList()

		assert(v1, (("Event Group \'%*\' contains a circular dependency, check your Pipelines/Phases"):format(v4)))

		for v8, v9 in v6 do
			p1:run(v9)
		end
	end

	return p1
end
function t2.insert(p1, p2, p3, p4) --[[ insert | Line: 395 | Upvalues: isPhase (copy), isPipeline (copy), isValidEvent (copy), hooks (copy) ]]
	assert(isPhase(p2) or isPipeline(p2), "Unknown dependency passed to Scheduler:insert(unknown, _, _)")

	if p3 then
		assert(isValidEvent(p3, p4), "Unknown instance/event passed to Scheduler:insert(_, instance, event)")
		p1:_getEventDependencyGraph(p3, p4):insert(p2)
	else
		p1._defaultDependencyGraph:insertBefore(p2, p1._defaultPhase)
	end

	if isPhase(p2) then
		p1._phaseToSystems[p2] = {}
		hooks.phaseAdd(p1, p2)
	end

	return p1
end
function t2.insertAfter(p1, p2, p3) --[[ insertAfter | Line: 441 | Upvalues: isPhase (copy), isPipeline (copy), hooks (copy) ]]
	assert(isPhase(p3) or isPipeline(p3), "Unknown dependency passed in Scheduler:insertAfter(_, unknown)")
	assert(isPhase(p2) or isPipeline(p2), "Unknown dependent passed in Scheduler:insertAfter(unknown, _)")
	p1:_getGraphOfDependency(p3):insertAfter(p2, p3)

	if isPhase(p2) then
		p1._phaseToSystems[p2] = {}
		hooks.phaseAdd(p1, p2)
	end

	return p1
end
function t2.insertBefore(p1, p2, p3) --[[ insertBefore | Line: 481 | Upvalues: isPhase (copy), isPipeline (copy), hooks (copy) ]]
	assert(isPhase(p3) or isPipeline(p3), "Unknown dependency passed in Scheduler:insertBefore(_, unknown)")
	assert(isPhase(p2) or isPipeline(p2), "Unknown dependent passed in Scheduler:insertBefore(unknown, _)")
	p1:_getGraphOfDependency(p3):insertBefore(p2, p3)

	if isPhase(p2) then
		p1._phaseToSystems[p2] = {}
		hooks.phaseAdd(p1, p2)
	end

	return p1
end
function t2.addSystem(p1, p2, p3) --[[ addSystem | Line: 509 | Upvalues: getSystem (copy), getSystemName (copy), hooks (copy) ]]
	local v1 = getSystem(p2)

	if not v1 then
		error("Unknown system passed to Scheduler:addSystem(unknown, phase?)")
	end

	local v2 = getSystemName(v1)

	if type(p2) == "table" and p2.name then
		v2 = p2.name
	end

	local t = {
		system = v1,
		phase = p3,
		name = v2,
		logs = {}
	}

	if not p3 and (type(p2) == "table" and p2.phase) then
		t.phase = p2.phase
	elseif not p3 then
		t.phase = p1._defaultPhase
	end

	p1._systemInfo[v1] = t

	if not p1._phaseToSystems[t.phase] then
		p1._phaseToSystems[t.phase] = {}
	end

	table.insert(p1._phaseToSystems[t.phase], v1)
	hooks.systemAdd(p1, t)

	if type(p2) == "table" and p2.runConditions then
		for v4, v5 in p2.runConditions do
			p1:addRunCondition(v1, v5)
		end
	end

	return p1
end
function t2.addSystems(p1, p2, p3) --[[ addSystems | Line: 562 | Upvalues: getSystem (copy) ]]
	if type(p2) ~= "table" then
		error("Unknown systems passed to Scheduler:addSystems(unknown, phase?)")
	end

	local count = 0
	local v1 = false

	for v2, v3 in p2 do
		count = count + 1

		if getSystem(v3) then
			p1:addSystem(v3, p3)
			v1 = true
		end
	end

	if count == 0 then
		error("Empty table passed to Scheduler:addSystems({ }, phase?)")
	end

	if v1 then
		return p1
	end

	error("Unknown table passed to Scheduler:addSystems({ unknown }, phase?)")
end
function t2.editSystem(p1, p2, p3) --[[ editSystem | Line: 597 | Upvalues: getSystem (copy) ]]
	local v1 = getSystem(p2)
	local v2 = p1._systemInfo[v1]

	assert(v2, "Attempt to remove a non-exist system in Scheduler:removeSystem(_)")

	local _ = p3 and p1._phaseToSystems[p3] ~= nil

	assert(true, "Phase never initialized before using Scheduler:editSystem(_, Phase)")

	local v4 = p1._phaseToSystems[v2.phase]
	local v5 = table.find(v4, v1)

	assert(v5, "Unable to find system within phase")
	table.remove(v4, v5)

	if not p1._phaseToSystems[p3] then
		p1._phaseToSystems[p3] = {}
	end

	table.insert(p1._phaseToSystems[p3], v1)
	v2.phase = p3

	return p1
end
function t2._removeCondition(p1, p2, p3) --[[ _removeCondition | Line: 626 | Upvalues: conditions (copy) ]]
	p1._runIfConditions[p2] = nil

	for v1, v2 in p1._runIfConditions do
		if table.find(v2, p3) then
			return
		end
	end

	conditions.cleanupCondition(p3)
end
function t2.removeSystem(p1, p2) --[[ removeSystem | Line: 643 | Upvalues: getSystem (copy), hooks (copy) ]]
	local v1 = getSystem(p2)
	local v2 = p1._systemInfo[v1]

	assert(v2, "Attempt to remove a non-exist system in Scheduler:removeSystem(_)")

	local v3 = p1._phaseToSystems[v2.phase]
	local v4 = table.find(v3, v1)

	assert(v4, "Unable to find system within phase")
	table.remove(v3, v4)
	p1._systemInfo[v1] = nil

	if p1._runIfConditions[p2] then
		for v5, v6 in p1._runIfConditions[p2] do
			p1:_removeCondition(p2, v6)
		end

		p1._runIfConditions[p2] = nil
	end

	hooks.systemRemove(p1, v2)

	return p1
end
function t2.replaceSystem(p1, p2, p3) --[[ replaceSystem | Line: 678 | Upvalues: getSystem (copy), getSystemName (copy), hooks (copy) ]]
	local v1 = getSystem(p2)
	local v2 = p1._systemInfo[v1]

	assert(v2, "Attempt to replace a non-existent system in Scheduler:replaceSystem(unknown, _)")

	local v3 = getSystem(p3)

	assert(v3, "Attempt to pass non-system in Scheduler:replaceSystem(_, unknown)")

	local v4 = p1._phaseToSystems[v2.phase]
	local v5 = table.find(v4, v1)

	assert(v5, "Unable to find system within phase")
	table.remove(v4, v5)
	table.insert(v4, v5, v3)

	local v6 = table.clone(v2)

	v2.system = v3
	v2.name = getSystemName(v3)
	hooks.systemReplace(p1, v6, v2)
	p1._systemInfo[v3] = p1._systemInfo[v1]
	p1._systemInfo[v1] = nil

	return p1
end
function t2.addRunCondition(p1, p2, p3) --[[ addRunCondition | Line: 737 | Upvalues: getSystem (copy), isPhase (copy), isPipeline (copy) ]]
	local v1 = getSystem(p2)

	if v1 then
		p2 = v1
	end

	assert(if v1 then v1 else isPhase(p2) or isPipeline(p2), "Attempt to pass unknown dependent into Scheduler:addRunCondition(unknown, _)")

	if not p1._runIfConditions[p2] then
		p1._runIfConditions[p2] = {}
	end

	table.insert(p1._runIfConditions[p2], p3)

	return p1
end
function t2._addBuiltins(p1) --[[ _addBuiltins | Line: 757 | Upvalues: Phase (copy), DependencyGraph (copy), Pipeline (copy), conditions (copy) ]]
	p1._defaultPhase = Phase.new("Default")
	p1._defaultDependencyGraph = DependencyGraph.new()
	p1._defaultDependencyGraph:insert(Pipeline.Startup)
	p1._defaultDependencyGraph:insert(p1._defaultPhase)
	p1:addRunCondition(Pipeline.Startup, conditions.runOnce())

	for v1, v2 in Pipeline.Startup.dependencyGraph.nodes do
		p1:addRunCondition(v2, conditions.runOnce())
	end
end
function t2._scheduleEvent(p1, p2, p3) --[[ _scheduleEvent | Line: 770 | Upvalues: utils (copy), getEventIdentifier (copy), DependencyGraph (copy), t (ref) ]]
	local v1 = utils.getConnectFunction(p2, p3)

	assert(v1, "Couldn\'t connect to event as no valid connect methods were found! Ensure the passed event has a \'Connect\' or an \'on\' method!")

	local v2 = getEventIdentifier(p2, p3)
	local v3 = DependencyGraph.new()

	local function f4() --[[ Line: 781 | Upvalues: v3 (copy), v2 (copy), t (ref), p1 (copy) ]]
		local v1 = v3:getOrderedList()

		if v1 == nil then
			local v22 = ("Event Group \'%*\' contains a circular dependency, check your Pipelines/Phases"):format(v2)

			if not t[v22] then
				task.spawn(error, v22, 0)
				warn("Planck: Error occurred while running event, this error will be ignored for 10 seconds")
				t[v22] = true
			end
		end

		for v32, v4 in v1 do
			p1:run(v4)
		end
	end

	p1._connectedEvents[v2] = v1(f4)
	p1._eventDependencyGraphs[v2] = v3
end
function t2._getEventDependencyGraph(p1, p2, p3) --[[ _getEventDependencyGraph | Line: 805 | Upvalues: getEventIdentifier (copy) ]]
	local v1 = getEventIdentifier(p2, p3)

	if not p1._connectedEvents[v1] then
		p1:_scheduleEvent(p2, p3)
	end

	return p1._eventDependencyGraphs[v1]
end
function t2._getGraphOfDependency(p1, p2) --[[ _getGraphOfDependency | Line: 815 ]]
	if table.find(p1._defaultDependencyGraph.nodes, p2) then
		return p1._defaultDependencyGraph
	end

	for v1, v2 in p1._eventDependencyGraphs do
		if table.find(v2.nodes, p2) then
			return v2
		end
	end

	error("Dependency does not belong to a DependencyGraph")
end
function t2.cleanup(p1) --[[ cleanup | Line: 848 | Upvalues: utils (copy), conditions (copy) ]]
	for v1, v2 in p1._connectedEvents do
		utils.disconnectEvent(v2)
	end

	for v3, v4 in p1._plugins do
		if v4.cleanup then
			v4:cleanup()
		end
	end

	if p1._thread then
		coroutine.close(p1._thread)
	end

	for v5, v6 in p1._runIfConditions do
		for v7, v8 in v6 do
			conditions.cleanupCondition(v8)
		end
	end
end
function t2.new(...) --[[ new | Line: 876 | Upvalues: t2 (copy), hooks (copy) ]]
	local t = {
		_hooks = {},
		_vargs = { ... },
		_eventDependencyGraphs = {},
		_connectedEvents = {},
		_phaseToSystems = {},
		_systemInfo = {},
		_runIfConditions = {},
		_plugins = {}
	}

	setmetatable(t, t2)

	for v2, v3 in hooks.Hooks do
		if not t._hooks[v3] then
			t._hooks[v3] = {}
		end
	end

	t:_addBuiltins()

	return t
end

return t2