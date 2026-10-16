-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local container = require(script.Parent.container);
local create = vide.create;
local read = vide.read;

return function(u1: table) -- Line: 33, Name: rounded_frame
    -- upvalues: create (copy), read (copy), container (copy)
    local u2 = u1.topleft or UDim.new();
    local u3 = u1.topright or UDim.new();
    local u4 = u1.bottomleft or UDim.new();
    local u5 = u1.bottomright or UDim.new();

    local function corner(p6: string, p7, p8, u9: any) -- Line: 39
        -- upvalues: create (ref), read (ref), u1 (copy)
        return create("Frame")({
            Name = p6,
            AutoLocalize = false,

            Size = function() -- Line: 44, Name: Size
                -- upvalues: read (ref), u9 (copy)
                return UDim2.new(read(u9), read(u9));
            end,

            Position = p7,
            AnchorPoint = p8,
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            create("Frame")({
                Name = "TopLeft",
                AutoLocalize = false,
                Size = UDim2.fromScale(2, 2),
                Position = UDim2.fromScale(-p8.X, -p8.Y),
                BackgroundColor3 = u1.color,
                ClipsDescendants = true,
                create("UICorner")({
                    CornerRadius = u9
                })
            })
        });
    end;

    return create("Frame")({
        Name = u1.name or "RoundedFrame",
        Size = u1.size,
        Position = u1.position,
        AnchorPoint = u1.anchor_point,
        BackgroundColor3 = u1.color,
        BackgroundTransparency = 1,
        create("Folder")({
            Name = "Corner",
            corner("TopLeft", UDim2.fromScale(0, 0), Vector2.new(0, 0), u2),
            corner("TopRight", UDim2.fromScale(1, 0), Vector2.new(1, 0), u3),
            corner("BottomLeft", UDim2.fromScale(0, 1), Vector2.new(0, 1), u4),
            corner("BottomRight", UDim2.fromScale(1, 1), Vector2.new(1, 1), u5),
            create("Frame")({
                AutoLocalize = false,
                Name = "FrameLeft",

                Size = function() -- Line: 95, Name: Size
                    -- upvalues: read (ref), u2 (copy), u4 (copy)
                    return UDim2.new(0.5, 0, 1 - read(u2).Scale - read(u4).Scale, -(read(u2).Offset + read(u4).Offset));
                end,

                Position = function() -- Line: 103, Name: Position
                    -- upvalues: read (ref), u2 (copy), u4 (copy)
                    return UDim2.new(0, 0, 0.5 + read(u2).Scale / 2 - read(u4).Scale / 2, 0 + read(u2).Offset / 2 - read(u4).Offset / 2);
                end,

                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = u1.color
            }),
            create("Frame")({
                Name = "FrameRight",
                AutoLocalize = false,

                Size = function() -- Line: 120, Name: Size
                    -- upvalues: read (ref), u3 (copy), u5 (copy)
                    return UDim2.new(0.5, 0, 1 - read(u3).Scale - read(u5).Scale, -(read(u3).Offset + read(u5).Offset));
                end,

                Position = function() -- Line: 128, Name: Position
                    -- upvalues: read (ref), u3 (copy), u5 (copy)
                    return UDim2.new(1, 0, 0.5 + read(u3).Scale / 2 - read(u5).Scale / 2, 0 + read(u3).Offset / 2 - read(u5).Offset / 2);
                end,

                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundColor3 = u1.color
            }),
            create("Frame")({
                Name = "FrameTop",
                AutoLocalize = false,

                Size = function() -- Line: 145, Name: Size
                    -- upvalues: read (ref), u2 (copy), u3 (copy)
                    return UDim2.new(1 - read(u2).Scale - read(u3).Scale, -(read(u2).Offset + read(u3).Offset), 0.5, 0);
                end,

                Position = function() -- Line: 153, Name: Position
                    -- upvalues: read (ref), u2 (copy), u3 (copy)
                    return UDim2.new(0.5 + read(u2).Scale / 2 - read(u3).Scale / 2, 0 + read(u2).Offset / 2 - read(u3).Offset / 2, 0, 0);
                end,

                AnchorPoint = Vector2.new(0.5, 0),
                BackgroundColor3 = u1.color
            }),
            create("Frame")({
                Name = "FrameBottom",
                AutoLocalize = false,

                Size = function() -- Line: 170, Name: Size
                    -- upvalues: read (ref), u4 (copy), u5 (copy)
                    return UDim2.new(1 - read(u4).Scale - read(u5).Scale, -(read(u4).Offset + read(u5).Offset), 0.5, 0);
                end,

                Position = function() -- Line: 178, Name: Position
                    -- upvalues: read (ref), u4 (copy), u5 (copy)
                    return UDim2.new(0.5 + read(u4).Scale / 2 - read(u5).Scale / 2, 0 + read(u4).Offset / 2 - read(u5).Offset / 2, 1, 0);
                end,

                AnchorPoint = Vector2.new(0.5, 1),
                BackgroundColor3 = u1.color
            })
        }),
        container({ unpack(u1) }),
        u1.layout
    });
end;