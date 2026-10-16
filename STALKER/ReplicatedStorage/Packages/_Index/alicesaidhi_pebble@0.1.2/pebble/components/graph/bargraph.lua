-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local container = require(script.Parent.Parent.util.container);
local create = vide.create;
local indexes = vide.indexes;
local read = vide.read;

return function(u1: table) -- Line: 24
    -- upvalues: container (copy), indexes (copy), create (copy), read (copy), theme (copy)
    local u2 = u1.max or function() -- Line: 26
        -- upvalues: u1 (copy)
        return math.max(unpack(u1.values()));
    end;

    local function total() -- Line: 30
        -- upvalues: u1 (copy)
        return #u1.values();
    end;

    return container({
        Position = u1.position,
        Size = u1.size,
        AnchorPoint = u1.anchorpoint,
        ClipsDescendants = true,
        indexes(u1.values, function(u3, u4) -- Line: 42
            -- upvalues: create (ref), u1 (copy), read (ref), u2 (copy), theme (ref)
            return create("Frame")({
                AutoLocalize = false,

                Position = function() -- Line: 47, Name: Position
                    -- upvalues: u4 (copy), u1 (ref)
                    return UDim2.fromScale((u4 - 1) / #u1.values(), 1);
                end,

                Size = function() -- Line: 50, Name: Size
                    -- upvalues: u1 (ref), u3 (copy), read (ref), u2 (ref)
                    return UDim2.fromScale(1 / #u1.values(), u3() / read(u2));
                end,

                AnchorPoint = Vector2.new(0, 1),
                create("UIGradient")({
                    Rotation = 90,

                    Color = function() -- Line: 59, Name: Color
                        -- upvalues: theme (ref)
                        return ColorSequence.new(theme.acc[10](), theme.acc[-3]());
                    end
                })
            });
        end),
        unpack(u1)
    });
end;