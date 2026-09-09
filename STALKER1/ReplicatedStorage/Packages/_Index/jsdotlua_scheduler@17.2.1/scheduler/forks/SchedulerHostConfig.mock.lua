-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local v1 = 0
local v2 = nil
local v3 = nil
local v4 = -1
local v5 = nil
local v6 = -1
local v7 = false
local v8 = false
local v9 = false
local v10 = false
local console = require(script.Parent.Parent.Parent:WaitForChild("shared")).console
local disabledLog = require(script.Parent.Parent.Parent:WaitForChild("shared")).ConsolePatchingDev.disabledLog

function t.requestHostCallback(p1) --[[ Line: 27 | Upvalues: v2 (ref) ]]
	v2 = p1
end
function t.cancelHostCallback() --[[ Line: 31 | Upvalues: v2 (ref) ]]
	v2 = nil
end
function t.requestHostTimeout(p1, p2) --[[ Line: 35 | Upvalues: v3 (ref), v4 (ref), v1 (ref) ]]
	v3 = p1
	v4 = v1 + p2
end
function t.cancelHostTimeout() --[[ Line: 40 | Upvalues: v3 (ref), v4 (ref) ]]
	v3 = nil
	v4 = -1
end
function t.shouldYieldToHost() --[[ Line: 45 | Upvalues: v5 (ref), v6 (ref), v10 (ref), v9 (ref), v7 (ref) ]]
	local v1 = v5

	if (v6 == -1 or (v1 == nil or not (v6 <= #v1))) and not (v10 and v9) then
		return false
	end

	v7 = true

	return true
end
function t.getCurrentTime() --[[ Line: 64 | Upvalues: v1 (ref) ]]
	return v1
end
function t.forceFrameRate() --[[ Line: 68 ]] end
function t.reset() --[[ Line: 72 | Upvalues: v8 (ref), v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), v7 (ref), v9 (ref) ]]
	if v8 then
		error("Cannot reset while already flushing work.")
	end

	v1 = 0
	v2 = nil
	v3 = nil
	v4 = -1
	v5 = nil
	v6 = -1
	v7 = false
	v8 = false
	v9 = false
end
function t.unstable_flushNumberOfYields(p1) --[[ Line: 89 | Upvalues: v8 (ref), v2 (ref), v6 (ref), v1 (ref), v7 (ref) ]]
	if v8 then
		error("Already flushing work.")
	end

	if v2 == nil then
		return
	end

	local v12 = v2

	v6 = p1
	v8 = true

	local ok, result = pcall(function() --[[ Line: 99 | Upvalues: v12 (copy), v1 (ref), v7 (ref), v2 (ref) ]]
		local v13

		repeat
			v13 = v12(true, v1)
		until not v13 or v7

		if v13 then
			return
		end

		v2 = nil
	end)

	v6 = -1
	v7 = false
	v8 = false

	if ok then
		return
	end

	error(result)
end
function t.unstable_flushUntilNextPaint() --[[ Line: 120 | Upvalues: v8 (ref), v2 (ref), v10 (ref), v9 (ref), v1 (ref), v7 (ref) ]]
	if v8 then
		error("Already flushing work.")
	end

	if v2 == nil then
		return
	end

	local v12 = v2

	v10 = true
	v9 = false
	v8 = true

	local ok, result = pcall(function() --[[ Line: 131 | Upvalues: v12 (copy), v1 (ref), v7 (ref), v2 (ref) ]]
		local v13

		repeat
			v13 = v12(true, v1)
		until not v13 or v7

		if v13 then
			return
		end

		v2 = nil
	end)

	v10 = false
	v7 = false
	v8 = false

	if ok then
		return
	end

	error(result)
end
function t.unstable_flushExpired() --[[ Line: 153 | Upvalues: v8 (ref), v2 (ref), v1 (ref) ]]
	if v8 then
		error("Already flushing work.")
	end

	if v2 == nil then
		return
	end

	v8 = true

	local ok, result = pcall(function() --[[ Line: 159 | Upvalues: v2 (ref), v1 (ref) ]]
		if v2(false, v1) then
			return
		end

		v2 = nil
	end)

	v8 = false

	if ok then
		return
	end

	error(result)
end
function t.unstable_flushAllWithoutAsserting() --[[ Line: 177 | Upvalues: v8 (ref), v2 (ref), v1 (ref) ]]
	if v8 then
		error("Already flushing work.")
	end

	if v2 == nil then
		return false
	end

	local v12 = v2

	v8 = true

	local ok, result = pcall(function() --[[ Line: 185 | Upvalues: v12 (copy), v1 (ref), v2 (ref) ]]
		local v13

		repeat
			v13 = v12(true, v1)
		until not v13

		if v13 then
			return
		end

		v2 = nil
	end)

	v8 = false

	if ok then
		return true
	end

	error(result)
end
function t.unstable_clearYields() --[[ Line: 208 | Upvalues: v5 (ref) ]]
	if v5 == nil then
		return {}
	end

	local v1 = v5

	v5 = nil

	return v1
end
function t.unstable_flushAll() --[[ Line: 217 | Upvalues: v5 (ref), t (copy) ]]
	if v5 ~= nil then
		error("Log is not empty. Assert on the log of yielded values before flushing additional work.")
	end

	t.unstable_flushAllWithoutAsserting()

	if v5 == nil then
		return
	end

	error("While flushing work, something yielded a value. Use an assertion helper to assert on the log of yielded values, e.g. expect(Scheduler).toFlushAndYield([...])")
end
function t.unstable_yieldValue(p1) --[[ Line: 234 | Upvalues: console (copy), disabledLog (copy), v5 (ref) ]]
	if console.log == disabledLog then
		return
	end

	if v5 == nil then
		v5 = { p1 }
	else
		table.insert(v5, p1)
	end
end
function t.unstable_advanceTime(p1) --[[ Line: 251 | Upvalues: console (copy), disabledLog (copy), v1 (ref), v3 (ref), v4 (ref) ]]
	if console.log == disabledLog then
		return
	end

	v1 = v1 + p1

	if v3 == nil or not (v4 <= v1) then
		return
	end

	v3(v1)
	v4 = -1
	v3 = nil
end
function t.requestPaint() --[[ Line: 270 | Upvalues: v9 (ref) ]]
	v9 = true
end

return t