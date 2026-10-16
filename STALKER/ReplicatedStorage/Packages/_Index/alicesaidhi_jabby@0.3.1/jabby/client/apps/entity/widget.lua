-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble);
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide);
local remotes = require(script.Parent.Parent.Parent.Parent.modules.remotes);
local add_component = require(script.Parent.add_component);
local editor = require(script.Parent.editor);
local create = vide.create;
local indexes = vide.indexes;
local source = vide.source;
local show = vide.show;
local u1 = source(Vector2.zero);
RunService.PreRender:Connect(function() -- Line: 35
    -- upvalues: u1 (copy), UserInputService (copy)
    u1(UserInputService:GetMouseLocation());
end);

return function(u2: table) -- Line: 39
    -- upvalues: source (copy), remotes (copy), vide (copy), pebble (copy), create (copy), editor (copy), add_component (copy), indexes (copy), show (copy)
    local u3 = {
        host = u2.host,
        to_vm = u2.vm
    };
    local live_updates = u2.live_updates;
    local changes = u2.changes;
    local u4 = source("");
    local u5 = source(false);
    local u6 = source(false);

    local function is_removed(p7: string) -- Line: 74
        return p7 == "nil";
    end;

    local function edit_component(p8: string) -- Line: 78
        -- upvalues: remotes (ref), u3 (copy), u2 (copy), u6 (copy), u4 (copy)
        remotes.get_component:fire(u3, u2.inspect_id, p8);
        u6(p8);
        u4("waiting...");
    end;

    vide.cleanup(remotes.return_component:connect(function(p9, p10, p11, p12) -- Line: 85
        -- upvalues: u2 (copy), u4 (copy)
        if u2.host ~= p9.host then
            return;
        end;

        if u2.inspect_id ~= p10 then
            return;
        end;

        local v13 = u2.changes()[p11];

        if v13 then
            u4(v13);

            return;
        end;

        u4(p12);
    end));

    return pebble.widget({
        title = `Entity #{u2.entity}`,
        subtitle = `host: {u2.host} vm: {u2.vm} id: {u2.id}`,
        min_size = Vector2.new(300, 300),
        bind_to_close = u2.destroy,
        create("Frame")({
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            create("UIListLayout")({
                VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly,
                Padding = UDim.new(0, 8)
            }),
            editor({
                components = u2.components,
                editing = u6,
                text = u4,
                changes = changes
            }),
            add_component({
                editing = edit_component,
                text = u4,
                changes = changes,
                adding = u5
            }),
            pebble.row({
                justifycontent = Enum.UIFlexAlignment.Fill,
                pebble.button({
                    text = "Live Updates",

                    activated = function() -- Line: 136, Name: activated
                        -- upvalues: live_updates (copy)
                        live_updates(not live_updates());
                    end,

                    create("UIListLayout")({
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
                        Padding = UDim.new(0, 4)
                    }),
                    pebble.checkbox({
                        size = UDim2.fromOffset(16, 16),
                        layoutorder = -1,
                        checked = live_updates,
                        create("UIFlexItem")({
                            FlexMode = Enum.UIFlexMode.None
                        })
                    })
                }),
                pebble.button({
                    size = UDim2.fromOffset(130, 30),

                    text = function() -- Line: 161, Name: text
                        -- upvalues: changes (copy)
                        local v14 = 0;

                        for _, _ in changes() do
                            v14 = v14 + 1;
                        end;

                        return `Apply {v14} Edits`;
                    end,

                    disabled = function() -- Line: 170, Name: disabled
                        -- upvalues: changes (copy)
                        return next(changes()) == nil;
                    end,

                    activated = function() -- Line: 173, Name: activated
                        -- upvalues: u2 (copy)
                        u2.apply_changes(true);
                    end
                }),
                pebble.button({
                    create("UIFlexItem")({
                        ItemLineAlignment = Enum.ItemLineAlignment.End
                    }),
                    size = UDim2.fromOffset(130, 30),
                    text = "Cancel changes",

                    disabled = function() -- Line: 185, Name: disabled
                        -- upvalues: changes (copy)
                        return next(changes()) == nil;
                    end,

                    activated = function() -- Line: 188, Name: activated
                        -- upvalues: changes (copy)
                        changes({});
                    end
                })
            }),
            create("ScrollingFrame")({
                Size = UDim2.fromScale(1, 0),
                CanvasSize = UDim2.new(),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = pebble.theme.bg[-1],
                ScrollBarThickness = 6,
                VerticalScrollBarInset = Enum.ScrollBarInset.Always,
                create("UIFlexItem")({
                    FlexMode = Enum.UIFlexMode.Fill
                }),
                create("UIListLayout")({
                    Padding = UDim.new(0, 4)
                }),
                pebble.typography({
                    text = "Components"
                }),
                pebble.container({
                    Size = UDim2.fromScale(1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    create("UIListLayout")({
                        SortOrder = Enum.SortOrder.Name
                    }),
                    indexes(function() -- Line: 52, Name: components
                        -- upvalues: u2 (copy)
                        local v15 = {};

                        for i, v in u2.components() do
                            if v ~= "tag" then
                                v15[i] = v;
                            end;
                        end;

                        return v15;
                    end, function(u16, u17) -- Line: 223
                        -- upvalues: pebble (ref), remotes (ref), u3 (copy), u2 (copy), u6 (copy), u4 (copy), create (ref), show (ref)
                        local button = pebble.button;
                        local v18 = {};
                        local v19 = {};
                        local v20;

                        if string.match(u17, "^%a") then
                            v20 = u17;
                        else
                            v20 = "zzzz" .. u17;
                        end;

                        v19.Name = v20;
                        v18[1] = v19;
                        v18.size = UDim2.new(1, 0, 0, 32);
                        v18.automaticsize = Enum.AutomaticSize.Y;
                        v18.text = "";
                        v18.corner = false;

                        function v18.activated() -- Line: 233
                            -- upvalues: u17 (copy), remotes (ref), u3 (ref), u2 (ref), u6 (ref), u4 (ref)
                            local v21 = u17;
                            remotes.get_component:fire(u3, u2.inspect_id, v21);
                            u6(v21);
                            u4("waiting...");
                        end;

                        v18[2], v18[3], v18[4], v18[5], v18[6], v18[7] = create("UIListLayout")({
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    Padding = UDim.new(0, 8)
}), pebble.padding({
    y = UDim.new(0, 4)
}), pebble.typography({
    code = true,
    wrapped = true,
    size = UDim2.new(0, 100, 0, 18),
    automaticsize = Enum.AutomaticSize.Y,
    text = u17,
    truncate = Enum.TextTruncate.SplitWord,
    xalignment = Enum.TextXAlignment.Left
}), pebble.typography({
    size = UDim2.fromOffset(0, 18),
    automaticsize = Enum.AutomaticSize.Y,
    yalignment = Enum.TextYAlignment.Top,
    xalignment = Enum.TextXAlignment.Left,
    text = u16,
    wrapped = true,
    truncate = Enum.TextTruncate.AtEnd,
    code = true,
    create("UIFlexItem")({
        FlexMode = Enum.UIFlexMode.Fill
    })
}), show(function() -- Line: 275
    -- upvalues: u2 (ref), u17 (copy)
    return u2.changes()[u17] ~= nil;
end, function() -- Line: 277
    -- upvalues: pebble (ref), u16 (copy), u2 (ref), u17 (copy)
    return pebble.typography({
        disabled = true,
        textsize = 14,

        text = function() -- Line: 279, Name: text
            -- upvalues: u16 (ref), u2 (ref), u17 (ref)
            local v22 = u16();
            local v23 = u2.changes()[u17];

            return v22 == nil and "(added)" or (v23 == "nil" and "(removed)" or "(changed)");
        end
    });
end), create("UISizeConstraint")({
    MaxSize = Vector2.new((1 / 0), 300)
});

                        return button(v18);
                    end)
                }),
                pebble.typography({
                    text = "Tags"
                }),
                pebble.container({
                    Size = UDim2.fromScale(1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    create("UIListLayout")({
                        SortOrder = Enum.SortOrder.Name
                    }),
                    indexes(function() -- Line: 63, Name: tags
                        -- upvalues: u2 (copy)
                        local v24 = {};

                        for i, v in u2.components() do
                            if v == "tag" then
                                v24[i] = v;
                            end;
                        end;

                        return v24;
                    end, function(u25, u26) -- Line: 309
                        -- upvalues: changes (copy), pebble (ref), u2 (copy), create (ref), show (ref)
                        local function did_change() -- Line: 310
                            -- upvalues: changes (ref), u26 (copy)
                            return changes()[u26] ~= nil;
                        end;

                        local button = pebble.button;
                        local v27 = {};
                        local v28 = {};
                        local v29;

                        if string.match(u26, "^%a") then
                            v29 = u26;
                        else
                            v29 = "zzzz" .. u26;
                        end;

                        v28.Name = v29;
                        v27[1] = v28;
                        v27.size = UDim2.new(1, 0, 0, 24);
                        v27.text = "";
                        v27.corner = false;

                        function v27.activated() -- Line: 322
                            -- upvalues: changes (ref), u26 (copy), u2 (ref)
                            if changes()[u26] ~= "tag" then
                                if changes()[u26] then
                                    changes()[u26] = nil;
                                    changes(changes());

                                    return;
                                end;

                                changes()[u26] = "nil";
                                changes(changes());

                                return;
                            end;

                            changes()[u26] = nil;
                            u2.components()[u26] = nil;
                            changes(changes());
                            u2.components(u2.components());
                        end;

                        v27[2], v27[3], v27[4], v27[5] = create("UIListLayout")({
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    Padding = UDim.new(0, 8)
}), pebble.padding({
    y = UDim.new(0, 4)
}), pebble.typography({
    size = UDim2.fromScale(0, 1),
    text = u26,
    code = true,
    wrapped = true,
    truncate = Enum.TextTruncate.SplitWord,
    xalignment = Enum.TextXAlignment.Left,
    create("UIFlexItem")({
        FlexMode = Enum.UIFlexMode.Fill
    })
}), show(did_change, function() -- Line: 367
    -- upvalues: pebble (ref), u25 (copy), changes (ref), u26 (copy)
    return pebble.typography({
        disabled = true,
        textsize = 14,

        text = function() -- Line: 369, Name: text
            -- upvalues: u25 (ref), changes (ref), u26 (ref)
            local v30 = u25();
            local v31 = changes()[u26];

            return v30 == nil and "(added)" or (v31 == "nil" and "(removed)" or "(changed)");
        end
    });
end);

                        return button(v27);
                    end)
                })
            }),
            pebble.row({
                justifycontent = Enum.UIFlexAlignment.Fill,
                pebble.button({
                    text = "Delete Id",
                    size = UDim2.fromOffset(100, 30),
                    activated = u2.delete
                }),
                pebble.button({
                    text = "Add Component",
                    size = UDim2.fromOffset(200, 30),

                    activated = function() -- Line: 402, Name: activated
                        -- upvalues: u5 (copy)
                        u5(true);
                    end
                })
            })
        })
    });
end;