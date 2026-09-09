-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local _ = script.Parent
local t = {}
local t2 = {}
local clock = os.clock

function t2.add(p1, p2) --[[ add | Line: 16 | Upvalues: t (copy) ]]
	assert(typeof(p2) ~= "Instance", "Make sure you are initializing from the Raycast module, not from this handler.")
	table.insert(t, p2)
end
function t2.remove(p1, p2) --[[ remove | Line: 21 | Upvalues: t (copy) ]]
	for i in ipairs(t) do
		if t[i].object == p2 then
			t[i]:Destroy()
			setmetatable(t[i], nil)
			table.remove(t, i)
		end
	end
end
function t2.check(p1, p2) --[[ check | Line: 31 | Upvalues: t (copy) ]]
	for i, v in ipairs(t) do
		if v.object == p2 then
			return v
		end
	end
end
function OnTagRemoved(p1) --[[ OnTagRemoved | Line: 39 | Upvalues: t2 (copy) ]]
	t2:remove(p1)
end
CollectionService:GetInstanceRemovedSignal("RaycastModuleManaged"):Connect(OnTagRemoved)
RunService.Heartbeat:Connect(function() --[[ Line: 47 | Upvalues: t (copy), t2 (copy), clock (copy) ]]
	for i, v in ipairs(t) do
		if v.deleted then
			t2:remove(v.object)

			continue
		end

		for i2, v2 in ipairs(v.points) do
			if v.active then
				local v1, v22, v3 = v2.solver:solve(v2, v.debugMode)
				local v4 = workspace:Raycast(v1, v22, v.raycastParams)

				v2.solver:lastPosition(v2, v3)

				if v4 then
					local v5 = v4.Instance
					local v6 = not v.partMode and v5:FindFirstAncestorOfClass("Model")
					local v7 = if v6 then v6:FindFirstChildOfClass("Humanoid") else v6
					local v8 = if v7 then v7 else v.partMode and v5

					if v8 and not v.targetsHit[v8] then
						v.targetsHit[v8] = true
						v.OnHit:Fire(v5, v7, v4, v2.group)
					end
				end

				if v.endTime > 0 and v.endTime <= clock() then
					v.endTime = 0
					v:HitStop()
				end

				v.OnUpdate:Fire(v2.LastPosition)

				continue
			end

			v2.LastPosition = nil
		end
	end
end)

return t2