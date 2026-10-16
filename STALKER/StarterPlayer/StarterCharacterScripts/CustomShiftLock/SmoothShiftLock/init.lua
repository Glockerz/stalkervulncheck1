-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Maid = require(script.Utils:WaitForChild("Maid"));
local Spring = require(script.Utils:WaitForChild("Spring"));
local LocalPlayer = Players.LocalPlayer;
local ToggleShiftLock = script:WaitForChild("ToggleShiftLock");
local u2 = {
    CHARACTER_SMOOTH_ROTATION = true,
    CHARACTER_ROTATION_SPEED = 3,
    TRANSITION_SPRING_DAMPER = 0.7,
    CAMERA_TRANSITION_IN_SPEED = 10,
    CAMERA_TRANSITION_OUT_SPEED = 14,
    LOCKED_CAMERA_OFFSET = Vector3.new(2.75, 0.25, 0),
    SHIFT_LOCK_KEYBINDS = { Enum.KeyCode.LeftControl, Enum.KeyCode.RightControl }
};
local u3 = Maid.new();

local function IsFirstPerson() -- Line: 32
    -- upvalues: Workspace (copy), LocalPlayer (copy)
    local CurrentCamera = Workspace.CurrentCamera;
    local v4 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head");

    if v4 then
        return (CurrentCamera.CFrame.Position - v4.Position).Magnitude < 1;
    end;

    return false;
end;

function u1.Init(u5) -- Line: 39
    -- upvalues: Maid (copy), LocalPlayer (copy)
    local v6 = Maid.new();
    task.wait(1);

    if game.Players.LocalPlayer.Character then
        u5:CharacterAdded();
    end;

    v6:GiveTask(LocalPlayer.CharacterAdded:Connect(function() -- Line: 46
        -- upvalues: u5 (copy)
        u5:CharacterAdded();
    end));
end;

