-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.new() --[[ Line: 4 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Waypoints = {}
	v2.Neighbors = {}
	v2.NextSerial = 1

	return v2
end
function t.fromWaypoints(p1, p2) --[[ Line: 11 | Upvalues: t (copy) ]]
	local v1 = t.new()
	local v2 = 0

	for k, v in pairs(p1) do
		if v2 < k then
			v2 = k
		end

		v1.Waypoints[k] = v
	end

	v1.Neighbors = p2
	v1.NextSerial = v2 + 1

	return v1
end
function t.SetWaypointPosition(p1, p2, p3) --[[ SetWaypointPosition | Line: 25 ]]
	assert(p1.Waypoints[p2], "No waypoint by serial: " .. tostring(p2))
	p1.Waypoints[p2][1] = p3
end
function t.SetWaypointLabel(p1, p2, p3) --[[ SetWaypointLabel | Line: 29 ]]
	assert(p1.Waypoints[p2], "No waypoint by serial: " .. tostring(p2))
	p1.Waypoints[p2][2] = p3
end
function t.SetWaypointWeight(p1, p2, p3) --[[ SetWaypointWeight | Line: 33 ]]
	assert(p1.Waypoints[p2], "No waypoint by serial: " .. tostring(p2))
	p1.Waypoints[p2][3] = p3
end
function t.AddWaypoint(p1, p2, p3, p4) --[[ AddWaypoint | Line: 38 ]]
	local t = { p2, tostring(p3) or "", tonumber(p4) or 255 }
	local NextSerial = p1.NextSerial

	p1.Waypoints[NextSerial] = t
	p1.Neighbors[NextSerial] = {}
	p1.NextSerial = p1.NextSerial + 1

	return NextSerial
end
function t.RemoveWaypoint(p1, p2) --[[ RemoveWaypoint | Line: 46 ]]
	p1.Waypoints[p2] = nil

	for k, v in pairs(p1.Neighbors[p2]) do
		p1:DisconnectWaypoints(p2, k)
	end

	p1.Neighbors[p2] = nil
end
function t.ConnectWaypoints(p1, p2, p3, p4) --[[ ConnectWaypoints | Line: 54 ]]
	if p2 == p3 then
		warn(tostring(p2) .. " == " .. tostring(p3))

		return
	end

	if not p1.Neighbors[p2] then
		warn("Waypoint by serial: " .. tostring(p2) .. " does not exist")

		return
	end

	if not p1.Neighbors[p3] then
		warn("Waypoint by serial: " .. tostring(p3) .. " does not exist")

		return
	end

	if p4 then
		p1.Neighbors[p2][p3] = true
		p1.Neighbors[p3][p2] = true
	else
		p1.Neighbors[p2][p3] = true
		p1.Neighbors[p3][p2] = false
	end
end
function t.DisconnectWaypoints(p1, p2, p3) --[[ DisconnectWaypoints | Line: 66 ]]
	if not p1.Neighbors[p2] then
		warn("Waypoint by serial: " .. tostring(p2) .. " does not exist")

		return
	end

	if p1.Neighbors[p3] then
		p1.Neighbors[p2][p3] = nil
		p1.Neighbors[p3][p2] = nil
	else
		warn("Waypoint by serial: " .. tostring(p3) .. " does not exist")
	end
end
function t.GetWaypointAtSerial(p1, p2) --[[ GetWaypointAtSerial | Line: 73 ]]
	local v1 = p1.Waypoints[p2]

	if v1 then
		return {
			Position = v1[1],
			Label = v1[2],
			Weight = v1[3]
		}
	end

	warn("No waypoint at serial: " .. tostring(p2))

	return nil
end
function t.GetNearestWaypoint(p1, p2) --[[ GetNearestWaypoint | Line: 86 ]]
	local v1 = (1 / 0)
	local v2 = nil

	for k, v in pairs(p1.Waypoints) do
		local Magnitude = (v[1] - p2).Magnitude

		if Magnitude < v1 then
			v1 = Magnitude
			v2 = k
		end
	end

	return v2
end
function t.GetOrderedWaypoints(p1, p2, p3, p4, p5) --[[ GetOrderedWaypoints | Line: 99 ]]
	if StartPosition == p3 then
		return {
			{
				Label = "",
				Weight = 0,
				Position = p3
			}
		}, 0
	end

	local v1 = p1:GetNearestWaypoint(p3)
	local _ = p1.Waypoints[p2]
	local v2 = p1.Waypoints[v1]
	local tbl = {
		[p2] = 0
	}
	local t = {}
	local t2 = {}

	while true do
		local v3 = (1 / 0)
		local v4 = nil
		local v5 = nil

		for k, v in pairs(tbl) do
			local v6 = v + (p1.Waypoints[k][1] - v2[1]).Magnitude

			if v6 < v3 then
				v3 = v6
				v4 = k
				v5 = v
			end
		end

		tbl[v4] = nil
		t[v4] = true

		if v4 == v1 then
			v7 = v1
			v8 = {}

			while v7 do
				table.insert(v8, 1, (p1:GetWaypointAtSerial(v7)))
				v7 = if t2[v7] then t2[v7][1] else nil
			end

			table.insert(v8, {
				Label = "",
				Weight = 0,
				Position = p3
			})

			return v8, t2[v1][2]
		end

		local v10 = p1.Waypoints[v4]

		for k, v in pairs(p1.Neighbors[v4]) do
			if v then
				local v12 = p1.Waypoints[k]
				local v13 = 0

				if v4 == p2 and p5 then
					local v14 = p5:Dot((v12[1] - v10[1]).Unit)

					if v14 < -0.75 then
						v13 = (1 - v14) * 10000000000000
					end
				end

				if not t[k] then
					if tbl[k] then
						local v15 = tbl[k]

						if v15 < v5 + v13 then
							t2[k] = { v4, v15 }
							tbl[k] = v15
						end

						continue
					end

					local v16 = v5 + (v12[1] - v10[1]).Magnitude + v12[3] + v13
					local _2 = v16 + (v12[1] - v2[1]).Magnitude

					t2[k] = { v4, v16 }
					tbl[k] = v16
				end
			end
		end
	end
end

return t