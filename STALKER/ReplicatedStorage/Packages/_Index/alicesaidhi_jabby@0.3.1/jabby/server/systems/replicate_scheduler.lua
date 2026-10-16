-- Decompiled with Potassium's decompiler.

local hash_connector = require(script.Parent.Parent.Parent.modules.hash_connector);
local queue = require(script.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.modules.remotes);
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector);
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check);
require(script.Parent.Parent.Parent.modules.types);
local public = require(script.Parent.Parent.public);

return function() -- Line: 10
    -- upvalues: queue (copy), remotes (copy), traffic_check (copy), public (copy), reverse_connector (copy), hash_connector (copy)
    local u1 = {};
    local u2 = queue(remotes.request_scheduler);
    local u3 = queue(remotes.disconnect_scheduler);
    local u4 = queue(remotes.scheduler_system_pause);

    return function() -- Line: 18
        -- upvalues: u2 (copy), traffic_check (ref), public (ref), reverse_connector (ref), u1 (copy), remotes (ref), u3 (copy), u4 (copy), hash_connector (ref)
        for i, v in u2:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v5 = public[v];

                if v5.class_name == "Scheduler" and v5 ~= nil then
                    local v6 = reverse_connector(i);
                    u1[v] = u1[v] or {};
                    table.insert(u1[v], v6);
                    local v7 = v;

                    for i2, v2 in v5.system_data do
                        remotes.scheduler_system_static_update:fire(v6, v7, i2, v2);
                    end;

                    for i2, v2 in v5.system_frames do
                        local v8 = v2[1];

                        if v8 then
                            remotes.scheduler_system_update:fire(v6, v7, i2, v8.i, v8.s);
                        end;
                    end;
                end;
            end;
        end;

        for i, v in u3:iter() do
            if traffic_check.check_no_wl(i.host) and u1[v] then
                local v9 = u1[v];
                local v10 = i;

                for i2 = #v9, 1, -1 do
                    local v11 = v9[i2];

                    if v11.host == v10.host and v11.to_vm == v10.from_vm then
                        v9[i2] = v9[#v9];
                        v9[#v9] = nil;
                        break;
                    end;

                    local _ = i2;
                end;
            end;
        end;

        for i, v, v2, v3 in u4:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v12 = public[v];

                if not v12 then
                    return;
                end;

                v12:set_system_data(v2, {
                    paused = v3
                });
            end;
        end;

        for i, v in u1 do
            local v13 = public[i];

            if #v ~= 0 then
                local v14 = i;
                local v15 = v;

                for i2 in v13.system_data_updated do
                    local v16 = v13.system_data[i2];
                    local v17 = i2;
                    local v18 = {};

                    for _, v2 in v15 do
                        if not v18[hash_connector(v2)] then
                            v18[hash_connector(v2)] = true;
                            remotes.scheduler_system_static_update:fire(v2, v14, v17, v16);
                        end;
                    end;

                    v13.system_data_updated[v17] = nil;
                end;

                for i2, v2 in v13.system_frames_updated do
                    local v19 = i2;
                    local v20 = {};

                    for i3 in v2 do
                        local v21 = i3;

                        for _, v3 in v15 do
                            if not v20[hash_connector(v3)] then
                                v20[hash_connector(v3)] = true;
                                remotes.scheduler_system_update:fire(v3, v14, v19, v21.i, v21.s);
                            end;
                        end;
                    end;

                    table.clear(v2);
                end;
            end;
        end;
    end;
end;