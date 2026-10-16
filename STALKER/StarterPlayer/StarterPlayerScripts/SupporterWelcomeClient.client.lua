-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local RequestSupporterWelcome = Remotes:WaitForChild("RequestSupporterWelcome", 30);
local SubmitSupporterWelcomeAck = Remotes:WaitForChild("SubmitSupporterWelcomeAck", 30);

if not (RequestSupporterWelcome and SubmitSupporterWelcomeAck) then
    warn("[SupporterWelcome] remotes missing");

    return;
end;

local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);

local function tryReq(p1) -- Line: 37
    -- upvalues: ReplicatedStorage (copy)
    local v2 = ReplicatedStorage:WaitForChild(p1, 10);

    if not v2 then
        return nil;
    end;

    local success, result = pcall(require, v2);

    return success and result and result or nil;
end;

local SupporterCatalog = ReplicatedStorage:WaitForChild("SupporterCatalog", 10);
local u3;

if SupporterCatalog then
    local success, result = pcall(require, SupporterCatalog);
    u3 = success and result or nil;
else
    u3 = nil;
end;

local LootConfig = ReplicatedStorage:WaitForChild("LootConfig", 10);
local u4;

if LootConfig then
    local success, result = pcall(require, LootConfig);
    u4 = success and result or nil;
else
    u4 = nil;
end;

local ItemDatabase = ReplicatedStorage:WaitForChild("ItemDatabase", 10);
local u5;

if ItemDatabase then
    local success, result = pcall(require, ItemDatabase);
    u5 = success and result or nil;
else
    u5 = nil;
end;

local StashTierConfig = ReplicatedStorage:WaitForChild("StashTierConfig", 10);
local u6;

if StashTierConfig then
    local success, result = pcall(require, StashTierConfig);
    u6 = success and result or nil;
else
    u6 = nil;
end;

local SkinCatalog = ReplicatedStorage:WaitForChild("SkinCatalog", 10);
local u7;

if SkinCatalog then
    local success, result = pcall(require, SkinCatalog);
    u7 = success and result or nil;
else
    u7 = nil;
end;

local u8 = false;

local function summarizeLoadout(p9) -- Line: 54
    -- upvalues: u5 (ref)
    local v10 = {};
    local v11 = {};

    for _, v in ipairs(p9) do
        if v.ID then
            if v10[v.ID] == nil then
                v10[v.ID] = 0;
                table.insert(v11, v.ID);
            end;

            v10[v.ID] = v10[v.ID] + 1;
        end;
    end;

    local v12 = {};

    for _, v in ipairs(v11) do
        local v13 = u5 and u5.GetItemData and u5.GetItemData(v);
        local v14;

        if v13 then
            v14 = v13.Name or v;
        else
            v14 = v;
        end;

        local v15 = v10[v];
        table.insert(v12, (v15 > 1 and v15 .. "x " or "") .. v14);
    end;

    return v12;
end;

local function stashSizeFor(p16) -- Line: 75
    -- upvalues: u6 (ref)
    if not (u6 and u6.GetSizeForTier) then
        return nil;
    end;

    local SizeForTier = u6.GetSizeForTier(p16);

    if SizeForTier then
        return string.format("Tier %d — %dx%d (%d slots)", p16, SizeForTier.X, SizeForTier.Y, SizeForTier.X * SizeForTier.Y);
    end;

    return nil;
end;

