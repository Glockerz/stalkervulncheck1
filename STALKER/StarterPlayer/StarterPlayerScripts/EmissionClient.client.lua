-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"));

if not (PlaceConfig.HasWeather and PlaceConfig.HasEmissions) then
    return;
end;

local EmissionConfig = require(ReplicatedStorage:WaitForChild("EmissionConfig"));
local WeatherConfig = require(ReplicatedStorage:WaitForChild("WeatherConfig"));
local CameraShaker = require(ReplicatedStorage:WaitForChild("CameraShaker"));
local EmissionAssets = ReplicatedStorage:WaitForChild("EmissionAssets");
local ScreenFlash = require(ReplicatedStorage:WaitForChild("ScreenFlash"));
local ATTR = EmissionConfig.ATTR;
local PHASE = EmissionConfig.PHASE;
local workspace_Terrain = workspace.Terrain;
local None = PHASE.None;
local u1 = 0;
local u2 = nil;

local function ensureChild(p3, p4, p5) -- Line: 45
    local v6 = p3:FindFirstChild(p4);

    if v6 and v6:IsA(p5) then
        return v6;
    end;

    local Instance_new_ret = Instance.new(p5);
    Instance_new_ret.Name = p4;
    Instance_new_ret.Parent = p3;

    return Instance_new_ret;
end;

local Soundscape = SoundService:FindFirstChild("Soundscape");

if not (Soundscape and Soundscape:IsA("Folder")) then
    Soundscape = Instance.new("Folder");
    Soundscape.Name = "Soundscape";
    Soundscape.Parent = SoundService;
end;

local Emission = Soundscape:FindFirstChild("Emission");

if not (Emission and Emission:IsA("SoundGroup")) then
    Emission = Instance.new("SoundGroup");
    Emission.Name = "Emission";
    Emission.Parent = Soundscape;
end;

Emission.Volume = EmissionConfig.GROUP_VOLUME;
local blowout_indoor_loop = EmissionAssets:WaitForChild("Loop"):WaitForChild("blowout_indoor_loop");
local Volume = blowout_indoor_loop.Volume;
local u7 = blowout_indoor_loop:Clone();
u7.Looped = true;
u7.SoundGroup = Emission;
u7.Volume = 0;
u7.Parent = Emission;
local blowout_rumble = EmissionAssets:WaitForChild("Loop"):WaitForChild("blowout_rumble");
local Volume2 = blowout_rumble.Volume;
local u8 = blowout_rumble:Clone();
u8.Looped = true;
u8.SoundGroup = Emission;
u8.Volume = 0;
u8.Parent = Emission;
local earthquake = EmissionAssets:WaitForChild("Loop"):WaitForChild("earthquake");
local Volume3 = earthquake.Volume;
local u9 = earthquake:Clone();
u9.Looped = true;
u9.SoundGroup = Emission;
u9.Volume = 0;
u9.Parent = Emission;
local close = EmissionAssets:WaitForChild("OneShot"):WaitForChild("close");
local Volume4 = close.Volume;
local blowout_siren = EmissionAssets:WaitForChild("OneShot"):WaitForChild("blowout_siren");
local Volume5 = blowout_siren.Volume;

local function playOneShot(p10, p11, p12) -- Line: 91
    -- upvalues: Emission (copy)
    local u13 = p10:Clone();
    u13.SoundGroup = Emission;
    u13.Volume = p11 * p12;
    u13.Parent = Emission;
    u13.Ended:Once(function() -- Line: 96
        -- upvalues: u13 (copy)
        u13:Destroy();
    end);
    u13:Play();
end;

local u15 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p14) -- Line: 118
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * p14;
    end;
end, "EmissionCameraShaker");
local u16 = nil;

local function shakeMagnitude(p17: number) -- Line: 127
    -- upvalues: EmissionConfig (copy)
    return EmissionConfig.SHAKE_MAX_MAGNITUDE * math.clamp((p17 - EmissionConfig.BUILDUP_LEVEL) / (1 - EmissionConfig.BUILDUP_LEVEL), 0, 1);
end;

