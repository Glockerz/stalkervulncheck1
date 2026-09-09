-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent.Parent:WaitForChild("luau-polyfill"))
local Object = v1.Object
local v2 = require(script.Parent.Parent.Parent:WaitForChild("shared"))
local console = v2.console
local errorToString = v2.errorToString
local describeError = v2.describeError
local setTimeout = v1.setTimeout
local clearTimeout = v1.clearTimeout
local v3 = false
local v4 = nil
local None = Object.None
local v5 = 15
local v6 = 0

local function shouldYieldToHost() --[[ shouldYieldToHost | Line: 46 | Upvalues: v6 (ref) ]]
	return v6 <= os.clock() * 1000
end

local function requestPaint() --[[ requestPaint | Line: 51 ]] end

local function forceFrameRate(p1) --[[ forceFrameRate | Line: 53 | Upvalues: console (copy), v5 (ref) ]]
	if p1 < 0 or p1 > 125 then
		console.warn("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported")

		return
	end

	v5 = if p1 > 0 then math.floor(1000 / p1) else 5
end

local function v7() --[[ performWorkUntilDeadline | Line: 69 | Upvalues: v4 (ref), v6 (ref), v5 (ref), v3 (ref), v7 (ref), describeError (copy), errorToString (copy) ]]
	if v4 == nil then
		v3 = false
	else
		local v1 = os.clock() * 1000

		v6 = v1 + v5

		local function doWork() --[[ doWork | Line: 79 | Upvalues: v4 (ref), v1 (copy), v3 (ref), v7 (ref) ]]
			if v4(true, v1) then
				task.delay(0, v7)
			else
				v3 = false
				v4 = nil
			end

			return nil
		end

		local v2, v32

		if _G.__YOLO__ then
			if v4(true, v1) then
				task.delay(0, v7)
			else
				v3 = false
				v4 = nil
			end

			v2 = true
			v32 = nil
		else
			local ok, result = xpcall(doWork, describeError)

			v2 = ok
			v32 = result
		end

		if not v2 then
			task.delay(0, v7)
			error(errorToString(v32))
		end
	end
end

local function wrapPerformWorkWithCoroutine(p1) --[[ wrapPerformWorkWithCoroutine | Line: 124 ]]
	local v1 = coroutine.create(function() --[[ Line: 125 | Upvalues: p1 (copy) ]]
		while true do
			local ok, result = pcall((coroutine.wrap(p1)))

			coroutine.yield(ok, result)
		end
	end)

	return function() --[[ Line: 135 | Upvalues: v1 (copy) ]]
		local _, v12, v2 = coroutine.resume(v1)

		if v12 then
			return
		end

		error(v2)
	end
end

local v8 = v7
local v9 = coroutine.create(function() --[[ Line: 125 | Upvalues: v8 (copy) ]]
	while true do
		local ok, result = pcall((coroutine.wrap(v8)))

		coroutine.yield(ok, result)
	end
end)

v7 = function() --[[ Line: 135 | Upvalues: v9 (copy) ]]
	local _, v12, v2 = coroutine.resume(v9)

	if v12 then
		return
	end

	error(v2)
end

return {
	requestHostCallback = function(p1) --[[ requestHostCallback | Line: 145 | Upvalues: v4 (ref), v3 (ref), v7 (ref) ]]
		v4 = p1

		if v3 then
			return
		end

		v3 = true
		task.delay(0, v7)
	end,
	cancelHostCallback = function() --[[ cancelHostCallback | Line: 154 | Upvalues: v4 (ref) ]]
		v4 = nil
	end,
	requestHostTimeout = function(p1, p2) --[[ requestHostTimeout | Line: 158 | Upvalues: None (ref), setTimeout (copy) ]]
		None = setTimeout(function() --[[ Line: 159 | Upvalues: p1 (copy) ]]
			p1(os.clock() * 1000)
		end, p2)
	end,
	cancelHostTimeout = function() --[[ cancelHostTimeout | Line: 164 | Upvalues: clearTimeout (copy), None (ref), Object (copy) ]]
		clearTimeout(None)
		None = Object.None
	end,
	shouldYieldToHost = shouldYieldToHost,
	requestPaint = requestPaint,
	getCurrentTime = function() --[[ Line: 19 ]]
		return os.clock() * 1000
	end,
	forceFrameRate = forceFrameRate
}