-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local jecs = require(script.Parent.Parent.Parent.Parent.Parent.Parent.jecs);
local vide = require(script.Parent.Parent.Parent.Parent.Parent.Parent.vide);
local queue = require(script.Parent.Parent.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes);
local effect = vide.effect;

return function(u1: table) -- Line: 23
    -- upvalues: effect (copy), queue (copy), remotes (copy), Players (copy), jecs (copy)
    local u2 = false;
    effect(function() -- Line: 27
        -- upvalues: u1 (copy), u2 (ref)
        u1.validate_query();
        u2 = true;
    end);
    local u3 = 0;
    local u4 = false;
    local u5 = queue(remotes.validate_result);
    local u6;

    if u1.host == Players.LocalPlayer then
        u6 = 0.3;
    else
        local _ = u1.host == "server";
        u6 = 0.5;
    end;

    return function(p7) -- Line: 47
        -- upvalues: u2 (ref), u3 (ref), u4 (ref), u1 (copy), u5 (copy), jecs (ref), u6 (ref), remotes (ref)
        if u2 then
            u3 = 0;
            u4 = false;
            u2 = false;
            u1.ok(false);
            u1.msg("");
        end;

        for i, v, v2, v3, v4, v5 in u5:iter() do
            if i.host == u1.host and (i.from_vm == u1.vm and (v == u1.id and v2 == u1.validate_query())) then
                u1.ok(v4);
                u1.msg(v5 or "");
                u1.primary_entity(nil);

                if v3 and #v3.include + #v3.exclude + #v3.with <= 1 then
                    local v8 = v3.include[1];

                    if v8 ~= nil and not jecs.IS_PAIR(v8) then
                        u1.primary_entity(v3.include[1]);
                    end;
                end;
            end;
        end;

        u3 = u3 + p7;

        if u3 < u6 then
            return;
        end;

        if u4 then
            return;
        end;

        if u1.validate_query() == "" then
            u1.ok(false);
            u1.msg("empty query");

            return;
        end;

        u4 = true;
        remotes.validate_query:fire({
            host = u1.host,
            to_vm = u1.vm
        }, u1.id, u1.validate_query());
    end;
end;