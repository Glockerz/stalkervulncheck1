-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.modules.types);
local world_hook = require(script.Parent.world_hook);
local u1 = newproxy();

local function create_changes() -- Line: 19
    return {
        types = {},
        entities = {},
        component = {},
        values = {},
        worlds = {}
    };
end;

return {
    create_watch = function() -- Line: 110, Name: create_watch
        return {
            enable_lon = false,
            frame = 0,
            frames = {}
        };
    end,

    track_watch = function(u2: table) -- Line: 34, Name: track_watch
        -- upvalues: world_hook (copy), u1 (copy)
        local u23 = {
            world_hook.hook_onto("remove", function(p3, p4, p5) -- Line: 38
                -- upvalues: u2 (copy), u1 (ref)
                local v6 = u2.frames[u2.frame];
                table.insert(v6.types, "remove");
                table.insert(v6.entities, p4);
                table.insert(v6.component, p5);
                table.insert(v6.values, u1);
                table.insert(v6.worlds, p3);
            end),
            world_hook.hook_onto("clear", function(p7, p8) -- Line: 48
                -- upvalues: u2 (copy), u1 (ref)
                local v9 = u2.frames[u2.frame];
                table.insert(v9.types, "clear");
                table.insert(v9.entities, p8);
                table.insert(v9.component, u1);
                table.insert(v9.values, u1);
                table.insert(v9.worlds, p7);
            end),
            world_hook.hook_onto("delete", function(p10, p11) -- Line: 58
                -- upvalues: u2 (copy), u1 (ref)
                local v12 = u2.frames[u2.frame];
                table.insert(v12.types, "delete");
                table.insert(v12.entities, p11);
                table.insert(v12.component, u1);
                table.insert(v12.values, u1);
                table.insert(v12.worlds, p10);
            end),
            world_hook.hook_onto("add", function(p13, p14, p15) -- Line: 68
                -- upvalues: u2 (copy), u1 (ref)
                local v16 = u2.frames[u2.frame];
                table.insert(v16.types, "add");
                table.insert(v16.entities, p14);
                table.insert(v16.component, p15);
                table.insert(v16.values, u1);
                table.insert(v16.worlds, p13);
            end),
            world_hook.hook_onto("set", function(p17, p18, p19, p20) -- Line: 78
                -- upvalues: u2 (copy)
                if p17:has(p18, p19) then
                    local v21 = u2.frames[u2.frame];
                    table.insert(v21.types, "change");
                    table.insert(v21.entities, p18);
                    table.insert(v21.component, p19);
                    table.insert(v21.values, p20);
                    table.insert(v21.worlds, p17);

                    return;
                end;

                local v22 = u2.frames[u2.frame];
                table.insert(v22.types, "move");
                table.insert(v22.entities, p18);
                table.insert(v22.component, p19);
                table.insert(v22.values, p20);
                table.insert(v22.worlds, p17);
            end)
        };

        return function() -- Line: 101, Name: stop_hook
            -- upvalues: u23 (copy)
            for _, v in u23 do
                v();
            end;
        end;
    end,

    step_watch = function(p24: table) -- Line: 29, Name: step_watch
        -- upvalues: create_changes (copy)
        p24.frame = p24.frame + 1;
        p24.frames[p24.frame] = create_changes();
    end,

    NIL = u1
};