-- Decompiled with Potassium's decompiler.

local u1 = {
    Config = {
        BaseAcceleration = 6,
        MoveAcceleration = 6,
        MovementCutoff = 0.001,
        SprintAcceleration = 4,
        ExhaustedAcceleration = 3,
        HeavyAcceleration = 2
    }
};
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local WeightBands = require(ReplicatedStorage:WaitForChild("WeightBands"));
local GameConfig = require(ReplicatedStorage:WaitForChild("SPH_Assets"):WaitForChild("GameConfig"));
local u2 = (GameConfig.walkSpeed + GameConfig.sprintSpeed) / 2;
local LocalPlayer = Players.LocalPlayer;
local ControlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"));
local workspace_CurrentCamera = workspace.CurrentCamera;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local Vector3_new_ret = Vector3.new();
local Vector3_new_ret2 = Vector3.new();
local u6 = 100;
local u7 = 0;

local function lerp(p8, p9, p10) -- Line: 37
    return p8 + (p9 - p8) * p10;
end;

local function calculateAcceleration() -- Line: 41
    -- upvalues: u1 (copy), u7 (ref), WeightBands (copy), u6 (ref), u4 (ref), u2 (copy), u3 (ref)
    local Config = u1.Config;
    local BaseAcceleration = Config.BaseAcceleration;

    if u7 >= WeightBands.OVERLOADED then
        BaseAcceleration = Config.HeavyAcceleration;
    elseif u7 >= WeightBands.HEAVY then
        local SprintAcceleration = Config.SprintAcceleration;
        BaseAcceleration = SprintAcceleration + (Config.HeavyAcceleration - SprintAcceleration) * ((u7 - WeightBands.HEAVY) / (WeightBands.OVERLOADED - WeightBands.HEAVY));
    elseif u7 >= WeightBands.LIGHT then
        local BaseAcceleration2 = Config.BaseAcceleration;
        BaseAcceleration = BaseAcceleration2 + (Config.SprintAcceleration - BaseAcceleration2) * ((u7 - WeightBands.LIGHT) / (WeightBands.HEAVY - WeightBands.LIGHT));
    end;

    local v11 = BaseAcceleration * WeightBands.AgilityFactor(u7);

    if u6 <= 10 then
        v11 = math.min(v11, Config.ExhaustedAcceleration);
    elseif u6 <= 30 then
        local ExhaustedAcceleration = Config.ExhaustedAcceleration;
        v11 = math.min(v11, ExhaustedAcceleration + (Config.BaseAcceleration - ExhaustedAcceleration) * ((u6 - 10) / 20));
    end;

    if u4 and u2 < u4.WalkSpeed then
        local v12 = u3 and u3:FindFirstChild("HumanoidRootPart");

        if v12 and v12.AssemblyLinearVelocity.Magnitude > 10 then
            v11 = math.min(v11, Config.SprintAcceleration);
        end;
    end;

    return v11;
end;

local function updateMovement(p13) -- Line: 80
    -- upvalues: workspace_CurrentCamera (copy), ControlModule (copy), Vector3_new_ret (ref), calculateAcceleration (copy), u1 (copy), Vector3_new_ret2 (ref), u4 (ref)
    Vector3_new_ret = workspace_CurrentCamera.CFrame:VectorToWorldSpace(ControlModule:GetMoveVector());
    local v14 = calculateAcceleration();
    u1.Config.MoveAcceleration = v14;
    local math_clamp_ret = math.clamp(p13 * v14, 0, 1);
    local v15 = Vector3_new_ret2;
    Vector3_new_ret2 = v15 + (Vector3_new_ret - v15) * math_clamp_ret;

    if Vector3_new_ret2.Magnitude < u1.Config.MovementCutoff and Vector3_new_ret.Magnitude < u1.Config.MovementCutoff then
        Vector3_new_ret2 = Vector3.new();
    end;

    if u4 then
        local Parent = u4.Parent;

        if Parent and Parent:GetAttribute("_vortexHeld") then
            return;
        end;

        u4:Move(Vector3_new_ret2);
    end;
end;

function u1.Initialize(p16) -- Line: 106
    -- upvalues: u3 (ref), LocalPlayer (copy), u4 (ref), ReplicatedStorage (copy), u6 (ref), u7 (ref), u5 (ref), RunService (copy), updateMovement (copy)
    p16:Cleanup();
    u3 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    u4 = u3:WaitForChild("Humanoid");
    LocalPlayer.CharacterAdded:Connect(function(p17) -- Line: 112
        -- upvalues: u3 (ref), u4 (ref)
        u3 = p17;
        u4 = u3:WaitForChild("Humanoid");
    end);
    local StaminaSync = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("StaminaSync");

    if StaminaSync then
        StaminaSync.OnClientEvent:Connect(function(p18, p19) -- Line: 120
            -- upvalues: u6 (ref)
            u6 = p18;
        end);
    end;

    local WeightSync = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("WeightSync");

    if WeightSync then
        WeightSync.OnClientEvent:Connect(function(p20, p21) -- Line: 128
            -- upvalues: u7 (ref)
            u7 = p20 / p21;
        end);
    end;

    u5 = RunService.RenderStepped:Connect(updateMovement);

    return p16;
end;

function u1.Cleanup(p22) -- Line: 138
    -- upvalues: u5 (ref)
    if u5 then
        u5:Disconnect();
        u5 = nil;
    end;
end;

function u1.GetVelocity(p23) -- Line: 145
    -- upvalues: Vector3_new_ret2 (ref)
    return Vector3_new_ret2;
end;

function u1.GetTargetVelocity(p24) -- Line: 149
    -- upvalues: Vector3_new_ret (ref)
    return Vector3_new_ret;
end;

function u1.GetAcceleration(p25) -- Line: 153
    -- upvalues: u1 (copy)
    return u1.Config.MoveAcceleration;
end;

return u1;