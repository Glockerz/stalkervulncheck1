-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function unimplemented(p1) --[[ unimplemented | Line: 11 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring(p1))
	error("FIXME (roblox): " .. p1 .. " is unimplemented", 2)
end

require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))
local OffscreenLane = ReactFiberLane.OffscreenLane
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"))

require(script.Parent:WaitForChild("ReactFiberOffscreenComponent"))

local resetWorkInProgressVersions = require(script.Parent:WaitForChild("ReactMutableSource.new")).resetWorkInProgressVersions
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local IndeterminateComponent = ReactWorkTags.IndeterminateComponent
local FunctionComponent = ReactWorkTags.FunctionComponent
local ClassComponent = ReactWorkTags.ClassComponent
local HostRoot = ReactWorkTags.HostRoot
local HostComponent = ReactWorkTags.HostComponent
local HostText = ReactWorkTags.HostText
local HostPortal = ReactWorkTags.HostPortal
local ContextProvider = ReactWorkTags.ContextProvider
local ContextConsumer = ReactWorkTags.ContextConsumer
local ForwardRef = ReactWorkTags.ForwardRef
local Fragment = ReactWorkTags.Fragment
local Mode = ReactWorkTags.Mode
local Profiler = ReactWorkTags.Profiler
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent
local MemoComponent = ReactWorkTags.MemoComponent
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local LazyComponent = ReactWorkTags.LazyComponent
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent
local FundamentalComponent = ReactWorkTags.FundamentalComponent
local ScopeComponent = ReactWorkTags.ScopeComponent
local Block = ReactWorkTags.Block
local OffscreenComponent = ReactWorkTags.OffscreenComponent
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent

require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"))

local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"))
local NoMode = ReactTypeOfMode.NoMode
local ConcurrentMode = ReactTypeOfMode.ConcurrentMode
local BlockingMode = ReactTypeOfMode.BlockingMode
local ProfileMode = ReactTypeOfMode.ProfileMode
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local Ref = ReactFiberFlags.Ref
local Update = ReactFiberFlags.Update
local Callback = ReactFiberFlags.Callback
local Passive = ReactFiberFlags.Passive
local Deletion = ReactFiberFlags.Deletion
local NoFlags = ReactFiberFlags.NoFlags
local DidCapture = ReactFiberFlags.DidCapture
local Snapshot = ReactFiberFlags.Snapshot
local MutationMask = ReactFiberFlags.MutationMask
local LayoutMask = ReactFiberFlags.LayoutMask
local PassiveMask = ReactFiberFlags.PassiveMask
local StaticMask = ReactFiberFlags.StaticMask
local PerformedWork = ReactFiberFlags.PerformedWork
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant
local createInstance = ReactFiberHostConfig.createInstance
local createTextInstance = ReactFiberHostConfig.createTextInstance
local appendInitialChild = ReactFiberHostConfig.appendInitialChild
local finalizeInitialChildren = ReactFiberHostConfig.finalizeInitialChildren
local prepareUpdate = ReactFiberHostConfig.prepareUpdate
local supportsMutation = ReactFiberHostConfig.supportsMutation
local supportsPersistence = ReactFiberHostConfig.supportsPersistence
local createContainerChildSet = ReactFiberHostConfig.createContainerChildSet
local finalizeContainerChildren = ReactFiberHostConfig.finalizeContainerChildren
local preparePortalMount = ReactFiberHostConfig.preparePortalMount
local v1 = require(script.Parent:WaitForChild("ReactFiberHostContext.new"))
local getRootHostContainer = v1.getRootHostContainer
local popHostContext = v1.popHostContext
local getHostContext = v1.getHostContext
local popHostContainer = v1.popHostContainer
local v2 = require(script.Parent:WaitForChild("ReactFiberSuspenseContext.new"))
local popSuspenseContext = v2.popSuspenseContext
local suspenseStackCursor = v2.suspenseStackCursor
local InvisibleParentSuspenseContext = v2.InvisibleParentSuspenseContext
local hasSuspenseContext = v2.hasSuspenseContext
local v3 = require(script.Parent:WaitForChild("ReactFiberContext.new"))
local isContextProvider = v3.isContextProvider
local popContext = v3.popContext
local popTopLevelContextObject = v3.popTopLevelContextObject
local popProvider = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).popProvider
local v4 = require(script.Parent:WaitForChild("ReactFiberHydrationContext.new"))
local prepareToHydrateHostSuspenseInstance = v4.prepareToHydrateHostSuspenseInstance
local popHydrationState = v4.popHydrationState
local resetHydrationState = v4.resetHydrationState
local prepareToHydrateHostInstance = v4.prepareToHydrateHostInstance
local prepareToHydrateHostTextInstance = v4.prepareToHydrateHostTextInstance
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing
local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback
local enableSuspenseServerRenderer = ReactFeatureFlags.enableSuspenseServerRenderer
local enableFundamentalAPI = ReactFeatureFlags.enableFundamentalAPI
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer
local v5 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"))
local popRenderLanes = v5.popRenderLanes
local markSpawnedWork = v5.markSpawnedWork
local renderDidSuspend = v5.renderDidSuspend
local renderDidSuspendDelayIfPossible = v5.renderDidSuspendDelayIfPossible
local NoLanes = ReactFiberLane.NoLanes
local includesSomeLane = ReactFiberLane.includesSomeLane
local mergeLanes = ReactFiberLane.mergeLanes
local transferActualDuration = require(script.Parent:WaitForChild("ReactProfilerTimer.new")).transferActualDuration

