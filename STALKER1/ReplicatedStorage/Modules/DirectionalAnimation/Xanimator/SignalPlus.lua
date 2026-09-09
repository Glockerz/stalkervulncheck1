-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function callbackThread(p1, p2) --[[ callbackThread | Line: 4 ]]
	repeat
		p2(coroutine.yield())
	until not p1.Thread
end

local t = {}

t.__index = t
function t.Disconnect(p1) --[[ Line: 14 ]]
	local Thread = p1.Thread

	if not Thread then
		return
	end

	if coroutine.status(Thread) == "suspended" then
		coroutine.close(Thread)
	end

	p1.Thread = nil

	local Signal = p1.Signal
	local v1 = #Signal
	local Index = p1.Index

	if Index ~= v1 then
		local v2 = Signal[v1]

		v2.Index = Index
		Signal[Index] = v2
	end

	Signal[v1] = nil
end

local t2 = {}

t2.__index = t2
function t2.Connect(p1, p2) --[[ Line: 37 | Upvalues: callbackThread (copy), t (copy) ]]
	local t2 = {
		Signal = p1,
		Index = #p1 + 1
	}

	t2.Thread = task.spawn(callbackThread, t2, p2)
	table.insert(p1, t2)

	return setmetatable(t2, t)
end
function t2.Once(p1, p2) --[[ Line: 43 | Upvalues: callbackThread (copy), t (copy) ]]
	local t2 = {
		Signal = p1,
		Index = #p1 + 1
	}

	t2.Thread = task.spawn(callbackThread, t2, function(...) --[[ Line: 45 | Upvalues: t2 (copy), p1 (copy), p2 (copy) ]]
		t2.Thread = nil

		local v1 = #p1
		local Index = t2.Index

		if Index ~= v1 then
			local v2 = p1[v1]

			v2.Index = Index
			p1[Index] = v2
		end

		p1[v1] = nil
		p2(...)
	end)
	table.insert(p1, t2)

	return setmetatable(t2, t)
end
function t2.Wait(p1) --[[ Line: 62 | Upvalues: callbackThread (copy) ]]
	local v1 = coroutine.running()
	local t = {
		Signal = p1,
		Index = #p1 + 1
	}

	t.Thread = task.spawn(callbackThread, t, function(...) --[[ Line: 65 | Upvalues: t (copy), p1 (copy), v1 (copy) ]]
		t.Thread = nil

		local v12 = #p1
		local Index = t.Index

		if Index ~= v12 then
			local v2 = p1[v12]

			v2.Index = Index
			p1[Index] = v2
		end

		p1[v12] = nil

		if coroutine.status(v1) ~= "suspended" then
			return
		end

		local _, v3 = coroutine.resume(v1, ...)

		if not v3 then
			return
		end

		error(v3, 2)
	end)
	table.insert(p1, t)

	return coroutine.yield()
end
function t2.Fire(p1, ...) --[[ Line: 86 ]]
	for i = #p1, 1, -1 do
		local Thread = p1[i].Thread

		if Thread then
			local _, v1 = coroutine.resume(Thread, ...)

			if v1 then
				error(v1, 3)
			end
		end
	end
end
function t2.DisconnectAll(p1) --[[ Line: 95 ]]
	for v1, v2 in p1 do
		local Thread = v2.Thread

		if coroutine.status(Thread) == "suspended" then
			coroutine.close(Thread)
		end

		v2.Thread = nil
	end

	table.clear(p1)
end
function t2.Destroy(p1) --[[ Line: 105 ]]
	for v1, v2 in p1 do
		local Thread = v2.Thread

		if coroutine.status(Thread) == "suspended" then
			coroutine.close(Thread)
		end

		v2.Thread = nil
	end

	table.clear(p1)
	setmetatable(p1, nil)
end

return function() --[[ Line: 117 | Upvalues: t2 (copy) ]]
	return setmetatable({}, t2)
end