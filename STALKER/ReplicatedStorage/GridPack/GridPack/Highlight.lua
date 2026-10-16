-- Decompiled with Potassium's decompiler.

local signal = require(script.Parent.Parent.signal);
local trove = require(script.Parent.Parent.trove);
require(script.Parent.Types);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 54
    -- upvalues: u1 (copy), trove (copy), signal (copy)
    local u3 = setmetatable({}, u1);
    u3._trove = trove.new();
    u3.Position = p2.Position or Vector2.new(0, 0);
    u3.Size = p2.Size or Vector2.new(1, 1);
    u3.Color = p2.Color or Color3.new(1, 1, 1);
    u3.ItemManager = nil;
    u3.ItemManagerChanged = signal.new();
    u3._trove:Add(function() -- Line: 65
        -- upvalues: u3 (copy)
        if u3.ItemManager then
            u3.ItemManager:RemoveHighlight(u3);
        end;

        u3.ItemManagerChanged:Fire(nil);
    end);

    return u3;
end;

function u1.SetItemManager(p4: table, p5: number, p6: any) -- Line: 81
    p4.ItemManager = p6;
    p4.ItemManagerChanged:Fire(p6);
    p4.ItemManager:AddHighlight(p5, p4);
end;

function u1.Destroy(p7) -- Line: 93
    p7._trove:Destroy();
end;

return u1;