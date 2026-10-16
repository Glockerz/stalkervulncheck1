-- Decompiled with Potassium's decompiler.

local scheduler = require(script.Parent.Parent.server.scheduler);

return function(p1: string, u2: any, ...) -- Line: 20, Name: loop_create
    -- upvalues: scheduler (copy)
    local u3 = scheduler.create(p1);
    local u4 = {};
    local u5 = nil;

    local function process_systems(p6: table) -- Line: 27
        -- upvalues: u5 (ref), u4 (copy), process_systems (copy), u3 (copy), u2 (copy)
        for _, v in p6 do
            if type(v) == "table" then
                if v.i then
                    if u5 then
                        table.insert(u4, u5);
                    end;

                    u5 = {
                        dt = 0,
                        interval = v.i or 1,
                        offset = v.o or 0
                    };
                else
                    process_systems(v);
                end;
            elseif type(v) == "function" then
                assert(u5);
                local v7 = {
                    name = "UNNAMED",
                    type = 0,
                    id = u3:register_system(),
                    fn = v
                };
                table.insert(u5, v7);
            else
                assert(u5);
                local v8 = require(v);
                local v9 = v8(u2, 0);
                local v10 = {
                    id = u3:register_system({
                        name = `{v.Name}`
                    }),
                    name = v.Name,
                    type = v9 and 1 or 0,
                    fn = v9 or v8
                };
                table.insert(u5, v10);
            end;
        end;
    end;

    process_systems({ ... });
    assert(u5);
    table.insert(u4, u5);
    u5 = nil;
    local u11 = 0;

    return function(p12) -- Line: 76
        -- upvalues: u11 (ref), u4 (copy), u3 (copy), u2 (copy)
        u11 = u11 + 1;
        debug.profilebegin("ECS LOOP");

        for _, v in u4 do
            v.dt = v.dt + p12;

            if u11 % v.interval == v.offset then
                local v13 = v;

                for _, v2 in ipairs(v) do
                    debug.setmemorycategory(v2.name);
                    debug.profilebegin(v2.name);

                    if v2.type == 0 then
                        u3:run(v2.id, v2.fn, u2, v13.dt);
                    else
                        u3:run(v2.id, v2.fn, v13.dt);
                    end;

                    debug.profileend();
                end;

                v13.dt = 0;
            end;
        end;

        debug.resetmemorycategory();
        debug.profileend();
    end, u3;
end;