-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide);
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes);
require(script.Parent.Parent.Parent.Parent.Parent.modules.types);
local batch = vide.batch;

return function(u1: table) -- Line: 23
    -- upvalues: vide (copy), queue (copy), remotes (copy), batch (copy)
    local watch_id = u1.watch_id;
    local u2 = {
        host = u1.host,
        to_vm = u1.vm
    };
    local u3 = false;
    local u4 = false;
    vide.effect(function() -- Line: 34
        -- upvalues: u3 (ref), u4 (ref), u1 (copy)
        u3 = true;
        u4 = u1.recording();
    end);
    local u5 = false;
    local u6 = 1;
    vide.effect(function() -- Line: 41
        -- upvalues: u5 (ref), u6 (ref), u1 (copy)
        u5 = true;
        u6 = u1.watching_frame();
    end);
    local u7 = queue(remotes.update_watch_data);
    local u8 = queue(remotes.update_overview);

    return function() -- Line: 49
        -- upvalues: u3 (ref), u4 (ref), remotes (ref), u2 (copy), watch_id (copy), u5 (ref), u6 (ref), batch (ref), u7 (copy), u1 (copy), u8 (copy)
        if u3 and u4 then
            remotes.start_record_watch:fire(u2, watch_id);
            u3 = false;
        elseif u3 and not u4 then
            remotes.stop_watch:fire(u2, watch_id);
            u3 = false;
        end;

        if u5 then
            remotes.request_watch_data:fire(u2, watch_id, u6);
            u5 = false;
        end;

        debug.profilebegin("receive update data");
        batch(function() -- Line: 65
            -- upvalues: u7 (ref), watch_id (ref), u6 (ref), u1 (ref)
            for _, v, v2, v3 in u7:iter() do
                if v == watch_id and v2 == u6 then
                    if v3 == nil then
                        u1.changes({
                            types = {},
                            entities = {},
                            component = {},
                            values = {},
                            worlds = {}
                        });
                    else
                        u1.changes(v3);
                    end;
                end;
            end;
        end);
        debug.profileend();
        debug.profilebegin("receive overview");
        batch(function() -- Line: 85
            -- upvalues: u8 (ref), watch_id (ref), u1 (ref)
            for _, v, v2, v3 in u8:iter() do
                if v == watch_id then
                    local v9 = u1.per_frame_data();

                    if v9[v2] ~= v3 then
                        v9[v2] = v3;
                        u1.per_frame_data(v9);
                    end;
                end;
            end;
        end);
        debug.profileend();
    end;
end;