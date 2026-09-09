-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide)
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes)
local reverse_connector = require(script.Parent.Parent.Parent.Parent.Parent.modules.reverse_connector)

return function(p1) --[[ Line: 8 | Upvalues: Players (copy), remotes (copy), queue (copy), reverse_connector (copy), vide (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		remotes.ping:fire({
			host = v2
		})
	end

	remotes.ping:fire({
		host = "server"
	})

	local v3 = queue(remotes.new_server_registered)
	local v4 = queue(remotes.update_server_data)
	local v5 = queue(Players.PlayerRemoving)
	local v6 = 0
	local t = {
		server = {}
	}

	return function() --[[ Line: 29 | Upvalues: v3 (copy), reverse_connector (ref), remotes (ref), v5 (copy), t (copy), p1 (copy), v4 (copy), v6 (ref), vide (ref) ]]
		for v1 in v3:iter() do
			remotes.bind_to_server_core:fire((reverse_connector(v1)))
		end

		for v32 in v5:iter() do
			local v42 = t[v32]

			if v42 then
				for v52, v62 in v42 do
					p1()[v62] = nil
				end

				p1(p1())
			end
		end

		for v7, v8 in v4:iter() do
			local v9 = reverse_connector(v7)

			t[v9.host] = t[v9.host] or {}

			local v12 = t[v9.host][v9.to_vm]

			if not v12 then
				v12 = v6 + 1
				v6 = v6 + 1
				t[v9.host][v9.to_vm] = v12
				p1()[v12] = {
					host = v9.host,
					vm = v9.to_vm,
					schedulers = vide.source({}),
					worlds = vide.source({})
				}
				p1(p1())
			end

			local v13 = p1()[v12]
			local v14 = v13.schedulers()
			local v15 = v13.worlds()

			table.clear(v14)
			table.clear(v15)

			for v16, v17 in v8.schedulers do
				local v18 = v14[v16]

				if not v18 or (v18.name ~= v17.name or v18.id ~= v17.id) then
					v14[v16] = v17
				end
			end

			for v19, v20 in v8.worlds do
				local v21 = v15[v19]

				if not v21 or (v21.name ~= v20.name or v21.id ~= v20.id) then
					v15[v19] = v20
				end
			end

			v13.schedulers(v14)
			v13.worlds(v15)
		end
	end
end