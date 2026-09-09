-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent:WaitForChild("ReactInternalTypes"))
require(script.Parent:WaitForChild("ReactFiberHostConfig"))
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"))

local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local get = require(script.Parent.Parent:WaitForChild("shared")).ReactInstanceMap.get
local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local ClassComponent = ReactWorkTags.ClassComponent
local HostComponent = ReactWorkTags.HostComponent
local HostRoot = ReactWorkTags.HostRoot
local HostPortal = ReactWorkTags.HostPortal
local HostText = ReactWorkTags.HostText
local FundamentalComponent = ReactWorkTags.FundamentalComponent
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local NoFlags = ReactFiberFlags.NoFlags
local Placement = ReactFiberFlags.Placement
local Hydrating = ReactFiberFlags.Hydrating
local enableFundamentalAPI = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableFundamentalAPI
local ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner
local t = {}

local function getNearestMountedFiber(p1) --[[ getNearestMountedFiber | Line: 47 | Upvalues: Placement (copy), Hydrating (copy), NoFlags (copy), HostRoot (copy) ]]
	local v1, v2

	if p1.alternate then
		v1 = p1
		v2 = p1

		while v1.return_ do
			v1 = v1.return_
		end
	else
		local v3

		v3 = p1
		v2 = p1

		repeat
			if bit32.band(v3.flags, (bit32.bor(Placement, Hydrating))) ~= NoFlags then
				v2 = v3.return_
			end

			v1 = v3
			v3 = v1.return_
		until not v3
	end

	if v1.tag == HostRoot then
		return v2
	end

	return nil
end

t.getNearestMountedFiber = getNearestMountedFiber
function t.getSuspenseInstanceFromFiber(p1) --[[ Line: 81 | Upvalues: SuspenseComponent (copy) ]]
	if p1.tag ~= SuspenseComponent then
		return nil
	end

	local memoizedState = p1.memoizedState

	if memoizedState == nil then
		local alternate = p1.alternate

		if alternate ~= nil then
			memoizedState = alternate.memoizedState
		end
	end

	if memoizedState then
		return memoizedState.dehydrated
	end

	return nil
end
function t.getContainerFromFiber(p1) --[[ Line: 97 | Upvalues: HostRoot (copy) ]]
	if p1.tag == HostRoot then
		return p1.stateNode.containerInfo
	end

	return nil
end
function t.isFiberMounted(p1) --[[ Line: 101 | Upvalues: getNearestMountedFiber (copy) ]]
	return getNearestMountedFiber(p1) == p1
end
function t.isMounted(p1) --[[ Line: 107 | Upvalues: ReactCurrentOwner (copy), ClassComponent (copy), console (copy), getComponentName (copy), get (copy), getNearestMountedFiber (copy) ]]
	if _G.__DEV__ then
		local current = ReactCurrentOwner.current

		if current ~= nil and current.tag == ClassComponent then
			local stateNode = current.stateNode

			if not stateNode._warnedAboutRefsInRender then
				console.error("%s is accessing isMounted inside its render() function. render() should be a pure function of props and state. It should never access something that requires stale data from the previous render, such as refs. Move this logic to componentDidMount and componentDidUpdate instead.", getComponentName(current.type) or "A component")
			end

			stateNode._warnedAboutRefsInRender = true
		end
	end

	local v1 = get(p1)

	if not v1 then
		return false
	end

	return getNearestMountedFiber(v1) == v1
end

local function assertIsMounted(p1) --[[ assertIsMounted | Line: 137 | Upvalues: invariant (copy), getNearestMountedFiber (copy) ]]
	invariant(getNearestMountedFiber(p1) == p1, "Unable to find node on an unmounted component.")
end

