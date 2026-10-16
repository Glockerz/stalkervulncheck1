-- Decompiled with Potassium's decompiler.

local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble);
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide);
require(script.Parent.Parent.Parent.Parent.modules.types);
local tooltip = require(script.Parent.Parent.Parent.components.tooltip);
local virtualscroller_horizontal = require(script.Parent.Parent.Parent.components.virtualscroller_horizontal);
local create = vide.create;
local source = vide.source;

return function(p1: table) -- Line: 26
    -- upvalues: source (copy), pebble (copy), virtualscroller_horizontal (copy), create (copy), tooltip (copy)
    local recording = p1.recording;
    local watching_frame = p1.watching_frame;
    local per_frame_data = p1.per_frame_data;
    local changes = p1.changes;

    local function sheet_changes() -- Line: 33
        -- upvalues: changes (copy)
        local v2 = changes();

        return {
            { "type", unpack(v2.types) },
            { "entity", unpack(v2.entities) },
            { "component", unpack(v2.component) },
            { "value", unpack(v2.values) }
        };
    end;

    local function max() -- Line: 44
        -- upvalues: per_frame_data (copy)
        return math.max(1, unpack(per_frame_data()));
    end;

    local function total_changes() -- Line: 48
        -- upvalues: per_frame_data (copy)
        local v3 = 0;

        for _, v in per_frame_data() do
            v3 = v3 + v;
        end;

        return v3;
    end;

    local u4 = source(false);

    return pebble.list({
        justifycontent = Enum.UIFlexAlignment.SpaceEvenly,
        spacing = UDim.new(0, 4),
        pebble.pane({ virtualscroller_horizontal({
                item_size = 6,

                item = function(u5) -- Line: 65, Name: item
                    -- upvalues: per_frame_data (copy), create (ref), u4 (copy), pebble (ref), watching_frame (copy)
                    local function value() -- Line: 66
                        -- upvalues: per_frame_data (ref), u5 (copy)
                        return per_frame_data()[u5()] or 0;
                    end;

                    return create("TextButton")({
                        Size = function() -- Line: 71, Name: Size
                            return UDim2.new(0, 6, 1, 0);
                        end,

                        BackgroundTransparency = function() -- Line: 74, Name: BackgroundTransparency
                            -- upvalues: u4 (ref), u5 (copy)
                            return u4() == u5() and 0.5 or 1;
                        end,

                        BackgroundColor3 = pebble.theme.bg[10],

                        MouseEnter = function() -- Line: 79, Name: MouseEnter
                            -- upvalues: u4 (ref), u5 (copy)
                            u4(u5());
                        end,

                        MouseLeave = function() -- Line: 82, Name: MouseLeave
                            -- upvalues: u4 (ref), u5 (copy)
                            if u4() ~= u5() then
                                return;
                            end;

                            u4(false);
                        end,

                        Activated = function() -- Line: 86, Name: Activated
                            -- upvalues: watching_frame (ref), u5 (copy)
                            watching_frame(u5());
                        end,

                        AutoLocalize = false,
                        create("Frame")({
                            Size = function() -- Line: 92, Name: Size
                                -- upvalues: per_frame_data (ref), u5 (copy)
                                return UDim2.fromScale(1, (per_frame_data()[u5()] or 0) / math.max(1, unpack(per_frame_data())));
                            end,

                            Position = UDim2.fromScale(1, 1),
                            AnchorPoint = Vector2.new(1, 1),

                            BackgroundColor3 = function() -- Line: 97, Name: BackgroundColor3
                                -- upvalues: watching_frame (ref), u5 (copy), pebble (ref), u4 (ref)
                                if watching_frame() == u5() then
                                    return pebble.theme.acc[20]();
                                end;

                                if u4() == u5() then
                                    return pebble.theme.acc[5]();
                                end;

                                return pebble.theme.acc[0]();
                            end
                        })
                    });
                end,

                max_items = function() -- Line: 108, Name: max_items
                    -- upvalues: per_frame_data (copy)
                    return #per_frame_data();
                end,

                create("UIStroke")({
                    Color = pebble.theme.bg[-3]
                }),
                {
                    ScrollBarThickness = 6,
                    Size = UDim2.new(1, 0, 0, 56),
                    HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
                    BackgroundColor3 = pebble.theme.bg[-1],

                    CanvasPosition = function() -- Line: 120, Name: CanvasPosition
                        -- upvalues: per_frame_data (copy)
                        per_frame_data();

                        return Vector2.new(table.maxn(per_frame_data()) * 6);
                    end
                }
            }), pebble.typography({
                text = function() -- Line: 128, Name: text
                    -- upvalues: per_frame_data (copy)
                    local v6 = #per_frame_data();
                    local v7 = 0;

                    for _, v in per_frame_data() do
                        v7 = v7 + v;
                    end;

                    return `Recorded {v6} frames and tracked {v7} changes`;
                end
            }), pebble.typography({
                text = function() -- Line: 134, Name: text
                    -- upvalues: watching_frame (copy)
                    return `Currently viewing frame {watching_frame()}`;
                end
            }) }),
        tooltip({
            transparency = 0,

            visible = function() -- Line: 142, Name: visible
                -- upvalues: u4 (copy)
                return u4() ~= false;
            end,

            pebble.typography({
                wrapped = true,
                automaticsize = Enum.AutomaticSize.XY,

                text = function() -- Line: 149, Name: text
                    -- upvalues: u4 (copy), per_frame_data (copy)
                    return `Frame: #{u4()}\nChanges: {per_frame_data()[u4()] or 0}`;
                end,

                xalignment = Enum.TextXAlignment.Left
            })
        }),
        pebble.container({
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = pebble.theme.bg[1],
            BackgroundTransparency = 0,
            create("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
                VerticalFlex = Enum.UIFlexAlignment.Fill,
                Padding = UDim.new(0, 8)
            }),
            pebble.padding({
                x = UDim.new(0, 4),
                y = UDim.new(0, 4)
            }),
            pebble.button({
                size = UDim2.new(0, 80, 0, 30),
                automaticsize = Enum.AutomaticSize.X,

                text = function() -- Line: 180, Name: text
                    -- upvalues: recording (copy)
                    return recording() and "Pause" or "Record";
                end,

                activated = function() -- Line: 184, Name: activated
                    -- upvalues: recording (copy)
                    recording(not recording());
                end
            }),
            pebble.container({
                Size = UDim2.fromScale(0, 0),
                create("UIFlexItem")({
                    FlexMode = Enum.UIFlexMode.Fill
                }),
                pebble.textfield({
                    placeholder = "frame",
                    size = UDim2.new(1, 0, 1, 0),
                    text = tostring(watching_frame()),

                    enter = function(p8: string) -- Line: 201, Name: enter
                        -- upvalues: watching_frame (copy)
                        if tonumber(p8) == nil then
                            return;
                        end;

                        watching_frame((tonumber(p8)));
                    end
                })
            })
        }),
        pebble.container({
            Size = UDim2.fromScale(1, 1),
            create("UIFlexItem")({
                FlexMode = Enum.UIFlexMode.Fill
            }),
            pebble.tablesheet({
                size = UDim2.fromScale(1, 1),
                column_sizes = source({ 100, 80, 100, 200 }),

                read_value = function(p9, p10) -- Line: 221, Name: read_value
                    -- upvalues: sheet_changes (copy)
                    local v11 = sheet_changes()[p9][p10];

                    return v11 == false and "" or v11;
                end,

                on_click = function() -- Line: 226, Name: on_click
                end,

                on_click2 = function() -- Line: 227, Name: on_click2
                end,

                columns = sheet_changes
            })
        })
    });
end;