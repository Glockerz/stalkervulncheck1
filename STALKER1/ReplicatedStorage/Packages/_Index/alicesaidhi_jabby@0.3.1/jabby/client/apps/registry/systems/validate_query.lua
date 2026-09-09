-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local jecs = require(script.Parent.Parent.Parent.Parent.Parent.Parent.jecs)
local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide)
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes)
local effect = vide.effect

return function(p1) --[[ Line: 23 | Upvalues: effect (copy), queue (copy), remotes (copy), Players (copy), jecs (copy) ]]
	local v1 = false

	effect(function() --[[ Line: 27 | Upvalues: p1 (copy), v1 (ref) ]]
		p1.validate_query()
		v1 = true
	end)

	local v2 = 0
	local v3 = false
	local v4 = queue(remotes.validate_result)
	local v5

	if p1.host == Players.LocalPlayer then
		v5 = 0.3
	else
		local isHost = p1.host == "server"

		v5 = 0.5
	end

	return function(p12) --[[ Line: 47 | Upvalues: v1 (ref), v2 (ref), v3 (ref), p1 (copy), v4 (copy), jecs (ref), v5 (ref), remotes (ref) ]]
		if v1 then
			v2 = 0
			v3 = false
			v1 = false
			p1.ok(false)
			p1.msg("")
		end

		for v12, v22, v32, v42, v52, v6 in v4:iter() do
			if v12.host == p1.host and (v12.from_vm == p1.vm and (v22 == p1.id and v32 == p1.validate_query())) then
				p1.ok(v52)
				p1.msg(v6 or "")
				p1.primary_entity(nil)

				if v42 and not (#v42.include + #v42.exclude + #v42.with > 1) then
					local v7 = v42.include[1]

					if v7 ~= nil and not jecs.IS_PAIR(v7) then
						p1.primary_entity(v42.include[1])
					end
				end
			end
		end

		v2 = v2 + p12

		if v2 < v5 then
			return
		end

		if v3 then
			return
		end

		if p1.validate_query() == "" then
			p1.ok(false)
			p1.msg("empty query")
		else
			v3 = true
			remotes.validate_query:fire({
				host = p1.host,
				to_vm = p1.vm
			}, p1.id, p1.validate_query())
		end
	end
end