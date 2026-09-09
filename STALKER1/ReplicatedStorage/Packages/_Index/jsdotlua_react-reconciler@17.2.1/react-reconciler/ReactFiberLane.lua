-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent:WaitForChild("ReactInternalTypes"))

local console = require(script.Parent.Parent:WaitForChild("shared")).console
local v1 = require(script.Parent:WaitForChild("ReactFiberSchedulerPriorities.roblox"))
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local ImmediatePriority = v1.ImmediatePriority
local UserBlockingPriority = v1.UserBlockingPriority
local NormalPriority = v1.NormalPriority
local LowPriority = v1.LowPriority
local IdlePriority = v1.IdlePriority
local NoPriority = v1.NoPriority
local t = {
	SyncLanePriority = 15,
	SyncBatchedLanePriority = 14,
	InputDiscreteLanePriority = 12,
	InputContinuousLanePriority = 10,
	DefaultLanePriority = 8,
	TransitionPriority = 6,
	NoLanePriority = 0,
	NoLanes = 0,
	NoLane = 0,
	SyncLane = 1,
	SyncBatchedLane = 2,
	InputDiscreteHydrationLane = 4,
	DefaultHydrationLane = 256,
	DefaultLanes = 3584,
	RetryLanes = 62914560,
	SomeRetryLane = 33554432,
	SelectiveHydrationLane = 67108864,
	IdleHydrationLane = 134217728,
	OffscreenLane = 1073741824,
	NoTimestamp = -1
}
local NoLanePriority = t.NoLanePriority

function t.getCurrentUpdateLanePriority() --[[ Line: 141 | Upvalues: NoLanePriority (ref) ]]
	return NoLanePriority
end
function t.setCurrentUpdateLanePriority(p1) --[[ Line: 145 | Upvalues: NoLanePriority (ref) ]]
	NoLanePriority = p1
end

local DefaultLanePriority = t.DefaultLanePriority

local function getHighestPriorityLanes(p1) --[[ getHighestPriorityLanes | Line: 153 | Upvalues: DefaultLanePriority (ref), console (copy) ]]
	if bit32.band(1, p1) ~= 0 then
		DefaultLanePriority = 15

		return 1
	end

	if bit32.band(2, p1) ~= 0 then
		DefaultLanePriority = 14

		return 2
	end

	if bit32.band(4, p1) ~= 0 then
		DefaultLanePriority = 13

		return 4
	end

	local v1 = bit32.band(24, p1)

	if v1 ~= 0 then
		DefaultLanePriority = 12

		return v1
	end

	if bit32.band(p1, 32) ~= 0 then
		DefaultLanePriority = 11

		return 32
	end

	local v2 = bit32.band(192, p1)

	if v2 ~= 0 then
		DefaultLanePriority = 10

		return v2
	end

	if bit32.band(p1, 256) ~= 0 then
		DefaultLanePriority = 9

		return 256
	end

	local v3 = bit32.band(3584, p1)

	if v3 ~= 0 then
		DefaultLanePriority = 8

		return v3
	end

	if bit32.band(p1, 4096) ~= 0 then
		DefaultLanePriority = 7

		return 4096
	end

	local v4 = bit32.band(4186112, p1)

	if v4 ~= 0 then
		DefaultLanePriority = 6

		return v4
	end

	local v5 = bit32.band(62914560, p1)

	if v5 ~= 0 then
		DefaultLanePriority = 5

		return v5
	end

	if bit32.band(p1, 67108864) ~= 0 then
		DefaultLanePriority = 4

		return 67108864
	end

	if bit32.band(p1, 134217728) ~= 0 then
		DefaultLanePriority = 3

		return 134217728
	end

	local v6 = bit32.band(805306368, p1)

	if v6 ~= 0 then
		DefaultLanePriority = 2

		return v6
	end

	if bit32.band(1073741824, p1) ~= 0 then
		DefaultLanePriority = 1

		return 1073741824
	end

	if not _G.__DEV__ then
		DefaultLanePriority = 8

		return p1
	end

	console.error("Should have found matching lanes. This is a bug in React.")
	DefaultLanePriority = 8

	return p1
end

