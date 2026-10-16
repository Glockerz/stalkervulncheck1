-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local CK_Marksmanship = ReplicatedStorage:WaitForChild("CK_Marksmanship", 30);

if not CK_Marksmanship then
    warn("[ScopeController] CK_Marksmanship missing; UI optics disabled");

    return;
end;

local CK_Config = require(CK_Marksmanship:WaitForChild("CK_Config"));
local GameConfig = require(ReplicatedStorage:WaitForChild("SPH_Assets"):WaitForChild("GameConfig"));
local AimSensitivity = require(ReplicatedStorage:WaitForChild("SPH_Assets"):WaitForChild("Modules"):WaitForChild("AimSensitivity"));
local CK_OverlayApi = require(CK_Marksmanship:WaitForChild("CK_OverlayApi"));

local function zoomExp() -- Line: 87
    -- upvalues: CK_Config (copy)
    return CK_Config.OPTIC.zoomExponent or 1;
end;

local function magToFov(p1) -- Line: 91
    -- upvalues: CK_Config (copy)
    local v2 = CK_Config.OPTIC.baseFov or 70;
    local v3 = math.max(p1, 0.01) ^ (CK_Config.OPTIC.zoomExponent or 1);
    local math_rad_ret = math.rad(v2 / 2);
    local v4 = math.tan(math_rad_ret) / v3;
    local v5 = math.atan(v4) * 2;

    return math.deg(v5);
end;

local function fovToMag(p6) -- Line: 103
    -- upvalues: CK_Config (copy)
    local math_rad_ret = math.rad((CK_Config.OPTIC.baseFov or 70) / 2);
    local math_tan_ret = math.tan(math_rad_ret);
    local math_rad_ret2 = math.rad(p6 / 2);
    local math_tan_ret2 = math.tan(math_rad_ret2);

    return (math_tan_ret / math.max(math_tan_ret2, 1e-6)) ^ (1 / (CK_Config.OPTIC.zoomExponent or 1));
end;

local u7 = Enum.RenderPriority.Camera.Value + 1;
local u8 = false;
local u9 = false;
local u10 = nil;
local u11 = nil;
local ContextActionService = game:GetService("ContextActionService");
local SoundService = game:GetService("SoundService");
local u12 = nil;
local u13 = 1;
local u14 = nil;
local Sound = Instance.new("Sound");
Sound.Name = "ZoneScopeZoomClick";
Sound.SoundId = "rbxassetid://102949973946969";
Sound.Volume = 0.6;
Sound.Parent = SoundService;

local function isVariable(p15) -- Line: 155
    local v16;

    if p15 == nil or p15.magStops == nil then
        v16 = false;
    else
        v16 = #p15.magStops > 1;
    end;

    return v16;
end;

local function onPrimarySight() -- Line: 179
    -- upvalues: LocalPlayer (copy)
    local Attribute = LocalPlayer:GetAttribute("CK_SightIndex");

    return Attribute == nil and true or Attribute == 1;
end;

local function opticTool() -- Line: 189
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Tool");
    end;

    if not Character then
        return nil;
    end;

    if Character:GetAttribute("CK_OpticId") == nil then
        return nil;
    end;

    local Attribute = LocalPlayer:GetAttribute("CK_SightIndex");

    if Attribute == nil and true or Attribute == 1 then
        return Character;
    end;

    return nil;
end;

local function setViewmodelHidden(p17) -- Line: 209
    -- upvalues: workspace_CurrentCamera (copy)
    local WeaponRig = workspace_CurrentCamera:FindFirstChild("WeaponRig");

    if not WeaponRig then
        return;
    end;

    local v18 = p17 and 1 or 0;

    for _, descendant in ipairs(WeaponRig:GetDescendants()) do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            descendant.LocalTransparencyModifier = v18;
        end;
    end;
end;

local u19 = {};

local function setOtherGuisHidden(p20) -- Line: 235
    -- upvalues: LocalPlayer (copy), u19 (ref)
    local v21 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not v21 then
        return;
    end;

    if p20 then
        u19 = {};

        for _, child in ipairs(v21:GetChildren()) do
            if child:IsA("ScreenGui") and (child.Enabled and child.Name ~= "CK_ScopeOverlay") then
                child.Enabled = false;
                table.insert(u19, child);
            end;
        end;

        return;
    end;

    for _, v in ipairs(u19) do
        if v.Parent then
            v.Enabled = true;
        end;
    end;

    u19 = {};
