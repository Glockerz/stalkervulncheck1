-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.TypeDefinitions)

local TestService = game:GetService("TestService")
local Table = require(script.Parent.Table)
local t = {}

t.__index = t
t.__type = "Signal"

local t2 = {}

t2.__index = t2
t2.__type = "SignalConnection"
function t.new(p1) --[[ new | Line: 44 | Upvalues: t (copy) ]]
	return setmetatable({
		Name = p1,
		Connections = {},
		YieldingThreads = {}
	}, t)
end

local function NewConnection(p1, p2) --[[ NewConnection | Line: 53 | Upvalues: t2 (copy) ]]
	return setmetatable({
		Index = -1,
		Signal = p1,
		Delegate = p2
	}, t2)
end

local function ThreadAndReportError(p1, p2, p3) --[[ ThreadAndReportError | Line: 62 | Upvalues: TestService (copy) ]]
	local v1 = coroutine.create(function() --[[ Line: 63 | Upvalues: p1 (copy), p2 (copy) ]]
		p1(unpack(p2))
	end)
	local v2, v3 = coroutine.resume(v1)

	if v2 then
		return
	end

	TestService:Error(string.format("Exception thrown in your %s event handler: %s", p3, v3))
	TestService:Checkpoint(debug.traceback(v1))
end

function t.Connect(p1, p2) --[[ Connect | Line: 75 | Upvalues: t (copy), t2 (copy), Table (copy) ]]
	assert(if getmetatable(p1) == t then true else false, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Connect", "Signal.new()"))

	local v3 = setmetatable({
		Index = -1,
		Signal = p1,
		Delegate = p2
	}, t2)

	v3.Index = #p1.Connections + 1
	Table.insert(p1.Connections, v3.Index, v3)

	return v3
end
function t.Fire(p1, ...) --[[ Fire | Line: 83 | Upvalues: t (copy), Table (copy), ThreadAndReportError (copy) ]]
	assert(getmetatable(p1) == t, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Fire", "Signal.new()"))

	local v2 = Table.pack(...)
	local Connections = p1.Connections
	local YieldingThreads = p1.YieldingThreads

	for i = 1, #Connections do
		local v3 = Connections[i]

		if v3.Delegate ~= nil then
			ThreadAndReportError(v3.Delegate, v2, v3.Signal.Name)
		end
	end

	for j = 1, #YieldingThreads do
		local v4 = YieldingThreads[j]

		if v4 ~= nil then
			coroutine.resume(v4, ...)
		end
	end
end
function t.FireSync(p1, ...) --[[ FireSync | Line: 103 | Upvalues: t (copy), Table (copy) ]]
	assert(getmetatable(p1) == t, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("FireSync", "Signal.new()"))

	local v2 = Table.pack(...)
	local Connections = p1.Connections
	local YieldingThreads = p1.YieldingThreads

	for i = 1, #Connections do
		local v3 = Connections[i]

		if v3.Delegate ~= nil then
			v3.Delegate(unpack(v2))
		end
	end

	for j = 1, #YieldingThreads do
		local v4 = YieldingThreads[j]

		if v4 ~= nil then
			coroutine.resume(v4, ...)
		end
	end
end
function t.Wait(p1) --[[ Wait | Line: 123 | Upvalues: t (copy), Table (copy) ]]
	assert(getmetatable(p1) == t, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Wait", "Signal.new()"))

	local v2 = coroutine.running()

	Table.insert(p1.YieldingThreads, v2)

	local t2 = { coroutine.yield() }

	Table.removeObject(p1.YieldingThreads, v2)

	return unpack(t2)
end
function t.Dispose(p1) --[[ Dispose | Line: 133 | Upvalues: t (copy) ]]
	assert(getmetatable(p1) == t, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Dispose", "Signal.new()"))

	local Connections = p1.Connections

	for i = 1, #Connections do
		Connections[i]:Disconnect()
	end

	p1.Connections = {}
	setmetatable(p1, nil)
end
function t2.Disconnect(p1) --[[ Disconnect | Line: 143 | Upvalues: t2 (copy), Table (copy) ]]
	assert(getmetatable(p1) == t2, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Disconnect", "private function NewConnection()"))
	Table.remove(p1.Signal.Connections, p1.Index)
	p1.SignalStatic = nil
	p1.Delegate = nil
	p1.YieldingThreads = {}
	p1.Index = -1
	setmetatable(p1, nil)
end

return t