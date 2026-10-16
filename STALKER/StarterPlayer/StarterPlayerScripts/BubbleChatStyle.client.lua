-- Decompiled with Potassium's decompiler.

local TextChatService = game:GetService("TextChatService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Color3_fromRGB_ret = Color3.fromRGB(15, 15, 15);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 220, 200);
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Medium);
local UDim_new_ret = UDim.new(0, 4);

local function suppressDefault(u1) -- Line: 34
    u1.Enabled = false;
    u1:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 36
        -- upvalues: u1 (copy)
        if u1.Enabled then
            u1.Enabled = false;
        end;
    end);
end;

local BubbleChatConfiguration = TextChatService:WaitForChild("BubbleChatConfiguration");
BubbleChatConfiguration.Enabled = false;
BubbleChatConfiguration:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 36
    -- upvalues: BubbleChatConfiguration (copy)
    if BubbleChatConfiguration.Enabled then
        BubbleChatConfiguration.Enabled = false;
    end;
end);
TextChatService.ChildAdded:Connect(function(u2) -- Line: 43
    if u2:IsA("BubbleChatConfiguration") then
        u2.Enabled = false;
        u2:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 36
            -- upvalues: u2 (copy)
            if u2.Enabled then
                u2.Enabled = false;
            end;
        end);
    end;
end);
local u3 = {};

local function ensureContainer(p4, p5) -- Line: 51
    -- upvalues: u3 (copy)
    if p4 then
        p4 = p4:FindFirstChild("HumanoidRootPart");
    end;

    if not p4 then
        return nil;
    end;

    local v6 = u3[p5];

    if v6 and (v6.gui.Parent and v6.gui.Adornee == p4) then
        return v6;
    end;

    if v6 and v6.gui then
        v6.gui:Destroy();
    end;

    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "CustomBubbleChat";
    BillboardGui.Adornee = p4;
    BillboardGui.Size = UDim2.fromOffset(360, 200);
    BillboardGui.StudsOffset = Vector3.new(0, 4.6, 0);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.LightInfluence = 0;
    BillboardGui.ClipsDescendants = false;
    BillboardGui.ResetOnSpawn = false;
    BillboardGui.Parent = p4;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 4);
    UIListLayout.Parent = BillboardGui;
    local v7 = {
        nextOrder = 0,
        gui = BillboardGui,
        list = {}
    };
    u3[p5] = v7;

    return v7;
end;

local function buildBubble(p8) -- Line: 83
    -- upvalues: Color3_fromRGB_ret (copy), UDim_new_ret (copy), Color3_fromRGB_ret2 (copy), Font_new_ret (copy)
    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3_fromRGB_ret;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.AutomaticSize = Enum.AutomaticSize.XY;
    Frame.Size = UDim2.fromOffset(0, 0);
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim_new_ret;
    UICorner.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 10);
    UIPadding.PaddingRight = UDim.new(0, 10);
    UIPadding.PaddingTop = UDim.new(0, 6);
    UIPadding.PaddingBottom = UDim.new(0, 6);
    UIPadding.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Text";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextColor3 = Color3_fromRGB_ret2;
    TextLabel.TextSize = 18;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextTransparency = 1;
    TextLabel.TextWrapped = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
    TextLabel.Size = UDim2.fromOffset(0, 0);
    local UISizeConstraint = Instance.new("UISizeConstraint");
    UISizeConstraint.MaxSize = Vector2.new(340, (1 / 0));
    UISizeConstraint.Parent = TextLabel;
    TextLabel.Text = p8;
    TextLabel.Parent = Frame;

    return Frame, TextLabel;
end;

local function trim(p9) -- Line: 119
    while #p9.list > 3 do
        local table_remove_ret = table.remove(p9.list, 1);

        if table_remove_ret then
            table_remove_ret:Destroy();
        end;
    end;
end;

local function spawnBubble(u10, p11) -- Line: 126
    -- upvalues: buildBubble (copy), trim (copy), TweenService (copy)
    local u12, u13 = buildBubble(p11);
    u10.nextOrder = u10.nextOrder + 1;
    u12.LayoutOrder = u10.nextOrder;
    u12.Parent = u10.gui;
    table.insert(u10.list, u12);
    trim(u10);
    local v14 = TweenService:Create(u12, TweenInfo.new(0.25), {
        BackgroundTransparency = 0.2
    });
    local v15 = TweenService:Create(u13, TweenInfo.new(0.25), {
        TextTransparency = 0
    });
    v14:Play();
    v15:Play();
    task.delay(8, function() -- Line: 136
        -- upvalues: u12 (copy), TweenService (ref), u13 (copy), u10 (copy)
        if not u12.Parent then
            return;
        end;

        local v16 = TweenService:Create(u12, TweenInfo.new(0.25), {
            BackgroundTransparency = 1
        });
        local v17 = TweenService:Create(u13, TweenInfo.new(0.25), {
            TextTransparency = 1
        });
        v16:Play();
        v17:Play();
        v16.Completed:Wait();

        if not u12.Parent then
            return;
        end;

        for i, v in ipairs(u10.list) do
            if v == u12 then
                table.remove(u10.list, i);
                break;
            end;
        end;

        u12:Destroy();
    end);
