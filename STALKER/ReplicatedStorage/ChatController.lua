-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RankRules = require(ReplicatedStorage:WaitForChild("RankRules"));
local TextChatService = game:GetService("TextChatService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local Workspace = game:GetService("Workspace");
local success, result = pcall(function() -- Line: 15
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("SupporterCatalog", 5));
end);

if not success then
    result = nil;
end;

local function getSupporterTag(p1) -- Line: 23
    -- upvalues: result (ref)
    if not (p1 and result) then
        return nil;
    end;

    local Attribute = p1:GetAttribute("_SupporterTier");

    if type(Attribute) ~= "string" or Attribute == "" then
        return nil;
    end;

    local v2 = result.Tiers and result.Tiers[Attribute];

    if not v2 then
        return nil;
    end;

    local v3 = v2.ChatColor or Color3.fromRGB(230, 230, 230);
    local string_format_ret = string.format("#%02X%02X%02X", math.floor(v3.R * 255 + 0.5), math.floor(v3.G * 255 + 0.5), (math.floor(v3.B * 255 + 0.5)));

    return {
        prefix = v2.ChatPrefix,
        colorHex = string_format_ret
    };
end;

local LocalPlayer = Players.LocalPlayer;
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
UDim2.fromScale(0.01, 0.55);
local u4 = {
    ZoneRadio = {
        displayName = "Zone Radio",
        faction = "PDA",
        sound = "pda_dead"
    },
    ZoneAlert = {
        displayName = "Zone Alert",
        faction = "PDA",
        sound = "pda_alarm"
    },
    ZoneEvents = {
        displayName = "Zone Events",
        faction = "PDA"
    },
    ZoneLoner = {
        displayName = "Stalker",
        faction = "Loner"
    },
    ZoneBandit = {
        displayName = "Bandit",
        faction = "Bandit"
    },
    ZoneMonolith = {
        displayName = "Unknown Signal",
        faction = "Monolith",
        sound = "pda_sos"
    },
    ZoneReputation = {
        displayName = "Reputation",
        faction = "PDA",
        sound = "pda_note_alt"
    },
    RadioBandit = {
        displayName = "Bandit",
        faction = "Bandit",
        radio = true,
        tag = "BANDIT",
        tint = Color3.fromRGB(196, 150, 96)
    },
    RadioMilitary = {
        displayName = "Military",
        faction = "Military",
        radio = true,
        tag = "MILITARY",
        tint = Color3.fromRGB(150, 172, 118)
    },
    RadioClearSky = {
        displayName = "Clear Sky",
        faction = "Clear Sky",
        radio = true,
        tag = "CLEAR SKY",
        tint = Color3.fromRGB(110, 170, 210)
    },
    RadioLoner = {
        displayName = "Loner",
        faction = "Loner",
        radio = true,
        tag = "LONER",
        tint = Color3.fromRGB(200, 186, 120)
    },
    RadioMonolith = {
        displayName = "Monolith",
        faction = "Monolith",
        radio = true,
        tag = "MONOLITH",
        tint = Color3.fromRGB(176, 176, 196)
    }
};
local v5 = {
    _initialized = false,
    _transientGui = nil,
    _transientList = nil,
    _historyGui = nil,
    _historyList = nil,
    _allMessages = {},
    _inputBar = nil,
    _inputBox = nil
};

local function getFactionFor(p6) -- Line: 103
    return p6 and (p6:GetAttribute("Faction") or "Loner") or "";
end;

local u7 = { "fuck", "shit", "bitch", "cunt", "faggot", "nigger", "nigga", "whore", "slut", "retard", "tranny", "dyke", "kike", "spic", "chink" };

