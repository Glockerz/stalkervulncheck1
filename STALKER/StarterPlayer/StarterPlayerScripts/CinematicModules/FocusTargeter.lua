-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CinematicCameraConfig = require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"));
local v1 = {};
local u2 = nil;

function v1.Enter(p3, p4) -- Line: 34
    -- upvalues: u2 (ref), Players (copy), CinematicCameraConfig (copy)
    u2 = Players.LocalPlayer:GetMouse();
    p4.focus.target = nil;
    p4.focus.distance = CinematicCameraConfig.Focus.DefaultDistance;
    p4.focus.distanceOffset = 0;
    p4.focus.locked = false;
    p4.lockTarget = nil;
end;

function v1.Tick(p5, p6, p7) -- Line: 43
    -- upvalues: u2 (ref), Players (copy), CinematicCameraConfig (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local actions = p6.actions;

    if actions.focusPickThisFrame then
        local UnitRay = u2.UnitRay;
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        local Character = Players.LocalPlayer.Character;
        RaycastParams_new_ret.FilterDescendantsInstances = Character and { Character } or {};
        local v8 = workspace:Raycast(workspace_CurrentCamera.CFrame.Position, UnitRay.Direction * 500, RaycastParams_new_ret);

        if v8 and (v8.Instance and v8.Instance:IsA("BasePart")) then
            if actions.focusPickShiftHeld then
                p6.focus.target = v8.Instance;
                p6.focus.distance = v8.Distance;
                p6.focus.distanceOffset = 0;
                p6.focus.locked = true;
            else
                p6.lockTarget = v8.Instance;
            end;
        end;
    end;

    if actions.breakFocusThisFrame then
        p6.focus.target = nil;
        p6.focus.distance = CinematicCameraConfig.Focus.DefaultDistance;
        p6.focus.distanceOffset = 0;
        p6.focus.locked = false;
        p6.lockTarget = nil;
    end;

    if p6.focus.locked then
        local target = p6.focus.target;

        if target and target.Parent then
            p6.focus.distance = (workspace_CurrentCamera.CFrame.Position - target.Position).Magnitude;

            if actions.scroll ~= 0 then
                local focus = p6.focus;
                focus.distanceOffset = focus.distanceOffset + actions.scroll * CinematicCameraConfig.Focus.ScrollFineStep;
            end;
        else
            p6.focus.target = nil;
            p6.focus.locked = false;
            p6.focus.distanceOffset = 0;
        end;
    end;

    if p6.lockTarget and not p6.lockTarget.Parent then
        p6.lockTarget = nil;
    end;
end;

function v1.Exit(p9) -- Line: 98
end;

return v1;