function t.schedulerPriorityToLanePriority(p1) --[[ schedulerPriorityToLanePriority | Line: 228 | Upvalues: ImmediatePriority (copy), UserBlockingPriority (copy), NormalPriority (copy), LowPriority (copy), IdlePriority (copy) ]]
	if p1 == ImmediatePriority then
		return 15
	end

	if p1 == UserBlockingPriority then
		return 10
	end

	if p1 == NormalPriority or p1 == LowPriority then
		return 8
	end

	if p1 == IdlePriority then
		return 2
	end

	return 0
end
function t.lanePriorityToSchedulerPriority(p1) --[[ lanePriorityToSchedulerPriority | Line: 249 | Upvalues: ImmediatePriority (copy), UserBlockingPriority (copy), NormalPriority (copy), IdlePriority (copy), NoPriority (copy), invariant (copy) ]]
	if p1 == 15 or p1 == 14 then
		return ImmediatePriority
	end

	if p1 == 13 or (p1 == 12 or (p1 == 11 or p1 == 10)) then
		return UserBlockingPriority
	end

	if p1 == 9 or (p1 == 8 or (p1 == 7 or (p1 == 6 or (p1 == 4 or p1 == 5)))) then
		return NormalPriority
	end

	if p1 == 3 or (p1 == 2 or p1 == 1) then
		return IdlePriority
	end

	if p1 == 0 then
		return NoPriority
	end

	invariant(false, "Invalid update priority: %s. This is a bug in React.", p1)
	error("unreachable")
end

local v2 = nil
local v3 = nil

function t.getNextLanes(p1, p2) --[[ getNextLanes | Line: 293 | Upvalues: DefaultLanePriority (ref), getHighestPriorityLanes (copy), v3 (ref), v2 (ref) ]]
	local pendingLanes = p1.pendingLanes

	if pendingLanes == 0 then
		DefaultLanePriority = 0

		return 0
	end

	local v1 = 0
	local v22 = 0
	local expiredLanes = p1.expiredLanes
	local suspendedLanes = p1.suspendedLanes
	local pingedLanes = p1.pingedLanes

	if expiredLanes == 0 then
		local v32 = bit32.band(pendingLanes, 134217727)

		if v32 == 0 then
			local v5 = bit32.band(pendingLanes, (bit32.bnot(suspendedLanes)))

			if v5 == 0 then
				if pingedLanes ~= 0 then
					v22 = DefaultLanePriority
					v1 = getHighestPriorityLanes(pingedLanes)
				end
			else
				v22 = DefaultLanePriority
				v1 = getHighestPriorityLanes(v5)
			end
		else
			local v9 = bit32.band(v32, (bit32.bnot(suspendedLanes)))

			if v9 == 0 then
				local v10 = bit32.band(v32, pingedLanes)

				if v10 ~= 0 then
					v22 = DefaultLanePriority
					v1 = getHighestPriorityLanes(v10)
				end
			else
				v22 = DefaultLanePriority
				v1 = getHighestPriorityLanes(v9)
			end
		end
	else
		DefaultLanePriority = 15
		v1 = expiredLanes
		v22 = 15
	end

	if v1 == 0 then
		return 0
	end

	local v15 = bit32.band(pendingLanes, bit32.lshift(v3(v1), 1) - 1)

	if p2 ~= 0 and (p2 ~= v15 and bit32.band(p2, suspendedLanes) == 0) then
		getHighestPriorityLanes(p2)

		if v22 <= DefaultLanePriority then
			return p2
		end

		DefaultLanePriority = v22
	end

	local v16 = v15
	local entangledLanes = p1.entangledLanes

	if entangledLanes ~= 0 then
		local entanglements = p1.entanglements
		local v17 = bit32.band(v16, entangledLanes)

		while v17 > 0 do
			local v18 = v2(v17)
			local v19 = bit32.lshift(1, v18)
			local v21 = bit32.bor(v16, entanglements[v18])

			v17, v16 = bit32.band(v17, (bit32.bnot(v19))), v21
		end
	end

	return v16
end
function t.getMostRecentEventTime(p1, p2) --[[ getMostRecentEventTime | Line: 412 | Upvalues: v2 (ref) ]]
	local eventTimes = p1.eventTimes
	local v1 = -1

	while p2 > 0 do
		local v22 = v2(p2)
		local v3 = bit32.lshift(1, v22)
		local v4 = eventTimes[v22]

		if v1 < v4 then
			v1 = v4
		end

		p2 = bit32.band(p2, (bit32.bnot(v3)))
	end

	return v1
