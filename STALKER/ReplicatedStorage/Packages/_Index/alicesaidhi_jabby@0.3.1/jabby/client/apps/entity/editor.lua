-- Decompiled with Potassium's decompiler.

local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble);
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide);
local create = vide.create;
local show = vide.show;

return function(u1: table) -- Line: 14
    -- upvalues: create (copy), show (copy), pebble (copy)
    local editing = u1.editing;
    local text = u1.text;
    local changes = u1.changes;

    return create("Folder")({
        Name = "Text Editor",
        show(function() -- Line: 23
            -- upvalues: editing (copy)
            return editing();
        end, function() -- Line: 25
            -- upvalues: create (ref), pebble (ref), editing (copy), text (copy), changes (copy), u1 (copy)
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
                    VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly,
                    Padding = UDim.new(0, 8)
                }),
                pebble.padding({
                    padding = UDim.new(0, 32)
                }),
                pebble.typography({
                    text = function() -- Line: 49, Name: text
                        -- upvalues: editing (ref)
                        return `Editing {editing()}`;
                    end
                }),
                create("Frame")({
                    Size = UDim2.fromScale(1, 0),
                    create("UIFlexItem")({
                        FlexMode = Enum.UIFlexMode.Fill
                    }),
                    BackgroundTransparency = 1,
                    pebble.textfield({
                        multiline = true,
                        code = true,
                        size = UDim2.fromScale(1, 1),
                        position = UDim2.fromScale(0.5, 0.5),
                        anchorpoint = Vector2.new(0.5, 0.5),
                        text = text,
                        oninput = text
                    })
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
                        text = "Save Changes",
                        accent = true,
                        size = UDim2.fromOffset(150, 30),

                        activated = function() -- Line: 90, Name: activated
                            -- upvalues: editing (ref), changes (ref), text (ref), u1 (ref)
                            local v2 = editing();
                            changes()[v2] = text();
                            editing(false);
                            changes(changes());

                            if u1.components()[v2] ~= nil then
                                return;
                            end;

                            u1.components()[v2] = text();
                        end
                    }),
                    pebble.button({
                        text = "Cancel Changes",
                        size = UDim2.fromOffset(150, 30),

                        activated = function() -- Line: 106, Name: activated
                            -- upvalues: editing (ref)
                            editing(false);
                        end
                    })
                })
            });
        end)
    });
end;