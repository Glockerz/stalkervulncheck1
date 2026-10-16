-- Decompiled with Potassium's decompiler.

local v1 = {};

local function call(p2, p3, ...) -- Line: 13
    local u4 = p2:FindFirstChild(p3);

    if not (u4 and u4:IsA("RemoteFunction")) then
        return {
            ok = false,
            err = "Server not ready."
        };
    end;

    local table_pack_ret = table.pack(...);
    local success, result = pcall(function() -- Line: 17
        -- upvalues: u4 (copy), table_pack_ret (copy)
        return u4:InvokeServer(table.unpack(table_pack_ret, 1, table_pack_ret.n));
    end);

    return (not success or type(result) ~= "table") and {
        ok = false,
        err = "No answer from the server."
    } or result;
end;

function v1.Build(p5) -- Line: 22
    -- upvalues: call (copy)
    local colours = p5.colours;
    local parent = p5.parent;
    local nextOrder = p5.nextOrder;
    local Remotes = p5.Remotes;

    local function label(p6, p7, p8, p9, p10) -- Line: 25
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = p7;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Font = p10 and Enum.Font.GothamBold or Enum.Font.Gotham;
        TextLabel.TextSize = p8;
        TextLabel.TextColor3 = p9;
        TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel.Parent = p6;

        return TextLabel;
    end;

    local function button(p11, p12, p13) -- Line: 37
        -- upvalues: colours (copy)
        local TextButton = Instance.new("TextButton");
        TextButton.BackgroundColor3 = p13;
        TextButton.BorderSizePixel = 0;
        TextButton.Text = p12;
        TextButton.Font = Enum.Font.GothamBold;
        TextButton.TextSize = 11;
        TextButton.TextColor3 = colours.TEXT;
        TextButton.Parent = p11;
        Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 3);

        return TextButton;
    end;

    local function row(p14) -- Line: 49
        -- upvalues: nextOrder (copy), parent (copy)
        local Frame = Instance.new("Frame");
        Frame.Size = UDim2.new(1, 0, 0, p14);
        Frame.LayoutOrder = nextOrder();
        Frame.BackgroundTransparency = 1;
        Frame.Parent = parent;

        return Frame;
    end;

    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 0, 20);
    Frame.LayoutOrder = nextOrder();
    Frame.BackgroundTransparency = 1;
    Frame.Parent = parent;
    local Color3_fromRGB_ret = Color3.fromRGB(180, 175, 130);
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "CINEMATIC CAMERA (F7; admins always have it)";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Font = Enum.Font.GothamBold or Enum.Font.Gotham;
    TextLabel.TextSize = 11;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Parent = Frame;
    TextLabel.Size = UDim2.fromScale(1, 1);
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.new(1, 0, 0, 30);
    Frame2.LayoutOrder = nextOrder();
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = parent;
    local TextBox = Instance.new("TextBox");
    TextBox.Size = UDim2.new(0.7, -4, 1, 0);
    TextBox.BackgroundColor3 = colours.BG_INPUT;
    TextBox.BorderSizePixel = 0;
    TextBox.PlaceholderText = "username or UserId";
    TextBox.PlaceholderColor3 = colours.TEXT_DIM;
    TextBox.Text = "";
    TextBox.ClearTextOnFocus = false;
    TextBox.Font = Enum.Font.Gotham;
    TextBox.TextSize = 12;
    TextBox.TextColor3 = colours.TEXT;
    TextBox.Parent = Frame2;
    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 3);
    local v15 = button(Frame2, "GRANT", colours.ACCENT_G);
    v15.Size = UDim2.new(0.3, 0, 1, 0);
    v15.Position = UDim2.new(0.7, 0, 0, 0);
    local Frame3 = Instance.new("Frame");
    Frame3.Size = UDim2.new(1, 0, 0, 16);
    Frame3.LayoutOrder = nextOrder();
    Frame3.BackgroundTransparency = 1;
    Frame3.Parent = parent;
    local TEXT_DIM = colours.TEXT_DIM;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = "";
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Font = Enum.Font.Gotham;
    TextLabel2.TextSize = 11;
    TextLabel2.TextColor3 = TEXT_DIM;
    TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel2.Parent = Frame3;
    TextLabel2.Size = UDim2.fromScale(1, 1);

    local function say(p16, p17) -- Line: 81
        -- upvalues: TextLabel2 (copy)
        TextLabel2.Text = p16;
        TextLabel2.TextColor3 = p17 and Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
    end;

    local Frame4 = Instance.new("Frame");
    Frame4.Size = UDim2.new(1, 0, 0, 0);
    Frame4.LayoutOrder = nextOrder();
    Frame4.BackgroundTransparency = 1;
    Frame4.Parent = parent;
    Frame4.AutomaticSize = Enum.AutomaticSize.Y;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Padding = UDim.new(0, 3);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = Frame4;
    local u18 = nil;

    local function paint(p19) -- Line: 94
        -- upvalues: Frame4 (copy), colours (copy), button (copy), call (ref), Remotes (copy), TextLabel2 (copy), u18 (ref)
        for _, child in ipairs(Frame4:GetChildren()) do
            if child:IsA("GuiObject") then
                child:Destroy();
            end;
        end;

        if #p19 ~= 0 then
            for i, v in ipairs(p19) do
                local Frame5 = Instance.new("Frame");
                Frame5.Size = UDim2.new(1, 0, 0, 26);
                Frame5.LayoutOrder = i;
                Frame5.BackgroundColor3 = colours.BG_ROW;
                Frame5.BorderSizePixel = 0;
                Frame5.Parent = Frame4;
                Instance.new("UICorner", Frame5).CornerRadius = UDim.new(0, 3);
                local v20 = v.at and v.at > 0 and (os.date("%Y-%m-%d", v.at) or "?") or "?";
                local v21 = ("  %s  (%d)  since %s"):format(v.name, v.userId, v20);
                local TEXT = colours.TEXT;
                local TextLabel3 = Instance.new("TextLabel");
                TextLabel3.BackgroundTransparency = 1;
                TextLabel3.Text = v21;
                TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel3.Font = Enum.Font.Gotham;
                TextLabel3.TextSize = 11;
                TextLabel3.TextColor3 = TEXT;
                TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd;
                TextLabel3.Parent = Frame5;
                TextLabel3.Size = UDim2.new(1, -84, 1, 0);
                local v22 = button(Frame5, "REVOKE", colours.DANGER);
                v22.Size = UDim2.fromOffset(76, 22);
                v22.Position = UDim2.new(1, -78, 0, 2);
                v22.MouseButton1Click:Connect(function() -- Line: 115
                    -- upvalues: call (ref), Remotes (ref), v (copy), TextLabel2 (ref), u18 (ref)
                    local v23 = call(Remotes, "CinematicAdminRevoke", v.userId);

                    if not v23.ok then
                        TextLabel2.Text = v23.err or "Failed.";
                        TextLabel2.TextColor3 = Color3.fromRGB(220, 110, 100);

                        return;
                    end;

                    TextLabel2.Text = "Revoked " .. v.name .. ".";
                    TextLabel2.TextColor3 = Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
                    u18();
                end);
            end;

            return;
        end;

        local TEXT_DIM2 = colours.TEXT_DIM;
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.Text = "  Nobody else has the camera.";
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.Font = Enum.Font.Gotham;
        TextLabel3.TextSize = 10;
        TextLabel3.TextColor3 = TEXT_DIM2;
        TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel3.Parent = Frame4;
        TextLabel3.Size = UDim2.new(1, 0, 0, 18);
    end;

    u18 = function() -- Line: 122
        -- upvalues: call (ref), Remotes (copy), paint (copy), TextLabel2 (copy)
        local v24 = call(Remotes, "CinematicAdminList");

        if v24.ok then
            paint(v24.entries or {});

            return;
        end;

        TextLabel2.Text = v24.err or "Could not load the list.";
        TextLabel2.TextColor3 = Color3.fromRGB(220, 110, 100);
    end;

    v15.MouseButton1Click:Connect(function() -- Line: 127
        -- upvalues: TextLabel2 (copy), call (ref), Remotes (copy), TextBox (copy), u18 (ref)
        TextLabel2.Text = "Granting...";
        TextLabel2.TextColor3 = Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
        local v25 = call(Remotes, "CinematicAdminGrant", TextBox.Text);

        if not v25.ok then
            TextLabel2.Text = v25.err or "Failed.";
            TextLabel2.TextColor3 = Color3.fromRGB(220, 110, 100);

            return;
        end;

        TextLabel2.Text = ("Granted the camera to %s."):format(v25.name);
        TextLabel2.TextColor3 = Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
        TextBox.Text = "";
        u18();
    end);
    task.spawn(u18);

    return u18;
end;

return v1;