-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local net = require(script.Parent.Parent.Parent.modules.net);
local queue = require(script.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.modules.remotes);
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector);
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check);

return function() -- Line: 10
    -- upvalues: queue (copy), remotes (copy), Players (copy), traffic_check (copy), net (copy), reverse_connector (copy)
    local u1 = queue(remotes.ping);

    for _, v in Players:GetPlayers() do
        if traffic_check.communication_is_allowed(net.local_host, v, true) then
            remotes.new_server_registered:fire({
                host = v
            });
        end;
    end;

    return function() -- Line: 22
        -- upvalues: u1 (copy), reverse_connector (ref), remotes (ref)
        for i in u1:iter() do
            local v2 = reverse_connector(i);
            remotes.new_server_registered:fire(v2);
        end;
    end;
end;