-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local ItemIconStyle = require(ReplicatedStorage:WaitForChild("ItemIconStyle"));
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Color3_fromRGB_ret = Color3.fromRGB(24, 26, 24);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret3 = Color3.fromRGB(235, 235, 235);
local Color3_fromRGB_ret4 = Color3.fromRGB(70, 70, 70);
local u1 = { "Primary", "Secondary", "Sidearm", "Melee" };
local u2 = {
    Enum.KeyCode.One,
    Enum.KeyCode.Two,
    Enum.KeyCode.Three,
    Enum.KeyCode.Four
};
local u3 = {
    Enum.KeyCode.F1,
    Enum.KeyCode.F2,
    Enum.KeyCode.F3,
    Enum.KeyCode.F4
};
local u4 = { "TraderGui", "PdaGui", "InventoryGui", "PremiumVendorGui", "NpcInteractionGui", "TalkGui", "EmoteWheelGui" };
local v5 = {
    _gui = nil,
    _weaponSlots = {},
    _quickSlots = {},
    _started = false
};

local function getEquippedToolName() -- Line: 49
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    for _, child in ipairs(Character:GetChildren()) do
        if child:IsA("Tool") then
            return child.Name;
        end;
    end;

    return nil;
end;

local function findToolFor(p6) -- Line: 58
    -- upvalues: LocalPlayer (copy)
    if not p6 then
        return nil;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        local v7 = Character:FindFirstChild(p6);

        if v7 and v7:IsA("Tool") then
            return v7;
        end;
    end;

    local Backpack = LocalPlayer:FindFirstChild("Backpack");

    if Backpack then
        local v8 = Backpack:FindFirstChild(p6);

        if v8 and v8:IsA("Tool") then
            return v8;
        end;
    end;

    return nil;
end;

local function isBlocked() -- Line: 73
    -- upvalues: UserInputService (copy), LocalPlayer (copy), u4 (copy)
    if UserInputService:GetFocusedTextBox() then
        return true;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

    if PlayerGui then
        for _, v in ipairs(u4) do
            local v9 = PlayerGui:FindFirstChild(v);

            if v9 and (v9:IsA("ScreenGui") and v9.Enabled) then
                return true;
            end;
        end;
    end;

    return false;
end;

local u10 = 0;
Remotes.ItemUseStarted.OnClientEvent:Connect(function(p11, p12) -- Line: 101
    -- upvalues: u10 (ref)
    u10 = os.clock() + (tonumber(p12) or 4) + 0.5;
end);
Remotes.ItemUseStopped.OnClientEvent:Connect(function() -- Line: 104
    -- upvalues: u10 (ref)
    u10 = 0;
end);

local function handsBusy() -- Line: 108
    -- upvalues: u10 (ref)
    return os.clock() < u10;
end;

local function reloading() -- Line: 129
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:GetAttribute("_ReloadingUntil");
    end;

    local v13;

    if type(Character) == "number" then
        v13 = os.clock() < Character;
    else
        v13 = false;
    end;

    return v13;
end;

local function styleSlot(p14, p15) -- Line: 137
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy)
    p14.BackgroundColor3 = Color3_fromRGB_ret;
    p14.BackgroundTransparency = 0.25;
    p14.BorderSizePixel = 0;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 6);
    UICorner.Parent = p14;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p15 or Color3_fromRGB_ret4;
    UIStroke.Thickness = 1;
    UIStroke.Transparency = 0.4;
    UIStroke.Parent = p14;

    return UIStroke;
end;

