-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local button = require(script.Parent.Parent.interactable.button);
local rounded_frame = require(script.Parent.Parent.util.rounded_frame);
local virtualscroller = require(script.Parent.Parent.util.virtualscroller);
local resizeable_bar = require(script.Parent.resizeable_bar);
local scroll_frame = require(script.Parent.scroll_frame);
local create = vide.create;
local source = vide.source;
local derive = vide.derive;
local indexes = vide.indexes;

return function(u1: table) -- Line: 31
    -- upvalues: source (copy), derive (copy), scroll_frame (copy), create (copy), resizeable_bar (copy), indexes (copy), theme (copy), virtualscroller (copy), button (copy), rounded_frame (copy)
    local v2 = source({});
    local u3 = source({});
    local v5 = derive(function() -- Line: 35
        -- upvalues: u1 (copy)
        local v4 = {};

        for i, v in u1.columns() do
            v4[i] = v[1];
        end;

        return v4;
    end);

    local function get_size(p6: number) -- Line: 45
        -- upvalues: u3 (copy), source (ref)
        local v7 = u3()[p6 - 1] or source(0);

        return (u3()[p6] or source(1))() - v7();
    end;

    return scroll_frame({
        Size = u1.size or UDim2.new(1, 0, 0, 256),

        CanvasSize = function() -- Line: 55, Name: CanvasSize
            return UDim2.new(1, 0);
        end,

        create("UIListLayout")({
            VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
        }),
        resizeable_bar({
            meaning = v5,
            sizes = v2,
            splits = u3,
            base_splits = u1.base_splits,
            suggested_sizes = u1.suggested_column_sizes
        }),
        create("Folder")({ indexes(v5, function(p8, u9) -- Line: 73
                -- upvalues: create (ref), u3 (copy), theme (ref)
                return create("Frame")({
                    AutoLocalize = false,
                    ZIndex = 100,
                    Size = UDim2.new(0, 1, 1, -32),

                    Position = function() -- Line: 77, Name: Position
                        -- upvalues: u3 (ref), u9 (copy)
                        local v10 = u3()[u9];

                        if v10 then
                            return UDim2.fromScale(v10(), 0);
                        end;

                        return UDim2.fromScale(0, 0);
                    end,

                    BackgroundColor3 = theme.bg[-1]
                });
            end) }),
        virtualscroller({
            size = UDim2.fromScale(1, 0),
            create("UIFlexItem")({
                FlexMode = Enum.UIFlexMode.Grow
            }),
            {
                BackgroundTransparency = 0,
                BackgroundColor3 = theme.bg[0],
                VerticalScrollBarInset = Enum.ScrollBarInset.None
            },
            item_size = 32,

            item = function(u11) -- Line: 103, Name: item
                -- upvalues: create (ref), theme (ref), indexes (ref), u1 (copy), button (ref), u3 (copy), source (ref)
                return create("Frame")({
                    Size = UDim2.new(1, 0, 0, 32),
                    AutoLocalize = false,
                    BackgroundColor3 = theme.bg[2],
                    create("UIListLayout")({
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, 0)
                    }),
                    create("UIStroke")({
                        Color = theme.bg[-1]
                    }),
                    indexes(u1.columns, function(p12, u13) -- Line: 120
                        -- upvalues: button (ref), u3 (ref), source (ref), u1 (ref), u11 (copy), create (ref)
                        return button({
                            size = function() -- Line: 122, Name: size
                                -- upvalues: u13 (copy), u3 (ref), source (ref)
                                local v14 = u13;
                                local v15 = u3()[v14 - 1] or source(0);
                                local v16 = (u3()[v14] or source(1))() - v15();

                                return UDim2.new(v16, 0, 0, 32);
                            end,

                            text = function() -- Line: 127, Name: text
                                -- upvalues: u1 (ref), u13 (copy), u11 (ref)
                                return u1.read_value(u13, u11() + 1) or "";
                            end,

                            create("UIListLayout")({
                                FillDirection = Enum.FillDirection.Horizontal,
                                VerticalAlignment = Enum.VerticalAlignment.Center
                            }),
                            xalignment = Enum.TextXAlignment.Left,
                            corner = false,
                            stroke = false,
                            code = true,

                            activated = function() -- Line: 142, Name: activated
                                -- upvalues: u1 (ref), u13 (copy), u11 (ref)
                                u1.on_click(u13, u11() + 2);
                            end,

                            mouse2 = function() -- Line: 146, Name: mouse2
                                -- upvalues: u1 (ref), u13 (copy), u11 (ref)
                                u1.on_click2(u13, u11() + 2);
                            end
                        });
                    end)
                });
            end,

            max_items = function() -- Line: 156, Name: max_items
                -- upvalues: u1 (copy)
                return (u1.columns()[1] ~= nil and #u1.columns()[1] or 0) - 1;
            end
        }),
        rounded_frame({
            size = function() -- Line: 165, Name: size
                return UDim2.new(1, 0, 0, 32);
            end,

            color = theme.bg[1],
            u1.below,
            bottomleft = UDim.new(0, 8),
            bottomright = UDim.new(0, 8)
        }),
        unpack(u1)
    });
end;