local function censorText(p8) -- Line: 118
    -- upvalues: u7 (copy)
    if type(p8) == "string" and p8 ~= "" then
        return p8:gsub("%w+", function(p9) -- Line: 120
            -- upvalues: u7 (ref)
            local v10 = p9:lower();

            for _, v in ipairs(u7) do
                if v10:find(v, 1, true) then
                    return string.rep("*", #p9);
                end;
            end;
        end);
    end;

    return p8;
end;

local function formatTimestamp(p11) -- Line: 130
    local math_floor_ret = math.floor(p11 / 3600 % 24);
    local math_floor_ret2 = math.floor(p11 / 60 % 60);

    return string.format("%02d:%02d", math_floor_ret, math_floor_ret2);
end;

function v5.Init(p12) -- Line: 136
    if p12._initialized then
        return;
    end;

    p12._initialized = true;
    p12:_buildGui();
    p12:_wireChat();
    p12:_wireInput();
    p12:_wireInputBar();
    p12:_wireTraderChat();
    print("[ChatController] initialized");
end;

function v5._buildGui(p13) -- Line: 147
    -- upvalues: LocalPlayer (copy), Font_new_ret3 (copy), Font_new_ret (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "ChatGui";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 5;
    ScreenGui.Parent = PlayerGui;
    p13._transientGui = ScreenGui;
    local Frame = Instance.new("Frame");
    Frame.Name = "Transient";
    Frame.Size = UDim2.new(0.36, 0, 0, 500);
    Frame.AnchorPoint = Vector2.new(0, 0.5);
    Frame.Position = UDim2.new(0, 12, 0.5, 0);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = ScreenGui;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "InputBar";
    Frame2.Size = UDim2.new(0.36, 0, 0, 40);
    Frame2.AnchorPoint = Vector2.new(0, 0);
    Frame2.Position = UDim2.new(0, 12, 0.5, 260);
    Frame2.BackgroundColor3 = Color3.fromRGB(25, 27, 24);
    Frame2.BackgroundTransparency = 0;
    Frame2.BorderSizePixel = 0;
    Frame2.Visible = false;
    Frame2.Parent = ScreenGui;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(48, 48, 48);
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame2;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 80, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 3, 2)) });
    UIGradient.Rotation = -90;
    UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.46875) });
    UIGradient.Parent = Frame2;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 12);
    UIPadding.PaddingRight = UDim.new(0, 12);
    UIPadding.Parent = Frame2;
    local TextBox = Instance.new("TextBox");
    TextBox.Name = "Input";
    TextBox.Size = UDim2.fromScale(1, 1);
    TextBox.BackgroundTransparency = 1;
    TextBox.PlaceholderText = "Type message...";
    TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120);
    TextBox.Text = "";
    TextBox.ClearTextOnFocus = false;
    TextBox.MultiLine = false;
    TextBox.TextEditable = true;
    TextBox.TextXAlignment = Enum.TextXAlignment.Left;
    TextBox.TextYAlignment = Enum.TextYAlignment.Center;
    TextBox.TextColor3 = Color3.fromRGB(240, 240, 240);
    TextBox.TextSize = 16;
    TextBox.FontFace = Font_new_ret3;
    TextBox.Parent = Frame2;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3.fromRGB(0, 0, 0);
    UIStroke2.Thickness = 1.5;
    UIStroke2.Transparency = 0.4;
    UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    UIStroke2.Parent = TextBox;
    p13._inputBar = Frame2;
    p13._inputBox = TextBox;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.Padding = UDim.new(0, 6);
    UIListLayout.Parent = Frame;
    p13._transientList = Frame;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "History";
    Frame3.Size = UDim2.fromScale(0.4, 0.7);
    Frame3.Position = UDim2.fromScale(0.5, 0.5);
    Frame3.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame3.BackgroundColor3 = Color3.fromRGB(25, 27, 24);
    Frame3.BackgroundTransparency = 0;
    Frame3.Visible = false;
    Frame3.Parent = ScreenGui;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = Color3.fromRGB(48, 48, 48);
    UIStroke3.Thickness = 1;
    UIStroke3.Parent = Frame3;
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 80, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 3, 2)) });
    UIGradient2.Rotation = -90;
    UIGradient2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.46875) });
    UIGradient2.Parent = Frame3;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, 0, 0, 32);
    TextLabel.Position = UDim2.fromOffset(0, 0);
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.BackgroundTransparency = 0;
    TextLabel.Text = "PDA MESSAGES";
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 24;
    TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220);
    TextLabel.Parent = Frame3;
    local UIGradient3 = Instance.new("UIGradient");
    UIGradient3.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 27, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 53, 53)) });
    UIGradient3.Rotation = -90;
    UIGradient3.Parent = TextLabel;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "List";
    ScrollingFrame.Size = UDim2.new(1, 0, 1, -32);
    ScrollingFrame.Position = UDim2.fromOffset(0, 32);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.CanvasSize = UDim2.new();
    ScrollingFrame.ScrollBarThickness = 6;
    ScrollingFrame.Parent = Frame3;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.Padding = UDim.new(0, 6);
    UIListLayout2.Parent = ScrollingFrame;
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.PaddingTop = UDim.new(0, 8);
    UIPadding2.PaddingBottom = UDim.new(0, 8);
    UIPadding2.PaddingLeft = UDim.new(0, 8);
    UIPadding2.PaddingRight = UDim.new(0, 8);
    UIPadding2.Parent = ScrollingFrame;
    p13._historyGui = Frame3;
    p13._historyList = ScrollingFrame;
