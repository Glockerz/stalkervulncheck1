-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local MusicPlayer = require(ReplicatedStorage:WaitForChild("MusicPlayer"));
local MusicRules = require(ReplicatedStorage:WaitForChild("MusicRules"));
local MusicConfig = require(ReplicatedStorage:WaitForChild("MusicConfig"));
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 220, 220);
local Color3_fromRGB_ret3 = Color3.fromRGB(170, 170, 170);
local Color3_fromRGB_ret4 = Color3.fromRGB(120, 120, 120);
local Color3_fromRGB_ret5 = Color3.fromRGB(28, 30, 28);
local Color3_fromRGB_ret6 = Color3.fromRGB(38, 40, 38);
local Color3_fromRGB_ret7 = Color3.fromRGB(60, 70, 50);
local Color3_fromRGB_ret8 = Color3.fromRGB(40, 42, 45);
Color3.fromRGB(60, 60, 60);
local Color3_fromRGB_ret9 = Color3.fromRGB(225, 95, 95);
local v1 = {};

local function label(p2, p3) -- Line: 34
    -- upvalues: Font_new_ret3 (copy), Color3_fromRGB_ret2 (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = p3.font or Font_new_ret3;
    TextLabel.TextSize = p3.size or 16;
    TextLabel.TextColor3 = p3.color or Color3_fromRGB_ret2;
    TextLabel.Text = p3.text or "";
    TextLabel.TextXAlignment = p3.align or Enum.TextXAlignment.Left;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Size = p3.sizeU or UDim2.new(1, 0, 0, 20);
    TextLabel.Position = p3.pos or UDim2.new();
    TextLabel.Parent = p2;

    return TextLabel;
end;

local function button(p4, p5, p6, p7, p8) -- Line: 49
    -- upvalues: Color3_fromRGB_ret8 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.AutoButtonColor = true;
    TextButton.BackgroundColor3 = Color3_fromRGB_ret8;
    TextButton.BorderSizePixel = 0;
    TextButton.FontFace = Font_new_ret2;
    TextButton.TextSize = 16;
    TextButton.TextColor3 = Color3_fromRGB_ret2;
    TextButton.Text = p5;
    TextButton.Position = p6;
    TextButton.Size = p7;
    TextButton.Parent = p4;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 4);
    UICorner.Parent = TextButton;
    TextButton.MouseButton1Click:Connect(p8);

    return TextButton;
end;

local function slider(p9, p10, p11, u12) -- Line: 67
    -- upvalues: Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret (copy), UserInputService (copy)
    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3_fromRGB_ret6;
    Frame.BorderSizePixel = 0;
    Frame.Position = p10;
    Frame.Size = p11;
    Frame.Active = true;
    Frame.Parent = p9;
    local Frame2 = Instance.new("Frame");
    Frame2.BackgroundColor3 = Color3_fromRGB_ret;
    Frame2.BorderSizePixel = 0;
    Frame2.Size = UDim2.fromScale(0, 1);
    Frame2.Parent = Frame;
    local u13 = false;

    local function setFrom(p14) -- Line: 81
        -- upvalues: Frame (copy), u12 (copy)
        local X = Frame.AbsoluteSize.X;

        if X <= 0 then
            return;
        end;

        u12((math.clamp((p14 - Frame.AbsolutePosition.X) / X, 0, 1)));
    end;

    Frame.InputBegan:Connect(function(p15) -- Line: 86
        -- upvalues: u13 (ref), Frame (copy), u12 (copy)
        if p15.UserInputType == Enum.UserInputType.MouseButton1 or p15.UserInputType == Enum.UserInputType.Touch then
            u13 = true;
            local X = Frame.AbsoluteSize.X;

            if X <= 0 then
                return;
            end;

            u12((math.clamp((p15.Position.X - Frame.AbsolutePosition.X) / X, 0, 1)));
        end;
    end);
    local u17 = UserInputService.InputChanged:Connect(function(p16) -- Line: 92
        -- upvalues: u13 (ref), Frame (copy), u12 (copy)
        if u13 and (p16.UserInputType == Enum.UserInputType.MouseMovement or p16.UserInputType == Enum.UserInputType.Touch) then
            local X = Frame.AbsoluteSize.X;

            if X <= 0 then
                return;
            end;

            u12((math.clamp((p16.Position.X - Frame.AbsolutePosition.X) / X, 0, 1)));
        end;
    end);
    local u19 = UserInputService.InputEnded:Connect(function(p18) -- Line: 97
        -- upvalues: u13 (ref)
        if p18.UserInputType == Enum.UserInputType.MouseButton1 or p18.UserInputType == Enum.UserInputType.Touch then
            u13 = false;
        end;
    end);
    Frame.Destroying:Connect(function() -- Line: 102
        -- upvalues: u17 (copy), u19 (copy)
        u17:Disconnect();
        u19:Disconnect();
    end);

    return Frame, Frame2;
