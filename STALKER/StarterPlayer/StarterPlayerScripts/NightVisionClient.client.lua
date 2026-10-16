-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local NightVisionConfig = require(ReplicatedStorage:WaitForChild("NightVisionConfig"));
local SoundService = game:GetService("SoundService");
local Debris = game:GetService("Debris");
local ToggleHeadlamp = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ToggleHeadlamp");
local NightVisionState = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("NightVisionState");

local function reportState(p1) -- Line: 55
    -- upvalues: NightVisionState (copy)
    if NightVisionState then
        NightVisionState:FireServer(p1);
    end;
end;

local function playButton() -- Line: 68
    -- upvalues: NightVisionConfig (copy), SoundService (copy), Debris (copy)
    local v2 = NightVisionConfig.SOUNDS and NightVisionConfig.SOUNDS.Button;

    if type(v2) ~= "string" or v2 == "" then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = v2;
    Sound.Volume = NightVisionConfig.SOUND_VOLUME;
    Sound.Parent = SoundService;
    Sound:Play();
    Sound.Ended:Connect(function() -- Line: 76
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    Debris:AddItem(Sound, 10);
end;

local LocalPlayer = Players.LocalPlayer;

local function headlampMounted() -- Line: 88
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;
    local v3;

    if Character == nil then
        v3 = false;
    else
        v3 = Character:FindFirstChild("PETZL HeadLamp") ~= nil;
    end;

    return v3;
end;

local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = 0;
local GAIN_START_STEP = NightVisionConfig.GAIN_START_STEP;
local Random_new_ret = Random.new();
local u9 = {};
local u10 = setmetatable({}, {
    __mode = "k"
});

local function setRigShadowsSuppressed(p11) -- Line: 116
    -- upvalues: u10 (copy)
    if not p11 then
        for i, v in pairs(u10) do
            if i.Parent then
                i.CastShadow = v;
            end;
        end;

        table.clear(u10);

        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera:FindFirstChild("WeaponRig");
    end;

    if not workspace_CurrentCamera then
        return;
    end;

    for _, descendant in ipairs(workspace_CurrentCamera:GetDescendants()) do
        if descendant:IsA("BasePart") and u10[descendant] == nil then
            u10[descendant] = descendant.CastShadow;
            descendant.CastShadow = false;
        end;
    end;
end;

local Lighting = game:GetService("Lighting");
local u12 = require(ReplicatedStorage:WaitForChild("PlaceConfig")).HasDayNightCycle == true;
local u13 = { "Ambient", "OutdoorAmbient", "ExposureCompensation" };
local u14 = { "Density", "Haze", "Color", "Decay" };
local u15 = nil;
local u16 = false;

local function trackInto(u17, u18, p19) -- Line: 160
    -- upvalues: u16 (ref)
    for _, v in ipairs(p19) do
        u17.server[v] = u18[v];
        local conns = u17.conns;
        local PropertyChangedSignal = u18:GetPropertyChangedSignal(v);
        table.insert(conns, PropertyChangedSignal:Connect(function() -- Line: 163
            -- upvalues: u16 (ref), u17 (copy), v (copy), u18 (copy)
            if not u16 then
                u17.server[v] = u18[v];
            end;
        end));
    end;
end;

local function stopLight() -- Line: 169
    -- upvalues: u15 (ref), u16 (ref), u13 (copy), Lighting (copy), u14 (copy)
    local v20 = u15;

    if not v20 then
        return;
    end;

    u15 = nil;
    u16 = true;

    for _, v in ipairs(u13) do
        Lighting[v] = v20.server[v];
    end;

    if v20.atmo and v20.atmo.Parent then
        for _, v in ipairs(u14) do
            v20.atmo[v] = v20.server[v];
        end;
    end;

    u16 = false;

    for _, v in ipairs(v20.conns) do
        v:Disconnect();
    end;
end;

local function startLight() -- Line: 182
    -- upvalues: u15 (ref), u12 (copy), trackInto (copy), Lighting (copy), u13 (copy), u14 (copy)
    if u15 then
        return;
    end;

    if not u12 then
        return;
    end;

    local v21 = {
        server = {},
        conns = {}
    };
    trackInto(v21, Lighting, u13);
    v21.atmo = Lighting:FindFirstChildOfClass("Atmosphere");

    if v21.atmo then
        trackInto(v21, v21.atmo, u14);
    end;

    u15 = v21;
end;

local function applyLight() -- Line: 192
    -- upvalues: u15 (ref), Lighting (copy), stopLight (copy), startLight (copy), NightVisionConfig (copy), u4 (ref), GAIN_START_STEP (ref), u16 (ref), u13 (copy), u14 (copy)
    if not u15 then
        return;
    end;

    if Lighting:FindFirstChildOfClass("Atmosphere") ~= u15.atmo then
        stopLight();
        startLight();
    end;

    local v22 = u15;
    local v23 = NightVisionConfig.Amplify(v22.server, u4, NightVisionConfig.GAIN_STEPS[GAIN_START_STEP]);

    if not v23 then
        return;
    end;

    u16 = true;

    for _, v in ipairs(u13) do
        if v23[v] ~= nil and Lighting[v] ~= v23[v] then
            Lighting[v] = v23[v];
        end;
    end;

    if v22.atmo then
        for _, v in ipairs(u14) do
            if v23[v] ~= nil and v22.atmo[v] ~= v23[v] then
                v22.atmo[v] = v23[v];
            end;
        end;
    end;

    u16 = false;
end;

local function clearIR() -- Line: 214
    -- upvalues: u10 (copy), u9 (copy)
    for i, v in pairs(u10) do
        if i.Parent then
            i.CastShadow = v;
        end;
    end;

    table.clear(u10);

    for _, v in pairs(u9) do
        v:Destroy();
    end;

    table.clear(u9);
end;

local function teardown() -- Line: 222
    -- upvalues: NightVisionState (copy), stopLight (copy), u6 (ref), clearIR (copy), u5 (ref), u4 (ref), u7 (ref), GAIN_START_STEP (ref), NightVisionConfig (copy)
    if NightVisionState then
        NightVisionState:FireServer(false);
    end;

    stopLight();

    if u6 then
        u6:Disconnect();
        u6 = nil;
    end;

    clearIR();

    if u5 then
        if u5.sheet then
            u5.sheet:Destroy();
        end;

        if u5.gain then
            u5.gain:Destroy();
        end;

        if u5.dof then
            u5.dof:Destroy();
        end;

        if u5.gui then
            u5.gui:Destroy();
        end;

        u5 = nil;
    end;

    u4 = nil;
    u7 = nil;
    GAIN_START_STEP = NightVisionConfig.GAIN_START_STEP;
end;

local function applyGain(p24) -- Line: 242
    -- upvalues: NightVisionConfig (copy), GAIN_START_STEP (ref)
    p24.gain.Brightness = p24.gen.GainBrightness * NightVisionConfig.GAIN_STEPS[GAIN_START_STEP];
    p24.gain.Contrast = p24.gen.GainContrast;
end;

local function isFirstPerson(p25) -- Line: 247
    -- upvalues: LocalPlayer (copy), NightVisionConfig (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("Head");
    end;

    if Character then
        return (p25.CFrame.Position - Character.Position).Magnitude <= NightVisionConfig.FIRST_PERSON_MAX_DISTANCE;
    end;

    return false;
end;

local function setShown(p26, p27) -- Line: 256
    -- upvalues: u7 (ref), startLight (copy), stopLight (copy)
    if u7 == p27 then
        return;
    end;

    u7 = p27;

    if p27 then
        startLight();
    else
        stopLight();
    end;

    p26.sheet.Transparency = not p27 and 1 or p26.gen.TintTransparency;
    p26.highlight.Enabled = p27;
    p26.gain.Enabled = p27;
    p26.dof.Enabled = p27;
    p26.grain.Visible = p27;

    if p26.tube then
        p26.tube.Visible = p27;
    end;
end;

local function onRender() -- Line: 268
    -- upvalues: u5 (ref), LocalPlayer (copy), NightVisionConfig (copy), u7 (ref), stopLight (copy), startLight (copy), applyLight (copy), u8 (ref), Random_new_ret (copy)
    local v28 = u5;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not (v28 and workspace_CurrentCamera) then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("Head");
    end;

    local v29;

    if Character then
        v29 = (workspace_CurrentCamera.CFrame.Position - Character.Position).Magnitude <= NightVisionConfig.FIRST_PERSON_MAX_DISTANCE;
    else
        v29 = false;
    end;

    if not v29 then
        if u7 == false then
            return;
        end;

        u7 = false;
        stopLight();
        v28.sheet.Transparency = 1;
        v28.highlight.Enabled = false;
        v28.gain.Enabled = false;
        v28.dof.Enabled = false;
        v28.grain.Visible = false;

        if v28.tube then
            v28.tube.Visible = false;
        end;

        return;
    end;

    if u7 ~= true then
        u7 = true;
        startLight();
        v28.sheet.Transparency = v28.gen.TintTransparency;
        v28.highlight.Enabled = true;
        v28.gain.Enabled = true;
        v28.dof.Enabled = true;
        v28.grain.Visible = true;

        if v28.tube then
            v28.tube.Visible = true;
        end;
    end;

    applyLight();

    if v28.sheet.Parent ~= workspace_CurrentCamera then
        v28.sheet.Parent = workspace_CurrentCamera;
    end;

    if v28.gain.Parent ~= workspace_CurrentCamera then
        v28.gain.Parent = workspace_CurrentCamera;
    end;

    if v28.dof.Parent ~= workspace_CurrentCamera then
        v28.dof.Parent = workspace_CurrentCamera;
    end;

    local math_rad_ret = math.rad(workspace_CurrentCamera.FieldOfView);
    local ViewportSize = workspace_CurrentCamera.ViewportSize;
    local v30 = ViewportSize.Y <= 0 and 1.7777777777777777 or ViewportSize.X / ViewportSize.Y;
    local v31 = 2 * NightVisionConfig.SHEET_DISTANCE * math.tan(math_rad_ret / 2) * 1.25;
    v28.sheet.Size = Vector3.new(v31 * v30, v31, 0.05);
    v28.sheet.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -NightVisionConfig.SHEET_DISTANCE);
    u8 = u8 + 1;

    if u8 >= v28.gen.GrainFrames then
        u8 = 0;
        local GRAIN_TILE_JITTER = NightVisionConfig.GRAIN_TILE_JITTER;
        local GRAIN_JITTER_PIXELS = NightVisionConfig.GRAIN_JITTER_PIXELS;
        v28.grain.TileSize = UDim2.fromScale(1 + Random_new_ret:NextNumber(-GRAIN_TILE_JITTER, GRAIN_TILE_JITTER), 1 + Random_new_ret:NextNumber(-GRAIN_TILE_JITTER, GRAIN_TILE_JITTER));
        v28.grain.Position = UDim2.fromOffset(Random_new_ret:NextInteger(-GRAIN_JITTER_PIXELS, GRAIN_JITTER_PIXELS), Random_new_ret:NextInteger(-GRAIN_JITTER_PIXELS, GRAIN_JITTER_PIXELS));
    end;
end;

local function buildInto(p32) -- Line: 311
    -- upvalues: NightVisionConfig (copy), GAIN_START_STEP (ref), LocalPlayer (copy)
    local gen = p32.gen;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    assert(workspace_CurrentCamera, "no CurrentCamera");
    local Part = Instance.new("Part");
    p32.sheet = Part;
    Part.Name = "NightVisionSheet";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Material = NightVisionConfig.SHEET_MATERIAL;
    Part.Color = gen.Tint;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 0.05);
    local Highlight = Instance.new("Highlight");
    p32.highlight = Highlight;
    Highlight.FillColor = NightVisionConfig.HIGHLIGHT_FILL;
    Highlight.FillTransparency = NightVisionConfig.HIGHLIGHT_FILL_TRANSPARENCY;
    Highlight.OutlineTransparency = 1;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Enabled = false;
    Highlight.Parent = Part;
    Part.Parent = workspace_CurrentCamera;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    p32.gain = ColorCorrectionEffect;
    ColorCorrectionEffect.Name = "NightVisionGain";
    ColorCorrectionEffect.Enabled = false;
    p32.gain.Brightness = p32.gen.GainBrightness * NightVisionConfig.GAIN_STEPS[GAIN_START_STEP];
    p32.gain.Contrast = p32.gen.GainContrast;
    ColorCorrectionEffect.Parent = workspace_CurrentCamera;
    local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect");
    p32.dof = DepthOfFieldEffect;
    DepthOfFieldEffect.Name = "NightVisionDepthOfField";
    DepthOfFieldEffect.Enabled = false;
    DepthOfFieldEffect.FarIntensity = NightVisionConfig.DOF_FAR_INTENSITY;
    DepthOfFieldEffect.FocusDistance = NightVisionConfig.DOF_FOCUS_DISTANCE;
    DepthOfFieldEffect.InFocusRadius = NightVisionConfig.DOF_IN_FOCUS_RADIUS;
    DepthOfFieldEffect.NearIntensity = NightVisionConfig.DOF_NEAR_INTENSITY;
    DepthOfFieldEffect.Parent = workspace_CurrentCamera;
    local ScreenGui = Instance.new("ScreenGui");
    p32.gui = ScreenGui;
    ScreenGui.Name = "NightVisionTubeGui";
    ScreenGui.DisplayOrder = NightVisionConfig.TUBE_DISPLAY_ORDER;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    local ImageLabel = Instance.new("ImageLabel");
    p32.grain = ImageLabel;
    ImageLabel.Name = "Grain";
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = NightVisionConfig.GRAIN_IMAGE;
    ImageLabel.ImageTransparency = gen.GrainTransparency;
    ImageLabel.ScaleType = Enum.ScaleType.Tile;
    ImageLabel.TileSize = UDim2.fromScale(1, 1);
    ImageLabel.ZIndex = 1;
    ImageLabel.Visible = false;
    ImageLabel.Parent = ScreenGui;

    if p32.drawTube then
        local ImageLabel2 = Instance.new("ImageLabel");
        p32.tube = ImageLabel2;
        ImageLabel2.Name = "Tube";
        ImageLabel2.Size = UDim2.fromScale(1, 1);
        ImageLabel2.BackgroundTransparency = 1;
        ImageLabel2.Image = gen.TubeImage;
        ImageLabel2.ScaleType = Enum.ScaleType.Stretch;
        ImageLabel2.ZIndex = 2;
        ImageLabel2.Visible = false;
        ImageLabel2.Parent = ScreenGui;
    end;

    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
