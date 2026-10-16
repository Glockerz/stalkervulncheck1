-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local v1 = {};
local u2 = { "Bandit", "Loner", "Military", "ClearSky", "Monolith" };
local u3 = {
    Bandit = Color3.fromRGB(200, 120, 60),
    Loner = Color3.fromRGB(200, 190, 120),
    Military = Color3.fromRGB(110, 150, 90),
    ClearSky = Color3.fromRGB(90, 150, 210),
    Monolith = Color3.fromRGB(190, 190, 200)
};
local u4 = { "any", "Rookie", "Experienced", "Professional", "Veteran", "Expert" };
local u5 = { "BlindDog", "Boar", "Flesh" };
local u6 = { 50, 150, 500, 2000 };

function v1.Build(p7) -- Line: 32
    -- upvalues: Players (copy), u2 (copy), u4 (copy), u5 (copy), u6 (copy), RunService (copy), u3 (copy)
    local colours = p7.colours;
    local run = p7.run;
    local player = p7.player;
    local Remotes = p7.Remotes;
    local Frame = Instance.new("Frame");
    Frame.Name = "TestingPane";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.Parent = p7.content;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Size = UDim2.fromScale(1, 1);
    ScrollingFrame.BackgroundColor3 = colours.BG_DEEP;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ScrollBarThickness = 6;
    ScrollingFrame.ScrollBarImageColor3 = colours.STROKE;
    ScrollingFrame.CanvasSize = UDim2.new();
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.Parent = Frame;
    Instance.new("UICorner", ScrollingFrame).CornerRadius = UDim.new(0, 4);
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Padding = UDim.new(0, 4);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = ScrollingFrame;
    local UIPadding = Instance.new("UIPadding");
    local UDim_new_ret = UDim.new(0, 6);
    local UDim_new_ret2 = UDim.new(0, 6);
    UIPadding.PaddingTop = UDim_new_ret;
    UIPadding.PaddingBottom = UDim_new_ret2;
    local UDim_new_ret3 = UDim.new(0, 6);
    local UDim_new_ret4 = UDim.new(0, 6);
    UIPadding.PaddingLeft = UDim_new_ret3;
    UIPadding.PaddingRight = UDim_new_ret4;
    UIPadding.Parent = ScrollingFrame;
    local u8 = 0;

    local function nextOrder() -- Line: 63
        -- upvalues: u8 (ref)
        u8 = u8 + 1;

        return u8;
    end;

    local function header(p9) -- Line: 65
        -- upvalues: u8 (ref), ScrollingFrame (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.new(1, 0, 0, 20);
        u8 = u8 + 1;
        TextLabel.LayoutOrder = u8;
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = p9;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Font = Enum.Font.GothamBold;
        TextLabel.TextSize = 11;
        TextLabel.TextColor3 = Color3.fromRGB(180, 175, 130);
        TextLabel.Parent = ScrollingFrame;
    end;

    local function note(p10) -- Line: 77
        -- upvalues: u8 (ref), colours (copy), ScrollingFrame (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.new(1, 0, 0, 14);
        u8 = u8 + 1;
        TextLabel.LayoutOrder = u8;
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = p10;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Font = Enum.Font.Gotham;
        TextLabel.TextSize = 10;
        TextLabel.TextColor3 = colours.TEXT_DIM;
        TextLabel.Parent = ScrollingFrame;

        return TextLabel;
    end;

    local function row(p11, p12) -- Line: 91
        -- upvalues: u8 (ref), ScrollingFrame (copy), colours (copy)
        local Frame2 = Instance.new("Frame");
        Frame2.Size = UDim2.new(1, 0, 0, p12 or 28);
        u8 = u8 + 1;
        Frame2.LayoutOrder = u8;
        Frame2.BackgroundTransparency = 1;
        Frame2.Parent = ScrollingFrame;
        local v13 = #p11;
        local v14 = {};

        for i, v in ipairs(p11) do
            local TextButton = Instance.new("TextButton");
            TextButton.Name = (v[1] == "" and "Toggle" or (v[1] or "Toggle")):gsub("[^%w]", "");
            TextButton.Size = UDim2.new(1 / v13, (v13 - 1) * -4 / v13, 1, 0);
            TextButton.Position = UDim2.new((i - 1) / v13, (i - 1) * 4 / v13, 0, 0);
            TextButton.BackgroundColor3 = v[3] or colours.BG_ROW;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = v[1];
            TextButton.Font = Enum.Font.GothamBold;
            TextButton.TextSize = 10;
            TextButton.TextColor3 = colours.TEXT;
            TextButton.TextWrapped = true;
            TextButton.Parent = Frame2;
            Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 3);

            if v[2] then
                TextButton.MouseButton1Click:Connect(function() -- Line: 114
                    -- upvalues: v (copy), TextButton (copy)
                    v[2](TextButton);
                end);
            end;

            v14[i] = TextButton;
        end;

        return v14;
    end;

    local function picker(u15, p16, p17) -- Line: 120
        -- upvalues: colours (copy), row (copy)
        local u18 = p16 or u15[1];
        local u19 = nil;

        local function paint() -- Line: 123
            -- upvalues: u19 (ref), u15 (copy), u18 (ref), colours (ref)
            for i, v in ipairs(u19) do
                local v20 = u15[i] == u18;
                v.BackgroundColor3 = v20 and colours.TAB_ACTIVE or colours.BG_ROW;
                v.TextColor3 = v20 and colours.TAB_TEXT_A or colours.TEXT_DIM;
            end;
        end;

        local v21 = {};

        for _, v in ipairs(u15) do
            local v22 = { p17 and p17(v) or tostring(v), function() -- Line: 132
                    -- upvalues: u18 (ref), v (copy), paint (copy)
                    u18 = v;
                    paint();
                end };
            table.insert(v21, v22);
        end;

        u19 = row(v21, 24);
        paint();

        return function() -- Line: 136
            -- upvalues: u18 (ref)
            return u18;
        end;
    end;

    local function stepper(u23, u24, u25, p26) -- Line: 139
        -- upvalues: u8 (ref), ScrollingFrame (copy), colours (copy)
        local u27 = p26;
        local Frame2 = Instance.new("Frame");
        Frame2.Size = UDim2.new(1, 0, 0, 24);
        u8 = u8 + 1;
        Frame2.LayoutOrder = u8;
        Frame2.BackgroundTransparency = 1;
        Frame2.Parent = ScrollingFrame;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.new(0.5, 0, 1, 0);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Font = Enum.Font.Gotham;
        TextLabel.TextSize = 11;
        TextLabel.TextColor3 = colours.TEXT;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Parent = Frame2;

        local function _() -- Line: 154
            -- upvalues: TextLabel (copy), u23 (copy), u27 (ref)
            TextLabel.Text = ("%s: %d"):format(u23, u27);
        end;

        for i, v in ipairs({ -1, 1 }) do
            local TextButton = Instance.new("TextButton");
            TextButton.Size = UDim2.new(0.25, -4, 1, 0);
            TextButton.Position = UDim2.new(0.5 + (i - 1) * 0.25, 2, 0, 0);
            TextButton.BackgroundColor3 = colours.BG_INPUT;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = v < 0 and "-" or "+";
            TextButton.Font = Enum.Font.GothamBold;
            TextButton.TextSize = 14;
            TextButton.TextColor3 = colours.TEXT;
            TextButton.Parent = Frame2;
            Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 3);
            TextButton.MouseButton1Click:Connect(function() -- Line: 167
                -- upvalues: u27 (ref), v (copy), u24 (copy), u25 (copy), TextLabel (copy), u23 (copy)
                u27 = math.clamp(u27 + v, u24, u25);
                TextLabel.Text = ("%s: %d"):format(u23, u27);
            end);
        end;

        TextLabel.Text = ("%s: %d"):format(u23, u27);

        return function() -- Line: 170
            -- upvalues: u27 (ref)
            return u27;
        end;
    end;

    local function toggle(u28, p29, u30) -- Line: 173
        -- upvalues: row (copy), colours (copy)
        local u31 = p29;
        local u32 = row({ { "", nil } })[1];

        local function _() -- Line: 176
            -- upvalues: u32 (copy), u28 (copy), u31 (ref), colours (ref)
            u32.Text = ("%s: %s"):format(u28, u31 and "ON" or "OFF");
            u32.BackgroundColor3 = u31 and colours.ACCENT_G or colours.BG_ROW;
        end;

        u32.MouseButton1Click:Connect(function() -- Line: 180
            -- upvalues: u31 (ref), u32 (copy), u28 (copy), colours (ref), u30 (copy)
            u31 = not u31;
            u32.Text = ("%s: %s"):format(u28, u31 and "ON" or "OFF");
            u32.BackgroundColor3 = u31 and colours.ACCENT_G or colours.BG_ROW;
            u30(u31);
        end);
        u32.Text = ("%s: %s"):format(u28, u31 and "ON" or "OFF");
        u32.BackgroundColor3 = u31 and colours.ACCENT_G or colours.BG_ROW;

        return u32, function(p33) -- Line: 182
            -- upvalues: u31 (ref), u32 (copy), u28 (copy), colours (ref)
            u31 = p33;
            u32.Text = ("%s: %s"):format(u28, u31 and "ON" or "OFF");
            u32.BackgroundColor3 = u31 and colours.ACCENT_G or colours.BG_ROW;
        end;
    end;

    local function crosshair() -- Line: 186
        -- upvalues: player (copy)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local ViewportSize = workspace_CurrentCamera.ViewportSize;
        local v34 = workspace_CurrentCamera:ViewportPointToRay(ViewportSize.X / 2, ViewportSize.Y / 2);
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { player.Character };
        local v35 = workspace:Raycast(v34.Origin, v34.Direction * 400, RaycastParams_new_ret);

        if not v35 then
            return "";
        end;

        local Position = v35.Position;

        return ("%.1f,%.1f,%.1f"):format(Position.X, Position.Y, Position.Z);
    end;

    header("YOU");
    toggle("IGNORE (NPCs + mutants leave you alone)", player:GetAttribute("AdminIgnore") == true, function(p36) -- Line: 201
        -- upvalues: run (copy)
        run("ignore", p36 and "on" or "off");
    end);
    row({
        { "GOD (toggle)", function() -- Line: 205
                -- upvalues: run (copy)
                run("god");
            end },
        { "HEAL", function() -- Line: 206
                -- upvalues: run (copy)
                run("heal");
            end },
        { "WHERE AM I", function() -- Line: 207
                -- upvalues: run (copy)
                run("where");
            end }
    });
    header("TRACKING");
    local u37 = false;
    local u38 = false;
    local u39 = false;
    toggle("ESP: players through walls", false, function(p40) -- Line: 213
        -- upvalues: u37 (ref)
        u37 = p40;
    end);
    toggle("ESP: NPC + mutant labels", false, function(p41) -- Line: 214
        -- upvalues: u38 (ref)
        u38 = p41;
    end);
    toggle("INSPECT: details of the NPC under the crosshair", false, function(p42) -- Line: 215
        -- upvalues: u39 (ref)
        u39 = p42;
    end);
    local u43 = nil;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.new(1, 0, 0, 0);
    Frame2.AutomaticSize = Enum.AutomaticSize.Y;
    Frame2.BackgroundTransparency = 1;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.Padding = UDim.new(0, 2);
    UIListLayout2.Parent = Frame2;

    local function stopWatching() -- Line: 226
        -- upvalues: u43 (ref), run (copy), player (copy)
        u43 = nil;
        run("spectate", "off");
        local v44 = player.Character and player.Character:FindFirstChildOfClass("Humanoid");

        if v44 then
            workspace.CurrentCamera.CameraSubject = v44;
        end;
    end;

    local function watch(u45) -- Line: 232
        -- upvalues: run (copy), u43 (ref), Players (ref)
        run("spectate", u45);
        u43 = u45;
        task.spawn(function() -- Line: 236
            -- upvalues: u43 (ref), u45 (copy), Players (ref)
            local v46 = os.clock() + 6;

            while u43 == u45 and os.clock() < v46 do
                local v47 = Players:FindFirstChild(u45);
                local v48 = v47 and v47.Character and v47.Character:FindFirstChildOfClass("Humanoid");

                if v48 then
                    workspace.CurrentCamera.CameraSubject = v48;

                    return;
                end;

                task.wait(0.2);
            end;
        end);
    end;

    local function refreshList() -- Line: 247
        -- upvalues: Frame2 (copy), Remotes (copy), colours (copy), player (copy), run (copy), u43 (ref), Players (ref)
        for _, child in ipairs(Frame2:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        local AdminPlayerList = Remotes:FindFirstChild("AdminPlayerList");
        local success, result = pcall(function() -- Line: 250
            -- upvalues: AdminPlayerList (copy)
            local v49 = AdminPlayerList and AdminPlayerList:InvokeServer();

            return v49;
        end);

        if not success or type(result) ~= "table" then
            return;
        end;

        for _, v in ipairs(result) do
            local Frame3 = Instance.new("Frame");
            Frame3.Size = UDim2.new(1, 0, 0, 40);
            Frame3.BackgroundColor3 = colours.BG_ROW;
            Frame3.BorderSizePixel = 0;
            Frame3.Parent = Frame2;
            Instance.new("UICorner", Frame3).CornerRadius = UDim.new(0, 3);
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Size = UDim2.new(1, -8, 0, 18);
            TextLabel.Position = UDim2.new(0, 4, 0, 1);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.Font = Enum.Font.Gotham;
            TextLabel.TextSize = 10;
            TextLabel.TextColor3 = colours.TEXT;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
            TextLabel.Text = ("%s  %d/%d hp  %s%s  %s%s"):format(v.name, v.hp, v.maxHp, v.loc, v.safe and " (safe)" or "", v.dist and (v.dist .. "m" or "") or "", v.ignored and "  IGNORED" or "");
            TextLabel.Parent = Frame3;
            local v50 = v.name == player.Name;
            local Frame4 = Instance.new("Frame");
            Frame4.Size = UDim2.new(1, -8, 0, 18);
            Frame4.Position = UDim2.new(0, 4, 0, 20);
            Frame4.BackgroundTransparency = 1;
            Frame4.Parent = Frame3;

            for i, v2 in ipairs({
                { "TP TO", function() -- Line: 278
                        -- upvalues: run (ref), v (copy)
                        run("tp", v.name);
                    end },
                { "BRING", function() -- Line: 279
                        -- upvalues: run (ref), v (copy)
                        run("bring", v.name);
                    end },
                { "WATCH", function() -- Line: 280
                        -- upvalues: v (copy), run (ref), u43 (ref), Players (ref)
                        local name = v.name;
                        run("spectate", name);
                        u43 = name;
                        task.spawn(function() -- Line: 236
                            -- upvalues: u43 (ref), name (copy), Players (ref)
                            local v51 = os.clock() + 6;

                            while u43 == name and os.clock() < v51 do
                                local v52 = Players:FindFirstChild(name);
                                local v53 = v52 and v52.Character and v52.Character:FindFirstChildOfClass("Humanoid");

                                if v53 then
                                    workspace.CurrentCamera.CameraSubject = v53;

                                    return;
                                end;

                                task.wait(0.2);
                            end;
                        end);
                    end }
            }) do
                local TextButton = Instance.new("TextButton");
                TextButton.Size = UDim2.new(0.3333333333333333, -3, 1, 0);
                TextButton.Position = UDim2.new((i - 1) / 3, 2, 0, 0);
                TextButton.BackgroundColor3 = v50 and colours.BG_DEEP or colours.BG_INPUT;
                TextButton.BorderSizePixel = 0;
                TextButton.Text = v2[1];
                TextButton.Font = Enum.Font.GothamBold;
                TextButton.TextSize = 10;
                TextButton.TextColor3 = v50 and colours.TEXT_DIM or colours.TEXT;
                TextButton.Parent = Frame4;
                Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 3);

                if not v50 then
                    TextButton.MouseButton1Click:Connect(v2[2]);
                end;
            end;
        end;
    end;

    row({
        { "REFRESH PLAYER LIST", function() -- Line: 298
                -- upvalues: refreshList (copy)
                refreshList();
            end },
        { "STOP WATCHING", function() -- Line: 299
                -- upvalues: u43 (ref), run (copy), player (copy)
                u43 = nil;
                run("spectate", "off");
                local v54 = player.Character and player.Character:FindFirstChildOfClass("Humanoid");

                if v54 then
                    workspace.CurrentCamera.CameraSubject = v54;
                end;
            end }
    });
    u8 = u8 + 1;
    Frame2.LayoutOrder = u8;
    Frame2.Parent = ScrollingFrame;
    header("MONEY BOARD  (roubles in hand, this wipe)");
    local u55 = note("Press REFRESH.");
    local Frame3 = Instance.new("Frame");
    Frame3.Size = UDim2.new(1, 0, 0, 0);
    Frame3.AutomaticSize = Enum.AutomaticSize.Y;
    Frame3.BackgroundTransparency = 1;
    local UIListLayout3 = Instance.new("UIListLayout");
    UIListLayout3.Padding = UDim.new(0, 1);
    UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout3.Parent = Frame3;

    local function money(p56) -- Line: 317
        local math_floor_ret = math.floor(p56 or 0);

        return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    end;

    local function ago(p57) -- Line: 322
        if not p57 then
            return "";
        end;

        if p57 < 3600 then
            return ("%dm ago"):format(p57 // 60);
        end;

        if p57 < 86400 then
            return ("%dh ago"):format(p57 // 3600);
        end;

        return ("%dd ago"):format(p57 // 86400);
    end;

    local function moneyRow(p58, p59, p60) -- Line: 328
        -- upvalues: colours (copy), Frame3 (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.new(1, 0, 0, 16);
        TextLabel.LayoutOrder = p58;
        TextLabel.BackgroundColor3 = colours.BG_ROW;
        TextLabel.BackgroundTransparency = 0.3;
        TextLabel.BorderSizePixel = 0;
        TextLabel.Font = Enum.Font.Code;
        TextLabel.TextSize = 11;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.TextColor3 = p60 or colours.TEXT;
        TextLabel.Text = " " .. p59;
        TextLabel.Parent = Frame3;
    end;

    local Color3_fromRGB_ret = Color3.fromRGB(240, 110, 90);

    local function refreshMoney() -- Line: 343
        -- upvalues: Frame3 (copy), u55 (copy), Remotes (copy), moneyRow (copy), Color3_fromRGB_ret (copy), ago (copy)
        for _, child in ipairs(Frame3:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy();
            end;
        end;

        u55.Text = "Reading...";
        local AdminMoneyBoard = Remotes:FindFirstChild("AdminMoneyBoard");
        local success, result = pcall(function() -- Line: 347
            -- upvalues: AdminMoneyBoard (copy)
            local v61 = AdminMoneyBoard and AdminMoneyBoard:InvokeServer();

            return v61;
        end);

        if not (success and (type(result) == "table" and result.ok)) then
            if success and type(result) == "table" then
                result = result.why or result;
            end;

            u55.Text = "Not available: " .. tostring(result);

            return;
        end;

        local wipeId = result.wipeId;
        local v62 = result.studio and " (Studio board, not live)" or "";
        local math_floor_ret = math.floor(result.threshold or 0);
        u55.Text = ("Wipe %d%s. Red = gained %s+ in an hour. * = online here."):format(wipeId, v62, (tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
        local v63 = 0;

        for i, v in ipairs(result.top) do
            v63 = v63 + 1;
            local v64 = tostring(v.name):sub(1, 18);
            local math_floor_ret2 = math.floor(v.balance or 0);
            local v65 = tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
            local v66 = v.online and " *" or "";
            local v67;

            if v.flagged then
                local math_floor_ret3 = math.floor(v.gain or 0);
                v67 = "  +" .. tostring(math_floor_ret3):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. "/h" or "";
            else
                v67 = "";
            end;

            moneyRow(v63, ("%2d. %-18s %13s%s%s"):format(i, v64, v65, v66, v67), v.flagged and Color3_fromRGB_ret or nil);
        end;

        if #result.top == 0 then
            v63 = v63 + 1;
            moneyRow(v63, "nobody yet: balances are written every 2 min of play");
        end;

        local v68 = v63 + 1;
        moneyRow(v68, "BIGGEST GAINS (hour before last save)", Color3.fromRGB(180, 175, 130));

        for _, v in ipairs(result.gainers) do
            v68 = v68 + 1;
            local v69 = tostring(v.name):sub(1, 18);
            local math_floor_ret2 = math.floor(v.gainNow or 0);
            moneyRow(v68, ("    %-18s +%12s  %s"):format(v69, tostring(math_floor_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), ago(v.ago)), v.flagged and Color3_fromRGB_ret or nil);
        end;
    end;

    row({
        { "REFRESH MONEY BOARD", function() -- Line: 369
                -- upvalues: refreshMoney (copy)
                refreshMoney();
            end },
        { "SYNC ONLINE NOW", function() -- Line: 370
                -- upvalues: run (copy), refreshMoney (copy)
                run("moneysync");
                task.delay(2, refreshMoney);
            end }
    });
    u8 = u8 + 1;
    Frame3.LayoutOrder = u8;
    Frame3.Parent = ScrollingFrame;
    header("SPAWN NPCs  (at the middle of your screen)");
    local u70 = picker(u2, "Bandit");
    local u72 = picker(u4, "any", function(p71) -- Line: 378
        return p71 == "Experienced" and "Exper." or (p71 == "Professional" and "Prof." or p71);
    end);
    local u73 = stepper("Squad size", 1, 12, 3);
    local u74 = picker({ "calm", "alert" }, "calm", string.upper);
    row({
        { "SPAWN NPCs", function() -- Line: 381
                -- upvalues: run (copy), u70 (copy), u73 (copy), u72 (copy), u74 (copy), crosshair (copy)
                run("spawnnpc", u70(), tostring(u73()), u72(), u74(), crosshair());
            end, colours.ACCENT_G }
    }, 30);
    header("SPAWN MUTANTS");
    local u75 = picker(u5, "BlindDog");
    local u76 = stepper("Count", 1, 12, 3);
    local u78 = picker({ "calm", "hunt" }, "calm", function(p77) -- Line: 389
        return p77 == "hunt" and "HUNTING (goes for anyone)" or "NORMAL";
    end);
    row({
        { "SPAWN MUTANTS", function() -- Line: 390
                -- upvalues: run (copy), u75 (copy), u76 (copy), u78 (copy), crosshair (copy)
                run("spawnmutant", u75(), tostring(u76()), u78(), crosshair());
            end, colours.ACCENT_G }
    }, 30);
    header("STAGE A FIGHT  (side A alerted, 70 studs apart)");
    note("Side A");
    local u79 = picker(u2, "Bandit");
    note("Side B");
    local u80 = picker(u2, "Loner");
    local u81 = stepper("Each side", 1, 8, 3);
    row({
        { "STAGE FIGHT", function() -- Line: 401
                -- upvalues: run (copy), u79 (copy), u80 (copy), u81 (copy), crosshair (copy)
                run("fight", u79(), u80(), tostring(u81()), crosshair());
            end, colours.ACCENT_G }
    }, 30);
    header("NEARBY AI");
    local u83 = picker(u6, 150, function(p82) -- Line: 407
        return p82 .. " studs";
    end);
    row({
        { "CLEAR NPCs", function() -- Line: 409
                -- upvalues: run (copy), u83 (copy)
                run("clearai", "npcs", (tostring(u83())));
            end },
        { "CLEAR MUTANTS", function() -- Line: 410
                -- upvalues: run (copy), u83 (copy)
                run("clearai", "mutants", (tostring(u83())));
            end },
        { "CLEAR ALL", function() -- Line: 411
                -- upvalues: run (copy), u83 (copy)
                run("clearai", "all", (tostring(u83())));
            end, colours.DANGER }
    });
    row({
        { "KILL NPCs", function() -- Line: 414
                -- upvalues: run (copy), u83 (copy)
                run("killai", "npcs", (tostring(u83())));
            end },
        { "KILL MUTANTS", function() -- Line: 415
                -- upvalues: run (copy), u83 (copy)
                run("killai", "mutants", (tostring(u83())));
            end },
        { "KILL ALL", function() -- Line: 416
                -- upvalues: run (copy), u83 (copy)
                run("killai", "all", (tostring(u83())));
            end, colours.DANGER }
    });
    row({
        { "FREEZE AI", function() -- Line: 419
                -- upvalues: run (copy), u83 (copy)
                run("freezeai", "on", (tostring(u83())));
            end },
        { "UNFREEZE ALL", function() -- Line: 420
                -- upvalues: run (copy)
                run("freezeai", "off");
            end }
    });
    note("CLEAR despawns (no loot). KILL runs deaths, loot and radio calls.");
    header("EVENTS");
    row({
        { "EMISSION NOW", function() -- Line: 427
                -- upvalues: run (copy)
                run("emission", "now");
            end, colours.DANGER },
        { "EMISSION (warning)", function() -- Line: 428
                -- upvalues: run (copy)
                run("emission", "start");
            end },
        { "STOP", function() -- Line: 429
                -- upvalues: run (copy)
                run("emission", "stop");
            end },
        { "STATUS", function() -- Line: 430
                -- upvalues: run (copy)
                run("emission", "status");
            end }
    });
    row({
        { "MILITARY PATROL", function() -- Line: 433
                -- upvalues: run (copy)
                run("patrol", "military");
            end },
        { "MONOLITH PATROL", function() -- Line: 434
                -- upvalues: run (copy)
                run("patrol", "monolith");
            end },
        { "ZONE CHATTER", function() -- Line: 435
                -- upvalues: run (copy)
                run("chatter");
            end }
    });
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "AdminTestingViews";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.DisplayOrder = 1199;
    ScreenGui.Parent = player:WaitForChild("PlayerGui");
    local u84 = {};

    local function labelFor(p85, p86, p87) -- Line: 450
        -- upvalues: u84 (copy), ScreenGui (copy)
        local v88 = u84[p85];

        if v88 and v88.bill.Parent then
            return v88;
        end;

        local v89 = p85:FindFirstChild("Head") or p85:FindFirstChild("HumanoidRootPart");

        if not v89 then
            return nil;
        end;

        local BillboardGui = Instance.new("BillboardGui");
        BillboardGui.Name = "AdminLabel";
        BillboardGui.AlwaysOnTop = true;
        BillboardGui.Size = UDim2.new(0, 220, 0, 46);
        BillboardGui.StudsOffset = Vector3.new(0, 2.6, 0);
        BillboardGui.LightInfluence = 0;
        BillboardGui.MaxDistance = 5000;
        BillboardGui.Adornee = v89;
        BillboardGui.Parent = ScreenGui;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.fromScale(1, 1);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Font = Enum.Font.GothamBold;
        TextLabel.TextSize = 11;
        TextLabel.TextStrokeTransparency = 0.3;
        TextLabel.TextColor3 = p86;
        TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom;
        TextLabel.Parent = BillboardGui;
        local v90;

        if p87 then
            v90 = Instance.new("Highlight");
            v90.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            v90.FillTransparency = 0.75;
            v90.OutlineColor = p86;
            v90.FillColor = p86;
            v90.Adornee = p85;
            v90.Parent = workspace.CurrentCamera;
        else
            v90 = nil;
        end;

        local v91 = {
            bill = BillboardGui,
            text = TextLabel,
            hl = v90
        };
        u84[p85] = v91;

        return v91;
    end;

    local function dropLabel(p92) -- Line: 487
        -- upvalues: u84 (copy)
        local v93 = u84[p92];

        if not v93 then
            return;
        end;

        v93.bill:Destroy();

        if v93.hl then
            v93.hl:Destroy();
        end;

        u84[p92] = nil;
    end;

    local function hp(p94) -- Line: 495
        local v95 = p94:FindFirstChildOfClass("Humanoid");

        return v95 and (math.floor(v95.Health) or 0) or 0, v95 and math.floor(v95.MaxHealth) or 0;
    end;

    local function targetName(p96) -- Line: 499
        -- upvalues: Players (ref)
        local Target = p96:FindFirstChild("Target");
        local v97 = Target and Target:IsA("ObjectValue") and Target.Value;

        if not v97 then
            return "none";
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v97);

        return PlayerFromCharacter and PlayerFromCharacter.Name or (v97:GetAttribute("NpcName") or (v97:GetAttribute("MutantType") or v97.Name));
    end;

    local function npcLine(p98, p99) -- Line: 506
        -- upvalues: targetName (copy)
        local v100 = p98:FindFirstChildOfClass("Humanoid");
        local v101 = v100 and (math.floor(v100.Health) or 0) or 0;
        local v102 = v100 and math.floor(v100.MaxHealth) or 0;
        local Alerted = p98:FindFirstChild("Alerted");
        local v103 = Alerted and Alerted.Value and "ALERT" or "calm";
        local v104 = ("%s %s  %d/%d  %s"):format(p98:GetAttribute("Faction") or "?", p98:GetAttribute("Rank") or "", v101, v102, v103);

        if not p99 then
            return v104;
        end;

        local v105 = p98:GetAttribute("NpcName") or p98.Name;
        local v106 = tostring(v105);
        local v107 = targetName(p98);
        local v108 = p98:GetAttribute("Tactic") or "-";
        local v109 = tostring(v108);
        local v110 = p98:GetAttribute("Morale") or "-";
        local v111 = tostring(v110);
        local v112 = p98:GetAttribute("CombatState") or "";
        local v113 = tostring(v112);
        local v114 = p98:GetAttribute("Stance") or "-";

        return ("%s\n%s  target: %s\ntactic %s  morale %s  %s  stance %s%s"):format(v106, v104, v107, v109, v111, v113, tostring(v114), p98:GetAttribute("Search") and "  SEARCHING" or "");
    end;

    local function mutantLine(p115) -- Line: 518
        local v116 = p115:FindFirstChildOfClass("Humanoid");
        local v117 = v116 and (math.floor(v116.Health) or 0) or 0;
        local v118 = v116 and math.floor(v116.MaxHealth) or 0;

        return ("%s  %d/%d%s"):format(p115:GetAttribute("MutantType") or "?", v117, v118, p115:GetAttribute("Aggro") and "  AGGRO" or "");
    end;

    local function underCrosshair() -- Line: 523
        -- upvalues: player (copy)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local ViewportSize = workspace_CurrentCamera.ViewportSize;
        local v119 = workspace_CurrentCamera:ViewportPointToRay(ViewportSize.X / 2, ViewportSize.Y / 2);
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { player.Character };
        local v120 = workspace:Raycast(v119.Origin, v119.Direction * 1000, RaycastParams_new_ret);

        if v120 then
            v120 = v120.Instance;
        end;

        while v120 and v120 ~= workspace do
            if v120:IsA("Model") and (v120:GetAttribute("Faction") or v120:GetAttribute("MutantType")) then
                return v120;
            end;

            v120 = v120.Parent;
        end;

        return nil;
    end;

    local u121 = 0;
    RunService.Heartbeat:Connect(function(p122) -- Line: 540
        -- upvalues: u121 (ref), player (copy), u37 (ref), Players (ref), labelFor (copy), u39 (ref), underCrosshair (copy), u38 (ref), u3 (ref), npcLine (copy), u84 (copy)
        u121 = u121 + p122;

        if u121 < 0.25 then
            return;
        end;

        u121 = 0;
        local u123 = player.Character and player.Character:FindFirstChild("HumanoidRootPart");
        local u124 = {};

        if u37 then
            for _, v in ipairs(Players:GetPlayers()) do
                if v ~= player and v.Character then
                    local v125 = labelFor(v.Character, Color3.fromRGB(255, 220, 90), true);

                    if v125 then
                        local HumanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart");
                        local v126 = v.Character:FindFirstChildOfClass("Humanoid");
                        local v127 = v126 and (math.floor(v126.Health) or 0) or 0;
                        local v128 = v126 and math.floor(v126.MaxHealth) or 0;
                        v125.text.Text = ("%s  %d/%d  %s"):format(v.Name, v127, v128, u123 and HumanoidRootPart and (math.floor((HumanoidRootPart.Position - u123.Position).Magnitude) .. "m" or "") or "");
                        u124[v.Character] = true;
                    end;
                end;
            end;
        end;

        local u129 = u39 and underCrosshair() or nil;

        if (u38 or u129) and u123 then
            local function each(p130, p131) -- Line: 562
                -- upvalues: u129 (copy), u38 (ref), u123 (copy)
                if not p130 then
                    return;
                end;

                for _, child in ipairs(p130:GetChildren()) do
                    local v132 = child:IsA("Model") and child:FindFirstChild("HumanoidRootPart");

                    if v132 and (child == u129 or u38 and (v132.Position - u123.Position).Magnitude <= 350) then
                        p131(child);
                    end;
                end;
            end;

            local PlayerCharacters = workspace:FindFirstChild("PlayerCharacters");

            if PlayerCharacters then
                PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
            end;

            each(PlayerCharacters, function(p133) -- Line: 570
                -- upvalues: labelFor (ref), u3 (ref), npcLine (ref), u129 (copy), u124 (copy)
                local v134 = labelFor(p133, u3[p133:GetAttribute("Faction")] or Color3.new(1, 1, 1), false);

                if v134 then
                    v134.text.Text = npcLine(p133, p133 == u129);
                    v134.bill.Size = UDim2.new(0, p133 == u129 and 300 or 220, 0, p133 == u129 and 70 or 46);
                    u124[p133] = true;
                end;
            end);
            each(workspace:FindFirstChild("Mutants"), function(p135) -- Line: 578
                -- upvalues: labelFor (ref), u124 (copy)
                local v136 = p135:FindFirstChildOfClass("Humanoid");
                local v137 = v136 and (v136.Health > 0 and labelFor(p135, Color3.fromRGB(230, 90, 90), false));

                if v137 then
                    local text = v137.text;
                    local v138 = p135:FindFirstChildOfClass("Humanoid");
                    local v139 = v138 and (math.floor(v138.Health) or 0) or 0;
                    local v140 = v138 and math.floor(v138.MaxHealth) or 0;
                    text.Text = ("%s  %d/%d%s"):format(p135:GetAttribute("MutantType") or "?", v139, v140, p135:GetAttribute("Aggro") and "  AGGRO" or "");
                    u124[p135] = true;
                end;
            end);
        end;

        for i in pairs(u84) do
            if not (u124[i] and i.Parent) then
                local v141 = u84[i];

                if v141 then
                    v141.bill:Destroy();

                    if v141.hl then
                        v141.hl:Destroy();
                    end;

                    u84[i] = nil;
                end;
            end;
        end;
    end);
    Players.PlayerRemoving:Connect(function(p142) -- Line: 592
        -- upvalues: u43 (ref), run (copy), player (copy)
        if u43 == p142.Name then
            u43 = nil;
            run("spectate", "off");
            local v143 = player.Character and player.Character:FindFirstChildOfClass("Humanoid");

            if v143 then
                workspace.CurrentCamera.CameraSubject = v143;
            end;
        end;
    end);

    return Frame;
end;

return v1;