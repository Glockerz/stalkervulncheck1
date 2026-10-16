-- Decompiled with Potassium's decompiler.

local create = require(script.Parent.Parent.Parent.Parent.vide).create;

return function(p1: table) -- Line: 22, Name: padding
    -- upvalues: create (copy)
    local v2 = p1.padding or UDim.new(0, 8);
    local v3 = p1.x or v2;
    local v4 = p1.y or v2;
    local v5 = p1.left or v3;
    local v6 = p1.right or v3;
    local v7 = p1.top or v4;
    local v8 = p1.bottom or v4;

    return create("UIPadding")({
        PaddingLeft = v5,
        PaddingRight = v6,
        PaddingTop = v7,
        PaddingBottom = v8
    });
end;