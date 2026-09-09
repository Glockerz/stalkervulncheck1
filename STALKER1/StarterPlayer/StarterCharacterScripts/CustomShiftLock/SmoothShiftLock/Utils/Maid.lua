-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	ClassName = "Maid"
}

function t.new() --[[ new | Line: 37 | Upvalues: t (copy) ]]
	return setmetatable({
		_tasks = {}
	}, t)
end
function t.isMaid(p1) --[[ isMaid | Line: 54 ]]
	return if type(p1) == "table" then p1.ClassName == "Maid" else false
end
function t.__index(p1, p2) --[[ __index | Line: 73 | Upvalues: t (copy) ]]
	if t[p2] then
		return t[p2]
	end

	return p1._tasks[p2]
end
function t.__newindex(p1, p2, p3) --[[ __newindex | Line: 100 | Upvalues: t (copy) ]]
	if t[p2] ~= nil then
		error(("Cannot use \'%s\' as a Maid key"):format((tostring(p2))), 2)
	end

	local _tasks = p1._tasks
	local v1 = _tasks[p2]

	if v1 == p3 then
		return
	end

	_tasks[p2] = p3

	if not v1 then
		return
	end

	if type(v1) == "function" then
		v1()

		return
	end

	if type(v1) == "thread" then
		task.cancel(v1)

		return
	end

	if typeof(v1) == "RBXScriptConnection" then
		v1:Disconnect()

		return
	end

	if not v1.Destroy then
		return
	end

	v1:Destroy()
end
function t.GiveTask(p1, p2) --[[ GiveTask | Line: 133 ]]
	if not p2 then
		error("Task cannot be false or nil", 2)
	end

	local v1 = #p1._tasks + 1

	p1[v1] = p2

	if type(p2) ~= "table" or p2.Destroy then
		return v1
	end

	warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback())

	return v1
end
function t.GivePromise(p1, p2) --[[ GivePromise | Line: 154 ]]
	if p2:IsPending() then
		local v1 = p2.resolved(p2)
		local v2 = p1:GiveTask(v1)

		v1:Finally(function() --[[ Line: 163 | Upvalues: p1 (copy), v2 (copy) ]]
			p1[v2] = nil
		end)

		return v1
	end

	return p2
end
function t.DoCleaning(p1) --[[ DoCleaning | Line: 186 ]]
	local _tasks = p1._tasks

	for k, v in pairs(_tasks) do
		if typeof(v) == "RBXScriptConnection" then
			_tasks[k] = nil
			v:Disconnect()
		end
	end

	local v1, v2 = next(_tasks)

	while v2 ~= nil do
		_tasks[v1] = nil

		if type(v2) == "function" then
			v2()
		elseif type(v2) == "thread" then
			task.cancel(v2)
		elseif typeof(v2) == "RBXScriptConnection" then
			v2:Disconnect()
		elseif v2.Destroy then
			v2:Destroy()
		end

		local v3, v4 = next(_tasks)

		v2, v1 = v4, v3
	end
end
t.Destroy = t.DoCleaning

return t