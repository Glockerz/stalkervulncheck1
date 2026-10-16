-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local InventoryWire = require(ReplicatedStorage:WaitForChild("InventoryWire"));
local WeaponCondition = require(ReplicatedStorage:WaitForChild("WeaponCondition"));
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Color3_fromRGB_ret = Color3.fromRGB(24, 26, 24);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret3 = Color3.fromRGB(228, 96, 96);
Color3.fromRGB(235, 235, 235);
local Color3_fromRGB_ret4 = Color3.fromRGB(70, 70, 70);
local u1 = {};

for i, v in pairs(ItemDatabase) do
    if type(v) == "table" and v.ToolName then
        u1[v.ToolName] = i;
    end;
end;

local v2 = {
    _started = false
};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;

local function ensureGui() -- Line: 41
    -- upvalues: u3 (ref), LocalPlayer (copy), u6 (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret4 (copy), u4 (ref), Color3_fromRGB_ret2 (copy), u5 (ref), Font_new_ret2 (copy), u7 (ref), u8 (ref), Font_new_ret (copy), Color3_fromRGB_ret3 (copy)
    if u3 and u3.Parent then
        return;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local AmmoHud = PlayerGui:FindFirstChild("AmmoHud");

    if AmmoHud then
        AmmoHud:Destroy();
    end;

    u3 = Instance.new("ScreenGui");
    u3.Name = "AmmoHud";
    u3.ResetOnSpawn = false;
    u3.IgnoreGuiInset = true;
    u3.DisplayOrder = 9;
    u3.Enabled = false;
    u3.Parent = PlayerGui;
    u6 = Instance.new("Frame");
    u6.Name = "Root";
    u6.AnchorPoint = Vector2.new(0.5, 0.5);
    u6.Position = UDim2.new(0.89, 0, 0.86, 0);
    u6.Size = UDim2.fromOffset(120, 80);
    u6.BackgroundTransparency = 1;
    u6.Parent = u3;
    local Frame = Instance.new("Frame");
    Frame.Name = "MagBody";
    Frame.AnchorPoint = Vector2.new(0, 0.5);
    Frame.Position = UDim2.new(0, 0, 0.5, 0);
    Frame.Size = UDim2.fromOffset(34, 72);
    Frame.BackgroundColor3 = Color3_fromRGB_ret;
    Frame.BackgroundTransparency = 0.2;
    Frame.BorderSizePixel = 0;
    Frame.Parent = u6;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 5);
    UICorner.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret4;
    UIStroke.Thickness = 1;
    UIStroke.Transparency = 0.3;
    UIStroke.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Track";
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.Position = UDim2.new(0.5, 0, 0.5, 0);
    Frame2.Size = UDim2.new(1, -8, 1, -8);
    Frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Frame2.BackgroundTransparency = 0.55;
    Frame2.BorderSizePixel = 0;
    Frame2.ClipsDescendants = true;
    Frame2.Parent = Frame;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(0, 3);
    UICorner2.Parent = Frame2;
    u4 = Instance.new("Frame");
    u4.Name = "Fill";
    u4.AnchorPoint = Vector2.new(0.5, 1);
    u4.Position = UDim2.new(0.5, 0, 1, 0);
    u4.Size = UDim2.new(1, 0, 1, 0);
    u4.BackgroundColor3 = Color3_fromRGB_ret2;
    u4.BorderSizePixel = 0;
    u4.Parent = Frame2;
    local UICorner3 = Instance.new("UICorner");
    UICorner3.CornerRadius = UDim.new(0, 3);
    UICorner3.Parent = u4;
    u5 = Instance.new("TextLabel");
    u5.Name = "Spare";
    u5.AnchorPoint = Vector2.new(0, 0.5);
    u5.Position = UDim2.new(0, 44, 0.5, 0);
    u5.Size = UDim2.fromOffset(80, 24);
    u5.BackgroundTransparency = 1;
    u5.FontFace = Font_new_ret2;
    u5.TextSize = 18;
    u5.TextColor3 = Color3_fromRGB_ret2;
    u5.TextXAlignment = Enum.TextXAlignment.Left;
    u5.Text = "x0";
    u5.Parent = u6;
    u7 = Instance.new("Frame");
    u7.Name = "ConditionBar";
    u7.AnchorPoint = Vector2.new(0, 0);
    u7.Position = UDim2.new(0, 0, 0, 78);
    u7.Size = UDim2.fromOffset(34, 4);
    u7.BackgroundColor3 = Color3_fromRGB_ret2;
    u7.BorderSizePixel = 0;
    u7.Parent = u6;
    local UICorner4 = Instance.new("UICorner");
    UICorner4.CornerRadius = UDim.new(0, 2);
    UICorner4.Parent = u7;
    u8 = Instance.new("TextLabel");
    u8.Name = "JamLabel";
    u8.AnchorPoint = Vector2.new(0, 0);
    u8.Position = UDim2.new(0, 44, 0, 54);
    u8.Size = UDim2.fromOffset(80, 16);
    u8.BackgroundTransparency = 1;
    u8.FontFace = Font_new_ret;
    u8.TextSize = 13;
    u8.TextColor3 = Color3_fromRGB_ret3;
    u8.TextXAlignment = Enum.TextXAlignment.Left;
    u8.Text = "JAMMED";
    u8.Visible = false;
    u8.Parent = u6;