end
function t.computeExpirationTime(p1, p2) --[[ computeExpirationTime | Line: 432 | Upvalues: getHighestPriorityLanes (copy), DefaultLanePriority (ref) ]]
	getHighestPriorityLanes(p1)

	local v1 = DefaultLanePriority

	if v1 >= 10 then
		return p2 + 250
	end

	if v1 >= 6 then
		return p2 + 5000
	end

	return -1
end
function t.markStarvedLanesAsExpired(p1, p2) --[[ markStarvedLanesAsExpired | Line: 462 | Upvalues: v2 (ref), getHighestPriorityLanes (copy), DefaultLanePriority (ref) ]]
	local suspendedLanes = p1.suspendedLanes
	local pingedLanes = p1.pingedLanes
	local expirationTimes = p1.expirationTimes
	local v1 = p1.pendingLanes

	while v1 > 0 do
		local v22 = v2(v1)
		local v3 = bit32.lshift(1, v22)
		local v4 = expirationTimes[v22]

		if v4 == -1 then
			if bit32.band(v3, suspendedLanes) == 0 or bit32.band(v3, pingedLanes) ~= 0 then
				getHighestPriorityLanes(v3)

				local v5 = DefaultLanePriority

				expirationTimes[v22] = if v5 >= 10 then p2 + 250 elseif v5 >= 6 then p2 + 5000 else -1
			end
		elseif v4 <= p2 then
			p1.expiredLanes = bit32.bor(p1.expiredLanes, v3)
		end

		v1 = bit32.band(v1, (bit32.bnot(v3)))
	end
end
function t.getHighestPriorityPendingLanes(p1) --[[ getHighestPriorityPendingLanes | Line: 504 | Upvalues: getHighestPriorityLanes (copy) ]]
	return getHighestPriorityLanes(p1.pendingLanes)
end
function t.getLanesToRetrySynchronouslyOnError(p1) --[[ getLanesToRetrySynchronouslyOnError | Line: 509 ]]
	local v1 = bit32.band(p1.pendingLanes, 3221225471)

	if v1 ~= 0 then
		return v1
	end

	if bit32.band(v1, 1073741824) == 0 then
		return 0
	end

	return 1073741824
end
function t.returnNextLanesPriority() --[[ returnNextLanesPriority | Line: 522 | Upvalues: DefaultLanePriority (ref) ]]
	return DefaultLanePriority
end
function t.includesNonIdleWork(p1) --[[ includesNonIdleWork | Line: 527 ]]
	return bit32.band(p1, 134217727) ~= 0
end
function t.includesOnlyRetries(p1) --[[ includesOnlyRetries | Line: 532 ]]
	return bit32.band(p1, 62914560) == p1
end
function t.includesOnlyTransitions(p1) --[[ includesOnlyTransitions | Line: 537 ]]
	return bit32.band(p1, 4186112) == p1
end

local v4 = nil

local function v5(p1, p2) --[[ findUpdateLane | Line: 547 | Upvalues: v4 (ref), v5 (copy), invariant (copy) ]]
	if p1 ~= 0 then
		if p1 == 15 then
			return 1
		end

		if p1 == 14 then
			return 2
		end

		if p1 == 12 then
			local v3 = v4((bit32.band(24, (bit32.bnot(p2)))))

			if v3 == 0 then
				return v5(10, p2)
			end

			return v3
		elseif p1 == 10 then
			local v6 = v4((bit32.band(192, (bit32.bnot(p2)))))

			if v6 == 0 then
				return v5(8, p2)
			end

			return v6
		elseif p1 == 8 then
			local v9 = v4((bit32.band(3584, (bit32.bnot(p2)))))

			if v9 == 0 then
				local v12 = v4((bit32.band(4186112, (bit32.bnot(p2)))))

				v9 = if v12 == 0 then v4(3584) else v12
			end

			return v9
		elseif p1 ~= 6 and (p1 ~= 5 and p1 == 2) then
			local v16 = v4((bit32.band(805306368, (bit32.bnot(p2)))))

			if v16 == 0 then
				v16 = v4(805306368)
			end

			return v16
		end
	end

	invariant(false, "Invalid update priority: %s. This is a bug in React.", p1)
	error("unreachable")
end

