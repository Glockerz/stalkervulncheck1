-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local source = require(script.Parent.Parent.Parent.vide).source
local v1 = newproxy()

return {
	new = function(p1, p2) --[[ new | Line: 22 | Upvalues: source (copy), v1 (copy) ]]
		local t = {}

		for v2, v3 in p1 do
			local v12

			v12 = if v3 == v1 or not v3 then nil else v3
			t[v2] = source(v12)
		end

		local t2 = {}

		setmetatable(t2, {
			__index = function(p1, p2) --[[ __index | Line: 36 | Upvalues: t (copy) ]]
				return t[p2]()
			end,
			__newindex = function(p1, p2, p3) --[[ __newindex | Line: 39 | Upvalues: t (copy) ]]
				t[p2](p3)
			end
		})

		local t4 = {}

		setmetatable(t4, {
			__index = function(p1, p2) --[[ __index | Line: 47 | Upvalues: t (copy) ]]
				local v1 = t[p2]

				if v1 ~= nil then
					return v1()
				end

				error(("invalid index %*"):format(p2), 2)
			end,
			__newindex = function(p1, p2, p3) --[[ __newindex | Line: 53 | Upvalues: t (copy) ]]
				t[p2](p3)
			end
		})

		for v5, v6 in next, p2(t2) do
			if rawget(t4, v5) then
				error(("duplicate field \"%*\""):format(v5), 2)
			end

			rawset(t4, v5, v6)
		end

		return t4
	end,
	null = v1
}