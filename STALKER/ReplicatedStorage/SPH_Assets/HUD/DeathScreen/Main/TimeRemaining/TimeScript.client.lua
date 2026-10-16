-- Decompiled with Potassium's decompiler.

local RespawnTime = game.Players.RespawnTime;
local LocalPlayer = game.Players.LocalPlayer;
local script_Parent = script.Parent;
local Parent = script.Parent.Parent;
local Blackout = script.Parent.Parent.Blackout;
local TweenService = game:GetService("TweenService");
local u1 = false;
local u2 = false;

repeat
    task.wait();
until LocalPlayer.Character;

LocalPlayer.Character:WaitForChild("Humanoid");
LocalPlayer.Character.Humanoid.Died:Connect(function() -- Line: 14
    -- upvalues: u1 (ref), TweenService (copy), Parent (copy), script_Parent (copy)
    u1 = true;
    local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quint);
    TweenService:Create(Parent, TweenInfo_new_ret, {
        BackgroundTransparency = 0,
        Position = UDim2.fromScale(0, 0)
    }):Play();
    TweenService:Create(script_Parent, TweenInfo_new_ret, {
        TextTransparency = 0
    }):Play();
end);
game:GetService("RunService").RenderStepped:Connect(function(p3) -- Line: 21
    -- upvalues: u1 (ref), RespawnTime (ref), u2 (ref), TweenService (copy), script_Parent (copy), Blackout (copy)
    if u1 then
        RespawnTime = RespawnTime - p3;

        if RespawnTime < 1 and not u2 then
            u2 = true;
            local TweenInfo_new_ret = TweenInfo.new(0.5);
            TweenService:Create(script_Parent, TweenInfo_new_ret, {
                TextTransparency = 1,
                Position = UDim2.fromScale(0.5, 0.15)
            }):Play();
            TweenService:Create(Blackout, TweenInfo_new_ret, {
                BackgroundTransparency = 0
            }):Play();
        end;

        local v4;

        if RespawnTime > 0.01 then
            local v5 = tostring(RespawnTime);

            if RespawnTime < 10 then
                v5 = "0" .. v5;
            end;

            local v6 = string.sub(v5, 1, 2) .. ".";
            local v7;

            if #v5 >= 4 then
                v7 = v6 .. string.sub(v5, 4, 4);
            else
                v7 = v6 .. "00";
            end;

            if #v5 >= 5 then
                v4 = v7 .. string.sub(v5, 5, 5);
            else
                v4 = v7 .. "0";
            end;
        else
            v4 = "00.00";
        end;

        script_Parent.Text = v4;
    end;
end);