local function markUpdate(p1) --[[ markUpdate | Line: 185 | Upvalues: Update (copy) ]]
	p1.flags = bit32.bor(p1.flags, Update)
end

local function markRef(p1) --[[ markRef | Line: 191 | Upvalues: Ref (copy) ]]
	p1.flags = bit32.bor(p1.flags, Ref)
end

local function hadNoMutationsEffects(p1, p2) --[[ hadNoMutationsEffects | Line: 197 | Upvalues: MutationMask (copy), NoFlags (copy) ]]
	if if p1 == nil then false elseif p1.child == p2.child then true else false then
		return true
	end

	local child = p2.child

	while child ~= nil do
		if bit32.band(child.flags, MutationMask) ~= NoFlags then
			return false
		end

		if bit32.band(child.subtreeFlags, MutationMask) ~= NoFlags then
			return false
		end

		child = child.sibling
	end

	return true
end

local v6 = nil
local v7 = nil
local v8 = nil
local v9

if supportsMutation then
	v7 = function(p1, p2, p3, p4, p5) --[[ updateHostComponent | Line: 264 | Upvalues: getHostContext (copy), prepareUpdate (copy), Update (copy) ]]
		local memoizedProps = p1.memoizedProps

		if memoizedProps == p4 then
			return
		end

		local v1 = prepareUpdate(p2.stateNode, p3, memoizedProps, p4, p5, (getHostContext()))

		p2.updateQueue = v1

		if not v1 then
			return
		end

		p2.flags = bit32.bor(p2.flags, Update)
	end
	v8 = function(p1, p2, p3, p4) --[[ updateHostText | Line: 305 | Upvalues: Update (copy) ]]
		if p3 == p4 then
			return
		end

		p2.flags = bit32.bor(p2.flags, Update)
	end
	v9 = function(p1, p2) --[[ Line: 261 ]] end
	v6 = function(p1, p2, p3, p4) --[[ Line: 223 | Upvalues: HostComponent (copy), HostText (copy), appendInitialChild (copy), enableFundamentalAPI (copy), FundamentalComponent (copy), HostPortal (copy) ]]
		local child = p2.child

		while child ~= nil do
			if child.tag == HostComponent or child.tag == HostText then
				appendInitialChild(p1, child.stateNode)
			else
				if not enableFundamentalAPI or child.tag ~= FundamentalComponent then
					if child.tag == HostPortal or child.child == nil then
						if child == p2 then
							break
						end

						while child.sibling == nil do
							if child.return_ == nil or child.return_ == p2 then
								return
							end

							child = child.return_
						end

						child.sibling.return_ = child.return_
						child = child.sibling
					else
						child.child.return_ = child
						child = child.child
					end

					continue
				end

				appendInitialChild(p1, child.stateNode.instance)
			end

			if child == p2 then
				break
			end

			while child.sibling == nil do
				if child.return_ == nil or child.return_ == p2 then
					return
				end

				child = child.return_
			end

			child.sibling.return_ = child.return_
			child = child.sibling
		end
	end