local function findCurrentFiberUsingSlowPath(p1) --[[ findCurrentFiberUsingSlowPath | Line: 144 | Upvalues: getNearestMountedFiber (copy), invariant (copy), HostRoot (copy) ]]
	local alternate = p1.alternate

	if alternate then
		v1 = p1
		v2 = alternate

		while true do
			local return_ = v1.return_

			if return_ == nil then
				break
			end

			local alternate2 = return_.alternate

			if alternate2 == nil then
				local return_2 = return_.return_

				if return_2 == nil then
					break
				end

				v1 = return_2
				v2 = return_2
			else
				if return_.child == alternate2.child then
					local child = return_.child

					while child do
						if child == v1 then
							invariant(if getNearestMountedFiber(return_) == return_ then true else false, "Unable to find node on an unmounted component.")

							return p1
						end

						if child == v2 then
							invariant(if getNearestMountedFiber(return_) == return_ then true else false, "Unable to find node on an unmounted component.")

							return alternate
						end

						child = child.sibling
					end

					invariant(false, "Unable to find node on an unmounted component.")
				end

				if v1.return_ == v2.return_ then
					local child = return_.child
					local v7 = false

					while child do
						if child == v1 then
							v7 = true
							v1 = return_
							v2 = alternate2

							break
						end

						if child == v2 then
							v7 = true
							v1 = alternate2
							v2 = return_

							break
						end

						child = child.sibling
					end

					if not v7 then
						local child2 = alternate2.child

						while child2 do
							if child2 == v1 then
								v7 = true
								v1 = alternate2
								v2 = return_

								break
							end

							if child2 == v2 then
								v7 = true
								v1 = return_
								v2 = alternate2

								break
							end

							child2 = child2.sibling
						end

						invariant(v7, "Child was not found in either parent set. This indicates a bug in React related to the return pointer. Please file an issue.")
					end
				else
					v1 = return_
					v2 = alternate2
				end

				invariant(if v1.alternate == v2 then true else false, "Return fibers should always be each others\' alternates. This error is likely caused by a bug in React. Please file an issue.")
			end
		end

		invariant(if v1.tag == HostRoot then true else false, "Unable to find node on an unmounted component.")

		if v1.stateNode.current == v1 then
			return p1
		end

		return alternate
	end

	local v12 = getNearestMountedFiber(p1)

	invariant(v12 ~= nil, "Unable to find node on an unmounted component.")

	if v12 == p1 then
		return p1
	end

	return nil
end

t.findCurrentFiberUsingSlowPath = findCurrentFiberUsingSlowPath
function t.findCurrentHostFiber(p1) --[[ Line: 279 | Upvalues: findCurrentFiberUsingSlowPath (copy), HostComponent (copy), HostText (copy) ]]
	local v1 = findCurrentFiberUsingSlowPath(p1)

	if not v1 then
		return nil
	end

	local v2 = v1

	while true do
		local child = v2.child

		if v2.tag == HostComponent or v2.tag == HostText then
			break
		end

		if child then
			child.return_ = v2
			v2 = child
		else
			if v2 == v1 then
				return nil
			end

			local return_ = v2.return_
			local sibling = v2.sibling

			while not sibling do
				if not return_ or return_ == v1 then
					return nil
				end
			end

			sibling.return_ = return_
			v2 = sibling
		end
	end

	return v2
end
function t.findCurrentHostFiberWithNoPortals(p1) --[[ Line: 318 | Upvalues: findCurrentFiberUsingSlowPath (copy), HostComponent (copy), HostText (copy), enableFundamentalAPI (copy), FundamentalComponent (copy), HostPortal (copy) ]]
	local v1 = findCurrentFiberUsingSlowPath(p1)

	if not v1 then
		return nil
	end

	local v2 = v1

	while true do
		local child = v2.child

		if v2.tag == HostComponent or (v2.tag == HostText or enableFundamentalAPI and v2.tag == FundamentalComponent) then
			break
		end

		if child and v2.tag ~= HostPortal then
			child.return_ = v2
			v2 = child
		else
			if v2 == v1 then
				return nil
			end

			local return_ = v2.return_
			local sibling = v2.sibling

			while not sibling do
				if not return_ or return_ == v1 then
					return nil
				end
			end

			sibling.return_ = return_
			v2 = sibling
		end
	end

	return v2
end
function t.isFiberSuspenseAndTimedOut(p1) --[[ Line: 360 | Upvalues: SuspenseComponent (copy) ]]
	local memoizedState = p1.memoizedState

	return if p1.tag == SuspenseComponent and memoizedState ~= nil then memoizedState.dehydrated == nil else false
end
function t.doesFiberContain(p1, p2) --[[ Line: 367 ]]
	local alternate = p1.alternate
	local v1 = p2

	while v1 ~= nil do
		if v1 == p1 or v1 == alternate then
			return true
		end

		v1 = v1.return_
	end

	return false
end

return t