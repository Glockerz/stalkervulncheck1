-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local script_Update = script.Update;
local u1 = {
    LookMode = "Camera",
    HeadLook = false,
    ArmsLook = false
};
local u2 = {};

local function getNeck(p3: userdata, p4: userdata) -- Line: 33
    if not (p3 and p4) then
        return;
    end;

    if p4.RigType == Enum.HumanoidRigType.R6 then
        local Torso = p3:FindFirstChild("Torso");

        if Torso then
            Torso = Torso:FindFirstChild("Neck");
        end;

        return Torso;
    end;

    if p4.RigType == Enum.HumanoidRigType.R15 then
        local Head = p3:FindFirstChild("Head");

        if Head then
            Head = Head:FindFirstChild("Neck");
        end;

        return Head;
    end;
end;

local function getShoulders(p5: userdata, p6: userdata) -- Line: 46
    if not (p5 and p6) then
        return;
    end;

    if p6.RigType == Enum.HumanoidRigType.R6 then
        local Torso = p5:FindFirstChild("Torso");
        local v7;

        if Torso then
            v7 = Torso:FindFirstChild("Left Shoulder");
        else
            v7 = Torso;
        end;

        if Torso then
            Torso = Torso:FindFirstChild("Right Shoulder");
        end;

        return v7, Torso;
    end;

    if p6.RigType == Enum.HumanoidRigType.R15 then
        local LeftUpperArm = p5:FindFirstChild("LeftUpperArm");
        local RightUpperArm = p5:FindFirstChild("RightUpperArm");

        if LeftUpperArm then
            LeftUpperArm = LeftUpperArm:FindFirstChild("LeftShoulder");
        end;

        if RightUpperArm then
            RightUpperArm = RightUpperArm:FindFirstChild("RightShoulder");
        end;

        return LeftUpperArm, RightUpperArm;
    end;
end;

local function getLookDirection(p8: userdata) -- Line: 64
    -- upvalues: Mouse (copy), u1 (copy)
    local LookVector = p8.CFrame:ToObjectSpace(workspace.CurrentCamera.CFrame).LookVector;
    local LookVector2 = p8.CFrame:ToObjectSpace(CFrame.lookAt(p8.CFrame.Position, Mouse.Hit.Position)).LookVector;
    local v9 = Vector3.new(0, 0, -1);

    if u1.LookMode == "Camera" then
        return LookVector;
    end;

    if u1.LookMode ~= "Mouse" then
        LookVector2 = v9;
    end;

    return LookVector2;
end;

