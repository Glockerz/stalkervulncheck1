-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function pointToViewport(p1, p2, p3, p4) --[[ pointToViewport | Line: 1 ]]
	local v1 = p1:PointToObjectSpace(p3)
	local v5 = -v1.z * math.tan((math.rad(p2 / 2)))
	local v6 = p4.X / p4.Y * v5
	local v7 = v1 - Vector3.new(-v6, v5, v1.z)
	local v8 = v7.x / (v6 * 2)
	local v9 = -v7.y / (v5 * 2)
	local _ = -v1.z > 0 and (v8 >= 0 and (v8 <= 1 and v9 >= 0))

	return Vector2.new(v8 * p4.X, v9 * p4.Y)
end

function ViewportPointToRay(p1, p2, p3, p4) --[[ ViewportPointToRay | Line: 20 ]]
	local v5 = math.tan(math.rad(p2) / 2)

	return Ray.new(p1.Position, (p1:VectorToWorldSpace(Vector3.new((p3.X / p4.X * 2 - 1) * v5 * (p4.X / p4.Y), (1 - p3.Y / p4.Y * 2) * v5, -1).Unit)))
end
function ViewportPointToPlanePoint(p1, p2, p3, p4, p5) --[[ ViewportPointToPlanePoint | Line: 39 ]]
	local v1 = ViewportPointToRay(p1, p2, p3, p4)

	if v1.Direction.Unit.Y == 0 then
		return Vector3.new(v1.Origin.X, p5, v1.Origin.Z)
	end

	return v1.Origin + v1.Direction.Unit * ((p5 - v1.Origin.Y) / v1.Direction.Unit.Y)
end

return {
	ViewportToPointRay = ViewportPointToRay,
	PointToViewport = pointToViewport,
	ViewportPointToPlanePoint = ViewportPointToPlanePoint
}