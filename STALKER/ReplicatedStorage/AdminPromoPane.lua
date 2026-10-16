-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};
local u2 = {
    active = Color3.fromRGB(110, 190, 110),
    disabled = Color3.fromRGB(150, 150, 150),
    expired = Color3.fromRGB(200, 150, 80),
    full = Color3.fromRGB(200, 150, 80)
};

local function comma(p3) -- Line: 22
    local v4 = tonumber(p3) or 0;
    local math_floor_ret = math.floor(v4);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

function v1.Build(p5) -- Line: 28
    -- upvalues: ReplicatedStorage (copy), u2 (copy)
    local colours = p5.colours;
    local Remotes = p5.Remotes;
    local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
    local Frame = Instance.new("Frame");
    Frame.Name = "PromoPane";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.Parent = p5.content;
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
    local u6 = 0;

    local function nextOrder() -- Line: 59
        -- upvalues: u6 (ref)
        u6 = u6 + 1;

        return u6;
    end;

    local function text(p7, p8, p9, p10, p11, p12) -- Line: 60
        -- upvalues: colours (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = p8;
        TextLabel.TextXAlignment = p12 or Enum.TextXAlignment.Left;
        TextLabel.Font = p11 and Enum.Font.GothamBold or Enum.Font.Gotham;
        TextLabel.TextSize = p9 or 11;
        TextLabel.TextColor3 = p10 or colours.TEXT;
        TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel.Parent = p7;

        return TextLabel;
    end;

    local function header(p13) -- Line: 72
        -- upvalues: text (copy), ScrollingFrame (copy), u6 (ref)
        local v14 = text(ScrollingFrame, p13, 11, Color3.fromRGB(180, 175, 130), true);
        v14.Size = UDim2.new(1, 0, 0, 20);
        u6 = u6 + 1;
        v14.LayoutOrder = u6;
    end;

    local function strip(p15) -- Line: 77
        -- upvalues: u6 (ref), ScrollingFrame (copy)
        local Frame2 = Instance.new("Frame");
        Frame2.Size = UDim2.new(1, 0, 0, p15 or 28);
        u6 = u6 + 1;
        Frame2.LayoutOrder = u6;
        Frame2.BackgroundTransparency = 1;
        Frame2.Parent = ScrollingFrame;

        return Frame2;
    end;

    local function input(p16, p17, p18, p19) -- Line: 85
        -- upvalues: colours (copy)
        local TextBox = Instance.new("TextBox");
        TextBox.Size = UDim2.new(p19, -4, 1, 0);
        TextBox.Position = UDim2.new(p18, 0, 0, 0);
        TextBox.BackgroundColor3 = colours.BG_INPUT;
        TextBox.BorderSizePixel = 0;
        TextBox.PlaceholderText = p17;
        TextBox.PlaceholderColor3 = colours.TEXT_DIM;
        TextBox.Text = "";
        TextBox.ClearTextOnFocus = false;
        TextBox.Font = Enum.Font.Gotham;
        TextBox.TextSize = 11;
        TextBox.TextColor3 = colours.TEXT;
        TextBox.Parent = p16;
        Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 3);

        return TextBox;
    end;

    local function button(p20, p21, p22, p23, p24) -- Line: 102
        -- upvalues: colours (copy)
        local TextButton = Instance.new("TextButton");
        TextButton.Name = p21:gsub("[^%w]", "");
        TextButton.Size = UDim2.new(p23, -4, 1, 0);
        TextButton.Position = UDim2.new(p22, 0, 0, 0);
        TextButton.BackgroundColor3 = p24 or colours.BG_ROW;
        TextButton.BorderSizePixel = 0;
        TextButton.Text = p21;
        TextButton.Font = Enum.Font.GothamBold;
        TextButton.TextSize = 10;
        TextButton.TextColor3 = colours.TEXT;
        TextButton.Parent = p20;
        Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, 3);

        return TextButton;
    end;

    header("CREATE A CODE");
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.new(1, 0, 0, 28);
    u6 = u6 + 1;
    Frame2.LayoutOrder = u6;
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = ScrollingFrame;
    local u25 = input(Frame2, "code (letters, digits, _ -)", 0, 0.5);
    local u26 = input(Frame2, "roubles (0 = none)", 0.5, 0.5);
    local Frame3 = Instance.new("Frame");
    Frame3.Size = UDim2.new(1, 0, 0, 28);
    u6 = u6 + 1;
    Frame3.LayoutOrder = u6;
    Frame3.BackgroundTransparency = 1;
    Frame3.Parent = ScrollingFrame;
    local u27 = input(Frame3, "max uses (blank = no cap)", 0, 0.5);
    local u28 = input(Frame3, "days to expiry (blank = never)", 0.5, 0.5);
    header("ITEM REWARDS (go to the stash)");
    local Frame4 = Instance.new("Frame");
    Frame4.Size = UDim2.new(1, 0, 0, 28);
    u6 = u6 + 1;
    Frame4.LayoutOrder = u6;
    Frame4.BackgroundTransparency = 1;
    Frame4.Parent = ScrollingFrame;
    local u29 = input(Frame4, "item: type to search", 0, 0.6);
    local u30 = input(Frame4, "count", 0.6, 0.15);
    u30.Text = "1";
    local v31 = button(Frame4, "ADD", 0.75, 0.25, colours.ACCENT_G);
    local Frame5 = Instance.new("Frame");
    Frame5.Size = UDim2.new(1, 0, 0, 0);
    u6 = u6 + 1;
    Frame5.LayoutOrder = u6;
    Frame5.BackgroundTransparency = 1;
    Frame5.Parent = ScrollingFrame;
    Frame5.AutomaticSize = Enum.AutomaticSize.Y;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.Padding = UDim.new(0, 2);
    UIListLayout2.Parent = Frame5;
    local u32 = {};

    for i, v in pairs(ItemDatabase) do
        if type(i) == "string" and (type(v) == "table" and (v.Size and v.Name)) then
            table.insert(u32, i);
        end;
    end;

    table.sort(u32);

    local function clearSuggest() -- Line: 147
        -- upvalues: Frame5 (copy)
        for _, child in ipairs(Frame5:GetChildren()) do
            if child:IsA("GuiButton") then
                child:Destroy();
            end;
        end;
    end;

    u29:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 150
        -- upvalues: clearSuggest (copy), u29 (copy), ItemDatabase (copy), u32 (copy), colours (copy), Frame5 (copy)
        clearSuggest();
        local v33 = u29.Text:lower();

        if #v33 < 2 or ItemDatabase[u29.Text] then
            return;
        end;

        local v34 = 0;

        for _, v in ipairs(u32) do
            local v35 = ItemDatabase[v].Name or v;

            if v:lower():find(v33, 1, true) or tostring(v35):lower():find(v33, 1, true) then
                local TextButton = Instance.new("TextButton");
                TextButton.Size = UDim2.new(1, 0, 0, 18);
                TextButton.BackgroundColor3 = colours.BG_ROW;
                TextButton.BorderSizePixel = 0;
                TextButton.Font = Enum.Font.Gotham;
                TextButton.TextSize = 10;
                TextButton.TextColor3 = colours.TEXT;
                TextButton.TextXAlignment = Enum.TextXAlignment.Left;
                TextButton.Text = "  " .. tostring(v35) .. "   (" .. v .. ")";
                TextButton.Parent = Frame5;
                TextButton.MouseButton1Click:Connect(function() -- Line: 168
                    -- upvalues: u29 (ref), v (copy), clearSuggest (ref)
                    u29.Text = v;
                    clearSuggest();
                end);
                v34 = v34 + 1;

                if v34 >= 6 then
                    break;
                end;
            end;
        end;
    end);
    local u36 = {};
    local Frame6 = Instance.new("Frame");
    Frame6.Size = UDim2.new(1, 0, 0, 0);
    u6 = u6 + 1;
    Frame6.LayoutOrder = u6;
    Frame6.BackgroundTransparency = 1;
    Frame6.Parent = ScrollingFrame;
    Frame6.AutomaticSize = Enum.AutomaticSize.Y;
    local UIListLayout3 = Instance.new("UIListLayout");
    UIListLayout3.Padding = UDim.new(0, 2);
    UIListLayout3.Parent = Frame6;

    local function paintItems() -- Line: 181
        -- upvalues: Frame6 (copy), u36 (ref), colours (copy), ItemDatabase (copy), button (copy), paintItems (copy)
        for _, child in ipairs(Frame6:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        for i, v in ipairs(u36) do
            local Frame7 = Instance.new("Frame");
            Frame7.Size = UDim2.new(1, 0, 0, 20);
            Frame7.BackgroundColor3 = colours.BG_ROW;
            Frame7.BorderSizePixel = 0;
            Frame7.Parent = Frame6;
            Instance.new("UICorner", Frame7).CornerRadius = UDim.new(0, 3);
            local v37 = ItemDatabase[v.id];
            local v38 = ("  %dx %s"):format(v.count, v37 and v37.Name or v.id);
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BackgroundTransparency = 1;
            TextLabel.Text = v38;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.Font = Enum.Font.Gotham;
            TextLabel.TextSize = 10;
            TextLabel.TextColor3 = colours.TEXT;
            TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
            TextLabel.Parent = Frame7;
            TextLabel.Size = UDim2.new(1, -30, 1, 0);
            local v39 = button(Frame7, "X", 1, 0, colours.DANGER);
            v39.Size = UDim2.fromOffset(24, 18);
            v39.Position = UDim2.new(1, -26, 0, 1);
            v39.MouseButton1Click:Connect(function() -- Line: 196
                -- upvalues: u36 (ref), i (copy), paintItems (ref)
                table.remove(u36, i);
                paintItems();
            end);
        end;
    end;

    local TEXT_DIM = colours.TEXT_DIM;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Font = Enum.Font.Gotham;
    TextLabel.TextSize = 11;
    TextLabel.TextColor3 = TEXT_DIM or colours.TEXT;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Parent = ScrollingFrame;
    TextLabel.Size = UDim2.new(1, 0, 0, 16);

    local function say(p40, p41) -- Line: 202
        -- upvalues: TextLabel (copy)
        TextLabel.Text = p40;
        TextLabel.TextColor3 = p41 and Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
    end;

    v31.MouseButton1Click:Connect(function() -- Line: 206
        -- upvalues: u29 (copy), u30 (copy), ItemDatabase (copy), TextLabel (copy), u36 (ref), paintItems (copy)
        local v42 = u29.Text:gsub("^%s+", ""):gsub("%s+$", "");
        local v43 = tonumber(u30.Text);

        if not ItemDatabase[v42] then
            TextLabel.Text = "Unknown item id: " .. v42;
            TextLabel.TextColor3 = Color3.fromRGB(220, 110, 100);

            return;
        end;

        if not (v43 and (v43 >= 1 and v43 % 1 == 0)) then
            TextLabel.Text = "Count must be a whole number.";
            TextLabel.TextColor3 = Color3.fromRGB(220, 110, 100);

            return;
        end;

        table.insert(u36, {
            id = v42,
            count = v43
        });
        u29.Text = "";
        u30.Text = "1";
        paintItems();
        TextLabel.Text = "";
        TextLabel.TextColor3 = Color3.fromRGB(220, 110, 100);
    end);
    local Frame7 = Instance.new("Frame");
    Frame7.Size = UDim2.new(1, 0, 0, 30);
    u6 = u6 + 1;
    Frame7.LayoutOrder = u6;
    Frame7.BackgroundTransparency = 1;
    Frame7.Parent = ScrollingFrame;
    local v44 = button(Frame7, "CREATE CODE", 0, 1, colours.ACCENT_G);
    u6 = u6 + 1;
    TextLabel.LayoutOrder = u6;
    header("CODES (newest first)");
    local Frame8 = Instance.new("Frame");
    Frame8.Size = UDim2.new(1, 0, 0, 24);
    u6 = u6 + 1;
    Frame8.LayoutOrder = u6;
    Frame8.BackgroundTransparency = 1;
    Frame8.Parent = ScrollingFrame;
    local v45 = button(Frame8, "REFRESH", 0, 1);
    local Frame9 = Instance.new("Frame");
    Frame9.Size = UDim2.new(1, 0, 0, 0);
    u6 = u6 + 1;
    Frame9.LayoutOrder = u6;
    Frame9.BackgroundTransparency = 1;
    Frame9.Parent = ScrollingFrame;
    Frame9.AutomaticSize = Enum.AutomaticSize.Y;
    local UIListLayout4 = Instance.new("UIListLayout");
    UIListLayout4.Padding = UDim.new(0, 3);
    UIListLayout4.Parent = Frame9;

    local function call(p46, ...) -- Line: 232
        -- upvalues: Remotes (copy)
        local u47 = Remotes:FindFirstChild(p46);

        if not (u47 and u47:IsA("RemoteFunction")) then
            return {
                ok = false,
                err = "Server not ready."
            };
        end;

        local table_pack_ret = table.pack(...);
        local success, result = pcall(function() -- Line: 236
            -- upvalues: u47 (copy), table_pack_ret (copy)
            return u47:InvokeServer(table.unpack(table_pack_ret, 1, table_pack_ret.n));
        end);

        return (not success or type(result) ~= "table") and {
            ok = false,
            err = "No answer from the server."
        } or result;
    end;

    local u48 = nil;

    local function codeRow(u49, p50) -- Line: 242
        -- upvalues: colours (copy), Frame9 (copy), u2 (ref), button (copy), call (copy), TextLabel (copy), u48 (ref)
        local Frame10 = Instance.new("Frame");
        Frame10.Size = UDim2.new(1, 0, 0, 40);
        Frame10.BackgroundColor3 = colours.BG_ROW;
        Frame10.BorderSizePixel = 0;
        Frame10.Parent = Frame9;
        Instance.new("UICorner", Frame10).CornerRadius = UDim.new(0, 3);
        local v51 = "  " .. u49.code;
        local TEXT = colours.TEXT;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.Text = v51;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Font = Enum.Font.GothamBold or Enum.Font.Gotham;
        TextLabel2.TextSize = 12;
        TextLabel2.TextColor3 = TEXT or colours.TEXT;
        TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel2.Parent = Frame10;
        TextLabel2.Size = UDim2.new(0.5, 0, 0, 18);
        local string_upper_ret = string.upper(u49.status);
        local v52 = u2[u49.status] or colours.TEXT_DIM;
        local Right = Enum.TextXAlignment.Right;
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.Text = string_upper_ret;
        TextLabel3.TextXAlignment = Right or Enum.TextXAlignment.Left;
        TextLabel3.Font = Enum.Font.GothamBold or Enum.Font.Gotham;
        TextLabel3.TextSize = 10;
        TextLabel3.TextColor3 = v52 or colours.TEXT;
        TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel3.Parent = Frame10;
        TextLabel3.Size = UDim2.new(0.5, -80, 0, 18);
        TextLabel3.Position = UDim2.new(0.5, 0, 0, 0);
        local v53 = u49.maxUses and ("%d / %d used"):format(u49.uses, u49.maxUses) or ("%d used"):format(u49.uses);
        local v54;

        if u49.expiresAt then
            local v55 = u49.expiresAt - (p50 or os.time());
            v54 = v55 <= 0 and "expired" or ("expires in %dd %dh"):format(v55 // 86400, v55 % 86400 // 3600);
        else
            v54 = "no expiry";
        end;

        local v56 = ("  %s  |  %s  |  %s"):format(u49.reward == "" and "-" or (u49.reward or "-"), v53, v54);
        local TEXT_DIM2 = colours.TEXT_DIM;
        local TextLabel4 = Instance.new("TextLabel");
        TextLabel4.BackgroundTransparency = 1;
        TextLabel4.Text = v56;
        TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel4.Font = Enum.Font.Gotham;
        TextLabel4.TextSize = 10;
        TextLabel4.TextColor3 = TEXT_DIM2 or colours.TEXT;
        TextLabel4.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel4.Parent = Frame10;
        TextLabel4.Size = UDim2.new(1, -84, 0, 18);
        TextLabel4.Position = UDim2.fromOffset(0, 19);
        local v57 = button(Frame10, u49.active and "DISABLE" or "ENABLE", 1, 0, u49.active and colours.DANGER or colours.ACCENT_G);
        v57.Size = UDim2.fromOffset(72, 30);
        v57.Position = UDim2.new(1, -76, 0, 5);
        v57.MouseButton1Click:Connect(function() -- Line: 266
            -- upvalues: call (ref), u49 (copy), TextLabel (ref), u48 (ref)
            local v58 = call("PromoAdminSetActive", u49.code, not u49.active);

            if not v58.ok then
                TextLabel.Text = v58.err or "Failed.";
                TextLabel.TextColor3 = Color3.fromRGB(220, 110, 100);

                return;
            end;

            TextLabel.Text = (u49.active and "Disabled " or "Enabled ") .. u49.code;
            TextLabel.TextColor3 = Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
            u48();
        end);
    end;

    u48 = function() -- Line: 272
        -- upvalues: Frame9 (copy), call (copy), TextLabel (copy), colours (copy), codeRow (copy)
        for _, child in ipairs(Frame9:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        local v59 = call("PromoAdminList");

        if not v59.ok then
            TextLabel.Text = v59.err or "Could not load the codes.";
            TextLabel.TextColor3 = Color3.fromRGB(220, 110, 100);

            return;
        end;

        if #v59.codes ~= 0 then
            for _, v in ipairs(v59.codes) do
                codeRow(v, v59.now);
            end;

            return;
        end;

        local TEXT_DIM2 = colours.TEXT_DIM;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.Text = "  No codes yet.";
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Font = Enum.Font.Gotham;
        TextLabel2.TextSize = 10;
        TextLabel2.TextColor3 = TEXT_DIM2 or colours.TEXT;
        TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel2.Parent = Frame9;
        TextLabel2.Size = UDim2.new(1, 0, 0, 18);
    end;

    v45.MouseButton1Click:Connect(u48);
    v44.MouseButton1Click:Connect(function() -- Line: 285
        -- upvalues: u25 (copy), u26 (copy), u36 (ref), u27 (copy), u28 (copy), TextLabel (copy), call (copy), paintItems (copy), u48 (ref)
        local function num(p60) -- Line: 286
            local v61 = p60.Text:gsub("%s", ""):gsub(",", "");

            if v61 == "" then
                return nil;
            end;

            return tonumber(v61);
        end;

        local v62 = {
            code = u25.Text
        };
        local v63 = u26.Text:gsub("%s", ""):gsub(",", "");
        local v64;

        if v63 == "" then
            v64 = nil;
        else
            v64 = tonumber(v63);
        end;

        v62.roubles = v64 or 0;
        v62.items = u36;
        local v65 = u27.Text:gsub("%s", ""):gsub(",", "");
        local v66;

        if v65 == "" then
            v66 = nil;
        else
            v66 = tonumber(v65);
        end;

        v62.maxUses = v66;
        local v67 = u28.Text:gsub("%s", ""):gsub(",", "");
        local v68;

        if v67 == "" then
            v68 = nil;
        else
            v68 = tonumber(v67);
        end;

        v62.expiresDays = v68;
        TextLabel.Text = "Creating...";
        TextLabel.TextColor3 = Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
        local v69 = call("PromoAdminCreate", v62);

        if v69.ok and v69.warn then
            TextLabel.Text = v69.warn;
            TextLabel.TextColor3 = Color3.fromRGB(220, 110, 100);
            u25.Text = "";
            u26.Text = "";
            u27.Text = "";
            u28.Text = "";
            u36 = {};
            paintItems();

            return;
        end;

        if not v69.ok then
            TextLabel.Text = v69.err or "Failed.";
            TextLabel.TextColor3 = Color3.fromRGB(220, 110, 100);

            return;
        end;

        local code = v69.code;
        local v70;

        if v62.roubles > 0 then
            local v71 = tonumber(v62.roubles) or 0;
            local math_floor_ret = math.floor(v71);
            v70 = " for " .. tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " roubles" or "";
        else
            v70 = "";
        end;

        TextLabel.Text = ("Created \"%s\"%s."):format(code, v70);
        TextLabel.TextColor3 = Color3.fromRGB(130, 200, 120) or Color3.fromRGB(220, 110, 100);
        u25.Text = "";
        u26.Text = "";
        u27.Text = "";
        u28.Text = "";
        u36 = {};
        paintItems();
        u48();
    end);
    local u72 = false;
    Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 315
        -- upvalues: Frame (copy), u72 (ref), u48 (ref)
        if Frame.Visible and not u72 then
            u72 = true;
            u48();
        end;
    end);

    return Frame;
end;

return v1;