local function getDefaultNeckCFrame(p10: userdata) -- Line: 78
    if p10.RigType == Enum.HumanoidRigType.R6 then
        return CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0);
    end;

    if p10.RigType == Enum.HumanoidRigType.R15 then
        return CFrame.new(-5.96046448e-8, 0.800017118, 1.1920929e-7, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    end;
end;

local function getDefaultShoulderCFrames(p11: userdata) -- Line: 86
    if p11.RigType == Enum.HumanoidRigType.R6 then
        return CFrame.new(-1, 0.5, 0) * CFrame.Angles(0, -1.55, 0), CFrame.new(1, 0.5, 0) * CFrame.Angles(0, 1.55, 0);
    end;

    if p11.RigType == Enum.HumanoidRigType.R15 then
        return CFrame.new(-1, 0.56301713, 1.1920929e-7, 1, 0, 0, 0, 1, 0, 0, 0, 1), CFrame.new(0.99999994, 0.56301713, 1.1920929e-7, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    end;
end;

local function getNeckTransformerCFrame(p12: userdata, p13: vector) -- Line: 98
    if p12.RigType == Enum.HumanoidRigType.R6 then
        return CFrame.Angles(-math.asin(p13.Y), 0, -math.asin(p13.X));
    end;

    if p12.RigType == Enum.HumanoidRigType.R15 then
        return CFrame.Angles(math.asin(p13.Y), -math.asin(p13.X), 0);
    end;
end;

local function getShoulderTransformerCFrames(p14: userdata, p15: vector) -- Line: 106
    if p14.RigType == Enum.HumanoidRigType.R6 then
        return CFrame.Angles(0, 0, -math.asin(p15.Unit.Y)), CFrame.Angles(0, 0, (math.asin(p15.Unit.Y)));
    end;

    if p14.RigType == Enum.HumanoidRigType.R15 then
        return CFrame.Angles(math.asin(p15.Unit.Y), 0, 0), CFrame.Angles(math.asin(p15.Unit.Y), 0, 0);
    end;
end;

local function updatePlayer(p16: userdata, p17: vector, p18: boolean, p19: boolean) -- Line: 118
    -- upvalues: getNeck (copy), getShoulders (copy), getDefaultNeckCFrame (copy), getNeckTransformerCFrame (copy), TweenService (copy), getDefaultShoulderCFrames (copy), getShoulderTransformerCFrames (copy)
    local Character = p16.Character;

    if not Character then
        return;
    end;

    local Humanoid = Character:FindFirstChild("Humanoid");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v20 = getNeck(Character, Humanoid);
    local v21, v22 = getShoulders(Character, Humanoid);

    if not (Humanoid and (HumanoidRootPart and (v20 and (v21 and v22)))) then
        return;
    end;

    local v23 = Character:GetAttribute("LowReady") or 0;

    if v23 > 0 and p19 then
        p17 = (CFrame.new() * CFrame.Angles(-0.13962634015954636 * v23, 0, 0)):VectorToWorldSpace(p17);
    end;

    local TweenInfo_new_ret = TweenInfo.new(0.1);

    if p18 then
        TweenService:Create(v20, TweenInfo_new_ret, {
            C0 = getDefaultNeckCFrame(Humanoid) * getNeckTransformerCFrame(Humanoid, p17)
        }):Play();
    else
        local v24 = getDefaultNeckCFrame(Humanoid);

        if v20.C0 ~= v24 then
            TweenService:Create(v20, TweenInfo_new_ret, {
                C0 = v24
            }):Play();
        end;
    end;

    if not p19 then
        local v25, v26 = getDefaultShoulderCFrames(Humanoid);

        if v21.C0 ~= v25 then
            TweenService:Create(v21, TweenInfo_new_ret, {
                C0 = v25
            }):Play();
        end;

        if v22.C0 ~= v26 then
            TweenService:Create(v22, TweenInfo_new_ret, {
                C0 = v26
            }):Play();
        end;

        return;
    end;

    local v27, v28 = getDefaultShoulderCFrames(Humanoid);
    local v29, v30 = getShoulderTransformerCFrames(Humanoid, p17);
    TweenService:Create(v21, TweenInfo_new_ret, {
        C0 = v27 * v29
    }):Play();
    TweenService:Create(v22, TweenInfo_new_ret, {
        C0 = v28 * v30
    }):Play();
end;

function u1.Commence(p31: table, p32: string, p33: boolean, p34: boolean, u35: number) -- Line: 168
    -- upvalues: u1 (copy), script_Update (copy), u2 (copy), RunService (copy), LocalPlayer (copy), getLookDirection (copy), updatePlayer (copy)
    u1.LookMode = p32 or "Camera";
    u1.HeadLook = p33 or false;
    u1.ArmsLook = p34 or false;
    script_Update.OnClientEvent:Connect(function(p36: userdata, ...) -- Line: 173
        -- upvalues: u2 (ref)
        u2[p36] = { ... };
    end);
    local u37 = 0;
    RunService:BindToRenderStep("Update", Enum.RenderPriority.Character.Value + 10, function(p38) -- Line: 179
        -- upvalues: LocalPlayer (ref), getLookDirection (ref), updatePlayer (ref), u1 (ref), u37 (ref), u35 (copy), u2 (ref)
        local Character = LocalPlayer.Character;

        if not Character then
            return;
        end;

        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        updatePlayer(LocalPlayer, getLookDirection(HumanoidRootPart), u1.HeadLook, u1.ArmsLook);

        if (u35 or 0.1) <= u37 + 0.016666666666666666 then
            u37 = 0;

            for i, v in pairs(u2) do
                updatePlayer(i, v[1], unpack(v[2]));
            end;
        end;

        u37 = u37 + p38;
    end);

    return u1;
end;

return u1;