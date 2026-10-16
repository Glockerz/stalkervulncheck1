-- Decompiled with Potassium's decompiler.

local LocalPlayer = game.Players.LocalPlayer;
local Humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAppearanceLoaded:Wait()):WaitForChild("Humanoid");
local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local u1 = game.Lighting:FindFirstChild("DamageColorCorrection") or Instance.new("ColorCorrectionEffect", game.Lighting);
u1.Name = "DamageColorCorrection";
local Heartbeat = script.Parent.Heartbeat;
Heartbeat.Volume = 0;
Heartbeat:Play();
local Damage2d = script.Parent.Damage2d;
Damage2d.BackgroundTransparency = 1;
Damage2d.ImageTransparency = 1;
local Health = Humanoid.Health;

if require(game.ReplicatedStorage.SPH_Assets.GameConfig).lowHealthEffects then
    local function UpdateHealthFX() -- Line: 24
        -- upvalues: Health (ref), Humanoid (copy), Damage2d (copy), TweenService (copy), TweenInfo_new_ret (copy), Heartbeat (copy), u1 (copy)
        if Health - Humanoid.Health > 15 then
            Damage2d.ImageTransparency = 0;
        end;

        local Health2 = Humanoid.Health;
        local v2 = Health2 / 70;

        if v2 >= 1 or Health2 <= 0 then
            TweenService:Create(Damage2d, TweenInfo_new_ret, {
                ImageTransparency = 1
            }):Play();
            TweenService:Create(Heartbeat, TweenInfo_new_ret, {
                Volume = 0
            }):Play();
            TweenService:Create(u1, TweenInfo_new_ret, {
                Brightness = 0,
                Contrast = 0,
                Saturation = 0
            }):Play();

            return;
        end;

        TweenService:Create(Damage2d, TweenInfo_new_ret, {
            ImageTransparency = v2
        }):Play();
        TweenService:Create(Heartbeat, TweenInfo_new_ret, {
            Volume = 1 - v2
        }):Play();
        TweenService:Create(u1, TweenInfo_new_ret, {
            Brightness = -0.2 + 0.2 * v2,
            Contrast = 0.2 - 0.2 * v2,
            Saturation = -1 + v2
        }):Play();
    end;

    Humanoid:GetPropertyChangedSignal("Health"):Connect(function() -- Line: 62
        -- upvalues: UpdateHealthFX (copy), Health (ref), Humanoid (copy)
        UpdateHealthFX();
        Health = Humanoid.Health;
    end);
    UpdateHealthFX();
end;