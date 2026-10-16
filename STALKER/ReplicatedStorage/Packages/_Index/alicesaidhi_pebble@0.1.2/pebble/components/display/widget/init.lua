-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local container = require(script.Parent.Parent.util.container);
local padding = require(script.Parent.Parent.util.padding);
local shadow = require(script.Parent.Parent.util.shadow);
local divider = require(script.Parent.divider);
local snapping = require(script.Parent.snapping);
local script_borders = require(script.borders);
local script_topbar = require(script.topbar);
local create = vide.create;
local source = vide.source;
local cleanup = vide.cleanup;
local changed = vide.changed;
local action = vide.action;
local _ = vide.spring;
local u1 = 100000;
local u2 = nil;
vide.mount(function() -- Line: 43
    -- upvalues: u2 (ref), snapping (copy), create (copy)
    u2 = snapping();

    return create("ScreenGui")({
        Name = "docks",
        AutoLocalize = false,
        create("Frame")({
            Size = UDim2.new(0, 16, 1, 0),
            BackgroundTransparency = 1,
            AutoLocalize = false,
            u2.snap_area({})
        })
    });
end, Players.LocalPlayer.PlayerGui);

return function(p3: table) -- Line: 79
    -- upvalues: source (copy), u1 (ref), cleanup (copy), UserInputService (copy), GuiService (copy), Players (copy), RunService (copy), create (copy), action (copy), theme (copy), changed (copy), shadow (copy), script_borders (copy), container (copy), script_topbar (copy), divider (copy), padding (copy), u2 (ref)
    local u4 = Vector2.new(100, 100):Max(p3.min_size or Vector2.zero);
    local u5 = p3.position or Vector2.new(32, 32);
    local v6 = p3.size or u4 * 1.5;
    local u7 = source((math.max(u4.X, v6.X)));
    local u8 = source((math.max(u4.Y, v6.Y)));
    local u9 = source(u5.X);
    local u10 = source(u5.Y);
    local u11 = source(Vector2.zero);
    local u12 = source(false);
    local u13 = source(Vector2.zero);
    local u14 = source(Vector2.zero);
    local u15 = source(false);
    local u16 = source(false);
    local u17 = source(false);
    local u18 = source(false);
    local u19 = source(false);
    local u20 = source();
    local u21 = source(u1 + 1);
    u1 = u1 + 1;
    local u22 = source(false);
    local u23 = nil;
    local u24 = nil;
    cleanup(UserInputService.InputEnded:Connect(function(p25) -- Line: 108
        -- upvalues: u19 (copy), u12 (copy)
        if p25.UserInputType ~= Enum.UserInputType.MouseButton1 and p25.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        u19(false);
        u12(false);
    end));
    cleanup(UserInputService.InputChanged:Connect(function(p26: userdata) -- Line: 119
        -- upvalues: u19 (copy), UserInputService (ref), GuiService (ref), u16 (copy), u8 (copy), u23 (ref), u4 (copy), u17 (copy), u7 (copy), u15 (copy), u24 (ref), u10 (copy), u18 (copy), u9 (copy)
        if p26.UserInputType ~= Enum.UserInputType.MouseMovement then
            return;
        end;

        if not u19() then
            return;
        end;

        local MouseLocation = UserInputService:GetMouseLocation();
        local GuiInset, v27 = GuiService:GetGuiInset();
        local v28 = MouseLocation + (-GuiInset - v27);
        local X = v28.X;
        local Y = v28.Y;

        if u16() then
            u8((math.max(Y - u23.Y, u4.Y)));
        end;

        if u17() then
            u7((math.max(X - u23.X, u4.X)));
        end;

        if u15() then
            u8((math.max(u24.Y - Y, u4.Y)));
            u10((math.min(Y, u24.Y - u4.Y)));
        end;

        if u18() then
            u7((math.max(u24.X - X, u4.X)));
            u9((math.min(X, u24.X - u4.X)));
        end;
    end));
    cleanup(UserInputService.InputBegan:Connect(function(p29) -- Line: 140
        -- upvalues: u12 (copy), u19 (copy), u23 (ref), u13 (copy), u24 (ref), u14 (copy), Players (ref), RunService (ref), u20 (copy), u21 (copy), u1 (ref)
        if p29.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return;
        end;

        if not u12() then
            u19(true);
        end;

        u23 = u13();
        u24 = u13() + u14();
        local v30;

        if Players.LocalPlayer and RunService:IsRunning() then
            v30 = Players.LocalPlayer:WaitForChild("PlayerGui");
        else
            if not (RunService:IsStudio() and RunService:IsRunning()) then
                return;
            end;

            v30 = game:GetService("CoreGui");
        end;

        local GuiObjectsAtPosition = v30:GetGuiObjectsAtPosition(p29.Position.X, p29.Position.Y);

        if #GuiObjectsAtPosition == 0 then
            return;
        end;

        if not GuiObjectsAtPosition[1]:IsDescendantOf(u20()) then
            return;
        end;

        u21(u1 + 1);
        u1 = u1 + 1;
    end));
    cleanup(UserInputService.InputChanged:Connect(function(p31: userdata) -- Line: 164
        -- upvalues: u12 (copy), UserInputService (ref), u9 (copy), u11 (copy), u10 (copy)
        if u12() == false then
            return;
        end;

        if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            u12(false);

            return;
        end;

        local MouseLocation = UserInputService:GetMouseLocation();
        u9(MouseLocation.X + u11().X);
        u10(MouseLocation.Y + u11().Y);
    end));
    local u32 = source(false);
    local u33 = source(UDim2.new());
    local u34 = source(UDim2.new());

    local function radius() -- Line: 182
        -- upvalues: u32 (copy)
        if u32() then
            return UDim.new();
        end;

        return UDim.new(0, 6);
    end;

    return create("ScreenGui")({
        Name = p3.title,
        AutoLocalize = false,
        DisplayOrder = u21,
        action(u20),
        create("Frame")({
            AutoLocalize = false,

            Position = function() -- Line: 194, Name: Position
                -- upvalues: u32 (copy), u34 (copy), u9 (copy), u10 (copy)
                if u32() then
                    return u34();
                end;

                return UDim2.fromOffset(u9(), u10());
            end,

            Size = function() -- Line: 198, Name: Size
                -- upvalues: u32 (copy), u7 (copy), u33 (copy), u8 (copy)
                if u32() then
                    return UDim2.fromOffset(u7() + 6, u33().Y.Offset);
                end;

                return UDim2.fromOffset(u7() + 6, u8() + 6);
            end,

            Active = true,
            BackgroundColor3 = theme.bg[0],

            MouseMoved = function() -- Line: 206, Name: MouseMoved
                -- upvalues: u19 (copy), UserInputService (ref), GuiService (ref), u5 (ref), u13 (copy), u15 (copy), u18 (copy), u16 (copy), u14 (copy), u17 (copy)
                if u19() then
                    return;
                end;

                local MouseLocation = UserInputService:GetMouseLocation();
                local GuiInset, v35 = GuiService:GetGuiInset();
                u5 = u5 + (-GuiInset - v35);
                local Y = MouseLocation.Y;
                local v36 = MouseLocation.X - u13().X;
                local v37 = Y - u13().Y;
                u15(v37 < 6);
                u18(v36 < 6);
                u16(u14().Y - 6 < v37);
                u17(u14().X - 6 < v36);
            end,

            MouseEnter = function() -- Line: 222, Name: MouseEnter
                -- upvalues: u22 (copy)
                u22(true);
            end,

            MouseLeave = function() -- Line: 226, Name: MouseLeave
                -- upvalues: u19 (copy), RunService (ref), u22 (copy)
                if u19() then
                    return;
                end;

                if RunService:IsRunning() == false then
                    return;
                end;

                u22(false);
            end,

            changed("AbsolutePosition", u13),
            changed("AbsoluteSize", u14),
            create("UICorner")({
                CornerRadius = radius
            }),
            shadow({}),
            script_borders({
                resize_range = 6,
                min_size = u4,
                can_resize_top = u15,
                can_resize_bottom = u16,
                can_resize_left = u18,
                can_resize_right = u17,
                resizing = u19
            }),
            container({
                Size = UDim2.fromScale(1, 1),
                create("UIListLayout")({}),
                script_topbar({
                    title = p3.title,
                    subtitle = p3.subtitle,
                    dragging = u12,
                    offset = u11,
                    bind_to_close = p3.bind_to_close,
                    radius = radius
                }),
                divider({}),
                container({
                    Size = UDim2.fromScale(1, 0),
                    padding({
                        x = UDim.new(0, 8),
                        y = UDim.new(0, 8)
                    }),
                    unpack(p3),
                    create("UIFlexItem")({
                        FlexMode = Enum.UIFlexMode.Grow
                    })
                })
            }),
            u2.snappable({
                dragging = u12,
                snapped = u32,
                position = u34,
                size = u33
            })
        })
    });
end;