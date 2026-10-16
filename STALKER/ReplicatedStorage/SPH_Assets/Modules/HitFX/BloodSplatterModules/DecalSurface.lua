-- Decompiled with Potassium's decompiler.

local v1 = {};

function ReturnNormal(p2, p3)
    if p2.lookVector - p3 == Vector3.new(0, 0, 0) then
        return "Front", 5;
    end;

    if p2.lookVector + p3 == Vector3.new(0, 0, 0) then
        return "Back", 2;
    end;

    local _, _, _, v4, v5, _, v6, v7, _, v8, v9, _ = p2:components();

    if Vector3.new(v5, v7, v9) == p3 then
        return "Top", 1;
    end;

    if Vector3.new(-v5, -v7, -v9) == p3 then
        return "Bottom", 4;
    end;

    if Vector3.new(-v4, -v6, -v8) == p3 then
        return "Left", 3;
    end;

    if Vector3.new(v4, v6, v8) == p3 then
        return "Right", 0;
    end;
end;

function SecondaryTex(p10, p11, p12, p13, p14, p15, p16, p17, p18, p19)
    local math_random_ret = math.random(script.Blood[p19].Decal.MinSize.Value, script.Blood[p19].Decal.MaxSize.Value);
    local X = p13.Size.X;
    local Y = p13.Size.Y;
    local v20 = nil;
    local v21 = nil;
    local _ = -X + p13.CFrame:toObjectSpace(CFrame.new(p14)).p.Z / X;

    if p12 == 1 then
        if p10 == "Front" then
            v20 = "Right";
            v21 = 0;
        elseif p10 == "Right" then
            v20 = "Back";
            v21 = 2;
        elseif p10 == "Left" then
            v20 = "Front";
            v21 = 5;
        elseif p10 == "Back" then
            v20 = "Left";
            v21 = 3;
        end;
    elseif p10 == "Front" then
        v20 = "Left";
        v21 = 3;
    elseif p10 == "Right" then
        v20 = "Front";
        v21 = 5;
    elseif p10 == "Left" then
        v20 = "Back";
        v21 = 2;
    elseif p10 == "Back" then
        v20 = "Right";
        v21 = 0;
    end;

    if v20 == "Right" or v20 == "Left" then
        X = p13.Size.Z;
        Y = p13.Size.Y;
        local _ = -X + p13.CFrame:toObjectSpace(CFrame.new(p14)).p.X / X;
    end;

    local v22 = nil;
    local v23 = nil;

    if v20 == nil then
        return;
    end;

    for _, child in pairs(p13:GetChildren()) do
        if child:IsA("SurfaceGui") and child.Face == Enum.NormalId[v20] then
            v23 = child.Framey;
            print(child.Face, "Found");
            v22 = child;
        end;
    end;

    if v22 == nil and p13.Parent:FindFirstChild("Humanoid") == nil then
        local SurfaceGui = Instance.new("SurfaceGui", p13);
        SurfaceGui.CanvasSize = Vector2.new(X * 10, Y * 10);
        SurfaceGui.Face = v21;
        print(SurfaceGui.Face, "Made");
        v23 = Instance.new("Frame", SurfaceGui);
        v23.Name = "Framey";
        v23.Size = UDim2.new(1, 0, 1, 0);
        v23.BackgroundColor = BrickColor.new(170, 0, 0);
        v23.ClipsDescendants = true;
        v23.BackgroundTransparency = 1;
    end;

    local ImageLabel = Instance.new("ImageLabel", v23);
    ImageLabel.Image = p18;
    ImageLabel.Size = UDim2.new(0, math_random_ret, 0, math_random_ret);
    ImageLabel.ImageColor3 = Color3.new(0.666667, 0, 0);
    ImageLabel.BackgroundTransparency = 1;

    if p12 == 0 then
        ImageLabel.Position = UDim2.new(0, p12 - (p15 - p16), p11.Y.Scale, p11.Y.Offset);
    else
        ImageLabel.Position = UDim2.new(1, p16, p11.Y.Scale, p11.Y.Offset);
    end;

    game.Debris:AddItem(ImageLabel, 200);
end;

