-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function getSystem(p1) --[[ getSystem | Line: 14 ]]
	if type(p1) == "function" then
		return p1
	end

	if type(p1) == "table" and p1.system then
		return p1.system
	end

	return nil
end

local function getSystemName(p1) --[[ getSystemName | Line: 24 ]]
	local v1 = debug.info(p1, "n")

	if not v1 or string.len(v1) == 0 then
		local v2, v3 = debug.info(p1, "sl")

		v1 = ("%*:%*"):format(v2, v3)
	end

	return v1
end

local function isPhase(p1) --[[ isPhase | Line: 34 ]]
	if type(p1) == "table" and p1._type == "phase" then
		return p1
	end

	return nil
end

local function isPipeline(p1) --[[ isPipeline | Line: 42 ]]
	if type(p1) == "table" and p1._type == "pipeline" then
		return p1
	end

	return nil
end

local function getEventIdentifier(p1, p2) --[[ getEventIdentifier | Line: 50 ]]
	local v2, v3

	if p2 then
		v2 = ("@%*"):format(p2)

		if v2 then
			v3 = p1
		else
			v3 = p1
			v2 = ""
		end
	else
		v3 = p1
		v2 = ""
	end

	return ("%*%*"):format(v3, v2)
end

local t = { "Connect", "On", "on", "connect" }
local t2 = { "disconnect", "Disconnect", "destroy", "Destroy" }

local function disconnectEvent(p1) --[[ disconnectEvent | Line: 73 | Upvalues: t2 (copy) ]]
	if type(p1) == "function" then
		p1()

		return
	end

	if typeof(p1) == "RBXScriptConnection" then
		p1:Disconnect()

		return
	end

	if type(p1) ~= "table" then
		return
	end

	for v1, v2 in t2 do
		if p1[v2] and type(p1[v2]) == "function" then
			p1[v2](p1)

			return
		end
	end
end

local function getConnectFunction(p1, p2) --[[ getConnectFunction | Line: 135 | Upvalues: t (copy) ]]
	local v1 = p1

	if typeof(p2) == "RBXScriptSignal" or type(p2) == "table" then
		v1 = p2
	elseif type(p2) == "string" then
		v1 = p1[p2]
	end

	if type(v1) == "function" then
		return v1
	end

	if typeof(v1) == "RBXScriptSignal" then
		return function(p1) --[[ Line: 147 | Upvalues: v1 (ref) ]]
			return v1:Connect(p1)
		end
	end

	if type(v1) ~= "table" then
		return nil
	end

	if type(p2) == "function" then
		return function(p1) --[[ Line: 154 | Upvalues: p2 (copy), v1 (ref) ]]
			return p2(v1, p1)
		end
	end

	for v2, v3 in t do
		local v4 = v1[v3]

		if type(v4) == "function" then
			return function(p1) --[[ Line: 164 | Upvalues: v1 (ref), v3 (copy) ]]
				return v1[v3](v1, p1)
			end
		end
	end

	return nil
end

return {
	getSystem = getSystem,
	getSystemName = getSystemName,
	isPhase = isPhase,
	isPipeline = isPipeline,
	getEventIdentifier = getEventIdentifier,
	isValidEvent = function(p1, p2) --[[ isValidEvent | Line: 173 | Upvalues: getConnectFunction (copy) ]]
		return getConnectFunction(p1, p2) ~= nil
	end,
	getConnectFunction = getConnectFunction,
	disconnectEvent = disconnectEvent
}