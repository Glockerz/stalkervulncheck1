-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local scheduler = require(script.Parent.Parent.server.scheduler)

return function(p1, p2, ...) --[[ loop_create | Line: 20 | Upvalues: scheduler (copy) ]]
	local v1 = scheduler.create(p1)
	local t = {}
	local v2 = nil

	local function v3(p1) --[[ process_systems | Line: 27 | Upvalues: v2 (ref), t (copy), v3 (copy), v1 (copy), p2 (copy) ]]
		for v12, v22 in p1 do
			if type(v22) == "table" then
				if v22.i then
					if v2 then
						table.insert(t, v2)
					end

					v2 = {
						dt = 0,
						interval = v22.i or 1,
						offset = v22.o or 0
					}

					continue
				end

				v3(v22)

				continue
			end

			if type(v22) == "function" then
				assert(v2)
				table.insert(v2, {
					name = "UNNAMED",
					type = 0,
					id = v1:register_system(),
					fn = v22
				})

				continue
			end

			assert(v2)

			local v8 = require(v22)
			local v9 = v8(p2, 0)
			local t2 = {
				id = v1:register_system({
					name = ("%*"):format(v22.Name)
				}),
				name = v22.Name
			}

			t2.type = if v9 then 1 else 0
			t2.fn = v9 or v8
			table.insert(v2, t2)
		end
	end

	v3({ ... })

	local v4 = v2

	assert(v4)

	local v5 = v2

	table.insert(t, v5)
	v2 = nil

	local v6 = 0

	return function(p1) --[[ Line: 76 | Upvalues: v6 (ref), t (copy), v1 (copy), p2 (copy) ]]
		v6 = v6 + 1
		debug.profilebegin("ECS LOOP")

		for v12, v2 in t do
			v2.dt = v2.dt + p1

			if v6 % v2.interval == v2.offset then
				for i, v in ipairs(v2) do
					debug.setmemorycategory(v.name)
					debug.profilebegin(v.name)

					if v.type == 0 then
						v1:run(v.id, v.fn, p2, v2.dt)
					else
						v1:run(v.id, v.fn, v2.dt)
					end

					debug.profileend()
				end

				v2.dt = 0
			end
		end

		debug.resetmemorycategory()
		debug.profileend()
	end, v1
end