end;

local u22 = nil;

local function watchFiring(u23) -- Line: 290
    -- upvalues: u22 (ref), u8 (ref), CK_OverlayApi (copy)
    if u22 then
        u22:Disconnect();
        u22 = nil;
    end;

    task.spawn(function() -- Line: 294
        -- upvalues: u23 (copy), u8 (ref), u22 (ref), CK_OverlayApi (ref)
        local Ammo = u23:WaitForChild("Ammo", 5);

        if Ammo then
            Ammo = Ammo:WaitForChild("MagAmmo", 5);
        end;

        if not (Ammo and u8) then
            return;
        end;

        local Value = Ammo.Value;
        local u24 = os.clock() + 0.35;
        u22 = Ammo.Changed:Connect(function(p25) -- Line: 300
            -- upvalues: Value (ref), u24 (copy), CK_OverlayApi (ref)
            if p25 < Value and u24 <= os.clock() then
                CK_OverlayApi.addKick();
            end;

            Value = p25;
        end);
    end);
end;

local function zoomHandler(p26, p27, p28) -- Line: 317
    -- upvalues: u8 (ref), u12 (ref), UserInputService (copy), GameConfig (copy), u13 (ref), SoundService (copy), Sound (copy)
    if p28.UserInputType ~= Enum.UserInputType.MouseWheel then
        return Enum.ContextActionResult.Pass;
    end;

    local Z = p28.Position.Z;

    if Z == 0 or not (u8 and (u12 and #u12 >= 2)) then
        return Enum.ContextActionResult.Pass;
    end;

    if not UserInputService:IsKeyDown(GameConfig.holdForScrollZoom) then
        return Enum.ContextActionResult.Pass;
    end;

    local math_clamp_ret = math.clamp(u13 + (Z > 0 and 1 or -1), 1, #u12);

    if math_clamp_ret ~= u13 then
        u13 = math_clamp_ret;
        SoundService:PlayLocalSound(Sound);
    end;

    return Enum.ContextActionResult.Sink;
end;

local function stopScope() -- Line: 343
    -- upvalues: u8 (ref), u22 (ref), setViewmodelHidden (copy), LocalPlayer (copy), u19 (ref), ContextActionService (copy), u12 (ref), u13 (ref), u14 (ref), u9 (ref), RunService (copy), u10 (ref), u11 (ref), AimSensitivity (copy), CK_OverlayApi (copy)
    if not u8 then
        return;
    end;

    u8 = false;

    if u22 then
        u22:Disconnect();
        u22 = nil;
    end;

    setViewmodelHidden(false);

    if LocalPlayer:FindFirstChildOfClass("PlayerGui") then
        for _, v in ipairs(u19) do
            if v.Parent then
                v.Enabled = true;
            end;
        end;

        u19 = {};
    end;

    LocalPlayer:SetAttribute("CK_ScopeOwnsFov", nil);
    ContextActionService:UnbindAction("ZoneScopeZoom");
    u12 = nil;
    u13 = 1;
    u14 = nil;

    if u9 then
        RunService:UnbindFromRenderStep("ZoneScopeFov");
        u9 = false;
    end;

    u10 = nil;
    u11 = nil;
    AimSensitivity.SetCameraScale(nil);
    CK_OverlayApi.setVisible(false);
end;

local function startScope(u29) -- Line: 373
    -- upvalues: CK_Config (copy), u10 (ref), u11 (ref), u8 (ref), u12 (ref), u13 (ref), LocalPlayer (copy), u14 (ref), workspace_CurrentCamera (copy), ContextActionService (copy), zoomHandler (copy), setOtherGuisHidden (copy), u22 (ref), CK_OverlayApi (copy), RunService (copy), u7 (copy), stopScope (copy), AimSensitivity (copy), setViewmodelHidden (copy), u9 (ref)
    local v30 = CK_Config.opticFor(u29);
    u10 = v30;
    u11 = v30.magStart or (v30.magStops and (v30.magStops[1] or 4) or 4);
    u8 = true;
    u12 = v30.magStops;
    u13 = 1;

    if u12 then
        local v31 = (1 / 0);

        for i, v in ipairs(u12) do
            local math_abs_ret = math.abs(v - u11);

            if math_abs_ret < v31 then
                u13 = i;
                v31 = math_abs_ret;
            end;
        end;
    end;

    local v32;

    if v30 == nil or v30.magStops == nil then
        v32 = false;
    else
        v32 = #v30.magStops > 1;
    end;

    if v32 then
        LocalPlayer:SetAttribute("CK_ScopeOwnsFov", true);
        u14 = workspace_CurrentCamera.FieldOfView;
        ContextActionService:BindActionAtPriority("ZoneScopeZoom", zoomHandler, false, 200, Enum.UserInputType.MouseWheel);
    end;

    setOtherGuisHidden(true);

    if u22 then
        u22:Disconnect();
        u22 = nil;
    end;

    task.spawn(function() -- Line: 294
        -- upvalues: u29 (copy), u8 (ref), u22 (ref), CK_OverlayApi (ref)
        local Ammo = u29:WaitForChild("Ammo", 5);

        if Ammo then
            Ammo = Ammo:WaitForChild("MagAmmo", 5);
        end;

        if not (Ammo and u8) then
            return;
        end;

        local Value = Ammo.Value;
        local u33 = os.clock() + 0.35;
        u22 = Ammo.Changed:Connect(function(p34) -- Line: 300
            -- upvalues: Value (ref), u33 (copy), CK_OverlayApi (ref)
            if p34 < Value and u33 <= os.clock() then
                CK_OverlayApi.addKick();
            end;

            Value = p34;
        end);
    end);
    CK_OverlayApi.setProfile(v30.profile or "SUSAT_4");
    CK_OverlayApi.setOptic(v30);
    CK_OverlayApi.updateReticle(v30, u11);
    CK_OverlayApi.setMag(u11);
    CK_OverlayApi.setVisible(true);
    RunService:BindToRenderStep("ZoneScopeFov", u7, function(p35) -- Line: 429
        -- upvalues: u8 (ref), LocalPlayer (ref), u29 (copy), stopScope (ref), u14 (ref), u12 (ref), u13 (ref), u11 (ref), CK_Config (ref), workspace_CurrentCamera (ref), u10 (ref), AimSensitivity (ref), setViewmodelHidden (ref), CK_OverlayApi (ref)
        if u8 then
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChildOfClass("Tool");
            end;

            if Character and Character:GetAttribute("CK_OpticId") ~= nil then
                local Attribute = LocalPlayer:GetAttribute("CK_SightIndex");

                if Attribute ~= nil and Attribute ~= 1 then
                    Character = nil;
                end;
            else
                Character = nil;
            end;

            if Character == u29 and u29.Parent ~= nil then
                local v36;

                if u14 then
                    local v37 = CK_Config.OPTIC.baseFov or 70;
                    local v38 = math.max(u12 and u12[u13] or (u11 or 4), 0.01) ^ (CK_Config.OPTIC.zoomExponent or 1);
                    local math_rad_ret = math.rad(v37 / 2);
                    local v39 = math.tan(math_rad_ret) / v38;
                    local v40 = math.atan(v39) * 2;
                    u14 = u14 + (math.deg(v40) - u14) * math.clamp((p35 or 0) * 18, 0, 1);
                    workspace_CurrentCamera.FieldOfView = u14;
                    v36 = u14;
                else
                    v36 = workspace_CurrentCamera.FieldOfView;
                end;

                local v41 = u10.baseFov or 70;
                local v42 = AimSensitivity.Get() / AimSensitivity.Default();
                AimSensitivity.SetCameraScale(math.clamp(v36 / v41, u10.sensZoomMin or 0.03, u10.sensZoomMax or 1.4) * v42);
                setViewmodelHidden(true);
                local math_rad_ret = math.rad((CK_Config.OPTIC.baseFov or 70) / 2);
                local math_tan_ret = math.tan(math_rad_ret);
                local math_rad_ret2 = math.rad(v36 / 2);
                local math_tan_ret2 = math.tan(math_rad_ret2);
                local v43 = (math_tan_ret / math.max(math_tan_ret2, 1e-6)) ^ (1 / (CK_Config.OPTIC.zoomExponent or 1)) * 10 + 0.5;
                local v44 = math.floor(v43) / 10;

                if v44 ~= u11 then
                    u11 = v44;
                    CK_OverlayApi.setMag(v44);
                    CK_OverlayApi.updateReticle(u10, v44);
                end;

                return;
            end;
        end;

        stopScope();
    end);
    u9 = true;
end;

local function onAimingChanged(p45) -- Line: 527
    -- upvalues: LocalPlayer (copy), u8 (ref), startScope (copy), stopScope (copy)
    if p45:GetAttribute("Aiming") then
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildOfClass("Tool");
        end;

        if Character and Character:GetAttribute("CK_OpticId") ~= nil then
            local Attribute = LocalPlayer:GetAttribute("CK_SightIndex");

            if Attribute ~= nil and Attribute ~= 1 then
                Character = nil;
            end;
        else
            Character = nil;
        end;

        if Character and not u8 then
            startScope(Character);
        end;
    else
        stopScope();
    end;
end;

LocalPlayer:GetAttributeChangedSignal("CK_SightIndex"):Connect(function() -- Line: 547
    -- upvalues: LocalPlayer (copy), u8 (ref), startScope (copy), stopScope (copy)
    local Character = LocalPlayer.Character;

    if Character then
        if Character:GetAttribute("Aiming") then
            local Character2 = LocalPlayer.Character;

            if Character2 then
                Character2 = Character2:FindFirstChildOfClass("Tool");
            end;

            if Character2 and Character2:GetAttribute("CK_OpticId") ~= nil then
                local Attribute = LocalPlayer:GetAttribute("CK_SightIndex");

                if Attribute ~= nil and Attribute ~= 1 then
                    Character2 = nil;
                end;
            else
                Character2 = nil;
            end;

            if Character2 and not u8 then
                startScope(Character2);
            end;
        else
            stopScope();
        end;
    end;
end);

local function hookCharacter(u46) -- Line: 552
    -- upvalues: stopScope (copy), LocalPlayer (copy), u8 (ref), startScope (copy), onAimingChanged (copy)
    stopScope();
    u46:GetAttributeChangedSignal("Aiming"):Connect(function() -- Line: 554
        -- upvalues: u46 (copy), LocalPlayer (ref), u8 (ref), startScope (ref), stopScope (ref)
        if u46:GetAttribute("Aiming") then
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChildOfClass("Tool");
            end;

            if Character and Character:GetAttribute("CK_OpticId") ~= nil then
                local Attribute = LocalPlayer:GetAttribute("CK_SightIndex");

                if Attribute ~= nil and Attribute ~= 1 then
                    Character = nil;
                end;
            else
                Character = nil;
            end;

            if Character and not u8 then
                startScope(Character);
            end;
        else
            stopScope();
        end;
    end);

    if u46:GetAttribute("Aiming") then
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildOfClass("Tool");
        end;

        if Character and Character:GetAttribute("CK_OpticId") ~= nil then
            local Attribute = LocalPlayer:GetAttribute("CK_SightIndex");

            if Attribute ~= nil and Attribute ~= 1 then
                Character = nil;
            end;
        else
            Character = nil;
        end;

        if Character and not u8 then
            startScope(Character);
        end;
    else
        stopScope();
    end;

    u46.ChildAdded:Connect(function(p47) -- Line: 563
        -- upvalues: onAimingChanged (ref), u46 (copy)
        if p47:IsA("Tool") then
            task.defer(onAimingChanged, u46);
        end;
    end);
    u46.AncestryChanged:Connect(function(p48, p49) -- Line: 568
        -- upvalues: stopScope (ref)
        if not p49 then
            stopScope();
        end;
    end);
end;

if LocalPlayer.Character then
    hookCharacter(LocalPlayer.Character);
end;

LocalPlayer.CharacterAdded:Connect(hookCharacter);
print("[ScopeController] UI optics ready (Aiming-driven)");