function v5._buildWeaponBar(p16) -- Line: 152
    -- upvalues: u1 (copy), styleSlot (copy), Color3_fromRGB_ret4 (copy), ItemIconStyle (copy), Font_new_ret (copy), Color3_fromRGB_ret3 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "WeaponBar";
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.Position = UDim2.new(0.5, 0, 1, -12);
    Frame.Size = UDim2.fromOffset(#u1 * 60 + (#u1 - 1) * 8, 60);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p16._gui;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 8);
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.Parent = Frame;

    for i, v in ipairs(u1) do
        local Frame2 = Instance.new("Frame");
        Frame2.Name = v .. "Slot";
        Frame2.Size = UDim2.fromOffset(60, 60);
        Frame2.LayoutOrder = i;
        Frame2.BackgroundTransparency = 0.55;
        Frame2.Parent = Frame;
        local v17 = styleSlot(Frame2, Color3_fromRGB_ret4);
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Icon";
        ImageLabel.Size = UDim2.fromScale(0.82, 0.82);
        ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.ScaleType = ItemIconStyle.ScaleTypeFor(nil);
        ImageLabel.Image = "";
        ImageLabel.Visible = false;
        ImageLabel.Parent = Frame2;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "KeyNum";
        TextLabel.Size = UDim2.fromOffset(16, 16);
        TextLabel.Position = UDim2.new(0, 3, 0, 1);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = tostring(i);
        TextLabel.FontFace = Font_new_ret;
        TextLabel.TextSize = 14;
        TextLabel.TextColor3 = Color3_fromRGB_ret3;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.TextTransparency = 0.4;
        TextLabel.ZIndex = 3;
        TextLabel.Parent = Frame2;
        p16._weaponSlots[v] = {
            itemID = nil,
            toolName = nil,
            frame = Frame2,
            iconHost = ImageLabel,
            numberLabel = TextLabel,
            stroke = v17
        };
    end;
end;

function v5._buildQuickCluster(p18) -- Line: 212
    -- upvalues: styleSlot (copy), Color3_fromRGB_ret4 (copy), ItemIconStyle (copy), Font_new_ret (copy), Color3_fromRGB_ret3 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "QuickCluster";
    Frame.AnchorPoint = Vector2.new(1, 1);
    Frame.Position = UDim2.new(1, -16, 1, -12);
    Frame.Size = UDim2.fromOffset(210, 48);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p18._gui;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 6);
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.Parent = Frame;

    for i = 1, 4 do
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "Quick" .. i;
        Frame2.Size = UDim2.fromOffset(48, 48);
        Frame2.LayoutOrder = i;
        Frame2.BackgroundTransparency = 0.45;
        Frame2.Parent = Frame;
        local v19 = styleSlot(Frame2, Color3_fromRGB_ret4);
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Icon";
        ImageLabel.Size = UDim2.fromScale(0.82, 0.82);
        ImageLabel.Position = UDim2.fromScale(0.5, 0.45);
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.ScaleType = ItemIconStyle.ScaleTypeFor(nil);
        ImageLabel.Image = "";
        ImageLabel.Visible = false;
        ImageLabel.Parent = Frame2;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "KeyLabel";
        TextLabel.Size = UDim2.fromOffset(20, 14);
        TextLabel.Position = UDim2.new(0, 3, 0, 1);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = "F" .. i;
        TextLabel.FontFace = Font_new_ret;
        TextLabel.TextSize = 12;
        TextLabel.TextColor3 = Color3_fromRGB_ret3;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.TextTransparency = 0.25;
        TextLabel.ZIndex = 3;
        TextLabel.Parent = Frame2;
        p18._quickSlots[i] = {
            itemID = nil,
            frame = Frame2,
            icon = ImageLabel,
            keyLabel = TextLabel,
            stroke = v19
        };
        local _ = i;
    end;
end;

local function ensureGui(p20) -- Line: 267
    -- upvalues: LocalPlayer (copy)
    if p20._gui and p20._gui.Parent then
        return;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local Hotbar = PlayerGui:FindFirstChild("Hotbar");

    if Hotbar then
        Hotbar:Destroy();
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "Hotbar";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 8;
    ScreenGui.Parent = PlayerGui;
    p20._gui = ScreenGui;
    p20._weaponSlots = {};
    p20._quickSlots = {};
    p20:_buildWeaponBar();
    p20:_buildQuickCluster();
end;

function v5._setWeaponSlot(p21, p22, p23) -- Line: 287
    -- upvalues: ItemDatabase (copy), ItemIconStyle (copy)
    local v24 = p21._weaponSlots[p22];

    if not v24 then
        return;
    end;

    v24.itemID = p23;
    local ViewportIcon = v24.iconHost:FindFirstChild("ViewportIcon");

    if ViewportIcon then
        ViewportIcon:Destroy();
    end;

    if p23 then
        local ItemData = ItemDatabase.GetItemData(p23);
        local v25;

        if ItemData then
            v25 = ItemData.ToolName or nil;
        else
            v25 = nil;
        end;

        v24.toolName = v25;
        v24.iconHost.Image = ItemData and (ItemData.ImageID or "") or "";
        v24.iconHost.ScaleType = ItemIconStyle.ScaleTypeFor(ItemData);
        v24.iconHost.Visible = true;
        v24.frame.BackgroundTransparency = 0.25;
        v24.numberLabel.TextTransparency = 0;
    else
        v24.toolName = nil;
        v24.iconHost.Image = "";
        v24.iconHost.Visible = false;
        v24.frame.BackgroundTransparency = 0.55;
        v24.numberLabel.TextTransparency = 0.4;
    end;

    p21:_refreshWeaponHighlight();
