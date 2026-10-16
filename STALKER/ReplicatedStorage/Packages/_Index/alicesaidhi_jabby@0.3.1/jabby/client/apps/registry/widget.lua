-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble);
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide);
local tooltip = require(script.Parent.Parent.Parent.components.tooltip);
local spawn_app = require(script.Parent.Parent.Parent.spawn_app);
local entity = require(script.Parent.Parent.entity);
local create = vide.create;
local effect = vide.effect;
local source = vide.source;
local show = vide.show;
local u1 = source(Vector2.zero);
RunService.PreRender:Connect(function() -- Line: 49
    -- upvalues: u1 (copy), UserInputService (copy)
    u1(UserInputService:GetMouseLocation());
end);

return function(u2: table) -- Line: 53
    -- upvalues: source (copy), effect (copy), pebble (copy), create (copy), tooltip (copy), vide (copy), spawn_app (copy), entity (copy), show (copy)
    local u3 = source("1");
    local u4 = source("25");
    local u5 = source(1);
    local u6 = source(20);
    effect(function() -- Line: 61
        -- upvalues: u3 (copy), u5 (copy)
        u3((tostring(u5())));
    end);
    effect(function() -- Line: 65
        -- upvalues: u4 (copy), u6 (copy)
        u4((tostring(u6())));
    end);
    effect(function() -- Line: 69
        -- upvalues: u5 (copy), u6 (copy), u2 (copy)
        local v7 = u5();
        local v8 = u6();
        local v9 = (v7 - 1) * v8 + 1;
        u2.from(v9);
        u2.upto(v9 + v8 - 1);
    end);
    local v10 = {
        Size = UDim2.new(0, 0, 0, 26),
        AutomaticSize = Enum.AutomaticSize.X
    };

    return pebble.widget({
        title = "Querying",
        subtitle = `host: {u2.host} vm: {u2.vm} id: {u2.id}`,
        min_size = Vector2.new(300, 300),
        bind_to_close = u2.destroy,
        create("Frame")({
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            tooltip({
                transparency = 0.3,

                visible = function() -- Line: 100, Name: visible
                    -- upvalues: u2 (copy)
                    return u2.entity_hovering_over() and #u2.entity_hovering_over() > 0 and true or false;
                end,

                pebble.typography({
                    automaticsize = Enum.AutomaticSize.XY,

                    text = function() -- Line: 107, Name: text
                        -- upvalues: u2 (copy)
                        return u2.entity_hovering_over() or "";
                    end,

                    xalignment = Enum.TextXAlignment.Left,
                    wrapped = true,
                    code = true,
                    {
                        RichText = true
                    },
                    create("UIStroke")({
                        Thickness = 1,
                        Color = pebble.theme.bg[-5]
                    })
                })
            }),
            create("Highlight")({
                FillTransparency = 0.5,
                DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
                OutlineColor = Color3.new(1, 1, 1),
                FillColor = pebble.theme.acc[0],
                Adornee = u2.hovering_over
            }),
            create("UIListLayout")({
                VerticalFlex = Enum.UIFlexAlignment.SpaceAround,
                Padding = UDim.new(0, 8)
            }),
            create("Frame")({
                Name = "Query + Pick",
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 1,
                create("UIListLayout")({
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.SpaceAround,
                    VerticalFlex = Enum.UIFlexAlignment.SpaceAround,
                    Padding = UDim.new(0, 8)
                }),
                create("Frame")({
                    Name = "Query",
                    Size = UDim2.fromScale(0, 1),
                    BackgroundTransparency = 1,
                    create("UIFlexItem")({
                        FlexMode = Enum.UIFlexMode.Fill
                    }),
                    pebble.textfield({
                        placeholder = "Query",
                        code = true,
                        size = UDim2.new(1, 0, 0, 30),

                        oninput = function(p11) -- Line: 167, Name: oninput
                            -- upvalues: u2 (copy)
                            u2.validate_query(p11);
                        end,

                        enter = function(p12) -- Line: 171, Name: enter
                            -- upvalues: u2 (copy)
                            u2.update_system_query(p12);
                        end
                    })
                }),
                vide.show(function() -- Line: 178
                    -- upvalues: u2 (copy)
                    return u2.primary_entity();
                end, function() -- Line: 180
                    -- upvalues: pebble (ref), spawn_app (ref), entity (ref), u2 (copy), create (ref)
                    return pebble.button({
                        size = UDim2.fromOffset(30, 30),
                        text = "",

                        activated = function() -- Line: 186, Name: activated
                            -- upvalues: spawn_app (ref), entity (ref), u2 (ref)
                            spawn_app.spawn_app(entity, {
                                host = u2.host,
                                vm = u2.vm,
                                id = u2.id,
                                entity = u2.primary_entity()
                            });
                        end,

                        create("ImageLabel")({
                            BackgroundTransparency = 1,
                            Image = "rbxassetid://10723415903",
                            Size = UDim2.fromOffset(24, 24),
                            Position = UDim2.fromScale(0.5, 0.5),
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            ImageColor3 = pebble.theme.fg_on_bg_high[3]
                        })
                    });
                end),
                pebble.button({
                    size = UDim2.fromOffset(30, 30),
                    text = "",
                    accent = u2.enable_pick,

                    activated = function() -- Line: 217, Name: activated
                        -- upvalues: u2 (copy)
                        u2.enable_pick(not u2.enable_pick());
                    end,

                    create("ImageLabel")({
                        BackgroundTransparency = 1,
                        Image = "rbxassetid://10734898355",
                        Size = UDim2.fromOffset(24, 24),
                        Position = UDim2.fromScale(0.5, 0.5),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        ImageColor3 = pebble.theme.fg_on_bg_high[3]
                    })
                })
            }),
            create("Frame")({
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundTransparency = 1,

                Visible = function() -- Line: 242, Name: Visible
                    -- upvalues: u2 (copy)
                    local v13 = not u2.ok() and #u2.msg() > 0;

                    return v13;
                end,

                pebble.typography({
                    text = u2.msg
                })
            }),
            create("Frame")({
                Size = UDim2.new(1, 0, 0, 32),
                BackgroundColor3 = pebble.theme.bg[2],
                AutomaticSize = Enum.AutomaticSize.Y,
                create("UICorner")({
                    CornerRadius = UDim.new(0, 8)
                }),
                create("UIListLayout")({
                    Wraps = true,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 8),
                    HorizontalFlex = Enum.UIFlexAlignment.SpaceAround,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }),
                pebble.row({
                    spacing = UDim.new(0, 8),
                    alignitems = Enum.ItemLineAlignment.Center,
                    v10,
                    pebble.typography({
                        text = "Page:"
                    }),
                    pebble.textfield({
                        placeholder = "1",
                        size = UDim2.fromOffset(40, 26),

                        text = function() -- Line: 284, Name: text
                            -- upvalues: u3 (copy)
                            return u3();
                        end,

                        oninput = u3,

                        enter = function(p14) -- Line: 290, Name: enter
                            -- upvalues: u3 (copy), u5 (copy)
                            local v15 = tonumber(p14);

                            if v15 == nil then
                                u3((tostring(u5())));

                                return;
                            end;

                            u5(v15);
                        end
                    }),
                    pebble.typography({
                        text = function() -- Line: 302, Name: text
                            -- upvalues: u2 (copy), u6 (copy)
                            local v16 = u2.total_entities() / u6();

                            return `/ {math.ceil(v16)}`;
                        end
                    })
                }),
                pebble.row({
                    spacing = UDim.new(0, 8),
                    alignitems = Enum.ItemLineAlignment.Center,
                    v10,
                    pebble.typography({
                        text = "Rows:"
                    }),
                    pebble.textfield({
                        placeholder = "Rows",
                        size = UDim2.fromOffset(40, 26),

                        text = function() -- Line: 322, Name: text
                            -- upvalues: u4 (copy)
                            return u4();
                        end,

                        oninput = u4,

                        enter = function(p17) -- Line: 328, Name: enter
                            -- upvalues: u4 (copy), u6 (copy)
                            local v18 = tonumber(p17);

                            if v18 == nil then
                                u4((tostring(u6())));

                                return;
                            end;

                            u6(v18);
                        end
                    })
                }),
                pebble.row({
                    spacing = UDim.new(0, 4),
                    v10,
                    pebble.button({
                        size = UDim2.fromOffset(26, 26),
                        text = "",

                        accent = function() -- Line: 348, Name: accent
                            -- upvalues: u2 (copy)
                            return not u2.paused();
                        end,

                        activated = function() -- Line: 352, Name: activated
                            -- upvalues: u2 (copy)
                            u2.paused(not u2.paused());
                        end,

                        {
                            LayoutOrder = 10
                        },
                        create("ImageLabel")({
                            BackgroundTransparency = 1,
                            Size = UDim2.fromOffset(24, 24),
                            Position = UDim2.fromScale(0.5, 0.5),
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            ImageColor3 = pebble.theme.fg_on_bg_high[3],

                            Image = function() -- Line: 367, Name: Image
                                -- upvalues: u2 (copy)
                                return u2.paused() and "rbxassetid://10735024209" or "rbxassetid://10734923214";
                            end
                        })
                    }),
                    show(u2.paused, function() -- Line: 375
                        -- upvalues: pebble (ref), u2 (copy), create (ref)
                        return pebble.button({
                            size = UDim2.fromOffset(26, 26),
                            text = "",

                            activated = function() -- Line: 380, Name: activated
                                -- upvalues: u2 (ref)
                                u2.refresh(true);
                            end,

                            create("ImageLabel")({
                                BackgroundTransparency = 1,
                                Image = "rbxassetid://10734933222",
                                Size = UDim2.fromOffset(24, 24),
                                Position = UDim2.fromScale(0.5, 0.5),
                                AnchorPoint = Vector2.new(0.5, 0.5),
                                ImageColor3 = pebble.theme.fg_on_bg_high[3]
                            })
                        });
                    end)
                })
            }),
            pebble.background({
                size = UDim2.fromScale(1, 0),
                automaticsize = Enum.AutomaticSize.Y,
                create("UICorner")({
                    CornerRadius = UDim.new(0, 8)
                }),
                create("UIFlexItem")({
                    FlexMode = Enum.UIFlexMode.Fill
                }),
                pebble.tablesheet({
                    size = UDim2.fromScale(1, 1),
                    suggested_column_sizes = { 0.1 },

                    column_sizes = function() -- Line: 419, Name: column_sizes
                        -- upvalues: u2 (copy)
                        local v19 = {};

                        for i in u2.columns() do
                            v19[i] = 200;
                        end;

                        v19[1] = 50;

                        return v19;
                    end,

                    columns = u2.columns,

                    read_value = function(p20, p21) -- Line: 429, Name: read_value
                        -- upvalues: u2 (copy)
                        local v22 = u2.columns()[p20];

                        return v22 and (v22[p21] or "") or "";
                    end,

                    on_click = function(p23, p24) -- Line: 435, Name: on_click
                        -- upvalues: u2 (copy), spawn_app (ref), entity (ref)
                        if not u2.columns()[1][p24 - 1] then
                            return;
                        end;

                        spawn_app.spawn_app(entity, {
                            host = u2.host,
                            vm = u2.vm,
                            id = u2.id,
                            entity = u2.columns()[1][p24 - 1]
                        });
                    end,

                    on_click2 = function() -- Line: 444, Name: on_click2
                    end,

                    below = {
                        pebble.padding({
                            x = UDim.new(0, 4),
                            y = UDim.new(0, 2)
                        }),
                        create("UIListLayout")({
                            FillDirection = Enum.FillDirection.Horizontal,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 8)
                        }),
                        pebble.button({
                            text = "Previous",
                            size = UDim2.fromOffset(70, 26),

                            activated = function() -- Line: 463, Name: activated
                                -- upvalues: u5 (copy)
                                u5(u5() - 1);
                            end,

                            disabled = function() -- Line: 467, Name: disabled
                                -- upvalues: u5 (copy), u2 (copy)
                                return u5() == 1 and true or u2.ok() == false;
                            end
                        }),
                        pebble.button({
                            text = "Next",
                            size = UDim2.fromOffset(70, 26),

                            activated = function() -- Line: 476, Name: activated
                                -- upvalues: u5 (copy)
                                u5(u5() + 1);
                            end,

                            disabled = function() -- Line: 480, Name: disabled
                                -- upvalues: u2 (copy), u6 (copy), u5 (copy)
                                local v25 = u2.total_entities() / u6();
                                local math_ceil_ret = math.ceil(v25);

                                return math.max(1, math_ceil_ret) == u5() and true or u2.ok() == false;
                            end
                        }),
                        (pebble.typography({
                            position = UDim2.new(0, 4, 0.5, 0),
                            anchorpoint = Vector2.new(0, 0.5),

                            text = function() -- Line: 490, Name: text
                                -- upvalues: u2 (copy)
                                return `total entities: {u2.total_entities()}\tfrom: {u2.from()}\tuntil: {u2.upto()}`;
                            end
                        }))
                    }
                })
            })
        })
    });
end;