-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide);
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes);
local effect = vide.effect;
local cleanup = vide.cleanup;
local batch = vide.batch;

return function(u1: table) -- Line: 24
    -- upvalues: queue (copy), remotes (copy), effect (copy), cleanup (copy), batch (copy)
    local u2 = queue(remotes.inspect_entity_update);
    local inspect_id = u1.inspect_id;
    local u3 = {
        host = u1.host,
        to_vm = u1.vm
    };
    remotes.inspect_entity:fire(u3, u1.id, u1.entity, inspect_id);
    local u4 = false;
    effect(function() -- Line: 43
        -- upvalues: u1 (copy), u4 (ref)
        u1.live_updates();
        u4 = true;
    end);
    cleanup(function() -- Line: 48
        -- upvalues: remotes (ref), u3 (copy), inspect_id (copy)
        remotes.stop_inspect_entity:fire(u3, inspect_id);
    end);

    return function() -- Line: 55
        -- upvalues: u1 (copy), remotes (ref), u3 (copy), inspect_id (copy), u4 (ref), batch (ref), u2 (copy)
        if u1.apply_changes() then
            remotes.update_entity:fire(u3, inspect_id, u1.changes());
            u1.apply_changes(false);
            u1.changes({});
        end;

        if u1.deleting() then
            remotes.delete_entity:fire(u3, inspect_id);
        end;

        if u4 then
            remotes.update_inspect_settings:fire(u3, inspect_id, {
                paused = not u1.live_updates()
            });
            u4 = false;
        end;

        batch(function() -- Line: 76
            -- upvalues: u2 (ref), inspect_id (ref), u1 (ref)
            for _, v, v2, v3 in u2:iter() do
                if v == inspect_id then
                    u1.keys()[v2] = v3;
                    u1.keys(u1.keys());
                end;
            end;
        end);
    end;
end;