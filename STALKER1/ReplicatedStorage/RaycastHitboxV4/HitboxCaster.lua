-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Heartbeat = game:GetService("RunService").Heartbeat
local CollectionService = game:GetService("CollectionService")
local VisualizerCache = require(script.Parent.VisualizerCache)
local t = {}
local Solvers = script.Parent:WaitForChild("Solvers")
local t2 = {}

t2.__index = t2
t2.__type = "RaycastHitbox"
t2.CastModes = {
	LinkAttachments = 1,
	Attachment = 2,
	Vector3 = 3,
	Bone = 4
}
function t2.HitStart(p1, p2) --[[ HitStart | Line: 54 ]]
	if p1.HitboxActive then
		p1:HitStop()
	end

	if p2 then
		p1.HitboxStopTime = os.clock() + math.max(1 / 60, p2)
	end

	p1.HitboxActive = true
end
function t2.HitStop(p1) --[[ HitStop | Line: 68 ]]
	p1.HitboxActive = false
	p1.HitboxStopTime = 0
	table.clear(p1.HitboxHitList)
end
function t2.Destroy(p1) --[[ Destroy | Line: 75 | Upvalues: CollectionService (copy) ]]
	p1.HitboxPendingRemoval = true

	if p1.HitboxObject then
		CollectionService:RemoveTag(p1.HitboxObject, p1.Tag)
	end

	p1:HitStop()
	p1.OnHit:Destroy()
	p1.OnUpdate:Destroy()
end
function t2.Recalibrate(p1) --[[ Recalibrate | Line: 88 | Upvalues: t2 (copy) ]]
	local count = 0

	for i, v in ipairs((p1.HitboxObject:GetDescendants())) do
		if v:IsA("Attachment") and v.Name == "DmgPoint" then
			local v2 = p1:_CreatePoint(v:GetAttribute("Group"), t2.CastModes.Attachment, v.WorldPosition)

			table.insert(v2.Instances, v)
			table.insert(p1.HitboxRaycastPoints, v2)
			count = count + 1
		end
	end

	if not p1.DebugLog then
		return
	end

	print(string.format("%s%s", "[ Raycast Hitbox V4 ]\n", count > 0 and string.format("%s attachments found in object: %s.", count, p1.HitboxObject.Name) or string.format("No attachments found in object: %s. Can be safely ignored if using SetPoints.", p1.HitboxObject.Name)))
end
function t2.LinkAttachments(p1, p2, p3) --[[ LinkAttachments | Line: 117 | Upvalues: t2 (copy) ]]
	local v1 = p1:_CreatePoint(p2:GetAttribute("Group"), t2.CastModes.LinkAttachments)

	v1.Instances[1] = p2
	v1.Instances[2] = p3
	table.insert(p1.HitboxRaycastPoints, v1)
end
function t2.UnlinkAttachments(p1, p2) --[[ UnlinkAttachments | Line: 128 ]]
	for i = #p1.HitboxRaycastPoints, 1, -1 do
		if #p1.HitboxRaycastPoints[i].Instances >= 2 and (p1.HitboxRaycastPoints[i].Instances[1] == p2 or p1.HitboxRaycastPoints[i].Instances[2] == p2) then
			table.remove(p1.HitboxRaycastPoints, i)
		end
	end
end
function t2.SetPoints(p1, p2, p3, p4) --[[ SetPoints | Line: 142 | Upvalues: t2 (copy) ]]
	for i, v in ipairs(p3) do
		local v2 = p1:_CreatePoint(p4, t2.CastModes[if p2:IsA("Bone") then "Bone" else "Vector3"])

		v2.Instances[1] = p2
		v2.Instances[2] = v
		table.insert(p1.HitboxRaycastPoints, v2)
	end
end
function t2.RemovePoints(p1, p2, p3) --[[ RemovePoints | Line: 155 ]]
	for i = #p1.HitboxRaycastPoints, 1, -1 do
		if p1.HitboxRaycastPoints[i].Instances[1] == p2 then
			local v1 = p1.HitboxRaycastPoints[i].Instances[2]

			for i2, v in ipairs(p3) do
				if v == v1 then
					table.remove(p1.HitboxRaycastPoints, i)

					break
				end
			end
		end
	end
end
function t2._CreatePoint(p1, p2, p3, p4) --[[ _CreatePoint | Line: 176 ]]
	return {
		WorldSpace = nil,
		Group = p2,
		CastMode = p3,
		LastPosition = p4,
		Instances = {}
	}
