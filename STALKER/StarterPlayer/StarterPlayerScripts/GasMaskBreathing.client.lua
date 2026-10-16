-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local LocalPlayer = Players.LocalPlayer;
local GasMaskVoiceConfig = require(ReplicatedStorage:WaitForChild("GasMaskVoiceConfig"));
local u1 = { "rbxassetid://97366561227121", "rbxassetid://126742845464284", "rbxassetid://105728541590146", "rbxassetid://71057343452580", "rbxassetid://80113917092811" };
local u2 = { "rbxassetid://121070979248151", "rbxassetid://87937341103243", "rbxassetid://80995660490663", "rbxassetid://135784478617027", "rbxassetid://97668581245908" };

local function isWearingGasMask() -- Line: 38
    -- upvalues: GasMaskVoiceConfig (copy), LocalPlayer (copy)
    return GasMaskVoiceConfig.isWearingGasMask(LocalPlayer.Character);
end;

local u3 = false;
local u4 = nil;
local u5 = nil;
local u6 = 100;
local u7 = 100;
local StaminaSync = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("StaminaSync");

if StaminaSync then
    StaminaSync.OnClientEvent:Connect(function(p8, p9) -- Line: 52
        -- upvalues: u6 (ref), u7 (ref)
        u6 = p8;
        u7 = p9 or 100;
    end);
end;

local function getBreathIntensity() -- Line: 58
    -- upvalues: LocalPlayer (copy), u6 (ref), u7 (ref)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:GetAttribute("Sprinting") == true;
    end;

    local v10 = u6 / u7;
    local v11 = Character and 0.6 or 0;

    if v10 < 0.5 then
        v11 = math.max(v11, 1 - v10 / 0.5);
    end;

    return math.clamp(v11, 0, 1);
end;

local function playSound(p12, p13, p14) -- Line: 100
    -- upvalues: SoundService (copy), u5 (ref), u3 (ref)
    local Sound = Instance.new("Sound");
    Sound.SoundId = p12;
    Sound.Volume = p13 or 0.8;
    Sound.PlaybackSpeed = p14 or 0.95 + math.random() * 0.1;
    Sound.Parent = SoundService;
    u5 = Sound;
    Sound:Play();
    local u15 = false;
    local v16 = Sound.Ended:Connect(function() -- Line: 111
        -- upvalues: u15 (ref)
        u15 = true;
    end);

    while not u15 and (u3 and Sound.Parent) do
        task.wait(0.05);
    end;

    v16:Disconnect();

    if u5 == Sound then
        u5 = nil;
    end;

    if Sound.Parent then
        Sound:Destroy();
    end;
end;

local function breathingLoop() -- Line: 120
    -- upvalues: u3 (ref), LocalPlayer (copy), u6 (ref), u7 (ref), u1 (copy), playSound (copy), u2 (copy)
    while u3 do
        local Character = LocalPlayer.Character;

        if Character then
            if Character:FindFirstChild("Head") then
                local Character2 = LocalPlayer.Character;

                if Character2 then
                    Character2 = Character2:GetAttribute("Sprinting") == true;
                end;

                local v17 = u6 / u7;
                local v18 = Character2 and 0.6 or 0;

                if v17 < 0.5 then
                    v18 = math.max(v18, 1 - v17 / 0.5);
                end;

                local math_clamp_ret = math.clamp(v18, 0, 1);
                local v19 = 0.6 + math_clamp_ret * 0.6;
                local v20 = 0.9 + math_clamp_ret * 0.3 + (math.random() * 0.1 - 0.05);
                playSound(u1[math.random(#u1)], v19, v20);
                local v21 = (0.15 + math.random() * 0.2) * (1 - math_clamp_ret * 0.5);
                task.wait(v21);

                if not u3 then
                    break;
                end;

                playSound(u2[math.random(#u2)], v19, v20);
                local v22 = (0.4 + math.random() * 0.5) * (1 - math_clamp_ret * 0.6);
                task.wait(v22);
            else
                task.wait(0.5);
            end;
        else
            task.wait(0.5);
        end;
    end;
end;

local function startBreathing() -- Line: 155
    -- upvalues: u3 (ref), u4 (ref), breathingLoop (copy)
    if u3 then
        return;
    end;

    u3 = true;
    u4 = task.spawn(breathingLoop);
end;

local function stopBreathing() -- Line: 161
    -- upvalues: u3 (ref), u4 (ref), u5 (ref)
    u3 = false;
    u4 = nil;

    if u5 then
        u5:Destroy();
        u5 = nil;
    end;
end;

task.spawn(function() -- Line: 171
    -- upvalues: GasMaskVoiceConfig (copy), LocalPlayer (copy), u3 (ref), u4 (ref), breathingLoop (copy), u5 (ref)
    while true do
        local v23 = GasMaskVoiceConfig.isWearingGasMask(LocalPlayer.Character);

        if v23 and not u3 then
            if not u3 then
                u3 = true;
                u4 = task.spawn(breathingLoop);
            end;
        elseif not v23 and u3 then
            u3 = false;
            u4 = nil;

            if u5 then
                u5:Destroy();
                u5 = nil;
            end;
        end;

        task.wait(1);
    end;
end);
print("[GasMaskBreathing] Initialized");