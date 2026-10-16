-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");

if not require(ReplicatedStorage:WaitForChild("PlaceConfig")).HasWeather then
    return;
end;

local WeatherConfig = require(ReplicatedStorage:WaitForChild("WeatherConfig"));
local WeatherMath = require(ReplicatedStorage:WaitForChild("WeatherMath"));
local WeatherAssets = ReplicatedStorage:WaitForChild("WeatherAssets");
local ATTR = WeatherConfig.ATTR;
local workspace_Terrain = workspace.Terrain;
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CFrame_new_ret = CFrame.new(10000, 10000, 10000);
local u1 = 0;
local u2 = 0;

local function ensureChild(p3, p4, p5) -- Line: 42
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

local Weather = Soundscape:FindFirstChild("Weather");

if not (Weather and Weather:IsA("SoundGroup")) then
    Weather = Instance.new("SoundGroup");
    Weather.Name = "Weather";
    Weather.Parent = Soundscape;
end;

Weather.Volume = WeatherConfig.WEATHER_GROUP_VOLUME;
local u7 = {};

for _, child in ipairs(WeatherAssets:WaitForChild("Rain"):GetChildren()) do
    local v8 = child:Clone();
    v8.SoundGroup = Weather;
    v8.Volume = 0;
    v8.Parent = Weather;
    u7[child.Name] = {
        sound = v8,
        base = child.Volume
    };
end;

local rain = WeatherAssets:WaitForChild("Helm"):WaitForChild("rain");
local u9 = rain:Clone();
u9.SoundGroup = Weather;
u9.Volume = 0;
u9.Parent = Weather;
local Volume = rain.Volume;

local function wearsRainHelmGear() -- Line: 78
    -- upvalues: Players (copy), WeatherConfig (copy)
    local Character = Players.LocalPlayer.Character;
    local v10;

    if Character == nil then
        v10 = false;
    else
        v10 = Character:GetAttribute(WeatherConfig.HEAD_COVER_HARD_ATTR) == true and true or Character:GetAttribute(WeatherConfig.FACE_COVER_VISORED_ATTR) == true;
    end;

    return v10;
end;

local u11 = false;

local function setLoopsPlaying(p12: boolean) -- Line: 85
    -- upvalues: u11 (ref), u7 (copy), u9 (copy)
    if p12 == u11 then
        return;
    end;

    u11 = p12;

    for _, v in pairs(u7) do
        if p12 then
            v.sound:Play();
        else
            v.sound:Stop();
            v.sound.Volume = 0;
        end;
    end;

    if p12 then
        u9:Play();

        return;
    end;

    u9:Stop();
    u9.Volume = 0;
end;

local RainAboveChunk = WeatherAssets:WaitForChild("RainAboveChunk");
local RainBelowChunk = WeatherAssets:WaitForChild("RainBelowChunk");
local u13 = {
    raindrops = RainAboveChunk:WaitForChild("raindrops").Rate,
    dropSplash = RainBelowChunk:WaitForChild("dropSplash").Rate,
    hardRainMist = RainBelowChunk:WaitForChild("hardRainMist").Rate,
    hardRainSplash = RainBelowChunk:WaitForChild("hardRainSplash").Rate
};
local Folder = Instance.new("Folder");
Folder.Name = "_WeatherRain";
Folder.Parent = workspace_Terrain;
local u14 = {};
local u15 = 0;
local u16 = true;

local function applyRates() -- Line: 127
    -- upvalues: u1 (ref), u2 (ref), u14 (copy), u13 (copy)
    local math_max_ret = math.max(0, u1);
    local v17 = math.min(math_max_ret, 1) * math.max(0, u2);

    for _, v in ipairs(u14) do
        v.raindrops.Rate = u13.raindrops * math_max_ret;
        v.dropSplash.Rate = u13.dropSplash * math_max_ret;
        v.hardRainMist.Rate = u13.hardRainMist * v17;
        v.hardRainSplash.Rate = u13.hardRainSplash * v17;
    end;
end;

