-- Decompiled with Potassium's decompiler.

local Internal = script.Parent.Parent.Internal;
local GoodSignal = require(Internal.GoodSignal);
local Janitor = require(Internal.Janitor);
game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local GeneralSettings = script.Parent.Parent.GeneralSettings;
local CurrentMap = GeneralSettings.CurrentMap;
local RotationCalculator = require(script.Parent.RotationCalculator);
local u1 = {
    InitializationPriority = 2,
    Signals = {
        CalculatedCFrameForFrame = GoodSignal.new()
    },
    MapDivisionNumber = 1
};
local u2 = {};

function u1.InitializeFrame(u3: userdata, u4: table, p5: any) -- Line: 40
    -- upvalues: Janitor (copy), u1 (copy), GoodSignal (copy), GeneralSettings (copy), CurrentMap (copy), u2 (copy)
    local u6 = p5:Add(Janitor.new());
    local u7 = p5:Add(Instance.new("ViewportFrame"));
    u7.Size = UDim2.fromScale(1, 1);
    u7.BackgroundTransparency = 1;
    u7.LightColor = Color3.fromRGB(255, 255, 255);
    u7.Ambient = Color3.fromRGB(255, 255, 255);
    u7.LightDirection = Vector3.new(0, 1, 0);
    u7.ZIndex = 100;
    u7.Parent = u3;
    local v8 = u3:FindFirstChildOfClass("UICorner");

    if v8 then
        v8:Clone().Parent = u7;
    end;

    local v9 = p5:Add(Instance.new("Camera"));
    v9.Parent = u7;
    u7.CurrentCamera = v9;

    local function CreateMap(p10: userdata) -- Line: 62
        -- upvalues: u6 (copy), u1 (ref), u7 (copy), u4 (copy)
        u6:Cleanup();
        local v11 = 2048;

        for _, child in p10:GetChildren() do
            v11 = math.max(v11, child.Size.Value.X, child.Size.Value.Z);
        end;

        u1.MapDivisionNumber = math.max(1, v11 / 2048);
        local Vector2_zero = Vector2.zero;
        local Vector2_zero2 = Vector2.zero;
        local Vector2_zero3 = Vector2.zero;
        local v12 = p10:GetAttribute("Rotation") or 0;

        for _, child in p10:GetChildren() do
            local v13 = u6:Add(Instance.new("Part"));
            local X = child.Position.Value.X;
            local math_rad_ret = math.rad(v12);
            local v14 = X * math.cos(math_rad_ret);
            local Z = child.Position.Value.Z;
            local math_rad_ret2 = math.rad(v12);
            local v15 = v14 - Z * math.sin(math_rad_ret2);
            local X2 = child.Position.Value.X;
            local math_rad_ret3 = math.rad(v12);
            local v16 = X2 * math.sin(math_rad_ret3);
            local Z2 = child.Position.Value.Z;
            local math_rad_ret4 = math.rad(v12);
            local v17 = v16 + Z2 * math.cos(math_rad_ret4);
            local Vector3_new_ret = Vector3.new(v15, 0, v17);
            v13.Size = Vector3.new(child.Size.Value.X / u1.MapDivisionNumber, 0.1, child.Size.Value.Z / u1.MapDivisionNumber);
            v13.Position = Vector3.new(Vector3_new_ret.X / u1.MapDivisionNumber, 0, Vector3_new_ret.Z / u1.MapDivisionNumber);
            v13.Transparency = 1;
            v13.Orientation = Vector3.new(0, child.Rotation.Value, 0);

            if not child:FindFirstChildOfClass("Decal") then
                error("No image was provided in image data " .. child:GetFullName());
            end;

            local v18 = u6:Add(child:FindFirstChildOfClass("Decal"):Clone());
            v18.Parent = v13;
            v18.Face = Enum.NormalId.Top;
            v13.Parent = u7;
            v13.Name = child.Name;
            Vector2_zero3 = Vector2_zero3 + Vector2.new(v13.Size.X, v13.Size.Z);
            Vector2_zero2 = Vector2_zero2 + Vector2.new(v13.Position.X, v13.Position.Z);
            Vector2_zero = Vector2_zero + Vector2.new(1, 1);
        end;

        u4.BoundingBox = Vector2_zero3;
        u4.Center = Vector2_zero2 / Vector2_zero;
    end;

    p5:Add(u3:GetAttributeChangedSignal("DontRotate"):Connect(function() -- Line: 119
        -- upvalues: u4 (copy), u3 (copy)
        u4.DontRotate = u3:GetAttribute("DontRotate");
    end));
    p5:Add(u3:GetAttributeChangedSignal("FocusPoint"):Connect(function() -- Line: 123
        -- upvalues: u4 (copy), u3 (copy)
        u4.FocusPoint = u3:GetAttribute("FocusPoint");
    end));
    u4.ZoomChanged = GoodSignal.new();
    p5:Add(u3:GetAttributeChangedSignal("Zoom"):Connect(function() -- Line: 128
        -- upvalues: u4 (copy), u3 (copy), GeneralSettings (ref)
        u4.Zoom = u3:GetAttribute("Zoom") or GeneralSettings.Zoom.Value;
        u4.ZoomChanged:Fire(u4.Zoom);
    end));
    u4.Camera = v9;
    u4.MinimapFrame = u7;
    u4.FocusPoint = u3:GetAttribute("FocusPoint");
    u4.DontRotate = u3:GetAttribute("DontRotate");
    u4.Zoom = u3:GetAttribute("Zoom") or GeneralSettings.Zoom.Value;
    u4.CalculatedCFrame = GoodSignal.new();
    u4.LastRotation = nil;
    u4.LastCFrame = nil;
    CreateMap(CurrentMap.Value);
    p5:Add(CurrentMap:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 147
        -- upvalues: CreateMap (copy), CurrentMap (ref)
        CreateMap(CurrentMap.Value);
    end));
    u2[u3] = u4;
