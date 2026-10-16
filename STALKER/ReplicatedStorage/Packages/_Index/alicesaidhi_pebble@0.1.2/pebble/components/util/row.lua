-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local container = require(script.Parent.container);
local create = vide.create;
local read = vide.read;

return function(u1: table) -- Line: 24, Name: layout
    -- upvalues: container (copy), create (copy), read (copy)
    return container({
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        create("UIListLayout")({
            Padding = function() -- Line: 31, Name: Padding
                -- upvalues: read (ref), u1 (copy)
                local v2 = read(u1.spacing);

                if typeof(v2) == "number" then
                    return UDim.new(0, v2);
                end;

                if typeof(v2) == "UDim" then
                    return v2;
                end;

                if typeof(v2) == "nil" then
                    return UDim.new(0, 8);
                end;

                return error("incorrect spacing type");
            end,

            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = u1.justifycontent,
            ItemLineAlignment = u1.alignitems,
            Wraps = u1.wraps
        }),
        unpack(u1)
    });
end;