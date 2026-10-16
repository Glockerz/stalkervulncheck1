-- Decompiled with Potassium's decompiler.

local PdaMapData = require(game:GetService("ReplicatedStorage"):WaitForChild("PdaMapData"));
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 90, 80);
local Color3_fromRGB_ret3 = Color3.fromRGB(220, 220, 220);
local Color3_fromRGB_ret4 = Color3.fromRGB(170, 170, 170);
local Color3_fromRGB_ret5 = Color3.fromRGB(120, 120, 120);
local Color3_fromRGB_ret6 = Color3.fromRGB(60, 70, 50);
Color3.fromRGB(140, 170, 90);
local Color3_fromRGB_ret7 = Color3.fromRGB(60, 60, 60);
Color3.fromRGB(28, 30, 28);
local Color3_fromRGB_ret8 = Color3.fromRGB(40, 42, 45);
local Color3_fromRGB_ret9 = Color3.fromRGB(45, 48, 42);
Color3.fromRGB(35, 42, 30);
local u1 = {
    online = Color3.fromRGB(140, 200, 120),
    away = Color3.fromRGB(235, 165, 75),
    offline = Color3.fromRGB(120, 120, 120)
};

local function makeAvatar(p2, p3, p4, p5) -- Line: 30
    -- upvalues: Color3_fromRGB_ret9 (copy), Font_new_ret (copy), u1 (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromOffset(p3, p3);
    Frame.BackgroundColor3 = Color3_fromRGB_ret9;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p2;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(70, 70, 70);
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = math.floor(p3 * 0.5);
    TextLabel.TextColor3 = Color3.fromRGB(170, 175, 160);
    TextLabel.Text = string.sub(p4, 1, 1):upper();
    TextLabel.Parent = Frame;

    if p5 then
        local Frame2 = Instance.new("Frame");
        Frame2.AnchorPoint = Vector2.new(1, 1);
        Frame2.Position = UDim2.new(1, -2, 1, -2);
        Frame2.Size = UDim2.fromOffset(8, 8);
        Frame2.BackgroundColor3 = u1[p5];
        Frame2.BorderSizePixel = 0;
        Frame2.Parent = Frame;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = Frame2;
    end;

    return Frame;
end;

local function buildContactEntry(p6, u7, p8, u9) -- Line: 67
    -- upvalues: Color3_fromRGB_ret6 (copy), makeAvatar (copy), u1 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Contact_" .. (u7.type == "npc" and u7.npcId or tostring(u7.userId));
    TextButton.Size = UDim2.new(1, -4, 0, 64);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret6;
    TextButton.BackgroundTransparency = 1;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = false;
    TextButton.Text = "";
    TextButton.LayoutOrder = p8;
    TextButton.Parent = p6;
    local Frame = Instance.new("Frame");
    Frame.Position = UDim2.fromOffset(8, 8);
    Frame.Size = UDim2.fromOffset(48, 48);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = TextButton;
    local v10 = u7.type == "npc" and u7.name or u7.displayName;
    makeAvatar(Frame, 48, v10);
    local Players = game:GetService("Players");
    local v11;

    if u7.type == "npc" then
        v11 = u1.online;
    else
        v11 = Players:GetPlayerByUserId(u7.userId) and u1.online or u1.offline;
    end;

    local Frame2 = Instance.new("Frame");
    Frame2.AnchorPoint = Vector2.new(0, 0.5);
    Frame2.Position = UDim2.new(0, 64, 0, 17);
    Frame2.Size = UDim2.fromOffset(7, 7);
    Frame2.BackgroundColor3 = v11;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = TextButton;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(76, 6);
    TextLabel.Size = UDim2.new(1, -160, 0, 22);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 17;
    TextLabel.TextColor3 = Color3_fromRGB_ret3;
    TextLabel.Text = v10;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = TextButton;
    local v12;

    if u7.type == "npc" then
        v12 = u7.role;
    else
        v12 = u7.addedVia == "squad" and "Squad" or "Friend";
    end;

    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(76, 26);
    TextLabel2.Size = UDim2.new(1, -160, 0, 18);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 13;
    TextLabel2.TextColor3 = Color3_fromRGB_ret4;
    TextLabel2.Text = v12;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Parent = TextButton;
    local v13;

    if u7.type == "npc" then
        v13 = u7.zone .. " (" .. u7.placeName .. ")";
    else
        v13 = Players:GetPlayerByUserId(u7.userId) and "Online" or "Offline";
    end;

    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Position = UDim2.fromOffset(76, 42);
    TextLabel3.Size = UDim2.new(1, -160, 0, 18);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font_new_ret3;
    TextLabel3.TextSize = 13;
    TextLabel3.TextColor3 = Color3_fromRGB_ret5;
    TextLabel3.Text = v13;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Parent = TextButton;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.AnchorPoint = Vector2.new(1, 0);
    TextLabel4.Position = UDim2.new(1, -12, 0, 8);
    TextLabel4.Size = UDim2.fromOffset(80, 20);
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = Font_new_ret2;
    TextLabel4.TextSize = 13;
    TextLabel4.TextColor3 = v11;
    TextLabel4.Text = u7.type == "npc" and "AVAILABLE" or (v11 == u1.online and "ONLINE" or "OFFLINE");
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel4.Parent = TextButton;

    if u9 then
        TextButton.MouseButton1Click:Connect(function() -- Line: 165
            -- upvalues: u9 (copy), u7 (copy)
            u9(u7);
        end);
    end;
end;

local function buildSidebar(p14, u15) -- Line: 171
    -- upvalues: Font_new_ret (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret8 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret5 (copy), buildContactEntry (copy)
    local ContactController = require(game:GetService("ReplicatedStorage"):WaitForChild("ContactController"));
    local Frame = Instance.new("Frame");
    Frame.Name = "Sidebar";
    Frame.Size = UDim2.new(0.28, 0, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p14;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(4, 0);
    TextLabel.Size = UDim2.new(1, -8, 0, 32);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 22;
    TextLabel.TextColor3 = Color3_fromRGB_ret3;
    TextLabel.Text = "CONTACTS";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Position = UDim2.fromOffset(0, 36);
    Frame2.Size = UDim2.new(1, 0, 0, 30);
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.Padding = UDim.new(0, 4);
    UIListLayout.Parent = Frame2;
    local u16 = "player";
    local u17 = {};
    local u18 = nil;

    local function makeTab(p19, p20, u21) -- Line: 206
        -- upvalues: Color3_fromRGB_ret8 (ref), Frame2 (copy), Font_new_ret2 (ref), Color3_fromRGB_ret4 (ref), u17 (copy), u16 (ref), u18 (ref), Color3_fromRGB_ret3 (ref)
        local TextButton = Instance.new("TextButton");
        TextButton.Size = UDim2.new(0.5, -2, 1, 0);
        TextButton.BackgroundColor3 = Color3_fromRGB_ret8;
        TextButton.BackgroundTransparency = 0.5;
        TextButton.BorderSizePixel = 0;
        TextButton.AutoButtonColor = true;
        TextButton.Text = "";
        TextButton.LayoutOrder = p20;
        TextButton.Parent = Frame2;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(80, 80, 80);
        UIStroke.Thickness = 1;
        UIStroke.Parent = TextButton;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Size = UDim2.fromScale(1, 1);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = Font_new_ret2;
        TextLabel2.TextSize = 13;
        TextLabel2.TextColor3 = Color3_fromRGB_ret4;
        TextLabel2.Text = p19;
        TextLabel2.Parent = TextButton;
        u17[u21] = {
            frame = TextButton,
            label = TextLabel2,
            stroke = UIStroke
        };
        TextButton.MouseButton1Click:Connect(function() -- Line: 233
            -- upvalues: u16 (ref), u21 (copy), u18 (ref), u17 (ref), Color3_fromRGB_ret3 (ref), Color3_fromRGB_ret4 (ref)
            u16 = u21;

            if u18 then
                u18();
            end;

            for i, v in pairs(u17) do
                local v22 = i == u16;
                v.frame.BackgroundTransparency = v22 and 0.2 or 0.5;
                v.label.TextColor3 = v22 and Color3_fromRGB_ret3 or Color3_fromRGB_ret4;
            end;
        end);
    end;

    makeTab("STALKERS", 1, "player");
    makeTab("TRADERS", 2, "npc");
    local TextButton = Instance.new("TextButton");
    TextButton.AnchorPoint = Vector2.new(0, 1);
    TextButton.Position = UDim2.new(0, 0, 1, 0);
    TextButton.Size = UDim2.new(1, 0, 0, 36);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret8;
    TextButton.BackgroundTransparency = 0.5;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = true;
    TextButton.Text = "";
    TextButton.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret7;
    UIStroke.Thickness = 1;
    UIStroke.Parent = TextButton;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.fromScale(1, 1);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret2;
    TextLabel2.TextSize = 14;
    TextLabel2.TextColor3 = Color3_fromRGB_ret4;
    TextLabel2.Text = "+  ADD CONTACT";
    TextLabel2.Parent = TextButton;
    TextButton.MouseButton1Click:Connect(function() -- Line: 272
        -- upvalues: ContactController (copy)
        ContactController:PromptInviteFriends();
    end);

    local function refreshAddBtn() -- Line: 276
        -- upvalues: ContactController (copy), TextLabel2 (copy), Color3_fromRGB_ret3 (ref), UIStroke (copy), Color3_fromRGB_ret5 (ref)
        if ContactController:CanInviteFriends() then
            TextLabel2.TextColor3 = Color3_fromRGB_ret3;
            UIStroke.Transparency = 0;

            return;
        end;

        TextLabel2.TextColor3 = Color3_fromRGB_ret5;
        UIStroke.Transparency = 0.4;
    end;

    if ContactController:CanInviteFriends() then
        TextLabel2.TextColor3 = Color3_fromRGB_ret3;
        UIStroke.Transparency = 0;
    else
        TextLabel2.TextColor3 = Color3_fromRGB_ret5;
        UIStroke.Transparency = 0.4;
    end;

    task.spawn(function() -- Line: 286
        -- upvalues: Frame (copy), ContactController (copy), TextLabel2 (copy), Color3_fromRGB_ret3 (ref), UIStroke (copy), Color3_fromRGB_ret5 (ref)
        while Frame.Parent do
            task.wait(60);

            if ContactController:CanInviteFriends() then
                TextLabel2.TextColor3 = Color3_fromRGB_ret3;
                UIStroke.Transparency = 0;
            else
                TextLabel2.TextColor3 = Color3_fromRGB_ret5;
                UIStroke.Transparency = 0.4;
            end;
        end;
    end);
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "ContactList";
    ScrollingFrame.Position = UDim2.fromOffset(0, 72);
    ScrollingFrame.Size = UDim2.new(1, 0, 1, -114);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.Parent = Frame;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.Padding = UDim.new(0, 4);
    UIListLayout2.Parent = ScrollingFrame;

    u18 = function() -- Line: 310
        -- upvalues: ScrollingFrame (copy), ContactController (copy), u16 (ref), buildContactEntry (ref), u15 (copy)
        for _, child in ipairs(ScrollingFrame:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        local Contacts = ContactController:GetContacts(u16);

        for i, v in ipairs(Contacts) do
            buildContactEntry(ScrollingFrame, v, i, u15);
        end;
    end;

    u17.player.frame.BackgroundTransparency = 0.2;
    u17.player.label.TextColor3 = Color3_fromRGB_ret3;
    u18();
    ContactController:OnChanged(function() -- Line: 323
        -- upvalues: u18 (ref)
        u18();
    end);

    return Frame;
end;

local function makeActionButton(p23, p24, p25, p26) -- Line: 328
    -- upvalues: Color3_fromRGB_ret8 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.Size = UDim2.new(1, 0, 0, 38);
    TextButton.BackgroundColor3 = p26 and Color3.fromRGB(60, 30, 28) or Color3_fromRGB_ret8;
    TextButton.BackgroundTransparency = 0.2;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = true;
    TextButton.Text = "";
    TextButton.LayoutOrder = p25;
    TextButton.Parent = p23;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p26 and Color3.fromRGB(160, 60, 50) or Color3.fromRGB(80, 80, 80);
    UIStroke.Thickness = 1;
    UIStroke.Parent = TextButton;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 14;
    TextLabel.TextColor3 = p26 and Color3_fromRGB_ret2 or Color3_fromRGB_ret3;
    TextLabel.Text = p24;
    TextLabel.Parent = TextButton;

    return TextButton;
end;

local function buildActions(p27, u28, u29, u30) -- Line: 356
    -- upvalues: makeActionButton (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Actions";
    Frame.AnchorPoint = Vector2.new(1, 0);
    Frame.Position = UDim2.new(1, 0, 0, 0);
    Frame.Size = UDim2.fromOffset(170, 180);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p27;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 8);
    UIListLayout.Parent = Frame;
    local v31 = makeActionButton(Frame, "SEND MESSAGE", 1, false);
    makeActionButton(Frame, "MARK ON MAP", 2, false);
    local u32 = makeActionButton(Frame, "INVITE TO SQUAD", 3, false);
    local u33 = makeActionButton(Frame, "KICK FROM SQUAD", 4, true);
    local u34 = makeActionButton(Frame, "LEAVE SQUAD", 5, true);
    local SquadController = require(game:GetService("ReplicatedStorage"):WaitForChild("SquadController"));
    local LocalPlayer = game:GetService("Players").LocalPlayer;

    local function refresh() -- Line: 380
        -- upvalues: SquadController (copy), u28 (copy), LocalPlayer (copy), u29 (copy), u30 (copy), u32 (copy), u33 (copy), u34 (copy)
        local Squad = SquadController:GetSquad();
        local v35 = SquadController:IsLeader();
        local v36 = u28 == LocalPlayer.DisplayName;
        local v37;

        if Squad and u29 then
            v37 = Squad.members[u29] ~= nil and true or Squad.members[tostring(u29)] ~= nil;
        else
            v37 = false;
        end;

        if u30 then
            u32.Visible = false;
            u33.Visible = false;
            u34.Visible = false;

            return;
        end;

        u32.Visible = not v36 and (not v37 and (not Squad or v35));

        if v37 then
            local v38 = not v36;

            if not v38 then
                v35 = v38;
            end;
        else
            v35 = v37;
        end;

        u33.Visible = v35;

        if v36 then
            v36 = Squad ~= nil;
        end;

        u34.Visible = v36;
    end;

    refresh();
    SquadController:OnChanged(refresh);
    u32.MouseButton1Click:Connect(function() -- Line: 406
        -- upvalues: u29 (copy), SquadController (copy)
        if not u29 then
            return;
        end;

        local v39 = SquadController:Invite(u29);

        if not (v39 and v39.ok) then
            if v39 then
                v39 = v39.error;
            end;

            warn("[PdaContactsPage] Invite failed: " .. tostring(v39));
        end;
    end);
    u33.MouseButton1Click:Connect(function() -- Line: 413
        -- upvalues: u29 (copy), SquadController (copy)
        if not u29 then
            return;
        end;

        SquadController:Kick(u29);
    end);
    u34.MouseButton1Click:Connect(function() -- Line: 417
        -- upvalues: SquadController (copy)
        SquadController:Leave();
    end);
    local v40 = not u30;

    if v40 then
        if u29 == nil then
            v40 = false;
        else
            v40 = u29 ~= LocalPlayer.UserId;
        end;
    end;

    v31.Visible = v40;
    v31.MouseButton1Click:Connect(function() -- Line: 424
        -- upvalues: u29 (copy), u30 (copy)
        if not u29 or u30 then
            return;
        end;

        require(game:GetService("ReplicatedStorage"):WaitForChild("RadioClient")):FocusDM(u29);
    end);
end;

local function buildSquadTile(p41, p42, p43, p44) -- Line: 431
    -- upvalues: Color3_fromRGB_ret9 (copy), Font_new_ret (copy), Color3_fromRGB_ret5 (copy), Font_new_ret2 (copy), makeAvatar (copy), u1 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret4 (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromOffset(108, 64);
    Frame.BackgroundColor3 = Color3_fromRGB_ret9;
    Frame.BackgroundTransparency = p44 and 1 or 0.4;
    Frame.BorderSizePixel = 0;
    Frame.LayoutOrder = p43;
    Frame.Parent = p41;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(70, 70, 70);
    UIStroke.Thickness = 1;

    if p44 then
        UIStroke.Transparency = 0.4;
    end;

    UIStroke.Parent = Frame;

    if p44 then
        local TextLabel = Instance.new("TextLabel");
        TextLabel.AnchorPoint = Vector2.new(0, 0.5);
        TextLabel.Position = UDim2.new(0, 8, 0.5, 0);
        TextLabel.Size = UDim2.fromOffset(40, 40);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font_new_ret;
        TextLabel.TextSize = 28;
        TextLabel.TextColor3 = Color3_fromRGB_ret5;
        TextLabel.Text = "+";
        TextLabel.Parent = Frame;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Position = UDim2.fromOffset(50, 0);
        TextLabel2.Size = UDim2.new(1, -55, 1, 0);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = Font_new_ret2;
        TextLabel2.TextSize = 14;
        TextLabel2.TextColor3 = Color3_fromRGB_ret5;
        TextLabel2.Text = "Open Slot";
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Parent = Frame;

        return;
    end;

    local Frame2 = Instance.new("Frame");
    Frame2.Position = UDim2.fromOffset(6, 8);
    Frame2.Size = UDim2.fromOffset(48, 48);
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;
    makeAvatar(Frame2, 48, p42.name);
    local Frame3 = Instance.new("Frame");
    Frame3.Position = UDim2.fromOffset(60, 10);
    Frame3.Size = UDim2.fromOffset(7, 7);
    Frame3.BackgroundColor3 = u1.online;
    Frame3.BorderSizePixel = 0;
    Frame3.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame3;
    local v45 = p42.role == "Leader";
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(68, 6);
    TextLabel.Size = UDim2.fromOffset(40, 20);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret2;
    TextLabel.TextSize = 14;
    TextLabel.TextColor3 = v45 and Color3_fromRGB_ret or Color3_fromRGB_ret3;
    TextLabel.Text = p42.name;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(60, 28);
    TextLabel2.Size = UDim2.fromOffset(48, 18);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 12;
    TextLabel2.TextColor3 = v45 and Color3_fromRGB_ret or Color3_fromRGB_ret4;
    TextLabel2.Text = p42.role;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Parent = Frame;

    if v45 then
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.AnchorPoint = Vector2.new(1, 0);
        TextLabel3.Position = UDim2.new(1, -4, 0, 2);
        TextLabel3.Size = UDim2.fromOffset(18, 18);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = Font_new_ret;
        TextLabel3.TextSize = 16;
        TextLabel3.TextColor3 = Color3_fromRGB_ret;
        TextLabel3.Text = "♛";
        TextLabel3.Parent = Frame;
    end;
end;

local function buildDetail(p46) -- Line: 528
    -- upvalues: PdaMapData (copy), buildActions (copy), makeAvatar (copy), Font_new_ret (copy), Color3_fromRGB_ret3 (copy), Font_new_ret3 (copy), Color3_fromRGB_ret4 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret5 (copy), u1 (copy), Color3_fromRGB_ret7 (copy), buildSquadTile (copy)
    local Players = game:GetService("Players");
    local LocalPlayer = Players.LocalPlayer;
    local SquadController = require(game:GetService("ReplicatedStorage"):WaitForChild("SquadController"));
    local Frame = Instance.new("Frame");
    Frame.Name = "Detail";
    Frame.Position = UDim2.new(0.28, 16, 0, 0);
    Frame.Size = UDim2.new(0.72, -16, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p46;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.fromScale(1, 1);
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;

    local function clearBody() -- Line: 545
        -- upvalues: Frame2 (copy)
        for _, child in ipairs(Frame2:GetChildren()) do
            child:Destroy();
        end;
    end;

    local u47 = {};

    local function usernameFor(u48, p49, u50) -- Line: 556
        -- upvalues: Players (copy), u47 (copy)
        local PlayerByUserId = Players:GetPlayerByUserId(u48);

        if PlayerByUserId then
            return PlayerByUserId.Name;
        end;

        if p49 then
            return p49;
        end;

        if u47[u48] ~= nil then
            return u47[u48] or nil;
        end;

        u47[u48] = false;
        task.spawn(function() -- Line: 562
            -- upvalues: Players (ref), u48 (copy), u47 (ref), u50 (copy)
            local success, result = pcall(Players.GetNameFromUserIdAsync, Players, u48);

            if success and result then
                u47[u48] = result;
                u50(result);
            end;
        end);

        return nil;
    end;

    local function renderContact(p51) -- Line: 572
        -- upvalues: Frame2 (copy), LocalPlayer (copy), PdaMapData (ref), Players (copy), usernameFor (copy), buildActions (ref), makeAvatar (ref), Font_new_ret (ref), Color3_fromRGB_ret3 (ref), Font_new_ret3 (ref), Color3_fromRGB_ret4 (ref), Font_new_ret2 (ref), Color3_fromRGB_ret5 (ref), u1 (ref), Color3_fromRGB_ret7 (ref), SquadController (copy), buildSquadTile (ref)
        for _, child in ipairs(Frame2:GetChildren()) do
            child:Destroy();
        end;

        local v52;

        if p51 then
            v52 = p51.type == "npc";
        else
            v52 = p51;
        end;

        local v53 = not p51;
        local v54 = nil;
        local v55, v56, v57, u58, v59, v60, v61;

        if v53 then
            v55 = LocalPlayer.DisplayName;
            v54 = LocalPlayer.Name;
            v56 = LocalPlayer:GetAttribute("Zone") or PdaMapData.CurrentZone();
            v57 = LocalPlayer.UserId;
            u58 = "";
            v59 = "Online";
            v60 = "-";
            v61 = "-";
        elseif v52 then
            v55 = p51.name;
            u58 = p51.role;
            v60 = p51.faction;
            v56 = p51.zone;
            v57 = nil;
            v59 = "Available";
            v61 = "-";
        else
            v55 = p51.displayName;
            u58 = p51.addedVia == "squad" and "Squadmate" or "Friend";
            local PlayerByUserId = Players:GetPlayerByUserId(p51.userId);
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            local RadioClient = require(ReplicatedStorage:WaitForChild("RadioClient"));
            local RadioConfig = require(ReplicatedStorage:WaitForChild("RadioConfig"));
            RadioClient:Init();
            local v62 = RadioClient:ContactsOnline()[tostring(p51.userId)];
            v56 = v62 == "here" and "Your server" or (v62 and (RadioConfig.MAP_NAMES[v62] or (v62 or "Unknown")) or "Unknown");
            v57 = p51.userId;
            v59 = (v62 or PlayerByUserId) and "Online" or "Offline";
            v60 = "-";
            v61 = "-";
        end;

        local u63 = nil;

        local function roleText(p64) -- Line: 615
            -- upvalues: u58 (ref)
            if p64 then
                return u58 ~= "" and "@" .. p64 .. "  •  " .. u58 or "@" .. p64;
            end;

            return u58;
        end;

        if not (v53 or v52) then
            v54 = usernameFor(p51.userId, p51.username, function(p65) -- Line: 620
                -- upvalues: u63 (ref), u58 (ref)
                if u63 and u63.Parent then
                    local v66;

                    if p65 then
                        v66 = u58 ~= "" and "@" .. p65 .. "  •  " .. u58 or "@" .. p65;
                    else
                        v66 = u58;
                    end;

                    u63.Text = v66;
                end;
            end);
        end;

        buildActions(Frame2, v55, v57, v52);
        local Frame3 = Instance.new("Frame");
        Frame3.Name = "Header";
        Frame3.Size = UDim2.new(1, -190, 0, 140);
        Frame3.BackgroundTransparency = 1;
        Frame3.Parent = Frame2;
        local Frame4 = Instance.new("Frame");
        Frame4.Position = UDim2.fromOffset(0, 8);
        Frame4.Size = UDim2.fromOffset(110, 110);
        Frame4.BackgroundTransparency = 1;
        Frame4.Parent = Frame3;
        makeAvatar(Frame4, 110, v55);
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Position = UDim2.fromOffset(124, 8);
        TextLabel.Size = UDim2.new(1, -124, 0, 32);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font_new_ret;
        TextLabel.TextSize = 26;
        TextLabel.TextColor3 = Color3_fromRGB_ret3;
        TextLabel.Text = v55;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Parent = Frame3;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Position = UDim2.fromOffset(124, 38);
        TextLabel2.Size = UDim2.new(1, -124, 0, 22);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = Font_new_ret3;
        TextLabel2.TextSize = 16;
        TextLabel2.TextColor3 = Color3_fromRGB_ret4;
        local v67;

        if v54 then
            v67 = u58 ~= "" and "@" .. v54 .. "  •  " .. u58 or "@" .. v54;
        else
            v67 = u58;
        end;

        TextLabel2.Text = v67;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Parent = Frame3;
        local v68 = {
            { "FACTION", v60 },
            { "LOCATION", v56 },
            { "STATUS", v59 }
        };

        if not v52 then
            table.insert(v68, { "DISTANCE", v61 });
        end;

        for i, v in ipairs(v68) do
            local v69 = 70 + (i - 1) * 18;
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Position = UDim2.fromOffset(124, v69);
            TextLabel3.Size = UDim2.fromOffset(96, 18);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.FontFace = Font_new_ret2;
            TextLabel3.TextSize = 13;
            TextLabel3.TextColor3 = Color3_fromRGB_ret5;
            TextLabel3.Text = v[1];
            TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel3.Parent = Frame3;
            local TextLabel4 = Instance.new("TextLabel");
            TextLabel4.Position = UDim2.fromOffset(220, v69);
            TextLabel4.Size = UDim2.new(1, -220, 0, 18);
            TextLabel4.BackgroundTransparency = 1;
            TextLabel4.FontFace = Font_new_ret2;
            TextLabel4.TextSize = 14;
            TextLabel4.TextColor3 = v[1] == "STATUS" and (v[2] == "Offline" and u1.offline or u1.online) or Color3_fromRGB_ret3;
            TextLabel4.Text = v[2];
            TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel4.Parent = Frame3;
        end;

        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.Position = UDim2.fromOffset(0, 148);
        TextLabel3.Size = UDim2.fromOffset(120, 18);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = Font_new_ret2;
        TextLabel3.TextSize = 13;
        TextLabel3.TextColor3 = Color3_fromRGB_ret5;
        TextLabel3.Text = "NOTES";
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.Parent = Frame2;
        local TextLabel4 = Instance.new("TextLabel");
        TextLabel4.Position = UDim2.fromOffset(0, 168);
        TextLabel4.Size = UDim2.new(1, 0, 0, 24);
        TextLabel4.BackgroundTransparency = 1;
        TextLabel4.FontFace = Font_new_ret3;
        TextLabel4.TextSize = 14;
        TextLabel4.TextColor3 = Color3_fromRGB_ret3;

        if v52 then
            local v70 = p51.interactionCount or 1;
            TextLabel4.Text = "Met " .. v70 .. " time" .. (v70 > 1 and "s" or "");
        else
            TextLabel4.Text = "";
        end;

        TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel4.Parent = Frame2;
        local Frame5 = Instance.new("Frame");
        Frame5.Position = UDim2.fromOffset(0, 198);
        Frame5.Size = UDim2.new(1, 0, 0, 1);
        Frame5.BackgroundColor3 = Color3_fromRGB_ret7;
        Frame5.BorderSizePixel = 0;
        Frame5.Parent = Frame2;
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.Position = UDim2.fromOffset(0, 210);
        TextLabel5.Size = UDim2.fromOffset(120, 18);
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.FontFace = Font_new_ret2;
        TextLabel5.TextSize = 13;
        TextLabel5.TextColor3 = Color3_fromRGB_ret5;
        TextLabel5.Text = "SQUAD";
        TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel5.Parent = Frame2;
        local Frame6 = Instance.new("Frame");
        Frame6.Position = UDim2.fromOffset(0, 230);
        Frame6.Size = UDim2.new(1, 0, 0, 66);
        Frame6.BackgroundTransparency = 1;
        Frame6.Parent = Frame2;
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout.Padding = UDim.new(0, 6);
        UIListLayout.Parent = Frame6;

        local function renderSquadTiles() -- Line: 758
            -- upvalues: Frame6 (copy), SquadController (ref), buildSquadTile (ref)
            for _, child in ipairs(Frame6:GetChildren()) do
                if child:IsA("Frame") then
                    child:Destroy();
                end;
            end;

            local Squad = SquadController:GetSquad();
            local v71 = {};

            if Squad then
                local u72 = tostring(Squad.leader_id);
                local v73 = {};

                for i, v in pairs(Squad.members) do
                    local v74 = {
                        uid = i,
                        key = tostring(i),
                        mem = v
                    };
                    table.insert(v73, v74);
                end;

                table.sort(v73, function(p75, p76) -- Line: 773
                    -- upvalues: u72 (copy)
                    if p75.key == u72 then
                        return true;
                    end;

                    if p76.key == u72 then
                        return false;
                    end;

                    return (p75.mem.joined_at or 0) < (p76.mem.joined_at or 0);
                end);

                for _, v in ipairs(v73) do
                    table.insert(v71, {
                        name = v.mem.display_name,
                        role = v.key == u72 and "Leader" or "Member"
                    });
                end;
            end;

            for i = 1, 4 do
                local v77 = v71[i];
                local v78;

                if v77 then
                    buildSquadTile(Frame6, v77, i, false);
                    v78 = i;
                else
                    buildSquadTile(Frame6, nil, i, true);
                    v78 = i;
                end;
            end;
        end;

        renderSquadTiles();
        SquadController:OnChanged(function() -- Line: 795
            -- upvalues: renderSquadTiles (copy)
            renderSquadTiles();
        end);
    end;

    renderContact(nil);

    return {
        frame = Frame,
        SelectContact = renderContact
    };
end;

return {
    Build = function(p79) -- Line: 810, Name: Build
        -- upvalues: buildDetail (copy), buildSidebar (copy)
        local Frame = Instance.new("Frame");
        Frame.Name = "Body";
        Frame.Position = UDim2.fromOffset(16, 8);
        Frame.Size = UDim2.new(1, -32, 1, -16);
        Frame.BackgroundTransparency = 1;
        Frame.Parent = p79;
        local u80 = buildDetail(Frame);
        buildSidebar(Frame, function(p81) -- Line: 819
            -- upvalues: u80 (copy)
            u80.SelectContact(p81);
        end);
    end
};