t.findUpdateLane = v5
function t.findTransitionLane(p1, p2) --[[ findTransitionLane | Line: 606 | Upvalues: v4 (ref) ]]
	local v3 = v4((bit32.band(4186112, (bit32.bnot(p2)))))

	if v3 == 0 then
		local v6 = v4((bit32.band(4186112, (bit32.bnot(p1)))))

		v3 = if v6 == 0 then v4(4186112) else v6
	end

	return v3
end
function t.findRetryLane(p1) --[[ findRetryLane | Line: 626 | Upvalues: v4 (ref) ]]
	local v3 = v4((bit32.band(62914560, (bit32.bnot(p1)))))

	if v3 == 0 then
		v3 = v4(62914560)
	end

	return v3
end

local function getHighestPriorityLane(p1) --[[ getHighestPriorityLane | Line: 638 ]]
	return bit32.band(p1, -p1)
end

v3 = function(p1) --[[ getLowestPriorityLane | Line: 642 ]]
	local v1 = 31 - bit32.countlz(p1)

	if v1 < 0 then
		return 0
	end

	return bit32.lshift(1, v1)
end

local function getEqualOrHigherPriorityLanes(p1) --[[ getEqualOrHigherPriorityLanes | Line: 652 | Upvalues: v3 (ref) ]]
	return bit32.lshift(v3(p1), 1) - 1
end

v4 = function(p1) --[[ pickArbitraryLane | Line: 656 ]]
	return bit32.band(p1, -p1)
end
t.pickArbitraryLane = v4
v2 = function(p1) --[[ pickArbitraryLaneIndex | Line: 665 ]]
	return 31 - bit32.countlz(p1)
end
function t.includesSomeLane(p1, p2) --[[ includesSomeLane | Line: 674 ]]
	return bit32.band(p1, p2) ~= 0
end
function t.isSubsetOfLanes(p1, p2) --[[ isSubsetOfLanes | Line: 679 ]]
	return bit32.band(p1, p2) == p2
end
function t.mergeLanes(p1, p2) --[[ mergeLanes | Line: 684 ]]
	return bit32.bor(p1, p2)
end
function t.removeLanes(p1, p2) --[[ removeLanes | Line: 689 ]]
	return bit32.band(p1, (bit32.bnot(p2)))
end
function t.laneToLanes(p1) --[[ laneToLanes | Line: 696 ]]
	return p1
end
function t.higherPriorityLane(p1, p2) --[[ higherPriorityLane | Line: 701 ]]
	if p1 == 0 or p2 == 0 then
		if p1 == 0 then
			return p2
		end

		return p1
	end

	if p1 < p2 then
		return p1
	end

	return p2
end
function t.higherLanePriority(p1, p2) --[[ higherLanePriority | Line: 717 ]]
	if p1 ~= 0 and p2 < p1 then
		return p1
	end

	return p2
end
function t.createLaneMap(p1) --[[ createLaneMap | Line: 728 ]]
	return {
		[0] = p1,
		[1] = p1,
		[2] = p1,
		[3] = p1,
		[4] = p1,
		[5] = p1,
		[6] = p1,
		[7] = p1,
		[8] = p1,
		[9] = p1,
		[10] = p1,
		[11] = p1,
		[12] = p1,
		[13] = p1,
		[14] = p1,
		[15] = p1,
		[16] = p1,
		[17] = p1,
		[18] = p1,
		[19] = p1,
		[20] = p1,
		[21] = p1,
		[22] = p1,
		[23] = p1,
		[24] = p1,
		[25] = p1,
		[26] = p1,
		[27] = p1,
		[28] = p1,
		[29] = p1,
		[30] = p1,
		[31] = p1
	}
end
function t.markRootUpdated(p1, p2, p3) --[[ markRootUpdated | Line: 772 ]]
	p1.pendingLanes = bit32.bor(p1.pendingLanes, p2)

	local v1 = p2 - 1

	p1.suspendedLanes = bit32.band(p1.suspendedLanes, v1)
	p1.pingedLanes = bit32.band(p1.pingedLanes, v1)
	p1.eventTimes[31 - bit32.countlz(p2)] = p3
