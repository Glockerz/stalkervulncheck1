-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local list = require(script.Parent.Parent.util.list);
local padding = require(script.Parent.Parent.util.padding);
local background = require(script.Parent.background);
local typography = require(script.Parent.typography);
local create = vide.create;
local read = vide.read;
local show = vide.show;

return function(u1: table) -- Line: 27
    -- upvalues: create (copy), theme (copy), show (copy), read (copy), background (copy), typography (copy), padding (copy), list (copy)
    return create("Frame")({
        Name = u1.name,
        Size = u1.size or UDim2.fromScale(1, 0),
        Position = u1.position,
        AnchorPoint = u1.anchorpoint,
        LayoutOrder = u1.layoutorder,
        AutomaticSize = u1.automaticsize or Enum.AutomaticSize.Y,
        BackgroundColor3 = theme.bg[0],
        AutoLocalize = false,
        create("UICorner")({
            CornerRadius = UDim.new(0, 8)
        }),
        create("UIStroke")({
            Color = theme.bg[-3]
        }),
        show(function() -- Line: 45
            -- upvalues: read (ref), u1 (copy)
            if read(u1.name) then
                return #read(u1.name) > 0;
            end;

            return false;
        end, function() -- Line: 47
            -- upvalues: background (ref), typography (ref), u1 (copy), padding (ref)
            return background({
                size = UDim2.new(),
                position = UDim2.fromOffset(4, -16),
                automaticsize = Enum.AutomaticSize.XY,
                typography({
                    disabled = true,
                    textsize = 14,
                    text = u1.name
                }),
                padding({
                    x = UDim.new(0, 2),
                    y = UDim.new()
                })
            });
        end),
        padding({}),
        list({ unpack(u1) })
    });
end;