local function buildSections(p17) -- Line: 83
    -- upvalues: u3 (ref), u6 (ref), u4 (ref), summarizeLoadout (copy), u7 (ref), u5 (ref)
    local v18 = u3 and u3.Tiers and u3.Tiers[p17];

    if not v18 then
        return {}, v18;
    end;

    local v19 = {};
    local v20 = v18.StashTierBonus or 0;
    local v21;

    if u6 and u6.GetSizeForTier then
        local SizeForTier = u6.GetSizeForTier(v20);

        if SizeForTier then
            v21 = string.format("Tier %d — %dx%d (%d slots)", v20, SizeForTier.X, SizeForTier.Y, SizeForTier.X * SizeForTier.Y);
        else
            v21 = nil;
        end;
    else
        v21 = nil;
    end;

    if v21 then
        table.insert(v19, {
            title = "PERSONAL STASH",
            bullets = { v21 .. "  (wipe-safe)" }
        });
    end;

    table.insert(v19, {
        title = "CHAT IDENTITY",
        bullets = { (v18.ChatPrefix or "[]") .. "  prefix + tier-colored nameplate" }
    });
    local v22 = u4 and (u4.Respawn and u4.Respawn.SupporterLoadouts) and u4.Respawn.SupporterLoadouts[v18.LoadoutKey];

    if v22 then
        local v23 = {
            title = "INSURANCE KIT (on every respawn)",
            bullets = summarizeLoadout(v22)
        };
        table.insert(v19, v23);
    end;

    if v18.UniformPacks and #v18.UniformPacks > 0 then
        local v24 = {};

        for _, v in ipairs(v18.UniformPacks) do
            local v25 = u7 and u7.Packs and u7.Packs[v];
            local v26;

            if v25 then
                v26 = v25.DisplayName or v;
            else
                v26 = v;
            end;

            table.insert(v24, v26);
        end;

        if p17 == "MasterStalker" then
            table.insert(v24, "+ Any future faction uniform packs unlock automatically");
        end;

        table.insert(v19, {
            title = "UNIFORM PACKS UNLOCKED",
            bullets = v24
        });
    elseif p17 == "Veteran" then
        table.insert(v19, {
            title = "UNIFORM PACK",
            bullets = { "Pick 1 faction\'s uniforms after this (Mercenary / Duty / Freedom)." }
        });
    end;

    local function slotLabel(p27) -- Line: 144
        return p27 == "Uniform" and "uniform skin" or (p27 == "BodyGear" and "BodyGear skin" or (p27 == "HeadGear" and "helmet skin" or (p27 == "FaceWear" and "mask skin" or (p27 == "Backpack" and "backpack skin" or "skin"))));
    end;

    if v18.ExclusiveSkins and #v18.ExclusiveSkins > 0 then
        local v28 = {};

        for _, v in ipairs(v18.ExclusiveSkins) do
            local v29 = u5 and u5.GetItemData and u5.GetItemData(v);
            local v30;

            if v29 then
                v30 = v29.Name or v;
            else
                v30 = v;
            end;

            if v29 then
                v29 = v29.ItemType;
            end;

            table.insert(v28, v30 .. "  (" .. (v29 == "Uniform" and "uniform skin" or (v29 == "BodyGear" and "BodyGear skin" or (v29 == "HeadGear" and "helmet skin" or (v29 == "FaceWear" and "mask skin" or (v29 == "Backpack" and "backpack skin" or "skin"))))) .. ")");
        end;

        table.insert(v19, {
            title = "EXCLUSIVE ITEMS",
            bullets = v28
        });
    end;

    table.insert(v19, {
        title = "BADGE + COMMUNITY",
        bullets = { "\'" .. v18.DisplayName .. "\' Roblox badge", "Discord \'" .. v18.DisplayName .. "\' role" }
    });

    return v19, v18;
end;

