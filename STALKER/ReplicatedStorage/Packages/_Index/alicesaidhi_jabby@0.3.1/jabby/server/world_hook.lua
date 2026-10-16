-- Decompiled with Potassium's decompiler.

local public = require(script.Parent.public);

local function i_hook_onto(u1: string, u2: table) -- Line: 4
    -- upvalues: public (copy)
    local u3 = {};

    for _, v in ipairs(public) do
        local world = v.world;

        if world then
            local u4 = world[u1];
            local v5 = typeof(u4) == "function";
            assert(v5, "can only hook onto functions");

            world[u1] = function(...) -- Line: 16, Name: run_hook
                -- upvalues: u2 (copy), u4 (copy)
                for _, v2 in u2 do
                    v2(...);
                end;

                return u4(...);
            end;

            u3[world] = u4;
        end;
    end;

    return function() -- Line: 28
        -- upvalues: u3 (copy), u1 (copy)
        for i, v in u3 do
            i[u1] = v;
        end;
    end;
end;

local u6 = {};

local function find_swap_pop(p7: table, p8: any) -- Line: 37
    local table_find_ret = table.find(p7, p8);

    if not table_find_ret then
        return;
    end;

    p7[table_find_ret] = p7[#p7];
    p7[#p7] = nil;
end;

return {
    hook_onto = function(u9: string, u10: function) -- Line: 44, Name: hook_onto
        -- upvalues: u6 (copy), i_hook_onto (copy)
        if u6[u9] == nil then
            local v11 = {};
            u6[u9] = {
                cleanup = i_hook_onto(u9, v11),
                callbacks = v11
            };
        end;

        local u12 = u6[u9];
        local u13 = false;
        table.insert(u12.callbacks, u10);

        return function() -- Line: 59, Name: unhook
            -- upvalues: u13 (ref), u12 (copy), u10 (copy), u6 (ref), u9 (copy)
            if u13 then
                return;
            end;

            u13 = true;
            local callbacks = u12.callbacks;
            local table_find_ret = table.find(callbacks, u10);

            if table_find_ret then
                callbacks[table_find_ret] = callbacks[#callbacks];
                callbacks[#callbacks] = nil;
            end;

            if u12.callbacks[1] == nil then
                u12.cleanup();
                u6[u9] = nil;
            end;
        end;
    end
};