-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"))
local NoLanes = ReactFiberLane.NoLanes
local mergeLanes = ReactFiberLane.mergeLanes

return {
	workInProgressRootSkippedLanes = function(p1) --[[ Line: 24 | Upvalues: NoLanes (ref) ]]
		if p1 ~= nil then
			NoLanes = p1
		end

		return NoLanes
	end,
	markSkippedUpdateLanes = function(p1) --[[ Line: 34 | Upvalues: NoLanes (ref), mergeLanes (copy) ]]
		NoLanes = mergeLanes(p1, NoLanes)
	end
}