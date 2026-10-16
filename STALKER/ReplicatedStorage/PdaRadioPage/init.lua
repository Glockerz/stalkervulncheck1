-- Decompiled with Potassium's decompiler.

local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 220, 220);
local Color3_fromRGB_ret3 = Color3.fromRGB(170, 170, 170);
local Color3_fromRGB_ret4 = Color3.fromRGB(120, 120, 120);
local Color3_fromRGB_ret5 = Color3.fromRGB(60, 70, 50);
local Color3_fromRGB_ret6 = Color3.fromRGB(140, 170, 90);
local Color3_fromRGB_ret7 = Color3.fromRGB(60, 60, 60);
local Color3_fromRGB_ret8 = Color3.fromRGB(40, 42, 45);

local function buildWaveform(p1, p2) -- Line: 14
    -- upvalues: Font_new_ret2 (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromOffset(180, 28);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p1;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.Padding = UDim.new(0, 2);
    UIListLayout.Parent = Frame;

    for i, v in ipairs({ 6, 14, 22, 10, 18, 26, 8, 14, 20, 6, 12, 22, 16, 10, 18, 24, 12, 8, 14, 20, 6, 12, 18 }) do
        local Frame2 = Instance.new("Frame");
        Frame2.Size = UDim2.fromOffset(3, v);
        Frame2.BackgroundColor3 = Color3.fromRGB(180, 220, 130);
        Frame2.BorderSizePixel = 0;
        Frame2.LayoutOrder = i;
        Frame2.Parent = Frame;
    end;

    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.fromOffset(28, 22);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 16;
    TextLabel.TextColor3 = Color3.fromRGB(180, 220, 130);
    TextLabel.Text = tostring(p2);
    TextLabel.LayoutOrder = 999;
    TextLabel.Parent = Frame;

    return TextLabel;
end;

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RadioClient = require(ReplicatedStorage:WaitForChild("RadioClient"));
local RadioRules = require(ReplicatedStorage:WaitForChild("RadioRules"));
local RadioConfig = require(ReplicatedStorage:WaitForChild("RadioConfig"));
local ContactController = require(ReplicatedStorage:WaitForChild("ContactController"));
local TradeView = require(script:WaitForChild("TradeView"));
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret9 = Color3.fromRGB(225, 95, 95);
local u3 = {
    busy = "Working...",
    bad_form = "Check the item and price.",
    muted = "You are muted.",
    try_later = "Radio busy. Try again in a moment.",
    cooldown = "Wait before posting again.",
    cap = "You already have 3 listings.",
    not_owned = "You no longer have that item.",
    unknown_item = "Unknown item.",
    funds = "Not enough roubles.",
    filter = "That listing could not be posted.",
    left = "",
    store_failed = "Posting failed. You were not charged.",
    not_yours = "Not your listing.",
    already = "You already sent interest.",
    cannot_contact = "You can\'t contact this player. A block or their chat settings prevent it.",
    not_lobby = "You must be in the Lobby to teleport to this player.",
    they_not_lobby = "That stalker isn\'t in the Lobby right now.",
    no_relation = "Send Interested first.",
    offline = "That stalker is offline.",
    not_public = "They are in a private server.",
    same_server = "They are in your server.",
    join_failed = "Could not join. The server may be full.",
    save_failed = "Could not save before joining. Try again.",
    slow_down = "Wait a moment before sending another.",
    not_contact = "Only contacts can be messaged.",
    not_here = "That stalker is not in your server.",
    cannot_receive = "This player can\'t receive messages.",
    chat_unavailable = RadioConfig.DISABLED_TEXT
};

local function reasonText(p4) -- Line: 82
    -- upvalues: RadioRules (copy), u3 (copy)
    local v5 = type(p4) == "table" and p4 and p4 or {};

    if v5.reason == "cooldown" and tonumber(v5.wait) then
        local v6 = tonumber(v5.wait);
        local math_ceil_ret = math.ceil(v6);

        return ("Wait %ds before posting again."):format((math.max(1, math_ceil_ret)));
    end;

    if v5.reason == "cap" and tonumber(v5.max) then
        return ("You already have %d active listings, the maximum. Cancel one or wait for one to expire."):format((tonumber(v5.max)));
    end;

    if v5.reason == "funds" and (tonumber(v5.need) and tonumber(v5.have)) then
        return ("This needs %s. You have %s."):format(RadioRules.FormatRoubles((tonumber(v5.need))), RadioRules.FormatRoubles((tonumber(v5.have))));
    end;

    return u3[v5.reason] or u3.try_later;
end;

local function label(p7, p8) -- Line: 94
    -- upvalues: Font_new_ret3 (copy), Color3_fromRGB_ret2 (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = p8.font or Font_new_ret3;
    TextLabel.TextSize = p8.size or 14;
    TextLabel.TextColor3 = p8.color or Color3_fromRGB_ret2;
    TextLabel.TextXAlignment = p8.align or Enum.TextXAlignment.Left;
    TextLabel.TextWrapped = p8.wrap or false;
    TextLabel.Text = p8.text or "";
    TextLabel.Position = p8.pos or UDim2.new();
    TextLabel.Size = p8.sizeU or UDim2.new(1, 0, 0, 20);
    TextLabel.LayoutOrder = p8.order or 0;
    TextLabel.Parent = p7;

    return TextLabel;
end;

local function button(p9, p10, p11, p12, p13) -- Line: 110
    -- upvalues: Color3_fromRGB_ret8 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.Position = p11;
    TextButton.Size = p12;
    TextButton.BackgroundColor3 = Color3_fromRGB_ret8;
    TextButton.BackgroundTransparency = 0.2;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = true;
    TextButton.FontFace = Font_new_ret2;
    TextButton.TextSize = 13;
    TextButton.TextColor3 = Color3_fromRGB_ret2;
    TextButton.Text = p10;
    TextButton.Parent = p9;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(80, 80, 80);
    UIStroke.Thickness = 1;
    UIStroke.Parent = TextButton;
    TextButton.MouseButton1Click:Connect(p13);

    return TextButton;
end;

local function divider(p14) -- Line: 131
    -- upvalues: Color3_fromRGB_ret7 (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 0, 1);
    Frame.AnchorPoint = Vector2.new(0, 1);
    Frame.Position = UDim2.new(0, 0, 1, 0);
    Frame.BackgroundColor3 = Color3_fromRGB_ret7;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p14;
end;

local function buildChannelEntry(p15, p16, p17, p18, p19, p20, p21, p22) -- Line: 141
    -- upvalues: Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret6 (copy), label (copy), Font_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret9 (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Channel_" .. p16.id;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.Size = UDim2.new(1, -4, 0, 56);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret5;
    TextButton.BackgroundTransparency = p18 and 0.25 or 1;
    TextButton.BorderSizePixel = 0;
    TextButton.LayoutOrder = p17;
    TextButton.Parent = p15;
    TextButton.MouseButton1Click:Connect(p21);

    if p18 then
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3_fromRGB_ret6;
        UIStroke.Thickness = 1;
        UIStroke.Transparency = 0.3;
        UIStroke.Parent = TextButton;
    end;

    label(TextButton, {
        text = "⧖",
        size = 18,
        font = Font_new_ret,
        color = p18 and Color3_fromRGB_ret or Color3_fromRGB_ret3,
        pos = UDim2.fromOffset(14, 18),
        sizeU = UDim2.fromOffset(20, 20)
    });
    label(TextButton, {
        size = 17,
        text = p16.name,
        font = Font_new_ret2,
        color = p20 and Color3_fromRGB_ret4 or Color3_fromRGB_ret2,
        pos = UDim2.fromOffset(42, 8),
        sizeU = UDim2.new(1, -110, 0, 22)
    });
    label(TextButton, {
        size = 13,
        text = p16.sub,
        color = Color3_fromRGB_ret3,
        pos = UDim2.fromOffset(42, 30),
        sizeU = UDim2.new(1, -110, 0, 18)
    });

    if p19 then
        label(TextButton, {
            size = 16,
            text = string.format("%02d", p19),
            font = Font_new_ret2,
            color = p18 and Color3_fromRGB_ret or Color3_fromRGB_ret3,
            align = Enum.TextXAlignment.Right,
            pos = UDim2.new(1, -70, 0, 6),
            sizeU = UDim2.fromOffset(60, 22)
        });
    end;

    if p22 then
        local TextButton2 = Instance.new("TextButton");
        TextButton2.AnchorPoint = Vector2.new(1, 1);
        TextButton2.Position = UDim2.new(1, -10, 1, -6);
        TextButton2.Size = UDim2.fromOffset(60, 16);
        TextButton2.BackgroundTransparency = 1;
        TextButton2.FontFace = Font_new_ret2;
        TextButton2.TextSize = 11;
        TextButton2.TextColor3 = p20 and Color3_fromRGB_ret9 or Color3_fromRGB_ret4;
        TextButton2.Text = p20 and "MUTED" or "MUTE";
        TextButton2.TextXAlignment = Enum.TextXAlignment.Right;
        TextButton2.Parent = TextButton;
        TextButton2.MouseButton1Click:Connect(p22);
    end;
end;

local function buildMessageRow(p23, p24, p25) -- Line: 186
    -- upvalues: label (copy), Font_new_ret (copy), LocalPlayer (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret4 (copy), divider (copy)
    local Frame = Instance.new("Frame");
    Frame.AutomaticSize = Enum.AutomaticSize.Y;
    Frame.Size = UDim2.new(1, 0, 0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.LayoutOrder = p25;
    Frame.Parent = p23;
    label(Frame, {
        size = 18,
        text = p24.dn,
        font = Font_new_ret,
        color = p24.u == LocalPlayer.UserId and Color3_fromRGB_ret or Color3_fromRGB_ret2,
        sizeU = UDim2.new(0.7, 0, 0, 22)
    });
    label(Frame, {
        size = 14,
        text = os.date("%H:%M", p24.ts),
        color = Color3_fromRGB_ret4,
        align = Enum.TextXAlignment.Right,
        pos = UDim2.new(1, -60, 0, 0),
        sizeU = UDim2.fromOffset(60, 22)
    });
    local v26 = label(Frame, {
        size = 16,
        wrap = true,
        text = p24.t,
        pos = UDim2.fromOffset(0, 24),
        sizeU = UDim2.new(1, 0, 0, 0)
    });
    v26.AutomaticSize = Enum.AutomaticSize.Y;
    v26.TextYAlignment = Enum.TextYAlignment.Top;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.new(1, 0, 0, 14);
    Frame2.AnchorPoint = Vector2.new(0, 1);
    Frame2.Position = UDim2.new(0, 0, 1, 0);
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;
    divider(Frame);
end;

return {
    Build = function(p27) -- Line: 211, Name: Build
        -- upvalues: RadioClient (copy), label (copy), Font_new_ret (copy), button (copy), buildWaveform (copy), Color3_fromRGB_ret5 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), RadioConfig (copy), RadioRules (copy), buildChannelEntry (copy), buildMessageRow (copy), TradeView (copy), u3 (copy), reasonText (copy), ContactController (copy)
        RadioClient:Init();
        local Frame = Instance.new("Frame");
        Frame.Name = "Body";
        Frame.Position = UDim2.fromOffset(16, 8);
        Frame.Size = UDim2.new(1, -32, 1, -16);
        Frame.BackgroundTransparency = 1;
        Frame.Parent = p27;
        local Frame2 = Instance.new("Frame");
        Frame2.Size = UDim2.new(0.28, 0, 1, 0);
        Frame2.BackgroundTransparency = 1;
        Frame2.Parent = Frame;
        label(Frame2, {
            text = "RADIO",
            size = 22,
            font = Font_new_ret,
            pos = UDim2.fromOffset(28, 0),
            sizeU = UDim2.new(1, -28, 0, 30)
        });
        local u28 = {
            tab = "channels",
            channelId = "map",
            dmUserId = nil,
            status = "",
            trade = {
                filter = "all",
                sort = "new"
            }
        };
        local u29 = nil;
        local u30 = {};

        for i, v in ipairs({ { "channels", "CHANNELS" }, { "contacts", "CONTACTS" } }) do
            u30[v[1]] = button(Frame2, v[2], UDim2.new((i - 1) * 0.5, (i - 1) * 2, 0, 36), UDim2.new(0.5, -2, 0, 32), function() -- Line: 232
                -- upvalues: u28 (copy), v (copy), u29 (ref)
                u28.tab = v[1];
                u28.status = "";
                u29();
            end);
        end;

        local ScrollingFrame = Instance.new("ScrollingFrame");
        ScrollingFrame.Position = UDim2.fromOffset(0, 76);
        ScrollingFrame.Size = UDim2.new(1, 0, 1, -76);
        ScrollingFrame.BackgroundTransparency = 1;
        ScrollingFrame.BorderSizePixel = 0;
        ScrollingFrame.ScrollBarThickness = 4;
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        ScrollingFrame.CanvasSize = UDim2.new();
        ScrollingFrame.Parent = Frame2;
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout.Padding = UDim.new(0, 4);
        UIListLayout.Parent = ScrollingFrame;
        local Frame3 = Instance.new("Frame");
        Frame3.Position = UDim2.new(0.28, 16, 0, 0);
        Frame3.Size = UDim2.new(0.72, -16, 1, 0);
        Frame3.BackgroundTransparency = 1;
        Frame3.Parent = Frame;
        local u31 = label(Frame3, {
            size = 24,
            font = Font_new_ret,
            sizeU = UDim2.fromOffset(260, 32)
        });
        local Frame4 = Instance.new("Frame");
        Frame4.Position = UDim2.fromOffset(270, 2);
        Frame4.Size = UDim2.fromOffset(220, 28);
        Frame4.BackgroundTransparency = 1;
        Frame4.Parent = Frame3;
        local u32 = buildWaveform(Frame4, 0);
        local Frame5 = Instance.new("Frame");
        Frame5.AnchorPoint = Vector2.new(1, 0);
        Frame5.Position = UDim2.new(1, 0, 0, 0);
        Frame5.Size = UDim2.fromOffset(180, 50);
        Frame5.BackgroundColor3 = Color3_fromRGB_ret5;
        Frame5.BackgroundTransparency = 0.4;
        Frame5.BorderSizePixel = 0;
        Frame5.Parent = Frame3;
        label(Frame5, {
            text = "ONLINE IN THE ZONE",
            size = 12,
            font = Font_new_ret2,
            color = Color3_fromRGB_ret4,
            pos = UDim2.fromOffset(12, 4),
            sizeU = UDim2.fromOffset(160, 18)
        });
        local u33 = label(Frame5, {
            size = 22,
            font = Font_new_ret,
            pos = UDim2.fromOffset(12, 20),
            sizeU = UDim2.fromOffset(60, 26)
        });
        label(Frame5, {
            text = "Stalkers",
            size = 14,
            color = Color3_fromRGB_ret3,
            pos = UDim2.fromOffset(72, 22),
            sizeU = UDim2.fromOffset(100, 22)
        });
        local u34 = label(Frame3, {
            size = 14,
            color = Color3_fromRGB_ret3,
            pos = UDim2.fromOffset(0, 36),
            sizeU = UDim2.new(1, -200, 0, 22)
        });
        local u35 = button(Frame3, "◀ RADIO", UDim2.fromOffset(0, 2), UDim2.fromOffset(100, 30), function() -- Line: 280
            -- upvalues: u28 (copy), u29 (ref)
            u28.channelId = "map";
            u28.trade.posting = nil;
            u28.status = "";
            u29();
        end);
        u35.Visible = false;
        local Frame6 = Instance.new("Frame");
        Frame6.Name = "TradeBar";
        Frame6.Position = UDim2.fromOffset(0, 64);
        Frame6.Size = UDim2.new(1, 0, 0, 30);
        Frame6.BackgroundTransparency = 1;
        Frame6.Visible = false;
        Frame6.Parent = Frame3;
        local UIListLayout2 = Instance.new("UIListLayout");
        UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout2.Padding = UDim.new(0, 4);
        UIListLayout2.Parent = Frame6;
        local TextBox = Instance.new("TextBox");
        TextBox.Name = "Search";
        TextBox.BackgroundColor3 = Color3.fromRGB(24, 26, 24);
        TextBox.BorderSizePixel = 0;
        TextBox.ClearTextOnFocus = false;
        TextBox.FontFace = Font_new_ret3;
        TextBox.TextSize = 14;
        TextBox.TextColor3 = Color3_fromRGB_ret2;
        TextBox.PlaceholderColor3 = Color3_fromRGB_ret4;
        TextBox.PlaceholderText = "Search...";
        TextBox.TextXAlignment = Enum.TextXAlignment.Left;
        TextBox.Text = "";
        TextBox.Visible = false;
        TextBox.Parent = Frame6;
        local Frame7 = Instance.new("Frame");
        Frame7.Name = "TradeFooter";
        Frame7.AnchorPoint = Vector2.new(0, 1);
        Frame7.Position = UDim2.new(0, 0, 1, 0);
        Frame7.Size = UDim2.new(1, 0, 0, 0);
        Frame7.BorderSizePixel = 0;
        Frame7.Visible = false;
        Frame7.Parent = Frame3;
        local ScrollingFrame2 = Instance.new("ScrollingFrame");
        ScrollingFrame2.Position = UDim2.fromOffset(0, 66);
        ScrollingFrame2.Size = UDim2.new(1, 0, 1, -140);
        ScrollingFrame2.BackgroundTransparency = 1;
        ScrollingFrame2.BorderSizePixel = 0;
        ScrollingFrame2.ScrollBarThickness = 4;
        ScrollingFrame2.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        ScrollingFrame2.CanvasSize = UDim2.new();
        ScrollingFrame2.Parent = Frame3;
        local UIListLayout3 = Instance.new("UIListLayout");
        UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout3.Parent = ScrollingFrame2;
        local u36 = label(Frame3, {
            size = 13,
            color = Color3_fromRGB_ret,
            pos = UDim2.new(0, 0, 1, -70),
            sizeU = UDim2.new(1, 0, 0, 18)
        });
        local Frame8 = Instance.new("Frame");
        Frame8.AnchorPoint = Vector2.new(0, 1);
        Frame8.Position = UDim2.new(0, 0, 1, 0);
        Frame8.Size = UDim2.new(1, 0, 0, 44);
        Frame8.BackgroundColor3 = Color3.fromRGB(28, 30, 28);
        Frame8.BorderSizePixel = 0;
        Frame8.Parent = Frame3;
        local TextBox2 = Instance.new("TextBox");
        TextBox2.Position = UDim2.fromOffset(14, 0);
        TextBox2.Size = UDim2.new(1, -150, 1, 0);
        TextBox2.BackgroundTransparency = 1;
        TextBox2.ClearTextOnFocus = false;
        TextBox2.FontFace = Font_new_ret3;
        TextBox2.TextSize = 15;
        TextBox2.TextColor3 = Color3_fromRGB_ret2;
        TextBox2.PlaceholderColor3 = Color3_fromRGB_ret4;
        TextBox2.TextXAlignment = Enum.TextXAlignment.Left;
        TextBox2.Text = "";
        TextBox2.Parent = Frame8;
        local u37 = label(Frame8, {
            size = 15,
            color = Color3_fromRGB_ret4,
            align = Enum.TextXAlignment.Center,
            sizeU = UDim2.fromScale(1, 1)
        });
        local u38 = nil;

        local function clear(p39) -- Line: 364
            for _, child in ipairs(p39:GetChildren()) do
                if not child:IsA("UIListLayout") then
                    child:Destroy();
                end;
            end;
        end;

        local function setStatus(p40) -- Line: 369
            -- upvalues: u28 (copy), u36 (copy)
            u28.status = p40;
            u36.Text = p40;
        end;

        local function updateInput() -- Line: 371
            -- upvalues: RadioClient (ref), Frame8 (copy), u28 (copy), TextBox2 (copy), u38 (ref), u37 (copy), RadioConfig (ref)
            local State = RadioClient:GetState();
            local v41;

            if State == nil then
                v41 = false;
            else
                v41 = State.allowed == true;
            end;

            Frame8.Visible = true;
            local v42;

            if u28.tab == "channels" then
                v42 = u28.channelId == "zone";
            else
                v42 = false;
            end;

            local v43;

            if u28.tab == "contacts" then
                v43 = not u28.dmUserId;
            else
                v43 = false;
            end;

            local v44;

            if v41 then
                v44 = not v42 and not v43;
            else
                v44 = v41;
            end;

            TextBox2.Visible = v44;
            u38.Visible = TextBox2.Visible;
            u37.Visible = not TextBox2.Visible;
            u37.Text = (v42 or v43 and v41) and "" or RadioConfig.DISABLED_TEXT;

            if u28.tab ~= "channels" or u28.channelId ~= "trade" then
                TextBox2.PlaceholderText = "Type your message...";
                u38.Text = "SEND";

                return;
            end;

            TextBox2.Visible = false;
            u38.Visible = false;
            u37.Visible = not v41;
            u37.Text = RadioConfig.DISABLED_TEXT;
            Frame8.Visible = not v41;
        end;

        u29 = function() -- Line: 396
            -- upvalues: Frame (copy), RadioClient (ref), u30 (copy), u28 (copy), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret3 (ref), u33 (copy), ScrollingFrame2 (copy), clear (copy), ScrollingFrame (copy), u36 (copy), Frame6 (copy), Frame7 (copy), Frame2 (copy), Frame3 (copy), u35 (copy), u31 (copy), Frame4 (copy), Frame5 (copy), u34 (copy), RadioRules (ref), buildChannelEntry (ref), u29 (ref), u32 (copy), buildMessageRow (ref), TradeView (ref), TextBox (copy), setStatus (copy), u3 (ref), reasonText (ref), label (ref), RadioConfig (ref), Color3_fromRGB_ret4 (ref), ContactController (ref), updateInput (copy)
            if not Frame.Parent then
                return;
            end;

            local State = RadioClient:GetState();
            local v45 = State and (State.counts or {
                total = 0,
                byPlace = {}
            }) or {
                total = 0,
                byPlace = {}
            };
            local v46 = State and (State.placeKey or "lobby") or "lobby";
            local v47 = State and (State.mutes or {
                channels = {},
                contacts = {}
            }) or {
                channels = {},
                contacts = {}
            };

            for i, v in pairs(u30) do
                v.BackgroundTransparency = i == u28.tab and 0.2 or 0.5;
                v.TextColor3 = i == u28.tab and Color3_fromRGB_ret2 or Color3_fromRGB_ret3;
            end;

            u33.Text = tostring(v45.total or 0);
            local v48 = ScrollingFrame2.CanvasPosition.Y >= ScrollingFrame2.AbsoluteCanvasSize.Y - ScrollingFrame2.AbsoluteWindowSize.Y - 24;
            clear(ScrollingFrame);
            clear(ScrollingFrame2);
            u36.Text = u28.status;
            local v49;

            if u28.tab == "channels" then
                v49 = u28.channelId == "trade";
            else
                v49 = false;
            end;

            Frame6.Visible = v49;
            Frame7.Visible = v49;
            Frame2.Visible = not v49;
            Frame3.Position = v49 and UDim2.new() or UDim2.new(0.28, 16, 0, 0);
            Frame3.Size = v49 and UDim2.fromScale(1, 1) or UDim2.new(0.72, -16, 1, 0);
            u35.Visible = v49;
            u31.Position = v49 and UDim2.fromOffset(112, 0) or UDim2.new();
            Frame4.Visible = not v49;
            Frame5.Visible = not v49;
            u34.Position = v49 and UDim2.fromOffset(230, 6) or UDim2.fromOffset(0, 36);

            if not v49 then
                ScrollingFrame2.Position = UDim2.fromOffset(0, 66);
                ScrollingFrame2.Size = UDim2.new(1, 0, 1, -140);
                u36.Position = UDim2.new(0, 0, 1, -70);
            end;

            if u28.tab == "channels" then
                local v50 = RadioRules.ChannelsFor(v46);
                local v51 = nil;

                for i, v in ipairs(v50) do
                    if v.id == u28.channelId then
                        v51 = v;
                    end;

                    local u52 = v47.channels[v.id] == true;
                    buildChannelEntry(ScrollingFrame, v, i, v.id == u28.channelId, RadioRules.CountFor(v.id, v46, v45), u52, function() -- Line: 437
                        -- upvalues: u28 (ref), v (copy), u36 (ref), u29 (ref)
                        u28.channelId = v.id;
                        u28.trade.posting = nil;
                        u28.status = "";
                        u36.Text = "";
                        u29();
                    end, v.kind ~= "wip" and (function() -- Line: 438
                        -- upvalues: RadioClient (ref), v (copy), u52 (copy)
                        RadioClient:SetMute("channel", v.id, not u52);
                    end or nil) or nil);
                end;

                u31.Text = v51 and (v51.name or "") or "";
                u34.Text = v51 and v51.sub or "";
                u32.Text = tostring(RadioRules.CountFor(u28.channelId, v46, v45));

                if u28.channelId == "map" then
                    for i, v in ipairs(RadioClient:MapMessages()) do
                        buildMessageRow(ScrollingFrame2, v, i);
                    end;
                elseif u28.channelId == "trade" then
                    local Render = TradeView.Render;
                    local v53 = {
                        feed = ScrollingFrame2,
                        bar = Frame6,
                        search = TextBox,
                        footer = Frame7,
                        state = u28.trade,
                        placeKey = v46
                    };
                    local v54;

                    if State == nil then
                        v54 = false;
                    else
                        v54 = State.allowed == true;
                    end;

                    v53.allowed = v54;
                    v53.setStatus = setStatus;
                    v53.rerender = u29;
                    v53.reasons = u3;
                    v53.reasonText = reasonText;
                    local v55, v56 = Render(v53);
                    Frame6.Size = UDim2.new(1, 0, 0, v55);
                    Frame7.Size = UDim2.new(1, 0, 0, v56);
                    local v57 = v56 > 0 and v56 + 22 or 64;
                    u36.Position = UDim2.new(0, 0, 1, -v57 + 2);
                    Frame6.Position = UDim2.fromOffset(0, 38);
                    ScrollingFrame2.Position = UDim2.fromOffset(0, 38 + v55 + 4);
                    ScrollingFrame2.Size = UDim2.new(1, 0, 1, -(38 + v55 + 4 + v57));
                    u34.Text = ("%d stalkers online in the Zone"):format(v45.total or 0);
                else
                    label(ScrollingFrame2, {
                        size = 16,
                        text = RadioConfig.ZONE_WIP_TEXT,
                        color = Color3_fromRGB_ret4,
                        align = Enum.TextXAlignment.Center,
                        sizeU = UDim2.new(1, 0, 0, 60)
                    });
                end;
            else
                local v58 = RadioClient:ContactsOnline();
                local v59 = 0;

                for _, v in ipairs(ContactController:GetContacts("player")) do
                    v59 = v59 + 1;
                    local v60 = v58[tostring(v.userId)];
                    local u61 = v47.contacts[tostring(v.userId)] == true;
                    local v62 = v60 == "here" and "In your server" or (v60 and "In " .. (RadioConfig.MAP_NAMES[v60] or v60) or "Offline");
                    buildChannelEntry(ScrollingFrame, {
                        id = "c" .. v.userId,
                        name = string.upper(v.displayName or "?"),
                        sub = v62
                    }, v59, v.userId == u28.dmUserId, nil, u61, function() -- Line: 477
                        -- upvalues: u28 (ref), v (copy), u36 (ref), u29 (ref)
                        u28.dmUserId = v.userId;
                        u28.status = "";
                        u36.Text = "";
                        u29();
                    end, function() -- Line: 478
                        -- upvalues: RadioClient (ref), v (copy), u61 (copy)
                        RadioClient:SetMute("contact", v.userId, not u61);
                    end);
                end;

                u31.Text = u28.dmUserId and "DIRECT" or "CONTACTS";
                u34.Text = u28.dmUserId and "Private. Only the two of you see this." or "Pick a contact in your server.";
                u32.Text = "";

                if u28.dmUserId then
                    for i, v in ipairs(RadioClient:Thread(u28.dmUserId)) do
                        buildMessageRow(ScrollingFrame2, v, i);
                    end;
                end;
            end;

            updateInput();

            if (u28.tab == "contacts" and true or u28.channelId == "map") and v48 then
                task.defer(function() -- Line: 492
                    -- upvalues: ScrollingFrame2 (ref)
                    if ScrollingFrame2.Parent then
                        ScrollingFrame2.CanvasPosition = Vector2.new(0, ScrollingFrame2.AbsoluteCanvasSize.Y);
                    end;
                end);
            end;
        end;

        local function send() -- Line: 498
            -- upvalues: TextBox2 (copy), u28 (copy), RadioClient (ref), u3 (ref), u36 (copy), u29 (ref)
            local Text = TextBox2.Text;

            if u28.tab == "contacts" then
                if not u28.dmUserId or Text == "" then
                    return;
                end;

                local v63 = RadioClient:SendDM(u28.dmUserId, Text);

                if v63.ok then
                    TextBox2.Text = "";
                else
                    local v64 = u3[v63.reason] or u3.try_later;
                    u28.status = v64;
                    u36.Text = v64;
                end;
            elseif u28.channelId == "map" and RadioClient:SendMap(Text) then
                TextBox2.Text = "";
            end;

            u29();
        end;

        u38 = button(Frame8, "SEND", UDim2.new(1, -128, 0, 7), UDim2.fromOffset(120, 30), send);
        TextBox2.FocusLost:Connect(function(p65) -- Line: 510
            -- upvalues: send (copy)
            if p65 then
                send();
            end;
        end);
        TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 512
            -- upvalues: u28 (copy), u29 (ref)
            if u28.trade.posting and u28.trade.posting.step == 1 then
                u29();
            end;
        end);
        local UserInputService = game:GetService("UserInputService");
        local u66 = RadioClient:OnChanged(function() -- Line: 519
            -- upvalues: u28 (copy), updateInput (copy), UserInputService (copy), Frame (copy), TextBox2 (copy), TextBox (copy), u29 (ref)
            if u28.trade.posting then
                updateInput();

                return;
            end;

            local FocusedTextBox = UserInputService:GetFocusedTextBox();

            if FocusedTextBox and (FocusedTextBox:IsDescendantOf(Frame) and (FocusedTextBox ~= TextBox2 and FocusedTextBox ~= TextBox)) then
                updateInput();

                return;
            end;

            u29();
        end);
        local u68 = RadioClient:OnFocusDM(function(p67) -- Line: 530
            -- upvalues: u28 (copy), u29 (ref)
            u28.tab = "contacts";
            u28.dmUserId = p67;
            u29();
        end);
        Frame.AncestryChanged:Connect(function() -- Line: 535
            -- upvalues: Frame (copy), u66 (copy), u68 (copy)
            if not Frame:IsDescendantOf(game) then
                u66();
                u68();
            end;
        end);
        task.spawn(function() -- Line: 538
            -- upvalues: Frame (copy), updateInput (copy), TradeView (ref), u28 (copy)
            while Frame:IsDescendantOf(game) do
                updateInput();
                TradeView.Tick({
                    state = u28.trade
                });
                task.wait(1);
            end;
        end);
        u29();
    end
};