local function parkAll() -- Line: 139
    -- upvalues: u14 (copy), CFrame_new_ret (copy), u16 (ref)
    local v18 = {};
    local v19 = {};

    for _, v in ipairs(u14) do
        table.insert(v18, v.above);
        table.insert(v19, CFrame_new_ret);
        table.insert(v18, v.below);
        table.insert(v19, CFrame_new_ret);
    end;

    if #v18 > 0 then
        workspace:BulkMoveTo(v18, v19, Enum.BulkMoveMode.FireCFrameChanged);
    end;

    u16 = true;
end;

local function buildGrid(p20: number) -- Line: 156
    -- upvalues: Folder (copy), u14 (copy), u15 (ref), WeatherConfig (copy), RainAboveChunk (copy), RainBelowChunk (copy), CFrame_new_ret (copy), u16 (ref), applyRates (copy)
    Folder:ClearAllChildren();
    table.clear(u14);
    u15 = p20;
    local v21 = WeatherConfig.RAIN_AREA / p20;
    local Vector3_new_ret = Vector3.new(v21, 0.001, v21);
    local v22 = -WeatherConfig.RAIN_AREA / 2 + v21 / 2;

    for i = 0, p20 - 1 do
        local v23 = i;

        for i2 = 0, p20 - 1 do
            local v24 = RainAboveChunk:Clone();
            local v25 = RainBelowChunk:Clone();
            v24.Size = Vector3_new_ret;
            v25.Size = Vector3_new_ret;
            v24.CFrame = CFrame_new_ret;
            v25.CFrame = CFrame_new_ret;
            v24.Parent = Folder;
            v25.Parent = Folder;
            local v26 = {
                above = v24,
                below = v25,
                offset = Vector3.new(v22 + v23 * v21, 0, v22 + i2 * v21),
                raindrops = v24.raindrops,
                dropSplash = v25.dropSplash,
                hardRainMist = v25.hardRainMist,
                hardRainSplash = v25.hardRainSplash
            };
            table.insert(u14, v26);
            local _ = i2;
        end;
    end;

    u16 = true;
    applyRates();
end;

buildGrid(WeatherMath.GridSize(UserGameSettings.SavedQualityLevel));
UserGameSettings:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function() -- Line: 189
    -- upvalues: WeatherMath (copy), UserGameSettings (copy), u15 (ref), buildGrid (copy)
    local v27 = WeatherMath.GridSize(UserGameSettings.SavedQualityLevel);

    if v27 ~= u15 then
        buildGrid(v27);
    end;
end);
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.IgnoreWater = false;
RaycastParams_new_ret.RespectCanCollide = true;

local function refreshFilter() -- Line: 210
    -- upvalues: Folder (copy), Players (copy), RaycastParams_new_ret (copy)
    local v28 = { Folder };

    if workspace.CurrentCamera then
        table.insert(v28, workspace.CurrentCamera);
    end;

    for _, v in ipairs(Players:GetPlayers()) do
        if v.Character then
            table.insert(v28, v.Character);
        end;
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v28;
end;

local function watchPlayer(p29: userdata) -- Line: 223
    -- upvalues: refreshFilter (copy)
    p29.CharacterAdded:Connect(refreshFilter);
    p29.CharacterRemoving:Connect(function() -- Line: 225
        -- upvalues: refreshFilter (ref)
        task.defer(refreshFilter);
    end);
end;

for _, v in ipairs(Players:GetPlayers()) do
    v.CharacterAdded:Connect(refreshFilter);
    v.CharacterRemoving:Connect(function() -- Line: 225
        -- upvalues: refreshFilter (copy)
        task.defer(refreshFilter);
    end);
end;

Players.PlayerAdded:Connect(watchPlayer);
Players.PlayerRemoving:Connect(function() -- Line: 233
    -- upvalues: refreshFilter (copy)
    task.defer(refreshFilter);
end);
refreshFilter();