end;

local function show(p33) -- Line: 404
    -- upvalues: teardown (copy), NightVisionConfig (copy), NightVisionState (copy), LocalPlayer (copy), u5 (ref), buildInto (copy), u4 (ref), u8 (ref), u6 (ref), RunService (copy), onRender (copy)
    teardown();
    local v34 = NightVisionConfig.GENS[p33];

    if not v34 then
        return;
    end;

    if NightVisionState then
        NightVisionState:FireServer(true);
    end;

    local _, v35 = NightVisionConfig.Worn(LocalPlayer.Character);
    local v36 = {
        gen = v34,
        drawTube = v35
    };
    u5 = v36;
    local success, result = pcall(buildInto, v36);

    if not success then
        warn("[NightVisionClient] build failed: " .. tostring(result));
        teardown();

        return;
    end;

    u4 = p33;
    u8 = 0;
    u6 = RunService.RenderStepped:Connect(onRender);
end;

local function wornGen() -- Line: 429
    -- upvalues: NightVisionConfig (copy), LocalPlayer (copy)
    return NightVisionConfig.Worn(LocalPlayer.Character);
end;

local function refreshIR() -- Line: 438
    -- upvalues: u4 (ref), u7 (ref), clearIR (copy), Players (copy), NightVisionConfig (copy), LocalPlayer (copy), u5 (ref), u9 (copy), setRigShadowsSuppressed (copy)
    if u4 == nil or u7 ~= true then
        clearIR();

        return;
    end;

    local v37 = {};

    for _, v in ipairs(Players:GetPlayers()) do
        local Character = v.Character;

        if Character and Character:GetAttribute(NightVisionConfig.IR_ATTR) == true then
            local v38;

            if v == LocalPlayer then
                v38 = u5 and u5.sheet;
            else
                v38 = Character:FindFirstChild("Head");
            end;

            if v38 then
                v37[Character] = true;
                u4 = u4;
                local v39;

                if v ~= LocalPlayer then
                    v39 = NightVisionConfig.Worn(Character);
                    local _ = v39 == nil;
                end;

                local v40 = NightVisionConfig.GENS[v39];
                local v41 = u9[Character];

                if not v41 or v41.Parent ~= v38 then
                    if v41 then
                        v41:Destroy();
                    end;

                    v41 = Instance.new("SpotLight");
                    v41.Name = "NightVisionIR";
                    v41.Brightness = NightVisionConfig.IR_BRIGHTNESS;
                    v41.Angle = NightVisionConfig.IR_ANGLE;
                    v41.Face = Enum.NormalId.Front;
                    v41.Shadows = NightVisionConfig.IR_SHADOWS;
                    v41.Parent = v38;
                    u9[Character] = v41;
                end;

                v41.Range = v40.IrRange;
                v41.Color = v40.IrColor;
            end;
        end;
    end;

    for i, v in pairs(u9) do
        if not v37[i] then
            v:Destroy();
            u9[i] = nil;
        end;
    end;

    local v42;

    if LocalPlayer.Character == nil then
        v42 = false;
    else
        v42 = u9[LocalPlayer.Character] ~= nil;
    end;

    setRigShadowsSuppressed(v42);