end;

local function setFill(p17) -- Line: 145
    -- upvalues: u4 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy)
    local math_clamp_ret = math.clamp(p17, 0, 1);
    u4.Size = UDim2.new(1, 0, math_clamp_ret, 0);
    u4.BackgroundColor3 = math_clamp_ret <= 0.25 and Color3_fromRGB_ret3 or Color3_fromRGB_ret2;
end;

local function updateMag() -- Line: 151
    -- upvalues: u10 (ref), u14 (ref), ItemDatabase (copy), u4 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy)
    if not u10 then
        return;
    end;

    local Value = u10.Value;
    local MaxValue = u10.MaxValue;

    if MaxValue <= 0 then
        local v18 = u14 and ItemDatabase.GetItemData(u14);
        MaxValue = v18 and v18.maxRounds or math.max(Value, 1);
    end;

    local math_clamp_ret = math.clamp(Value / MaxValue, 0, 1);
    u4.Size = UDim2.new(1, 0, math_clamp_ret, 0);
    u4.BackgroundColor3 = math_clamp_ret <= 0.25 and Color3_fromRGB_ret3 or Color3_fromRGB_ret2;
end;

local function countSpareMags(p19) -- Line: 162
    -- upvalues: Remotes (copy), InventoryWire (copy), ItemDatabase (copy)
    local success, result = pcall(function() -- Line: 163
        -- upvalues: Remotes (ref)
        return Remotes.GetAllInventories:InvokeServer();
    end);

    if not success or type(result) ~= "table" then
        return 0;
    end;

    local v20 = 0;

    for _, v in pairs(result) do
        if type(v) == "table" and v.Items then
            for _, v3 in InventoryWire.Each(v.Items) do
                if v3 and ItemDatabase.MagFits(p19, v3.ID) then
                    v20 = v20 + 1;
                end;
            end;
        end;
    end;

    return v20;
end;

local function updateSpare() -- Line: 183
    -- upvalues: u9 (ref), u15 (ref), LocalPlayer (copy), u16 (ref), u5 (ref), u14 (ref), countSpareMags (copy)
    if not u9 then
        return;
    end;

    if not u15 then
        if u14 then
            u5.Text = "x" .. countSpareMags(u14);

            return;
        end;

        u5.Text = "";

        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("AmmoPool");
    end;

    local v21 = Character and u16 and (Character:FindFirstChild(u16) or Character:FindFirstChild("Universal"));

    if v21 then
        v21 = v21:FindFirstChild("CurrentValue");
    end;

    u5.Text = (v21 and tostring(v21.Value) or "0") .. " rds";
end;

