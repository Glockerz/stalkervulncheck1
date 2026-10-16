-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
u1.__index = u1;
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Functions = require(script:WaitForChild("Functions"));
local u3 = true;
game.Players.LocalPlayer.CharacterAdded:Connect(function() -- Line: 14
    -- upvalues: u3 (ref)
    if u3 then
        u3 = false;
    end;
end);

function u1.New(p4, p5, p6, p7, p8, p9) -- Line: 21
    -- upvalues: Functions (copy), u2 (copy), u1 (copy)
    local v10 = {
        UI = p4,
        SizeX = 5,
        SizeY = 1
    };
    local v11, v12, v13, v14, v15, v16, v17 = Functions:CreateHairs(p4, v10.SizeX, v10.SizeY);
    v10.Top = v11;
    v10.Bottom = v12;
    v10.Left = v13;
    v10.Right = v14;
    v10.HitMarker = v15;
    v10.CenterDot = v16;
    v10.ImageCrosshair = v17;
    v10.Spreading = {
        Spread = p5 or 20,
        MaxSpread = p6 or 60,
        MinSpread = p5 or 20,
        DecreasePerSecond = p7 or 40,
        IncreasePerSecond = p8 or 30
    };

    if not (p9 and (type(p9) == "boolean" and p9)) then
        p9 = false;
    end;

    v10.FollowingMouse = p9;
    v10.Locked = false;
    v10.WorldPosition = nil;
    v10.show = true;
    v10.Hairs = {
        v10.Top,
        v10.Bottom,
        v10.Left,
        v10.Right
    };
    v10.EasingStyle = Enum.EasingStyle.Linear;
    v10.EasingDirection = Enum.EasingDirection.InOut;
    v10.HitMarker = {
        fadeTime = 0.25,
        hitmarker = v10.HitMarker,
        size = UDim2.fromOffset(50, 50),
        default = Color3.fromRGB(255, 255, 255),
        headshot = Color3.fromRGB(255, 0, 0),
        easingStyle = Enum.EasingStyle.Linear,
        easingDirection = Enum.EasingDirection.InOut,
        Image = {
            default = "rbxassetid://285779644",
            headshot = nil
        }
    };
    v10.CenterDot = {
        enabled = false,
        transparency = 0,
        Image = "rbxassetid://11003529439",
        centerdot = v10.CenterDot,
        size = UDim2.fromOffset(7.5, 7.5)
    };
    v10.ImageCrosshair = {
        enabled = false,
        Image = "rbxassetid://12550071496",
        crosshair = v10.ImageCrosshair
    };
    table.insert(u2, v10);
    Functions:UpdateEnabled(v10.Hairs, false);

    return setmetatable(v10, u1);
end;

function u1.Enable(p18) -- Line: 88
    -- upvalues: UserInputService (copy), Functions (copy)
    p18.Enabled = true;
    UserInputService.MouseIconEnabled = false;
    Functions:UpdateEnabled(p18.Hairs, p18.Enabled);
end;

function u1.Disable(p19) -- Line: 95
    -- upvalues: UserInputService (copy), Functions (copy)
    p19.Enabled = false;
    UserInputService.MouseIconEnabled = true;
    Functions:UpdateEnabled(p19.Hairs, p19.Enabled);
end;

function u1.Lock(p20, p21) -- Line: 101
    p20.Locked = p21 or true;
end;

function u1.FollowMouse(p22, p23) -- Line: 105
    p22.FollowingMouse = p23 or true;
end;

function u1.UseMuzzleAttach(p24, p25, p26, p27) -- Line: 110
    local v28 = p26 or 600;
    local v29 = workspace:Raycast(p25.WorldPosition, p25.WorldCFrame.LookVector * v28, p27);
    p24:SetWorldPosition(v29 and v29.Position or p25.WorldPosition + p25.WorldCFrame.LookVector * v28);
    p24.FollowingMouse = false;
end;

function u1.SetWorldPosition(p30, p31) -- Line: 120
    p30.WorldPosition = p31;
    p30.FollowingMouse = false;
end;

