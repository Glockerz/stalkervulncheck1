-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent:WaitForChild("ReactInternalTypes"))
require(script.Parent:WaitForChild("ReactFiberLane"))
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"))

local resetWorkInProgressVersions = require(script.Parent:WaitForChild("ReactMutableSource.new")).resetWorkInProgressVersions
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"))
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags
local enableSuspenseServerRenderer = ReactFeatureFlags.enableSuspenseServerRenderer
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer
local v1 = require(script.Parent:WaitForChild("ReactFiberHostContext.new"))
local popHostContainer = v1.popHostContainer
local popHostContext = v1.popHostContext
local popSuspenseContext = require(script.Parent:WaitForChild("ReactFiberSuspenseContext.new")).popSuspenseContext
local resetHydrationState = require(script.Parent:WaitForChild("ReactFiberHydrationContext.new")).resetHydrationState
local v2 = require(script.Parent:WaitForChild("ReactFiberContext.new"))
local isContextProvider = v2.isContextProvider
local popContext = v2.popContext
local popTopLevelContextObject = v2.popTopLevelContextObject
local popProvider = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).popProvider
local v3 = nil

local function f4(...) --[[ Line: 44 | Upvalues: v3 (ref) ]]
	if v3 then
		return v3(...)
	end

	v3 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new")).popRenderLanes

	return v3(...)
end

local transferActualDuration = require(script.Parent:WaitForChild("ReactProfilerTimer.new")).transferActualDuration
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant

local function unwindWork(p1, p2) --[[ unwindWork | Line: 55 | Upvalues: ReactWorkTags (copy), isContextProvider (copy), popContext (copy), ReactFiberFlags (copy), enableProfilerTimer (copy), ReactTypeOfMode (copy), transferActualDuration (copy), popHostContainer (copy), popTopLevelContextObject (copy), resetWorkInProgressVersions (copy), invariant (copy), popHostContext (copy), popSuspenseContext (copy), enableSuspenseServerRenderer (copy), resetHydrationState (copy), popProvider (copy), f4 (copy) ]]
	if p1.tag == ReactWorkTags.ClassComponent then
		if isContextProvider(p1.type) then
			popContext(p1)
		end

		local flags = p1.flags

		if bit32.band(flags, ReactFiberFlags.ShouldCapture) == 0 then
			return nil
		end

		p1.flags = bit32.bor(bit32.band(flags, (bit32.bnot(ReactFiberFlags.ShouldCapture))), ReactFiberFlags.DidCapture)

		if enableProfilerTimer and bit32.band(p1.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
			transferActualDuration(p1)
		end

		return p1
	end

	if p1.tag == ReactWorkTags.HostRoot then
		popHostContainer(p1)
		popTopLevelContextObject(p1)
		resetWorkInProgressVersions()

		local flags = p1.flags
		local isNoFlags = bit32.band(flags, ReactFiberFlags.DidCapture) == ReactFiberFlags.NoFlags

		invariant(isNoFlags, "The root failed to unmount after an error. This is likely a bug in React. Please file an issue.")
		p1.flags = bit32.bor(bit32.band(flags, (bit32.bnot(ReactFiberFlags.ShouldCapture))), ReactFiberFlags.DidCapture)

		return p1
	end

	if p1.tag == ReactWorkTags.HostComponent then
		popHostContext(p1)

		return nil
	end

	if p1.tag == ReactWorkTags.SuspenseComponent then
		popSuspenseContext(p1)

		if enableSuspenseServerRenderer then
			local memoizedState = p1.memoizedState

			if memoizedState ~= nil and memoizedState.dehydrated ~= nil then
				invariant(p1.alternate ~= nil, "Threw in newly mounted dehydrated component. This is likely a bug in React. Please file an issue.")
				resetHydrationState()
			end
		end

		local flags = p1.flags

		if bit32.band(flags, ReactFiberFlags.ShouldCapture) == 0 then
			return nil
		end

		p1.flags = bit32.bor(bit32.band(flags, (bit32.bnot(ReactFiberFlags.ShouldCapture))), ReactFiberFlags.DidCapture)

		if enableProfilerTimer and bit32.band(p1.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
			transferActualDuration(p1)
		end

		return p1
	end

	if p1.tag == ReactWorkTags.SuspenseListComponent then
		popSuspenseContext(p1)

		return nil
	end

	if p1.tag == ReactWorkTags.HostPortal then
		popHostContainer(p1)

		return nil
	end

	if p1.tag == ReactWorkTags.ContextProvider then
		popProvider(p1)

		return nil
	end

	if p1.tag ~= ReactWorkTags.OffscreenComponent and p1.tag ~= ReactWorkTags.LegacyHiddenComponent then
		return nil
	end

	f4(p1)

	return nil
end

function unwindInterruptedWork(p1) --[[ unwindInterruptedWork | Line: 150 | Upvalues: ReactWorkTags (copy), popContext (copy), popHostContainer (copy), popTopLevelContextObject (copy), resetWorkInProgressVersions (copy), popHostContext (copy), popSuspenseContext (copy), popProvider (copy), f4 (copy) ]]
	if p1.tag == ReactWorkTags.ClassComponent then
		if (if typeof(p1.type) == "table" then p1.type.childContextTypes else nil) ~= nil then
			popContext(p1)
		end
	else
		if p1.tag == ReactWorkTags.HostRoot then
			popHostContainer(p1)
			popTopLevelContextObject(p1)
			resetWorkInProgressVersions()

			return
		end

		if p1.tag == ReactWorkTags.HostComponent then
			popHostContext(p1)

			return
		end

		if p1.tag == ReactWorkTags.HostPortal then
			popHostContainer(p1)

			return
		end

		if p1.tag == ReactWorkTags.SuspenseComponent then
			popSuspenseContext(p1)

			return
		end

		if p1.tag == ReactWorkTags.SuspenseListComponent then
			popSuspenseContext(p1)

			return
		end

		if p1.tag == ReactWorkTags.ContextProvider then
			popProvider(p1)

			return
		end

		if p1.tag ~= ReactWorkTags.OffscreenComponent and p1.tag ~= ReactWorkTags.LegacyHiddenComponent then
			return
		end

		f4(p1)
	end
end

return {
	unwindWork = unwindWork,
	unwindInterruptedWork = unwindInterruptedWork
}