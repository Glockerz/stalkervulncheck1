-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local success, result = pcall(function() -- Line: 4
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("PdaSound", 5));
end);

local function sfx(p1) -- Line: 7
    -- upvalues: success (copy), result (copy)
    if success and result then
        result.Play(p1);
    end;
end;

local function click() -- Line: 10
    -- upvalues: success (copy), result (copy)
    if success and result then
        result.PlayClick(5);
    end;
end;

local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local Font_new_ret4 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic);
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 220, 220);
local Color3_fromRGB_ret3 = Color3.fromRGB(170, 170, 170);
local Color3_fromRGB_ret4 = Color3.fromRGB(120, 120, 120);
local Color3_fromRGB_ret5 = Color3.fromRGB(50, 56, 48);
local Color3_fromRGB_ret6 = Color3.fromRGB(120, 140, 80);
local Color3_fromRGB_ret7 = Color3.fromRGB(60, 60, 60);
local Color3_fromRGB_ret8 = Color3.fromRGB(225, 95, 95);
local Color3_fromRGB_ret9 = Color3.fromRGB(190, 190, 190);
local v2 = {};

local function formatTime(p3) -- Line: 31
    if p3 <= 0 then
        return "00:00:00";
    end;

    local math_floor_ret = math.floor(p3 / 3600);
    local math_floor_ret2 = math.floor(p3 % 3600 / 60);

    return string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, p3 % 60);
end;

local function turnInReward() -- Line: 47
    -- upvalues: ReplicatedStorage (copy)
    local success2, result2 = pcall(function() -- Line: 48
        -- upvalues: ReplicatedStorage (ref)
        return require(ReplicatedStorage:WaitForChild("TaskController", 5));
    end);

    if not (success2 and (result2 and result2.GetDailyTurnIn)) then
        return nil, 1;
    end;

    local DailyTurnIn, _, v4 = result2:GetDailyTurnIn();

    return DailyTurnIn, v4 or 1;
end;

local function buildSidebar(p5, p6, u7) -- Line: 59
    -- upvalues: Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret6 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Sidebar";
    Frame.Size = UDim2.new(0.2, 0, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p5;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 6);
    UIListLayout.Parent = Frame;

    for i, v in ipairs({ {
            key = "operational",
            name = "OPERATIONAL\nTASKS"
        }, {
            key = "main",
            name = "MAIN\nTASKS"
        }, {
            key = "side",
            name = "SIDE\nTASKS"
        } }) do
        local v8 = v.key == p6;
        local TextButton = Instance.new("TextButton");
        TextButton.Name = "Cat_" .. v.key;
        TextButton.Size = UDim2.new(1, 0, 0, 64);
        TextButton.BackgroundColor3 = Color3_fromRGB_ret5;
        TextButton.BackgroundTransparency = v8 and 0.25 or 1;
        TextButton.BorderSizePixel = 0;
        TextButton.AutoButtonColor = false;
        TextButton.Text = "";
        TextButton.LayoutOrder = i;
        TextButton.Parent = Frame;

        if v8 then
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Color = Color3_fromRGB_ret6;
            UIStroke.Thickness = 1;
            UIStroke.Transparency = 0.3;
            UIStroke.Parent = TextButton;
        end;

        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.new(1, -20, 1, 0);
        TextLabel.Position = UDim2.fromOffset(16, 0);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font_new_ret2;
        TextLabel.TextSize = 15;
        TextLabel.TextColor3 = v8 and Color3_fromRGB_ret2 or Color3_fromRGB_ret3;
        TextLabel.Text = v.name;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel.LineHeight = 1.05;
        TextLabel.Parent = TextButton;
        TextButton.MouseButton1Click:Connect(function() -- Line: 107
            -- upvalues: u7 (copy), v (copy)
            if u7 then
                u7(v.key);
            end;
        end);
    end;
end;

local function buildDailyCard(p9, u10, p11, p12, u13) -- Line: 116
    -- upvalues: Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret6 (copy), Font_new_ret (copy), Color3_fromRGB_ret3 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret7 (copy), Font_new_ret4 (copy), Color3_fromRGB_ret4 (copy), ReplicatedStorage (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "DailyCard_" .. tostring(u10.index or 0);
    TextButton.Size = UDim2.new(1, -4, 0, 108);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret5;
    TextButton.BackgroundTransparency = p12 and 0.05 or 0.15;
    TextButton.BorderSizePixel = 0;
    TextButton.LayoutOrder = p11;
    TextButton.AutoButtonColor = false;
    TextButton.Text = "";
    TextButton.Parent = p9;

    if u13 then
        TextButton.MouseButton1Click:Connect(function() -- Line: 129
            -- upvalues: u13 (copy), u10 (copy)
            u13(u10);
        end);
    end;

    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p12 and Color3_fromRGB_ret or Color3_fromRGB_ret6;
    UIStroke.Thickness = p12 and 1.5 or 1;
    UIStroke.Transparency = p12 and 0.2 or 0.4;
    UIStroke.Parent = TextButton;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(0, 60, 0, 18);
    TextLabel.Position = UDim2.fromOffset(10, 8);
    TextLabel.BackgroundColor3 = Color3_fromRGB_ret;
    TextLabel.BackgroundTransparency = 0.2;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 12;
    TextLabel.TextColor3 = Color3.new(0, 0, 0);
    TextLabel.Text = "DAILY";
    TextLabel.Parent = TextButton;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.AnchorPoint = Vector2.new(1, 0);
    TextLabel2.Position = UDim2.new(1, -10, 0, 8);
    TextLabel2.Size = UDim2.new(0, 100, 0, 18);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret;
    TextLabel2.TextSize = 12;
    TextLabel2.TextColor3 = Color3_fromRGB_ret3;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel2.Parent = TextButton;

    local function tickCardTimer() -- Line: 160
        -- upvalues: TextLabel2 (copy)
        local os_time_ret = os.time();
        local v14 = (math.floor(os_time_ret / 86400) + 1) * 86400 - os_time_ret;
        local v15;

        if v14 <= 0 then
            v15 = "00:00:00";
        else
            local math_floor_ret = math.floor(v14 / 3600);
            local math_floor_ret2 = math.floor(v14 % 3600 / 60);
            v15 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v14 % 60);
        end;

        TextLabel2.Text = "⧖ " .. v15;
    end;

    local os_time_ret = os.time();
    local v16 = (math.floor(os_time_ret / 86400) + 1) * 86400 - os_time_ret;
    local v17;

    if v16 <= 0 then
        v17 = "00:00:00";
    else
        local math_floor_ret = math.floor(v16 / 3600);
        local math_floor_ret2 = math.floor(v16 % 3600 / 60);
        v17 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v16 % 60);
    end;

    TextLabel2.Text = "⧖ " .. v17;
    task.spawn(function() -- Line: 166
        -- upvalues: TextLabel2 (copy)
        while TextLabel2.Parent do
            task.wait(1);

            if TextLabel2.Parent then
                local os_time_ret2 = os.time();
                local v18 = (math.floor(os_time_ret2 / 86400) + 1) * 86400 - os_time_ret2;
                local v19;

                if v18 <= 0 then
                    v19 = "00:00:00";
                else
                    local math_floor_ret = math.floor(v18 / 3600);
                    local math_floor_ret2 = math.floor(v18 % 3600 / 60);
                    v19 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v18 % 60);
                end;

                TextLabel2.Text = "⧖ " .. v19;
            end;
        end;
    end);
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Size = UDim2.new(1, -20, 0, 22);
    TextLabel3.Position = UDim2.fromOffset(10, 30);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret2;
    TextLabel3.TextSize = 16;
    TextLabel3.TextColor3 = Color3_fromRGB_ret2;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Text = u10.objective or "Daily objective";
    TextLabel3.Parent = TextButton;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, -20, 0, 6);
    Frame.Position = UDim2.new(0, 10, 0, 56);
    Frame.BackgroundColor3 = Color3_fromRGB_ret7;
    Frame.BorderSizePixel = 0;
    Frame.Parent = TextButton;
    local v20 = not (u10.params and (u10.params.target and u10.params.target > 0)) and 0 or math.clamp((u10.progress or 0) / u10.params.target, 0, 1);
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.new(v20, 0, 1, 0);
    Frame2.BackgroundColor3 = Color3_fromRGB_ret;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.Size = UDim2.new(1, -20, 0, 20);
    TextLabel4.Position = UDim2.new(0, 10, 0, 68);
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = Font_new_ret4;
    TextLabel4.TextSize = 12;
    TextLabel4.TextColor3 = Color3_fromRGB_ret3;
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel4.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel4.Text = u10.briefing or "";
    TextLabel4.Parent = TextButton;
    local v21, v22;

    if u10.turned_in then
        v21 = Color3_fromRGB_ret4;
        v22 = "TURNED IN: come back tomorrow";
    elseif u10.completed then
        v21 = Color3_fromRGB_ret;
        v22 = "READY: RETURN TO ECOLOGIST";
    else
        local success2, result2 = pcall(function() -- Line: 48
            -- upvalues: ReplicatedStorage (ref)
            return require(ReplicatedStorage:WaitForChild("TaskController", 5));
        end);
        local v23, v24;

        if success2 and (result2 and result2.GetDailyTurnIn) then
            local v25, v26;
            v23, v25, v26 = result2:GetDailyTurnIn();
            v24 = v26 or 1;
        else
            v23 = nil;
            v24 = 1;
        end;

        v22 = v23 and string.format("IN PROGRESS   •   +%s₽   •   +%d Ecologist Rep", v23, v24) or string.format("IN PROGRESS   •   +%d Ecologist Rep", v24);
        v21 = Color3_fromRGB_ret3;
    end;

    local TextLabel5 = Instance.new("TextLabel");
    TextLabel5.Size = UDim2.new(1, -20, 0, 16);
    TextLabel5.Position = UDim2.new(0, 10, 0, 88);
    TextLabel5.BackgroundTransparency = 1;
    TextLabel5.FontFace = Font_new_ret2;
    TextLabel5.TextSize = 12;
    TextLabel5.TextColor3 = v21;
    TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel5.Text = v22;
    TextLabel5.Parent = TextButton;
