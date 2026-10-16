-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local anim = require(script.Parent.Parent.Parent.util.anim);
local theme = require(script.Parent.Parent.Parent.util.theme);
local create = vide.create;
local read = vide.read;

return function(u1: table) -- Line: 24
    -- upvalues: create (copy), anim (copy), read (copy), theme (copy)
    return create("Frame")({
        Position = u1.position,
        Size = u1.size or UDim2.fromOffset(24, 24),
        AnchorPoint = u1.anchorpoint or Vector2.new(0.5, 0.5),
        AutomaticSize = u1.automaticsize,
        AutoLocalize = false,
        LayoutOrder = u1.layoutorder,
        ZIndex = u1.zindex,
        BackgroundColor3 = anim(function() -- Line: 37
            -- upvalues: read (ref), u1 (copy), theme (ref)
            if read(u1.checked) then
                return theme.acc[3]();
            end;

            return theme.bg[1]();
        end),
        create("UIStroke")({
            Color = function() -- Line: 42, Name: Color
                -- upvalues: read (ref), u1 (copy), theme (ref)
                if read(u1.checked) then
                    return theme.acc[0]();
                end;

                return theme.bg[-3]();
            end
        }),
        create("UICorner")({
            CornerRadius = UDim.new(0, 4)
        }),
        create("ImageLabel")({
            BackgroundTransparency = 1,
            Image = "rbxassetid://100188624502987",
            Size = UDim2.fromScale(1, 1),
            ImageTransparency = anim(function() -- Line: 56
                -- upvalues: read (ref), u1 (copy)
                return read(u1.checked) and 0 or 1;
            end)
        }),
        unpack(u1)
    });
end;