-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	new = function(p1) --[[ new | Line: 3 ]]
		local v1 = tick()
		local v2 = p1 or 0
		local v3 = p1 and 0 * p1 or 0
		local v4 = p1 or 0
		local v5 = 1
		local v6 = 1

		local function positionvelocity(p1) --[[ positionvelocity | Line: 11 | Upvalues: v1 (ref), v2 (ref), v4 (ref), v6 (ref), v5 (ref), v3 (ref) ]]
			local v12 = p1 - v1
			local v22 = v2 - v4

			if v6 == 0 then
				return v2, 0
			end

			if v5 < 1 then
				local v32 = (1 - v5 * v5) ^ 0.5
				local v42 = (v3 / v6 + v5 * v22) / v32
				local v62 = math.cos(v32 * v6 * v12)
				local v8 = math.sin(v32 * v6 * v12)
				local v9 = 2.718281828459045 ^ (v5 * v6 * v12)

				return v4 + (v22 * v62 + v42 * v8) / v9, v6 * ((v32 * v42 - v5 * v22) * v62 - (v32 * v22 + v5 * v42) * v8) / v9
			end

			local v10 = v3 / v6 + v22
			local v11 = 2.718281828459045 ^ (v6 * v12)

			return v4 + (v22 + v10 * v6 * v12) / v11, v6 * (v10 - v22 - v10 * v6 * v12) / v11
		end

		local t = {
			accelerate = function(p1, p2) --[[ accelerate | Line: 34 | Upvalues: positionvelocity (copy), v2 (ref), v3 (ref), v1 (ref) ]]
				local v12 = tick()
				local v22, v32 = positionvelocity(v12)

				v2 = v22
				v3 = v32 + p2
				v1 = v12
			end
		}
		local t2 = {
			__index = function(p1, p2) --[[ __index | Line: 44 | Upvalues: positionvelocity (copy), v1 (ref), v2 (ref), v4 (ref), v6 (ref), v5 (ref), v3 (ref) ]]
				if p2 == "value" or (p2 == "position" or p2 == "p") then
					local v12, _ = positionvelocity(tick())

					return v12
				end

				if p2 == "velocity" or p2 == "v" then
					local _, v22 = positionvelocity(tick())

					return v22
				end

				if p2 == "acceleration" or p2 == "a" then
					local v32 = tick() - v1
					local v42 = v2 - v4

					if v6 == 0 then
						return 0
					end

					if v5 < 1 then
						local v52 = (1 - v5 * v5) ^ 0.5
						local v62 = (v3 / v6 + v5 * v42) / v52

						return v6 * v6 * ((v5 * v5 * v42 - v52 * 2 * v5 * v62 - v52 * v52 * v42) * cos(v52 * v6 * v32) + (v5 * v5 * v62 + v52 * 2 * v5 * v42 - v52 * v52 * v62) * sin(v52 * v6 * v32)) / 2.718281828459045 ^ (v5 * v6 * v32)
					end

					local v7 = v3 / v6 + v42

					return v6 * v6 * (v42 - 2 * v7 + v7 * v6 * v32) / 2.718281828459045 ^ (v6 * v32)
				end

				if p2 == "target" or p2 == "t" then
					return v4
				end

				if p2 == "damper" or p2 == "d" then
					return v5
				end

				if p2 == "speed" or p2 == "s" then
					return v6
				end

				error(p2 .. " is not a valid member of spring", 0)
			end,
			__newindex = function(p1, p2, p3) --[[ __newindex | Line: 85 | Upvalues: positionvelocity (copy), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), v1 (ref) ]]
				local v12 = tick()

				if p2 == "value" or (p2 == "position" or p2 == "p") then
					local _, v22 = positionvelocity(v12)

					v2 = p3
					v3 = v22
				elseif p2 == "velocity" or p2 == "v" then
					local v32, _ = positionvelocity(v12)

					v2 = v32
					v3 = p3
				elseif p2 == "acceleration" or p2 == "a" then
					local v42, v52 = positionvelocity(v12)

					v2 = v42
					v3 = v52 + p3
				elseif p2 == "target" or p2 == "t" then
					local v62, v7 = positionvelocity(v12)

					v2 = v62
					v3 = v7
					v4 = p3
				elseif p2 == "damper" or p2 == "d" then
					local v8, v9 = positionvelocity(v12)

					v2 = v8
					v3 = v9
					v5 = if p3 < 0 then 0 elseif p3 < 1 then p3 else 1
				elseif p2 == "speed" or p2 == "s" then
					local v11, v122 = positionvelocity(v12)

					v2 = v11
					v3 = v122
					v6 = if p3 < 0 then 0 else p3
				else
					error(p2 .. " is not a valid member of spring", 0)
				end

				v1 = v12
			end
		}

		return setmetatable(t, t2)
	end
}