end;

function v5._wireChat(u14) -- Line: 308
    -- upvalues: TextChatService (copy), Players (copy), getSupporterTag (copy), ReplicatedStorage (copy)
    local v15 = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration");

    if v15 then
        v15.Enabled = false;
    end;

    local v16 = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration");

    if v16 then
        v16.Enabled = false;
    end;

    TextChatService.OnIncomingMessage = nil;

    local function handleMessage(p17) -- Line: 324
        -- upvalues: u14 (copy), Players (ref), getSupporterTag (ref), ReplicatedStorage (ref)
        if not (p17 and p17.TextSource) then
            return;
        end;

        u14._seenMessageIds = u14._seenMessageIds or {};
        local MessageId = p17.MessageId;

        if MessageId then
            if u14._seenMessageIds[MessageId] then
                return;
            end;

            u14._seenMessageIds[MessageId] = true;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId(p17.TextSource.UserId);
        local u18 = PlayerByUserId and (PlayerByUserId.DisplayName or "Unknown") or "Unknown";
        local u19 = PlayerByUserId and (PlayerByUserId.UserId or 0) or 0;
        local u20 = PlayerByUserId and (PlayerByUserId:GetAttribute("Faction") or "Loner") or "";
        local u21 = getSupporterTag(PlayerByUserId);
        local u22;

        if PlayerByUserId then
            u22 = PlayerByUserId:GetAttribute("PlayerRank");
        else
            u22 = PlayerByUserId;
        end;

        local Status = p17.Status;

        if Status == Enum.TextChatMessageStatus.InvalidTextChannelPermissions or (Status == Enum.TextChatMessageStatus.TextFilterFailed or Status == Enum.TextChatMessageStatus.Floodchecked) then
            return;
        end;

        local Text = p17.Text;

        if not Text or Text == "" then
            return;
        end;

        local function u26(p23) -- Line: 358
            -- upvalues: u14 (ref), u18 (copy), u19 (copy), u20 (copy), u21 (copy), u22 (copy)
            local v24 = {
                sender = u18,
                userId = u19,
                text = p23,
                faction = u20,
                time = os.time()
            };
            v24.supporterPrefix = u21 and u21.prefix;
            v24.supporterColorHex = u21 and u21.colorHex;
            local v25;

            if type(u22) == "string" and u22 ~= "" then
                v25 = u22 or nil;
            else
                v25 = nil;
            end;

            v24.rank = v25;
            u14:_addMessage(v24);
        end;

        if PlayerByUserId == Players.LocalPlayer then
            task.spawn(function() -- Line: 371
                -- upvalues: ReplicatedStorage (ref), Text (copy), u26 (copy)
                local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

                if Remotes then
                    Remotes = Remotes:FindFirstChild("FilterSelfChat");
                end;

                local v27 = Text;
                local v28;

                if Remotes then
                    local v29;
                    v29, v28 = pcall(function() -- Line: 376
                        -- upvalues: Remotes (copy), Text (ref)
                        return Remotes:InvokeServer(Text);
                    end);

                    if v29 and typeof(v28) == "string" then
                        if v28 == "" then
                            v28 = v27;
                        end;
                    else
                        v28 = v27;
                    end;
                else
                    v28 = v27;
                end;

                u26(v28);
            end);

            return;
        end;

        u26(Text);
    end;

    local TextChannels = TextChatService:WaitForChild("TextChannels");

    local function hookChannel(p30) -- Line: 390
        -- upvalues: handleMessage (copy)
        if p30:IsA("TextChannel") and (p30.Name == "RBXGeneral" or p30.Name == "RBXGeneralChannel") then
            p30.MessageReceived:Connect(handleMessage);
        end;
    end;

    for _, child in ipairs(TextChannels:GetChildren()) do
        if child:IsA("TextChannel") and (child.Name == "RBXGeneral" or child.Name == "RBXGeneralChannel") then
            child.MessageReceived:Connect(handleMessage);
        end;
    end;

    TextChannels.ChildAdded:Connect(hookChannel);