end;

local function buildTaskEntry(p27, u28, p29, u30, u31) -- Line: 242
    -- upvalues: Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret6 (copy), Font_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret9 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret8 (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Task_" .. u28.id;
    TextButton.Size = UDim2.new(1, -4, 0, 52);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret5;
    TextButton.BackgroundTransparency = u30 and 0.25 or 1;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = false;
    TextButton.Text = "";
    TextButton.LayoutOrder = p29;
    TextButton.Parent = p27;

    if u30 then
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3_fromRGB_ret6;
        UIStroke.Thickness = 1;
        UIStroke.Transparency = 0.3;
        UIStroke.Parent = TextButton;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.AnchorPoint = Vector2.new(0, 0.5);
        TextLabel.Position = UDim2.new(0, -12, 0.5, 0);
        TextLabel.Size = UDim2.fromOffset(14, 14);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font_new_ret;
        TextLabel.TextColor3 = Color3_fromRGB_ret;
        TextLabel.Text = "▶";
        TextLabel.TextSize = 16;
        TextLabel.Parent = TextButton;
    end;

    local Frame = Instance.new("Frame");
    Frame.AnchorPoint = Vector2.new(0, 0.5);
    Frame.Position = UDim2.new(0, 12, 0.5, 0);
    Frame.Size = UDim2.fromOffset(7, 7);
    Frame.BackgroundColor3 = u30 and Color3_fromRGB_ret or Color3_fromRGB_ret9;
    Frame.BorderSizePixel = 0;
    Frame.Parent = TextButton;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(28, 7);
    TextLabel.Size = UDim2.new(1, -130, 0, 22);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 18;
    TextLabel.TextColor3 = Color3_fromRGB_ret2;
    TextLabel.Text = u28.title or "Task";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = TextButton;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(28, 28);
    TextLabel2.Size = UDim2.new(1, -130, 0, 18);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 14;
    TextLabel2.TextColor3 = Color3_fromRGB_ret3;
    TextLabel2.Text = u28.objective_location and (u28.objective_location.zone or "?") or "?";
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Parent = TextButton;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.AnchorPoint = Vector2.new(1, 0);
    TextLabel3.Position = UDim2.new(1, -12, 0, 28);
    TextLabel3.Size = UDim2.fromOffset(100, 18);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret2;
    TextLabel3.TextSize = 14;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel3.Parent = TextButton;

    local function tick() -- Line: 314
        -- upvalues: TextButton (copy), u28 (copy), TextLabel3 (copy), Color3_fromRGB_ret8 (ref), u30 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret3 (ref)
        if not TextButton.Parent then
            return;
        end;

        local v32 = (u28.timing and u28.timing.deadline_at or 0) - os.time();
        local v33;

        if v32 <= 0 then
            v33 = "00:00:00";
        else
            local math_floor_ret = math.floor(v32 / 3600);
            local math_floor_ret2 = math.floor(v32 % 3600 / 60);
            v33 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v32 % 60);
        end;

        TextLabel3.Text = "⧖ " .. v33;
        TextLabel3.TextColor3 = v32 < 300 and Color3_fromRGB_ret8 or (u30 and Color3_fromRGB_ret or Color3_fromRGB_ret3);
    end;

    if TextButton.Parent then
        local v34 = (u28.timing and (u28.timing.deadline_at or 0) or 0) - os.time();
        local v35;

        if v34 <= 0 then
            v35 = "00:00:00";
        else
            local math_floor_ret = math.floor(v34 / 3600);
            local math_floor_ret2 = math.floor(v34 % 3600 / 60);
            v35 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v34 % 60);
        end;

        TextLabel3.Text = "⧖ " .. v35;
        TextLabel3.TextColor3 = v34 < 300 and Color3_fromRGB_ret8 or (u30 and Color3_fromRGB_ret or Color3_fromRGB_ret3);
    end;

    task.spawn(function() -- Line: 321
        -- upvalues: TextButton (copy), u28 (copy), TextLabel3 (copy), Color3_fromRGB_ret8 (ref), u30 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret3 (ref)
        while TextButton.Parent do
            task.wait(1);

            if TextButton.Parent then
                local v36 = (u28.timing and u28.timing.deadline_at or 0) - os.time();
                local v37;

                if v36 <= 0 then
                    v37 = "00:00:00";
                else
                    local math_floor_ret = math.floor(v36 / 3600);
                    local math_floor_ret2 = math.floor(v36 % 3600 / 60);
                    v37 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v36 % 60);
                end;

                TextLabel3.Text = "⧖ " .. v37;
                TextLabel3.TextColor3 = v36 < 300 and Color3_fromRGB_ret8 or (u30 and Color3_fromRGB_ret or Color3_fromRGB_ret3);
            end;
        end;
    end);

    if u31 then
        TextButton.MouseButton1Click:Connect(function() -- Line: 326
            -- upvalues: u31 (copy), u28 (copy)
            u31(u28);
        end);
    end;
end;

local function buildShareEntry(p38, p39, p40, p41, u42) -- Line: 331
    -- upvalues: Color3_fromRGB_ret5 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Font_new_ret3 (copy), Font_new_ret (copy)
    local u43 = p39.task or {};
    local Color3_fromRGB_ret10 = Color3.fromRGB(140, 200, 120);
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Share_" .. tostring(u43.id);
    TextButton.Size = UDim2.new(1, -4, 0, 52);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret5;
    TextButton.BackgroundTransparency = p41 and 0.25 or 1;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = false;
    TextButton.Text = "";
    TextButton.LayoutOrder = p40;
    TextButton.Parent = p38;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret10;
    UIStroke.Thickness = 1;
    UIStroke.Transparency = p41 and 0.1 or 0.55;
    UIStroke.Parent = TextButton;
    local Frame = Instance.new("Frame");
    Frame.AnchorPoint = Vector2.new(0, 0.5);
    Frame.Position = UDim2.new(0, 12, 0.5, 0);
    Frame.Size = UDim2.fromOffset(7, 7);
    Frame.BackgroundColor3 = Color3_fromRGB_ret10;
    Frame.BorderSizePixel = 0;
    Frame.Parent = TextButton;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(28, 7);
    TextLabel.Size = UDim2.new(1, -130, 0, 22);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 18;
    TextLabel.TextColor3 = Color3_fromRGB_ret2;
    TextLabel.Text = u43.title or "Shared Task";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = TextButton;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(28, 28);
    TextLabel2.Size = UDim2.new(1, -130, 0, 18);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 14;
    TextLabel2.TextColor3 = Color3_fromRGB_ret10;
    TextLabel2.Text = "⇄ from " .. (p39.fromName or "a squadmate");
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Parent = TextButton;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.AnchorPoint = Vector2.new(1, 0);
    TextLabel3.Position = UDim2.new(1, -12, 0, 7);
    TextLabel3.Size = UDim2.fromOffset(100, 18);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret;
    TextLabel3.TextSize = 12;
    TextLabel3.TextColor3 = Color3_fromRGB_ret10;
    TextLabel3.Text = "NEW";
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel3.Parent = TextButton;

    if u42 then
        TextButton.MouseButton1Click:Connect(function() -- Line: 397
            -- upvalues: u42 (copy), u43 (copy)
            u42(u43);
        end);
    end;