local function updateRain(p30: vector) -- Line: 238
    -- upvalues: u14 (copy), WeatherConfig (copy), RaycastParams_new_ret (copy), CFrame_new_ret (copy), u16 (ref)
    local v31 = {};
    local v32 = {};

    for _, v in ipairs(u14) do
        local v33 = p30 + v.offset + Vector3.new(0, 1, 0) * WeatherConfig.RAIN_VERTICAL_OFFSET;

        if workspace:Raycast(v33, Vector3.new(0, 1, 0) * WeatherConfig.RAIN_SAFETY_RANGE, RaycastParams_new_ret) then
            table.insert(v31, v.above);
            table.insert(v32, CFrame_new_ret);
            table.insert(v31, v.below);
            table.insert(v32, CFrame_new_ret);
        else
            local v34 = workspace:Raycast(v33, Vector3.new(-0, -1, -0) * WeatherConfig.RAIN_CHECK_RANGE, RaycastParams_new_ret);
            table.insert(v31, v.above);
            table.insert(v32, CFrame.new(v33));
            table.insert(v31, v.below);

            if v34 then
                local v35 = CFrame.lookAt(v34.Position, v34.Position + v34.Normal) * CFrame.Angles(1.5707963267948966, 0, 0);
                table.insert(v32, v35);
                v.raindrops.Lifetime = NumberRange.new(v34.Distance / v.raindrops.Speed.Max * WeatherConfig.RAINDROP_LIFETIME_SCALE);
            else
                table.insert(v32, CFrame_new_ret);
                v.raindrops.Lifetime = NumberRange.new(WeatherConfig.RAINDROP_FALLBACK_LIFETIME);
            end;
        end;
    end;

    if #v31 > 0 then
        workspace:BulkMoveTo(v31, v32, Enum.BulkMoveMode.FireCFrameChanged);
    end;

    u16 = false;
end;

local u36 = { Vector3.new(0, 1, 0), Vector3.new(1, 1, 0), Vector3.new(-1, 1, 0), Vector3.new(0, 1, 1), Vector3.new(0, 1, -1) };

local function checkIndoors(p37: vector) -- Line: 280
    -- upvalues: u36 (copy), WeatherConfig (copy), RaycastParams_new_ret (copy)
    local v38 = 0;

    for _, v in ipairs(u36) do
        if workspace:Raycast(p37, v * WeatherConfig.INDOOR_CHECK_RANGE, RaycastParams_new_ret) then
            v38 = v38 + 1;

            if v38 >= 3 then
                return true;
            end;
        end;
    end;

    return false;
end;

local u39 = 0;
local u40 = 0;
local u41 = 0;

local function onTick() -- Line: 298
    -- upvalues: u1 (ref), u16 (ref), parkAll (copy), updateRain (copy), u39 (ref), checkIndoors (copy)
    if u1 <= 0 then
        if not u16 then
            parkAll();
        end;

        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local Position = workspace_CurrentCamera.CFrame.Position;
    updateRain(Position);
    u39 = checkIndoors(Position) and 1 or 0;
end;