function u1.CharacterAdded(p7) -- Line: 51
    -- upvalues: u1 (copy), LocalPlayer (copy), Workspace (copy), Maid (copy), Spring (copy), u2 (copy), UserInputService (copy), TweenService (copy), RunService (copy), ToggleShiftLock (copy)
    game.ReplicatedStorage.miscEvents.Test2:Fire(false);
    local u8 = setmetatable({}, u1);
    u8.Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    u8.RootPart = u8.Character:WaitForChild("HumanoidRootPart");
    u8.Humanoid = u8.Character:WaitForChild("Humanoid");
    u8.Head = u8.Character:WaitForChild("Head");
    u8.PlayerMouse = LocalPlayer:GetMouse();
    u8.Camera = Workspace.CurrentCamera;
    u8.defaultFOV = 70;
    u8.Zoomed = false;
    u8.muzzleAttach = nil;
    u8.gunModel = nil;
    u8.ENABLED = true;
    u8._wasShiftLockEnabled = true;
    u8.crosshairLocation = Instance.new("Attachment");
    u8.crosshairLocation.Parent = workspace.Terrain;
    u8.crosshairBeam = Instance.new("Beam");
    u8.crosshairBeam.Enabled = true;
    u8.crosshairUI = script.CrosshairUI:Clone();
    u8.crosshairUI.Enabled = false;
    u8.crosshairUI.Parent = u8.crosshairLocation;
    u8.connectionsMaid = Maid.new();
    u8.camOffsetSpring = Spring.new(Vector3.new(0, 0, 0));
    u8.camOffsetSpring.Damper = u2.TRANSITION_SPRING_DAMPER;
    u8:ToggleShiftLock(true);
    u8.connectionsMaid:GiveTask(UserInputService.InputBegan:Connect(function(p9, p10) -- Line: 86
        -- upvalues: Workspace (ref), LocalPlayer (ref), u2 (ref), u8 (copy), TweenService (ref)
        if p10 then
            return;
        end;

        if p9.KeyCode == Enum.KeyCode.LeftControl or p9.KeyCode == Enum.KeyCode.RightControl then
            local CurrentCamera = Workspace.CurrentCamera;
            local v11 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head");
            local v12;

            if v11 then
                v12 = (CurrentCamera.CFrame.Position - v11.Position).Magnitude < 1;
            else
                v12 = false;
            end;

            if v12 then
                return;
            end;
        end;

        for _, v in pairs(u2.SHIFT_LOCK_KEYBINDS) do
            local v13, v14, v15;

            if p9.KeyCode == v and (u8.Humanoid and u8.Humanoid.Health ~= 0) then
                local CurrentCamera = Workspace.CurrentCamera;
                local v16 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head");
                local v17;

                if v16 then
                    v17 = (CurrentCamera.CFrame.Position - v16.Position).Magnitude < 1;
                else
                    v17 = false;
                end;

                if v17 then
                    if p9.UserInputType == v and (u8.Humanoid and (u8.Humanoid.Health ~= 0 and u8.Character:FindFirstChildOfClass("Tool"))) then
                        v13 = Workspace.CurrentCamera;
                        v14 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head");

                        if v14 then
                            v15 = (v13.CFrame.Position - v14.Position).Magnitude < 1;
                        else
                            v15 = false;
                        end;

                        if not v15 then
                            u8:ToggleShiftLock(not u8.ENABLED);
                        end;
                    end;
                else
                    u8:ToggleShiftLock(not u8.ENABLED);
                end;
            elseif p9.UserInputType == v and (u8.Humanoid and (u8.Humanoid.Health ~= 0 and u8.Character:FindFirstChildOfClass("Tool"))) then
                v13 = Workspace.CurrentCamera;
                v14 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head");

                if v14 then
                    v15 = (v13.CFrame.Position - v14.Position).Magnitude < 1;
                else
                    v15 = false;
                end;

                if not v15 then
                    u8:ToggleShiftLock(not u8.ENABLED);
                end;
            end;
        end;

        if p9.UserInputType == Enum.UserInputType.MouseButton2 then
            if not u8.ENABLED then
                return;
            end;

            local CurrentCamera = Workspace.CurrentCamera;
            local v18 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head");
            local v19;

            if v18 then
                v19 = (CurrentCamera.CFrame.Position - v18.Position).Magnitude < 1;
            else
                v19 = false;
            end;

            if v19 then
                return;
            end;

            print("Zoom ON");
            game.ReplicatedStorage.miscEvents.Test:Fire(true);
            u8.Zoomed = true;
            u8.crosshairUI.Enabled = true;
            local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            TweenService:Create(u8.Camera, TweenInfo_new_ret, {
                FieldOfView = 30
            }):Play();

            if u8.Character.WeaponRig and u8.Character.WeaponRig.Weapon:FindFirstChildOfClass("Model") then
                local v20 = u8.Character.WeaponRig.Weapon:FindFirstChildOfClass("Model");
                u8.gunModel = v20;
                u8.muzzleAttach = v20.Grip.Muzzle;
            end;
        end;
    end));
    u8.connectionsMaid:GiveTask(UserInputService.InputEnded:Connect(function(p21, p22) -- Line: 123
        -- upvalues: u2 (ref), u8 (copy), Workspace (ref), LocalPlayer (ref), TweenService (ref)
        if p22 then
            return;
        end;

        for _, v in pairs(u2.SHIFT_LOCK_KEYBINDS) do
            if p21.UserInputType == v and (u8.Humanoid and (u8.Humanoid.Health ~= 0 and u8.Character:FindFirstChildOfClass("Tool"))) then
                u8:ToggleShiftLock(not u8.ENABLED);
            end;
        end;

        if p21.UserInputType == Enum.UserInputType.MouseButton2 then
            if not u8.ENABLED then
                return;
            end;

            local CurrentCamera = Workspace.CurrentCamera;
            local v23 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head");
            local v24;

            if v23 then
                v24 = (CurrentCamera.CFrame.Position - v23.Position).Magnitude < 1;
            else
                v24 = false;
            end;

            if v24 then
                return;
            end;

            if u8.Zoomed then
                print("Zoom OFF");
                game.ReplicatedStorage.miscEvents.Test:Fire(false);
                u8.Zoomed = false;
                u8.crosshairUI.Enabled = false;
                local v25 = {
                    FieldOfView = u8.defaultFOV
                };
                local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                TweenService:Create(u8.Camera, TweenInfo_new_ret, v25):Play();
            end;
        end;
    end));
    u8.connectionsMaid:GiveTask(RunService.RenderStepped:Connect(function(p26) -- Line: 149
        -- upvalues: u8 (copy), UserInputService (ref)
        if u8.Zoomed then
            if not u8.gunModel then
                return;
            end;

            local muzzleAttach = u8.muzzleAttach;
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
            RaycastParams_new_ret.FilterDescendantsInstances = { u8.gunModel, u8.Character };
            RaycastParams_new_ret.RespectCanCollide = true;
            local v27 = workspace:Raycast(muzzleAttach.WorldPosition, muzzleAttach.WorldCFrame.LookVector * 600, RaycastParams_new_ret);

            if v27 then
                u8.crosshairLocation.WorldPosition = v27.Position;
            else
                u8.crosshairLocation.WorldPosition = muzzleAttach.WorldCFrame.LookVector * 600;
            end;
        end;

        if u8.Head.LocalTransparencyModifier > 0.6 then
            return;
        end;

        if u8.Camera.CameraType ~= Enum.CameraType.Custom then
            return;
        end;

        if (u8.Head.Position - u8.Camera.CFrame.p).Magnitude > 1 then
            u8.Camera.CFrame = u8.Camera.CFrame * CFrame.new(u8.camOffsetSpring.Position);

            if u8.ENABLED and UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
                u8:SetMouseState(u8.ENABLED);
            end;
        end;
    end));
    u8.connectionsMaid:GiveTask(LocalPlayer:GetPropertyChangedSignal("CameraMode"):Connect(function() -- Line: 183
        -- upvalues: Workspace (ref), LocalPlayer (ref), u8 (copy)
        local CurrentCamera = Workspace.CurrentCamera;
        local v28 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head");
        local v29;

        if v28 then
            v29 = (CurrentCamera.CFrame.Position - v28.Position).Magnitude < 1;
        else
            v29 = false;
        end;

        if v29 then
            if u8.ENABLED then
                u8:ToggleShiftLock(false);
                u8._wasShiftLockEnabled = true;
            end;
        elseif u8._wasShiftLockEnabled then
            u8:ToggleShiftLock(true);
            u8._wasShiftLockEnabled = false;
        end;
    end));
    u8.connectionsMaid:GiveTask(ToggleShiftLock.Event:Connect(function(p30) -- Line: 197
        -- upvalues: u8 (copy)
        if u8.Humanoid and u8.Humanoid.Health ~= 0 then
            u8:ToggleShiftLock(p30);
        end;
    end));
    u8.connectionsMaid:GiveTask(u8.Humanoid.Died:Connect(function() -- Line: 203
        -- upvalues: u8 (copy)
        u8:CharacterDiedOrRemoved();
    end));
    u8.connectionsMaid:GiveTask(LocalPlayer.CharacterRemoving:Connect(function() -- Line: 207
        -- upvalues: u8 (copy)
        u8:CharacterDiedOrRemoved();
    end));

    return u8;
