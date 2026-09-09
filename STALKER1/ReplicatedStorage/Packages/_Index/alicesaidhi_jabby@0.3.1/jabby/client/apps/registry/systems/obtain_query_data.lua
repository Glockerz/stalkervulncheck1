-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide)
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes)
local effect = vide.effect
local batch = vide.batch
local cleanup = vide.cleanup

local function generate_random_query_id() --[[ generate_random_query_id | Line: 27 ]]
	return math.random(2147483647)
end

return function(p1) --[[ Line: 31 | Upvalues: effect (copy), queue (copy), remotes (copy), cleanup (copy), batch (copy) ]]
	local v1 = false
	local v2 = false

	effect(function() --[[ Line: 36 | Upvalues: p1 (copy), v1 (ref) ]]
		if not (#p1.query() > 0) then
			return
		end

		v1 = true
	end)
	effect(function() --[[ Line: 42 | Upvalues: p1 (copy), v2 (ref) ]]
		p1.from()
		p1.upto()
		v2 = true
	end)

	local v3 = -1
	local v4 = 0
	local v5 = queue(remotes.update_query_result)
	local v6 = queue(remotes.count_total_entities)
	local columns = p1.columns
	local t = {
		host = p1.host,
		to_vm = p1.vm
	}

	cleanup(function() --[[ Line: 59 | Upvalues: remotes (ref), t (copy), v3 (ref) ]]
		remotes.disconnect_query:fire(t, v3)
	end)

	local v7 = false

	effect(function() --[[ Line: 64 | Upvalues: p1 (copy), v7 (ref) ]]
		if p1.refresh() == true then
			p1.refresh(false)
			v7 = true
		end
	end)

	local v8 = p1.paused()
	local v9 = false

	effect(function() --[[ Line: 72 | Upvalues: v9 (ref), v8 (ref), p1 (copy) ]]
		v9 = true
		v8 = p1.paused()
	end)

	return function() --[[ Line: 77 | Upvalues: v1 (ref), columns (copy), remotes (ref), t (copy), v3 (ref), p1 (copy), v4 (ref), v8 (ref), v2 (ref), v6 (copy), v9 (ref), v7 (ref), batch (ref), v5 (copy) ]]
		if v1 then
			columns({})
			remotes.disconnect_query:fire(t, v3)
			v3 = math.random(2147483647)
			remotes.request_query:fire(t, p1.id, v3, p1.query())
			remotes.advance_query_page:fire(t, v3, p1.from(), p1.upto())
			v4 = 0
			v1 = false
			remotes.pause_query:fire(t, v3, v8)
		end

		if v2 then
			remotes.advance_query_page:fire(t, v3, p1.from(), p1.upto())
			v2 = false
		end

		for v12, v22, v32 in v6:iter() do
			if v22 == v3 then
				p1.total_entities(v32)
			end
		end

		if v9 then
			remotes.pause_query:fire(t, v3, v8)
			v9 = false
		end

		if v7 then
			remotes.refresh_results:fire(t, v3)
			v7 = false
		end

		batch(function() --[[ Line: 112 | Upvalues: v5 (ref), v3 (ref), v4 (ref), columns (ref) ]]
			for v1, v2, v32, v42, v52, v6 in v5:iter() do
				if v2 == v3 and not (v32 < v4 - 10) then
					v4 = math.max(v4, v32)

					if columns()[v42] == nil then
						columns()[v42] = {}
					end

					columns()[v42][v52] = v6
					columns(columns())
				end
			end
		end)
	end
end