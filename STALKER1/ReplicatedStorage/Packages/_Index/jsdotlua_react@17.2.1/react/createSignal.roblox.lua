-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ createSignal | Line: 36 ]]
	local t = {}
	local t2 = {}
	local v1 = false

	return function(p1) --[[ subscribe | Line: 41 | Upvalues: v1 (ref), t (copy), t2 (copy) ]]
		assert(typeof(p1) == "function", "Can only subscribe to signals with a function.")

		local t3 = {
			disconnected = false,
			callback = p1
		}

		if v1 and not t[p1] then
			t2[p1] = t3
		end

		t[p1] = t3

		return function() --[[ disconnect | Line: 60 | Upvalues: t3 (copy), t (ref), p1 (copy), t2 (ref) ]]
			assert(not t3.disconnected, "Listeners can only be disconnected once.")
			t3.disconnected = true
			t[p1] = nil
			t2[p1] = nil
		end
	end, function(...) --[[ fire | Line: 74 | Upvalues: v1 (ref), t (copy), t2 (copy) ]]
		v1 = true

		for v12, v2 in t do
			if not (v2.disconnected or t2[v12]) then
				v12(...)
			end
		end

		v1 = false
		table.clear(t2)
	end
end