RunService.Heartbeat:Connect(function(p42) -- Line: 312
    -- upvalues: u41 (ref), WeatherConfig (copy), u1 (ref), u16 (ref), parkAll (copy), updateRain (copy), u39 (ref), checkIndoors (copy)
    u41 = u41 + p42;
    local v43 = 1 / WeatherConfig.RAIN_UPDATE_HZ;

    if v43 <= u41 then
        u41 = u41 % v43;

        if u1 <= 0 then
            if not u16 then
                parkAll();
            end;
        else
            local workspace_CurrentCamera = workspace.CurrentCamera;

            if not workspace_CurrentCamera then
                return;
            end;

            local Position = workspace_CurrentCamera.CFrame.Position;
            updateRain(Position);
            u39 = checkIndoors(Position) and 1 or 0;
        end;
    end;
end);
RunService.RenderStepped:Connect(function(p44) -- Line: 322
    -- upvalues: u1 (ref), u11 (ref), u7 (copy), u9 (copy), WeatherConfig (copy), u40 (ref), u39 (ref), u2 (ref), WeatherMath (copy), Players (copy), Volume (copy)
    if u1 <= 0 then
        if u11 == false then
            return;
        end;

        u11 = false;

        for _, v in pairs(u7) do
            v.sound:Stop();
            v.sound.Volume = 0;
        end;

        u9:Stop();
        u9.Volume = 0;

        return;
    end;

    if u11 ~= true then
        u11 = true;

        for _, v in pairs(u7) do
            v.sound:Play();
        end;

        u9:Play();
    end;

    local math_clamp_ret = math.clamp(p44 * 60, 0, WeatherConfig.FRAME_COMPENSATION_MAX);
    u40 = u40 + (u39 - u40) * (1 - (1 - WeatherConfig.INDOOR_SMOOTHING) ^ math_clamp_ret);
    local v45 = u1 + math.min(u1, 1) * u2;
    local v46, v47, v48 = WeatherMath.RainLayers(v45);

    for i, v in pairs({
        weak = v46,
        medium = v47,
        strong = v48
    }) do
        local v49 = u7["indoor_" .. i];
        local v50 = u7["outdoor_" .. i];

        if v49 then
            v49.sound.Volume = v49.base * v * u40;
        end;

        if v50 then
            v50.sound.Volume = v50.base * v * (1 - u40);
        end;
    end;

    local Character = Players.LocalPlayer.Character;
    local v51;

    if Character == nil then
        v51 = false;
    else
        v51 = Character:GetAttribute(WeatherConfig.HEAD_COVER_HARD_ATTR) == true and true or Character:GetAttribute(WeatherConfig.FACE_COVER_VISORED_ATTR) == true;
    end;

    local v52 = not v51 and 0 or math.clamp(v45 / 3, 0, 1) * (1 - u40);
    u9.Volume = Volume * WeatherConfig.RAIN_HELM_VOLUME * v52;
end);
local ScreenFlash = require(ReplicatedStorage:WaitForChild("ScreenFlash"));
local u53 = {
    close = {},
    far = {}
};

for _, child in ipairs(WeatherAssets:WaitForChild("Thunder"):GetChildren()) do
    local v54;

    if child.Name:sub(1, 5) == "close" then
        v54 = u53.close;
    elseif child.Name:sub(1, 3) == "far" then
        v54 = u53.far;
    else
        v54 = nil;
    end;

    if v54 then
        table.insert(v54, child);
    end;
end;

for _, v in pairs(u53) do
    table.sort(v, function(p55, p56) -- Line: 377
        return p55.Name < p56.Name;
    end);
end;

