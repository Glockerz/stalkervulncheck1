-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"))

require(script.Parent:WaitForChild("ReactFiberLane"))

local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"))
local NoFlags = ReactFiberFlags.NoFlags
local DidCapture = ReactFiberFlags.DidCapture
local isSuspenseInstancePending = ReactFiberHostConfig.isSuspenseInstancePending
local isSuspenseInstanceFallback = ReactFiberHostConfig.isSuspenseInstanceFallback

return {
	shouldCaptureSuspense = function(p1, p2) --[[ Line: 83 ]]
		local memoizedState = p1.memoizedState

		if memoizedState then
			return memoizedState.dehydrated ~= nil
		end

		local memoizedProps = p1.memoizedProps

		if memoizedProps.fallback == nil then
			return false
		end

		if memoizedProps.unstable_avoidThisFallback == true then
			return not p2
		end

		return true
	end,
	findFirstSuspended = function(p1) --[[ Line: 112 | Upvalues: SuspenseComponent (copy), isSuspenseInstancePending (copy), isSuspenseInstanceFallback (copy), SuspenseListComponent (copy), DidCapture (copy), NoFlags (copy) ]]
		local v1 = p1

		while v1 ~= nil do
			if v1.tag == SuspenseComponent then
				local memoizedState = v1.memoizedState

				if memoizedState then
					local dehydrated = memoizedState.dehydrated

					if dehydrated == nil or (isSuspenseInstancePending(dehydrated) or isSuspenseInstanceFallback(dehydrated)) then
						return v1
					end
				end
			else
				if v1.tag ~= SuspenseListComponent or v1.memoizedProps.revealOrder == nil then
					if v1.child == nil then
						if v1 == p1 then
							break
						end

						while v1.sibling == nil do
							if v1.return_ == nil or v1.return_ == p1 then
								return nil
							end

							v1 = v1.return_
						end

						v1.sibling.return_ = v1.return_
						v1 = v1.sibling
					else
						v1.child.return_ = v1
						v1 = v1.child
					end

					continue
				end

				if bit32.band(v1.flags, DidCapture) ~= NoFlags then
					return v1
				end
			end

			if v1 == p1 then
				break
			end

			while v1.sibling == nil do
				if v1.return_ == nil or v1.return_ == p1 then
					return nil
				end

				v1 = v1.return_
			end

			v1.sibling.return_ = v1.return_
			v1 = v1.sibling
		end

		return nil
	end
}