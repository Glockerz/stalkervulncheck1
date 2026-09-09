-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.modules.types)

local watch = require(script.Parent.watch)
local v1 = 0
local t = {}

local function unit() --[[ unit | Line: 19 ]] end

return {
	create = function() --[[ create_scheduler | Line: 21 | Upvalues: watch (copy), unit (copy), t (copy), v1 (ref) ]]
		local v12 = 1
		local v2 = 0
		local t2 = {
			class_name = "Scheduler",
			name = "Scheduler",
			valid_system_ids = {},
			system_data = {},
			system_data_updated = {},
			system_frames = {},
			system_frames_updated = {},
			processing_frame = {},
			system_watches = {}
		}

		local function ENABLE_WATCHES(p1) --[[ ENABLE_WATCHES | Line: 48 | Upvalues: t2 (copy), watch (ref) ]]
			local t = {}

			for v1, v2 in t2.system_watches[p1] do
				if v2.active ~= false then
					watch.step_watch(v2.watch)
					t[v1] = watch.track_watch(v2.watch)
				end
			end

			return function() --[[ Line: 58 | Upvalues: t (copy) ]]
				for v1, v2 in t do
					v2()
				end
			end
		end

		local function ASSERT_SYSTEM_VALID(p1) --[[ ASSERT_SYSTEM_VALID | Line: 65 | Upvalues: t2 (copy) ]]
			assert(t2.valid_system_ids[p1], (("attempt to use unknown system with id #%*"):format(p1)))
		end

		function t2.register_system(p1, p2) --[[ register_system | Line: 69 | Upvalues: v12 (ref), t2 (copy) ]]
			local v1 = v12

			v12 = v12 + 1
			t2.valid_system_ids[v1] = true
			t2.system_data[v1] = {
				name = "UNNAMED",
				phase = nil,
				layout_order = 0,
				paused = false
			}
			t2.system_frames[v1] = {}
			t2.system_frames_updated[v1] = {}

			if p2 then
				t2:set_system_data(v1, p2)
			end

			return v1
		end
		function t2.set_system_data(p1, p2, p3) --[[ set_system_data | Line: 88 | Upvalues: t2 (copy) ]]
			assert(t2.valid_system_ids[p2], (("attempt to use unknown system with id #%*"):format(p2)))

			for v3, v4 in p3 do
				t2.system_data[p2][v3] = v4
			end

			t2.system_data_updated[p2] = true
		end
		function t2.get_system_data(p1, p2) --[[ get_system_data | Line: 97 | Upvalues: t2 (copy) ]]
			assert(t2.valid_system_ids[p2], (("attempt to use unknown system with id #%*"):format(p2)))

			return t2.system_data[p2]
		end
		function t2.remove_system(p1, p2) --[[ remove_system | Line: 102 | Upvalues: t2 (copy) ]]
			t2.valid_system_ids[p2] = nil
			t2.system_data[p2] = nil
			t2.system_frames[p2] = nil
			t2.system_frames_updated[p2] = nil
			t2.system_data_updated[p2] = true
			t2.system_watches[p2] = nil
		end
		function t2._mark_system_frame_start(p1, p2) --[[ _mark_system_frame_start | Line: 111 | Upvalues: t2 (copy) ]]
			assert(t2.valid_system_ids[p2], (("attempt to use unknown system with id #%*"):format(p2)))
			t2.processing_frame[p2] = {
				started_at = os.clock()
			}
		end
		function t2._mark_system_frame_end(p1, p2, p3) --[[ _mark_system_frame_end | Line: 119 | Upvalues: t2 (copy), v2 (ref) ]]
			assert(t2.valid_system_ids[p2], (("attempt to use unknown system with id #%*"):format(p2)))

			local v3 = os.clock()
			local v4 = t2.processing_frame[p2]

			assert(v4 ~= nil, "no processing frame")

			local t = {
				i = v2,
				s = v3 - v4.started_at
			}

			v2 = v2 + 1
			t2.processing_frame[p2] = nil
			t2.system_frames_updated[p2][t] = true

			local v6 = t2.system_frames[p2][50]

			if v6 then
				t2.system_frames_updated[p2][v6] = nil
			end

			table.insert(t2.system_frames[p2], 1, t)
			table.remove(t2.system_frames[p2], 51)
		end
		function t2.append_extra_frame_data(p1, p2, p3) --[[ append_extra_frame_data | Line: 142 ]]
			error("todo")
		end
		function t2.run(p1, p2, p3, ...) --[[ run | Line: 147 | Upvalues: t2 (copy), unit (ref), ENABLE_WATCHES (copy) ]]
			assert(t2.valid_system_ids[p2], (("attempt to use unknown system with id #%*"):format(p2)))

			if t2.system_data[p2].paused then
				return
			end

			local v3 = unit

			if t2.system_watches[p2] then
				v3 = ENABLE_WATCHES(p2)
			end

			t2:_mark_system_frame_start(p2)
			p3(...)
			t2:_mark_system_frame_end(p2)
			v3()
		end
		function t2.create_watch_for_system(p1, p2) --[[ create_watch_for_system | Line: 167 | Upvalues: t2 (copy), watch (ref) ]]
			local v1 = t2.valid_system_ids[p2]

			assert(v1, (("attempt to use unknown system with id #%*"):format(p2)))

			local v3 = watch.create_watch()
			local v4 = nil
			local system_watches = t2.system_watches

			system_watches[p2] = t2.system_watches[p2] or {}

			local t = {
				active = false,
				watch = v3,
				untrack = function() --[[ untrack | Line: 174 | Upvalues: t2 (ref), p2 (copy), v4 (ref) ]]
					table.remove(t2.system_watches[p2], (table.find(t2.system_watches[p2], v4)))
				end
			}
			local v6 = t2.system_watches[p2]

			table.insert(v6, t)

			return t
		end
		t[v1 + 1] = t2
		v1 = v1 + 1

		return t2
	end,
	schedulers = t
}