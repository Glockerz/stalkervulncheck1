-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Set = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Set
local t = {}
local enableSchedulerTracing = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableSchedulerTracing
local v1 = 0
local v2 = 0
local v3, v4

if enableSchedulerTracing then
	v3 = {
		current = Set.new()
	}
	v4 = {
		current = nil
	}
else
	v3 = nil
	v4 = nil
end

t.__interactionsRef = v3
t.__subscriberRef = v4
function t.unstable_clear(p1) --[[ Line: 91 | Upvalues: enableSchedulerTracing (copy), v3 (ref), Set (copy) ]]
	if not enableSchedulerTracing then
		return p1()
	end

	local current = v3.current

	v3.current = Set.new()

	local ok, result = pcall(p1)

	v3.current = current

	if not ok then
		error(result)
	end

	return result
end
function t.unstable_getCurrent() --[[ Line: 111 | Upvalues: enableSchedulerTracing (copy), v3 (ref) ]]
	if enableSchedulerTracing then
		return v3.current
	end

	return nil
end
function t.unstable_getThreadID() --[[ Line: 119 | Upvalues: v2 (ref) ]]
	v2 = v2 + 1

	return v2
end
function t.unstable_trace(p1, p2, p3, p4) --[[ Line: 125 | Upvalues: enableSchedulerTracing (copy), v1 (ref), v3 (ref), Set (copy), v4 (ref) ]]
	local v12 = if p4 == nil then 0 else p4

	if not enableSchedulerTracing then
		return p3()
	end

	local t = {
		__count = 1,
		id = v1,
		name = p1,
		timestamp = p2
	}

	v1 = v1 + 1

	local current = v3.current
	local v2 = Set.new(current)

	v2:add(t)
	v3.current = v2

	local current2 = v4.current
	local v32 = nil
	local ok, result = pcall(function() --[[ Line: 154 | Upvalues: current2 (copy), t (copy) ]]
		if current2 == nil then
			return
		end

		current2.onInteractionTraced(t)
	end)
	local ok2, result2 = pcall(function() --[[ Line: 161 | Upvalues: current2 (copy), v2 (copy), v12 (copy) ]]
		if current2 == nil then
			return
		end

		current2.onWorkStarted(v2, v12)
	end)
	local ok3, result3 = pcall(function() --[[ Line: 169 | Upvalues: v32 (ref), p3 (copy) ]]
		v32 = p3()
	end)

	v3.current = current

	local ok4, result4 = pcall(function() --[[ Line: 175 | Upvalues: current2 (copy), v2 (copy), v12 (copy) ]]
		if current2 == nil then
			return
		end

		current2.onWorkStopped(v2, v12)
	end)

	t.__count = t.__count - 1

	if current2 ~= nil and t.__count == 0 then
		current2.onInteractionScheduledWorkCompleted(t)
	end

	if not ok4 then
		error(result4)
	end

	if not ok3 then
		error(result3)
	end

	if not ok2 then
		error(result2)
	end

	if ok then
		return v32
	end

	error(result)
end
function t.unstable_wrap(p1, p2) --[[ Line: 208 | Upvalues: enableSchedulerTracing (copy), v3 (ref), v4 (ref) ]]
	if p2 == nil then
		p2 = 0
	end

	if not enableSchedulerTracing then
		return p1
	end

	local current = v3.current
	local current2 = v4.current

	if current2 ~= nil then
		current2.onWorkScheduled(current, p2)
	end

	for v1, v2 in current do
		v2.__count = v2.__count + 1
	end

	local v32 = false

	local function f4() --[[ Line: 301 | Upvalues: current2 (ref), v4 (ref), current (copy), p2 (ref) ]]
		current2 = v4.current

		local ok, result = pcall(function() --[[ Line: 304 | Upvalues: current2 (ref), current (ref), p2 (ref) ]]
			if current2 == nil then
				return
			end

			current2.onWorkCanceled(current, p2)
		end)

		for v1, v2 in current do
			v2.__count = v2.__count - 1

			if current2 ~= nil and v2.__count == 0 then
				current2.onInteractionScheduledWorkCompleted(v2)
			end
		end

		if ok then
			return
		end

		error(result)
	end

	local t = {}
	local t2 = {
		__call = function(p12, ...) --[[ _wrapped | Line: 236 | Upvalues: v3 (ref), current (copy), current2 (ref), v4 (ref), p2 (ref), p1 (copy), v32 (ref) ]]
			local current3 = v3.current

			v3.current = current
			current2 = v4.current

			local ok, result = pcall(function(...) --[[ Line: 243 | Upvalues: current2 (ref), current (ref), p2 (ref), p1 (ref), v3 (ref), current3 (copy) ]]
				local v1 = nil
				local ok, result = pcall(function() --[[ Line: 247 | Upvalues: current2 (ref), current (ref), p2 (ref) ]]
					if current2 == nil then
						return
					end

					current2.onWorkStarted(current, p2)
				end)
				local ok2, result2 = pcall(function(...) --[[ Line: 254 | Upvalues: v1 (ref), p1 (ref) ]]
					v1 = p1(...)
				end, ...)

				v3.current = current3

				if current2 ~= nil then
					current2.onWorkStopped(current, p2)
				end

				if not ok2 then
					error(result2)
				end

				if ok then
					return v1
				end

				error(result)
			end, ...)

			if not v32 then
				v32 = true

				for v1, v2 in current do
					v2.__count = v2.__count - 1

					if current2 ~= nil and v2.__count == 0 then
						current2.onInteractionScheduledWorkCompleted(v2)
					end
				end
			end

			if not ok then
				error(result)
			end

			return result
		end
	}

	setmetatable(t, t2)
	t.cancel = f4

	return t
end

return t