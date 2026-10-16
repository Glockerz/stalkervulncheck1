-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 220, 220);
local Color3_fromRGB_ret3 = Color3.fromRGB(150, 150, 150);
local Color3_fromRGB_ret4 = Color3.fromRGB(140, 200, 120);
local Color3_fromRGB_ret5 = Color3.fromRGB(225, 95, 95);
local Color3_fromRGB_ret6 = Color3.fromRGB(20, 22, 20);
local v1 = {
    _panel = nil,
    _timeLbl = nil,
    _current = nil
};

local function formatTime(p2) -- Line: 25
    if p2 <= 0 then
        return "00:00:00";
    end;

    local math_floor_ret = math.floor(p2 / 3600);
    local math_floor_ret2 = math.floor(p2 % 3600 / 60);

    return string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, p2 % 60);
end;

function v1._build(p3) -- Line: 33
    -- upvalues: LocalPlayer (copy), Color3_fromRGB_ret6 (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local TaskTrackerGui = PlayerGui:FindFirstChild("TaskTrackerGui");

    if TaskTrackerGui then
        TaskTrackerGui:Destroy();
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "TaskTrackerGui";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = false;
    ScreenGui.DisplayOrder = 6;
    ScreenGui.Parent = PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.Name = "Panel";
    Frame.AnchorPoint = Vector2.new(1, 0);
    Frame.Position = UDim2.new(1, -16, 0, 16);
    Frame.Size = UDim2.fromOffset(260, 40);
    Frame.AutomaticSize = Enum.AutomaticSize.Y;
    Frame.BackgroundColor3 = Color3_fromRGB_ret6;
    Frame.BackgroundTransparency = 0.2;
    Frame.BorderSizePixel = 0;
    Frame.Visible = false;
    Frame.Parent = ScreenGui;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 4);
    UICorner.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(70, 75, 70);
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 8);
    UIPadding.PaddingBottom = UDim.new(0, 8);
    UIPadding.PaddingLeft = UDim.new(0, 10);
    UIPadding.PaddingRight = UDim.new(0, 10);
    UIPadding.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 3);
    UIListLayout.Parent = Frame;
    p3._panel = Frame;
end;

function v1._clear(p4) -- Line: 72
    for _, child in ipairs(p4._panel:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy();
        end;
    end;

    p4._timeLbl = nil;
end;

function v1._updateTime(p5, p6) -- Line: 79
    -- upvalues: Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret3 (copy)
    if not p5._timeLbl then
        return;
    end;

    local v7 = p6 and p6.timing and p6.timing.deadline_at;

    if not v7 then
        p5._timeLbl.Text = "";

        return;
    end;

    local v8 = v7 - os.time();
    local _timeLbl = p5._timeLbl;
    local v9;

    if v8 <= 0 then
        v9 = "00:00:00";
    else
        local math_floor_ret = math.floor(v8 / 3600);
        local math_floor_ret2 = math.floor(v8 % 3600 / 60);
        v9 = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, v8 % 60);
    end;

    _timeLbl.Text = "⧖ " .. v9;
    p5._timeLbl.TextColor3 = v8 < 300 and Color3_fromRGB_ret5 or Color3_fromRGB_ret3;
end;

function v1._render(p10, p11) -- Line: 88
    -- upvalues: Font_new_ret2 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret2 (copy), Font_new_ret3 (copy)
    if not p10._panel then
        return;
    end;

    if not p11 then
        p10._panel.Visible = false;
        p10._current = nil;

        return;
    end;

    p10._current = p11;
    p10._panel.Visible = true;
    p10:_clear();
    local u12 = 0;

    local function nextOrder() -- Line: 96
        -- upvalues: u12 (ref)
        u12 = u12 + 1;

        return u12;
    end;

    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, 0, 0, 12);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 10;
    TextLabel.TextColor3 = Color3_fromRGB_ret3;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "TRACKING";
    u12 = u12 + 1;
    TextLabel.LayoutOrder = u12;
    TextLabel.Parent = p10._panel;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.new(1, 0, 0, 18);
    TextLabel2.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret;
    TextLabel2.TextSize = 15;
    TextLabel2.TextColor3 = Color3_fromRGB_ret;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextWrapped = true;
    TextLabel2.Text = p11.title or "Task";
    u12 = u12 + 1;
    TextLabel2.LayoutOrder = u12;
    TextLabel2.Parent = p10._panel;

    for _, v in ipairs(p11.objectives or {}) do
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.Size = UDim2.new(1, 0, 0, 14);
        TextLabel3.AutomaticSize = Enum.AutomaticSize.Y;
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = Font_new_ret2;
        TextLabel3.TextSize = 13;
        TextLabel3.TextColor3 = v.complete and Color3_fromRGB_ret4 or Color3_fromRGB_ret2;
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.TextWrapped = true;
        local v13 = v.complete and "✓" or "•";
        local v14 = v.text or "";

        if v.target and v.progress ~= nil then
            v14 = v14 .. string.format(" [%d/%d]", v.progress, v.target);
        end;

        TextLabel3.Text = v13 .. " " .. v14;
        u12 = u12 + 1;
        TextLabel3.LayoutOrder = u12;
        TextLabel3.Parent = p10._panel;
    end;

    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Size = UDim2.new(1, 0, 0, 14);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret3;
    TextLabel3.TextSize = 12;
    TextLabel3.TextColor3 = Color3_fromRGB_ret3;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    u12 = u12 + 1;
    TextLabel3.LayoutOrder = u12;
    TextLabel3.Parent = p10._panel;
    p10._timeLbl = TextLabel3;
    p10:_updateTime(p11);
end;

function v1.Init(u15) -- Line: 155
    -- upvalues: ReplicatedStorage (copy)
    u15:_build();
    local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));

    local function refresh() -- Line: 158
        -- upvalues: u15 (copy), TaskController (copy)
        u15:_render(TaskController:GetPinnedTask());
    end;

    TaskController:OnPinnedChanged(refresh);
    TaskController:OnChanged(refresh);

    if TaskController.OnMainChanged then
        TaskController:OnMainChanged(refresh);
    end;

    task.spawn(function() -- Line: 168
        -- upvalues: u15 (copy)
        while true do
            repeat
                task.wait(1);
            until u15._current and (u15._timeLbl and u15._timeLbl.Parent);

            u15:_updateTime(u15._current);
        end;
    end);
    print("[TaskTrackerController] initialized");
end;

return v1;