end;

function v1.Build(u20: userdata) -- Line: 106
    -- upvalues: MusicPlayer (copy), label (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret5 (copy), Font_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret9 (copy), slider (copy), Color3_fromRGB_ret4 (copy), button (copy), MusicConfig (copy), Color3_fromRGB_ret6 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret7 (copy), Font_new_ret2 (copy), MusicRules (copy)
    if not MusicPlayer:Enabled() then
        label(u20, {
            text = "Music is not available here",
            size = 20,
            align = Enum.TextXAlignment.Center,
            sizeU = UDim2.fromScale(1, 1),
            color = Color3_fromRGB_ret3
        });

        return;
    end;

    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3_fromRGB_ret5;
    Frame.BorderSizePixel = 0;
    Frame.Position = UDim2.new(0, 12, 0, 12);
    Frame.Size = UDim2.new(0.4, -18, 1, -24);
    Frame.Parent = u20;
    label(Frame, {
        text = "NOW PLAYING",
        size = 14,
        font = Font_new_ret,
        color = Color3_fromRGB_ret,
        pos = UDim2.new(0, 14, 0, 12)
    });
    local u21 = label(Frame, {
        text = "",
        size = 22,
        font = Font_new_ret,
        pos = UDim2.new(0, 14, 0, 36),
        sizeU = UDim2.new(1, -28, 0, 28)
    });
    local u22 = label(Frame, {
        text = "",
        size = 16,
        color = Color3_fromRGB_ret3,
        pos = UDim2.new(0, 14, 0, 66),
        sizeU = UDim2.new(1, -28, 0, 20)
    });
    local u23 = label(Frame, {
        text = "",
        size = 14,
        color = Color3_fromRGB_ret9,
        pos = UDim2.new(0, 14, 0, 88),
        sizeU = UDim2.new(1, -28, 0, 18)
    });
    local _, u25 = slider(Frame, UDim2.new(0, 14, 0, 118), UDim2.new(1, -28, 0, 8), function(p24) -- Line: 129
        -- upvalues: MusicPlayer (ref)
        MusicPlayer:SeekFraction(p24);
    end);
    local u26 = label(Frame, {
        text = "0:00",
        size = 13,
        color = Color3_fromRGB_ret4,
        pos = UDim2.new(0, 14, 0, 130),
        sizeU = UDim2.new(0.5, -14, 0, 16)
    });
    local u27 = label(Frame, {
        text = "",
        size = 13,
        color = Color3_fromRGB_ret4,
        pos = UDim2.new(0.5, 0, 0, 130),
        sizeU = UDim2.new(0.5, -14, 0, 16),
        align = Enum.TextXAlignment.Right
    });
    local UDim2_new_ret = UDim2.new(0.3, -6, 0, 38);
    button(Frame, "PREV", UDim2.new(0.05, 0, 0, 160), UDim2_new_ret, function() -- Line: 139
        -- upvalues: MusicPlayer (ref)
        MusicPlayer:Prev();
    end);
    local u28 = button(Frame, "PLAY", UDim2.new(0.35, 0, 0, 160), UDim2_new_ret, function() -- Line: 140
        -- upvalues: MusicPlayer (ref)
        MusicPlayer:Toggle();
    end);
    button(Frame, "NEXT", UDim2.new(0.65, 0, 0, 160), UDim2_new_ret, function() -- Line: 141
        -- upvalues: MusicPlayer (ref)
        MusicPlayer:Next();
    end);
    local u29 = button(Frame, "SHUFFLE", UDim2.new(0.05, 0, 0, 206), UDim2.new(0.45, -6, 0, 32), function() -- Line: 142
        -- upvalues: MusicPlayer (ref)
        MusicPlayer:SetShuffle(not MusicPlayer:GetState().settings.shuffle);
    end);
    local u30 = button(Frame, "REPEAT OFF", UDim2.new(0.5, 0, 0, 206), UDim2.new(0.45, -6, 0, 32), function() -- Line: 145
        -- upvalues: MusicPlayer (ref)
        MusicPlayer:CycleRepeat();
    end);
    label(Frame, {
        text = "VOLUME",
        size = 13,
        font = Font_new_ret,
        color = Color3_fromRGB_ret3,
        pos = UDim2.new(0, 14, 0, 252)
    });
    local u31 = label(Frame, {
        text = "",
        size = 13,
        color = Color3_fromRGB_ret3,
        pos = UDim2.new(0, 14, 0, 252),
        sizeU = UDim2.new(1, -28, 0, 20),
        align = Enum.TextXAlignment.Right
    });
    local _, u33 = slider(Frame, UDim2.new(0, 14, 0, 276), UDim2.new(1, -28, 0, 10), function(p32) -- Line: 152
        -- upvalues: MusicPlayer (ref), MusicConfig (ref)
        MusicPlayer:SetVolume(p32 * MusicConfig.VOLUME_MAX);
    end);
    local u34 = button(Frame, "", UDim2.new(0.05, 0, 0, 304), UDim2.new(0.9, 0, 0, 32), function() -- Line: 156
        -- upvalues: MusicPlayer (ref)
        MusicPlayer:SetSpeaker(not MusicPlayer:GetState().settings.speaker);
    end);
    local u35 = button(Frame, "", UDim2.new(0.05, 0, 0, 342), UDim2.new(0.9, 0, 0, 32), function() -- Line: 159
        -- upvalues: MusicPlayer (ref)
        MusicPlayer:SetHearOthers(not MusicPlayer:GetState().settings.hearOthers);
    end);
    local u36 = label(Frame, {
        text = "",
        size = 13,
        color = Color3_fromRGB_ret4,
        pos = UDim2.new(0, 14, 0, 380),
        sizeU = UDim2.new(1, -28, 0, 36)
    });
    u36.TextWrapped = true;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.BackgroundColor3 = Color3_fromRGB_ret5;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Position = UDim2.new(0.4, 6, 0, 12);
    ScrollingFrame.Size = UDim2.new(0.6, -18, 1, -24);
    ScrollingFrame.ScrollBarThickness = 6;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.CanvasSize = UDim2.new();
    ScrollingFrame.Parent = u20;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 2);
    UIListLayout.Parent = ScrollingFrame;
    local Frame2 = Instance.new("Frame");
    Frame2.BackgroundTransparency = 1;
    Frame2.Size = UDim2.new(1, -12, 0, 40);
    local TextBox = Instance.new("TextBox");
    TextBox.BackgroundColor3 = Color3_fromRGB_ret6;
    TextBox.BorderSizePixel = 0;
    TextBox.ClearTextOnFocus = false;
    TextBox.FontFace = Font_new_ret3;
    TextBox.TextSize = 15;
    TextBox.TextColor3 = Color3_fromRGB_ret2;
    TextBox.PlaceholderText = "Paste an audio ID";
    TextBox.PlaceholderColor3 = Color3_fromRGB_ret4;
    TextBox.Text = "";
    TextBox.TextXAlignment = Enum.TextXAlignment.Left;
    TextBox.Position = UDim2.new(0, 8, 0, 4);
    TextBox.Size = UDim2.new(1, -110, 0, 32);
    TextBox.Parent = Frame2;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 8);
    UIPadding.Parent = TextBox;
    local u37 = nil;
    button(Frame2, "ADD", UDim2.new(1, -96, 0, 4), UDim2.new(0, 88, 0, 32), function() -- Line: 202
        -- upvalues: TextBox (copy), MusicPlayer (ref), u37 (ref)
        local Text = TextBox.Text;
        task.spawn(function() -- Line: 204
            -- upvalues: MusicPlayer (ref), Text (copy), TextBox (ref), u37 (ref)
            local v38, v39 = MusicPlayer:AddCustom(Text);

            if v38 then
                TextBox.Text = "";
            end;

            if u37 and u37.Parent then
                u37.Text = v39 or "";
            end;
        end);
    end);

    local function section(p40, p41) -- Line: 211
        -- upvalues: label (ref), ScrollingFrame (copy), Font_new_ret (ref), Color3_fromRGB_ret (ref)
        local v42 = label(ScrollingFrame, {
            size = 14,
            text = p40,
            font = Font_new_ret,
            color = Color3_fromRGB_ret,
            sizeU = UDim2.new(1, -12, 0, 30)
        });
        v42.LayoutOrder = p41;
        local UIPadding2 = Instance.new("UIPadding");
        UIPadding2.PaddingLeft = UDim.new(0, 10);
        UIPadding2.PaddingTop = UDim.new(0, 8);
        UIPadding2.Parent = v42;
    end;

    local function row(u43, u44, u45, p46, p47) -- Line: 218
        -- upvalues: Color3_fromRGB_ret7 (ref), Color3_fromRGB_ret5 (ref), ScrollingFrame (copy), label (ref), Font_new_ret (ref), Font_new_ret2 (ref), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret3 (ref), MusicPlayer (ref), button (ref)
        local TextButton = Instance.new("TextButton");
        TextButton.AutoButtonColor = true;
        TextButton.Text = "";
        TextButton.BorderSizePixel = 0;
        TextButton.BackgroundColor3 = p46 and Color3_fromRGB_ret7 or Color3_fromRGB_ret5;
        TextButton.Size = UDim2.new(1, -12, 0, 34);
        TextButton.LayoutOrder = p47;
        TextButton.Parent = ScrollingFrame;
        label(TextButton, {
            size = 16,
            text = u45.name,
            font = p46 and Font_new_ret or Font_new_ret2,
            color = p46 and Color3_fromRGB_ret or Color3_fromRGB_ret2,
            pos = UDim2.new(0, 10, 0, 0),
            sizeU = UDim2.new(0.6, -10, 1, 0)
        });
        label(TextButton, {
            size = 14,
            text = u45.artist,
            color = Color3_fromRGB_ret3,
            pos = UDim2.new(0.6, 0, 0, 0),
            sizeU = UDim2.new(0.4, u43 == "custom" and -50 or -10, 1, 0)
        });
        TextButton.MouseButton1Click:Connect(function() -- Line: 231
            -- upvalues: MusicPlayer (ref), u43 (copy), u44 (copy)
            MusicPlayer:PlayFrom(u43, u44);
        end);

        if u43 == "custom" then
            button(TextButton, "X", UDim2.new(1, -40, 0, 4), UDim2.new(0, 32, 0, 26), function() -- Line: 233
                -- upvalues: MusicPlayer (ref), u45 (copy)
                MusicPlayer:RemoveCustom(u45.id);
            end);
        end;
    end;

    local u48 = nil;

    local function rebuildList(p49) -- Line: 240
        -- upvalues: MusicPlayer (ref), u48 (ref), Frame2 (copy), ScrollingFrame (copy), section (copy), label (ref), Color3_fromRGB_ret4 (ref), row (copy), MusicConfig (ref), u37 (ref)
        local entry = p49.entry;
        local v50 = MusicPlayer:List("custom");
        local table_concat_ret = table.concat(p49.settings.custom, ",");
        local v51;

        if entry then
            v51 = entry.id;
        else
            v51 = entry;
        end;

        local v52 = table_concat_ret .. "|" .. tostring(v51) .. "|" .. p49.source;

        for _, v in ipairs(v50) do
            v52 = v52 .. "|" .. v.name;
        end;

        if v52 == u48 then
            return;
        end;

        u48 = v52;
        Frame2.Parent = nil;

        for _, child in ipairs(ScrollingFrame:GetChildren()) do
            if not child:IsA("UIListLayout") then
                child:Destroy();
            end;
        end;

        local u53 = 0;

        local function nextOrder() -- Line: 252
            -- upvalues: u53 (ref)
            u53 = u53 + 1;

            return u53;
        end;

        u53 = u53 + 1;
        section("TRACKS", u53);
        local v54 = MusicPlayer:List("curated");

        if #v54 == 0 then
            local v55 = label(ScrollingFrame, {
                text = "No tracks yet",
                size = 15,
                color = Color3_fromRGB_ret4,
                sizeU = UDim2.new(1, -12, 0, 28)
            });
            u53 = u53 + 1;
            v55.LayoutOrder = u53;
            local UIPadding2 = Instance.new("UIPadding");
            UIPadding2.PaddingLeft = UDim.new(0, 10);
            UIPadding2.Parent = v55;
        end;

        for i, v in ipairs(v54) do
            local v56;

            if p49.source == "curated" and entry ~= nil then
                v56 = entry.id == v.id;
            else
                v56 = false;
            end;

            u53 = u53 + 1;
            row("curated", i, v, v56, u53);
        end;

        local v57 = ("CUSTOM  (%d/%d)"):format(#v50, MusicConfig.CUSTOM_MAX);
        u53 = u53 + 1;
        section(v57, u53);

        for i, v in ipairs(v50) do
            local v58;

            if p49.source == "custom" and entry ~= nil then
                v58 = entry.id == v.id;
            else
                v58 = false;
            end;

            u53 = u53 + 1;
            row("custom", i, v, v58, u53);
        end;

        u53 = u53 + 1;
        Frame2.LayoutOrder = u53;
        Frame2.Parent = ScrollingFrame;
        u37 = label(ScrollingFrame, {
            text = "",
            size = 13,
            color = Color3_fromRGB_ret4,
            sizeU = UDim2.new(1, -12, 0, 20)
        });
        u53 = u53 + 1;
        u37.LayoutOrder = u53;
        local UIPadding2 = Instance.new("UIPadding");
        UIPadding2.PaddingLeft = UDim.new(0, 10);
        UIPadding2.Parent = u37;
    end;

    local function render() -- Line: 274
        -- upvalues: u20 (copy), MusicPlayer (ref), u21 (copy), u22 (copy), u23 (copy), u28 (copy), u29 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref), u30 (copy), u33 (copy), MusicConfig (ref), u31 (copy), u34 (copy), u36 (copy), u35 (copy), rebuildList (copy)
        if not u20.Parent then
            return;
        end;

        local State = MusicPlayer:GetState();
        local entry = State.entry;
        u21.Text = entry and (entry.name or "Nothing playing") or "Nothing playing";
        u22.Text = entry and entry.artist or "Pick a track";
        u23.Text = State.error or "";
        u28.Text = State.playing and "PAUSE" or "PLAY";
        u29.TextColor3 = State.settings.shuffle and Color3_fromRGB_ret or Color3_fromRGB_ret2;
        u30.Text = ({
            off = "REPEAT OFF",
            all = "REPEAT ALL",
            one = "REPEAT ONE"
        })[State.settings.repeatMode];
        u30.TextColor3 = State.settings.repeatMode ~= "off" and Color3_fromRGB_ret or Color3_fromRGB_ret2;
        u33.Size = UDim2.fromScale(State.settings.volume / MusicConfig.VOLUME_MAX, 1);
        u31.Text = ("%d%%"):format((math.floor(State.settings.volume * 100 + 0.5)));
        u34.Text = State.settings.speaker and "SPEAKER: ON" or "SPEAKER: OFF (HEADPHONES)";
        u34.TextColor3 = State.settings.speaker and Color3_fromRGB_ret or Color3_fromRGB_ret2;
        u36.Text = State.settings.speaker and "Players near you can hear your music." or "";
        u35.Text = State.settings.hearOthers and "HEAR OTHER PLAYERS: ON" or "HEAR OTHER PLAYERS: OFF";
        rebuildList(State);
    end;

    local function tickProgress() -- Line: 295
        -- upvalues: MusicPlayer (ref), u25 (copy), u26 (copy), MusicRules (ref), u27 (copy)
        local State = MusicPlayer:GetState();
        local length = State.length;
        u25.Size = UDim2.fromScale(length > 0 and (math.clamp(State.position / length, 0, 1) or 0) or 0, 1);
        u26.Text = MusicRules.FormatTime(State.position);
        u27.Text = length > 0 and "-" .. MusicRules.FormatTime(length - State.position) or "";
    end;

    local v59 = MusicPlayer:OnChanged(render);
    u20.Destroying:Connect(v59);
    render();
    task.spawn(function() -- Line: 306
        -- upvalues: u20 (copy), tickProgress (copy)
        while u20.Parent do
            if u20.Visible then
                tickProgress();
            end;

            task.wait(0.25);
        end;
    end);
end;

return v1;