-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local container = require(script.Parent.Parent.util.container);
local create = vide.create;
local source = vide.source;
local action = vide.action;
local effect = vide.effect;
local read = vide.read;

return function(u1: table) -- Line: 25
    -- upvalues: source (copy), effect (copy), read (copy), container (copy), create (copy), theme (copy), action (copy)
    local u2 = source();
    effect(function() -- Line: 29
        -- upvalues: u2 (copy), u1 (copy), read (ref)
        if not u2() then
            return;
        end;

        local v3 = u2();
        local table_create_ret = table.create(50);
        local v4 = #u1.values();
        local v5 = read(u1.max) or 100;
        local v6 = read(u1.min) or 0;
        local math_abs_ret = math.abs(v5 - v6);

        for i, v in u1.values() do
            table.insert(table_create_ret, Path2DControlPoint.new(UDim2.fromScale((i - 1) / (v4 - 1), 1 - (v - v6) / math_abs_ret)));
        end;

        v3:SetControlPoints(table_create_ret);
    end);

    return container({
        Position = u1.position,
        Size = u1.size,
        AnchorPoint = u1.anchorpoint,
        ClipsDescendants = true,
        create("Path2D")({
            Thickness = 2,
            Color3 = theme.acc[3],
            action(u2)
        }),
        unpack(u1)
    });
end;