end;

local function buildMainCard(p44, u45, p46, p47, u48) -- Line: 406
    -- upvalues: Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret6 (copy), Font_new_ret (copy), Color3_fromRGB_ret3 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Font_new_ret3 (copy)
    local v49 = u45.stageCount ~= nil;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "MainCard_" .. tostring(u45.id);
    TextButton.Size = UDim2.new(1, -4, 0, v49 and 96 or 76);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret5;
    TextButton.BackgroundTransparency = p47 and 0.05 or 0.15;
    TextButton.BorderSizePixel = 0;
    TextButton.LayoutOrder = p46;
    TextButton.AutoButtonColor = false;
    TextButton.Text = "";
    TextButton.Parent = p44;

    if u48 then
        TextButton.MouseButton1Click:Connect(function() -- Line: 421
            -- upvalues: u48 (copy), u45 (copy)
            u48(u45);
        end);
    end;

    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p47 and Color3_fromRGB_ret or Color3_fromRGB_ret6;
    UIStroke.Thickness = p47 and 1.5 or 1;
    UIStroke.Transparency = p47 and 0.2 or 0.4;
    UIStroke.Parent = TextButton;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(0, 54, 0, 18);
    TextLabel.Position = UDim2.fromOffset(10, 8);
    TextLabel.BackgroundColor3 = Color3_fromRGB_ret;
    TextLabel.BackgroundTransparency = 0.2;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 12;
    TextLabel.TextColor3 = Color3.new(0, 0, 0);
    TextLabel.Text = "STORY";
    TextLabel.Parent = TextButton;

    if v49 then
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.AnchorPoint = Vector2.new(1, 0);
        TextLabel2.Position = UDim2.new(1, -10, 0, 8);
        TextLabel2.Size = UDim2.new(0, 90, 0, 18);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = Font_new_ret;
        TextLabel2.TextSize = 12;
        TextLabel2.TextColor3 = Color3_fromRGB_ret3;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Right;
        TextLabel2.Text = string.format("STEP %d / %d", u45.stageIndex or 1, u45.stageCount or 1);
        TextLabel2.Parent = TextButton;
    end;

    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.new(1, -20, 0, 22);
    TextLabel2.Position = UDim2.fromOffset(10, 30);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret2;
    TextLabel2.TextSize = 16;
    TextLabel2.TextColor3 = Color3_fromRGB_ret2;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel2.Text = u45.title or "Story task";
    TextLabel2.Parent = TextButton;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Size = UDim2.new(1, -20, 0, 34);
    TextLabel3.Position = UDim2.fromOffset(10, 54);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret3;
    TextLabel3.TextSize = 14;
    TextLabel3.TextColor3 = v49 and Color3_fromRGB_ret or Color3_fromRGB_ret3;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel3.TextWrapped = true;
    TextLabel3.Text = v49 and (u45.stageText or "") or "Available: speak to Crow";
    TextLabel3.Parent = TextButton;
end;

local function buildMainDetail(p50, p51) -- Line: 484
    -- upvalues: Font_new_ret (copy), Color3_fromRGB_ret2 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret4 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret (copy), ReplicatedStorage (copy), Color3_fromRGB_ret5 (copy), success (copy), result (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Detail";
    Frame.Position = UDim2.new(0.52, 8, 0, 0);
    Frame.Size = UDim2.new(0.48, -8, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p50;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 8);
    UIListLayout.Parent = Frame;
    local u52 = 0;

    local function add(p53) -- Line: 498
        -- upvalues: u52 (ref), Frame (copy)
        u52 = u52 + 1;
        p53.LayoutOrder = u52;
        p53.Parent = Frame;

        return p53;
    end;

    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, 0, 0, 28);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 20;
    TextLabel.TextColor3 = Color3_fromRGB_ret2;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = p51.title or "Story task";
    u52 = u52 + 1;
    TextLabel.LayoutOrder = u52;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.new(1, 0, 0, 0);
    TextLabel2.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 14;
    TextLabel2.TextColor3 = Color3_fromRGB_ret3;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.TextWrapped = true;
    TextLabel2.Text = p51.summary or "";
    u52 = u52 + 1;
    TextLabel2.LayoutOrder = u52;
    TextLabel2.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.new(1, 0, 0, 1);
    Frame2.BackgroundColor3 = Color3_fromRGB_ret7;
    Frame2.BorderSizePixel = 0;
    u52 = u52 + 1;
    Frame2.LayoutOrder = u52;
    Frame2.Parent = Frame;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Size = UDim2.new(1, 0, 0, 18);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret;
    TextLabel3.TextSize = 12;
    TextLabel3.TextColor3 = Color3_fromRGB_ret4;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Text = p51.stageCount and "CURRENT OBJECTIVE" or "STATUS";
    u52 = u52 + 1;
    TextLabel3.LayoutOrder = u52;
    TextLabel3.Parent = Frame;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.Size = UDim2.new(1, 0, 0, 0);
    TextLabel4.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = Font_new_ret2;
    TextLabel4.TextSize = 15;
    TextLabel4.TextColor3 = Color3_fromRGB_ret;
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel4.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel4.TextWrapped = true;
    TextLabel4.Text = p51.stageCount and (string.format("%s  (step %d of %d)", p51.stageText or "", p51.stageIndex or 1, p51.stageCount or 1) or "Crow is ready to brief you. Go and speak to him.") or "Crow is ready to brief you. Go and speak to him.";
    u52 = u52 + 1;
    TextLabel4.LayoutOrder = u52;
    TextLabel4.Parent = Frame;

    if p51.reward and p51.reward.money then
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.Size = UDim2.new(1, 0, 0, 20);
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.FontFace = Font_new_ret2;
        TextLabel5.TextSize = 14;
        TextLabel5.TextColor3 = Color3.fromRGB(150, 200, 150);
        TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel5.Text = string.format("Reward: %d₽", p51.reward.money);
        u52 = u52 + 1;
        TextLabel5.LayoutOrder = u52;
        TextLabel5.Parent = Frame;
    end;

    if p51.stageCount then
        local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
        local u54 = "main:" .. tostring(p51.id);
        local v55 = TaskController:GetPinnedId() == u54;
        local TextButton = Instance.new("TextButton");
        TextButton.Name = "MainTrackBtn";
        TextButton.Size = UDim2.new(0, 140, 0, 30);
        TextButton.BackgroundColor3 = v55 and Color3_fromRGB_ret or Color3_fromRGB_ret5;
        TextButton.BackgroundTransparency = v55 and 0.15 or 0.35;
        TextButton.BorderSizePixel = 0;
        TextButton.AutoButtonColor = false;
        TextButton.FontFace = Font_new_ret;
        TextButton.TextSize = 13;
        TextButton.TextColor3 = v55 and Color3.new(0, 0, 0) or Color3_fromRGB_ret2;
        TextButton.Text = v55 and "✓ TRACKING" or "TRACK";
        u52 = u52 + 1;
        TextButton.LayoutOrder = u52;
        TextButton.Parent = Frame;
        TextButton.MouseButton1Click:Connect(function() -- Line: 593
            -- upvalues: success (ref), result (ref), TaskController (copy), u54 (copy)
            if success and result then
                result.PlayClick(5);
            end;

            TaskController:SetPinned(u54);
        end);
    end;
end;