elseif supportsPersistence then
	local function appendAllChildrenToContainer(p1, p2, p3, p4) --[[ appendAllChildrenToContainer | Line: 413 ]]
		print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		print("UNIMPLEMENTED ERROR: " .. tostring("appendAllChildrenToContainer"))
		error("FIXME (roblox): appendAllChildrenToContainer is unimplemented", 2)
	end

	v9 = function(p1, p2) --[[ updateHostContainer | Line: 507 | Upvalues: hadNoMutationsEffects (copy), createContainerChildSet (copy), Update (copy), finalizeContainerChildren (copy) ]]
		local stateNode = p2.stateNode

		if not hadNoMutationsEffects(p1, p2) then
			local v1 = createContainerChildSet(stateNode.containerInfo)

			print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
			print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
			print("UNIMPLEMENTED ERROR: " .. tostring("appendAllChildrenToContainer"))
			error("FIXME (roblox): appendAllChildrenToContainer is unimplemented", 2)
		end
	end
	v6 = function(p1, p2, p3, p4) --[[ Line: 318 ]]
		print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		print("UNIMPLEMENTED ERROR: " .. tostring("appendAllChildren"))
		error("FIXME (roblox): appendAllChildren is unimplemented", 2)
	end
else
	v9 = function(p1, p2) --[[ Line: 623 ]] end
end

local function bubbleProperties(p1) --[[ bubbleProperties | Line: 716 | Upvalues: NoLanes (copy), NoFlags (copy), enableProfilerTimer (copy), ProfileMode (copy), NoMode (copy), mergeLanes (copy), StaticMask (copy) ]]
	local v1 = if p1.alternate == nil then false elseif p1.alternate.child == p1.child then true else false
	local v2 = NoLanes
	local v3 = NoFlags

	if v1 then
		local v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16

		if enableProfilerTimer then
			if bit32.band(p1.mode, ProfileMode) == NoMode then
				v4 = p1.child

				while v4 ~= nil do
					v5 = v4.lanes
					v6 = v4.childLanes
					v7 = bit32.bor(v5, v6)
					v8 = bit32.bor(v2, v7)
					v9 = v4.subtreeFlags
					v10 = StaticMask
					v11 = bit32.band(v9, StaticMask)
					v12 = bit32.bor(v3, v11)
					v13 = v4.flags
					v14 = StaticMask
					v15 = bit32.band(v13, StaticMask)
					v16 = bit32.bor(v12, v15)
					v4.return_ = p1
					v4 = v4.sibling
					v2, v3 = v8, v16
				end
			else
				local selfBaseDuration = p1.selfBaseDuration
				local child = p1.child

				while child ~= nil do
					local v18 = mergeLanes(v2, mergeLanes(child.lanes, child.childLanes))
					local v24 = bit32.bor(bit32.bor(v3, (bit32.band(child.subtreeFlags, StaticMask))), (bit32.band(child.flags, StaticMask)))

					selfBaseDuration = selfBaseDuration + child.treeBaseDuration
					child = child.sibling
					v3, v2 = v24, v18
				end

				p1.treeBaseDuration = selfBaseDuration
			end
		else
			v4 = p1.child

			while v4 ~= nil do
				v5 = v4.lanes
				v6 = v4.childLanes
				v7 = bit32.bor(v5, v6)
				v8 = bit32.bor(v2, v7)
				v9 = v4.subtreeFlags
				v10 = StaticMask
				v11 = bit32.band(v9, StaticMask)
				v12 = bit32.bor(v3, v11)
				v13 = v4.flags
				v14 = StaticMask
				v15 = bit32.band(v13, StaticMask)
				v16 = bit32.bor(v12, v15)
				v4.return_ = p1
				v4 = v4.sibling
				v2, v3 = v8, v16
			end
		end

		p1.subtreeFlags = bit32.bor(p1.subtreeFlags, v3)
	else
		local v25, v26, v27, v28, v29, v30, v31, v32, v33

		if enableProfilerTimer then
			if bit32.band(p1.mode, ProfileMode) == NoMode then
				v25 = p1.child

				while v25 ~= nil do
					v26 = v25.lanes
					v27 = v25.childLanes
					v28 = bit32.bor(v26, v27)
					v29 = bit32.bor(v2, v28)
					v30 = v25.subtreeFlags
					v31 = bit32.bor(v3, v30)
					v32 = v25.flags
					v33 = bit32.bor(v31, v32)
					v25.return_ = p1
					v25 = v25.sibling
					v2, v3 = v29, v33
				end
			else
				local actualDuration = p1.actualDuration
				local selfBaseDuration = p1.selfBaseDuration
				local child = p1.child

				while child ~= nil do
					local v35 = mergeLanes(v2, mergeLanes(child.lanes, child.childLanes))
					local v37 = bit32.bor(bit32.bor(v3, child.subtreeFlags), child.flags)

					actualDuration = actualDuration + child.actualDuration
					selfBaseDuration = selfBaseDuration + child.treeBaseDuration
					child = child.sibling
					v3, v2 = v37, v35
				end

				p1.actualDuration = actualDuration
				p1.treeBaseDuration = selfBaseDuration
			end
		else
			v25 = p1.child

			while v25 ~= nil do
				v26 = v25.lanes
				v27 = v25.childLanes
				v28 = bit32.bor(v26, v27)
				v29 = bit32.bor(v2, v28)
				v30 = v25.subtreeFlags
				v31 = bit32.bor(v3, v30)
				v32 = v25.flags
				v33 = bit32.bor(v31, v32)
				v25.return_ = p1
				v25 = v25.sibling
				v2, v3 = v29, v33
			end
		end

		p1.subtreeFlags = bit32.bor(p1.subtreeFlags, v3)
	end

	p1.childLanes = v2

	return v1
