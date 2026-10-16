-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local create = vide.create;
local read = vide.read;

return function(u1: table) -- Line: 24
    -- upvalues: create (copy), read (copy), theme (copy)
    return create("Frame")({
        Position = u1.position,
        Size = u1.size or UDim2.fromScale(1, 1),
        AnchorPoint = u1.anchorpoint,
        AutomaticSize = u1.automaticsize,
        AutoLocalize = false,
        LayoutOrder = u1.layoutorder,
        ZIndex = u1.zindex,

        BackgroundColor3 = function() -- Line: 37, Name: BackgroundColor3
            -- upvalues: read (ref), u1 (copy), theme (ref)
            if read(u1.accent) then
                return theme.acc[read(u1.depth) or 0]();
            end;

            return theme.bg[read(u1.depth) or 0]();
        end,

        unpack(u1)
    });
end;