end
function t.markRootSuspended(p1, p2) --[[ markRootSuspended | Line: 801 | Upvalues: v2 (ref) ]]
	p1.suspendedLanes = bit32.bor(p1.suspendedLanes, p2)
	p1.pingedLanes = bit32.band(p1.pingedLanes, (bit32.bnot(p2)))

	local expirationTimes = p1.expirationTimes
	local v22 = p2

	while v22 > 0 do
		local v3 = v2(v22)
		local v4 = bit32.lshift(1, v3)

		expirationTimes[v3] = -1
		v22 = bit32.band(v22, (bit32.bnot(v4)))
	end
end
function t.markRootPinged(p1, p2, p3) --[[ markRootPinged | Line: 819 ]]
	p1.pingedLanes = bit32.bor(p1.pingedLanes, (bit32.band(p1.suspendedLanes, p2)))
end
function t.markRootExpired(p1, p2) --[[ markRootExpired | Line: 825 ]]
	p1.expiredLanes = bit32.bor(p1.expiredLanes, (bit32.band(p2, p1.pendingLanes)))
end
function t.markDiscreteUpdatesExpired(p1) --[[ markDiscreteUpdatesExpired | Line: 831 ]]
	p1.expiredLanes = bit32.bor(p1.expiredLanes, (bit32.band(24, p1.pendingLanes)))
end
function t.hasDiscreteLanes(p1) --[[ hasDiscreteLanes | Line: 837 ]]
	return bit32.band(p1, 24) ~= 0
end
function t.markRootMutableRead(p1, p2) --[[ markRootMutableRead | Line: 842 ]]
	p1.mutableReadLanes = bit32.bor(p1.mutableReadLanes, (bit32.band(p2, p1.pendingLanes)))
end
function t.markRootFinished(p1, p2) --[[ markRootFinished | Line: 848 | Upvalues: v2 (ref) ]]
	local v22 = bit32.band(p1.pendingLanes, (bit32.bnot(p2)))

	p1.pendingLanes = p2
	p1.suspendedLanes = 0
	p1.pingedLanes = 0
	p1.expiredLanes = bit32.band(p1.expiredLanes, p2)
	p1.mutableReadLanes = bit32.band(p1.mutableReadLanes, p2)
	p1.entangledLanes = bit32.band(p1.entangledLanes, p2)

	local entanglements = p1.entanglements
	local eventTimes = p1.eventTimes
	local expirationTimes = p1.expirationTimes
	local v3 = v22

	while v3 > 0 do
		local v4 = v2(v3)
		local v5 = bit32.lshift(1, v4)

		entanglements[v4] = 0
		eventTimes[v4] = -1
		expirationTimes[v4] = -1
		v3 = bit32.band(v3, (bit32.bnot(v5)))
	end
end
function t.markRootEntangled(p1, p2) --[[ markRootEntangled | Line: 881 | Upvalues: v2 (ref) ]]
	p1.entangledLanes = bit32.bor(p1.entangledLanes, p2)

	local entanglements = p1.entanglements
	local v1 = p2

	while v1 > 0 do
		local v22 = v2(v1)
		local v3 = bit32.lshift(1, v22)

		entanglements[v22] = bit32.bor(entanglements[v22], p2)
		v1 = bit32.band(v1, (bit32.bnot(v3)))
	end
end
function t.getBumpedLaneForHydration(p1, p2) --[[ getBumpedLaneForHydration | Line: 897 | Upvalues: getHighestPriorityLanes (copy), DefaultLanePriority (ref), invariant (copy) ]]
	getHighestPriorityLanes(p2)

	local v1 = DefaultLanePriority
	local v2 = nil

	if v1 == 15 or v1 == 14 then
		v2 = 0
	elseif v1 == 13 or v1 == 12 then
		v2 = 4
	elseif v1 == 11 or v1 == 10 then
		v2 = 32
	elseif v1 == 9 or v1 == 8 then
		v2 = 256
	elseif v1 == 7 or v1 == 6 or v1 == 5 then
		v2 = 4096
	elseif v1 == 4 then
		v2 = 67108864
	elseif v1 == 3 or v1 == 2 then
		v2 = 134217728
	elseif v1 == 1 or v1 == 0 then
		v2 = 0
	else
		invariant(false, "Invalid lane: %s. This is a bug in React.", (tostring(v2)))
	end

	if bit32.band(v2, (bit32.bor(p1.suspendedLanes, p2))) == 0 then
		return v2
	end

	return 0
end

return t