local function beginMouseUnlock() -- Line: 184
    -- upvalues: RunService (copy), UserInputService (copy)
    pcall(function() -- Line: 185
        -- upvalues: RunService (ref), UserInputService (ref)
        RunService:BindToRenderStep("_SupporterWelcomeMouseUnlock", Enum.RenderPriority.Last.Value, function() -- Line: 186
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

local function endMouseUnlock() -- Line: 197
    -- upvalues: RunService (copy)
    pcall(function() -- Line: 198
        -- upvalues: RunService (ref)
        RunService:UnbindFromRenderStep("_SupporterWelcomeMouseUnlock");
    end);
end;

RequestSupporterWelcome.OnClientEvent:Connect(function(u31) -- Line: 201, Name: showWelcome
    -- upvalues: u8 (ref), buildSections (copy), SubmitSupporterWelcomeAck (copy), RunService (copy), UserInputService (copy), PlayerGui (copy), Font_new_ret (copy), Font_new_ret2 (copy)
    if u8 then
        return;
    end;

    u8 = true;
    local v32, v33 = buildSections(u31);

    if not v33 then
        u8 = false;
        SubmitSupporterWelcomeAck:FireServer(u31);

        return;
    end;

    pcall(function() -- Line: 185
        -- upvalues: RunService (ref), UserInputService (ref)
        RunService:BindToRenderStep("_SupporterWelcomeMouseUnlock", Enum.RenderPriority.Last.Value, function() -- Line: 186
            -- upvalues: UserInputService (ref)
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            end;

            if not UserInputService.MouseIconEnabled then
                UserInputService.MouseIconEnabled = true;
            end;
        end);
    end);
    local v34 = v33.ChatColor or Color3.fromRGB(220, 220, 220);
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "SupporterWelcome";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 210;
    ScreenGui.Parent = PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Frame.BackgroundTransparency = 0.35;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 1;
    Frame.Parent = ScreenGui;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.fromOffset(560, 580);
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
    local Frame3 = Instance.new("Frame");
    Frame3.AnchorPoint = Vector2.new(0.5, 0);
    Frame3.Position = UDim2.new(0.5, 0, 0, 0);
    Frame3.Size = UDim2.new(1, 0, 0, 3);
    Frame3.BackgroundColor3 = v34;
    Frame3.BorderSizePixel = 0;
    Frame3.ZIndex = 3;
    Frame3.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, 0, 0, 16);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "SUPPORTER TIER UNLOCKED";
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 12;
    TextLabel.TextColor3 = Color3.fromRGB(150, 150, 150);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.ZIndex = 3;
    TextLabel.Parent = Frame2;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.new(1, 0, 0, 40);
    TextLabel2.Position = UDim2.fromOffset(0, 20);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = string.upper(v33.DisplayName or u31);
    TextLabel2.FontFace = Font_new_ret;
    TextLabel2.TextSize = 32;
    TextLabel2.TextColor3 = v34;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.ZIndex = 3;
    TextLabel2.Parent = Frame2;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Size = UDim2.new(1, 0, 0, 20);
    TextLabel3.Position = UDim2.fromOffset(0, 62);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.Text = "Thank you for supporting Zone STALKER. Here\'s what you get:";
    TextLabel3.FontFace = Font_new_ret2;
    TextLabel3.TextSize = 14;
    TextLabel3.TextColor3 = Color3.fromRGB(190, 190, 190);
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.ZIndex = 3;
    TextLabel3.Parent = Frame2;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Size = UDim2.new(1, 0, 1, -156);
    ScrollingFrame.Position = UDim2.fromOffset(0, 92);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.CanvasSize = UDim2.new();
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120);
    ScrollingFrame.ZIndex = 3;
    ScrollingFrame.Parent = Frame2;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 16);
    UIListLayout.Parent = ScrollingFrame;

    for i, v in ipairs(v32) do
        local Frame4 = Instance.new("Frame");
        Frame4.Size = UDim2.new(1, -8, 0, 0);
        Frame4.AutomaticSize = Enum.AutomaticSize.Y;
        Frame4.BackgroundTransparency = 1;
        Frame4.LayoutOrder = i;
        Frame4.ZIndex = 3;
        Frame4.Parent = ScrollingFrame;
        local UIListLayout2 = Instance.new("UIListLayout");
        UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout2.Padding = UDim.new(0, 4);
        UIListLayout2.Parent = Frame4;
        local TextLabel4 = Instance.new("TextLabel");
        TextLabel4.Size = UDim2.new(1, 0, 0, 18);
        TextLabel4.BackgroundTransparency = 1;
        TextLabel4.Text = v.title;
        TextLabel4.FontFace = Font_new_ret;
        TextLabel4.TextSize = 13;
        TextLabel4.TextColor3 = v34;
        TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel4.LayoutOrder = 1;
        TextLabel4.ZIndex = 3;
        TextLabel4.Parent = Frame4;

        for i2, v2 in ipairs(v.bullets) do
            local TextLabel5 = Instance.new("TextLabel");
            TextLabel5.Size = UDim2.new(1, 0, 0, 22);
            TextLabel5.AutomaticSize = Enum.AutomaticSize.Y;
            TextLabel5.BackgroundTransparency = 1;
            TextLabel5.Text = "• " .. v2;
            TextLabel5.FontFace = Font_new_ret2;
            TextLabel5.TextSize = 15;
            TextLabel5.TextColor3 = Color3.fromRGB(230, 230, 230);
            TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel5.TextYAlignment = Enum.TextYAlignment.Top;
            TextLabel5.TextWrapped = true;
            TextLabel5.LayoutOrder = 1 + i2;
            TextLabel5.ZIndex = 3;
            TextLabel5.Parent = Frame4;
        end;
    end;

    local TextButton = Instance.new("TextButton");
    TextButton.Size = UDim2.fromOffset(200, 40);
    TextButton.AnchorPoint = Vector2.new(1, 1);
    TextButton.Position = UDim2.new(1, 0, 1, 0);
    TextButton.BackgroundColor3 = Color3.fromRGB(45, 55, 40);
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = false;
    TextButton.Text = "CONTINUE";
    TextButton.FontFace = Font_new_ret;
    TextButton.TextSize = 18;
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextButton.ZIndex = 4;
    TextButton.Parent = Frame2;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = v34;
    UIStroke2.Thickness = 1;
    UIStroke2.Parent = TextButton;
    TextButton.MouseButton1Click:Connect(function() -- Line: 387
        -- upvalues: SubmitSupporterWelcomeAck (ref), u31 (copy), RunService (ref), u8 (ref), ScreenGui (copy)
        SubmitSupporterWelcomeAck:FireServer(u31);
        pcall(function() -- Line: 198
            -- upvalues: RunService (ref)
            RunService:UnbindFromRenderStep("_SupporterWelcomeMouseUnlock");
        end);
        u8 = false;
        ScreenGui:Destroy();
    end);
end);
print("[SupporterWelcomeClient] ready");