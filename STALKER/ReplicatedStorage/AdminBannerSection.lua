-- Decompiled with Potassium's decompiler.

local v1 = {};

local function call(p2, p3, ...) -- Line: 14
    local u4 = p2:FindFirstChild(p3);

    if not (u4 and u4:IsA("RemoteFunction")) then
        return {
            ok = false,
            err = "Server not ready."
        };
    end;

    local table_pack_ret = table.pack(...);
    local success, result = pcall(function() -- Line: 18
        -- upvalues: u4 (copy), table_pack_ret (copy)
        return u4:InvokeServer(table.unpack(table_pack_ret, 1, table_pack_ret.n));
    end);

    return (not success or type(result) ~= "table") and {
        ok = false,
        err = "No answer from the server."
    } or result;
end;

function v1.Build(p5) -- Line: 23
    -- upvalues: call (copy)
    local colours = p5.colours;
    local parent = p5.parent;
    local nextOrder = p5.nextOrder;
    local Remotes = p5.Remotes;

    local function label(p6, p7, p8, p9, p10) -- Line: 26
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = p7;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Font = p10 and Enum.Font.GothamBold or Enum.Font.Gotham;
        TextLabel.TextSize = p8;
        TextLabel.TextColor3 = p9;
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

    local function input(p15, p16) -- Line: 57
        -- upvalues: colours (copy)
        local TextBox = Instance.new("TextBox");
        TextBox.BackgroundColor3 = colours.BG_INPUT;
        TextBox.BorderSizePixel = 0;
        TextBox.PlaceholderText = p16;
        TextBox.PlaceholderColor3 = colours.TEXT_DIM;
        TextBox.Text = "";
        TextBox.ClearTextOnFocus = false;
        TextBox.Font = Enum.Font.Gotham;
        TextBox.TextSize = 12;
        TextBox.TextColor3 = colours.TEXT;
        TextBox.Parent = p15;
        Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 3);

        return TextBox;
    end;

    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 0, 20);
    Frame.LayoutOrder = nextOrder();
    Frame.BackgroundTransparency = 1;
    Frame.Parent = parent;
    local Color3_fromRGB_ret = Color3.fromRGB(180, 175, 130);
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "BANNER ANNOUNCEMENT (top of every player\'s screen)";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Font = Enum.Font.GothamBold or Enum.Font.Gotham;
    TextLabel.TextSize = 11;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.Parent = Frame;
    TextLabel.Size = UDim2.fromScale(1, 1);
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.new(1, 0, 0, 54);
    Frame2.LayoutOrder = nextOrder();
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = parent;
    local u17 = input(Frame2, "message (one line, 200 characters)");
    u17.Size = UDim2.fromScale(1, 1);
    u17.MultiLine = true;
    u17.TextWrapped = true;
    u17.TextXAlignment = Enum.TextXAlignment.Left;
    u17.TextYAlignment = Enum.TextYAlignment.Top;
    local UIPadding = Instance.new("UIPadding");
    local UDim_new_ret = UDim.new(0, 6);
    local UDim_new_ret2 = UDim.new(0, 6);
    local UDim_new_ret3 = UDim.new(0, 4);
    UIPadding.PaddingLeft = UDim_new_ret;
    UIPadding.PaddingRight = UDim_new_ret2;
    UIPadding.PaddingTop = UDim_new_ret3;
    UIPadding.Parent = u17;
    local Frame3 = Instance.new("Frame");
    Frame3.Size = UDim2.new(1, 0, 0, 28);
    Frame3.LayoutOrder = nextOrder();
    Frame3.BackgroundTransparency = 1;
    Frame3.Parent = parent;
    local u18 = input(Frame3, "minutes (1-60, blank = 10)");
    u18.Size = UDim2.new(0.34, -4, 1, 0);
    local u19 = false;
    local u20 = button(Frame3, "EVERY SERVER", colours.BG_ROW);
    u20.Size = UDim2.new(0.33, -4, 1, 0);
    u20.Position = UDim2.new(0.34, 0, 0, 0);
    u20.MouseButton1Click:Connect(function() -- Line: 94
        -- upvalues: u19 (ref), u20 (copy)
        u19 = not u19;
        u20.Text = u19 and "THIS SERVER ONLY" or "EVERY SERVER";
    end);
    local v21 = button(Frame3, "SEND", colours.ACCENT_G);
    v21.Size = UDim2.new(0.33, 0, 1, 0);
    v21.Position = UDim2.new(0.67, 0, 0, 0);
    local Frame4 = Instance.new("Frame");
    Frame4.Size = UDim2.new(1, 0, 0, 16);
    Frame4.LayoutOrder = nextOrder();
    Frame4.BackgroundTransparency = 1;
    Frame4.Parent = parent;
    local TEXT_DIM = colours.TEXT_DIM;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = "";
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Font = Enum.Font.Gotham;
    TextLabel2.TextSize = 11;
    TextLabel2.TextColor3 = TEXT_DIM;
    TextLabel2.Parent = Frame4;
    TextLabel2.Size = UDim2.fromScale(1, 1);
    TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;

    local function say(p22, p23) -- Line: 105
        -- upvalues: TextLabel2 (copy)
        TextLabel2.Text = p22;
        TextLabel2.TextColor3 = p23 and Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
    end;

    u17:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 109
        -- upvalues: u17 (copy), TextLabel2 (copy), colours (copy)
        local v24 = #u17.Text;
        TextLabel2.Text = v24 > 0 and (("%d / %d"):format(v24, 200) or "") or "";
        TextLabel2.TextColor3 = v24 > 200 and Color3.fromRGB(220, 110, 100) or colours.TEXT_DIM;
    end);
    local Frame5 = Instance.new("Frame");
    Frame5.Size = UDim2.new(1, 0, 0, 30);
    Frame5.LayoutOrder = nextOrder();
    Frame5.BackgroundTransparency = 1;
    Frame5.Parent = parent;
    local Frame6 = Instance.new("Frame");
    Frame6.Size = UDim2.new(1, -84, 1, 0);
    Frame6.BackgroundColor3 = colours.BG_ROW;
    Frame6.BorderSizePixel = 0;
    Frame6.Parent = Frame5;
    Instance.new("UICorner", Frame6).CornerRadius = UDim.new(0, 3);
    local TEXT_DIM2 = colours.TEXT_DIM;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.Text = "";
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Font = Enum.Font.Gotham;
    TextLabel3.TextSize = 10;
    TextLabel3.TextColor3 = TEXT_DIM2;
    TextLabel3.Parent = Frame6;
    TextLabel3.Size = UDim2.new(1, -8, 1, 0);
    TextLabel3.Position = UDim2.fromOffset(6, 0);
    TextLabel3.TextWrapped = true;
    TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd;
    local v25 = button(Frame5, "TAKE DOWN", colours.DANGER);
    v25.Size = UDim2.new(0, 80, 1, 0);
    v25.Position = UDim2.new(1, -80, 0, 0);
    local u26 = nil;

    local function refresh() -- Line: 132
        -- upvalues: call (ref), Remotes (copy), u26 (ref), TextLabel3 (copy), colours (copy)
        local v27 = call(Remotes, "AdminAnnounceCurrent");
        local v28 = v27.ok and v27.banner;

        if v28 then
            u26 = v28.id;
            TextLabel3.Text = ("UP (%s, %dm left): %s"):format(v28.localOnly and "this server" or "every server", math.ceil((v28.remaining or 0) / 60), v28.text);
            TextLabel3.TextColor3 = colours.TEXT;

            return;
        end;

        u26 = nil;
        TextLabel3.Text = v27.ok and "No banner is up." or (v27.err or "Could not check.");
        TextLabel3.TextColor3 = colours.TEXT_DIM;
    end;

    v21.MouseButton1Click:Connect(function() -- Line: 147
        -- upvalues: u18 (copy), u17 (copy), u19 (ref), TextLabel2 (copy), call (ref), Remotes (copy), refresh (copy)
        local v29 = u18.Text:gsub("%s", "");
        local v30 = {
            text = u17.Text
        };
        local v31;

        if v29 == "" then
            v31 = nil;
        else
            v31 = tonumber(v29) or nil;
        end;

        v30.minutes = v31;
        v30.localOnly = u19;

        if v29 ~= "" and not tonumber(v29) then
            TextLabel2.Text = "Minutes must be a number.";
            TextLabel2.TextColor3 = Color3.fromRGB(220, 110, 100);

            return;
        end;

        TextLabel2.Text = "Sending...";
        TextLabel2.TextColor3 = Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
        local v32 = call(Remotes, "AdminAnnounceSend", v30);

        if not v32.ok then
            TextLabel2.Text = v32.err or "Failed.";
            TextLabel2.TextColor3 = Color3.fromRGB(220, 110, 100);

            return;
        end;

        local v33 = not v32.filtered;
        TextLabel2.Text = v32.filtered and "Sent. The text filter changed some words." or "Sent.";
        TextLabel2.TextColor3 = v33 and Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
        u17.Text = "";
        refresh();
    end);
    v25.MouseButton1Click:Connect(function() -- Line: 162
        -- upvalues: u26 (ref), refresh (copy), call (ref), Remotes (copy), TextLabel2 (copy)
        if not u26 then
            refresh();

            return;
        end;

        local v34 = call(Remotes, "AdminAnnounceClear", u26);

        if v34.ok then
            TextLabel2.Text = "Taken down.";
            TextLabel2.TextColor3 = Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
        else
            TextLabel2.Text = v34.err or "Failed.";
            TextLabel2.TextColor3 = Color3.fromRGB(220, 110, 100);
        end;

        refresh();
    end);
    task.spawn(refresh);

    return refresh;
end;

return v1;