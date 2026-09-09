-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent.Parent.Parent:WaitForChild("shared")).console
local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 47 | Upvalues: t (copy) ]]
	return setmetatable({
		_status = "Disabled",
		_isResuming = false,
		_suspendedEventQueue = {},
		_connections = {},
		_listeners = {},
		_instance = p1
	}, t)
end
function t.connectEvent(p1, p2, p3) --[[ connectEvent | Line: 75 ]]
	p1:_connect(p2, p1._instance[p2], p3)
end
function t.connectPropertyChange(p1, p2, p3) --[[ connectPropertyChange | Line: 79 ]]
	local ok, result = pcall(p1._instance.GetPropertyChangedSignal, p1._instance, p2)

	if not ok then
		error(string.format("Cannot get changed signal on property %q: %s", tostring(p2), result), 0)
	end

	p1:_connect("Change." .. p2, result, p3)
end
function t._connect(p1, p2, p3, p4) --[[ _connect | Line: 97 ]]
	if p4 == nil then
		if p1._connections[p2] ~= nil then
			p1._connections[p2]:Disconnect()
			p1._connections[p2] = nil
		end

		p1._listeners[p2] = nil
	else
		if p1._connections[p2] == nil then
			p1._connections[p2] = p3:Connect(function(...) --[[ Line: 108 | Upvalues: p1 (copy), p2 (copy) ]]
				if p1._status == "Enabled" then
					p1._listeners[p2](p1._instance, ...)

					return
				end

				if p1._status ~= "Suspended" then
					return
				end

				local v1 = select("#", ...)

				table.insert(p1._suspendedEventQueue, { p2, v1, ... })
			end)
		end

		p1._listeners[p2] = p4
	end
end
function t.suspend(p1) --[[ suspend | Line: 128 ]]
	p1._status = "Suspended"
end
function t.resume(p1) --[[ resume | Line: 132 | Upvalues: console (copy) ]]
	if p1._isResuming then
		return
	end

	p1._isResuming = true

	for v1, v2 in p1._suspendedEventQueue do
		local v3 = p1._listeners[v2[1]]
		local v4 = v2[2]

		if v3 ~= nil then
			local v6, v7 = coroutine.resume(coroutine.create(v3), p1._instance, unpack(v2, 3, 2 + v4))

			if not v6 then
				console.warn("%s", v7)
			end
		end
	end

	p1._isResuming = false
	p1._status = "Enabled"
	table.clear(p1._suspendedEventQueue)
end

return t