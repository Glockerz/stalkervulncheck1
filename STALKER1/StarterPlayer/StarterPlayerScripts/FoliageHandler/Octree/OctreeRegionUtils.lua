-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

local function v1(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) --[[ GetNeighborsWithinRadius | Line: 23 | Upvalues: v1 (copy) ]]
	if not p8 then
		error("Missing MaxDepth.")
	end

	local v12 = p2 + 0.8660254037844386 * (p1.Size[1] / 2)
	local v2 = p2 * p2
	local v3 = v12 * v12 + 1e-6

	for v4, v5 in next, p1.SubRegions do
		local Position = v5.Position
		local v7 = p3 - Position[1]
		local v8 = p4 - Position[2]
		local v9 = p5 - Position[3]

		if v7 * v7 + v8 * v8 + v9 * v9 <= v3 then
			if v5.Depth == p8 then
				for v10 in next, v5.Nodes do
					local v11 = v10.PositionX - p3
					local v122 = v10.PositionY - p4
					local v13 = v10.PositionZ - p5
					local v14 = v11 * v11 + v122 * v122 + v13 * v13

					if v14 <= v2 then
						p9 = p9 + 1
						p10 = p10 + 1
						p6[p9] = v10.Object
						p7[p10] = v14
					end
				end

				continue
			end

			local v15, v16 = v1(v5, p2, p3, p4, p5, p6, p7, p8, p9, p10)

			p10 = v16
			p9 = v15
		end
	end

	return p9, p10
end

t.GetNeighborsWithinRadius = v1

return t