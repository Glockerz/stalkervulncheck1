-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide);
local create = vide.create;
local indexes = vide.indexes;
local derive = vide.derive;

return function(u1: table) -- Line: 12
    -- upvalues: derive (copy), create (copy), indexes (copy)
    local u3 = derive(function() -- Line: 14
        -- upvalues: u1 (copy)
        local v2 = 0;

        for _, v in u1.values() do
            v2 = v2 + v.value;
        end;

        return v2;
    end);

    return create("Frame")({
        Name = "Graph",
        Size = UDim2.new(1, 0, 0, 32),
        indexes(u1.values, function(u4, u5) -- Line: 26
            -- upvalues: create (ref), u3 (copy), u1 (copy)
            return create("Frame")({
                Size = function() -- Line: 29, Name: Size
                    -- upvalues: u4 (copy), u3 (ref)
                    return UDim2.fromScale(u4().value / u3(), 1);
                end,

                BackgroundColor3 = function() -- Line: 33, Name: BackgroundColor3
                    -- upvalues: u4 (copy)
                    return u4().color;
                end,

                MouseEnter = function() -- Line: 35, Name: MouseEnter
                    -- upvalues: u1 (ref), u5 (copy)
                    u1.selected(u5);
                end
            });
        end),
        create("UIListLayout")({
            FillDirection = Enum.FillDirection.Horizontal
        })
    });
end;