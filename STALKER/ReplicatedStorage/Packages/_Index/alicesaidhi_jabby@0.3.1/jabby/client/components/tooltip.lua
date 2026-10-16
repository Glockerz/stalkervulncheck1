-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local pebble = require(script.Parent.Parent.Parent.Parent.pebble);
local vide = require(script.Parent.Parent.Parent.Parent.vide);
local create = vide.create;
local source = vide.source;
local cleanup = vide.cleanup;

return function(p1: table) -- Line: 17
    -- upvalues: source (copy), cleanup (copy), RunService (copy), UserInputService (copy), create (copy), pebble (copy)
    local u2 = source(Vector2.zero);
    cleanup(RunService.PreRender:Connect(function() -- Line: 21
        -- upvalues: u2 (copy), UserInputService (ref)
        u2(UserInputService:GetMouseLocation());
    end));

    return create("ScreenGui")({
        Name = "Mouse Hover",
        IgnoreGuiInset = true,
        DisplayOrder = 1000000000,
        Enabled = p1.visible,
        create("Frame")({
            Position = function() -- Line: 32, Name: Position
                -- upvalues: u2 (copy)
                return UDim2.fromOffset(u2().X + 24, u2().Y + 24);
            end,

            Size = UDim2.fromOffset(400, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundColor3 = pebble.theme.bg[0],
            BackgroundTransparency = p1.transparency or 0.5,
            pebble.padding({}),
            create("UICorner")({
                CornerRadius = UDim.new(0, 8)
            }),
            create("UIStroke")({
                Thickness = 2,
                Transparency = 0.8,
                Color = pebble.theme.bg[-10]
            }),
            unpack(p1)
        })
    });
end;