end;

function v5._wireTraderChat(u31) -- Line: 400
    -- upvalues: ReplicatedStorage (copy), u4 (copy), LocalPlayer (copy), Workspace (copy)
    local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

    if Remotes then
        Remotes = Remotes:FindFirstChild("TraderChatMessage");
    end;

    if not Remotes then
        return;
    end;

    local success2, result2 = pcall(require, ReplicatedStorage:WaitForChild("PdaSound"));

    if not success2 then
        result2 = nil;
    end;

    Remotes.OnClientEvent:Connect(function(p32, p33, p34, p35, p36) -- Line: 412
        -- upvalues: u4 (ref), LocalPlayer (ref), Workspace (ref), u31 (copy), result2 (ref)
        if typeof(p32) ~= "string" or typeof(p33) ~= "string" then
            return;
        end;

        local v37 = u4[p32];

        if v37 and (v37.radio and LocalPlayer:GetAttribute("NpcRadioMuted") == true) then
            return;
        end;

        local v38, v39;

        if v37 then
            v38 = v37.displayName;
            v39 = v37.faction or "PDA";
        else
            local NPCs = Workspace:FindFirstChild("NPCs");

            if NPCs then
                NPCs = NPCs:FindFirstChild("Traders");
            end;

            if NPCs then
                NPCs = NPCs:FindFirstChild(p32);
            end;

            if NPCs then
                v38 = NPCs:GetAttribute("TraderID") or p32;
            else
                v38 = p32;
            end;

            v39 = "Trader";
        end;

        if typeof(p34) == "string" then
            if p34 == "" then
                p34 = v38;
            end;
        else
            p34 = v38;
        end;

        local v40 = {
            userId = 0,
            sender = p34,
            npcId = p32,
            look = p35,
            text = p33,
            faction = v39,
            time = os.time()
        };
        local v41;

        if v37 then
            v41 = v37.radio or nil;
        else
            v41 = nil;
        end;

        v40.radio = v41;
        local v42;

        if v37 then
            v42 = v37.tag or nil;
        else
            v42 = nil;
        end;

        v40.radioTag = v42;
        local v43;

        if v37 then
            v43 = v37.tint or nil;
        else
            v43 = nil;
        end;

        v40.radioTint = v43;
        u31:_addMessage(v40);
        local v44 = (typeof(p36) ~= "string" or (p36 == "" or not p36)) and (v37 and (v37.sound or "pda_notify") or "pda_notify") or p36;

        if result2 then
            result2.Play(v44, v37 and v37.radio and 0.25 or nil);
        end;
    end);
end;

function v5._wireInput(u45) -- Line: 458
    -- upvalues: UserInputService (copy)
    UserInputService.InputBegan:Connect(function(p46, p47) -- Line: 459
        -- upvalues: u45 (copy)
        if p47 then
            return;
        end;

        if p46.KeyCode == Enum.KeyCode.Y then
            u45:_toggleHistory();
        end;
    end);
end;

