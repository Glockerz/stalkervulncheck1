-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))

require(script.Parent:WaitForChild("ReactInternalTypes"))

local v1 = _G.__REACT_MICROPROFILER_LEVEL or 0
local v2 = false
local v3 = nil

function startTimerSampling(p1) --[[ startTimerSampling | Line: 42 | Upvalues: v2 (ref), v3 (ref) ]]
	if v2 then
		warn("RobloxReactProfiling Timer Sampling already running.")
	end

	v2 = true
	v3 = p1
end
function endTimerSampling() --[[ endTimerSampling | Line: 50 | Upvalues: v2 (ref), v3 (ref) ]]
	v2 = false
	v3 = nil
end
function getFirstStringKey(p1) --[[ getFirstStringKey | Line: 55 ]]
	for v1, v2 in p1 do
		if type(v1) == "string" then
			return v1
		end
	end

	return nil
end
function startTimer(p1) --[[ startTimer | Line: 64 | Upvalues: v2 (ref) ]]
	if not v2 then
		return
	end

	p1.startTime = os.clock()
end
function endTimer(p1) --[[ endTimer | Line: 69 | Upvalues: v2 (ref), v3 (ref) ]]
	if not v2 then
		return
	end

	p1.endTime = os.clock()

	if not v3 then
		return
	end

	v3(p1)
end
function profileRootBeforeUnitOfWork(p1) --[[ profileRootBeforeUnitOfWork | Line: 78 ]]
	local current = p1.current
	local v1 = nil

	if current then
		if current.memoizedProps then
			v1 = getFirstStringKey(current.memoizedProps)
		end

		if v1 == nil and (current.stateNode and current.stateNode.containerInfo) then
			v1 = current.stateNode.containerInfo.Name
		end
	end

	if v1 == "Folder" and current.child then
		local child = current.child
		local v3 = if child.memoizedProps then getFirstStringKey(child.memoizedProps) else nil

		if v3 == nil and (child.stateNode and child.stateNode.containerInfo) then
			v3 = child.stateNode.containerInfo.Name
		end

		if v3 ~= nil then
			v1 = v3
		end
	end

	if v1 == nil then
		return nil
	end

	local t = {
		startTime = 0,
		endTime = 0,
		id = v1
	}

	startTimer(t)
	debug.profilebegin(v1)

	return t
end
function profileRootAfterYielding(p1) --[[ profileRootAfterYielding | Line: 132 ]]
	if not p1 then
		return
	end

	endTimer(p1)
	debug.profileend()
end
function profileUnitOfWorkBefore(p1) --[[ profileUnitOfWorkBefore | Line: 139 | Upvalues: getComponentName (copy), ReactWorkTags (copy) ]]
	local v1 = getComponentName(p1.type)

	if p1.key then
		v1 = tostring(p1.key) .. "=" .. (v1 or "?")
	end

	local v2 = nil

	if p1.stateNode and (p1.tag == ReactWorkTags.HostComponent or p1.tag == ReactWorkTags.HostText) then
		local v3 = p1.stateNode:FindFirstAncestorWhichIsA("LayerCollector")

		if v3 then
			v2 = "[" .. v3:GetFullName() .. "] "
		end
	end

	if v2 then
		v1 = v2 .. " : " .. (v1 or "?")
	end

	if v1 == nil then
		return false
	end

	debug.profilebegin(v1)

	return true
end
function profileUnitOfWorkAfter(p1) --[[ profileUnitOfWorkAfter | Line: 172 ]]
	if not p1 then
		return
	end

	debug.profileend()
end
function profileCommitBefore() --[[ profileCommitBefore | Line: 178 ]]
	debug.profilebegin("Commit")
end
function profileCommitAfter() --[[ profileCommitAfter | Line: 181 ]]
	debug.profileend()
end
function noop(...) --[[ noop | Line: 185 ]] end

local t = {
	startTimerSampling = startTimerSampling,
	endTimerSampling = endTimerSampling
}

t.profileRootBeforeUnitOfWork = if v1 >= 1 then profileRootBeforeUnitOfWork else noop
t.profileRootAfterYielding = if v1 >= 1 then profileRootAfterYielding else noop
t.profileUnitOfWorkBefore = if v1 >= 10 then profileUnitOfWorkBefore else noop
t.profileUnitOfWorkAfter = if v1 >= 10 then profileUnitOfWorkAfter else noop
t.profileCommitBefore = if v1 >= 1 then profileCommitBefore else noop
t.profileCommitAfter = if v1 >= 1 then profileCommitAfter else noop

return t