end

return {
	completeWork = function(p1, p2, p3) --[[ completeWork | Line: 855 | Upvalues: IndeterminateComponent (copy), LazyComponent (copy), SimpleMemoComponent (copy), FunctionComponent (copy), ForwardRef (copy), Fragment (copy), Mode (copy), ContextConsumer (copy), MemoComponent (copy), bubbleProperties (copy), ClassComponent (copy), isContextProvider (copy), popContext (copy), HostRoot (copy), popHostContainer (copy), popTopLevelContextObject (copy), resetWorkInProgressVersions (copy), popHydrationState (copy), Update (copy), Snapshot (copy), v9 (ref), HostComponent (copy), popHostContext (copy), getRootHostContainer (copy), v7 (ref), Ref (copy), invariant (copy), getHostContext (copy), prepareToHydrateHostInstance (copy), createInstance (copy), v6 (ref), finalizeInitialChildren (copy), HostText (copy), v8 (ref), prepareToHydrateHostTextInstance (copy), createTextInstance (copy), Profiler (copy), Callback (copy), Passive (copy), PerformedWork (copy), NoFlags (copy), LayoutMask (copy), Deletion (copy), PassiveMask (copy), SuspenseComponent (copy), popSuspenseContext (copy), enableSuspenseServerRenderer (copy), prepareToHydrateHostSuspenseInstance (copy), enableSchedulerTracing (copy), markSpawnedWork (copy), OffscreenLane (copy), enableProfilerTimer (copy), ProfileMode (copy), NoMode (copy), resetHydrationState (copy), DidCapture (copy), transferActualDuration (copy), BlockingMode (copy), hasSuspenseContext (copy), suspenseStackCursor (copy), InvisibleParentSuspenseContext (copy), renderDidSuspend (copy), renderDidSuspendDelayIfPossible (copy), supportsPersistence (copy), supportsMutation (copy), enableSuspenseCallback (copy), HostPortal (copy), preparePortalMount (copy), ContextProvider (copy), popProvider (copy), IncompleteClassComponent (copy), SuspenseListComponent (copy), FundamentalComponent (copy), ScopeComponent (copy), Block (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy), popRenderLanes (copy), includesSomeLane (copy), v5 (copy), ConcurrentMode (copy) ]]
		local pendingProps = p2.pendingProps

		if p2.tag == IndeterminateComponent or (p2.tag == LazyComponent or (p2.tag == SimpleMemoComponent or (p2.tag == FunctionComponent or (p2.tag == ForwardRef or (p2.tag == Fragment or (p2.tag == Mode or (p2.tag == ContextConsumer or p2.tag == MemoComponent))))))) then
			bubbleProperties(p2)

			return nil
		end

		if p2.tag == ClassComponent then
			if isContextProvider(p2.type) then
				popContext(p2)
			end

			bubbleProperties(p2)

			return nil
		end

		if p2.tag == HostRoot then
			popHostContainer(p2)
			popTopLevelContextObject(p2)
			resetWorkInProgressVersions()

			local stateNode = p2.stateNode

			if stateNode.pendingContext then
				stateNode.context = stateNode.pendingContext
				stateNode.pendingContext = nil
			end

			if p1 == nil or p1.child == nil then
				if popHydrationState(p2) then
					p2.flags = bit32.bor(p2.flags, Update)
				elseif not stateNode.hydrate then
					p2.flags = bit32.bor(p2.flags, Snapshot)
				end
			end

			v9(p1, p2)
			bubbleProperties(p2)

			return nil
		end

		if p2.tag == HostComponent then
			popHostContext(p2)

			local v3 = getRootHostContainer()
			local v4 = p2.type

			if p1 == nil or p2.stateNode == nil then
				if pendingProps then
					local v52 = getHostContext()

					if popHydrationState(p2) then
						if prepareToHydrateHostInstance(p2, v3, v52) then
							p2.flags = bit32.bor(p2.flags, Update)
						end
					else
						local v72 = createInstance(v4, pendingProps, v3, v52, p2)

						v6(v72, p2, false, false)
						p2.stateNode = v72

						if finalizeInitialChildren(v72, v4, pendingProps, v3, v52) then
							p2.flags = bit32.bor(p2.flags, Update)
						end
					end

					if p2.ref ~= nil then
						p2.flags = bit32.bor(p2.flags, Ref)
					end
				else
					invariant(p2.stateNode ~= nil, "We must have new props for new mounts. This error is likely caused by a bug in React. Please file an issue.")
					bubbleProperties(p2)

					return nil
				end
			else
				v7(p1, p2, v4, pendingProps, v3)

				if p1.ref ~= p2.ref then
					p2.flags = bit32.bor(p2.flags, Ref)
				end
			end

			bubbleProperties(p2)

			return nil
		end

		if p2.tag == HostText then
			if p1 and p2.stateNode ~= nil then
				v8(p1, p2, p1.memoizedProps, pendingProps)
			else
				if typeof(pendingProps) ~= "string" then
					invariant(p2.stateNode ~= nil, "We must have new props for new mounts. This error is likely caused by a bug in React. Please file an issue.")
				end

				local v13 = getRootHostContainer()
				local v14 = getHostContext()

				if popHydrationState(p2) then
					if prepareToHydrateHostTextInstance(p2) then
						p2.flags = bit32.bor(p2.flags, Update)
					end
				else
					p2.stateNode = createTextInstance(pendingProps, v13, v14, p2)
				end
			end

			bubbleProperties(p2)

			return nil
		end

		if p2.tag == Profiler then
			if bubbleProperties(p2) then
				return nil
			end

			local v16 = Update
			local v17 = Callback
			local v18 = Passive
			local subtreeFlags = p2.subtreeFlags
			local flags = p2.flags
			local v20

			if bit32.band(flags, PerformedWork) == NoFlags and bit32.band(subtreeFlags, PerformedWork) == NoFlags then
				v20 = flags
			else
				local v21

				v21 = bit32.bor(flags, v16)
				v20 = v21
			end

			local v26

			if bit32.band(flags, (bit32.bor(LayoutMask, Deletion))) == NoFlags then
				if bit32.band(subtreeFlags, (bit32.bor(LayoutMask, Deletion))) ~= NoFlags then
					v26 = bit32.bor(v20, v17)
					v20 = v26
				end
			else
				v26 = bit32.bor(v20, v17)
				v20 = v26
			end

			local v31

			if bit32.band(flags, PassiveMask) == NoFlags then
				if bit32.band(subtreeFlags, PassiveMask) ~= NoFlags then
					v31 = bit32.bor(v20, v18)
					v20 = v31
				end
			else
				v31 = bit32.bor(v20, v18)
				v20 = v31
			end

			p2.flags = v20

			return nil
		end

		if p2.tag == SuspenseComponent then
			popSuspenseContext(p2)

			local memoizedState = p2.memoizedState

			if enableSuspenseServerRenderer and (memoizedState ~= nil and memoizedState.dehydrated ~= nil) then
				if p1 == nil then
					invariant(popHydrationState(p2), "A dehydrated suspense component was completed without a hydrated node. This is probably a bug in React.")
					prepareToHydrateHostSuspenseInstance(p2)

					if enableSchedulerTracing then
						markSpawnedWork(OffscreenLane)
					end

					bubbleProperties(p2)

					if not enableProfilerTimer then
						return nil
					end

					if bit32.band(p2.mode, ProfileMode) == NoMode then
						return nil
					end

					if memoizedState == nil then
						return nil
					end

					local child = p2.child

					if child == nil then
						return nil
					end

					p2.treeBaseDuration = child.treeBaseDuration
				else
					resetHydrationState()

					if bit32.band(p2.flags, DidCapture) == NoFlags then
						p2.memoizedState = nil
					end

					p2.flags = bit32.bor(p2.flags, Update)
					bubbleProperties(p2)

					if not enableProfilerTimer then
						return nil
					end

					if bit32.band(p2.mode, ProfileMode) == NoMode then
						return nil
					end

					if memoizedState == nil then
						return nil
					end

					local child = p2.child

					if child == nil then
						return nil
					end

					p2.treeBaseDuration = p2.treeBaseDuration - child.treeBaseDuration
				end

				return nil
			end

			if bit32.band(p2.flags, DidCapture) == NoFlags then
				local v40 = if memoizedState == nil then false else true
				local v41 = false

				if p1 == nil then
					if p2.memoizedProps.fallback ~= nil then
						popHydrationState(p2)
					end
				else
					v41 = if p1.memoizedState == nil then false else true
				end

				if v40 and not v41 and bit32.band(p2.mode, BlockingMode) ~= NoMode then
					local v43 = if p1 == nil then if p2.memoizedProps.unstable_avoidThisFallback == true then false else true else false

					if v43 or hasSuspenseContext(suspenseStackCursor.current, InvisibleParentSuspenseContext) then
						renderDidSuspend()
					else
						renderDidSuspendDelayIfPossible()
					end
				end

				if supportsPersistence and v40 then
					p2.flags = bit32.bor(p2.flags, Update)
				end

				if supportsMutation and (v40 or v41) then
					p2.flags = bit32.bor(p2.flags, Update)
				end

				if enableSuspenseCallback and (p2.updateQueue ~= nil and p2.memoizedProps.suspenseCallback ~= nil) then
					p2.flags = bit32.bor(p2.flags, Update)
				end

				bubbleProperties(p2)

				if not enableProfilerTimer then
					return nil
				end

				if bit32.band(p2.mode, ProfileMode) == NoMode or not v40 then
					return nil
				end

				local child = p2.child

				if child == nil then
					return nil
				end

				p2.treeBaseDuration = p2.treeBaseDuration - child.treeBaseDuration

				return nil
			end

			p2.lanes = p3

			if enableProfilerTimer and bit32.band(p2.mode, ProfileMode) ~= NoMode then
				transferActualDuration(p2)
			end

			return p2
		end

		if p2.tag == HostPortal then
			popHostContainer(p2)
			v9(p1, p2)

			if p1 == nil then
				preparePortalMount(p2.stateNode.containerInfo)
			end

			bubbleProperties(p2)
		else
			if p2.tag == ContextProvider then
				popProvider(p2)
				bubbleProperties(p2)

				return nil
			end

			if p2.tag == IncompleteClassComponent then
				if isContextProvider(p2.type) then
					popContext(p2)
				end

				bubbleProperties(p2)
			else
				if p2.tag == SuspenseListComponent then
					print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					print("UNIMPLEMENTED ERROR: " .. tostring("SuspenseListComponent"))
					error("FIXME (roblox): SuspenseListComponent is unimplemented", 2)
				elseif p2.tag == FundamentalComponent then
					print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					print("UNIMPLEMENTED ERROR: " .. tostring("FundamentalComponent"))
					error("FIXME (roblox): FundamentalComponent is unimplemented", 2)
				elseif p2.tag == ScopeComponent then
					print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					print("UNIMPLEMENTED ERROR: " .. tostring("ScopeComponent"))
					error("FIXME (roblox): ScopeComponent is unimplemented", 2)
				elseif p2.tag == Block then
					print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					print("UNIMPLEMENTED ERROR: " .. tostring("Block"))
					error("FIXME (roblox): Block is unimplemented", 2)
				elseif p2.tag == OffscreenComponent or p2.tag == LegacyHiddenComponent then
					popRenderLanes(p2)

					local v49 = if p2.memoizedState == nil then false else true

					if p1 ~= nil and ((if p1.memoizedState == nil then false else true) ~= v49 and pendingProps.mode ~= "unstable-defer-without-hiding") then
						p2.flags = bit32.bor(p2.flags, Update)
					end

					if v49 and not includesSomeLane(v5.subtreeRenderLanes, OffscreenLane) and bit32.band(p2.mode, ConcurrentMode) ~= NoMode then
						return nil
					end

					bubbleProperties(p2)

					return nil
				end

				invariant(false, "Unknown unit of work tag (%s). This error is likely caused by a bug in React. Please file an issue.", (tostring(p2.tag)))
			end
		end

		return nil
	end
}