function v1.MakeDecalOnSurface(p24, p25, p26, p27, p28) -- Line: 101
    if not (p26 and p24) then
        warn("Invalid arguments: part or package missing");

        return;
    end;

    local v29 = script:FindFirstChild(p24);

    if not v29 then
        warn("Package not found:", p24);

        return;
    end;

    local v30 = v29:FindFirstChild(p28);

    if not v30 then
        warn("Size folder not found in package:", p28);

        return;
    end;

    local Children = v30:GetChildren();

    if #Children == 0 then
        warn("No images found in package/size folder");

        return;
    end;

    local v31 = Children[math.random(1, #Children)];

    if not v31 then
        warn("Random image selection failed");

        return;
    end;

    local math_random_ret = math.random(script.Blood[p28].Decal.MinSize.Value, script.Blood[p28].Decal.MaxSize.Value);
    local v32, v33 = ReturnNormal(p26.CFrame, p25);

    if not v32 then
        warn("Could not determine face for normal", p25);

        return;
    end;

    local v34 = nil;
    local v35 = nil;

    for _, child in ipairs(p26:GetChildren()) do
        if child:IsA("SurfaceGui") and child.Face == Enum.NormalId[v32] then
            v34 = child:FindFirstChild("Framey");
            v35 = child;
            break;
        end;
    end;

    local X = p26.Size.X;
    local Y = p26.Size.Y;

    if v32 == "Top" or v32 == "Bottom" then
        X = p26.Size.Z;
        Y = p26.Size.X;
    elseif v32 == "Right" or v32 == "Left" then
        X = p26.Size.Z;
        Y = p26.Size.Y;
    end;

    if not (v35 or p26.Parent:FindFirstChild("Humanoid")) then
        v35 = Instance.new("SurfaceGui");
        v35.Name = "BloodSurface";
        v35.Face = v33;
        v35.CanvasSize = Vector2.new(X * 10, Y * 10);
        v35.Parent = p26;
        v34 = Instance.new("Frame");
        v34.Name = "Framey";
        v34.Size = UDim2.new(1, 0, 1, 0);
        v34.BackgroundTransparency = 1;
        v34.ClipsDescendants = true;
        v34.Parent = v35;
    end;

    if v35 and not v34 then
        v34 = Instance.new("Frame");
        v34.Name = "Framey";
        v34.Size = UDim2.new(1, 0, 1, 0);
        v34.BackgroundTransparency = 1;
        v34.ClipsDescendants = true;
        v34.Parent = v35;
    end;

    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Image = v31.Value;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.ImageColor3 = Color3.new(0.666667, 0, 0);
    ImageLabel.Parent = v34;
    local v36 = X / Y;

    if v36 > 1 then
        ImageLabel.Size = UDim2.new(0, math_random_ret, 0, math_random_ret / v36);
    else
        ImageLabel.Size = UDim2.new(0, math_random_ret * v36, 0, math_random_ret);
    end;

    local v37 = -p26.CFrame:toObjectSpace(CFrame.new(p27)).p;

    if v32 == "Front" then
        ImageLabel.Position = UDim2.new(0.5 + v37.X / X, -math_random_ret / 2, 0.5 + v37.Y / Y, -math_random_ret / 2);
    elseif v32 == "Back" then
        ImageLabel.Position = UDim2.new(0.5 + -v37.X / X, -math_random_ret / 2, 0.5 + v37.Y / Y, -math_random_ret / 2);
    elseif v32 == "Right" then
        ImageLabel.Position = UDim2.new(0.5 + v37.Z / X, -math_random_ret / 2, 0.5 + v37.Y / Y, -math_random_ret / 2);
    elseif v32 == "Left" then
        ImageLabel.Position = UDim2.new(0.5 + -v37.Z / X, -math_random_ret / 2, 0.5 + v37.Y / Y, -math_random_ret / 2);
    elseif v32 == "Top" then
        ImageLabel.Position = UDim2.new(0.5 + v37.Z / X, -math_random_ret / 2, 0.5 + -v37.X / Y, -math_random_ret / 2);
    elseif v32 == "Bottom" then
        ImageLabel.Position = UDim2.new(0.5 + v37.Z / X, -math_random_ret / 2, 0.5 + v37.X / Y, -math_random_ret / 2);
    end;

    if ImageLabel.AbsolutePosition.X > v35.AbsoluteSize.X - math_random_ret then
        SecondaryTex(v32, ImageLabel.Position, 0, p26, p27, v35.AbsoluteSize.X, ImageLabel.AbsolutePosition.X, math_random_ret, v31.Value, p28);
    elseif ImageLabel.AbsolutePosition.X < math_random_ret / 2 then
        SecondaryTex(v32, ImageLabel.Position, 1, p26, p27, v35.AbsoluteSize.X, ImageLabel.AbsolutePosition.X, math_random_ret, v31.Value, p28);
    end;

    game.Debris:AddItem(ImageLabel, 200);
end;

return v1;