function v5._wireInputBar(p48) -- Line: 467
    -- upvalues: UserInputService (copy), TextChatService (copy)
    local _inputBox = p48._inputBox;
    local _inputBar = p48._inputBar;
    UserInputService.InputBegan:Connect(function(p49, p50) -- Line: 471
        -- upvalues: _inputBar (copy), _inputBox (copy)
        if p50 then
            return;
        end;

        if p49.KeyCode == Enum.KeyCode.Slash then
            _inputBar.Visible = true;
            task.defer(function() -- Line: 475
                -- upvalues: _inputBox (ref)
                _inputBox:CaptureFocus();
                task.wait();

                if _inputBox.Text == "/" then
                    _inputBox.Text = "";
                end;
            end);
        end;
    end);
    _inputBox.FocusLost:Connect(function(p51) -- Line: 487
        -- upvalues: _inputBox (copy), _inputBar (copy), TextChatService (ref)
        local u52 = p51 and _inputBox.Text or nil;
        _inputBox.Text = "";
        _inputBar.Visible = false;

        if u52 and u52 ~= "" then
            local TextChannels = TextChatService:FindFirstChild("TextChannels");

            if TextChannels then
                TextChannels = TextChannels:FindFirstChild("RBXGeneralChannel") or TextChannels:FindFirstChild("RBXGeneral");
            end;

            if TextChannels then
                pcall(function() -- Line: 500
                    -- upvalues: TextChannels (copy), u52 (copy)
                    TextChannels:SendAsync(u52);
                end);
            end;
        end;
    end);
end;

function v5._toggleHistory(u53) -- Line: 506
    if not u53._historyGui then
        return;
    end;

    local v54 = not u53._historyGui.Visible;
    u53._historyGui.Visible = v54;

    if v54 then
        task.defer(function() -- Line: 511
            -- upvalues: u53 (copy)
            if u53._historyList then
                u53._historyList.CanvasPosition = Vector2.new(0, u53._historyList.AbsoluteCanvasSize.Y);
            end;
        end);
    end;
end;

local function assembleRig(p55) -- Line: 533
    local v56 = {};

    for _, descendant in ipairs(p55:GetDescendants()) do
        if descendant:IsA("Motor6D") and (descendant.Part0 and descendant.Part1) then
            table.insert(v56, descendant);
        end;
    end;

    for i = 1, 4 do
        local _ = i;

        for _, v in ipairs(v56) do
            v.Part1.CFrame = v.Part0.CFrame * v.C0 * v.C1:Inverse();
        end;
    end;
end;

local function isRigAssembled(p57) -- Line: 549
    local Head = p57:FindFirstChild("Head");
    local v58 = p57:FindFirstChild("Torso") or p57:FindFirstChild("UpperTorso");

    return not (Head and v58) and true or (Head.Position - v58.Position).Magnitude < 8;
end;

local u59 = {
    ZoneLoner = "Loner",
    ZoneBandit = "Bandit",
    RadioBandit = "Bandit",
    RadioMilitary = "Military",
    RadioClearSky = "ClearSky",
    RadioLoner = "Loner",
    RadioMonolith = "Monolith"
};
local u60 = {
    Loner = "LonerOutfit",
    Bandit = "BanditLCSuit"
};
local u61 = {
    Head = true,
    Torso = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    HumanoidRootPart = true
};

local function dressRig(p62, p63, p64) -- Line: 604
    -- upvalues: u60 (copy), ReplicatedStorage (copy), u61 (copy)
    local v65 = p64 and p64.uniform or u60[p63];

    if v65 then
        local success2, result2 = pcall(require, ReplicatedStorage:FindFirstChild("ItemDatabase"));
        local v66 = success2 and result2 and result2.GetItemData(v65);

        if v66 then
            local v67 = p62:FindFirstChildOfClass("Shirt");
            local v68 = p62:FindFirstChildOfClass("Pants");

            if v67 and v66.ShirtID then
                v67.ShirtTemplate = v66.ShirtID;
            end;

            if v68 and v66.PantsID then
                v68.PantsTemplate = v66.PantsID;
            end;
        end;
    end;

    if p64 then
        p64 = p64.skin;
    end;

    if not p64 then
        return;
    end;

    local success2, result2 = pcall(require, ReplicatedStorage:FindFirstChild("StalkerVoice"));

    if not (success2 and result2) then
        return;
    end;

    local v69 = result2.SKIN_TONES and result2.SKIN_TONES[p64];

    if not v69 then
        return;
    end;

    for _, child in ipairs(p62:GetChildren()) do
        if child:IsA("BasePart") and u61[child.Name] then
            child.Color = v69;
            child.Material = Enum.Material.SmoothPlastic;
        end;
    end;
end;

