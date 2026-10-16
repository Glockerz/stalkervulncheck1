-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local scroll_frame = require(script.Parent.Parent.display.scroll_frame);
local container = require(script.Parent.Parent.util.container);
local list = require(script.Parent.Parent.util.list);
local padding = require(script.Parent.Parent.util.padding);
local portal = require(script.Parent.Parent.util.portal);
local button = require(script.Parent.button);
local create = vide.create;
local source = vide.source;
local changed = vide.changed;
local indexes = vide.indexes;
local spring = vide.spring;
local read = vide.read;

return function(p1: table) -- Line: 31, Name: dropdown
    -- upvalues: source (copy), spring (copy), button (copy), read (copy), create (copy), container (copy), theme (copy), portal (copy), padding (copy), scroll_frame (copy), list (copy), changed (copy), indexes (copy)
    local selected = p1.selected;
    local u2 = p1.update_selected or function() -- Line: 34
    end;
    local options = p1.options;
    local u3 = source(false);
    local u4 = source(Vector2.zero);
    local u5 = spring(function() -- Line: 40
        -- upvalues: u3 (copy), u4 (copy)
        if not u3() then
            return UDim2.fromScale(1, 0);
        end;

        local UDim2_new = UDim2.new;
        local Y = u4().Y;

        return UDim2_new(1, 0, 0, (math.min(100, Y)));
    end, 0.1);

    return button({
        size = p1.size or UDim2.fromOffset(200, 32),
        position = p1.position or UDim2.fromScale(0.5, 0.5),
        anchorpoint = p1.anchorpoint or Vector2.new(0.5, 0.5),
        xalignment = Enum.TextXAlignment.Left,

        text = function() -- Line: 53, Name: text
            -- upvalues: read (ref), options (copy), selected (copy)
            return read(options)[read(selected)];
        end,

        activated = function() -- Line: 57, Name: activated
            -- upvalues: u3 (copy)
            u3(not u3());
        end,

        create("UIListLayout")({
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 8)
        }),
        container({
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.fromScale(1, 0),
            Size = UDim2.new(0, 18, 0, 16),
            LayoutOrder = -1,
            create("ImageLabel")({
                Name = "arrow",
                AutoLocalize = false,
                BackgroundTransparency = 1,
                Image = "rbxassetid://7260137654",
                Size = UDim2.new(0, 8, 0, 4),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Rotation = spring(function() -- Line: 83
                    -- upvalues: u3 (copy)
                    return u3() and -180 or 0;
                end, 0.1),
                BackgroundColor3 = theme.fg_on_bg_high[3],
                ImageColor3 = theme.fg_on_bg_low[3],
                ScaleType = Enum.ScaleType.Stretch
            })
        }),
        portal({
            inherit_layout = true,
            container({
                Position = UDim2.new(0, 1, 1, 4),
                Size = u5,
                BackgroundTransparency = 0,
                BackgroundColor3 = theme.bg[3],
                ClipsDescendants = true,

                Visible = function() -- Line: 111, Name: Visible
                    -- upvalues: u5 (copy)
                    return u5().Y.Offset > 1;
                end,

                padding({
                    padding = UDim.new(0, 2)
                }),
                scroll_frame({
                    Size = UDim2.fromScale(1, 1),
                    ScrollBarThickness = 4,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    list({
                        spacing = UDim.new(0, 1),
                        changed("AbsoluteSize", u4),
                        indexes(function() -- Line: 129
                            -- upvalues: read (ref), options (copy)
                            return read(options);
                        end, function(p6, u7) -- Line: 131
                            -- upvalues: button (ref), u3 (copy), u2 (copy), create (ref)
                            return button({
                                size = UDim2.new(1, 0, 0, 30),
                                text = p6,
                                stroke = false,

                                activated = function() -- Line: 137, Name: activated
                                    -- upvalues: u3 (ref), u2 (ref), u7 (copy)
                                    u3(false);
                                    u2(u7);
                                end,

                                create("UIListLayout")({
                                    FillDirection = Enum.FillDirection.Horizontal,
                                    VerticalAlignment = Enum.VerticalAlignment.Center,
                                    Padding = UDim.new(0, 8)
                                })
                            });
                        end)
                    })
                }),
                create("UIStroke")({
                    Color = theme.bg[-3]
                }),
                create("UICorner")({
                    CornerRadius = UDim.new(0, 3)
                })
            })
        })
    });
end;