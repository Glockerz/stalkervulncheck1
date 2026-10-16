-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble);
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide);
local spawn_app = require(script.Parent.Parent.Parent.spawn_app);
local overview_scheduler = require(script.Parent.Parent.overview_scheduler);
local registry = require(script.Parent.Parent.registry);
local create = vide.create;
local derive = vide.derive;
local source = vide.source;
local values = vide.values;
local show = vide.show;

return function(u1: table) -- Line: 35
    -- upvalues: source (copy), Players (copy), derive (copy), pebble (copy), create (copy), show (copy), values (copy), spawn_app (copy), registry (copy), overview_scheduler (copy)
    local u2 = source(Players.LocalPlayer);
    local u4 = derive(function() -- Line: 39
        -- upvalues: u1 (copy)
        local v3 = {};

        for _, v in u1.servers() do
            local host = v.host;
            v3[host] = v3[host] or {};
            table.insert(v3[host], v);
        end;

        v3.all = u1.servers();

        return v3;
    end);
    local v7 = derive(function() -- Line: 53
        -- upvalues: u4 (copy), Players (ref)
        local v5 = {};

        for i, _ in u4() do
            local v6;

            if type(i) == "string" then
                v6 = i;
            else
                v6 = `@{i.Name}`;
            end;

            v5[i] = v6;
        end;

        v5[Players.LocalPlayer] = "localplayer";
        v5.all = "all";

        return v5;
    end);

    return pebble.widget({
        title = "Home",
        min_size = Vector2.new(230, 200),
        bind_to_close = u1.destroy,
        pebble.container({ create("UIListLayout")({
                Padding = UDim.new(0, 2),
                VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly,
                HorizontalFlex = Enum.UIFlexAlignment.Fill
            }), pebble.select({
                size = UDim2.new(1, 0, 0, 32),
                options = v7,
                selected = u2,
                update_selected = u2
            }), create("ScrollingFrame")({
                CanvasSize = UDim2.new(),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                ScrollBarThickness = 6,
                HorizontalScrollBarInset = Enum.ScrollBarInset.Always,
                create("UIFlexItem")({
                    FlexMode = Enum.UIFlexMode.Fill
                }),
                pebble.padding({
                    x = UDim.new(0, 1),
                    right = UDim.new(0, 8)
                }),
                create("UIListLayout")({
                    Wraps = true,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDim.new(0, 8)
                }),
                show(function() -- Line: 70, Name: is_empty
                    -- upvalues: u4 (copy), u2 (copy)
                    return next(u4()[u2()] or {}) == nil and "No objects found. You may not have permissions to use this." or false;
                end, function() -- Line: 124
                    -- upvalues: pebble (ref), u4 (copy), u2 (copy)
                    return pebble.typography({
                        wrapped = true,
                        text = next(u4()[u2()] or {}) == nil and "No objects found. You may not have permissions to use this." or false,
                        xalignment = Enum.TextXAlignment.Left
                    });
                end),
                values(function() -- Line: 66, Name: objects
                    -- upvalues: u4 (copy), u2 (copy)
                    return u4()[u2()] or {};
                end, function(u8, p9) -- Line: 132
                    -- upvalues: pebble (ref), create (ref), values (ref), spawn_app (ref), registry (ref), overview_scheduler (ref)
                    return pebble.pane({
                        name = "",
                        size = UDim2.fromOffset(200, 0),
                        automaticsize = Enum.AutomaticSize.Y,
                        create("UIListLayout")({
                            Padding = UDim.new(0, 8)
                        }),
                        pebble.typography({
                            wrapped = true,
                            text = `host: {u8.host}\tvm id: {u8.vm}`
                        }),
                        values(u8.worlds, function(u10) -- Line: 148
                            -- upvalues: pebble (ref), spawn_app (ref), registry (ref), u8 (copy)
                            return pebble.button({
                                size = UDim2.new(1, 0, 0, 30),
                                text = `World: {u10.name}`,

                                activated = function() -- Line: 153, Name: activated
                                    -- upvalues: spawn_app (ref), registry (ref), u8 (ref), u10 (copy)
                                    spawn_app.spawn_app(registry, {
                                        host = u8.host,
                                        vm = u8.vm,
                                        id = u10.id
                                    });
                                end
                            });
                        end),
                        values(u8.schedulers, function(u11) -- Line: 163
                            -- upvalues: pebble (ref), spawn_app (ref), overview_scheduler (ref), u8 (copy)
                            return pebble.button({
                                size = UDim2.new(1, 0, 0, 30),
                                text = `Scheduler: {u11.name}`,

                                activated = function() -- Line: 168, Name: activated
                                    -- upvalues: spawn_app (ref), overview_scheduler (ref), u8 (ref), u11 (copy)
                                    spawn_app.spawn_app(overview_scheduler, {
                                        host = u8.host,
                                        vm = u8.vm,
                                        id = u11.id
                                    });
                                end
                            });
                        end)
                    });
                end)
            }) })
    });
end;