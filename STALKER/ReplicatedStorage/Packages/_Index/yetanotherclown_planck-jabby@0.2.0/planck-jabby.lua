-- Decompiled with Potassium's decompiler.

local Jabby = require(script.Parent.Jabby);
local u1 = {};
u1.__index = u1;
local u2 = 0;

function u1.build(p3, p4) -- Line: 31
    -- upvalues: u2 (ref), Jabby (copy)
    u2 = u2 + 1;
    local v5 = `Planck{u2 > 1 and ` #{u2}` or ""}`;
    local u6 = Jabby.scheduler.create();
    local u7 = {};

    for i, v in p4._systemInfo do
        u7[i] = u6:register_system({
            name = v.name,
            phase = tostring(v.phase)
        });
    end;

    p4:_addHook(p4.Hooks.SystemAdd, function(p8: table) -- Line: 52
        -- upvalues: u6 (copy), u7 (copy)
        local v9 = u6:register_system({
            name = p8.system.name,
            phase = tostring(p8.system.phase)
        });
        u7[p8.system.system] = v9;
    end);
    p4:_addHook(p4.Hooks.SystemRemove, function(p10: table) -- Line: 64
        -- upvalues: u6 (copy), u7 (copy)
        u6:remove_system(u7[p10.system.system]);
        u7[p10.system.system] = nil;
    end);
    p4:_addHook(p4.Hooks.SystemReplace, function(p11: table) -- Line: 72
        -- upvalues: u6 (copy), u7 (copy)
        local system = p11.new.system;
        local system2 = p11.old.system;
        u6:remove_system(u7[system2]);
        u7[system2] = nil;
        u7[system] = u6:register_system({
            name = p11.new.name,
            phase = tostring(p11.new.phase)
        });
    end);
    local u12 = { "PreStartup", "Startup", "PostStartup" };
    local u13 = {};
    p4:_addHook(p4.Hooks.SystemCall, function(u14: table) -- Line: 91
        -- upvalues: u7 (copy), u13 (copy), u6 (copy), u12 (copy)
        local u15 = u7[u14.system.system];

        return function() -- Line: 94
            -- upvalues: u13 (ref), u6 (ref), u15 (copy), u14 (copy), u12 (ref)
            for i, _ in u13 do
                u6:set_system_data(i, {
                    paused = true
                });
            end;

            u6:run(u15, function() -- Line: 101
                -- upvalues: u14 (ref), u12 (ref), u13 (ref), u15 (ref)
                u14.nextFn();
                local v16 = tostring(u14.system.phase);

                if table.find(u12, v16) then
                    u13[u15] = true;
                end;
            end);
        end;
    end);
    Jabby.register({
        applet = Jabby.applets.scheduler,
        name = v5,
        configuration = {
            scheduler = u6
        }
    });
end;

function u1.new() -- Line: 121
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;

return u1;