-- Decompiled with Potassium's decompiler.

local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes);

return function(u1: table) -- Line: 16
    -- upvalues: queue (copy), remotes (copy)
    local u2 = queue(remotes.send_mouse_entity);

    return function() -- Line: 20
        -- upvalues: u2 (copy), u1 (copy)
        for i, v, v2, v3, v4 in u2:iter() do
            if i.host == u1.host and (i.from_vm == u1.vm and (v == u1.id and u1.enable_pick() ~= false)) then
                u1.hovering_over(v2);
                u1.entity_hovering_over(v4);
                u1.set_entity(v3);
            end;
        end;
    end;
end;