-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.modules.types);
local watch = require(script.Parent.watch);
local u1 = 0;
local u2 = {};

local function unit() -- Line: 19
end;

return {
    create = function() -- Line: 21, Name: create_scheduler
        -- upvalues: watch (copy), unit (copy), u2 (copy), u1 (ref)
        local u3 = 1;
        local u4 = 0;
        local u5 = {
            class_name = "Scheduler",
            name = "Scheduler",
            valid_system_ids = {},
            system_data = {},
            system_data_updated = {},
            system_frames = {},
            system_frames_updated = {},
            processing_frame = {},
            system_watches = {}
        };

        local function ENABLE_WATCHES(p6) -- Line: 48
            -- upvalues: u5 (copy), watch (ref)
            local u7 = {};

            for i, v in u5.system_watches[p6] do
                if v.active ~= false then
                    watch.step_watch(v.watch);
                    u7[i] = watch.track_watch(v.watch);
                end;
            end;

            return function() -- Line: 58
                -- upvalues: u7 (copy)
                for _, v in u7 do
                    v();
                end;
            end;
        end;

        local function ASSERT_SYSTEM_VALID(p8) -- Line: 65
            -- upvalues: u5 (copy)
            local v9 = u5.valid_system_ids[p8];
            local v10 = `attempt to use unknown system with id #{p8}`;
            assert(v9, v10);
        end;

        function u5.register_system(p11, p12) -- Line: 69
            -- upvalues: u3 (ref), u5 (copy)
            local v13 = u3;
            u3 = u3 + 1;
            u5.valid_system_ids[v13] = true;
            u5.system_data[v13] = {
                name = "UNNAMED",
                phase = nil,
                layout_order = 0,
                paused = false
            };
            u5.system_frames[v13] = {};
            u5.system_frames_updated[v13] = {};

            if p12 then
                u5:set_system_data(v13, p12);
            end;

            return v13;
        end;

        function u5.set_system_data(p14, p15, p16) -- Line: 88
            -- upvalues: u5 (copy)
            local v17 = u5.valid_system_ids[p15];
            local v18 = `attempt to use unknown system with id #{p15}`;
            assert(v17, v18);

            for i, v in p16 do
                u5.system_data[p15][i] = v;
            end;

            u5.system_data_updated[p15] = true;
        end;

        function u5.get_system_data(p19, p20) -- Line: 97
            -- upvalues: u5 (copy)
            local v21 = u5.valid_system_ids[p20];
            local v22 = `attempt to use unknown system with id #{p20}`;
            assert(v21, v22);

            return u5.system_data[p20];
        end;

        function u5.remove_system(p23, p24) -- Line: 102
            -- upvalues: u5 (copy)
            u5.valid_system_ids[p24] = nil;
            u5.system_data[p24] = nil;
            u5.system_frames[p24] = nil;
            u5.system_frames_updated[p24] = nil;
            u5.system_data_updated[p24] = true;
            u5.system_watches[p24] = nil;
        end;

        function u5._mark_system_frame_start(p25, p26) -- Line: 111
            -- upvalues: u5 (copy)
            local v27 = u5.valid_system_ids[p26];
            local v28 = `attempt to use unknown system with id #{p26}`;
            assert(v27, v28);
            u5.processing_frame[p26] = {
                started_at = os.clock()
            };
        end;

        function u5._mark_system_frame_end(p29: table, p30: any, p31: number?) -- Line: 119
            -- upvalues: u5 (copy), u4 (ref)
            local v32 = u5.valid_system_ids[p30];
            local v33 = `attempt to use unknown system with id #{p30}`;
            assert(v32, v33);
            local os_clock_ret = os.clock();
            local v34 = u5.processing_frame[p30];
            assert(v34 ~= nil, "no processing frame");
            local v35 = {
                i = u4,
                s = os_clock_ret - v34.started_at
            };
            u4 = u4 + 1;
            u5.processing_frame[p30] = nil;
            u5.system_frames_updated[p30][v35] = true;
            local v36 = u5.system_frames[p30][50];

            if v36 then
                u5.system_frames_updated[p30][v36] = nil;
            end;

            table.insert(u5.system_frames[p30], 1, v35);
            table.remove(u5.system_frames[p30], 51);
        end;

        function u5.append_extra_frame_data(p37: table, p38: any, p39: table) -- Line: 142
            error("todo");
        end;

        function u5.run(p40: table, p41: any, p42: function, ...) -- Line: 147
            -- upvalues: u5 (copy), unit (ref), ENABLE_WATCHES (copy)
            local v43 = u5.valid_system_ids[p41];
            local v44 = `attempt to use unknown system with id #{p41}`;
            assert(v43, v44);

            if u5.system_data[p41].paused then
                return;
            end;

            local v45 = unit;

            if u5.system_watches[p41] then
                v45 = ENABLE_WATCHES(p41);
            end;

            u5:_mark_system_frame_start(p41);
            p42(...);
            u5:_mark_system_frame_end(p41);
            v45();
        end;

        function u5.create_watch_for_system(p46, u47) -- Line: 167
            -- upvalues: u5 (copy), watch (ref)
            local v48 = u5.valid_system_ids[u47];
            local v49 = `attempt to use unknown system with id #{u47}`;
            assert(v48, v49);
            local v50 = watch.create_watch();
            local u51 = nil;
            u5.system_watches[u47] = u5.system_watches[u47] or {};
            u51 = {
                active = false,
                watch = v50,

                untrack = function() -- Line: 174, Name: untrack
                    -- upvalues: u5 (ref), u47 (copy), u51 (ref)
                    local table_find_ret = table.find(u5.system_watches[u47], u51);
                    table.remove(u5.system_watches[u47], table_find_ret);
                end
            };
            table.insert(u5.system_watches[u47], u51);

            return u51;
        end;

        u2[u1 + 1] = u5;
        u1 = u1 + 1;

        return u5;
    end,

    schedulers = u2
};