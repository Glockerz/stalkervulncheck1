-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local create = vide.create;
local read = vide.read;

return function(u1: table) -- Line: 13
    -- upvalues: create (copy), theme (copy), read (copy)
    return create("Frame")({
        AutoLocalize = false,
        BackgroundColor3 = theme.bg[-2],
        Position = u1.position,

        Size = function() -- Line: 19, Name: Size
            -- upvalues: read (ref), u1 (copy)
            return UDim2.new(1, 0, 0, read(u1.thickness) or 1);
        end
    });
end;