local function updateCondition() -- Line: 202
    -- upvalues: u9 (ref), u7 (ref), WeaponCondition (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy)
    if not (u9 and u7) then
        return;
    end;

    local Attribute = u9:GetAttribute(WeaponCondition.ATTR);

    if type(Attribute) ~= "number" then
        Attribute = WeaponCondition.MAX;
    end;

    local math_clamp_ret = math.clamp(Attribute / WeaponCondition.MAX, 0, 1);
    local UDim2_fromOffset = UDim2.fromOffset;
    local math_floor_ret = math.floor(math_clamp_ret * 34);
    u7.Size = UDim2_fromOffset(math.max(1, math_floor_ret), 4);
    u7.BackgroundColor3 = math_clamp_ret <= 0.25 and Color3_fromRGB_ret3 or Color3_fromRGB_ret2;
end;

local function updateJam() -- Line: 214
    -- upvalues: u9 (ref), u8 (ref)
    if not (u9 and u8) then
        return;
    end;

    u8.Visible = u9:GetAttribute("WeaponJammed") == true;
end;

local function unbind() -- Line: 219
    -- upvalues: u11 (ref), u12 (ref), u13 (ref), u9 (ref), u10 (ref), u14 (ref), u15 (ref), u16 (ref), u8 (ref), u3 (ref)
    if u11 then
        u11:Disconnect();
        u11 = nil;
    end;

    if u12 then
        u12:Disconnect();
        u12 = nil;
    end;

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    u9 = nil;
    u10 = nil;
    u14 = nil;
    u15 = nil;
    u16 = nil;

    if u8 then
        u8.Visible = false;
    end;

    if u3 then
        u3.Enabled = false;
    end;
end;

local function bind(p22) -- Line: 230
    -- upvalues: u9 (ref), u11 (ref), u12 (ref), u13 (ref), u10 (ref), u14 (ref), u15 (ref), u16 (ref), u8 (ref), u3 (ref), u1 (copy), ItemDatabase (copy), ensureGui (copy), updateMag (copy), WeaponCondition (copy), updateCondition (copy), updateJam (copy), u4 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), updateSpare (copy)
    if u9 == p22 then
        return;
    end;

    if u11 then
        u11:Disconnect();
        u11 = nil;
    end;

    if u12 then
        u12:Disconnect();
        u12 = nil;
    end;

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    u9 = nil;
    u10 = nil;
    u14 = nil;
    u15 = nil;
    u16 = nil;

    if u8 then
        u8.Visible = false;
    end;

    if u3 then
        u3.Enabled = false;
    end;

    if not (p22 and p22:FindFirstChild("SPH_Weapon")) then
        return;
    end;

    local v23 = u1[p22.Name];

    if v23 then
        v23 = ItemDatabase.GetItemData(v23);
    end;

    local v24;

    if v23 then
        v24 = v23.MagType or nil;
    else
        v24 = nil;
    end;

    u14 = v24;
    local v25 = nil;
    local WeaponStats = p22.SPH_Weapon:FindFirstChild("WeaponStats");
    local v26;

    if WeaponStats then
        local v27;
        v27, v26 = pcall(require, WeaponStats);

        if not v27 then
            v26 = v25;
        end;
    else
        v26 = v25;
    end;

    local v28;

    if v26 then
        v28 = v26.magType;
    else
        v28 = v26;
    end;

    u15 = (v28 == 2 or v28 == 3) and true or u14 == nil;
    local v29 = v26 and v26.ammoType;

    if v29 then
        v23 = v29;
    elseif v23 then
        v23 = v23.ammoType;
    end;

    u16 = v23;
    local Ammo = p22:WaitForChild("Ammo", 3);

    if Ammo then
        Ammo = Ammo:WaitForChild("MagAmmo", 3);
    end;

    u10 = Ammo;

    if u10 then
        u9 = p22;
        ensureGui();
        u3.Enabled = true;
        u11 = u10.Changed:Connect(updateMag);
        u12 = p22:GetAttributeChangedSignal(WeaponCondition.ATTR):Connect(updateCondition);
        u13 = p22:GetAttributeChangedSignal("WeaponJammed"):Connect(updateJam);

        if u10 then
            local Value = u10.Value;
            local MaxValue = u10.MaxValue;

            if MaxValue <= 0 then
                local v30 = u14 and ItemDatabase.GetItemData(u14);
                MaxValue = v30 and v30.maxRounds or math.max(Value, 1);
            end;

            local math_clamp_ret = math.clamp(Value / MaxValue, 0, 1);
            u4.Size = UDim2.new(1, 0, math_clamp_ret, 0);
            u4.BackgroundColor3 = math_clamp_ret <= 0.25 and Color3_fromRGB_ret3 or Color3_fromRGB_ret2;
        end;

        updateSpare();
        updateCondition();

        if u9 then
            if not u8 then
                return;
            end;

            u8.Visible = u9:GetAttribute("WeaponJammed") == true;
        end;

        return;
    end;

    if u11 then
        u11:Disconnect();
        u11 = nil;
    end;

    if u12 then
        u12:Disconnect();
        u12 = nil;
    end;

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    u9 = nil;
    u10 = nil;
    u14 = nil;
    u15 = nil;
    u16 = nil;

    if u8 then
        u8.Visible = false;
    end;

    if u3 then
        u3.Enabled = false;
    end;
