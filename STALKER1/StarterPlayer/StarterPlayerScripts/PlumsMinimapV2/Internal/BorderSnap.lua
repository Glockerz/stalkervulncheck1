-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function getCornerPosition(p1, p2, p3, p4) --[[ getCornerPosition | Line: 3 ]]
	return Vector2.new(p3, p3), Vector2.new(p3, p2.Y - p3), Vector2.new(p2.X - p3, p3), Vector2.new(p2.X - p3, p2.Y - p3)
end

local function getRadius(p1, p2) --[[ getRadius | Line: 7 | Upvalues: getCornerPosition (copy) ]]
	local v1 = math.min(p2.X, p2.Y)

	math.max(p2.X, p2.Y)

	local v2 = v1 * math.clamp(p1.Scale, 0, 0.5)
	local v3 = v2 + math.clamp(p1.Offset, 0, v1 / 2)

	return v3, getCornerPosition(v1, p2, v3)
end

local function check(p1, p2, p3, p4, p5) --[[ check | Line: 14 ]]
	if p1.X < p2.X and p1.Y < p2.Y then
		return "left-top"
	end

	if p1.X < p3.X and p1.Y > p3.Y then
		return "left-bottom"
	end

	if p1.X > p4.X and p1.Y < p4.Y then
		return "right-top"
	end

	if p1.X > p5.X and p1.Y > p5.Y then
		return "right-bottom"
	end
end

local function clamp(p1, p2, p3, p4) --[[ clamp | Line: 30 ]]
	local magnitude = (p1 - p2).magnitude

	if not (p3 < magnitude) then
		return p1
	end

	if p4 == "left-top" then
		local v2 = math.acos(Vector2.new(p2.X - p1.X, p2.Y - p1.Y).Y / magnitude)

		return p2 - Vector2.new(p3 * math.sin(v2), p3 * math.cos(v2))
	end

	if p4 == "left-bottom" then
		local v4 = math.acos(Vector2.new(p2.X - p1.X, p2.Y - p1.Y).Y / magnitude)

		return p2 - Vector2.new(p3 * math.sin(v4), p3 * math.cos(v4))
	end

	if p4 == "right-top" then
		local v6 = math.acos(Vector2.new(p1.X - p2.X, p1.Y - p2.Y).Y / magnitude)

		return p2 + Vector2.new(p3 * math.sin(v6), p3 * math.cos(v6))
	end

	local v8 = math.acos(Vector2.new(p1.X - p2.X, p1.Y - p2.Y).Y / magnitude)

	return p2 + Vector2.new(p3 * math.sin(v8), p3 * math.cos(v8))
end

return function(p1, p2, p3) --[[ Line: 72 | Upvalues: getCornerPosition (copy), check (copy), clamp (copy) ]]
	local v1 = math.min(p2.X, p2.Y)

	math.max(p2.X, p2.Y)

	local v2 = v1 * math.clamp(p3.Scale, 0, 0.5)
	local v3 = v2 + math.clamp(p3.Offset, 0, v1 / 2)
	local v4, v5, v6, v7 = getCornerPosition(v1, p2, v3)
	local v8 = check(p1, v4, v5, v6, v7)
	local v9 = if v8 == "left-top" then clamp(p1, v4, v3, v8) elseif v8 == "left-bottom" then clamp(p1, v5, v3, v8) elseif v8 == "right-top" then clamp(p1, v6, v3, v8) elseif v8 == "right-bottom" then clamp(p1, v7, v3, v8) else p1

	return Vector2.new(math.clamp(v9.X, 0, p2.X), (math.clamp(v9.Y, 0, p2.Y)))
end