end
function t2._FindHitbox(p1, p2) --[[ _FindHitbox | Line: 188 | Upvalues: t (copy) ]]
	for i, v in ipairs(t) do
		if v.HitboxObject == p2 then
			return v
		end
	end
end
function t2._Init(p1) --[[ _Init | Line: 198 | Upvalues: t (copy), CollectionService (copy) ]]
	if p1.HitboxObject then
		local v1 = nil

		local function onTagRemoved(p12) --[[ onTagRemoved | Line: 203 | Upvalues: p1 (copy), v1 (ref) ]]
			if p12 ~= p1.HitboxObject then
				return
			end

			v1:Disconnect()
			p1:Destroy()
		end

		p1:Recalibrate()
		table.insert(t, p1)
		CollectionService:AddTag(p1.HitboxObject, p1.Tag)
		v1 = CollectionService:GetInstanceRemovedSignal(p1.Tag):Connect(onTagRemoved)
	end
end
(function() --[[ Init | Line: 217 | Upvalues: Solvers (copy), Heartbeat (copy), t (copy), VisualizerCache (copy), t2 (copy) ]]
	local v1 = table.create(#Solvers:GetChildren())

	Heartbeat:Connect(function(p1) --[[ Line: 221 | Upvalues: t (ref), v1 (copy), VisualizerCache (ref) ]]
		for i = #t, 1, -1 do
			if t[i].HitboxPendingRemoval then
				setmetatable(table.remove(t, i), nil)

				continue
			end

			for i2, v in ipairs(t[i].HitboxRaycastPoints) do
				local v2

				if t[i].HitboxActive then
					local v3 = v1[v.CastMode]
					local v4, v5 = v3:Solve(v)
					local v6 = workspace:Raycast(v4, v5, t[i].RaycastParams)

					if t[i].Visualizer then
						local v7 = VisualizerCache:GetAdornment()

						if v7 then
							local v8 = v3:Visualize(v)

							v7.Adornment.Length = v5.Magnitude
							v7.Adornment.CFrame = v8
						end
					end

					v.LastPosition = v3:UpdateToNextPosition(v)

					if v6 then
						local v9 = v6.Instance
						local v10 = nil

						if t[i].DetectionMode == 1 then
							local v11 = v9:FindFirstAncestorOfClass("Model")

							if v11 then
								v10 = v11:FindFirstChildOfClass("Humanoid")
							end

							v2 = v10
						else
							v2 = v9
						end

						if v2 then
							if t[i].DetectionMode <= 2 then
								if not t[i].HitboxHitList[v2] then
									t[i].HitboxHitList[v2] = true
									t[i].OnHit:Fire(v9, v10, v6, v.Group)

									if t[i].HitboxStopTime > 0 and t[i].HitboxStopTime <= os.clock() then
										t[i].HitboxStopTime = 0
										t[i]:HitStop()
									end

									t[i].OnUpdate:Fire(v.LastPosition)
								end
							else
								t[i].OnHit:Fire(v9, v10, v6, v.Group)

								if t[i].HitboxStopTime > 0 and t[i].HitboxStopTime <= os.clock() then
									t[i].HitboxStopTime = 0
									t[i]:HitStop()
								end

								t[i].OnUpdate:Fire(v.LastPosition)
							end
						else
							if t[i].HitboxStopTime > 0 and t[i].HitboxStopTime <= os.clock() then
								t[i].HitboxStopTime = 0
								t[i]:HitStop()
							end

							t[i].OnUpdate:Fire(v.LastPosition)
						end
					else
						if t[i].HitboxStopTime > 0 and t[i].HitboxStopTime <= os.clock() then
							t[i].HitboxStopTime = 0
							t[i]:HitStop()
						end

						t[i].OnUpdate:Fire(v.LastPosition)
					end

					continue
				end

				v.LastPosition = nil
			end
		end

		local v12 = #VisualizerCache._AdornmentInUse

		if not (v12 > 0) then
			return
		end

		for j = v12, 1, -1 do
			if os.clock() - VisualizerCache._AdornmentInUse[j].LastUse >= 0.25 then
				local v13 = table.remove(VisualizerCache._AdornmentInUse, j)

				if v13 then
					VisualizerCache:ReturnAdornment(v13)
				end
			end
		end
	end)

	for k, v in pairs(t2.CastModes) do
		local v2 = Solvers:FindFirstChild(k)

		if v2 then
			v1[v] = require(v2)
		end
	end
end)()

return t2