end;

UserInputService.InputBegan:Connect(function(p43, p44) -- Line: 491
    -- upvalues: NightVisionConfig (copy), LocalPlayer (copy), ToggleHeadlamp (copy), playButton (copy), u5 (ref), GAIN_START_STEP (ref), u4 (ref), show (copy), teardown (copy)
    if p44 then
        return;
    end;

    if p43.KeyCode == NightVisionConfig.IR_KEY then
        if NightVisionConfig.Worn(LocalPlayer.Character) ~= nil then
            local Character = LocalPlayer.Character;
            local v45;

            if Character == nil then
                v45 = false;
            else
                v45 = Character:FindFirstChild("PETZL HeadLamp") ~= nil;
            end;

            if not v45 then
                ToggleHeadlamp:FireServer();
                playButton();
            end;
        end;

        return;
    end;

    if p43.KeyCode ~= NightVisionConfig.GAIN_UP_KEY and p43.KeyCode ~= NightVisionConfig.GAIN_DOWN_KEY then
        if p43.KeyCode ~= NightVisionConfig.TOGGLE_KEY then
            return;
        end;

        local v46 = NightVisionConfig.Next(u4, (NightVisionConfig.Worn(LocalPlayer.Character)));

        if v46 then
            show(v46);

            return;
        end;

        teardown();

        return;
    end;

    if not u5 then
        return;
    end;

    local v47 = GAIN_START_STEP;
    GAIN_START_STEP = math.clamp(GAIN_START_STEP + (p43.KeyCode == NightVisionConfig.GAIN_UP_KEY and 1 or -1), 1, #NightVisionConfig.GAIN_STEPS);
    local v48 = u5;
    v48.gain.Brightness = v48.gen.GainBrightness * NightVisionConfig.GAIN_STEPS[GAIN_START_STEP];
    v48.gain.Contrast = v48.gen.GainContrast;

    if GAIN_START_STEP ~= v47 then
        playButton();
    end;
end);
local u49 = 0;
RunService.Heartbeat:Connect(function(p50) -- Line: 519
    -- upvalues: u49 (ref), NightVisionConfig (copy), refreshIR (copy)
    u49 = u49 + p50;

    if u49 < NightVisionConfig.IR_POLL_SECONDS then
        return;
    end;

    u49 = 0;
    refreshIR();
end);
local u51 = {};

local function onCharacter(p52) -- Line: 529
    -- upvalues: u51 (copy), teardown (copy), NightVisionConfig (copy), LocalPlayer (copy), u4 (ref), u5 (ref), show (copy)
    for _, v in ipairs(u51) do
        v:Disconnect();
    end;

    table.clear(u51);
    teardown();

    local function onWornChanged() -- Line: 538
        -- upvalues: NightVisionConfig (ref), LocalPlayer (ref), teardown (ref), u4 (ref), u5 (ref), show (ref)
        local v53, v54 = NightVisionConfig.Worn(LocalPlayer.Character);

        if v53 == nil then
            teardown();

            return;
        end;

        if u4 ~= nil and (u4 ~= v53 or u5 ~= nil and u5.drawTube ~= v54) then
            show(v53);
        end;
    end;

    local AttributeChangedSignal = p52:GetAttributeChangedSignal(NightVisionConfig.ATTR);
    table.insert(u51, AttributeChangedSignal:Connect(onWornChanged));
    local AttributeChangedSignal2 = p52:GetAttributeChangedSignal(NightVisionConfig.FACE_ATTR);
    table.insert(u51, AttributeChangedSignal2:Connect(onWornChanged));
    local AttributeChangedSignal3 = p52:GetAttributeChangedSignal("_electroStunUntil");
    table.insert(u51, AttributeChangedSignal3:Connect(teardown));
    local Humanoid = p52:WaitForChild("Humanoid", 10);

    if Humanoid and LocalPlayer.Character == p52 then
        table.insert(u51, Humanoid.Died:Connect(teardown));
    end;
end;

LocalPlayer.CharacterAdded:Connect(onCharacter);
LocalPlayer.CharacterRemoving:Connect(teardown);

if LocalPlayer.Character then
    task.spawn(onCharacter, LocalPlayer.Character);
end;

print("[NightVisionClient] Bound: K toggle, Z IR, Equals/Minus gain");