-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.Parent.util.theme);
local container = require(script.Parent.Parent.Parent.util.container);
local create = vide.create;
local source = vide.source;
local spring = vide.spring;
local changed = vide.changed;
local cleanup = vide.cleanup;

local function xpos(u1: function) -- Line: 29
    return function() -- Line: 30
        -- upvalues: u1 (copy)
        return Vector2.new(u1(), 0);
    end;
end;

local function ypos(u2: function) -- Line: 35
    return function() -- Line: 36
        -- upvalues: u2 (copy)
        return Vector2.new(0, u2());
    end;
end;

return function(p3: table) -- Line: 41
    -- upvalues: source (copy), theme (copy), cleanup (copy), RunService (copy), UserInputService (copy), GuiService (copy), changed (copy), container (copy), spring (copy), create (copy)
    local resize_range = p3.resize_range;
    local min_size = p3.min_size;
    local can_resize_left = p3.can_resize_left;
    local can_resize_right = p3.can_resize_right;
    local can_resize_bottom = p3.can_resize_bottom;
    local can_resize_top = p3.can_resize_top;
    local resizing = p3.resizing;
    local u4 = source(Vector2.new(1, 1));
    local u5 = source(Vector2.zero);
    local v6 = theme.acc[8];
    local NumberSequence_new_ret = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.25, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(0.75, 1),
        NumberSequenceKeypoint.new(1, 1)
    });
    local u7 = source(0);
    local u8 = source(0);
    cleanup(RunService.Heartbeat:Connect(function() -- Line: 67
        -- upvalues: UserInputService (ref), GuiService (ref), min_size (copy), u4 (copy), resizing (copy), u7 (copy), u8 (copy)
        local MouseLocation = UserInputService:GetMouseLocation();
        local GuiInset, v9 = GuiService:GetGuiInset();
        local v10 = MouseLocation + (-GuiInset - v9);

        if min_size.X ~= u4().X or not resizing() then
            u7(v10.X);
        end;

        if min_size.Y ~= u4().Y or not resizing() then
            u8(v10.Y);
        end;
    end));
    cleanup(RunService.RenderStepped:Connect(function() -- Line: 76
        -- upvalues: UserInputService (ref), GuiService (ref), resizing (copy), u5 (copy), u4 (copy), resize_range (copy), can_resize_top (copy), can_resize_left (copy), can_resize_bottom (copy), can_resize_right (copy)
        local MouseLocation = UserInputService:GetMouseLocation();
        local GuiInset, v11 = GuiService:GetGuiInset();
        local v12 = MouseLocation + (-GuiInset - v11);
        local X = v12.X;
        local Y = v12.Y;

        if resizing() then
            return;
        end;

        local X2 = u5().X;
        local Y2 = u5().Y;
        local v13 = X2 + u4().X;
        local v14 = Y2 + u4().Y;
        local v15 = u5() - Vector2.new(resize_range, resize_range);
        local v16 = u5() + u4() + Vector2.new(resize_range, resize_range);
        local v17;

        if v15.X < X and (v15.Y < Y and X < v16.X) then
            v17 = Y < v16.Y;
        else
            v17 = false;
        end;

        local v18;

        if Y2 - resize_range < Y then
            if Y < Y2 then
                v18 = v17;
            else
                v18 = false;
            end;
        else
            v18 = false;
        end;

        can_resize_top(v18);
        local v19;

        if X < X2 + resize_range then
            if X2 - resize_range < X then
                v19 = v17;
            else
                v19 = false;
            end;
        else
            v19 = false;
        end;

        can_resize_left(v19);
        local v20;

        if Y < v14 + resize_range then
            if v14 - resize_range < Y then
                v20 = v17;
            else
                v20 = false;
            end;
        else
            v20 = false;
        end;

        can_resize_bottom(v20);

        if X < v13 + resize_range then
            if v13 - resize_range >= X then
                v17 = false;
            end;
        else
            v17 = false;
        end;

        can_resize_right(v17);
    end));
    local v21 = {};
    local v23 = changed("AbsoluteSize", function(p22) -- Line: 103
        -- upvalues: u4 (copy)
        if p22.Magnitude == 0 then
            return;
        end;

        u4(p22);
    end);
    local v24 = changed("AbsolutePosition", u5);
    local v25 = {
        Name = "Left",
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.new(0, 4, 1, 8),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = v6,
        BackgroundTransparency = spring(function() -- Line: 119
            -- upvalues: can_resize_left (copy)
            return can_resize_left() and 0 or 1;
        end, 0.2),
        ZIndex = 1000
    };
    local v26 = create("UIGradient");
    local v27 = {
        Rotation = 90,
        Transparency = NumberSequence_new_ret
    };
    local u28 = spring(function() -- Line: 130
        -- upvalues: u8 (copy), u5 (copy), u4 (copy)
        return (u8() - u5().Y - u4().Y / 2) / u4().Y;
    end, 0.1);

    function v27.Offset() -- Line: 36
        -- upvalues: u28 (copy)
        return Vector2.new(0, u28());
    end;

    v25[1], v25[2] = v26(v27), create("UICorner")({
    CornerRadius = UDim.new(0, 4)
});
    local v29 = container(v25);
    local v30 = {
        Name = "Right",
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.new(0, 4, 1, 8),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = v6,
        BackgroundTransparency = spring(function() -- Line: 150
            -- upvalues: can_resize_right (copy)
            return can_resize_right() and 0 or 1;
        end, 0.2),
        ZIndex = 1000
    };
    local v31 = create("UIGradient");
    local v32 = {
        Rotation = 90,
        Transparency = NumberSequence_new_ret
    };
    local u33 = spring(function() -- Line: 161
        -- upvalues: u8 (copy), u5 (copy), u4 (copy)
        return (u8() - u5().Y - u4().Y / 2) / u4().Y;
    end, 0.1);

    function v32.Offset() -- Line: 36
        -- upvalues: u33 (copy)
        return Vector2.new(0, u33());
    end;

    v30[1], v30[2] = v31(v32), create("UICorner")({
    CornerRadius = UDim.new(0, 4)
});
    local v34 = container(v30);
    local v35 = {
        Name = "Bottom",
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.new(1, 8, 0, 4),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = v6,
        BackgroundTransparency = spring(function() -- Line: 181
            -- upvalues: can_resize_bottom (copy)
            return can_resize_bottom() and 0 or 1;
        end, 0.2),
        ZIndex = 1000
    };
    local v36 = create("UIGradient");
    local v37 = {
        Transparency = NumberSequence_new_ret
    };
    local u38 = spring(function() -- Line: 190
        -- upvalues: u7 (copy), u5 (copy), u4 (copy)
        return (u7() - u5().X - u4().X / 2) / u4().X;
    end, 0.1);

    function v37.Offset() -- Line: 30
        -- upvalues: u38 (copy)
        return Vector2.new(u38(), 0);
    end;

    v35[1], v35[2] = v36(v37), create("UICorner")({
    CornerRadius = UDim.new(0, 4)
});
    local v39 = container(v35);
    local v40 = {
        Name = "Top",
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.new(1, 8, 0, 4),
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundColor3 = v6,
        BackgroundTransparency = spring(function() -- Line: 210
            -- upvalues: can_resize_top (copy)
            return can_resize_top() and 0 or 1;
        end, 0.2),
        ZIndex = 1000
    };
    local v41 = create("UIGradient");
    local v42 = {
        Transparency = NumberSequence_new_ret
    };
    local u43 = spring(function() -- Line: 219
        -- upvalues: u7 (copy), u5 (copy), u4 (copy)
        return (u7() - u5().X - u4().X / 2) / u4().X;
    end, 0.1);

    function v42.Offset() -- Line: 30
        -- upvalues: u43 (copy)
        return Vector2.new(u43(), 0);
    end;

    v40[1], v40[2] = v41(v42), create("UICorner")({
    CornerRadius = UDim.new(0, 4)
});
    v21[1], v21[2], v21[3], v21[4], v21[5], v21[6] = v23, v24, v29, v34, v39, container(v40);

    return v21;
end;