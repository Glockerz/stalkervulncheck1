-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.Parent.util.theme);
local list = require(script.Parent.Parent.Parent.util.list);
local padding = require(script.Parent.Parent.Parent.util.padding);
local rounded_frame = require(script.Parent.Parent.Parent.util.rounded_frame);
local typography = require(script.Parent.Parent.typography);
local create = vide.create;
local source = vide.source;
local changed = vide.changed;
local spring = vide.spring;
local show = vide.show;

return function(u1: table) -- Line: 30
    -- upvalues: source (copy), rounded_frame (copy), theme (copy), create (copy), changed (copy), padding (copy), list (copy), typography (copy), show (copy), spring (copy)
    local bind_to_close = u1.bind_to_close;
    local dragging = u1.dragging;
    local offset = u1.offset;
    local u2 = source(Vector2.zero);
    local u3 = source(Enum.GuiState.Idle);

    return rounded_frame({
        name = "Topbar",
        size = UDim2.new(1, 0, 0, 48),
        color = theme.bg[3],
        topleft = u1.radius,
        topright = u1.radius,
        create("ImageButton")({
            Size = UDim2.fromScale(1, 1),
            AutoLocalize = false,
            BackgroundTransparency = 1,
            ZIndex = 1000,
            changed("AbsolutePosition", u2),

            MouseButton1Down = function(p4, p5) -- Line: 59, Name: MouseButton1Down
                -- upvalues: offset (copy), u2 (copy), dragging (copy)
                offset(u2() - Vector2.new(p4, p5));
                dragging(true);
            end,

            create("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalFlex = Enum.UIFlexAlignment.Fill
            }),
            padding({
                x = UDim.new(0, 16)
            }),
            list({
                spacing = UDim.new(),
                typography({
                    textsize = 20,
                    header = true,
                    size = UDim2.fromScale(1, 0),
                    text = u1.title,
                    xalignment = Enum.TextXAlignment.Left,
                    truncate = Enum.TextTruncate.SplitWord
                }),
                show(function() -- Line: 86
                    -- upvalues: u1 (copy)
                    return u1.subtitle ~= nil;
                end, function() -- Line: 88
                    -- upvalues: typography (ref), u1 (copy)
                    return typography({
                        bold = true,
                        textsize = 16,
                        size = UDim2.fromScale(1, 0),
                        text = u1.subtitle,
                        xalignment = Enum.TextXAlignment.Left,
                        truncate = Enum.TextTruncate.SplitWord
                    });
                end)
            }),
            show(source(bind_to_close and true or false), function() -- Line: 103
                -- upvalues: create (ref), spring (ref), u3 (copy), theme (ref), changed (ref), u1 (copy)
                return create("ImageButton")({
                    Size = UDim2.fromOffset(32, 32),
                    BackgroundColor3 = spring(function() -- Line: 108
                        -- upvalues: u3 (ref), theme (ref)
                        if u3() == Enum.GuiState.Hover then
                            return theme.bg[5]();
                        end;

                        if u3() == Enum.GuiState.Press then
                            return theme.bg[0]();
                        end;

                        return theme.bg[3]();
                    end, 0.1),
                    changed("GuiState", u3),
                    Activated = u1.bind_to_close,
                    create("UICorner")({
                        CornerRadius = UDim.new(1, 0)
                    }),
                    create("ImageLabel")({
                        AutoLocalize = false,
                        BackgroundTransparency = 1,
                        Image = "rbxassetid://10747384394",
                        Size = UDim2.fromOffset(24, 24),
                        Position = UDim2.fromScale(0.5, 0.5),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        ImageColor3 = theme.fg_on_bg_high[3]
                    }),
                    create("UIFlexItem")({
                        ShrinkRatio = 0,
                        FlexMode = Enum.UIFlexMode.Custom
                    })
                });
            end)
        })
    });
end;