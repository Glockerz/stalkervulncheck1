-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
require(script.Parent.Parent.Parent.util.anim);
local theme = require(script.Parent.Parent.Parent.util.theme);
require(script.Parent.Parent.interactable.button);
local container = require(script.Parent.Parent.util.container);
local list = require(script.Parent.Parent.util.list);
local padding = require(script.Parent.Parent.util.padding);
local rounded_frame = require(script.Parent.Parent.util.rounded_frame);
local divider = require(script.Parent.divider);
local typography = require(script.Parent.typography);
local create = vide.create;
local source = vide.source;
local changed = vide.changed;
local indexes = vide.indexes;
local untrack = vide.untrack;
local _ = vide.cleanup;

return function(u1: table) -- Line: 29
    -- upvalues: source (copy), list (copy), create (copy), theme (copy), divider (copy), container (copy), indexes (copy), rounded_frame (copy), typography (copy), padding (copy), changed (copy), untrack (copy)
    local u2 = source(1);

    return list({
        justifycontent = Enum.UIFlexAlignment.Fill,
        spacing = UDim.new(),
        create("Frame")({
            Size = UDim2.new(1, 0, 0, 32),
            AutoLocalize = false,
            BackgroundColor3 = theme.bg[3],
            divider({
                position = UDim2.fromScale(0, 1)
            }),
            container({ create("UIListLayout")({
                    FillDirection = Enum.FillDirection.Horizontal
                }), indexes(u1.labels, function(u3, u4) -- Line: 51
                    -- upvalues: source (ref), rounded_frame (ref), u2 (copy), theme (ref), create (ref), typography (ref), padding (ref), changed (ref)
                    local u5 = source(Enum.GuiState.Idle);

                    return rounded_frame({
                        name = u4,
                        size = UDim2.fromOffset(50, 30),
                        automaticsize = Enum.AutomaticSize.X,
                        topleft = UDim.new(0, 4),
                        topright = UDim.new(0, 4),

                        color = function() -- Line: 61, Name: color
                            -- upvalues: u2 (ref), u4 (copy), theme (ref), u5 (copy)
                            if u2() == u4 then
                                return theme.bg[0]();
                            end;

                            if u5() == Enum.GuiState.Idle then
                                return theme.bg[3]();
                            end;

                            return theme.bg[1]();
                        end,

                        create("TextButton")({
                            Size = UDim2.fromScale(1, 1),
                            AutoLocalize = false,
                            BackgroundTransparency = 1,

                            Activated = function() -- Line: 72, Name: Activated
                                -- upvalues: u2 (ref), u4 (copy)
                                u2(u4);
                            end,

                            typography({
                                textsize = 16,
                                position = UDim2.fromScale(0.5, 0.5),
                                anchorpoint = Vector2.new(0.5, 0.5),

                                text = function() -- Line: 81, Name: text
                                    -- upvalues: u3 (copy)
                                    return u3().title;
                                end
                            }),
                            padding({
                                x = UDim.new(0, 24),
                                y = UDim.new(0, 2)
                            }),
                            changed("GuiState", u5)
                        })
                    });
                end) }),
            ZIndex = 100
        }),
        create("Frame")({
            Size = UDim2.new(1, 0, 1, 0),
            AutoLocalize = false,
            BackgroundColor3 = theme.bg[0],

            function() -- Line: 110
                -- upvalues: untrack (ref), u1 (copy), u2 (copy)
                return untrack(u1.labels()[u2()].ui);
            end
        })
    });
end;