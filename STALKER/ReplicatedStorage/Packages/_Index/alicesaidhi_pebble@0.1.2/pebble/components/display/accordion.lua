-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local container = require(script.Parent.Parent.util.container);
local padding = require(script.Parent.Parent.util.padding);
local typography = require(script.Parent.typography);
local create = vide.create;
local source = vide.source;
local changed = vide.changed;
local spring = vide.spring;

return function(u1: table) -- Line: 24
    -- upvalues: source (copy), container (copy), spring (copy), create (copy), theme (copy), padding (copy), typography (copy), changed (copy)
    local u2 = source(Enum.GuiState.Idle);
    local u3 = source(Vector2.zero);

    return container({
        Name = "Accordion",
        Size = spring(function() -- Line: 31
            -- upvalues: u1 (copy), u3 (copy)
            if u1.expanded() == false then
                return UDim2.new(1, 0, 0, 32);
            end;

            return UDim2.new(1, 0, 0, 40 + u3().Y);
        end, 0.1),
        ClipsDescendants = true,
        create("ImageButton")({
            Name = "Accordion",
            AutoLocalize = false,
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundColor3 = spring(function() -- Line: 42
                -- upvalues: u2 (copy), theme (ref)
                if u2() == Enum.GuiState.Press then
                    return theme.bg[-1]();
                end;

                if u2() == Enum.GuiState.Hover then
                    return theme.bg[3]();
                end;

                return theme.bg[0]();
            end, 0.1),
            padding({
                x = UDim.new(0, 8)
            }),
            create("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 8)
            }),
            create("UICorner")({
                CornerRadius = UDim.new(0, 8)
            }),
            container({
                Size = UDim2.fromOffset(16, 16),
                create("ImageLabel")({
                    BackgroundTransparency = 1,
                    AutoLocalize = false,
                    Image = "rbxassetid://10709790948",
                    Size = UDim2.fromOffset(16, 16),
                    Rotation = spring(function() -- Line: 71
                        -- upvalues: u1 (copy)
                        return u1.expanded() and 180 or 0;
                    end, 0.1)
                })
            }),
            typography({
                size = UDim2.fromScale(0, 1),
                text = u1.text,
                truncate = Enum.TextTruncate.SplitWord,
                xalignment = Enum.TextXAlignment.Left,
                create("UIFlexItem")({
                    FlexMode = Enum.UIFlexMode.Fill
                })
            }),

            Activated = function() -- Line: 88, Name: Activated
                -- upvalues: u1 (copy)
                u1.set_expanded(not u1.expanded());
            end,

            changed("GuiState", u2)
        }),
        container({
            Name = "Children",
            Position = UDim2.fromOffset(0, 40),
            AutomaticSize = Enum.AutomaticSize.None,

            Size = function() -- Line: 101, Name: Size
                -- upvalues: u3 (copy)
                return UDim2.new(1, 0, 0, u3().Y);
            end,

            BackgroundColor3 = theme.bg[3],
            ClipsDescendants = true,
            container({
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                unpack(u1),
                changed("AbsoluteSize", u3)
            })
        })
    });
end;