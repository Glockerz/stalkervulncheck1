-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local container = require(script.Parent.Parent.util.container);
local create = vide.create;
local source = vide.source;
local action = vide.action;
local effect = vide.effect;

return function(u1: table) -- Line: 23
    -- upvalues: source (copy), effect (copy), container (copy), create (copy), theme (copy), action (copy)
    local u2 = source();
    effect(function() -- Line: 27
        -- upvalues: u2 (copy), u1 (copy)
        if not u2() then
            return;
        end;

        u2():SetControlPoints(u1.values());
    end);

    return container({
        Position = u1.position,
        Size = u1.size,
        AnchorPoint = u1.anchorpoint,
        create("Path2D")({
            Thickness = 2,
            Color3 = theme.acc[3],
            action(u2)
        }),
        unpack(u1)
    });
end;