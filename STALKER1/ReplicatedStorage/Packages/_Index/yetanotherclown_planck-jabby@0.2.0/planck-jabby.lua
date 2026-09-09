-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Jabby = require(script.Parent.Jabby)
local t = {}

t.__index = t

local v1 = 0

function t.build(p1, p2) --[[ build | Line: 31 | Upvalues: v1 (ref), Jabby (copy) ]]
	v1 = v1 + 1

	local v2 = ("Planck%*"):format(v1 > 1 and (" #%*"):format(v1) or "")
	local v3 = Jabby.scheduler.create()
	local t = {}

	for v4, v5 in p2._systemInfo do
		local t2 = {
			name = v5.name
		}

		t2.phase = tostring(v5.phase)
		t[v4] = v3:register_system(t2)
	end

	p2:_addHook(p2.Hooks.SystemAdd, function(p1) --[[ Line: 52 | Upvalues: v3 (copy), t (copy) ]]
		local t2 = {
			name = p1.system.name
		}

		t2.phase = tostring(p1.system.phase)
		t[p1.system.system] = v3:register_system(t2)
	end)
	p2:_addHook(p2.Hooks.SystemRemove, function(p1) --[[ Line: 64 | Upvalues: v3 (copy), t (copy) ]]
		v3:remove_system(t[p1.system.system])
		t[p1.system.system] = nil
	end)
	p2:_addHook(p2.Hooks.SystemReplace, function(p1) --[[ Line: 72 | Upvalues: v3 (copy), t (copy) ]]
		local system2 = p1.old.system

		v3:remove_system(t[system2])
		t[system2] = nil

		local t2 = {
			name = p1.new.name
		}

		t2.phase = tostring(p1.new.phase)
		t[p1.new.system] = v3:register_system(t2)
	end)

	local t2 = { "PreStartup", "Startup", "PostStartup" }
	local t3 = {}

	p2:_addHook(p2.Hooks.SystemCall, function(p1) --[[ Line: 91 | Upvalues: t (copy), t3 (copy), v3 (copy), t2 (copy) ]]
		local v1 = t[p1.system.system]

		return function() --[[ Line: 94 | Upvalues: t3 (ref), v3 (ref), v1 (copy), p1 (copy), t2 (ref) ]]
			for v12, v2 in t3 do
				v3:set_system_data(v12, {
					paused = true
				})
			end

			v3:run(v1, function() --[[ Line: 101 | Upvalues: p1 (ref), t2 (ref), t3 (ref), v1 (ref) ]]
				p1.nextFn()

				if not table.find(t2, (tostring(p1.system.phase))) then
					return
				end

				t3[v1] = true
			end)
		end
	end)
	Jabby.register({
		applet = Jabby.applets.scheduler,
		name = v2,
		configuration = {
			scheduler = v3
		}
	})
end
function t.new() --[[ new | Line: 121 | Upvalues: t (copy) ]]
	return setmetatable({}, t)
end

return t