end;

local function currentSphTool(p31) -- Line: 265
    for _, child in ipairs(p31:GetChildren()) do
        if child:IsA("Tool") and child:FindFirstChild("SPH_Weapon") then
            return child;
        end;
    end;

    return nil;
end;

local function hookCharacter(p32) -- Line: 272
    -- upvalues: currentSphTool (copy), bind (copy), u9 (ref), u11 (ref), u12 (ref), u13 (ref), u10 (ref), u14 (ref), u15 (ref), u16 (ref), u8 (ref), u3 (ref)
    local v33 = currentSphTool(p32);

    if v33 then
        bind(v33);
    end;

    p32.ChildAdded:Connect(function(u34) -- Line: 275
        -- upvalues: bind (ref)
        if u34:IsA("Tool") and u34:FindFirstChild("SPH_Weapon") then
            task.defer(function() -- Line: 277
                -- upvalues: bind (ref), u34 (copy)
                bind(u34);
            end);
        end;
    end);
    p32.ChildRemoved:Connect(function(p35) -- Line: 280
        -- upvalues: u9 (ref), u11 (ref), u12 (ref), u13 (ref), u10 (ref), u14 (ref), u15 (ref), u16 (ref), u8 (ref), u3 (ref)
        if p35 == u9 then
            if u11 then
                u11:Disconnect();
                u11 = nil;
            end;

            if u12 then
                u12:Disconnect();
                u12 = nil;
            end;

            if u13 then
                u13:Disconnect();
                u13 = nil;
            end;

            u9 = nil;
            u10 = nil;
            u14 = nil;
            u15 = nil;
            u16 = nil;

            if u8 then
                u8.Visible = false;
            end;

            if u3 then
                u3.Enabled = false;
            end;
        end;
    end);
end;

function v2.Init(p36) -- Line: 285
    -- upvalues: ensureGui (copy), LocalPlayer (copy), hookCharacter (copy), u11 (ref), u12 (ref), u13 (ref), u9 (ref), u10 (ref), u14 (ref), u15 (ref), u16 (ref), u8 (ref), u3 (ref), Remotes (copy), updateSpare (copy)
    if p36._started then
        return;
    end;

    p36._started = true;
    ensureGui();

    if LocalPlayer.Character then
        hookCharacter(LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(function(p37) -- Line: 290
        -- upvalues: u11 (ref), u12 (ref), u13 (ref), u9 (ref), u10 (ref), u14 (ref), u15 (ref), u16 (ref), u8 (ref), u3 (ref), hookCharacter (ref)
        if u11 then
            u11:Disconnect();
            u11 = nil;
        end;

        if u12 then
            u12:Disconnect();
            u12 = nil;
        end;

        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;

        u9 = nil;
        u10 = nil;
        u14 = nil;
        u15 = nil;
        u16 = nil;

        if u8 then
            u8.Visible = false;
        end;

        if u3 then
            u3.Enabled = false;
        end;

        hookCharacter(p37);
    end);
    Remotes.RefreshInventory.OnClientEvent:Connect(function() -- Line: 294
        -- upvalues: u9 (ref), updateSpare (ref)
        if u9 then
            updateSpare();
        end;
    end);
end;

return v2;