end;

function v5._refreshWeaponHighlight(p26) -- Line: 313
    -- upvalues: getEquippedToolName (copy), u1 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret4 (copy)
    local v27 = getEquippedToolName();

    for _, v in ipairs(u1) do
        local v28 = p26._weaponSlots[v];

        if v28 then
            local v29;

            if v28.toolName == nil then
                v29 = false;
            else
                v29 = v28.toolName == v27;
            end;

            v28.stroke.Color = v29 and Color3_fromRGB_ret2 or Color3_fromRGB_ret4;
            v28.stroke.Thickness = v29 and 2 or 1;
            v28.stroke.Transparency = v29 and 0 or 0.4;
        end;
    end;
end;

function v5._drawWeapon(p30, p31) -- Line: 326
    -- upvalues: LocalPlayer (copy), u10 (ref), getEquippedToolName (copy), findToolFor (copy)
    local v32 = p30._weaponSlots[p31];

    if not (v32 and v32.toolName) then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if not Character or Character.Health <= 0 then
        return;
    end;

    if os.clock() < u10 and getEquippedToolName() ~= v32.toolName then
        return;
    end;

    local Character2 = LocalPlayer.Character;

    if Character2 then
        Character2 = Character2:GetAttribute("_ReloadingUntil");
    end;

    local v33;

    if type(Character2) == "number" then
        v33 = os.clock() < Character2;
    else
        v33 = false;
    end;

    if v33 then
        return;
    end;

    if getEquippedToolName() == v32.toolName then
        Character:UnequipTools();

        return;
    end;

    local v34 = findToolFor(v32.toolName);

    if v34 then
        Character:EquipTool(v34);
    end;
end;

function v5.SetQuickSlot(p35, p36, p37) -- Line: 350
    -- upvalues: ItemDatabase (copy), ItemIconStyle (copy)
    local v38 = p35._quickSlots[p36];

    if not v38 then
        return;
    end;

    if p37 then
        for i, v in pairs(p35._quickSlots) do
            if i ~= p36 and v.itemID == p37 then
                v.itemID = nil;
                v.icon.Image = "";
                v.icon.Visible = false;
            end;
        end;
    end;

    v38.itemID = p37;

    if p37 then
        local ItemData = ItemDatabase.GetItemData(p37);
        v38.icon.Image = ItemData and (ItemData.ImageID or "") or "";
        v38.icon.ScaleType = ItemIconStyle.ScaleTypeFor(ItemData);
        v38.icon.Visible = true;
    else
        v38.icon.Image = "";
        v38.icon.Visible = false;
    end;

    p35:RefreshQuickAvailability();
end;

