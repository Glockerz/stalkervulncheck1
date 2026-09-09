-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = newproxy(false)

return function(p1) --[[ Line: 9 | Upvalues: v1 (copy) ]]
	return {
		setInterval = function(p12, p2, ...) --[[ setInterval | Line: 10 | Upvalues: v1 (ref), p1 (copy) ]]
			local t = { ... }
			local t2 = {
				[v1] = 1
			}

			if p2 == nil then
				p2 = 0
			end

			local v12 = p2 / 1000

			local function v2() --[[ Line: 24 | Upvalues: p1 (ref), v12 (copy), t2 (copy), v1 (ref), p12 (copy), t (copy), v2 (ref) ]]
				p1(v12, function() --[[ Line: 25 | Upvalues: t2 (ref), v1 (ref), p12 (ref), t (ref), v2 (ref) ]]
					if t2[v1] ~= 1 then
						return
					end

					p12(unpack(t))
					v2()
				end)
			end

			v2()

			return t2
		end,
		clearInterval = function(p1) --[[ clearInterval | Line: 38 | Upvalues: v1 (ref) ]]
			if p1 == nil then
				return
			end

			if p1[v1] ~= 1 then
				return
			end

			p1[v1] = 3
		end
	}
end