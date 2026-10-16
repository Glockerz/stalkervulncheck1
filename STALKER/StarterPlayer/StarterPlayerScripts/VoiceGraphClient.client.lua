-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Workspace = game:GetService("Workspace");
local GasMaskVoiceConfig = require(ReplicatedStorage:WaitForChild("GasMaskVoiceConfig"));
local LocalPlayer = Players.LocalPlayer;
local AudioListener = Instance.new("AudioListener");
AudioListener.Parent = Workspace.CurrentCamera;
local AudioDeviceOutput = Instance.new("AudioDeviceOutput");
AudioDeviceOutput.Parent = AudioListener;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;

local function setDirect() -- Line: 20
    -- upvalues: u3 (ref), u4 (ref), u2 (ref), u1 (ref), AudioListener (copy), AudioDeviceOutput (copy)
    if u3 then
        u3:Destroy();
        u3 = nil;
    end;

    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    if u2 then
        u2:Destroy();
        u2 = nil;
    end;

    if not u1 then
        u1 = Instance.new("Wire");
        u1.SourceInstance = AudioListener;
        u1.TargetInstance = AudioDeviceOutput;
        u1.Parent = AudioDeviceOutput;
    end;
end;

local function setMuffled() -- Line: 32
    -- upvalues: u1 (ref), u2 (ref), GasMaskVoiceConfig (copy), AudioListener (copy), u3 (ref), u4 (ref), AudioDeviceOutput (copy)
    if u1 then
        u1:Destroy();
        u1 = nil;
    end;

    if u2 then
        return;
    end;

    u2 = Instance.new("AudioEqualizer");
    local MidGain = GasMaskVoiceConfig.ListenerEQ.MidGain;
    local HighGain = GasMaskVoiceConfig.ListenerEQ.HighGain;
    u2.LowGain = GasMaskVoiceConfig.ListenerEQ.LowGain;
    u2.MidGain = MidGain;
    u2.HighGain = HighGain;
    u2.Parent = AudioListener;
    u3 = Instance.new("Wire");
    u3.SourceInstance = AudioListener;
    u3.TargetInstance = u2;
    u3.Parent = u2;
    u4 = Instance.new("Wire");
    u4.SourceInstance = u2;
    u4.TargetInstance = AudioDeviceOutput;
    u4.Parent = AudioDeviceOutput;
end;

setDirect();
task.spawn(function() -- Line: 47
    -- upvalues: Workspace (copy), AudioListener (copy), LocalPlayer (copy), GasMaskVoiceConfig (copy), u5 (ref), setMuffled (copy), setDirect (copy)
    while true do
        local CurrentCamera = Workspace.CurrentCamera;

        if CurrentCamera and AudioListener.Parent ~= CurrentCamera then
            AudioListener.Parent = CurrentCamera;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if Character then
            Character = Character:FindFirstChildOfClass("AudioEmitter");
        end;

        if Character then
            Character.AudioInteractionGroup = GasMaskVoiceConfig.SelfMonitor and "" or "__noself__";
        end;

        local v6 = GasMaskVoiceConfig.isWearingGasMask(LocalPlayer.Character);

        if v6 ~= u5 then
            u5 = v6;

            if v6 then
                setMuffled();
            else
                setDirect();
            end;
        end;

        task.wait(GasMaskVoiceConfig.PollInterval);
    end;
end);
print("[VoiceGraphClient] online");