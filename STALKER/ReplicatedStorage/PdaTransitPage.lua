-- Decompiled with Potassium's decompiler.

local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local Color3_fromRGB_ret = Color3.fromRGB(16, 18, 15);
local Color3_fromRGB_ret2 = Color3.fromRGB(30, 33, 26);
local Color3_fromRGB_ret3 = Color3.fromRGB(44, 46, 41);
local Color3_fromRGB_ret4 = Color3.fromRGB(216, 214, 203);
local Color3_fromRGB_ret5 = Color3.fromRGB(140, 139, 128);
local Color3_fromRGB_ret6 = Color3.fromRGB(94, 94, 86);
local Color3_fromRGB_ret7 = Color3.fromRGB(138, 176, 100);
local Color3_fromRGB_ret8 = Color3.fromRGB(96, 122, 60);
local Color3_fromRGB_ret9 = Color3.fromRGB(44, 50, 36);
local Color3_fromRGB_ret10 = Color3.fromRGB(232, 236, 220);
local Color3_fromRGB_ret11 = Color3.fromRGB(214, 160, 90);
local StoryRules = require(game:GetService("ReplicatedStorage"):WaitForChild("StoryRules"));
local v1 = {};

local function label(p2, p3) -- Line: 34
    -- upvalues: Font_new_ret3 (copy), Color3_fromRGB_ret4 (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = p3.font or Font_new_ret3;
    TextLabel.TextSize = p3.size or 16;
    TextLabel.TextColor3 = p3.color or Color3_fromRGB_ret4;
    TextLabel.Text = p3.text or "";
    TextLabel.TextXAlignment = p3.align or Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = p3.valign or Enum.TextYAlignment.Center;
    TextLabel.TextWrapped = p3.wrap == true;
    TextLabel.TextTruncate = p3.wrap and Enum.TextTruncate.None or Enum.TextTruncate.AtEnd;
    TextLabel.Size = p3.sizeU or UDim2.new(1, 0, 0, 20);
    TextLabel.Position = p3.pos or UDim2.new();
    TextLabel.Parent = p2;

    return TextLabel;
end;

local function rule(p4, p5, p6) -- Line: 51
    -- upvalues: Color3_fromRGB_ret3 (copy)
    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3_fromRGB_ret3;
    Frame.BorderSizePixel = 0;
    Frame.Position = p5;
    Frame.Size = p6;
    Frame.Parent = p4;

    return Frame;
end;

local function button(p7, p8, p9, u10) -- Line: 61
    -- upvalues: Color3_fromRGB_ret9 (copy), Font_new_ret (copy), Color3_fromRGB_ret4 (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.AutoButtonColor = false;
    TextButton.BorderSizePixel = 0;
    TextButton.BackgroundColor3 = Color3_fromRGB_ret9;
    TextButton.FontFace = Font_new_ret;
    TextButton.TextSize = 18;
    TextButton.TextColor3 = Color3_fromRGB_ret4;
    TextButton.Text = "";
    TextButton.Position = p8;
    TextButton.Size = p9;
    TextButton.Parent = p7;
    TextButton.MouseButton1Click:Connect(function() -- Line: 73
        -- upvalues: TextButton (copy), u10 (copy)
        if TextButton.Active then
            u10();
        end;
    end);

    return TextButton;
end;

function v1.Build(u11: userdata, u12: any) -- Line: 79
    -- upvalues: Color3_fromRGB_ret (copy), label (copy), Font_new_ret (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret7 (copy), Font_new_ret2 (copy), button (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret11 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret10 (copy), StoryRules (copy)
    u11.BackgroundColor3 = Color3_fromRGB_ret;
    u11.BackgroundTransparency = 0;
    u11.BorderSizePixel = 0;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 20);
    UIPadding.PaddingRight = UDim.new(0, 20);
    UIPadding.PaddingTop = UDim.new(0, 14);
    UIPadding.PaddingBottom = UDim.new(0, 12);
    UIPadding.Parent = u11;
    local Frame = Instance.new("Frame");
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.new(0.5, -14, 1, -60);
    Frame.Parent = u11;
    label(Frame, {
        text = "TRANSIT TO",
        size = 14,
        font = Font_new_ret,
        color = Color3_fromRGB_ret6,
        sizeU = UDim2.new(1, 0, 0, 16)
    });
    local u13 = label(Frame, {
        size = 34,
        font = Font_new_ret,
        pos = UDim2.new(0, 0, 0, 18),
        sizeU = UDim2.new(1, 0, 0, 40)
    });
    local u14 = label(Frame, {
        size = 15,
        wrap = true,
        color = Color3_fromRGB_ret5,
        valign = Enum.TextYAlignment.Top,
        pos = UDim2.new(0, 0, 0, 62),
        sizeU = UDim2.new(1, 0, 0, 44)
    });
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Position = UDim2.new(0, 0, 0, 112);
    ImageLabel.Size = UDim2.new(1, 0, 0, 120);
    ImageLabel.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.BackgroundTransparency = 1;
    Frame2.Position = UDim2.new(0, 0, 0, 112);
    Frame2.Size = UDim2.new(1, 0, 1, -236);
    Frame2.Parent = Frame;
    local UDim2_new_ret = UDim2.new();
    local UDim2_new_ret2 = UDim2.new(1, 0, 0, 1);
    local Frame3 = Instance.new("Frame");
    Frame3.BackgroundColor3 = Color3_fromRGB_ret3;
    Frame3.BorderSizePixel = 0;
    Frame3.Position = UDim2_new_ret;
    Frame3.Size = UDim2_new_ret2;
    Frame3.Parent = Frame2;
    label(Frame2, {
        text = "SERVERS",
        size = 14,
        font = Font_new_ret,
        color = Color3_fromRGB_ret6,
        pos = UDim2.new(0, 0, 0, 8),
        sizeU = UDim2.new(0.5, 0, 0, 16)
    });
    local TextBox = Instance.new("TextBox");
    TextBox.BackgroundColor3 = Color3_fromRGB_ret2;
    TextBox.BorderSizePixel = 0;
    TextBox.ClearTextOnFocus = false;
    TextBox.FontFace = Font_new_ret3;
    TextBox.TextSize = 14;
    TextBox.TextColor3 = Color3_fromRGB_ret4;
    TextBox.PlaceholderText = "Search code";
    TextBox.PlaceholderColor3 = Color3_fromRGB_ret6;
    TextBox.Text = "";
    TextBox.Position = UDim2.new(0.55, 0, 0, 4);
    TextBox.Size = UDim2.new(0.45, 0, 0, 24);
    TextBox.Parent = Frame2;
    TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 129
        -- upvalues: u12 (copy), TextBox (copy)
        u12:SetFilter(TextBox.Text);
    end);
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 34);
    ScrollingFrame.Size = UDim2.new(1, 0, 1, -34);
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.CanvasSize = UDim2.new();
    ScrollingFrame.Parent = Frame2;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = ScrollingFrame;

    local function serverRow(p15, u16, p17, p18, p19, p20, p21, u22) -- Line: 143
        -- upvalues: Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret (ref), ScrollingFrame (copy), Color3_fromRGB_ret7 (ref), Color3_fromRGB_ret4 (ref), Color3_fromRGB_ret6 (ref), label (ref), Font_new_ret (ref), Color3_fromRGB_ret5 (ref), Font_new_ret2 (ref)
        local TextButton = Instance.new("TextButton");
        TextButton.AutoButtonColor = false;
        TextButton.BorderSizePixel = 0;
        TextButton.Text = "";
        TextButton.BackgroundColor3 = p20 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;
        TextButton.BackgroundTransparency = p20 and 0 or 1;
        TextButton.Size = UDim2.new(1, -6, 0, 30);
        TextButton.LayoutOrder = p15;
        TextButton.Active = p21;
        TextButton.Parent = ScrollingFrame;
        local v23 = p20 and Color3_fromRGB_ret7 or (p21 and Color3_fromRGB_ret4 or Color3_fromRGB_ret6);
        label(TextButton, {
            size = 15,
            text = p17,
            font = Font_new_ret,
            color = v23,
            pos = UDim2.new(0, 8, 0, 0),
            sizeU = UDim2.new(0.3, -8, 1, 0)
        });
        label(TextButton, {
            size = 14,
            text = p18,
            color = p21 and Color3_fromRGB_ret5 or Color3_fromRGB_ret6,
            pos = UDim2.new(0.3, 0, 0, 0),
            sizeU = UDim2.new(0.45, 0, 1, 0)
        });
        label(TextButton, {
            size = 14,
            text = p19,
            font = Font_new_ret2,
            color = v23,
            align = Enum.TextXAlignment.Right,
            pos = UDim2.new(0.75, 0, 0, 0),
            sizeU = UDim2.new(0.25, -8, 1, 0)
        });
        TextButton.MouseButton1Click:Connect(function() -- Line: 159
            -- upvalues: TextButton (copy), u22 (copy), u16 (copy)
            if TextButton.Active then
                u22(u16);
            end;
        end);
    end;

    local Frame4 = Instance.new("Frame");
    Frame4.BackgroundTransparency = 1;
    Frame4.Position = UDim2.new(0, 0, 1, -116);
    Frame4.Size = UDim2.new(1, 0, 0, 116);
    Frame4.Parent = Frame;
    local UDim2_new_ret3 = UDim2.new();
    local UDim2_new_ret4 = UDim2.new(1, 0, 0, 1);
    local Frame5 = Instance.new("Frame");
    Frame5.BackgroundColor3 = Color3_fromRGB_ret3;
    Frame5.BorderSizePixel = 0;
    Frame5.Position = UDim2_new_ret3;
    Frame5.Size = UDim2_new_ret4;
    Frame5.Parent = Frame4;
    label(Frame4, {
        text = "ACCESS",
        size = 14,
        font = Font_new_ret,
        color = Color3_fromRGB_ret6,
        pos = UDim2.new(0, 0, 0, 8),
        sizeU = UDim2.new(1, 0, 0, 16)
    });
    local u24 = button(Frame4, UDim2.new(0, 0, 0, 30), UDim2.new(0.5, -4, 0, 38), function() -- Line: 170
        -- upvalues: u12 (copy)
        u12:SetAccess("open", true);
    end);
    local u25 = button(Frame4, UDim2.new(0.5, 4, 0, 30), UDim2.new(0.5, -4, 0, 38), function() -- Line: 171
        -- upvalues: u12 (copy)
        u12:SetAccess("private", true);
    end);
    u24.Text = "OPEN";
    u25.Text = "PRIVATE";
    local u26 = label(Frame4, {
        size = 14,
        wrap = true,
        color = Color3_fromRGB_ret5,
        pos = UDim2.new(0, 0, 0, 74),
        sizeU = UDim2.new(1, 0, 0, 34),
        valign = Enum.TextYAlignment.Top
    });
    local Frame6 = Instance.new("Frame");
    Frame6.BackgroundTransparency = 1;
    Frame6.Position = UDim2.new(0, 0, 0, 112);
    Frame6.Size = UDim2.new(1, 0, 1, -112);
    Frame6.Visible = false;
    Frame6.Parent = Frame;
    local u27 = label(Frame6, {
        size = 110,
        font = Font_new_ret,
        color = Color3_fromRGB_ret7,
        align = Enum.TextXAlignment.Center,
        sizeU = UDim2.new(1, 0, 0, 130)
    });
    label(Frame6, {
        text = "STAY ON THE PAD",
        size = 18,
        font = Font_new_ret,
        align = Enum.TextXAlignment.Center,
        pos = UDim2.new(0, 0, 0, 134),
        sizeU = UDim2.new(1, 0, 0, 22)
    });
    label(Frame6, {
        text = "Your squad is protected until the transit.",
        size = 14,
        color = Color3_fromRGB_ret5,
        align = Enum.TextXAlignment.Center,
        pos = UDim2.new(0, 0, 0, 160),
        sizeU = UDim2.new(1, 0, 0, 20)
    });
    local UDim2_new_ret5 = UDim2.new(0.5, -1, 0, 0);
    local UDim2_new_ret6 = UDim2.new(0, 1, 1, -60);
    local Frame7 = Instance.new("Frame");
    Frame7.BackgroundColor3 = Color3_fromRGB_ret3;
    Frame7.BorderSizePixel = 0;
    Frame7.Position = UDim2_new_ret5;
    Frame7.Size = UDim2_new_ret6;
    Frame7.Parent = u11;
    local Frame8 = Instance.new("Frame");
    Frame8.BackgroundTransparency = 1;
    Frame8.Position = UDim2.new(0.5, 14, 0, 0);
    Frame8.Size = UDim2.new(0.5, -14, 1, -60);
    Frame8.Parent = u11;
    label(Frame8, {
        text = "SQUAD",
        size = 14,
        font = Font_new_ret,
        color = Color3_fromRGB_ret6,
        sizeU = UDim2.new(0.5, 0, 0, 16)
    });
    local u28 = label(Frame8, {
        size = 14,
        font = Font_new_ret,
        color = Color3_fromRGB_ret5,
        align = Enum.TextXAlignment.Right,
        pos = UDim2.new(0.5, 0, 0, 0),
        sizeU = UDim2.new(0.5, 0, 0, 16)
    });
    local u29 = {};

    for i = 1, 4 do
        local v30 = (i - 1) * 46 + 26;
        local v31 = label(Frame8, {
            size = 18,
            font = Font_new_ret2,
            pos = UDim2.new(0, 0, 0, v30),
            sizeU = UDim2.new(0.62, 0, 0, 38)
        });
        local v32 = label(Frame8, {
            size = 14,
            font = Font_new_ret,
            align = Enum.TextXAlignment.Right,
            pos = UDim2.new(0.62, 0, 0, v30),
            sizeU = UDim2.new(0.38, 0, 0, 38)
        });
        local UDim2_new_ret7 = UDim2.new(0, 0, 0, v30 + 46 - 4);
        local UDim2_new_ret8 = UDim2.new(1, 0, 0, 1);
        local Frame9 = Instance.new("Frame");
        Frame9.BackgroundColor3 = Color3_fromRGB_ret3;
        Frame9.BorderSizePixel = 0;
        Frame9.Position = UDim2_new_ret7;
        Frame9.Size = UDim2_new_ret8;
        Frame9.Parent = Frame8;
        u29[i] = {
            name = v31,
            status = v32
        };
        local _ = i;
    end;

    local UDim2_new_ret7 = UDim2.new(0, 0, 1, -54);
    local UDim2_new_ret8 = UDim2.new(1, 0, 0, 1);
    local Frame9 = Instance.new("Frame");
    Frame9.BackgroundColor3 = Color3_fromRGB_ret3;
    Frame9.BorderSizePixel = 0;
    Frame9.Position = UDim2_new_ret7;
    Frame9.Size = UDim2_new_ret8;
    Frame9.Parent = u11;
    local u33 = label(u11, {
        size = 15,
        wrap = true,
        color = Color3_fromRGB_ret5,
        pos = UDim2.new(0, 0, 1, -46),
        sizeU = UDim2.new(1, -250, 0, 40)
    });
    local u34 = button(u11, UDim2.new(1, -230, 1, -46), UDim2.new(0, 230, 0, 42), function() -- Line: 216
        -- upvalues: u12 (copy)
        u12:PrimaryPressed();
    end);
    local u35 = nil;
    local v51 = {
        Render = function(p36) -- Line: 221, Name: Render
            -- upvalues: u35 (ref), u13 (copy), u14 (copy), ImageLabel (copy), Frame4 (copy), Frame6 (copy), Frame2 (copy), ScrollingFrame (copy), serverRow (copy), u12 (copy), label (ref), Color3_fromRGB_ret6 (ref), u24 (copy), u25 (copy), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret (ref), Color3_fromRGB_ret7 (ref), Color3_fromRGB_ret4 (ref), u26 (copy), u28 (copy), u29 (copy), u34 (copy), Color3_fromRGB_ret9 (ref), Color3_fromRGB_ret11 (ref), Color3_fromRGB_ret8 (ref), Color3_fromRGB_ret10 (ref), u33 (copy), StoryRules (ref), Color3_fromRGB_ret5 (ref)
            u35 = p36;
            local v37 = p36.destination or {
                title = "UNKNOWN",
                subtitle = "",
                art = ""
            };
            u13.Text = v37.title;
            u14.Text = v37.subtitle;
            ImageLabel.Image = v37.art or "";
            local v38;

            if (v37.art or "") == "" then
                v38 = false;
            else
                v38 = p36.countdown == nil;
            end;

            ImageLabel.Visible = v38;
            local v39 = p36.countdown ~= nil;
            Frame4.Visible = not v39;
            Frame6.Visible = v39;
            local v40;

            if p36.access == "private" then
                v40 = false;
            else
                v40 = not v39;
            end;

            Frame2.Visible = v40;

            if v40 then
                ImageLabel.Visible = false;
            end;

            for _, child in ipairs(ScrollingFrame:GetChildren()) do
                if child:IsA("TextButton") or child.Name == "Empty" then
                    child:Destroy();
                end;
            end;

            local v41 = #(p36.members or {});
            local isLeader = p36.isLeader;
            serverRow(0, nil, "AUTO", "Best available", "", p36.pick == nil, isLeader, function() -- Line: 241
                -- upvalues: u12 (ref)
                u12:SelectServer(nil);
            end);

            for i, v in ipairs(p36.servers or {}) do
                local v42 = v.max - v.players >= math.max(1, v41);
                serverRow(i, v.code, v.code, v.region, ("%d/%d"):format(v.players, v.max), p36.pick == v.code, isLeader and v42, function(p43) -- Line: 245
                    -- upvalues: u12 (ref)
                    u12:SelectServer(p43);
                end);
            end;

            if #(p36.servers or {}) == 0 then
                local v44 = label(ScrollingFrame, {
                    size = 13,
                    text = p36.filter == "" and "No other servers running right now." or "No server matches that code.",
                    color = Color3_fromRGB_ret6,
                    sizeU = UDim2.new(1, -6, 0, 24)
                });
                v44.LayoutOrder = 999;
                v44.Name = "Empty";
            end;

            for _, v in ipairs({
                { u24, "open" },
                { u25, "private" }
            }) do
                local v45 = v[1];
                local v46 = v[2] == p36.access;
                v45.BackgroundColor3 = v46 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;
                v45.TextColor3 = v46 and Color3_fromRGB_ret7 or (p36.isLeader and Color3_fromRGB_ret4 or Color3_fromRGB_ret6);
                v45.Active = p36.isLeader;
            end;

            u26.Text = p36.access == "private" and "A private server for your squad only." or "Other stalkers may join this Zone.";
            local v47 = p36.members or {};
            u28.Text = ("%d/%d READY"):format(p36.readyCount or 0, #v47);

            for i, v in ipairs(u29) do
                local v48 = v47[i];

                if v48 then
                    v.name.Text = v48.name .. (v48.isLeader and "  (LEADER)" or "");
                    v.name.TextColor3 = Color3_fromRGB_ret4;
                    v.status.Text = v48.ready and "READY" or "NOT READY";
                    v.status.TextColor3 = v48.ready and Color3_fromRGB_ret7 or Color3_fromRGB_ret6;
                else
                    v.name.Text = "Empty slot";
                    v.name.TextColor3 = Color3_fromRGB_ret6;
                    v.status.Text = "";
                end;
            end;

            local v49;

            if (p36.readyCount or 0) >= #v47 then
                v49 = #v47 > 0;
            else
                v49 = false;
            end;

            if p36.locked then
                u34.Text = "LOCKED";
                u34.Active = false;
                u34.BackgroundColor3 = Color3_fromRGB_ret;
                u34.TextColor3 = Color3_fromRGB_ret6;
            elseif v39 then
                u34.Text = p36.isLeader and "CANCEL" or "WAITING";
                u34.Active = p36.isLeader;
                u34.BackgroundColor3 = p36.isLeader and Color3_fromRGB_ret9 or Color3_fromRGB_ret;
                u34.TextColor3 = p36.isLeader and Color3_fromRGB_ret11 or Color3_fromRGB_ret6;
            elseif p36.isLeader then
                u34.Text = v49 and "TRANSIT" or "WAITING FOR SQUAD";
                u34.Active = v49;
                u34.BackgroundColor3 = v49 and Color3_fromRGB_ret8 or Color3_fromRGB_ret9;
                u34.TextColor3 = v49 and Color3_fromRGB_ret10 or Color3_fromRGB_ret6;
            else
                local v50 = nil;

                for _, v in ipairs(v47) do
                    if v.isMe then
                        v50 = v;
                    end;
                end;

                if v50 then
                    v50 = v50.ready;
                end;

                u34.Text = v50 and "NOT READY" or "READY";
                u34.Active = true;
                u34.BackgroundColor3 = v50 and Color3_fromRGB_ret9 or Color3_fromRGB_ret8;
                u34.TextColor3 = Color3_fromRGB_ret10;
            end;

            if p36.locked or p36.notice then
                u33.Text = p36.locked and StoryRules.LOCKED_NOTICE or p36.notice;
                u33.TextColor3 = Color3_fromRGB_ret11;

                return;
            end;

            u33.TextColor3 = Color3_fromRGB_ret5;
            u33.Text = v39 and "Everyone must stay on the pad." or (p36.isLeader and "Everyone must be on the pad and ready." or "Press READY when you are set.");
        end
    };
    task.spawn(function() -- Line: 316
        -- upvalues: u11 (copy), u35 (ref), u27 (copy)
        while u11.Parent do
            if u35 and u35.countdown then
                local v52 = u35.countdown.endsAt - workspace:GetServerTimeNow();
                local math_ceil_ret = math.ceil(v52);
                local math_max_ret = math.max(0, math_ceil_ret);
                u27.Text = tostring(math_max_ret);
            end;

            task.wait(0.1);
        end;
    end);

    return v51;
end;

return v1;