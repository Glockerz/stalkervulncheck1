-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local RequestVeteranFactionPick = Remotes:WaitForChild("RequestVeteranFactionPick", 30);
local SubmitVeteranFactionPick = Remotes:WaitForChild("SubmitVeteranFactionPick", 30);

if not (RequestVeteranFactionPick and SubmitVeteranFactionPick) then
    warn("[VeteranFactionPicker] remotes missing");

    return;
end;

local v1 = nil;
local success, result = pcall(function() -- Line: 35
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("SkinCatalog", 10));
end);

if not success then
    result = nil;
end;

local success2, result2 = pcall(function() -- Line: 37
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("ItemDatabase", 10));
end);

if not success2 then
    result2 = v1;
end;

local function getPackUniformNames(p2) -- Line: 41
    -- upvalues: result (ref), result2 (ref)
    if not (result and result.Packs) then
        return {};
    end;

    local v3 = result.Packs[p2];

    if not (v3 and v3.Skins) then
        return {};
    end;

    local v4 = {};

    for _, v in ipairs(v3.Skins) do
        local v5 = result2 and result2.GetItemData and result2.GetItemData(v);
        local v6;

        if v5 then
            v6 = v5.Name or v;
        else
            v6 = v;
        end;

        table.insert(v4, v6);
    end;

    return v4;
end;

local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local u7 = {
    {
        key = "MercenaryFactionUniforms",
        name = "MERCENARY",
        tagline = "Earn your pay.",
        tint = Color3.fromRGB(60, 80, 100),
        accent = Color3.fromRGB(120, 150, 175)
    },
    {
        key = "DutyFactionUniforms",
        name = "DUTY",
        tagline = "The Zone must be destroyed.",
        tint = Color3.fromRGB(110, 40, 40),
        accent = Color3.fromRGB(200, 90, 80)
    },
    {
        key = "FreedomFactionUniforms",
        name = "FREEDOM",
        tagline = "The Zone should be free.",
        tint = Color3.fromRGB(45, 90, 45),
        accent = Color3.fromRGB(120, 200, 100)
    }
};
local u8 = false;

local function beginMouseUnlock() -- Line: 84
    -- upvalues: RunService (copy), UserInputService (copy)
    pcall(function() -- Line: 85
        -- upvalues: RunService (ref), UserInputService (ref)
        RunService:BindToRenderStep("_VeteranFactionPickerMouseUnlock", Enum.RenderPriority.Last.Value, function() -- Line: 86
            -- upvalues: UserInputService (ref)
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            end;

            if not UserInputService.MouseIconEnabled then
                UserInputService.MouseIconEnabled = true;
            end;
        end);
    end);
end;

local function endMouseUnlock() -- Line: 97
    -- upvalues: RunService (copy)
    pcall(function() -- Line: 98
        -- upvalues: RunService (ref)
        RunService:UnbindFromRenderStep("_VeteranFactionPickerMouseUnlock");
    end);
end;