function u1.Shove(p32, p33) -- Line: 127
    -- upvalues: RunService (copy)
    if not p33 then
        p32.Spreading.Spread = p32.Spreading.Spread / (p32.Spreading.IncreasePerSecond * RunService.Heartbeat:Wait());

        return;
    end;

    local v34 = type(p33) == "number" and p33 and p33 or p33.Magnitude;
    p32.Spreading.Spread = p32.Spreading.Spread + v34;
end;

function u1.SmoothSet(p35, p36, p37, p38) -- Line: 138
    -- upvalues: TweenService (copy), RunService (copy)
    print("MAKING SMOOTH");
    local v39 = tick();
    local Spread = p35.Spreading.Spread;

    while tick() - v39 < p37 do
        local Value = TweenService:GetValue((tick() - v39) / p37, p35.EasingStyle or Enum.EasingStyle.Linear, p35.EasingDirection or Enum.EasingDirection.InOut);
        p35.Spreading.Spread = Spread + (p36 - Spread) * Value;
        RunService.Heartbeat:Wait();
    end;

    if p38 then
        p35.Spreading.MinSpread = p35.Spreading.Spread;
    end;

    p35.Spreading.Spread = p36;
end;

function u1.Set(p40, p41) -- Line: 153
    p40.Spreading.Spread = tonumber(p41);
end;

function u1.Size(p42, p43, p44) -- Line: 158
    if type(p43) ~= "number" or type(p44) ~= "number" then
        return;
    end;

    p42.SizeX = p43;
    p42.SizeY = p44;
    p42.Top.Size = UDim2.fromOffset(p44, p43);
    p42.Bottom.Size = UDim2.fromOffset(p44, p43);
    p42.Left.Size = UDim2.fromOffset(p43, p44);
    p42.Right.Size = UDim2.fromOffset(p43, p44);
end;

function u1.Display(u45, p46) -- Line: 169
    local function ApplyAll(p47, p48) -- Line: 170
        -- upvalues: u45 (copy)
        for _, v in pairs(u45.Hairs) do
            v[p47] = p48;
        end;
    end;

    for i, v in pairs(p46) do
        if pcall(function() -- Line: 176
            -- upvalues: u45 (copy), i (copy)
            local _ = u45.Top[i];
        end) then
            local v49 = v;
            local v50 = i;

            for _, v2 in pairs(u45.Hairs) do
                v2[v50] = v49;
            end;
        end;
    end;
end;

function u1.Destroy(p51) -- Line: 184
    -- upvalues: u2 (copy)
    for _, v in pairs(p51.Hairs) do
        v:Destroy();
    end;

    p51.CenterDot.centerdot:Destroy();
    p51.ImageCrosshair.crosshair:Destroy();
    table.remove(u2, table.find(u2, p51));
    table.clear(p51);
end;

local u52 = false;
game.ReplicatedStorage.miscEvents.Test2.Event:Connect(function(p53) -- Line: 194
    -- upvalues: u52 (ref)
    u52 = p53;
end);