end;

function u1.CharacterDiedOrRemoved(p31) -- Line: 214
    -- upvalues: TweenService (copy), u3 (copy)
    p31:ToggleShiftLock(false);
    game.ReplicatedStorage.miscEvents.Test2:Fire(false);
    p31.Zoomed = false;
    p31.camOffsetSpring.Target = Vector3.new(0, 0, 0);
    local v32 = {
        FieldOfView = p31.defaultFOV
    };
    local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    TweenService:Create(p31.Camera, TweenInfo_new_ret, v32):Play();

    if p31.connectionsMaid then
        p31.connectionsMaid:Destroy();
    end;

    u3:DoCleaning();
end;

function u1.IsEnabled(p33) -- Line: 229
    return p33.ENABLED;
end;

function u1.SetMouseState(p34: table, p35: boolean) -- Line: 233
    -- upvalues: UserInputService (copy)
    UserInputService.MouseBehavior = p35 and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default;
end;

function u1.SetMouseIcon(p36: table, p37: boolean) -- Line: 237
end;

function u1.TransitionLockOffset(p38: table, p39: boolean) -- Line: 241
    -- upvalues: u2 (copy)
    if p39 then
        p38.camOffsetSpring.Speed = u2.CAMERA_TRANSITION_IN_SPEED;
        p38.camOffsetSpring.Target = u2.LOCKED_CAMERA_OFFSET;

        return;
    end;

    p38.camOffsetSpring.Speed = u2.CAMERA_TRANSITION_OUT_SPEED;
    p38.camOffsetSpring.Target = Vector3.new(0, 0, 0);
end;

function u1.ToggleShiftLock(u40: table, p41: boolean) -- Line: 251
    -- upvalues: LocalPlayer (copy), u3 (copy), RunService (copy), u2 (copy), TweenService (copy)
    print("shiftlock fire");
    game.ReplicatedStorage.miscEvents.Test2:Fire(p41);
    local v42 = typeof(p41) == "boolean";
    assert(v42, "Enable value is not a boolean.");
    u40.ENABLED = p41;
    LocalPlayer:SetAttribute("ShiftLockEnabled", p41);
    u40:SetMouseState(u40.ENABLED);
    u40:SetMouseIcon(u40.ENABLED);
    u40:TransitionLockOffset(u40.ENABLED);

    if u40.ENABLED then
        u3:GiveTask(RunService.RenderStepped:Connect(function(p43) -- Line: 265
            -- upvalues: u40 (copy), u2 (ref), TweenService (ref), u3 (ref)
            if u40.Humanoid and u40.RootPart then
                u40.Humanoid.AutoRotate = not u40.ENABLED;
            end;

            if u40.ENABLED and u40.Camera.CameraType == Enum.CameraType.Custom then
                if u40.Humanoid.Sit or (u40.Humanoid.PlatformStand or not u2.CHARACTER_SMOOTH_ROTATION) then
                    if not (u40.Humanoid.Sit or u40.Humanoid.PlatformStand) then
                        local _, v44, _ = u40.Camera.CFrame:ToOrientation();
                        u40.RootPart.CFrame = CFrame.new(u40.RootPart.Position) * CFrame.Angles(0, v44, 0);
                    end;
                else
                    local _, v45, _ = u40.Camera.CFrame:ToOrientation();
                    u40.RootPart.CFrame = u40.RootPart.CFrame:Lerp(CFrame.new(u40.RootPart.Position) * CFrame.Angles(0, v45, 0), p43 * 5 * u2.CHARACTER_ROTATION_SPEED);
                end;
            end;

            if not u40.ENABLED then
                if u40.Zoomed then
                    u40.Zoomed = false;
                    u40.crosshairUI.Enabled = false;
                    local v46 = {
                        FieldOfView = u40.defaultFOV
                    };
                    local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                    TweenService:Create(u40.Camera, TweenInfo_new_ret, v46):Play();
                end;

                u3:Destroy();
            end;
        end));
    end;

    return u40;
end;

return u1;