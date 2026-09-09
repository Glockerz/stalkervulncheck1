-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local utils = require(script.Parent.utils)
local getConnectFunction = utils.getConnectFunction

local function timePassed(p1) --[[ timePassed | Line: 22 ]]
	local v1 = nil

	return function() --[[ Line: 25 | Upvalues: v1 (ref), p1 (copy) ]]
		if v1 == nil or p1 <= os.clock() - v1 then
			v1 = os.clock()

			return true
		end

		return false
	end
end

local function runOnce() --[[ runOnce | Line: 39 ]]
	local v1 = false

	return function() --[[ Line: 42 | Upvalues: v1 (ref) ]]
		if v1 then
			return false
		end

		v1 = true

		return true
	end
end

local t = {}

local function cleanupCondition(p1) --[[ cleanupCondition | Line: 56 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	v1()
	t[p1] = nil
end

return {
	timePassed = timePassed,
	runOnce = runOnce,
	onEvent = function(p1, p2) --[[ onEvent | Line: 107 | Upvalues: getConnectFunction (copy), utils (copy), t (copy) ]]
		local v1 = getConnectFunction(p1, p2)

		assert(v1, "Event passed to .onEvent is not valid")

		local v2 = false
		local t2 = {}
		local v3 = nil

		local function disconnect() --[[ disconnect | Line: 119 | Upvalues: v3 (ref), utils (ref) ]]
			if v3 then
				utils.disconnectEvent(v3)
				v3 = nil
			end
		end

		v3 = v1(function(...) --[[ callback | Line: 128 | Upvalues: v2 (ref), t2 (copy) ]]
			v2 = true
			table.insert(t2, { ... })
		end)

		local function hasNewEvent() --[[ hasNewEvent | Line: 135 | Upvalues: v2 (ref), t2 (copy) ]]
			if v2 then
				v2 = false

				return true
			end

			table.clear(t2)

			return false
		end

		local function collectEvents() --[[ collectEvents | Line: 145 | Upvalues: t2 (copy) ]]
			local v1 = 0

			return function() --[[ Line: 147 | Upvalues: v1 (ref), t2 (ref) ]]
				v1 = v1 + 1

				local v12 = table.remove(t2, 1)

				if v12 then
					return v1, table.unpack(v12)
				end

				return nil
			end
		end

		local function getDisconnectFn() --[[ getDisconnectFn | Line: 160 | Upvalues: disconnect (copy) ]]
			return disconnect
		end

		t[hasNewEvent] = disconnect

		return hasNewEvent, collectEvents, getDisconnectFn
	end,
	isNot = function(p1, ...) --[[ isNot | Line: 176 ]]
		return function() --[[ Line: 177 | Upvalues: p1 (copy) ]]
			return not p1()
		end
	end,
	cleanupCondition = cleanupCondition
}