function u1.Update(p54, p55) -- Line: 198
    -- upvalues: u3 (ref), u52 (ref), Functions (copy)
    if not p54.Enabled then
        return;
    end;

    p54.Spreading.Spread = p54.Spreading.Spread - p54.Spreading.DecreasePerSecond * p55;
    p54.Spreading.Spread = math.clamp(p54.Spreading.Spread, p54.Spreading.MinSpread, p54.Spreading.MaxSpread);
    local AbsoluteSize = p54.UI.AbsoluteSize;
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v56;

    if p54.WorldPosition then
        local v57;

        if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
            v57 = workspace_CurrentCamera:WorldToViewportPoint(p54.WorldPosition);
            v56 = UDim2.fromOffset(v57.X, v57.Y);
        elseif u3 then
            if u52 == true then
                local v58 = workspace_CurrentCamera.CFrame:VectorToWorldSpace(Vector3.new(0, 0, 0));
                v57 = workspace_CurrentCamera:WorldToViewportPoint(p54.WorldPosition - v58);
                v56 = UDim2.fromOffset(v57.X, v57.Y);
            else
                local v59;
                v57, v59 = workspace_CurrentCamera:WorldToViewportPoint(p54.WorldPosition);
                v56 = UDim2.fromOffset(v57.X, v57.Y);
            end;
        else
            local v60;
            v57, v60 = workspace_CurrentCamera:WorldToViewportPoint(p54.WorldPosition);
            v56 = UDim2.fromOffset(v57.X, v57.Y);
        end;

        if v57.Z < 0 then
            v56 = UDim2.fromOffset(-1000, -1000);
        end;
    elseif p54.FollowingMouse then
        v56 = UDim2.fromOffset(game:GetService("UserInputService"):GetMouseLocation().X, game:GetService("UserInputService"):GetMouseLocation().Y - game:GetService("GuiService"):GetGuiInset().Y);
    else
        v56 = UDim2.fromOffset(AbsoluteSize.X / 2, AbsoluteSize.Y / 2);
    end;

    local UDim2_fromOffset_ret = UDim2.fromOffset(0, p54.Spreading.Spread);
    local UDim2_fromOffset_ret2 = UDim2.fromOffset(p54.Spreading.Spread, 0);
    p54.Top.Position = v56 - UDim2_fromOffset_ret;
    p54.Bottom.Position = v56 + UDim2_fromOffset_ret;
    p54.Right.Position = v56 - UDim2_fromOffset_ret2;
    p54.Left.Position = v56 + UDim2_fromOffset_ret2;
    p54.HitMarker.hitmarker.Position = v56;

    if p54.CenterDot.enabled then
        p54.CenterDot.centerdot.Visible = true;
        p54.CenterDot.centerdot.Image = p54.CenterDot.Image;
        p54.CenterDot.centerdot.Size = p54.CenterDot.size;
        p54.CenterDot.centerdot.ImageTransparency = p54.CenterDot.transparency;
        p54.CenterDot.centerdot.Position = v56;
    else
        p54.CenterDot.centerdot.Visible = false;
    end;

    if not p54.ImageCrosshair.enabled then
        if not p54.show then
            Functions:UpdateEnabled(p54.Hairs, false);

            return;
        end;

        p54.ImageCrosshair.crosshair.Visible = false;
        Functions:UpdateEnabled(p54.Hairs, true);

        return;
    end;

    p54.ImageCrosshair.crosshair.Visible = true;
    p54.ImageCrosshair.crosshair.Image = p54.ImageCrosshair.Image;
    p54.ImageCrosshair.crosshair.Size = UDim2.fromOffset(p54.SizeX * 2 + p54.Spreading.Spread, p54.SizeX * 2 + p54.Spreading.Spread);
    p54.ImageCrosshair.crosshair.AnchorPoint = Vector2.new(0.5, 0.5);
    p54.ImageCrosshair.crosshair.Position = v56;
    Functions:UpdateEnabled(p54.Hairs, false);
end;

function u1.ToggleVisible(p61, p62) -- Line: 287
    -- upvalues: UserInputService (copy)
    print("------------------------");
    print(p62);
    p61.show = p62;

    for _, v in ipairs(p61.Hairs) do
        v.Visible = p62;
    end;

    if p61.CenterDot and p61.CenterDot.centerdot then
        local v63;

        if p62 then
            v63 = p61.CenterDot.enabled or false;
        else
            v63 = false;
        end;

        p61.CenterDot.centerdot.Visible = v63;
    end;

    if p61.ImageCrosshair and p61.ImageCrosshair.crosshair then
        p61.ImageCrosshair.crosshair.Visible = p62 and p61.ImageCrosshair.enabled or false;
    end;

    if p62 then
        UserInputService.MouseIconEnabled = false;
    end;
end;

function u1.Raycast(p64) -- Line: 307
    -- upvalues: Functions (copy), GuiService (copy)
    local v65, v66 = Functions:RandomPointsInsideCrosshair(p64.Spreading.Spread);
    local AbsoluteSize = p64.UI.AbsoluteSize;
    local v67 = workspace.CurrentCamera:ViewportPointToRay(AbsoluteSize.X / 2 + v65, AbsoluteSize.Y / 2 + v66 - GuiService:GetGuiInset().Y);

    return v67.Origin, v67.Direction;
end;

RunService.RenderStepped:Connect(function(p68) -- Line: 319
    -- upvalues: u2 (copy)
    for _, v in pairs(u2) do
        v:Update(p68);
    end;
end);

return u1;