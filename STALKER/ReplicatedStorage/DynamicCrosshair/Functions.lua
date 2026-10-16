-- Decompiled with Potassium's decompiler.

return {
    CreateHairs = function(p1, p2, p3, p4) -- Line: 3, Name: CreateHairs
        local v5 = {};

        for i = 1, 7 do
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.BorderSizePixel = 0;
            ImageLabel.Image = "";
            ImageLabel.Name = "_hair";
            ImageLabel.Parent = p2;
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);

            if i < 3 then
                ImageLabel.Size = UDim2.fromOffset(p4, p3);
            elseif i > 2 and i < 5 then
                ImageLabel.Size = UDim2.fromOffset(p3, p4);
            elseif i == 5 then
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.Size = UDim2.fromOffset(50, 50);
                ImageLabel.Image = "rbxassetid://285779644";
                ImageLabel.Name = "HitMarker";
                ImageLabel.ImageTransparency = 1;
            elseif i == 6 then
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.Size = UDim2.fromOffset(10, 10);
                ImageLabel.Image = "rbxassetid://11003529439";
                ImageLabel.Name = "CenterDot";
                ImageLabel.ImageTransparency = 0;
                ImageLabel.Visible = false;
            else
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.Name = "ImageCrosshair";
                ImageLabel.Visible = false;
            end;

            ImageLabel.BorderSizePixel = 0;
            table.insert(v5, i, ImageLabel);
            local _ = i;
        end;

        return unpack(v5);
    end,

    RandomPointsInsideCrosshair = function(p6, p7) -- Line: 48, Name: RandomPointsInsideCrosshair
        local math_random_ret = math.random();
        local v8 = p7 * math.sqrt(math_random_ret) / 2.5;
        local v9 = math.random() * 2 * 3.141592653589793;

        return v8 * math.cos(v9), v8 * math.sin(v9);
    end,

    UpdateEnabled = function(p10, p11, p12) -- Line: 57, Name: UpdateEnabled
        for _, v in pairs(p11) do
            v.Visible = p12;
        end;
    end
};