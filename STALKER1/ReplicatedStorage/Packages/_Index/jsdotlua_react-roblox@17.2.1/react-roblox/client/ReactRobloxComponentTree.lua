-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent:WaitForChild("ReactRobloxHostTypes.roblox"))
require(script.Parent.Parent.Parent:WaitForChild("react-reconciler"))

local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local invariant = require(script.Parent.Parent.Parent:WaitForChild("shared")).invariant
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local v9 = string.sub(tostring(math.random()), 3)
local v10 = "__reactFiber$" .. v9
local v11 = "__reactContainer$" .. v9

function t.precacheFiberNode(p1, p2) --[[ Line: 65 | Upvalues: t3 (copy) ]]
	t3[p2] = p1
end
function t.uncacheFiberNode(p1) --[[ Line: 70 | Upvalues: t3 (copy), t4 (copy) ]]
	t3[p1] = nil
	t4[p1] = nil
end
function t.markContainerAsRoot(p1, p2) --[[ Line: 75 | Upvalues: t2 (copy) ]]
	t2[p2] = p1
end
function t.unmarkContainerAsRoot(p1) --[[ Line: 81 | Upvalues: t2 (copy) ]]
	t2[p1] = nil
end
function t.isContainerMarkedAsRoot(p1) --[[ Line: 87 | Upvalues: t2 (copy) ]]
	return t2[p1] and true or false
end
function t.getClosestInstanceFromNode(p1) --[[ Line: 101 | Upvalues: t3 (copy), v7 (ref) ]]
	local v1 = t3[p1]

	if v1 then
		return v1
	end

	local v2 = p1.Parent

	while v2 do
		local v3 = t3[v2]

		if v3 then
			local alternate = v3.alternate

			if v3.child ~= nil or alternate ~= nil and alternate.child ~= nil then
				if v7 == nil then
					v7 = require(script.Parent.ReactRobloxHostConfig).getParentSuspenseInstance
				end

				local v4 = v7(p1)

				while v4 ~= nil do
					local v5 = t3[v4]

					if v5 then
						return v5
					end

					v4 = v7(v4)
				end
			end

			return v3
		end

		v2, p1 = v2.Parent, v2
	end

	return nil
end
function t.getInstanceFromNode(p1) --[[ Line: 185 | Upvalues: v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), v10 (copy), v11 (copy) ]]
	if v2 == nil then
		v2 = require(script.Parent.Parent:WaitForChild("ReactReconciler.roblox")).ReactWorkTags
		v3 = v2.HostComponent
		v4 = v2.HostComponent
		v5 = v2.HostComponent
		v6 = v2.HostComponent
	end

	local v1 = p1[v10] or p1[v11]

	if not v1 then
		return nil
	end

	if v1.tag ~= v3 and (v1.tag ~= v4 and (v1.tag ~= v6 and v1.tag ~= v5)) then
		return nil
	end

	return v1
end
function t.getNodeFromInstance(p1) --[[ Line: 218 | Upvalues: v3 (ref), v4 (ref), invariant (copy) ]]
	if p1.tag ~= v3 and p1.tag ~= v4 then
		invariant(false, "getNodeFromInstance: Invalid argument.")
		error("getNodeFromInstance: Invalid argument.")
	end

	return p1.stateNode
end
function t.getFiberCurrentPropsFromNode(p1) --[[ Line: 233 | Upvalues: t4 (copy) ]]
	return t4[p1]
end
function t.updateFiberProps(p1, p2) --[[ Line: 237 | Upvalues: t4 (copy) ]]
	t4[p1] = p2
end

return t