RequestVeteranFactionPick.OnClientEvent:Connect(function() -- Line: 101, Name: showPicker
    -- upvalues: u8 (ref), RunService (copy), UserInputService (copy), PlayerGui (copy), Font_new_ret (copy), Font_new_ret3 (copy), u7 (copy), getPackUniformNames (copy), Font_new_ret2 (copy), SubmitVeteranFactionPick (copy)
    if u8 then
        return;
    end;

    u8 = true;
    pcall(function() -- Line: 85
        -- upvalues: RunService (ref), UserInputService (ref)
        RunService:BindToRenderStep("_VeteranFactionPickerMouseUnlock", Enum.RenderPriority.Last.Value, function() -- Line: 86
            -- upvalues: UserInputService (ref)
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            end;

            if not UserInputService.MouseIconEnabled then
                UserInputService.MouseIconEnabled = true;
            end;
        end);
    end);
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "VeteranFactionPicker";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 200;
    ScreenGui.Parent = PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Frame.BackgroundTransparency = 0.35;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 1;
    Frame.Parent = ScreenGui;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.fromOffset(720, 480);
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.Position = UDim2.fromScale(0.5, 0.5);
    Frame2.BackgroundColor3 = Color3.fromRGB(20, 22, 20);
    Frame2.BorderSizePixel = 0;
    Frame2.ZIndex = 2;
    Frame2.Parent = ScreenGui;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(90, 90, 90);
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame2;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 48, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 10)) });
    UIGradient.Rotation = -90;
    UIGradient.Parent = Frame2;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 24);
    UIPadding.PaddingBottom = UDim.new(0, 24);
    UIPadding.PaddingLeft = UDim.new(0, 28);
    UIPadding.PaddingRight = UDim.new(0, 28);
    UIPadding.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, 0, 0, 30);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "CHOOSE YOUR FACTION PACK";
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 26;
    TextLabel.TextColor3 = Color3.fromRGB(230, 230, 230);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.ZIndex = 3;
    TextLabel.Parent = Frame2;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.new(1, 0, 0, 40);
    TextLabel2.Position = UDim2.fromOffset(0, 34);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = "Veteran Pack: pick 1 faction. All uniforms in that faction unlock as skins.\nThis choice is PERMANENT and survives wipes.";
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 15;
    TextLabel2.TextColor3 = Color3.fromRGB(180, 180, 180);
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.TextWrapped = true;
    TextLabel2.ZIndex = 3;
    TextLabel2.Parent = Frame2;
    local Frame3 = Instance.new("Frame");
    Frame3.Size = UDim2.new(1, 0, 0, 280);
    Frame3.Position = UDim2.fromOffset(0, 88);
    Frame3.BackgroundTransparency = 1;
    Frame3.ZIndex = 3;
    Frame3.Parent = Frame2;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.Padding = UDim.new(0, 16);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = Frame3;

    local function styleCard(p9, p10) -- Line: 192
        p9.strokeInst.Color = p10 and p9.faction.accent or Color3.fromRGB(60, 60, 60);
        p9.strokeInst.Thickness = p10 and 3 or 1;
        p9.btn.BackgroundTransparency = p10 and 0 or 0.25;
    end;

    local v11 = {};
    local u12 = nil;

    for i, v in ipairs(u7) do
        local TextButton = Instance.new("TextButton");
        TextButton.Size = UDim2.new(0, 210, 1, 0);
        TextButton.BackgroundColor3 = v.tint;
        TextButton.BackgroundTransparency = 0.25;
        TextButton.AutoButtonColor = false;
        TextButton.Text = "";
        TextButton.BorderSizePixel = 0;
        TextButton.LayoutOrder = i;
        TextButton.ZIndex = 4;
        TextButton.Parent = Frame3;
        local UIStroke2 = Instance.new("UIStroke");
        UIStroke2.Color = Color3.fromRGB(60, 60, 60);
        UIStroke2.Thickness = 1;
        UIStroke2.Parent = TextButton;
        local UIGradient2 = Instance.new("UIGradient");
        UIGradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60)) });
        UIGradient2.Rotation = -90;
        UIGradient2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 0.15) });
        UIGradient2.Parent = TextButton;
        local Frame4 = Instance.new("Frame");
        Frame4.Size = UDim2.new(1, 0, 0, 4);
        Frame4.BackgroundColor3 = v.accent;
        Frame4.BorderSizePixel = 0;
        Frame4.ZIndex = 5;
        Frame4.Parent = TextButton;
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.Size = UDim2.new(1, -24, 0, 40);
        TextLabel3.Position = UDim2.fromOffset(12, 16);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.Text = v.name;
        TextLabel3.FontFace = Font_new_ret;
        TextLabel3.TextSize = 32;
        TextLabel3.TextColor3 = Color3.fromRGB(240, 240, 240);
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.ZIndex = 5;
        TextLabel3.Parent = TextButton;
        local TextLabel4 = Instance.new("TextLabel");
        TextLabel4.Size = UDim2.new(1, -24, 0, 22);
        TextLabel4.Position = UDim2.fromOffset(12, 58);
        TextLabel4.BackgroundTransparency = 1;
        TextLabel4.Text = v.tagline;
        TextLabel4.FontFace = Font_new_ret3;
        TextLabel4.TextSize = 14;
        TextLabel4.TextColor3 = Color3.fromRGB(200, 200, 200);
        TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel4.TextYAlignment = Enum.TextYAlignment.Top;
        TextLabel4.TextWrapped = true;
        TextLabel4.ZIndex = 5;
        TextLabel4.Parent = TextButton;
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.Size = UDim2.new(1, -24, 0, 16);
        TextLabel5.Position = UDim2.fromOffset(12, 96);
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.Text = "UNIFORMS INCLUDED";
        TextLabel5.FontFace = Font_new_ret;
        TextLabel5.TextSize = 11;
        TextLabel5.TextColor3 = v.accent;
        TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel5.ZIndex = 5;
        TextLabel5.Parent = TextButton;
        local Frame5 = Instance.new("Frame");
        Frame5.Size = UDim2.new(1, -24, 1, -128);
        Frame5.Position = UDim2.fromOffset(12, 116);
        Frame5.BackgroundTransparency = 1;
        Frame5.ZIndex = 5;
        Frame5.Parent = TextButton;
        local UIListLayout2 = Instance.new("UIListLayout");
        UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout2.Padding = UDim.new(0, 4);
        UIListLayout2.Parent = Frame5;
        local v13 = getPackUniformNames(v.key);
        local v14 = v;

        for i2, v2 in ipairs(v13) do
            local TextLabel6 = Instance.new("TextLabel");
            TextLabel6.Size = UDim2.new(1, 0, 0, 20);
            TextLabel6.BackgroundTransparency = 1;
            TextLabel6.Text = "• " .. v2;
            TextLabel6.FontFace = Font_new_ret2;
            TextLabel6.TextSize = 14;
            TextLabel6.TextColor3 = Color3.fromRGB(230, 230, 230);
            TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel6.TextTruncate = Enum.TextTruncate.AtEnd;
            TextLabel6.LayoutOrder = i2;
            TextLabel6.ZIndex = 5;
            TextLabel6.Parent = Frame5;
        end;

        local u15 = {
            btn = TextButton,
            strokeInst = UIStroke2,
            faction = v14
        };
        v11[v14.key] = u15;
        TextButton.MouseButton1Click:Connect(function() -- Line: 304
            -- upvalues: u12 (ref), u15 (copy)
            if u12 then
                local v16 = u12;
                v16.strokeInst.Color = Color3.fromRGB(60, 60, 60);
                v16.strokeInst.Thickness = 1;
                v16.btn.BackgroundTransparency = 0.25;
            end;

            u12 = u15;
            local v17 = u15;
            v17.strokeInst.Color = v17.faction.accent or Color3.fromRGB(60, 60, 60);
            v17.strokeInst.Thickness = 3;
            v17.btn.BackgroundTransparency = 0;
        end);
    end;

    local Frame4 = Instance.new("Frame");
    Frame4.Size = UDim2.new(1, 0, 0, 44);
    Frame4.AnchorPoint = Vector2.new(0, 1);
    Frame4.Position = UDim2.new(0, 0, 1, 0);
    Frame4.BackgroundTransparency = 1;
    Frame4.ZIndex = 3;
    Frame4.Parent = Frame2;
    local TextButton = Instance.new("TextButton");
    TextButton.Size = UDim2.fromOffset(200, 40);
    TextButton.AnchorPoint = Vector2.new(1, 0.5);
    TextButton.Position = UDim2.new(1, 0, 0.5, 0);
    TextButton.BackgroundColor3 = Color3.fromRGB(45, 55, 40);
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = false;
    TextButton.Text = "CONFIRM";
    TextButton.FontFace = Font_new_ret;
    TextButton.TextSize = 18;
    TextButton.TextColor3 = Color3.fromRGB(180, 180, 180);
    TextButton.ZIndex = 4;
    TextButton.Parent = Frame4;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3.fromRGB(60, 70, 55);
    UIStroke2.Thickness = 1;
    UIStroke2.Parent = TextButton;

    local function updateConfirmEnabled() -- Line: 339
        -- upvalues: u12 (ref), TextButton (copy), UIStroke2 (copy)
        if u12 then
            TextButton.BackgroundColor3 = Color3.fromRGB(80, 130, 70);
            TextButton.TextColor3 = Color3.fromRGB(255, 255, 255);
            UIStroke2.Color = Color3.fromRGB(140, 200, 130);

            return;
        end;

        TextButton.BackgroundColor3 = Color3.fromRGB(45, 55, 40);
        TextButton.TextColor3 = Color3.fromRGB(140, 140, 140);
        UIStroke2.Color = Color3.fromRGB(60, 70, 55);
    end;

    for _, v in pairs(v11) do
        v.btn.MouseButton1Click:Connect(updateConfirmEnabled);
    end;

    TextButton.MouseButton1Click:Connect(function() -- Line: 356
        -- upvalues: u12 (ref), SubmitVeteranFactionPick (ref), RunService (ref), u8 (ref), ScreenGui (copy)
        if not u12 then
            return;
        end;

        SubmitVeteranFactionPick:FireServer(u12.faction.key);
        pcall(function() -- Line: 98
            -- upvalues: RunService (ref)
            RunService:UnbindFromRenderStep("_VeteranFactionPickerMouseUnlock");
        end);
        u8 = false;
        ScreenGui:Destroy();
    end);
end);
print("[VeteranFactionPickerClient] ready");