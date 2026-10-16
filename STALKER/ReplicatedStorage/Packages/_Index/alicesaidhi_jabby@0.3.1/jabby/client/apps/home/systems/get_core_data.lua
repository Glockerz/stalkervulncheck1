-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide);
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes);
local reverse_connector = require(script.Parent.Parent.Parent.Parent.Parent.modules.reverse_connector);

return function(u1) -- Line: 8
    -- upvalues: Players (copy), remotes (copy), queue (copy), reverse_connector (copy), vide (copy)
    for _, v in Players:GetPlayers() do
        remotes.ping:fire({
            host = v
        });
    end;

    remotes.ping:fire({
        host = "server"
    });
    local u2 = queue(remotes.new_server_registered);
    local u3 = queue(remotes.update_server_data);
    local u4 = queue(Players.PlayerRemoving);
    local u5 = 0;
    local u6 = {
        server = {}
    };

    return function() -- Line: 29
        -- upvalues: u2 (copy), reverse_connector (ref), remotes (ref), u4 (copy), u6 (copy), u1 (copy), u3 (copy), u5 (ref), vide (ref)
        for i in u2:iter() do
            local v7 = reverse_connector(i);
            remotes.bind_to_server_core:fire(v7);
        end;

        for i in u4:iter() do
            local v8 = u6[i];

            if v8 then
                for _, v in v8 do
                    u1()[v] = nil;
                end;

                u1(u1());
            end;
        end;

        for i, v in u3:iter() do
            local v9 = reverse_connector(i);
            u6[v9.host] = u6[v9.host] or {};
            local v10 = u6[v9.host][v9.to_vm];

            if not v10 then
                v10 = u5 + 1;
                u5 = u5 + 1;
                u6[v9.host][v9.to_vm] = v10;
                u1()[v10] = {
                    host = v9.host,
                    vm = v9.to_vm,
                    schedulers = vide.source({}),
                    worlds = vide.source({})
                };
                u1(u1());
            end;

            local v11 = u1()[v10];
            local v12 = v11.schedulers();
            local v13 = v11.worlds();
            table.clear(v12);
            table.clear(v13);

            for i2, v2 in v.schedulers do
                local v14 = v12[i2];

                if not (v14 and (v14.name == v2.name and v14.id == v2.id)) then
                    v12[i2] = v2;
                end;
            end;

            for i2, v2 in v.worlds do
                local v15 = v13[i2];

                if not (v15 and (v15.name == v2.name and v15.id == v2.id)) then
                    v13[i2] = v2;
                end;
            end;

            v11.schedulers(v12);
            v11.worlds(v13);
        end;
    end;
end;