local function strike(p57: number) -- Line: 380
    -- upvalues: WeatherConfig (copy), u53 (copy), WeatherMath (copy), workspace_Terrain (copy), ScreenFlash (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local Random_new_ret = Random.new(p57);
    local v58 = Random_new_ret:NextNumber(0, 360);
    local math_rad_ret = math.rad(v58);
    local v59 = Random_new_ret:NextNumber(WeatherConfig.THUNDER_ELEVATION_MIN_DEG, WeatherConfig.THUNDER_ELEVATION_MAX_DEG);
    local math_rad_ret2 = math.rad(v59);
    local v60 = Random_new_ret:NextNumber(WeatherConfig.THUNDER_MIN_DISTANCE, WeatherConfig.THUNDER_MAX_DISTANCE);
    local v61 = u53[WeatherMath.ThunderSet(v60)];

    if #v61 == 0 then
        return;
    end;

    local v62 = v61[Random_new_ret:NextInteger(1, #v61)];
    local LookVector = (CFrame.Angles(0, math_rad_ret, 0) * CFrame.Angles(math_rad_ret2, 0, 0)).LookVector;
    local v63 = Random_new_ret:NextNumber(0.95, 1.05);
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "WeatherThunder";
    Attachment.Parent = workspace_Terrain;
    Attachment.WorldPosition = workspace_CurrentCamera.CFrame.Position + LookVector * v60;
    local v64 = v62:Clone();
    v64.RollOffMode = Enum.RollOffMode.Inverse;
    v64.RollOffMinDistance = WeatherConfig.THUNDER_ROLLOFF_MIN_DISTANCE;
    v64.Volume = v64.Volume * WeatherConfig.THUNDER_VOLUME_SCALE;
    v64.PlaybackSpeed = v64.PlaybackSpeed * v63;
    v64.Parent = Attachment;
    ScreenFlash.Trigger(WeatherMath.ThunderSet(v60) == "close" and 1 or WeatherConfig.FLASH_FAR_STRENGTH);
    local u65 = false;

    local function cleanup() -- Line: 423
        -- upvalues: u65 (ref), Attachment (copy)
        if u65 then
            return;
        end;

        u65 = true;
        Attachment:Destroy();
    end;

    v64.Ended:Once(cleanup);
    task.delay(WeatherConfig.THUNDER_CLEANUP_TIMEOUT_SECONDS, cleanup);
    v64:Play();
end;

local ScreenRain = require(script:WaitForChild("ScreenRain"));
ScreenRain.Configure({
    Size = WeatherConfig.SCREEN_RAIN_SIZE,
    Tint = WeatherConfig.SCREEN_RAIN_TINT,
    Fade = WeatherConfig.SCREEN_RAIN_FADE,
    UpdateFreq = 1 / WeatherConfig.SCREEN_RAIN_UPDATE_HZ,
    MaxLookDown = WeatherConfig.SCREEN_RAIN_MAX_LOOK_DOWN,
    CoverRange = WeatherConfig.SCREEN_RAIN_COVER_RANGE
});
local LocalPlayer = Players.LocalPlayer;
local success, result = pcall(function() -- Line: 455
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("ClientSettings", 5));
end);

local function updateScreenRain() -- Line: 457
    -- upvalues: success (copy), result (copy), LocalPlayer (copy), ScreenRain (copy), u1 (ref), WeatherMath (copy), UserGameSettings (copy), WeatherConfig (copy)
    local v66 = success and result and result.Get("screenRain") == false;

    if LocalPlayer:GetAttribute("VisorOnScreen") == true and not v66 then
        if u1 <= 0 or not WeatherMath.ScreenRainAllowed(UserGameSettings.SavedQualityLevel) then
            ScreenRain.SetRate(0);

            return;
        end;

        ScreenRain.SetRate(WeatherConfig.SCREEN_RAIN_RATE_MAX * math.clamp(u1 / 3, 0, 1));

        return;
    end;

    ScreenRain.SetRate(0);
    ScreenRain.Clear();
end;

LocalPlayer:GetAttributeChangedSignal("VisorOnScreen"):Connect(updateScreenRain);
UserGameSettings:GetPropertyChangedSignal("SavedQualityLevel"):Connect(updateScreenRain);

if success and result then
    result.OnChanged("screenRain", function() -- Line: 474
        -- upvalues: updateScreenRain (copy)
        updateScreenRain();
    end);
end;

local function readLevels() -- Line: 479
    -- upvalues: ReplicatedStorage (copy), ATTR (copy), u1 (ref), u2 (ref), applyRates (copy), updateScreenRain (copy)
    local Attribute = ReplicatedStorage:GetAttribute(ATTR.Rain);
    local Attribute2 = ReplicatedStorage:GetAttribute(ATTR.Storm);
    u1 = type(Attribute) ~= "number" and 0 or Attribute;
    u2 = type(Attribute2) ~= "number" and 0 or Attribute2;
    applyRates();
    updateScreenRain();
end;

ReplicatedStorage:GetAttributeChangedSignal(ATTR.Rain):Connect(readLevels);
ReplicatedStorage:GetAttributeChangedSignal(ATTR.Storm):Connect(readLevels);
ReplicatedStorage:GetAttributeChangedSignal(ATTR.Lightning):Connect(function() -- Line: 491
    -- upvalues: ReplicatedStorage (copy), ATTR (copy), strike (copy)
    local Attribute = ReplicatedStorage:GetAttribute(ATTR.Lightning);

    if type(Attribute) == "number" then
        strike(Attribute);
    end;
end);
local Attribute = ReplicatedStorage:GetAttribute(ATTR.Rain);
local Attribute2 = ReplicatedStorage:GetAttribute(ATTR.Storm);

if type(Attribute) == "number" then
    u1 = Attribute;
else
    u1 = 0;
end;

if type(Attribute2) == "number" then
    u2 = Attribute2;
else
    u2 = 0;
end;

applyRates();
updateScreenRain();