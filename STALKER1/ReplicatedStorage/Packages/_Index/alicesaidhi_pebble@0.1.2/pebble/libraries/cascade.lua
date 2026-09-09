-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.vide)
local action = vide.action
local cleanup = vide.cleanup

return function(p1) --[[ cascade | Line: 14 | Upvalues: action (copy), cleanup (copy) ]]
	local t = {}
	local t2 = {}

	local function get_cascaded_value(p12) --[[ get_cascaded_value | Line: 19 | Upvalues: t2 (copy), p1 (copy) ]]
		while p12 ~= nil do
			local v1 = t2[p12]

			if v1 ~= nil then
				return v1
			end

			p12 = p12.Parent
		end

		return p1
	end

	function t.send(p1) --[[ send | Line: 31 | Upvalues: action (ref), cleanup (ref), t2 (copy) ]]
		return action(function(p12) --[[ Line: 32 | Upvalues: cleanup (ref), t2 (ref), p1 (copy) ]]
			cleanup(function() --[[ Line: 33 | Upvalues: t2 (ref), p12 (copy) ]]
				t2[p12] = nil
			end)
			t2[p12] = p1
		end)
	end
	function t.receive(p12) --[[ receive | Line: 41 | Upvalues: action (ref), t2 (copy), p1 (copy), cleanup (ref) ]]
		return action(function(p13) --[[ Line: 42 | Upvalues: p12 (copy), t2 (ref), p1 (ref), cleanup (ref) ]]
			local function recalculate() --[[ recalculate | Line: 43 | Upvalues: p12 (ref), p13 (copy), t2 (ref), p1 (ref) ]]
				local v1 = p12
				local v2 = p13.Parent

				while v2 ~= nil do
					local v3
					local v4 = t2[v2]

					if v4 == nil then
						v2 = v2.Parent
					else
						v3 = v4
						v1(v4)

						return
					end
				end

				v1(p1)
			end

			local v1 = p12
			local v2 = p13.Parent

			while v2 ~= nil do
				local v3
				local v4 = t2[v2]

				if v4 == nil then
					v2 = v2.Parent
				else
					v3 = v4
					v1(v4)
					cleanup(p13.AncestryChanged:Connect(recalculate))
					cleanup(function() --[[ Line: 52 | Upvalues: p12 (ref), p1 (ref) ]]
						p12(p1)
					end)

					return
				end
			end

			v1(p1)
			cleanup(p13.AncestryChanged:Connect(recalculate))
			cleanup(function() --[[ Line: 52 | Upvalues: p12 (ref), p1 (ref) ]]
				p12(p1)
			end)
		end)
	end

	return t
end