end;

function u1.CleanupFrame(p19: userdata) -- Line: 155
    -- upvalues: u2 (copy)
    u2[p19] = nil;
end;

function u1.WorldToMap(p20: vector) -- Line: 159
    -- upvalues: u1 (copy)
    return p20 / u1.MapDivisionNumber;
end;

function u1.WorldToMapVec2(p21: vector) -- Line: 163
    -- upvalues: u1 (copy)
    local v22 = p21 / u1.MapDivisionNumber;

    return Vector2.new(v22.X, v22.Z);
end;

RotationCalculator.Signals.CalculatedRotation:Connect(function(p23) -- Line: 168
    -- upvalues: LocalPlayer (copy), u2 (copy), u1 (copy), GeneralSettings (copy)
    local v24 = Vector3.new(0, 0, 0);
    local v25 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if v25 then
        v24 = v25.CFrame.Position;
    end;

    for i, v in u2 do
        local v26 = nil;

        if i.Visible then
            local v27;

            if v.FocusPoint then
                v27 = u1.WorldToMap((Vector3.new(v.FocusPoint.X, 0, v.FocusPoint.Z)));
            else
                v27 = v26 or u1.WorldToMap(v24);
            end;

            local Vector3_new_ret = Vector3.new(v27.X, v.Zoom or GeneralSettings.Zoom.Value, v27.Z);
            local DontRotate = v.DontRotate;

            if DontRotate == nil then
                DontRotate = GeneralSettings.DontRotate.Value;
            end;

            if DontRotate then
                v.Camera.CFrame = CFrame.new(Vector3_new_ret, Vector3_new_ret - Vector3.new(0, 1, 0));
            else
                v.Camera.CFrame = CFrame.new(Vector3_new_ret, Vector3_new_ret - Vector3.new(0, 1, 0)) * CFrame.Angles(0, 0, p23);
            end;

            if v.Camera.CFrame.Position ~= v.LastCFrame or p23 ~= v.LastRotation then
                v.CalculatedCFrame:Fire(v.Camera.CFrame, p23);
                v.Rotation = p23;
                v.LastCFrame = v.Camera.CFrame.Position;
                v.LastRotation = p23;
            end;
        end;
    end;
end);

return u1;