local function buildSectionHeader(p56, p57, p58) -- Line: 601
    -- upvalues: Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 0, 24);
    Frame.BackgroundTransparency = 1;
    Frame.LayoutOrder = p58;
    Frame.Parent = p56;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(8, 0);
    TextLabel.Size = UDim2.new(1, -16, 1, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 12;
    TextLabel.TextColor3 = Color3_fromRGB_ret4;
    TextLabel.Text = p57;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom;
    TextLabel.Parent = Frame;
end;

local function buildTaskList(p59, p60, p61, p62, p63, u64) -- Line: 620
    -- upvalues: buildSectionHeader (copy), buildShareEntry (copy), ReplicatedStorage (copy), buildDailyCard (copy), buildMainCard (copy), buildTaskEntry (copy), Font_new_ret3 (copy), Color3_fromRGB_ret4 (copy)
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "TaskList";
    ScrollingFrame.Position = UDim2.new(0.2, 8, 0, 0);
    ScrollingFrame.Size = UDim2.new(0.3, 0, 1, 0);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.Parent = p59;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 4);
    UIListLayout.Parent = ScrollingFrame;
    local v65 = 0;

    if p62 == "side" and (p61 and #p61 > 0) then
        v65 = v65 + 1;
        buildSectionHeader(ScrollingFrame, "INCOMING SHARES", v65);

        for _, v in ipairs(p61) do
            v65 = v65 + 1;
            local v66;

            if v.task == nil then
                v66 = false;
            else
                v66 = v.task.id == p63;
            end;

            buildShareEntry(ScrollingFrame, v, v65, v66, u64);
        end;
    end;

    local v67 = ({
        operational = "OPERATIONAL TASKS",
        main = "MAIN TASKS",
        side = "SIDE TASKS"
    })[p62] or "TASKS";
    local v68 = v65 + 1;
    buildSectionHeader(ScrollingFrame, v67, v68);
    local v69 = 0;

    if p62 == "operational" then
        local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
        local v70 = TaskController.GetDailyTasks and TaskController:GetDailyTasks() or {};

        for _, v in ipairs(v70) do
            v69 = v69 + 1;
            v68 = v68 + 1;
            buildDailyCard(ScrollingFrame, v, v68, p63 == "daily:" .. tostring(v.index or 0), function(p71) -- Line: 666
                -- upvalues: u64 (copy)
                if u64 then
                    u64({
                        id = "daily:" .. tostring(p71.index or 0),
                        _daily = p71
                    });
                end;
            end);
        end;
    end;

    local v72 = nil;

    if p62 == "main" then
        local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
        local v73 = TaskController.GetMain and TaskController:GetMain() or nil;
        local v74 = 0;

        if v73 then
            if v73.active then
                v68 = v68 + 1;
                v74 = v74 + 1;
                buildMainCard(ScrollingFrame, v73.active, v68, p63 == "main:" .. v73.active.id, function(p75) -- Line: 683
                    -- upvalues: u64 (copy)
                    if u64 then
                        u64({
                            id = "main:" .. p75.id,
                            _main = p75
                        });
                    end;
                end);
            end;

            for _, v in ipairs(v73.available or {}) do
                v68 = v68 + 1;
                v74 = v74 + 1;
                buildMainCard(ScrollingFrame, v, v68, p63 == "main:" .. v.id, function(p76) -- Line: 689
                    -- upvalues: u64 (copy)
                    if u64 then
                        u64({
                            id = "main:" .. p76.id,
                            _main = p76
                        });
                    end;
                end);
            end;
        end;

        if v74 == 0 then
            v72 = "No main tasks active.";
        end;
    end;

    local v77 = {};

    for _, v in ipairs(p60) do
        if (v.category or "side") == p62 then
            table.insert(v77, v);
        end;
    end;

    if #v77 > 0 then
        for _, v in ipairs(v77) do
            v68 = v68 + 1;
            buildTaskEntry(ScrollingFrame, v, v68, v.id == p63, u64);
        end;

        return;
    end;

    if p62 ~= "main" or v72 ~= nil then
        if p62 == "operational" and v69 > 0 then
            return;
        end;

        local v78 = v72 or (({
            operational = "No operational tasks. Daily tasks appear here.",
            main = "No main tasks active.",
            side = "No active tasks. Talk to a quest-giver for work."
        })[p62] or "No tasks in this category.");
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.new(1, 0, 0, 60);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font_new_ret3;
        TextLabel.TextSize = 14;
        TextLabel.TextColor3 = Color3_fromRGB_ret4;
        TextLabel.TextWrapped = true;
        TextLabel.LayoutOrder = v68 + 1;
        TextLabel.Text = v78;
        TextLabel.Parent = ScrollingFrame;
    end;
end;

local function buildDailyDetail(p79, p80) -- Line: 739
    -- upvalues: Font_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret7 (copy), Font_new_ret2 (copy), ReplicatedStorage (copy), Font_new_ret4 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "DailyDetail";
    Frame.Position = UDim2.new(0.5, 8, 0, 0);
    Frame.Size = UDim2.new(0.5, -8, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p79;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(4, 6);
    TextLabel.Size = UDim2.new(1, -8, 0, 30);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 22;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.Text = p80.objective or "Daily task";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(4, 38);
    TextLabel2.Size = UDim2.new(0, 80, 0, 20);
    TextLabel2.BackgroundColor3 = Color3_fromRGB_ret;
    TextLabel2.BackgroundTransparency = 0.2;
    TextLabel2.FontFace = Font_new_ret;
    TextLabel2.TextSize = 12;
    TextLabel2.TextColor3 = Color3.new(0, 0, 0);
    TextLabel2.Text = "DAILY";
    TextLabel2.Parent = Frame;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Position = UDim2.fromOffset(92, 38);
    TextLabel3.Size = UDim2.new(1, -230, 0, 20);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret;
    TextLabel3.TextSize = 12;

    if p80.turned_in then
        TextLabel3.Text = "TURNED IN";
        TextLabel3.TextColor3 = Color3_fromRGB_ret4;
    elseif p80.completed then
        TextLabel3.Text = "READY: RETURN TO ECOLOGIST";
        TextLabel3.TextColor3 = Color3_fromRGB_ret;
    else
        TextLabel3.Text = "IN PROGRESS";
        TextLabel3.TextColor3 = Color3_fromRGB_ret3;
    end;

    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Parent = Frame;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.AnchorPoint = Vector2.new(1, 0);
    TextLabel4.Position = UDim2.new(1, -4, 0, 38);
    TextLabel4.Size = UDim2.new(0, 128, 0, 20);
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = Font_new_ret;
    TextLabel4.TextSize = 12;
    TextLabel4.TextColor3 = Color3_fromRGB_ret3;
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel4.Parent = Frame;

    local function tickDetailTimer() -- Line: 800
        -- upvalues: TextLabel4 (copy)
        local os_time_ret = os.time();
        local v81 = (math.floor(os_time_ret / 86400) + 1) * 86400 - os_time_ret;
        local v82;

        if v81 <= 0 then
            v82 = "00:00:00";
        else
            local math_floor_ret = math.floor(v81 / 3600);
            local math_floor_ret2 = math.floor(v81 % 3600 / 60);
            v82 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v81 % 60);
        end;

        TextLabel4.Text = "⧖ " .. v82 .. " TO RESET";
    end;

    local os_time_ret = os.time();
    local v83 = (math.floor(os_time_ret / 86400) + 1) * 86400 - os_time_ret;
    local v84;

    if v83 <= 0 then
        v84 = "00:00:00";
    else
        local math_floor_ret = math.floor(v83 / 3600);
        local math_floor_ret2 = math.floor(v83 % 3600 / 60);
        v84 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v83 % 60);
    end;

    TextLabel4.Text = "⧖ " .. v84 .. " TO RESET";
    task.spawn(function() -- Line: 806
        -- upvalues: TextLabel4 (copy)
        while TextLabel4.Parent do
            task.wait(1);

            if TextLabel4.Parent then
                local os_time_ret2 = os.time();
                local v85 = (math.floor(os_time_ret2 / 86400) + 1) * 86400 - os_time_ret2;
                local v86;

                if v85 <= 0 then
                    v86 = "00:00:00";
                else
                    local math_floor_ret = math.floor(v85 / 3600);
                    local math_floor_ret2 = math.floor(v85 % 3600 / 60);
                    v86 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v85 % 60);
                end;

                TextLabel4.Text = "⧖ " .. v86 .. " TO RESET";
            end;
        end;
    end);
    local TextLabel5 = Instance.new("TextLabel");
    TextLabel5.Position = UDim2.fromOffset(4, 70);
    TextLabel5.Size = UDim2.new(1, -8, 0, 16);
    TextLabel5.BackgroundTransparency = 1;
    TextLabel5.FontFace = Font_new_ret;
    TextLabel5.TextSize = 12;
    TextLabel5.TextColor3 = Color3_fromRGB_ret4;
    TextLabel5.Text = "BRIEFING";
    TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel5.Parent = Frame;
    local TextLabel6 = Instance.new("TextLabel");
    TextLabel6.Position = UDim2.fromOffset(4, 88);
    TextLabel6.Size = UDim2.new(1, -8, 0, 60);
    TextLabel6.BackgroundTransparency = 1;
    TextLabel6.FontFace = Font_new_ret3;
    TextLabel6.TextSize = 14;
    TextLabel6.TextColor3 = Color3_fromRGB_ret2;
    TextLabel6.Text = p80.briefing or "";
    TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel6.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel6.TextWrapped = true;
    TextLabel6.Parent = Frame;
    local TextLabel7 = Instance.new("TextLabel");
    TextLabel7.Position = UDim2.fromOffset(4, 156);
    TextLabel7.Size = UDim2.new(1, -8, 0, 16);
    TextLabel7.BackgroundTransparency = 1;
    TextLabel7.FontFace = Font_new_ret;
    TextLabel7.TextSize = 12;
    TextLabel7.TextColor3 = Color3_fromRGB_ret4;
    TextLabel7.Text = "PROGRESS";
    TextLabel7.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel7.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Position = UDim2.fromOffset(4, 178);
    Frame2.Size = UDim2.new(1, -80, 0, 10);
    Frame2.BackgroundColor3 = Color3_fromRGB_ret7;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local v87 = p80.params and (p80.params.target or 0) or 0;
    local v88 = v87 <= 0 and 0 or math.clamp((p80.progress or 0) / v87, 0, 1);
    local Frame3 = Instance.new("Frame");
    Frame3.Size = UDim2.new(v88, 0, 1, 0);
    Frame3.BackgroundColor3 = Color3_fromRGB_ret;
    Frame3.BorderSizePixel = 0;
    Frame3.Parent = Frame2;
    local TextLabel8 = Instance.new("TextLabel");
    TextLabel8.AnchorPoint = Vector2.new(1, 0);
    TextLabel8.Position = UDim2.new(1, -4, 0, 172);
    TextLabel8.Size = UDim2.fromOffset(70, 20);
    TextLabel8.BackgroundTransparency = 1;
    TextLabel8.FontFace = Font_new_ret;
    TextLabel8.TextSize = 15;
    TextLabel8.TextColor3 = Color3_fromRGB_ret2;
    TextLabel8.Text = string.format("%d / %d", p80.progress or 0, v87);
    TextLabel8.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel8.Parent = Frame;
    local TextLabel9 = Instance.new("TextLabel");
    TextLabel9.Position = UDim2.fromOffset(4, 202);
    TextLabel9.Size = UDim2.new(1, -8, 0, 16);
    TextLabel9.BackgroundTransparency = 1;
    TextLabel9.FontFace = Font_new_ret;
    TextLabel9.TextSize = 12;
    TextLabel9.TextColor3 = Color3_fromRGB_ret4;
    TextLabel9.Text = "REWARD";
    TextLabel9.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel9.Parent = Frame;
    local TextLabel10 = Instance.new("TextLabel");
    TextLabel10.Position = UDim2.fromOffset(4, 220);
    TextLabel10.Size = UDim2.new(1, -8, 0, 22);
    TextLabel10.BackgroundTransparency = 1;
    TextLabel10.FontFace = Font_new_ret2;
    TextLabel10.TextSize = 16;
    TextLabel10.TextColor3 = Color3.fromRGB(150, 210, 140);
    local success2, result2 = pcall(function() -- Line: 48
        -- upvalues: ReplicatedStorage (ref)
        return require(ReplicatedStorage:WaitForChild("TaskController", 5));
    end);
    local v89, v90;

    if success2 and (result2 and result2.GetDailyTurnIn) then
        local v91, v92;
        v89, v91, v92 = result2:GetDailyTurnIn();
        v90 = v92 or 1;
    else
        v89 = nil;
        v90 = 1;
    end;

    TextLabel10.Text = v89 and string.format("%s ₽   +%d Ecologist Rep", v89, v90) or string.format("+%d Ecologist Rep", v90);
    TextLabel10.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel10.Parent = Frame;
    local Frame4 = Instance.new("Frame");
    Frame4.Position = UDim2.new(0, 4, 0, 258);
    Frame4.Size = UDim2.new(1, -8, 0, 68);
    Frame4.BackgroundColor3 = Color3.fromRGB(40, 42, 45);
    Frame4.BackgroundTransparency = 0.15;
    Frame4.BorderSizePixel = 0;
    Frame4.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret;
    UIStroke.Thickness = 1;
    UIStroke.Transparency = 0.5;
    UIStroke.Parent = Frame4;
    local TextLabel11 = Instance.new("TextLabel");
    TextLabel11.Position = UDim2.fromOffset(10, 6);
    TextLabel11.Size = UDim2.new(1, -20, 0, 16);
    TextLabel11.BackgroundTransparency = 1;
    TextLabel11.FontFace = Font_new_ret;
    TextLabel11.TextSize = 12;
    TextLabel11.TextColor3 = Color3_fromRGB_ret;
    TextLabel11.Text = "TURN IN AT";
    TextLabel11.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel11.Parent = Frame4;
    local TextLabel12 = Instance.new("TextLabel");
    TextLabel12.Position = UDim2.fromOffset(10, 24);
    TextLabel12.Size = UDim2.new(1, -20, 0, 20);
    TextLabel12.BackgroundTransparency = 1;
    TextLabel12.FontFace = Font_new_ret;
    TextLabel12.TextSize = 18;
    TextLabel12.TextColor3 = Color3_fromRGB_ret2;
    TextLabel12.Text = "Ecologist";
    TextLabel12.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel12.Parent = Frame4;
    local TextLabel13 = Instance.new("TextLabel");
    TextLabel13.Position = UDim2.fromOffset(10, 46);
    TextLabel13.Size = UDim2.new(1, -20, 0, 16);
    TextLabel13.BackgroundTransparency = 1;
    TextLabel13.FontFace = Font_new_ret4;
    TextLabel13.TextSize = 12;
    TextLabel13.TextColor3 = Color3_fromRGB_ret3;
    TextLabel13.Text = "Lobby, main hub";
    TextLabel13.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel13.Parent = Frame4;
