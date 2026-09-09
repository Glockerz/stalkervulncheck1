-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.connect(p1, p2) --[[ connect | Line: 25 ]]
	assert(if type(p2) == "function" then true else false)
	p1.callbacks[p2] = true

	return {
		disconnect = function() --[[ disconnect | Line: 30 | Upvalues: p1 (copy), p2 (copy) ]]
			p1.callbacks[p2] = nil
		end,
		reconnect = function() --[[ reconnect | Line: 31 | Upvalues: p1 (copy), p2 (copy) ]]
			p1.callbacks[p2] = true
		end
	}
end
function t.fire(p1, ...) --[[ fire | Line: 35 ]]
	for v1 in p1.callbacks do
		v1(...)
	end
end
function t.once(p1, p2) --[[ once | Line: 41 ]]
	local v1 = nil

	v1 = p1:connect(function(...) --[[ Line: 43 | Upvalues: v1 (ref), p2 (copy) ]]
		v1:disconnect()
		p2(...)
	end)

	return v1
end
function t.wait(p1) --[[ wait | Line: 51 ]]
	local v1 = coroutine.running()
	local v2 = p1:connect(function(...) --[[ Line: 54 | Upvalues: v1 (copy) ]]
		coroutine.resume(v1, ...)
	end)
	local t = { coroutine.yield() }

	v2:disconnect()

	return unpack(t)
end

return function() --[[ new_signal | Line: 60 | Upvalues: t (copy) ]]
	local v2 = setmetatable({
		class_name = "Signal",
		callbacks = {}
	}, t)

	return v2, function(...) --[[ fire | Line: 66 | Upvalues: v2 (copy) ]]
		for v1 in v2.callbacks do
			v1(...)
		end
	end
end