function v5.RefreshQuickAvailability(p39) -- Line: 376
    -- upvalues: Remotes (copy), ItemDatabase (copy), ItemIconStyle (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret4 (copy)
    local success, result = pcall(function() -- Line: 377
        -- upvalues: Remotes (ref)
        return Remotes.GetQuickSlots:InvokeServer();
    end);

    if not success or type(result) ~= "table" then
        return;
    end;

    for i = 1, 4 do
        local v40 = p39._quickSlots[i];
        local v41;

        if v40 then
            local v42 = result[i] or result[tostring(i)];

            if v42 and v42.id then
                v40.itemID = v42.id;
                local ItemData = ItemDatabase.GetItemData(v42.id);
                v40.icon.Image = ItemData and (ItemData.ImageID or "") or "";
                v40.icon.ScaleType = ItemIconStyle.ScaleTypeFor(ItemData);
                v40.icon.Visible = true;
                v40.icon.ImageTransparency = v42.available and 0 or 0.65;
                v40.stroke.Color = v42.available and Color3_fromRGB_ret2 or Color3_fromRGB_ret4;
                v40.stroke.Transparency = v42.available and 0.2 or 0.5;
                v41 = i;
            else
                v40.itemID = nil;
                v40.icon.Visible = false;
                v40.stroke.Color = Color3_fromRGB_ret4;
                v40.stroke.Transparency = 0.4;
                v41 = i;
            end;
        else
            v41 = i;
        end;
    end;
end;

function v5._useQuick(u43, p44) -- Line: 402
    -- upvalues: Remotes (copy)
    local v45 = u43._quickSlots[p44];

    if not (v45 and v45.itemID) then
        return;
    end;

    Remotes.UseItemByType:FireServer(v45.itemID);
    task.delay(0.4, function() -- Line: 406
        -- upvalues: u43 (copy)
        u43:RefreshQuickAvailability();
    end);
end;

function v5._bindInput(u46) -- Line: 411
    -- upvalues: ContextActionService (copy), isBlocked (copy), u2 (copy), u1 (copy), u3 (copy)
    ContextActionService:BindAction("Hotbar_Weapons", function(p47, p48, p49) -- Line: 412
        -- upvalues: isBlocked (ref), u2 (ref), u46 (copy), u1 (ref)
        if p48 ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass;
        end;

        if isBlocked() then
            return Enum.ContextActionResult.Pass;
        end;

        for i, v in ipairs(u2) do
            if p49.KeyCode == v then
                u46:_drawWeapon(u1[i]);

                return Enum.ContextActionResult.Sink;
            end;
        end;

        return Enum.ContextActionResult.Pass;
    end, false, table.unpack(u2));
    ContextActionService:BindAction("Hotbar_Quick", function(p50, p51, p52) -- Line: 424
        -- upvalues: isBlocked (ref), u3 (ref), u46 (copy)
        if p51 ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass;
        end;

        if isBlocked() then
            return Enum.ContextActionResult.Pass;
        end;

        for i, v in ipairs(u3) do
            if p52.KeyCode == v then
                u46:_useQuick(i);

                return Enum.ContextActionResult.Sink;
            end;
        end;

        return Enum.ContextActionResult.Pass;
    end, false, table.unpack(u3));
end;

function v5._onEquipmentLoaded(p53, p54) -- Line: 439
    -- upvalues: u1 (copy)
    if type(p54) ~= "table" then
        return;
    end;

    for _, v in ipairs(u1) do
        local v55 = p54[v];
        p53:_setWeaponSlot(v, v55 and v55.ID or nil);
    end;
end;

function v5._hookCharacter(u56, p57) -- Line: 447
    -- upvalues: StarterGui (copy)
    pcall(function() -- Line: 450
        -- upvalues: StarterGui (ref)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    end);

    local function refresh() -- Line: 451
        -- upvalues: u56 (copy)
        u56:_refreshWeaponHighlight();
    end;

    p57.ChildAdded:Connect(function(p58) -- Line: 452
        -- upvalues: refresh (copy)
        if p58:IsA("Tool") then
            task.defer(refresh);
        end;
    end);
    p57.ChildRemoved:Connect(function(p59) -- Line: 453
        -- upvalues: refresh (copy)
        if p59:IsA("Tool") then
            task.defer(refresh);
        end;
    end);
    task.defer(refresh);
end;

function v5.Init(u60) -- Line: 457
    -- upvalues: ensureGui (copy), StarterGui (copy), Remotes (copy), u1 (copy), LocalPlayer (copy)
    if u60._started then
        return;
    end;

    u60._started = true;
    ensureGui(u60);
    pcall(function() -- Line: 462
        -- upvalues: StarterGui (ref)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
    end);
    u60:_bindInput();
    Remotes.LoadEquipment.OnClientEvent:Connect(function(p61) -- Line: 466
        -- upvalues: u60 (copy)
        u60:_onEquipmentLoaded(p61);
    end);
    Remotes.EquipSlotChanged.OnClientEvent:Connect(function(p62, p63) -- Line: 469
        -- upvalues: u1 (ref), u60 (copy)
        for _, v in ipairs(u1) do
            if p62 == v then
                local v64;

                if p63 then
                    v64 = p63.ID or nil;
                else
                    v64 = nil;
                end;

                u60:_setWeaponSlot(v, v64);
            end;
        end;
    end);
    Remotes:WaitForChild("HotbarEquipChanged").OnClientEvent:Connect(function(p65, p66) -- Line: 480
        -- upvalues: u60 (copy)
        u60:_setWeaponSlot(p65, p66 and p66.ID or nil);
    end);
    Remotes.RefreshInventory.OnClientEvent:Connect(function() -- Line: 486
        -- upvalues: u60 (copy)
        u60:RefreshQuickAvailability();
    end);

    if LocalPlayer.Character then
        u60:_hookCharacter(LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(function(p67) -- Line: 491
        -- upvalues: u60 (copy)
        u60:_hookCharacter(p67);
    end);
    task.defer(function() -- Line: 493
        -- upvalues: u60 (copy)
        u60:RefreshQuickAvailability();
    end);
end;

return v5;