local function findNpcCharacter(p70) -- Line: 635
    -- upvalues: Workspace (copy), ReplicatedStorage (copy)
    local PlayerCharacters = Workspace:FindFirstChild("PlayerCharacters");

    if PlayerCharacters then
        PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
    end;

    if PlayerCharacters then
        local v71 = {};

        for _, child in ipairs(PlayerCharacters:GetChildren()) do
            if child:IsA("Model") and (child:GetAttribute("Faction") == p70 and (child:FindFirstChild("Head") and child:FindFirstChild("HumanoidRootPart"))) then
                local v72 = child:FindFirstChildOfClass("Humanoid");

                if v72 and v72.Health > 0 then
                    table.insert(v71, child);
                end;
            end;
        end;

        if #v71 > 0 then
            return v71[math.random(1, #v71)], false;
        end;
    end;

    return ReplicatedStorage:FindFirstChild("HostileNPC"), true;
end;

local function makePortrait(u73, p74, p75, p76) -- Line: 657
    -- upvalues: u59 (copy), ReplicatedStorage (copy), findNpcCharacter (copy), Players (copy), assembleRig (copy), dressRig (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromOffset(p74, p74);
    Frame.BackgroundColor3 = Color3.fromRGB(20, 22, 20);
    Frame.BorderSizePixel = 0;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(48, 48, 48);
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame;

    local function drawIcon() -- Line: 674
        -- upvalues: Frame (copy)
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Size = UDim2.fromScale(1, 1);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxassetid://70595759053813";
        ImageLabel.Parent = Frame;

        return Frame;
    end;

    local v77 = nil;
    local v78 = nil;
    local v79;

    if p75 then
        v77 = u59[p75];

        if not v77 then
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Image = "rbxassetid://70595759053813";
            ImageLabel.Parent = Frame;

            return Frame;
        end;

        if p76 and (p76.npc == nil and (p76.model == nil and (p76.uniform == nil and p76.skin == nil))) then
            p76 = nil;
        end;

        if p76 and (typeof(p76.npc) == "Instance" and (p76.npc:IsA("Model") and (p76.npc.Parent and (p76.npc:FindFirstChild("Head") and p76.npc:FindFirstChild("HumanoidRootPart"))))) then
            v79 = p76.npc;
            v78 = false;
        elseif p76 and p76.model then
            v79 = ReplicatedStorage:FindFirstChild("MainTaskNpcs");

            if v79 then
                v79 = v79:FindFirstChild(p76.model);
            end;

            if v79 and v79:IsA("Model") then
                v78 = false;
            else
                v79 = ReplicatedStorage:FindFirstChild("HostileNPC");
                v78 = true;
            end;
        elseif p76 then
            v79 = ReplicatedStorage:FindFirstChild("HostileNPC");
            v78 = true;
        else
            v79, v78 = findNpcCharacter(v77);
        end;

        if not v79 then
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Image = "rbxassetid://70595759053813";
            ImageLabel.Parent = Frame;

            return Frame;
        end;
    else
        if not u73 then
            return Frame;
        end;

        v79 = u73.Character;
    end;

    local v80;

    if v79 then
        v80 = v79:FindFirstChild("Head");
    else
        v80 = v79;
    end;

    local v81;

    if v79 then
        v81 = v79:FindFirstChild("HumanoidRootPart");
    else
        v81 = v79;
    end;

    if not (v79 and (v80 and v81)) then
        if p75 then
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Image = "rbxassetid://70595759053813";
            ImageLabel.Parent = Frame;

            return Frame;
        end;

        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Size = UDim2.fromScale(1, 1);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Parent = Frame;
        task.spawn(function() -- Line: 733
            -- upvalues: Players (ref), u73 (copy), ImageLabel (copy)
            local success2, result2 = pcall(function() -- Line: 734
                -- upvalues: Players (ref), u73 (ref)
                return Players:GetUserThumbnailAsync(u73.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60);
            end);

            if success2 and ImageLabel.Parent then
                ImageLabel.Image = result2;
            end;
        end);

        return Frame;
    end;

    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Size = UDim2.fromScale(1, 1);
    ViewportFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 20);
    ViewportFrame.BackgroundTransparency = 0;
    ViewportFrame.BorderSizePixel = 0;
    ViewportFrame.Ambient = Color3.fromRGB(180, 180, 180);
    ViewportFrame.LightColor = Color3.fromRGB(255, 255, 255);
    ViewportFrame.LightDirection = (Vector3.new(-0.3, -1, -0.5)).Unit;
    ViewportFrame.Parent = Frame;
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = ViewportFrame;

    local function makeArchivable(p82) -- Line: 757
        -- upvalues: makeArchivable (copy)
        if not p82.Archivable then
            p82.Archivable = true;
        end;

        for _, child in ipairs(p82:GetChildren()) do
            makeArchivable(child);
        end;
    end;

    if not v79.Archivable then
        v79.Archivable = true;
    end;

    for _, child in ipairs(v79:GetChildren()) do
        makeArchivable(child);
    end;

    local v83 = v79:Clone();

    for _, descendant in ipairs(v83:GetDescendants()) do
        if descendant:IsA("Script") or descendant:IsA("LocalScript") then
            descendant:Destroy();
        end;
    end;

    v83.Parent = WorldModel;
    local Head = v83:FindFirstChild("Head");
    local v84 = v83:FindFirstChild("Torso") or v83:FindFirstChild("UpperTorso");

    if Head and v84 and (Head.Position - v84.Position).Magnitude >= 8 then
        assembleRig(v83);
    end;

    if v78 then
        dressRig(v83, v77, p76);
    end;

    for _, descendant in ipairs(v83:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;

    local v85 = v83:FindFirstChild("Head") or v80;
    local v86 = v83:FindFirstChild("HumanoidRootPart") or v81;
    local Position = v85.Position;
    local v87 = Position + v86.CFrame.LookVector * 2.5;
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 40;
    Camera.CFrame = CFrame.new(v87, Position);
    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;

    return Frame;
end;

function v5._makeEntry(p88, p89, p90, p91) -- Line: 796
    -- upvalues: makePortrait (copy), Players (copy), Font_new_ret2 (copy), RankRules (copy), Font_new_ret3 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Msg";
    Frame.Size = UDim2.new(1, 0, 0, 68);
    Frame.AutomaticSize = Enum.AutomaticSize.Y;
    Frame.BackgroundTransparency = 1;
    Frame.LayoutOrder = p91 and #p88._allMessages or os.clock();
    Frame.Parent = p89;
    local v92 = makePortrait(Players:GetPlayerByUserId(p90.userId or 0), 60, p90.npcId, p90.look);
    v92.Position = UDim2.fromOffset(0, 0);
    v92.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, -70, 0, 18);
    TextLabel.Position = UDim2.fromOffset(68, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 15;
    TextLabel.TextColor3 = Color3.fromRGB(170, 170, 170);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.RichText = true;
    local sender = p90.sender;

    if p90.supporterColorHex then
        sender = string.format("<font color=\"%s\">%s</font>", p90.supporterColorHex, p90.sender);
    end;

    if p90.supporterPrefix and p90.supporterPrefix ~= "" then
        sender = string.format("<font color=\"%s\">%s</font> %s", p90.supporterColorHex or "#DCB43C", p90.supporterPrefix, sender);
    end;

    local faction = p90.faction;

    if p90.rank then
        faction = string.format("<font color=\"#%s\">%s</font> %s", RankRules.ColorFor(p90.rank):ToHex(), p90.rank, p90.faction);
    end;

    local string_format = string.format;
    local time = p90.time;
    local math_floor_ret = math.floor(time / 3600 % 24);
    local math_floor_ret2 = math.floor(time / 60 % 60);
    TextLabel.Text = string_format("%s  %s, %s", string.format("%02d:%02d", math_floor_ret, math_floor_ret2), sender, faction);

    if p90.radio then
        local string_format2 = string.format;
        local time2 = p90.time;
        local math_floor_ret3 = math.floor(time2 / 3600 % 24);
        local math_floor_ret4 = math.floor(time2 / 60 % 60);
        TextLabel.Text = string_format2("%s  <font color=\"#%s\">[%s]</font> %s", string.format("%02d:%02d", math_floor_ret3, math_floor_ret4), p90.radioTint:ToHex(), p90.radioTag, sender);
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Name = "RadioBadge";
        TextLabel2.Size = UDim2.new(1, 0, 0, 14);
        TextLabel2.Position = UDim2.new(0, 0, 1, -14);
        TextLabel2.BackgroundColor3 = Color3.fromRGB(12, 14, 12);
        TextLabel2.BackgroundTransparency = 0.25;
        TextLabel2.BorderSizePixel = 0;
        TextLabel2.FontFace = Font_new_ret2;
        TextLabel2.TextSize = 11;
        TextLabel2.TextColor3 = p90.radioTint;
        TextLabel2.Text = "RADIO";
        TextLabel2.Parent = v92;
    end;

    TextLabel.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(0, 0, 0);
    UIStroke.Thickness = 1.5;
    UIStroke.Transparency = 0.4;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    UIStroke.Parent = TextLabel;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.new(1, -70, 0, 0);
    TextLabel2.Position = UDim2.fromOffset(68, 20);
    TextLabel2.AutomaticSize = Enum.AutomaticSize.Y;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 18;
    TextLabel2.TextColor3 = p90.radio and Color3.fromRGB(200, 200, 190) or Color3.fromRGB(230, 230, 230);
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.TextWrapped = true;
    TextLabel2.Text = p90.text;
    TextLabel2.Parent = Frame;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3.fromRGB(0, 0, 0);
    UIStroke2.Thickness = 1.5;
    UIStroke2.Transparency = 0.4;
    UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    UIStroke2.Parent = TextLabel2;

    return Frame, v92, TextLabel, TextLabel2;
end;

function v5._addMessage(p93, p94) -- Line: 888
    -- upvalues: u7 (copy), TweenService (copy)
    if p94 and p94.text then
        local text = p94.text;

        if type(text) == "string" and text ~= "" then
            text = text:gsub("%w+", function(p95) -- Line: 120
                -- upvalues: u7 (ref)
                local v96 = p95:lower();

                for _, v in ipairs(u7) do
                    if v96:find(v, 1, true) then
                        return string.rep("*", #p95);
                    end;
                end;
            end);
        end;

        p94.text = text;
    end;

    table.insert(p93._allMessages, p94);
    p93:_makeEntry(p93._historyList, p94, true);
    local u97, _, _, _ = p93:_makeEntry(p93._transientList, p94, false);
    local v98 = {};

    for _, child in ipairs(p93._transientList:GetChildren()) do
        if child:IsA("Frame") then
            table.insert(v98, child);
        end;
    end;

    while #v98 > 8 do
        v98[1]:Destroy();
        table.remove(v98, 1);
    end;

    task.delay(18, function() -- Line: 910
        -- upvalues: u97 (copy), TweenService (ref)
        if not u97.Parent then
            return;
        end;

        local TweenInfo_new_ret = TweenInfo.new(1.5, Enum.EasingStyle.Linear);
        local v99 = {};

        for _, descendant in ipairs(u97:GetDescendants()) do
            if descendant:IsA("ViewportFrame") then
                table.insert(v99, TweenService:Create(descendant, TweenInfo_new_ret, {
                    ImageTransparency = 1,
                    BackgroundTransparency = 1
                }));
            elseif descendant:IsA("Frame") then
                if descendant.BackgroundTransparency < 1 then
                    table.insert(v99, TweenService:Create(descendant, TweenInfo_new_ret, {
                        BackgroundTransparency = 1
                    }));
                end;
            elseif descendant:IsA("ImageLabel") then
                table.insert(v99, TweenService:Create(descendant, TweenInfo_new_ret, {
                    ImageTransparency = 1,
                    BackgroundTransparency = 1
                }));
            elseif descendant:IsA("TextLabel") then
                table.insert(v99, TweenService:Create(descendant, TweenInfo_new_ret, {
                    TextTransparency = 1,
                    BackgroundTransparency = 1,
                    TextStrokeTransparency = 1
                }));
                local v100 = descendant:FindFirstChildOfClass("UIStroke");

                if v100 then
                    table.insert(v99, TweenService:Create(v100, TweenInfo_new_ret, {
                        Transparency = 1
                    }));
                end;
            elseif descendant:IsA("UIStroke") then
                table.insert(v99, TweenService:Create(descendant, TweenInfo_new_ret, {
                    Transparency = 1
                }));
            end;
        end;

        for _, v in ipairs(v99) do
            v:Play();
        end;

        task.delay(1.6, function() -- Line: 934
            -- upvalues: u97 (ref)
            if u97.Parent then
                u97:Destroy();
            end;
        end);
    end);
end;

return v5;