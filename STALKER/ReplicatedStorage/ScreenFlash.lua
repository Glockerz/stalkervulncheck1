-- Decompiled with Potassium's decompiler.

local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local WeatherConfig = require(ReplicatedStorage:WaitForChild("WeatherConfig"));
local WeatherMath = require(ReplicatedStorage:WaitForChild("WeatherMath"));
local Color3_new_ret = Color3.new(1, 1, 1);
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = (-1 / 0);

local function ensure() -- Line: 31
    -- upvalues: u2 (ref), Color3_new_ret (copy), Lighting (copy), RunService (copy), u3 (ref), WeatherMath (copy), WeatherConfig (copy)
    if u2 and u2.Parent then
        return;
    end;

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "ZoneFlash";
    ColorCorrectionEffect.Brightness = 0;
    ColorCorrectionEffect.TintColor = Color3_new_ret;
    ColorCorrectionEffect.Parent = Lighting;
    u2 = ColorCorrectionEffect;
    RunService.RenderStepped:Connect(function() -- Line: 39
        -- upvalues: u3 (ref), WeatherMath (ref), ColorCorrectionEffect (copy), WeatherConfig (ref), Color3_new_ret (ref)
        if not u3 then
            return;
        end;

        local v5 = os.clock() - u3.start;
        local v6 = WeatherMath.FlashEnvelope(v5);
        ColorCorrectionEffect.Brightness = math.min(u3.peak * v6, WeatherConfig.FLASH_MAX_BRIGHTNESS);
        ColorCorrectionEffect.TintColor = Color3_new_ret:Lerp(u3.tint, v6);

        if WeatherConfig.FLASH_RISE_SECONDS + WeatherConfig.FLASH_DECAY_SECONDS <= v5 then
            ColorCorrectionEffect.Brightness = 0;
            ColorCorrectionEffect.TintColor = Color3_new_ret;
            u3 = nil;
        end;
    end);
end;

function v1.Trigger(p7: number, p8) -- Line: 60
    -- upvalues: RunService (copy), u4 (ref), WeatherConfig (copy), ensure (copy), u3 (ref), Color3_new_ret (copy)
    if RunService:IsServer() then
        return false;
    end;

    local os_clock_ret = os.clock();

    if os_clock_ret - u4 < WeatherConfig.FLASH_MIN_INTERVAL then
        return false;
    end;

    u4 = os_clock_ret;
    ensure();
    local v9 = {
        start = os_clock_ret
    };
    local v10 = tonumber(p7) or 0;
    v9.peak = math.clamp(v10, 0, 1) * WeatherConfig.FLASH_MAX_BRIGHTNESS;
    v9.tint = p8 or Color3_new_ret;
    u3 = v9;

    return true;
end;

return v1;