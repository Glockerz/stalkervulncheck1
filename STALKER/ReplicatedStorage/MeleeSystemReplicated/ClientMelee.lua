-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RaycastHitboxV4 = require(game:GetService("ReplicatedStorage").RaycastHitboxV4);
local MeleeSystemReplicated = game:GetService("ReplicatedStorage"):WaitForChild("MeleeSystemReplicated");
local ShakeFunction = require(MeleeSystemReplicated.ShakeFunction);
local ChargeBar = require(MeleeSystemReplicated.ChargeBar);

return {
    Init = function(u1) -- Line: 12, Name: Init
        -- upvalues: ChargeBar (copy), ShakeFunction (copy), Players (copy), RaycastHitboxV4 (copy), MeleeSystemReplicated (copy), UserInputService (copy)
        local MeleeConfig = require(u1:WaitForChild("MeleeConfig"));
        ChargeBar.Init();
        ShakeFunction.Init();
        local LocalPlayer = Players.LocalPlayer;
        local u2 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
        local F = Enum.KeyCode.F;
        local V = Enum.KeyCode.V;
        local u3 = nil;
        local u4 = nil;
        local Remotes = u1:WaitForChild("Remotes");
        Remotes:WaitForChild("Finish");
        Remotes:WaitForChild("Inspect");
        local RemoteEventMelee = Remotes:WaitForChild("RemoteEventMelee");
        local SwingStart = Remotes:WaitForChild("SwingStart");
        local SwingEnd = Remotes:WaitForChild("SwingEnd");
        local dualWield = MeleeConfig.dualWield;
        local u5 = RaycastHitboxV4.new(u1);
        u5.DetectionMode = RaycastHitboxV4.DetectionMode.PartMode;
        u5.Visualizer = true;
        local u6 = nil;
        local u7 = false;
        local u8 = false;
        local u9 = false;
        local u10 = 0;
        local Handle = u1.Handle;
        local MotorGrip = u1:FindFirstChild("MotorGrip");
        local u11 = nil;
        local Children = u1:WaitForChild("SwingAnims"):GetChildren();
        local u12 = MeleeConfig.coolDown or 0;

        local function connectHitbox(u13) -- Line: 57
            -- upvalues: u9 (ref), u2 (copy), Players (ref), LocalPlayer (copy), Handle (ref), u10 (ref), MeleeConfig (copy), RemoteEventMelee (copy)
            u13.OnHit:Connect(function(p14, p15, p16) -- Line: 58
                -- upvalues: u9 (ref), u2 (ref), Players (ref), LocalPlayer (ref), Handle (ref), u10 (ref), MeleeConfig (ref), u13 (copy), RemoteEventMelee (ref)
                if not (p14 and (p14.Parent and u9)) then
                    return;
                end;

                if p14:IsDescendantOf(u2) or p14.Parent:IsA("Tool") then
                    return;
                end;

                local PlayerFromCharacter = Players:GetPlayerFromCharacter(p14.Parent);

                if PlayerFromCharacter and PlayerFromCharacter == LocalPlayer then
                    return;
                end;

                if p14.Parent ~= workspace and p14:IsDescendantOf(Handle.Parent) or p14.Parent:IsA("Accessory") then
                    return;
                end;

                Handle = p14;

                if u10 > MeleeConfig.consecutiveHits then
                    u13:HitStop();

                    return;
                end;

                u10 = u10 + 1;
                RemoteEventMelee:FireServer(p14, p16.Position, p16.Normal);
            end);
        end;

        u1.Equipped:Connect(function() -- Line: 82
            -- upvalues: MeleeConfig (copy), ChargeBar (ref), MotorGrip (copy), MeleeSystemReplicated (ref), u1 (copy), dualWield (copy), u6 (ref), RaycastHitboxV4 (ref), u9 (ref), u3 (ref), u4 (ref), u11 (ref), u2 (copy), u7 (ref), u8 (ref), u5 (copy), Players (ref), LocalPlayer (copy), Handle (ref), u10 (ref), RemoteEventMelee (copy)
            if MeleeConfig.displayChargeBar then
                ChargeBar.StartTracking();
            end;

            if MotorGrip and MotorGrip.Value == true then
                MeleeSystemReplicated.ConnectM6D:FireServer(u1.Handle);
            end;

            if dualWield then
                MeleeSystemReplicated.ConnectM6D:FireServer(u1.Handle, dualWield);
                u1:WaitForChild("Handle2");
                u6 = RaycastHitboxV4.new(u1.Handle2);
                u6.DetectionMode = RaycastHitboxV4.DetectionMode.PartMode;
                u6.Visualizer = true;
            end;

            u9 = false;

            if u3 then
                u3:Stop();
            end;

            if u4 then
                u4:Stop();
            end;

            if u11 then
                u11:Stop();
            end;

            u3 = u2.Humanoid:LoadAnimation(u1.Anims:WaitForChild("idle"));
            u3.Priority = Enum.AnimationPriority.Action;
            u3.Looped = true;
            u3:Play();
            u11 = u2.Humanoid:LoadAnimation(u1.Anims.Equip);
            u11:Play();
            u1.Handle.Equip:Play();
            u7 = false;
            u8 = false;
            ChargeBar.Charge(u11.Length);
            task.delay(u11.Length, function() -- Line: 117
                -- upvalues: u7 (ref), u9 (ref)
                u7 = true;
                u9 = true;
            end);
            local u17 = u5;
            u17.OnHit:Connect(function(p18, p19, p20) -- Line: 58
                -- upvalues: u9 (ref), u2 (ref), Players (ref), LocalPlayer (ref), Handle (ref), u10 (ref), MeleeConfig (ref), u17 (copy), RemoteEventMelee (ref)
                if not (p18 and (p18.Parent and u9)) then
                    return;
                end;

                if p18:IsDescendantOf(u2) or p18.Parent:IsA("Tool") then
                    return;
                end;

                local PlayerFromCharacter = Players:GetPlayerFromCharacter(p18.Parent);

                if PlayerFromCharacter and PlayerFromCharacter == LocalPlayer then
                    return;
                end;

                if p18.Parent ~= workspace and p18:IsDescendantOf(Handle.Parent) or p18.Parent:IsA("Accessory") then
                    return;
                end;

                Handle = p18;

                if u10 > MeleeConfig.consecutiveHits then
                    u17:HitStop();

                    return;
                end;

                u10 = u10 + 1;
                RemoteEventMelee:FireServer(p18, p20.Position, p20.Normal);
            end);

            if u6 then
                local u21 = u6;
                u21.OnHit:Connect(function(p22, p23, p24) -- Line: 58
                    -- upvalues: u9 (ref), u2 (ref), Players (ref), LocalPlayer (ref), Handle (ref), u10 (ref), MeleeConfig (ref), u21 (copy), RemoteEventMelee (ref)
                    if not (p22 and (p22.Parent and u9)) then
                        return;
                    end;

                    if p22:IsDescendantOf(u2) or p22.Parent:IsA("Tool") then
                        return;
                    end;

                    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p22.Parent);

                    if PlayerFromCharacter and PlayerFromCharacter == LocalPlayer then
                        return;
                    end;

                    if p22.Parent ~= workspace and p22:IsDescendantOf(Handle.Parent) or p22.Parent:IsA("Accessory") then
                        return;
                    end;

                    Handle = p22;

                    if u10 > MeleeConfig.consecutiveHits then
                        u21:HitStop();

                        return;
                    end;

                    u10 = u10 + 1;
                    RemoteEventMelee:FireServer(p22, p24.Position, p24.Normal);
                end);
            end;
        end);
        u1.Unequipped:Connect(function() -- Line: 129
            -- upvalues: u9 (ref), u7 (ref), u8 (ref), u3 (ref), u11 (ref), u4 (ref), u6 (ref), MotorGrip (copy), MeleeSystemReplicated (ref), u1 (copy), u5 (copy), MeleeConfig (copy), ChargeBar (ref)
            u9 = false;
            u7 = false;
            u8 = false;

            if u3 then
                u3:Stop();
            end;

            if u11 then
                u11:Stop();
            end;

            if u4 then
                u4:Stop();
            end;

            if u6 then
                u6:HitStop();
                u6:Destroy();
            end;

            if MotorGrip and MotorGrip.Value == true then
                MeleeSystemReplicated.DisconnectM6D:FireServer(u1.Handle);
            end;

            u5:HitStop();

            if MeleeConfig.displayChargeBar then
                ChargeBar.StopTracking();
            end;
        end);
        u1.Activated:Connect(function() -- Line: 152, Name: swing
            -- upvalues: u11 (ref), u7 (ref), u8 (ref), u9 (ref), Children (copy), u4 (ref), u2 (copy), MeleeConfig (copy), ShakeFunction (ref), ChargeBar (ref), u12 (copy), u5 (copy), SwingStart (copy), u1 (copy), SwingEnd (copy), u6 (ref), u10 (ref), Handle (ref)
            if u11 and u11.IsPlaying then
                return;
            end;

            if not (u7 and (not u8 and u9)) then
                return;
            end;

            u8 = true;
            u7 = false;
            local v25 = Children[math.random(1, #Children)];
            u4 = u2.Humanoid:LoadAnimation(v25);
            local u26 = false;

            if MeleeConfig.shakeCamera then
                ShakeFunction.Shake(MeleeConfig.camShakeSettings);
            end;

            ChargeBar.Charge(u4.Length + u12);
            u4:GetMarkerReachedSignal("HitStart"):Connect(function() -- Line: 169
                -- upvalues: u26 (ref), u5 (ref), SwingStart (ref), u1 (ref)
                if not u26 then
                    u26 = true;
                    u5:HitStart();
                    SwingStart:FireServer(u1);
                end;
            end);
            u4:GetMarkerReachedSignal("HitEnd"):Connect(function() -- Line: 177
                -- upvalues: u5 (ref), SwingEnd (ref), u1 (ref)
                u5:HitStop();
                SwingEnd:FireServer(u1);
            end);
            u4:GetMarkerReachedSignal("HitStart2"):Connect(function() -- Line: 182
                -- upvalues: u6 (ref), u26 (ref), SwingStart (ref), u1 (ref)
                if u6 and not u26 then
                    u26 = true;
                    u6:HitStart();
                    SwingStart:FireServer(u1);
                end;
            end);
            u4:GetMarkerReachedSignal("HitEnd2"):Connect(function() -- Line: 190
                -- upvalues: u6 (ref), SwingEnd (ref), u1 (ref)
                if u6 then
                    u6:HitStop();
                    SwingEnd:FireServer(u1);
                end;
            end);
            u4:Play();
            u4.Stopped:Connect(function() -- Line: 198
                -- upvalues: u12 (ref), u8 (ref), u7 (ref), u10 (ref), Handle (ref), u1 (ref)
                task.wait(u12);
                u8 = false;
                u7 = true;
                u10 = 0;
                Handle = u1.Handle;
            end);
        end);
        UserInputService.InputBegan:Connect(function(p27, p28) -- Line: 209
            -- upvalues: F (copy), V (copy)
            if p28 then
                return;
            end;

            if p27.KeyCode == F then
                return;
            end;

            local _ = p27.KeyCode == V;
        end);
    end
};