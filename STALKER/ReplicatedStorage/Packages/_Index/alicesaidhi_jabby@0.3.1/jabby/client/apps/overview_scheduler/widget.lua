-- Decompiled with Potassium's decompiler.

local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble);
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide);
local convert_units = require(script.Parent.Parent.Parent.Parent.modules.convert_units);
require(script.Parent.Parent.Parent.Parent.modules.types);
local spawn_app = require(script.Parent.Parent.Parent.spawn_app);
local system = require(script.Parent.Parent.system);
local stack_bar = require(script.Parent.stack_bar);
local create = vide.create;
local indexes = vide.indexes;
local values = vide.values;
local changed = vide.changed;
local source = vide.source;
local derive = vide.derive;

local function color(p1: number) -- Line: 32
    return Color3.fromHSV((p1 - 1) * 0.15 % 1, 1, 1);
end;

local u2 = { "Name", "Id", "Frame Time" };

return function(u3: table) -- Line: 42
    -- upvalues: source (copy), derive (copy), create (copy), pebble (copy), changed (copy), spawn_app (copy), system (copy), convert_units (copy), stack_bar (copy), u2 (copy), values (copy), indexes (copy)
    local v4 = source(0);
    local u5 = source("");
    local u6 = source(2);
    local u9 = derive(function() -- Line: 49
        -- upvalues: u3 (copy)
        local v7 = 0;

        for _, v in u3.system_frames() do
            local v8 = 0;

            for _, v2 in v do
                v8 = v8 + v2.s;
            end;

            v7 = math.max(v7, v8 / #v);
        end;

        return v7;
    end);
    local u11 = derive(function() -- Line: 63
        -- upvalues: u3 (copy)
        local v10 = {
            [false] = {}
        };

        for i, v in u3.system_data() do
            if v10[v.phase or false] == nil then
                v10[v.phase or false] = {};
            end;

            table.insert(v10[v.phase or false], i);
        end;

        return v10;
    end);

    local function u22(u12: number) -- Line: 72
        -- upvalues: source (ref), u3 (copy), create (ref), u6 (copy), pebble (ref), u5 (copy), changed (ref), spawn_app (ref), system (ref), u9 (copy), convert_units (ref)
        local u13 = source(Enum.GuiState.Idle);

        local function frame_time() -- Line: 75
            -- upvalues: u3 (ref), u12 (copy)
            local v14 = u3.system_frames()[u12];
            local v15 = 0;

            for _, v in v14 do
                v15 = v15 + v.s;
            end;

            return v15 / #v14;
        end;

        return create("ImageButton")({
            Name = function() -- Line: 87, Name: Name
                -- upvalues: u3 (ref), u12 (copy)
                return u3.system_data()[u12].name;
            end,

            Size = UDim2.new(1, 0, 0, 32),

            LayoutOrder = function() -- Line: 92, Name: LayoutOrder
                -- upvalues: u6 (ref), u3 (ref), u12 (copy)
                if u6() ~= 3 then
                    return u12;
                end;

                local v16 = u3.system_frames()[u12];
                local v17 = 0;

                for _, v in v16 do
                    v17 = v17 + v.s;
                end;

                return 1000000000 - v17 / #v16 * 100000000;
            end,

            BackgroundColor3 = function() -- Line: 96, Name: BackgroundColor3
                -- upvalues: u13 (copy), pebble (ref)
                if u13() == Enum.GuiState.Press then
                    return pebble.theme.bg[-1]();
                end;

                if u13() == Enum.GuiState.Hover then
                    return pebble.theme.bg[6]();
                end;

                return pebble.theme.bg[3]();
            end,

            Visible = function() -- Line: 105, Name: Visible
                -- upvalues: u3 (ref), u12 (copy), u5 (ref)
                return string.match(u3.system_data()[u12].name, u5()) and true or false;
            end,

            changed("GuiState", u13),

            Activated = function() -- Line: 111, Name: Activated
                -- upvalues: spawn_app (ref), system (ref), u3 (ref), u12 (copy)
                spawn_app.spawn_app(system, {
                    host = u3.host,
                    vm = u3.vm,
                    scheduler = u3.id,
                    system = u12,
                    name = u3.system_data()[u12].name
                });
            end,

            MouseButton2Click = function() -- Line: 122, Name: MouseButton2Click
                -- upvalues: u3 (ref), u12 (copy)
                u3.pause_system(u12);
            end,

            create("Folder")({ create("Frame")({
                    Position = UDim2.new(0, 0, 1, 4),
                    AnchorPoint = Vector2.new(0, 1),

                    Size = function() -- Line: 131, Name: Size
                        -- upvalues: u3 (ref), u12 (copy), u9 (ref)
                        local UDim2_new = UDim2.new;
                        local v18 = u3.system_frames()[u12];
                        local v19 = 0;

                        for _, v in v18 do
                            v19 = v19 + v.s;
                        end;

                        return UDim2_new(v19 / #v18 / u9(), 0, 0, 1);
                    end,

                    BackgroundColor3 = pebble.theme.fg_on_bg_high[0]
                }) }),
            create("UIStroke")({
                Color = pebble.theme.bg[-3]
            }),
            create("UICorner")({
                CornerRadius = UDim.new(0, 4)
            }),
            create("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
                Padding = UDim.new(0, 8)
            }),
            pebble.padding({
                x = UDim.new(0, 8)
            }),
            create("Frame")({
                Size = UDim2.fromOffset(16, 16),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromHSV((u12 - 1) * 0.15 % 1, 1, 1),
                create("UICorner")({
                    CornerRadius = UDim.new(1, 0)
                })
            }),
            pebble.typography({
                automaticsize = Enum.AutomaticSize.None,

                text = function() -- Line: 172, Name: text
                    -- upvalues: u3 (ref), u12 (copy)
                    return u3.system_data()[u12].name;
                end,

                truncate = Enum.TextTruncate.SplitWord,
                xalignment = Enum.TextXAlignment.Left,

                disabled = function() -- Line: 178, Name: disabled
                    -- upvalues: u3 (ref), u12 (copy)
                    return u3.system_data()[u12].paused;
                end,

                create("UIFlexItem")({
                    GrowRatio = 1,
                    ShrinkRatio = 1,
                    FlexMode = Enum.UIFlexMode.Fill
                })
            }),
            pebble.typography({
                disabled = true,
                automaticsize = Enum.AutomaticSize.XY,

                text = function() -- Line: 191, Name: text
                    -- upvalues: u3 (ref), u12 (copy), convert_units (ref)
                    local v20 = u3.system_frames()[u12];
                    local v21 = 0;

                    for _, v in v20 do
                        v21 = v21 + v.s;
                    end;

                    return `{convert_units("s", v21 / #v20)}`;
                end,

                xalignment = Enum.TextXAlignment.Right
            })
        });
    end;

    return pebble.widget({
        title = "Scheduler",
        subtitle = `host: {u3.host} vm: {u3.vm} id: {u3.id}`,
        min_size = Vector2.new(200, 300),
        bind_to_close = u3.destroy,
        create("Frame")({
            Name = "Elements",
            Size = UDim2.fromScale(1, 1),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            create("UIListLayout")({
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
                FillDirection = Enum.FillDirection.Vertical,
                VerticalFlex = Enum.UIFlexAlignment.SpaceBetween,
                Padding = UDim.new(0, 8)
            }),
            create("Frame")({
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                pebble.pane({
                    name = "Overview",
                    size = UDim2.fromScale(1, 0),
                    create("UIListLayout")({
                        FillDirection = Enum.FillDirection.Vertical
                    }),
                    pebble.typography({
                        text = function() -- Line: 255, Name: text
                            -- upvalues: u3 (copy), convert_units (ref)
                            local v23 = 0;

                            for i, v in u3.system_frames() do
                                if not u3.system_data()[i].paused then
                                    local v24 = 0;

                                    for _, v2 in v do
                                        v24 = v24 + v2.s;
                                    end;

                                    v23 = v23 + v24 / #v;
                                end;
                            end;

                            return `Run time: {convert_units("s", v23)}`;
                        end
                    }),
                    stack_bar({
                        values = function() -- Line: 273, Name: values
                            -- upvalues: u3 (copy)
                            local v25 = u3.system_ids();
                            local v26 = u3.system_frames();
                            local v27 = {};

                            for i = 1, table.maxn(v25) do
                                local v28;

                                if v25[i] == nil or u3.system_data()[i].paused then
                                    v28 = i;
                                else
                                    local v29 = v26[i];
                                    v28 = i;
                                    local v30 = 0;

                                    for _, v in v29 do
                                        v30 = v30 + v.s;
                                    end;

                                    local v31 = {
                                        value = v30 / #v29,
                                        color = Color3.fromHSV((v28 - 1) * 0.15 % 1, 1, 1)
                                    };
                                    table.insert(v27, v31);
                                end;
                            end;

                            return v27;
                        end,

                        selected = v4
                    }),
                    pebble.row({
                        justifycontent = Enum.UIFlexAlignment.Fill,
                        pebble.button({
                            text = "Pause all",

                            activated = function() -- Line: 303, Name: activated
                                -- upvalues: u3 (copy)
                                for i, v in u3.system_data() do
                                    if not v.paused then
                                        u3.pause_system(i);
                                    end;
                                end;
                            end
                        }),
                        pebble.button({
                            text = "Resume all",

                            activated = function() -- Line: 314, Name: activated
                                -- upvalues: u3 (copy)
                                for i, v in u3.system_data() do
                                    if v.paused then
                                        u3.pause_system(i);
                                    end;
                                end;
                            end
                        })
                    })
                })
            }),
            pebble.select({
                size = UDim2.new(1, 0, 0, 30),
                options = u2,
                selected = u6,

                update_selected = function(p32) -- Line: 331, Name: update_selected
                    -- upvalues: u6 (copy)
                    u6(p32);
                end
            }),
            pebble.textfield({
                placeholder = "System Match",
                size = UDim2.new(1, 0, 0, 36),
                oninput = u5
            }),
            create("ScrollingFrame")({
                Name = "Systems",
                Size = UDim2.fromScale(1, 0),
                CanvasSize = UDim2.new(),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                ScrollBarThickness = 6,
                VerticalScrollBarInset = Enum.ScrollBarInset.Always,
                ScrollBarImageColor3 = pebble.theme.fg_on_bg_low[3],
                create("UIFlexItem")({
                    FlexMode = Enum.UIFlexMode.Fill
                }),
                create("UIListLayout")({
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, 8),

                    SortOrder = function() -- Line: 366, Name: SortOrder
                        -- upvalues: u6 (copy)
                        if u6() == 1 then
                            return Enum.SortOrder.Name;
                        end;

                        return Enum.SortOrder.LayoutOrder;
                    end
                }),
                pebble.padding({
                    y = UDim.new(0, 1),
                    x = UDim.new(0, 1)
                }),
                values(function() -- Line: 376
                    -- upvalues: u11 (copy)
                    return u11()[false];
                end, u22),
                indexes(u11, function(p33, p34) -- Line: 380
                    -- upvalues: source (ref), pebble (ref), create (ref), u6 (copy), values (ref), u22 (copy)
                    if p34 == false then
                        return {};
                    end;

                    local v35 = source(true);

                    return pebble.accordion({
                        expanded = v35,
                        set_expanded = v35,
                        text = p34,
                        pebble.container({
                            Size = UDim2.fromScale(1, 0),
                            create("UIListLayout")({
                                FillDirection = Enum.FillDirection.Vertical,
                                Padding = UDim.new(0, 8),

                                SortOrder = function() -- Line: 396, Name: SortOrder
                                    -- upvalues: u6 (ref)
                                    if u6() == 1 then
                                        return Enum.SortOrder.Name;
                                    end;

                                    return Enum.SortOrder.LayoutOrder;
                                end
                            }),
                            values(p33, u22)
                        })
                    });
                end)
            })
        })
    });
end;