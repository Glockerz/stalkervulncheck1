-- Decompiled with Potassium's decompiler.

local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble);
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide);
local query_parser = require(script.Parent.Parent.Parent.Parent.server.query_parser);
local create = vide.create;
local source = vide.source;
local show = vide.show;

return function(p1: table) -- Line: 16
    -- upvalues: source (copy), create (copy), show (copy), pebble (copy), query_parser (copy)
    local u2 = source("");
    local adding = p1.adding;
    local editing = p1.editing;
    local _ = p1.text;

    return create("Folder")({
        Name = "Add Component",
        show(adding, function() -- Line: 26
            -- upvalues: create (ref), pebble (ref), u2 (copy), adding (copy), editing (copy), query_parser (ref)
            return create("Frame")({
                ZIndex = 1000,
                Size = UDim2.new(1, 16, 1, 16),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.new(0, 0, 0),
                BackgroundTransparency = 0.5,
                Active = true,
                create("UIListLayout")({
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 8)
                }),
                pebble.padding({
                    padding = UDim.new(0, 32)
                }),
                pebble.textfield({
                    placeholder = "Entity",
                    size = UDim2.fromOffset(200, 30),
                    oninput = u2
                }),
                create("Frame")({
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    create("UIListLayout")({
                        HorizontalFlex = Enum.UIFlexAlignment.Fill,
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, 8)
                    }),
                    pebble.button({
                        text = "Edit",
                        accent = true,
                        size = UDim2.fromOffset(150, 30),

                        activated = function() -- Line: 70, Name: activated
                            -- upvalues: adding (ref), editing (ref), u2 (ref)
                            adding(false);
                            editing(u2());
                        end,

                        disabled = function() -- Line: 74, Name: disabled
                            -- upvalues: query_parser (ref), u2 (ref)
                            local success, result = pcall(query_parser, u2());

                            if not success then
                                return true;
                            end;

                            if not result[1] then
                                return true;
                            end;

                            if result[2] then
                                return true;
                            end;

                            local v3 = result[1];

                            if v3.type == "Relationship" then
                                if v3.left.type == "Wildcard" then
                                    return true;
                                end;

                                if v3.right.type == "Wildcard" then
                                    return true;
                                end;
                            end;

                            return false;
                        end
                    }),
                    pebble.button({
                        text = "Cancel",
                        size = UDim2.fromOffset(150, 30),

                        activated = function() -- Line: 94, Name: activated
                            -- upvalues: adding (ref)
                            adding(false);
                        end
                    })
                })
            });
        end)
    });
end;