end;

local function buildDetail(p93, u94, p95) -- Line: 956
    -- upvalues: Font_new_ret3 (copy), Color3_fromRGB_ret4 (copy), Font_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret7 (copy), success (copy), result (copy), ReplicatedStorage (copy), Font_new_ret4 (copy), Color3_fromRGB_ret5 (copy)
    local v96 = p95 or {};
    local onShare = v96.onShare;
    local onAbandon = v96.onAbandon;
    local onAccept = v96.onAccept;
    local onDecline = v96.onDecline;
    local pending = v96.pending;
    local Frame = Instance.new("Frame");
    Frame.Name = "Detail";
    Frame.Position = UDim2.new(0.51, 16, 0, 0);
    Frame.Size = UDim2.new(0.49, -16, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p93;

    if not u94 then
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.fromScale(1, 1);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font_new_ret3;
        TextLabel.TextSize = 16;
        TextLabel.TextColor3 = Color3_fromRGB_ret4;
        TextLabel.Text = "Select a task to view details.";
        TextLabel.Parent = Frame;

        return;
    end;

    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(0, 0);
    TextLabel.Size = UDim2.new(0.6, 0, 0, 32);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 24;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.Text = u94.title or "Task";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(0, 38);
    TextLabel2.Size = UDim2.new(0.6, 0, 0, 60);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 15;
    TextLabel2.TextColor3 = Color3_fromRGB_ret3;
    TextLabel2.TextWrapped = true;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.Text = u94.description or "";
    TextLabel2.Parent = Frame;

    if u94.shared_from then
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.Position = UDim2.fromOffset(0, 95);
        TextLabel3.Size = UDim2.new(0.6, 0, 0, 14);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = Font_new_ret2;
        TextLabel3.TextSize = 13;
        TextLabel3.TextColor3 = Color3.fromRGB(140, 200, 120);
        TextLabel3.Text = "⇄ Shared by " .. (u94.shared_from_name or "a squadmate");
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.Parent = Frame;
    end;

    local Frame2 = Instance.new("Frame");
    Frame2.AnchorPoint = Vector2.new(1, 0);
    Frame2.Position = UDim2.new(1, 0, 0, 0);
    Frame2.Size = UDim2.fromOffset(170, 110);
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Size = UDim2.new(1, 0, 0, 16);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret2;
    TextLabel3.TextSize = 12;
    TextLabel3.TextColor3 = Color3_fromRGB_ret4;
    TextLabel3.Text = "TIME LIMIT";
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Parent = Frame2;
    local v97;

    if pending then
        v97 = u94.timing and (u94.timing.duration or 0) or 0;
    else
        v97 = u94.timing and (u94.timing.deadline_at and u94.timing.accepted_at) and (u94.timing.deadline_at - u94.timing.accepted_at or 0) or 0;
    end;

    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.Position = UDim2.fromOffset(0, 18);
    TextLabel4.Size = UDim2.new(1, 0, 0, 30);
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = Font_new_ret;
    TextLabel4.TextSize = 26;
    TextLabel4.TextColor3 = Color3_fromRGB_ret;
    local v98;

    if v97 <= 0 then
        v98 = "00:00:00";
    else
        local math_floor_ret = math.floor(v97 / 3600);
        local math_floor_ret2 = math.floor(v97 % 3600 / 60);
        v98 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v97 % 60);
    end;

    TextLabel4.Text = "⧖ " .. v98;
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel4.Parent = Frame2;
    local TextLabel5 = Instance.new("TextLabel");
    TextLabel5.Position = UDim2.fromOffset(0, 56);
    TextLabel5.Size = UDim2.new(1, 0, 0, 16);
    TextLabel5.BackgroundTransparency = 1;
    TextLabel5.FontFace = Font_new_ret2;
    TextLabel5.TextSize = 12;
    TextLabel5.TextColor3 = Color3_fromRGB_ret4;
    TextLabel5.Text = "REMAINING";
    TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel5.Parent = Frame2;
    local TextLabel6 = Instance.new("TextLabel");
    TextLabel6.Position = UDim2.fromOffset(0, 74);
    TextLabel6.Size = UDim2.new(1, 0, 0, 26);
    TextLabel6.BackgroundTransparency = 1;
    TextLabel6.FontFace = Font_new_ret2;
    TextLabel6.TextSize = 20;
    TextLabel6.TextColor3 = Color3_fromRGB_ret2;
    TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel6.Parent = Frame2;

    if pending then
        TextLabel5.Text = "STARTS";
        TextLabel6.Text = "On accept";
        TextLabel6.TextColor3 = Color3_fromRGB_ret3;
    else
        local function tickRem() -- Line: 1081
            -- upvalues: TextLabel6 (copy), u94 (copy), Color3_fromRGB_ret8 (ref), Color3_fromRGB_ret2 (ref)
            if not TextLabel6.Parent then
                return;
            end;

            local v99 = (u94.timing and u94.timing.deadline_at or 0) - os.time();
            local v100;

            if v99 <= 0 then
                v100 = "00:00:00";
            else
                local math_floor_ret = math.floor(v99 / 3600);
                local math_floor_ret2 = math.floor(v99 % 3600 / 60);
                v100 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v99 % 60);
            end;

            TextLabel6.Text = v100;
            TextLabel6.TextColor3 = v99 < 300 and Color3_fromRGB_ret8 or Color3_fromRGB_ret2;
        end;

        if TextLabel6.Parent then
            local v101 = (u94.timing and (u94.timing.deadline_at or 0) or 0) - os.time();
            local v102;

            if v101 <= 0 then
                v102 = "00:00:00";
            else
                local math_floor_ret = math.floor(v101 / 3600);
                local math_floor_ret2 = math.floor(v101 % 3600 / 60);
                v102 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v101 % 60);
            end;

            TextLabel6.Text = v102;
            TextLabel6.TextColor3 = v101 < 300 and Color3_fromRGB_ret8 or Color3_fromRGB_ret2;
        end;

        task.spawn(function() -- Line: 1088
            -- upvalues: TextLabel6 (copy), u94 (copy), Color3_fromRGB_ret8 (ref), Color3_fromRGB_ret2 (ref)
            while TextLabel6.Parent do
                task.wait(1);

                if TextLabel6.Parent then
                    local v103 = (u94.timing and u94.timing.deadline_at or 0) - os.time();
                    local v104;

                    if v103 <= 0 then
                        v104 = "00:00:00";
                    else
                        local math_floor_ret = math.floor(v103 / 3600);
                        local math_floor_ret2 = math.floor(v103 % 3600 / 60);
                        v104 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v103 % 60);
                    end;

                    TextLabel6.Text = v104;
                    TextLabel6.TextColor3 = v103 < 300 and Color3_fromRGB_ret8 or Color3_fromRGB_ret2;
                end;
            end;
        end);
    end;

    local function metaCol(p105, p106, p107, p108, p109) -- Line: 1095
        -- upvalues: Font_new_ret2 (ref), Color3_fromRGB_ret4 (ref), Frame (copy), Color3_fromRGB_ret2 (ref)
        local TextLabel7 = Instance.new("TextLabel");
        TextLabel7.Position = UDim2.fromOffset(p105, 110);
        TextLabel7.Size = UDim2.fromOffset(p106, 18);
        TextLabel7.BackgroundTransparency = 1;
        TextLabel7.FontFace = Font_new_ret2;
        TextLabel7.TextSize = 12;
        TextLabel7.TextColor3 = Color3_fromRGB_ret4;
        TextLabel7.Text = p107;
        TextLabel7.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel7.Parent = Frame;
        local TextLabel8 = Instance.new("TextLabel");
        TextLabel8.Position = UDim2.fromOffset(p105, 130);
        TextLabel8.Size = UDim2.fromOffset(p106, 22);
        TextLabel8.BackgroundTransparency = 1;
        TextLabel8.FontFace = Font_new_ret2;
        TextLabel8.TextSize = 16;
        TextLabel8.TextColor3 = p109 or Color3_fromRGB_ret2;
        TextLabel8.Text = p108;
        TextLabel8.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel8.Parent = Frame;
    end;

    metaCol(0, 130, "GIVER", u94.giver and (u94.giver.npcId or "?") or "?");
    metaCol(130, 180, "LOCATION", u94.objective_location and (u94.objective_location.zone or "?") or "?");
    local TextLabel7 = Instance.new("TextLabel");
    TextLabel7.Position = UDim2.fromOffset(310, 110);
    TextLabel7.Size = UDim2.new(1, -310, 0, 18);
    TextLabel7.BackgroundTransparency = 1;
    TextLabel7.FontFace = Font_new_ret2;
    TextLabel7.TextSize = 12;
    TextLabel7.TextColor3 = Color3_fromRGB_ret4;
    TextLabel7.Text = "REWARD";
    TextLabel7.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel7.Parent = Frame;
    local TextLabel8 = Instance.new("TextLabel");
    TextLabel8.Position = UDim2.fromOffset(310, 130);
    TextLabel8.Size = UDim2.new(1, -310, 0, 24);
    TextLabel8.BackgroundTransparency = 1;
    TextLabel8.FontFace = Font_new_ret;
    TextLabel8.TextSize = 20;
    TextLabel8.TextColor3 = Color3_fromRGB_ret;
    TextLabel8.Text = (u94.rewards and (u94.rewards.money or 0) or 0) .. "₽";
    TextLabel8.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel8.Parent = Frame;
    local v110 = {};

    if u94.rewards and u94.rewards.rep then
        table.insert(v110, "+ " .. u94.rewards.rep.amount .. " " .. (u94.rewards.rep.faction or "?") .. " rep");
    end;

    if u94.rewards and u94.rewards.items then
        for _, v in ipairs(u94.rewards.items) do
            table.insert(v110, "+ " .. (v.count or 1) .. "x " .. (v.name or "item"));
        end;
    end;

    for i, v in ipairs(v110) do
        local TextLabel9 = Instance.new("TextLabel");
        TextLabel9.Position = UDim2.fromOffset(310, 156 + (i - 1) * 18);
        TextLabel9.Size = UDim2.new(1, -310, 0, 18);
        TextLabel9.BackgroundTransparency = 1;
        TextLabel9.FontFace = Font_new_ret3;
        TextLabel9.TextSize = 14;
        TextLabel9.TextColor3 = Color3_fromRGB_ret3;
        TextLabel9.Text = v;
        TextLabel9.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel9.Parent = Frame;
    end;

    local Frame3 = Instance.new("Frame");
    Frame3.Position = UDim2.fromOffset(0, 210);
    Frame3.Size = UDim2.new(1, 0, 0, 1);
    Frame3.BackgroundColor3 = Color3_fromRGB_ret7;
    Frame3.BorderSizePixel = 0;
    Frame3.Parent = Frame;
    local TextLabel9 = Instance.new("TextLabel");
    TextLabel9.Position = UDim2.fromOffset(0, 222);
    TextLabel9.Size = UDim2.new(1, 0, 0, 22);
    TextLabel9.BackgroundTransparency = 1;
    TextLabel9.FontFace = Font_new_ret2;
    TextLabel9.TextSize = 14;
    TextLabel9.TextColor3 = Color3_fromRGB_ret4;
    TextLabel9.Text = "OBJECTIVES";
    TextLabel9.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel9.Parent = Frame;

    for i, v in ipairs(u94.objectives or {}) do
        local Frame4 = Instance.new("Frame");
        Frame4.Position = UDim2.fromOffset(0, 252 + (i - 1) * 40);
        Frame4.Size = UDim2.new(1, 0, 0, 34);
        Frame4.BackgroundTransparency = 1;
        Frame4.Parent = Frame;
        local Frame5 = Instance.new("Frame");
        Frame5.Position = UDim2.fromOffset(0, 4);
        Frame5.Size = UDim2.fromOffset(20, 20);
        Frame5.BackgroundColor3 = v.complete and Color3_fromRGB_ret or Color3.fromRGB(40, 40, 40);
        Frame5.BorderSizePixel = 0;
        Frame5.Parent = Frame4;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3_fromRGB_ret3;
        UIStroke.Thickness = 1.5;
        UIStroke.Parent = Frame5;
        local TextLabel10 = Instance.new("TextLabel");
        TextLabel10.Position = UDim2.fromOffset(32, 0);
        TextLabel10.Size = UDim2.new(1, -40, 0, 24);
        TextLabel10.BackgroundTransparency = 1;
        TextLabel10.FontFace = Font_new_ret2;
        TextLabel10.TextSize = 17;
        TextLabel10.TextColor3 = v.complete and Color3_fromRGB_ret4 or Color3_fromRGB_ret2;
        local v111 = v.text or "";

        if v.target and v.progress then
            v111 = v111 .. string.format("  [%d/%d]", v.progress, v.target);
        end;

        TextLabel10.Text = v111;
        TextLabel10.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel10.Parent = Frame4;
    end;

    if pending then
        local TextButton = Instance.new("TextButton");
        TextButton.AnchorPoint = Vector2.new(0, 1);
        TextButton.Position = UDim2.new(0, 0, 1, -8);
        TextButton.Size = UDim2.fromOffset(150, 34);
        TextButton.BackgroundColor3 = Color3.fromRGB(140, 200, 120);
        TextButton.BorderSizePixel = 0;
        TextButton.FontFace = Font_new_ret;
        TextButton.TextSize = 15;
        TextButton.TextColor3 = Color3.fromRGB(20, 22, 20);
        TextButton.Text = "ACCEPT TASK";
        TextButton.Parent = Frame;
        TextButton.MouseButton1Click:Connect(function() -- Line: 1233
            -- upvalues: success (ref), result (ref), onAccept (copy), u94 (copy)
            if success and result then
                result.PlayClick(5);
            end;

            if onAccept then
                onAccept(u94);
            end;
        end);
        local TextButton2 = Instance.new("TextButton");
        TextButton2.AnchorPoint = Vector2.new(1, 1);
        TextButton2.Position = UDim2.new(1, 0, 1, -8);
        TextButton2.Size = UDim2.fromOffset(120, 34);
        TextButton2.BackgroundColor3 = Color3.fromRGB(60, 45, 45);
        TextButton2.BackgroundTransparency = 0.1;
        TextButton2.BorderSizePixel = 0;
        TextButton2.FontFace = Font_new_ret2;
        TextButton2.TextSize = 14;
        TextButton2.TextColor3 = Color3_fromRGB_ret2;
        TextButton2.Text = "DECLINE";
        TextButton2.Parent = Frame;
        TextButton2.MouseButton1Click:Connect(function() -- Line: 1250
            -- upvalues: success (ref), result (ref), onDecline (copy), u94 (copy)
            if success and result then
                result.PlayClick(5);
            end;

            if onDecline then
                onDecline(u94);
            end;
        end);

        return;
    end;

    local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"));
    local v112 = u94.type == "clearing" and true or u94.type == "mutant_hunting";
    local v113 = true;

    for _, v in ipairs(u94.objectives or {}) do
        if v.id ~= "return" and (v.id ~= "deliver" and not v.complete) then
            v113 = false;
            break;
        end;
    end;

    if v112 then
        v112 = not u94.shared_from and not v113;
    end;

    if v112 and SquadController:GetSquad() then
        local TextButton = Instance.new("TextButton");
        TextButton.AnchorPoint = Vector2.new(0, 1);
        TextButton.Position = UDim2.new(0, 0, 1, -8);
        TextButton.Size = UDim2.fromOffset(180, 32);
        TextButton.BackgroundColor3 = Color3_fromRGB_ret;
        TextButton.BorderSizePixel = 0;
        TextButton.Text = "SHARE TO SQUAD";
        TextButton.FontFace = Font_new_ret;
        TextButton.TextSize = 14;
        TextButton.TextColor3 = Color3.fromRGB(20, 20, 22);
        TextButton.Parent = Frame;
        TextButton.MouseButton1Click:Connect(function() -- Line: 1286
            -- upvalues: success (ref), result (ref), onShare (copy), u94 (copy)
            if success and result then
                result.PlayClick(5);
            end;

            if onShare then
                onShare(u94);
            end;
        end);
    elseif v112 then
        local TextButton = Instance.new("TextButton");
        TextButton.Name = "ShareHint";
        TextButton.AnchorPoint = Vector2.new(0, 1);
        TextButton.Position = UDim2.new(0, 0, 1, -8);
        TextButton.Size = UDim2.fromOffset(180, 32);
        TextButton.BackgroundColor3 = Color3.fromRGB(52, 48, 38);
        TextButton.BackgroundTransparency = 0.35;
        TextButton.BorderSizePixel = 0;
        TextButton.AutoButtonColor = false;
        TextButton.Text = "SHARE TO SQUAD";
        TextButton.FontFace = Font_new_ret;
        TextButton.TextSize = 14;
        TextButton.TextColor3 = Color3.fromRGB(150, 140, 115);
        TextButton.Parent = Frame;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3_fromRGB_ret;
        UIStroke.Thickness = 1;
        UIStroke.Transparency = 0.6;
        UIStroke.Parent = TextButton;
        local TextLabel10 = Instance.new("TextLabel");
        TextLabel10.AnchorPoint = Vector2.new(0, 1);
        TextLabel10.Position = UDim2.new(0, 0, 1, -44);
        TextLabel10.Size = UDim2.fromOffset(240, 16);
        TextLabel10.BackgroundTransparency = 1;
        TextLabel10.Text = "Join a squad to share this contract";
        TextLabel10.FontFace = Font_new_ret4;
        TextLabel10.TextSize = 12;
        TextLabel10.TextColor3 = Color3_fromRGB_ret4;
        TextLabel10.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel10.Parent = Frame;
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.AnchorPoint = Vector2.new(1, 1);
    TextButton.Position = UDim2.new(1, 0, 1, -8);
    TextButton.Size = UDim2.fromOffset(90, 24);
    TextButton.BackgroundTransparency = 1;
    TextButton.Text = "Abandon";
    TextButton.FontFace = Font_new_ret4;
    TextButton.TextSize = 13;
    TextButton.TextColor3 = Color3_fromRGB_ret4;
    TextButton.Parent = Frame;
    TextButton.MouseButton1Click:Connect(function() -- Line: 1335
        -- upvalues: success (ref), result (ref), onAbandon (copy), u94 (copy)
        if success and result then
            result.PlayClick(5);
        end;

        if onAbandon then
            onAbandon(u94);
        end;
    end);
    local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
    local TextButton2 = Instance.new("TextButton");
    TextButton2.AnchorPoint = Vector2.new(1, 1);
    TextButton2.Position = UDim2.new(1, -96, 1, -8);
    TextButton2.Size = UDim2.fromOffset(108, 24);
    TextButton2.BackgroundColor3 = Color3_fromRGB_ret5;
    TextButton2.BackgroundTransparency = 0.25;
    TextButton2.BorderSizePixel = 0;
    TextButton2.AutoButtonColor = true;
    TextButton2.FontFace = Font_new_ret2;
    TextButton2.TextSize = 13;
    TextButton2.Parent = Frame;

    local function refreshPin() -- Line: 1353
        -- upvalues: TaskController (copy), u94 (copy), TextButton2 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref)
        local v114 = TaskController:GetPinnedId() == u94.id;
        TextButton2.Text = v114 and "✓ TRACKING" or "TRACK";
        TextButton2.TextColor3 = v114 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
    end;

    local v115 = TaskController:GetPinnedId() == u94.id;
    TextButton2.Text = v115 and "✓ TRACKING" or "TRACK";
    TextButton2.TextColor3 = v115 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
    TextButton2.MouseButton1Click:Connect(function() -- Line: 1359
        -- upvalues: success (ref), result (ref), TaskController (copy), u94 (copy), TextButton2 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref)
        if success and result then
            result.PlayClick(5);
        end;

        TaskController:SetPinned(u94.id);
        local v116 = TaskController:GetPinnedId() == u94.id;
        TextButton2.Text = v116 and "✓ TRACKING" or "TRACK";
        TextButton2.TextColor3 = v116 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
    end);
