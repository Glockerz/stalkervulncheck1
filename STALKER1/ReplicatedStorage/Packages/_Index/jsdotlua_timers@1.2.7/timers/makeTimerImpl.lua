-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = newproxy(false)

return function(p1) --[[ Line: 10 | Upvalues: v1 (copy) ]]
	return {
		setTimeout = function(p12, p2, ...) --[[ setTimeout | Line: 11 | Upvalues: v1 (ref), p1 (copy) ]]
			local t = { ... }
			local t2 = {
				[v1] = 1
			}

			if p2 == nil then
				p2 = 0
			end

			p1(p2 / 1000, function() --[[ Line: 24 | Upvalues: t2 (copy), v1 (ref), p12 (copy), t (copy) ]]
				if t2[v1] ~= 1 then
					return
				end

				p12(unpack(t))
				t2[v1] = 2
			end)

			return t2
		end,
		clearTimeout = function(p1) --[[ clearTimeout | Line: 34 | Upvalues: v1 (ref) ]]
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