local Children = EmissionAssets:WaitForChild("Thunder"):GetChildren();
table.sort(Children, function(p18, p19) -- Line: 136
    return p18.Name < p19.Name;
end);

local function strike(p20: number) -- Line: 138
    -- upvalues: Children (copy), WeatherConfig (copy), EmissionConfig (copy), workspace_Terrain (copy), ScreenFlash (copy), u15 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera or #Children == 0 then
        return;
    end;

    local v21 = p20 % 2 == 1;
    local Random_new_ret = Random.new(p20);
    local v22 = Random_new_ret:NextNumber(0, 360);
    local math_rad_ret = math.rad(v22);
    local v23 = Random_new_ret:NextNumber(WeatherConfig.THUNDER_ELEVATION_MIN_DEG, WeatherConfig.THUNDER_ELEVATION_MAX_DEG);
    local math_rad_ret2 = math.rad(v23);
    local v24;

    if v21 then
        v24 = Random_new_ret:NextNumber(EmissionConfig.STRIKE_DISTANCE_MIN, EmissionConfig.STRIKE_DISTANCE_MAX);
    else
        v24 = Random_new_ret:NextNumber(EmissionConfig.BUILDUP_DISTANCE_MIN, EmissionConfig.BUILDUP_DISTANCE_MAX);
    end;

    local v25 = Children[Random_new_ret:NextInteger(1, #Children)];
    local LookVector = (CFrame.Angles(0, math_rad_ret, 0) * CFrame.Angles(math_rad_ret2, 0, 0)).LookVector;
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "EmissionThunder";
    Attachment.Parent = workspace_Terrain;
    Attachment.WorldPosition = workspace_CurrentCamera.CFrame.Position + LookVector * v24;
    local v26 = v25:Clone();
    v26.RollOffMode = Enum.RollOffMode.Inverse;
    v26.RollOffMinDistance = EmissionConfig.THUNDER_ROLLOFF_MIN_DISTANCE;
    v26.Volume = v26.Volume * EmissionConfig.THUNDER_VOLUME_SCALE;
    v26.Parent = Attachment;

    if v21 then
        ScreenFlash.Trigger(1, EmissionConfig.FLASH_TINT);

        if v24 < EmissionConfig.CLOSE_DISTANCE then
            u15:ShakeOnce(EmissionConfig.JOLT_MAGNITUDE, EmissionConfig.JOLT_ROUGHNESS, 0, EmissionConfig.JOLT_FADE_OUT);
        end;
    end;

    local u27 = false;

    local function cleanup() -- Line: 174
        -- upvalues: u27 (ref), Attachment (copy)
        if u27 then
            return;
        end;

        u27 = true;
        Attachment:Destroy();
    end;

    v26.Ended:Once(cleanup);
    task.delay(EmissionConfig.THUNDER_CLEANUP_TIMEOUT_SECONDS, cleanup);
    v26:Play();
end;

local function isActive(p28: string) -- Line: 189
    -- upvalues: PHASE (copy)
    return (p28 == PHASE.Buildup or (p28 == PHASE.Surge or p28 == PHASE.Apex)) and true or p28 == PHASE.Clearing;
end;

local function setActive(p29: boolean) -- Line: 193
    -- upvalues: u7 (copy), u8 (copy), u16 (ref), u15 (copy), EmissionConfig (copy)
    if p29 then
        if not u7.IsPlaying then
            u7:Play();
        end;

        if not u8.IsPlaying then
            u8:Play();
        end;

        if not u16 then
            u15:Start();
            u16 = u15:StartShake(0, EmissionConfig.SHAKE_ROUGHNESS, 0);
        end;
    else
        u7:Stop();
        u7.Volume = 0;
        u8:Stop();
        u8.Volume = 0;

        if u16 then
            u16:StartFadeOut(0);
            u16 = nil;
            u15:Stop();
        end;
    end;
end;

local function setEarthquakeActive(p30: boolean) -- Line: 220
    -- upvalues: u9 (copy)
    if p30 then
        if not u9.IsPlaying then
            u9:Play();
        end;
    else
        u9:Stop();
        u9.Volume = 0;
    end;
end;

local function readState() -- Line: 231
    -- upvalues: ReplicatedStorage (copy), ATTR (copy), PHASE (copy), u1 (ref), u2 (ref), close (copy), Volume4 (copy), EmissionConfig (copy), Emission (copy), blowout_siren (copy), Volume5 (copy), None (ref), setActive (copy), u9 (copy)
    local Attribute = ReplicatedStorage:GetAttribute(ATTR.Phase);
    local Attribute2 = ReplicatedStorage:GetAttribute(ATTR.Level);

    if type(Attribute) ~= "string" then
        Attribute = PHASE.None;
    end;

    u1 = type(Attribute2) ~= "number" and 0 or math.clamp(Attribute2, 0, 1);

    if u2 ~= nil then
        if Attribute == PHASE.Omen and u2 ~= PHASE.Omen then
            local BIRDS_VOLUME = EmissionConfig.BIRDS_VOLUME;
            local u31 = close:Clone();
            u31.SoundGroup = Emission;
            u31.Volume = Volume4 * BIRDS_VOLUME;
            u31.Parent = Emission;
            u31.Ended:Once(function() -- Line: 96
                -- upvalues: u31 (copy)
                u31:Destroy();
            end);
            u31:Play();
        end;

        local v32 = u2;

        if not (v32 == PHASE.Buildup or (v32 == PHASE.Surge or v32 == PHASE.Apex) or v32 == PHASE.Clearing or Attribute ~= PHASE.Buildup and (Attribute ~= PHASE.Surge and Attribute ~= PHASE.Apex)) then
            local SIREN_VOLUME = EmissionConfig.SIREN_VOLUME;
            local u33 = blowout_siren:Clone();
            u33.SoundGroup = Emission;
            u33.Volume = Volume5 * SIREN_VOLUME;
            u33.Parent = Emission;
            u33.Ended:Once(function() -- Line: 96
                -- upvalues: u33 (copy)
                u33:Destroy();
            end);
            u33:Play();
        end;
    end;

    u2 = Attribute;
    None = Attribute;
    local v34 = None;
    setActive((v34 == PHASE.Buildup or (v34 == PHASE.Surge or v34 == PHASE.Apex)) and true or v34 == PHASE.Clearing);

    if None == PHASE.Apex and true or None == PHASE.Clearing then
        if not u9.IsPlaying then
            u9:Play();
        end;
    else
        u9:Stop();
        u9.Volume = 0;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 258
    -- upvalues: None (ref), PHASE (copy), u7 (copy), Volume (copy), EmissionConfig (copy), u1 (ref), u8 (copy), Volume2 (copy), u16 (ref), u9 (copy), Volume3 (copy)
    local v35 = None;

    if (v35 == PHASE.Buildup or (v35 == PHASE.Surge or v35 == PHASE.Apex)) and true or v35 == PHASE.Clearing then
        u7.Volume = Volume * EmissionConfig.LOOP_VOLUME * u1;
        u8.Volume = Volume2 * EmissionConfig.RUMBLE_VOLUME * (None ~= PHASE.Clearing and 1 or u1);

        if u16 then
            u16.Magnitude = EmissionConfig.SHAKE_MAX_MAGNITUDE * math.clamp((u1 - EmissionConfig.BUILDUP_LEVEL) / (1 - EmissionConfig.BUILDUP_LEVEL), 0, 1);
        end;
    end;

    if None == PHASE.Apex or None == PHASE.Clearing then
        u9.Volume = math.min(EmissionConfig.EARTHQUAKE_MAX_VOLUME, Volume3 * EmissionConfig.EARTHQUAKE_VOLUME * (None ~= PHASE.Clearing and 1 or u1));
    end;
end);
ReplicatedStorage:GetAttributeChangedSignal(ATTR.Phase):Connect(readState);
ReplicatedStorage:GetAttributeChangedSignal(ATTR.Level):Connect(readState);
ReplicatedStorage:GetAttributeChangedSignal(ATTR.Strike):Connect(function() -- Line: 274
    -- upvalues: ReplicatedStorage (copy), ATTR (copy), strike (copy)
    local Attribute = ReplicatedStorage:GetAttribute(ATTR.Strike);

    if type(Attribute) == "number" then
        strike(Attribute);
    end;
end);
readState();