end;

function v2.Build(p117) -- Line: 1366
    -- upvalues: ReplicatedStorage (copy), Font_new_ret (copy), Color3_fromRGB_ret2 (copy), buildSidebar (copy), buildTaskList (copy), success (copy), result (copy), buildMainDetail (copy), buildDailyDetail (copy), buildDetail (copy)
    local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "PageTitle";
    TextLabel.Position = UDim2.fromOffset(16, 4);
    TextLabel.Size = UDim2.new(0.3, 0, 0, 30);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 24;
    TextLabel.TextColor3 = Color3_fromRGB_ret2;
    TextLabel.Text = "Tasks";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = p117;
    local Frame = Instance.new("Frame");
    Frame.Name = "Body";
    Frame.Position = UDim2.fromOffset(16, 40);
    Frame.Size = UDim2.new(1, -32, 1, -48);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p117;
    local u118 = "side";
    local u119 = nil;

    local function rebuild() -- Line: 1391
        -- upvalues: Frame (copy), TaskController (copy), u119 (ref), buildSidebar (ref), u118 (ref), rebuild (copy), buildTaskList (ref), success (ref), result (ref), buildMainDetail (ref), buildDailyDetail (ref), buildDetail (ref)
        for _, child in ipairs(Frame:GetChildren()) do
            child:Destroy();
        end;

        local ActiveTasks = TaskController:GetActiveTasks();
        local PendingShares = TaskController:GetPendingShares();

        local function findPending(p120) -- Line: 1396
            -- upvalues: PendingShares (copy)
            for _, v in ipairs(PendingShares) do
                if v.task and v.task.id == p120 then
                    return v;
                end;
            end;

            return nil;
        end;

        local function isDailyIdValid(p121) -- Line: 1404
            -- upvalues: TaskController (ref)
            if type(p121) ~= "string" or p121:sub(1, 6) ~= "daily:" then
                return false;
            end;

            local v122 = tonumber(p121:sub(7));
            local v123 = TaskController.GetDailyTasks and TaskController:GetDailyTasks() or {};

            for _, v in ipairs(v123) do
                if (v.index or 0) == v122 then
                    return true;
                end;
            end;

            return false;
        end;

        local function findMain(p124) -- Line: 1416
            -- upvalues: TaskController (ref)
            if type(p124) ~= "string" or p124:sub(1, 5) ~= "main:" then
                return nil;
            end;

            local v125 = p124:sub(6);
            local v126 = TaskController.GetMain and TaskController:GetMain() or nil;

            if not v126 then
                return nil;
            end;

            if v126.active and v126.active.id == v125 then
                return v126.active;
            end;

            for _, v in ipairs(v126.available or {}) do
                if v.id == v125 then
                    return v;
                end;
            end;

            return nil;
        end;

        if u119 and not TaskController:GetTask(u119) then
            local v127 = u119;
            local v128 = nil;

            for _, v in ipairs(PendingShares) do
                if v.task and v.task.id == v127 then
                    v128 = v;
                    break;
                end;
            end;

            if not (v128 or (isDailyIdValid(u119) or findMain(u119))) then
                u119 = nil;
            end;
        end;

        buildSidebar(Frame, u118, function(p129) -- Line: 1433
            -- upvalues: u118 (ref), rebuild (ref)
            u118 = p129;
            rebuild();
        end);
        buildTaskList(Frame, ActiveTasks, PendingShares, u118, u119, function(p130) -- Line: 1437
            -- upvalues: success (ref), result (ref), u119 (ref), rebuild (ref)
            if success and result then
                result.PlayClick(5);
            end;

            u119 = p130.id;
            rebuild();
        end);
        local v131 = findMain(u119);

        if v131 then
            buildMainDetail(Frame, v131);

            return;
        end;

        local v132 = nil;

        if u119 and (type(u119) == "string" and u119:sub(1, 6) == "daily:") then
            local v133 = tonumber(u119:sub(7));
            local v134 = TaskController.GetDailyTasks and TaskController:GetDailyTasks() or {};

            for _, v in ipairs(v134) do
                if (v.index or 0) == v133 then
                    v132 = v;
                    break;
                end;
            end;
        end;

        if v132 then
            buildDailyDetail(Frame, v132);

            return;
        end;

        local v135 = u119 and TaskController:GetTask(u119) or nil;
        local v136;

        if v135 or not u119 then
            v136 = nil;
        else
            local v137 = u119;
            v136 = nil;

            for _, v in ipairs(PendingShares) do
                if v.task and v.task.id == v137 then
                    v136 = v;
                    break;
                end;
            end;

            if not v136 then
                v136 = nil;
            end;
        end;

        if v136 then
            buildDetail(Frame, v136.task, {
                pending = true,

                onAccept = function(p138) -- Line: 1468, Name: onAccept
                    -- upvalues: TaskController (ref), u119 (ref), rebuild (ref)
                    local v139 = TaskController:AcceptShare(p138.id);

                    if v139 and v139.ok then
                        u119 = p138.id;
                        TaskController:ShowToast("Accepted: " .. (p138.title or "Task"));
                    else
                        TaskController:ShowToast(({
                            share_expired = "That shared task is no longer available",
                            share_gone = "That shared task is no longer available",
                            task_cap_reached = "Too many active tasks"
                        })[v139 and v139.error or "unknown"] or "Couldn\'t accept shared task");
                    end;

                    rebuild();
                end,

                onDecline = function(p140) -- Line: 1483, Name: onDecline
                    -- upvalues: TaskController (ref), u119 (ref), rebuild (ref)
                    TaskController:DeclineShare(p140.id);
                    u119 = nil;
                    rebuild();
                end
            });

            return;
        end;

        buildDetail(Frame, v135, {
            onShare = function(p141) -- Line: 1491, Name: onShare
                -- upvalues: TaskController (ref)
                local v142 = TaskController:Share(p141.id);

                if v142 and v142.ok then
                    TaskController:ShowToast(v142.recipients and (v142.recipients > 0 and "Shared with " .. v142.recipients .. " squadmate(s)") or "No squadmates online to share with");

                    return;
                end;

                TaskController:ShowToast("Couldn\'t share task");
            end,

            onAbandon = function(p143) -- Line: 1501, Name: onAbandon
                -- upvalues: TaskController (ref)
                TaskController:Abandon(p143.id);
            end
        });
    end;

    rebuild();
    TaskController:OnChanged(rebuild);
    TaskController:OnSharesChanged(rebuild);

    if TaskController.OnMainChanged then
        TaskController:OnMainChanged(function() -- Line: 1511
            -- upvalues: rebuild (copy)
            rebuild();
        end);
    end;

    TaskController:OnPinnedChanged(function() -- Line: 1514
        -- upvalues: rebuild (copy)
        rebuild();
    end);

    if TaskController.OnDailyChanged then
        TaskController:OnDailyChanged(function() -- Line: 1515
            -- upvalues: rebuild (copy)
            rebuild();
        end);
    end;
end;

return v2;