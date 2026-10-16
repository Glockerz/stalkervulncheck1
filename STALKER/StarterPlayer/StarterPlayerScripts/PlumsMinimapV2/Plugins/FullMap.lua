-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Internal = script.Parent.Parent.Internal;
require(Internal.Janitor);
local CameraUtils = require(Internal.CameraUtils);
local GeneralSettings = script.Parent.Parent.GeneralSettings;
local v1 = {
    Signals = {},
    InitializationPriority = 4
};
local u2 = nil;

function v1.InitializeFrame(u3: userdata, u4: table, p5: any) -- Line: 34
    -- upvalues: GeneralSettings (copy), u2 (ref), LocalPlayer (copy), UserInputService (copy), GuiService (copy), CameraUtils (copy)
    if not u3:GetAttribute("FullSize") then
        if GeneralSettings.OpenFullMapWithClick.Value then
            local v6 = p5:Add(Instance.new("ImageButton"));
            v6.Size = UDim2.fromScale(1, 1);
            v6.BorderSizePixel = 0;
            v6.BackgroundColor3 = u3.BackgroundColor3;
            v6.AutoButtonColor = false;
            v6.Parent = u3;
            local v7 = u3:FindFirstChildOfClass("UICorner");

            if v7 then
                v7:Clone().Parent = v6;
            end;

            v6.MouseButton1Click:Connect(function() -- Line: 50
                -- upvalues: u2 (ref), LocalPlayer (ref)
                if not u2 then
                    return;
                end;

                local v8 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

                if v8 then
                    u2:SetAttribute("FocusPoint", v8.CFrame.Position);
                end;

                u2.Visible = not u2.Visible;
            end);
        end;

        return;
    end;

    u2 = u3;
    u3:SetAttribute("FocusPoint", Vector3.new(0, 0, 0));
    u3:SetAttribute("DontRotate", true);
    local u9 = p5:Add(Instance.new("ImageButton"));
    u9.Size = UDim2.fromScale(1, 1);
    u9.BorderSizePixel = 0;
    u9.BackgroundColor3 = u3.BackgroundColor3;
    u9.AutoButtonColor = false;
    u9.Parent = u3;
    u4.FullmapButton = u9;
    local v10 = u3:FindFirstChildOfClass("UICorner");

    if v10 then
        v10:Clone().Parent = u9;
    end;

    u4.MouseDown = false;
    u4.LastPosition = nil;
    u4.OriginalFocusPoint = nil;
    p5:Add(u9.InputBegan:Connect(function(p11) -- Line: 95
        -- upvalues: u4 (copy), UserInputService (ref), u9 (copy), GuiService (ref)
        if p11.UserInputType == Enum.UserInputType.MouseButton1 then
            u4.MouseDown = true;
            u4.LastPosition = UserInputService:GetMouseLocation() - u9.AbsolutePosition - GuiService:GetGuiInset();
        end;
    end));
    p5:Add(u9.InputChanged:Connect(function(p12) -- Line: 105
        -- upvalues: UserInputService (ref), u9 (copy), GuiService (ref), CameraUtils (ref), u4 (copy), u3 (copy)
        if p12.UserInputType == Enum.UserInputType.MouseWheel then
            local v13 = UserInputService:GetMouseLocation() - u9.AbsolutePosition - GuiService:GetGuiInset();
            local v14 = CameraUtils.ViewportPointToPlanePoint(u4.Camera.CFrame, u4.Camera.FieldOfView, v13, u9.AbsoluteSize, 0.05);
            local Y = u4.BoundingBox.Y;
            local math_rad_ret = math.rad(u4.Camera.FieldOfView / 2);
            local v15 = Y / (math.tan(math_rad_ret) * 2) + 100;
            local math_clamp_ret = math.clamp(u4.Zoom - p12.Position.Z * u4.Zoom * 0.1, 100, v15);
            u3:SetAttribute("Zoom", math_clamp_ret);
            local Vector3_new_ret = Vector3.new(u4.FocusPoint.X, math_clamp_ret, u4.FocusPoint.Z);
            local CFrame_new_ret = CFrame.new(Vector3_new_ret, Vector3_new_ret - Vector3.new(0, 1, 0));
            local v16 = v14 - CameraUtils.ViewportPointToPlanePoint(CFrame_new_ret, u4.Camera.FieldOfView, v13, u9.AbsoluteSize, 0.05);
            u3:SetAttribute("FocusPoint", u4.Camera.CFrame * CFrame.new(u4.Camera.CFrame:VectorToObjectSpace(v16)).Position);
        end;
    end));
    p5:Add(UserInputService.TouchPan:Connect(function(p17: any, p18, p19, p20: any) -- Line: 131
        -- upvalues: u4 (copy), u9 (copy), u3 (copy)
        local Vector2_zero = Vector2.zero;

        for _, v in p17 do
            Vector2_zero = Vector2_zero + v;
        end;

        local v21 = Vector2_zero / #p17;

        if p20 == Enum.UserInputState.End then
            u4.TouchPanning = false;

            return;
        end;

        if not u4.TouchPanning then
            return;
        end;

        if #p17 ~= 2 then
            return;
        end;

        local v22 = u4.LastPositionPan - v21;
        u4.LastPositionPan = v21;
        local v23 = 2 * ((u4.Zoom - 0.05) / math.abs(u4.Camera.CFrame.LookVector.Y));
        local v24 = math.rad(u4.Camera.FieldOfView) / 2;
        local v25 = v23 * math.tan(v24) / u9.AbsoluteSize.Y;
        local v26 = (u4.Camera.CFrame.RightVector * v22.X + u4.Camera.CFrame.UpVector * -v22.Y) * v25;
        local v27 = u4.FocusPoint + Vector3.new(v26.X, 0, v26.Z);
        local math_clamp_ret = math.clamp(v27.X, u4.Center.X - u4.BoundingBox.X / 2, u4.Center.X + u4.BoundingBox.X / 2);
        local math_clamp_ret2 = math.clamp(v27.Z, u4.Center.Y - u4.BoundingBox.Y / 2, u4.Center.Y + u4.BoundingBox.Y / 2);
        local Vector3_new_ret = Vector3.new(math_clamp_ret, 0, math_clamp_ret2);
        local Y = u4.BoundingBox.Y;
        local math_rad_ret = math.rad(u4.Camera.FieldOfView / 2);
        local v28 = Y / (math.tan(math_rad_ret) * 2) + 100;
        u3:SetAttribute("Zoom", (math.clamp(u4.StartZoom + (p18 - u4.StartScale).Magnitude, 100, v28)));
        u3:SetAttribute("FocusPoint", Vector3_new_ret);
    end));
    p5:Add(u9.TouchPan:Connect(function(p29: any, p30, p31, p32: any) -- Line: 181
        -- upvalues: u4 (copy)
        local Vector2_zero = Vector2.zero;

        for _, v in p29 do
            Vector2_zero = Vector2_zero + v;
        end;

        local v33 = Vector2_zero / #p29;

        if p32 == Enum.UserInputState.Begin then
            u4.LastPositionPan = v33;
            u4.StartZoom = u4.Zoom;
            u4.StartScale = p30;
            u4.TouchPanning = true;
        end;
    end));
    p5:Add(UserInputService.InputEnded:Connect(function(p34) -- Line: 200
        -- upvalues: u4 (copy)
        if p34.UserInputType == Enum.UserInputType.MouseButton1 then
            u4.MouseDown = false;
        end;
    end));
    p5:Add(UserInputService.InputChanged:Connect(function(p35) -- Line: 206
        -- upvalues: u4 (copy), UserInputService (ref), u9 (copy), GuiService (ref), u3 (copy)
        if not u4.MouseDown then
            return;
        end;

        if p35.UserInputType == Enum.UserInputType.MouseMovement then
            local v36 = UserInputService:GetMouseLocation() - u9.AbsolutePosition - GuiService:GetGuiInset();
            local v37 = v36 - u4.LastPosition;
            u4.LastPosition = v36;
            local v38 = 2 * ((u4.Zoom - 0.05) / math.abs(u4.Camera.CFrame.LookVector.Y));
            local v39 = math.rad(u4.Camera.FieldOfView) / 2;
            local v40 = v38 * math.tan(v39) / u9.AbsoluteSize.Y;
            local v41 = (u4.Camera.CFrame.RightVector * -v37.X + u4.Camera.CFrame.UpVector * v37.Y) * v40;
            local v42 = u4.FocusPoint + Vector3.new(v41.X, 0, v41.Z);
            local math_clamp_ret = math.clamp(v42.X, u4.Center.X - u4.BoundingBox.X / 2, u4.Center.X + u4.BoundingBox.X / 2);
            local math_clamp_ret2 = math.clamp(v42.Z, u4.Center.Y - u4.BoundingBox.Y / 2, u4.Center.Y + u4.BoundingBox.Y / 2);
            u3:SetAttribute("FocusPoint", (Vector3.new(math_clamp_ret, 0, math_clamp_ret2)));
        end;
    end));
end;

function v1.CleanupFrame(p43) -- Line: 237
end;

return v1;