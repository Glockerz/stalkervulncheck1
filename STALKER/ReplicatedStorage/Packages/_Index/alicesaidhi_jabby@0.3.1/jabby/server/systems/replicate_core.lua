-- Decompiled with Potassium's decompiler.

local queue = require(script.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.modules.remotes);
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector);
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check);
local public = require(script.Parent.Parent.public);

return function() -- Line: 7
    -- upvalues: queue (copy), remotes (copy), reverse_connector (copy), traffic_check (copy), public (copy)
    local u1 = {};
    local u2 = queue(remotes.bind_to_server_core);

    return function() -- Line: 13
        -- upvalues: u2 (copy), reverse_connector (ref), traffic_check (ref), u1 (copy), public (ref), remotes (ref)
        for i in u2:iter() do
            local v3 = reverse_connector(i);

            if traffic_check.check_no_wl(i.host) then
                table.insert(u1, v3);
                local v4 = {};
                local v5 = {};

                for i2, v in ipairs(public) do
                    if v.class_name == "Scheduler" then
                        table.insert(v5, {
                            name = v.name,
                            id = i2
                        });
                    elseif v.class_name == "World" then
                        table.insert(v4, {
                            name = v.name,
                            id = i2
                        });
                    end;
                end;

                remotes.update_server_data:fire(v3, {
                    schedulers = v5,
                    worlds = v4
                });
            end;
        end;

        if public.updated == false then
            return;
        end;

        public.updated = false;
        local v6 = {};
        local v7 = {};

        for i, v in ipairs(public) do
            if v.class_name == "Scheduler" then
                table.insert(v7, {
                    name = v.name,
                    id = i
                });
            elseif v.class_name == "World" then
                table.insert(v6, {
                    name = v.name,
                    id = i
                });
            end;
        end;

        local v8 = {};

        for _, v in u1 do
            if v8[v] then
                return;
            end;

            v8[v] = true;
            remotes.update_server_data:fire(v, {
                schedulers = v7,
                worlds = v6
            });
        end;
    end;
end;