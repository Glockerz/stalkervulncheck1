-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide);
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes);
require(script.Parent.Parent.Parent.Parent.Parent.modules.types);
local batch = vide.batch;
local cleanup = vide.cleanup;

return function(u1: table) -- Line: 25
    -- upvalues: remotes (copy), queue (copy), cleanup (copy), batch (copy)
    local u2 = {
        host = u1.host,
        to_vm = u1.vm
    };
    remotes.request_scheduler:fire(u2, u1.id);
    local u3 = queue(remotes.scheduler_system_static_update);
    local u4 = queue(remotes.scheduler_system_update);
    cleanup(function() -- Line: 36
        -- upvalues: remotes (ref), u2 (copy), u1 (copy)
        remotes.disconnect_scheduler:fire(u2, u1.id);
    end);

    return function() -- Line: 40
        -- upvalues: batch (ref), u3 (copy), u1 (copy), u4 (copy)
        batch(function() -- Line: 42
            -- upvalues: u3 (ref), u1 (ref), u4 (ref)
            for i, v, v2, v3 in u3:iter() do
                if i.host == u1.host and (i.from_vm == u1.vm and v == u1.id) then
                    if v3 == nil then
                        u1.system_ids()[v2] = nil;
                        u1.system_data()[v2] = nil;
                        u1.system_frames()[v2] = nil;
                        u1.system_ids(u1.system_ids());
                        u1.system_data(u1.system_data());
                        u1.system_frames(u1.system_frames());
                    else
                        u1.system_ids()[v2] = true;
                        u1.system_data()[v2] = v3;
                        u1.system_frames()[v2] = u1.system_frames()[v2] or {};
                        u1.system_ids(u1.system_ids());
                        u1.system_data(u1.system_data());
                        u1.system_frames(u1.system_frames());
                    end;
                end;
            end;

            for i, v, v2, v3, v4 in u4:iter() do
                if i.host == u1.host and (i.from_vm == u1.vm and (v == u1.id and u1.system_frames()[v2] ~= nil)) then
                    local v5 = u1.system_frames()[v2];
                    local v6 = v3;
                    local v7 = {
                        i = v3,
                        s = v4
                    };
                    local v8 = false;

                    for i2, v9 in v5 do
                        if v9.i == v6 then
                            v5[i2] = v7;
                        elseif v6 >= v9.i then
                            table.insert(v5, i2, v7);
                            table.remove(v5, 51);
                            v8 = true;
                            break;
                        end;
                    end;

                    if #v5 <= 50 and v8 == false then
                        table.insert(v5, v7);
                    end;

                    u1.system_frames(u1.system_frames());
                end;
            end;
        end);
    end;
end;