end;

local function onMessage(p18) -- Line: 150
    -- upvalues: Players (copy), ensureContainer (copy), ReplicatedStorage (copy), spawnBubble (copy)
    if not (p18 and p18.TextSource) then
        return;
    end;

    local Status = p18.Status;

    if Status == Enum.TextChatMessageStatus.InvalidTextChannelPermissions or (Status == Enum.TextChatMessageStatus.TextFilterFailed or Status == Enum.TextChatMessageStatus.Floodchecked) then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p18.TextSource.UserId);

    if not PlayerByUserId then
        return;
    end;

    local Character = PlayerByUserId.Character;

    if not Character then
        return;
    end;

    local Text = p18.Text;

    if not Text or Text == "" then
        return;
    end;

    local v19 = ensureContainer(Character, PlayerByUserId.UserId);

    if not v19 then
        return;
    end;

    if PlayerByUserId == Players.LocalPlayer then
        task.spawn(function() -- Line: 179
            -- upvalues: ReplicatedStorage (ref), Text (copy), ensureContainer (ref), PlayerByUserId (copy), spawnBubble (ref)
            local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

            if Remotes then
                Remotes = Remotes:FindFirstChild("FilterSelfChat");
            end;

            local v20 = Text;
            local v21;

            if Remotes then
                local v22;
                v22, v21 = pcall(function() -- Line: 184
                    -- upvalues: Remotes (copy), Text (ref)
                    return Remotes:InvokeServer(Text);
                end);

                if v22 and typeof(v21) == "string" then
                    if v21 == "" then
                        v21 = v20;
                    end;
                else
                    v21 = v20;
                end;
            else
                v21 = v20;
            end;

            local v23 = ensureContainer(PlayerByUserId.Character, PlayerByUserId.UserId);

            if v23 then
                spawnBubble(v23, v21);
            end;
        end);

        return;
    end;

    spawnBubble(v19, Text);
end;

local TextChannels = TextChatService:WaitForChild("TextChannels");

local function hookChannel(p24) -- Line: 199
    -- upvalues: onMessage (copy)
    if p24:IsA("TextChannel") then
        p24.MessageReceived:Connect(onMessage);
    end;
end;

for _, child in ipairs(TextChannels:GetChildren()) do
    if child:IsA("TextChannel") then
        child.MessageReceived:Connect(onMessage);
    end;
end;

TextChannels.ChildAdded:Connect(hookChannel);
task.spawn(function() -- Line: 220
    -- upvalues: ReplicatedStorage (copy), ensureContainer (copy), spawnBubble (copy)
    local Remotes = ReplicatedStorage:WaitForChild("Remotes", 30);

    if Remotes then
        Remotes = Remotes:WaitForChild("SquadCallout", 30);
    end;

    if not Remotes then
        return;
    end;

    Remotes.OnClientEvent:Connect(function(p25, p26) -- Line: 224
        -- upvalues: ensureContainer (ref), spawnBubble (ref)
        if typeof(p25) ~= "Instance" or not p25:IsA("Player") then
            return;
        end;

        if type(p26) ~= "string" or p26 == "" then
            return;
        end;

        local Character = p25.Character;

        if not Character then
            return;
        end;

        local v27 = ensureContainer(Character, p25.UserId);

        if v27 then
            spawnBubble(v27, p26);
        end;
    end);
end);
Players.PlayerRemoving:Connect(function(p28) -- Line: 234
    -- upvalues: u3 (copy)
    local v29 = u3[p28.UserId];

    if v29 and v29.gui then
        v29.gui:Destroy();
    end;

    u3[p28.UserId] = nil;
end);
game:GetService("RunService").Heartbeat:Connect(function() -- Line: 241
    -- upvalues: Players (copy), u3 (copy)
    local Character = Players.LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    for _, v in pairs(u3) do
        local v30 = v.gui and v.gui.Adornee;

        if v30 then
            local Magnitude = (v30.Position - Character.Position).Magnitude;

            if Magnitude >= 80 then
                v.gui.Enabled = false;
            else
                v.gui.Enabled = true;

                if Magnitude > 60 then
                    local v31 = (Magnitude - 60) / 20;

                    for _, v2 in ipairs(v.list) do
                        if v2 and v2.Parent then
                            v2.BackgroundTransparency = 0.2 + 0.8 * v31;
                            local Text = v2:FindFirstChild("Text");

                            if Text then
                                Text.TextTransparency = v31;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end);