-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide);
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes);
local effect = vide.effect;
local batch = vide.batch;
local cleanup = vide.cleanup;

local function generate_random_query_id() -- Line: 27
    return math.random(2147483647);
end;

return function(u1: table) -- Line: 31
    -- upvalues: effect (copy), queue (copy), remotes (copy), cleanup (copy), batch (copy)
    local u2 = false;
    local u3 = false;
    effect(function() -- Line: 36
        -- upvalues: u1 (copy), u2 (ref)
        if #u1.query() > 0 then
            u2 = true;
        end;
    end);
    effect(function() -- Line: 42
        -- upvalues: u1 (copy), u3 (ref)
        u1.from();
        u1.upto();
        u3 = true;
    end);
    local u4 = -1;
    local u5 = 0;
    local u6 = queue(remotes.update_query_result);
    local u7 = queue(remotes.count_total_entities);
    local columns = u1.columns;
    local u8 = {
        host = u1.host,
        to_vm = u1.vm
    };
    cleanup(function() -- Line: 59
        -- upvalues: remotes (ref), u8 (copy), u4 (ref)
        remotes.disconnect_query:fire(u8, u4);
    end);
    local u9 = false;
    effect(function() -- Line: 64
        -- upvalues: u1 (copy), u9 (ref)
        if u1.refresh() ~= true then
            return;
        end;

        u1.refresh(false);
        u9 = true;
    end);
    local u10 = u1.paused();
    local u11 = false;
    effect(function() -- Line: 72
        -- upvalues: u11 (ref), u10 (ref), u1 (copy)
        u11 = true;
        u10 = u1.paused();
    end);

    return function() -- Line: 77
        -- upvalues: u2 (ref), columns (copy), remotes (ref), u8 (copy), u4 (ref), u1 (copy), u5 (ref), u10 (ref), u3 (ref), u7 (copy), u11 (ref), u9 (ref), batch (ref), u6 (copy)
        if u2 then
            columns({});
            remotes.disconnect_query:fire(u8, u4);
            u4 = math.random(2147483647);
            remotes.request_query:fire(u8, u1.id, u4, u1.query());
            remotes.advance_query_page:fire(u8, u4, u1.from(), u1.upto());
            u5 = 0;
            u2 = false;
            remotes.pause_query:fire(u8, u4, u10);
        end;

        if u3 then
            remotes.advance_query_page:fire(u8, u4, u1.from(), u1.upto());
            u3 = false;
        end;

        for _, v, v2 in u7:iter() do
            if v == u4 then
                u1.total_entities(v2);
            end;
        end;

        if u11 then
            remotes.pause_query:fire(u8, u4, u10);
            u11 = false;
        end;

        if u9 then
            remotes.refresh_results:fire(u8, u4);
            u9 = false;
        end;

        batch(function() -- Line: 112
            -- upvalues: u6 (ref), u4 (ref), u5 (ref), columns (ref)
            for _, v, v2, v3, v4, v5 in u6:iter() do
                if v == u4 and v2 >= u5 - 10 then
                    u5 = math.max(u5, v2);

                    if columns()[v3] == nil then
                        columns()[v3] = {};
                    end;

                    columns()[v3][v4] = v5;
                    columns(columns());
                end;
            end;
        end);
    end;
end;