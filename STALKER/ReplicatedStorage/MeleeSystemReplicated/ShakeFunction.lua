-- Decompiled with Potassium's decompiler.

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
ReplicatedStorage:WaitForChild("MeleeSystemReplicated");
local CameraShaker = require(ReplicatedStorage.CameraShaker);
local u2 = nil;

local function ShakeCamera(p3) -- Line: 15
    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * p3;
end;

function v1.Init() -- Line: 20
    -- upvalues: u2 (ref), CameraShaker (copy), ShakeCamera (copy)
    u2 = CameraShaker.new(Enum.RenderPriority.Camera.Value + 1, ShakeCamera);
    u2:Start();
end;

function v1.Shake(p4) -- Line: 26
    -- upvalues: u2 (ref)
    if u2 then
        u2:ShakeOnce(p4.magnitude, p4.rougness, p4.fadein, p4.fadeout, p4.PositionInfluence, p4.RotationInfluence);
    end;
end;

function v1.miscShake(p5) -- Line: 39
    -- upvalues: u2 (ref), CameraShaker (copy)
    if u2 then
        u2:Shake(p5 or CameraShaker.Presets.Bump);
    end;
end;

function v1.Stop() -- Line: 47
    -- upvalues: u2 (ref)
    if u2 then
        u2:Stop();
    end;
end;

return v1;