-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RadioClient = require(ReplicatedStorage:WaitForChild("RadioClient"));
local RadioRules = require(ReplicatedStorage:WaitForChild("RadioRules"));
local RadioConfig = require(ReplicatedStorage:WaitForChild("RadioConfig"));
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local ItemIconStyle = require(ReplicatedStorage:WaitForChild("ItemIconStyle"));
local ConditionValue = require(ReplicatedStorage:WaitForChild("ConditionValue"));
local LocalPlayer = Players.LocalPlayer;
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret2 = Color3.fromRGB(120, 180, 235);
local Color3_fromRGB_ret3 = Color3.fromRGB(220, 220, 220);
local Color3_fromRGB_ret4 = Color3.fromRGB(170, 170, 170);
local Color3_fromRGB_ret5 = Color3.fromRGB(120, 120, 120);
local Color3_fromRGB_ret6 = Color3.fromRGB(60, 70, 50);
local Color3_fromRGB_ret7 = Color3.fromRGB(40, 42, 45);
local Color3_fromRGB_ret8 = Color3.fromRGB(30, 33, 30);
local Color3_fromRGB_ret9 = Color3.fromRGB(34, 37, 34);
local Color3_fromRGB_ret10 = Color3.fromRGB(45, 48, 42);
local Color3_fromRGB_ret11 = Color3.fromRGB(22, 24, 22);
local Color3_fromRGB_ret12 = Color3.fromRGB(62, 82, 52);
local u1 = { { "all", "ALL" }, { "ammo", "AMMO" }, { "weapons", "WEAPONS" }, { "gear", "GEAR" }, { "medical", "MEDICAL" }, { "attachments", "ATTACHMENTS" }, { "consumables", "CONSUMABLES" }, { "other", "OTHER" } };
local u2 = {
    Primary = "weapons",
    Sidearm = "weapons",
    Melee = "weapons",
    Ammo = "ammo",
    AmmoPack = "ammo",
    BodyGear = "gear",
    HeadGear = "gear",
    FaceWear = "gear",
    Uniform = "gear",
    Backpack = "gear",
    BeltGear = "gear",
    StorageBox = "gear",
    EyeWear = "gear",
    Watch = "gear",
    Medical = "medical",
    NightOptical = "attachments",
    ArmorInsert = "attachments",
    MaskFilter = "attachments",
    UpgradeKit = "attachments",
    Patch = "attachments",
    FoodAndDrink = "consumables",
    Injector = "consumables",
    Vial = "consumables"
};
local u3 = {
    ammo = "Ammo",
    weapons = "Weapon",
    gear = "Gear",
    medical = "Medical",
    attachments = "Attachment",
    consumables = "Consumable",
    other = "Other"
};
local u4 = {};

local function dbOf(p5) -- Line: 81
    -- upvalues: ItemDatabase (copy)
    local v6 = ItemDatabase[p5];

    return type(v6) == "table" and v6 and v6 or nil;
end;

local function categoryOf(p7) -- Line: 86
    -- upvalues: ItemDatabase (copy), u2 (copy)
    local v8 = ItemDatabase[p7];
    local v9 = type(v8) == "table" and v8 and v8 or nil;

    return v9 and u2[v9.ItemType] or "other";
end;

local function conditionRatio(p10) -- Line: 91
    local v11;

    if type(p10) == "string" then
        v11 = tonumber(p10:match("^(%d+)%%$"));
    else
        v11 = false;
    end;

    return v11 and math.clamp(v11 / 100, 0, 1) or nil;
end;

function u4.VendorHint(p12, p13, p14) -- Line: 98
    -- upvalues: ItemDatabase (copy), ConditionValue (copy)
    local v15 = ItemDatabase[p12];
    local v16 = type(v15) == "table" and v15 and v15 or nil;
    local v17;

    if v16 then
        v17 = tonumber(v16.BaseSellValue);
    else
        v17 = v16;
    end;

    if not v17 or v17 <= 0 then
        return nil;
    end;

    local v18 = 1;
    local v19;

    if type(p13) == "string" then
        v19 = tonumber(p13:match("^(%d+)%%$"));
    else
        v19 = false;
    end;

    local v20 = v19 and math.clamp(v19 / 100, 0, 1) or nil;

    if v20 then
        v18 = v20 ^ (ConditionValue.CURVE_POWER or 2);
    end;

    local v21;

    if type(p13) == "string" then
        v21 = tonumber(p13:match("^(%d+) rds$"));
    else
        v21 = false;
    end;

    if v21 and (v16.stackSize and v16.stackSize > 0) then
        v18 = math.clamp(v21 / v16.stackSize, 0, 1);
    end;

    return math.floor(v17 * 0.65 * v18 * (p14 or 1));
end;

local function priceStep(p22) -- Line: 110
    return p22 < 1000 and 50 or (p22 < 10000 and 250 or (p22 < 100000 and 1000 or 5000));
end;

local function ago(p23) -- Line: 117
    local os_time_ret = os.time();
    local v24 = p23 or os.time();
    local math_max_ret = math.max(0, os_time_ret - v24);

    if math_max_ret < 60 then
        return "just now";
    end;

    if math_max_ret < 3600 then
        return math_max_ret // 60 .. "m ago";
    end;

    return math_max_ret // 3600 .. "h ago";
end;

local function qtyOf(p25) -- Line: 125
    if p25.k == "buy" then
        return p25.q or 1;
    end;

    local v26;

    if type(p25.d) == "string" then
        v26 = tonumber(p25.d:match("^(%d+) rds$"));
    else
        v26 = false;
    end;

    return v26 or 1;
end;

local function label(p27, p28) -- Line: 132
    -- upvalues: Font_new_ret3 (copy), Color3_fromRGB_ret3 (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = p28.font or Font_new_ret3;
    TextLabel.TextSize = p28.size or 14;
    TextLabel.TextColor3 = p28.color or Color3_fromRGB_ret3;
    TextLabel.TextXAlignment = p28.align or Enum.TextXAlignment.Left;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Text = p28.text or "";
    TextLabel.Position = p28.pos or UDim2.new();
    TextLabel.Size = p28.sizeU or UDim2.new(1, 0, 0, 20);
    TextLabel.LayoutOrder = p28.order or 0;
    TextLabel.Parent = p27;

    return TextLabel;
end;

local function button(p29, p30, p31, p32, p33, p34) -- Line: 148
    -- upvalues: Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.Position = p31;
    TextButton.Size = p32;
    TextButton.BackgroundColor3 = p34 and Color3_fromRGB_ret6 or Color3_fromRGB_ret7;
    TextButton.BackgroundTransparency = p34 and 0.1 or 0.2;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = true;
    TextButton.FontFace = Font_new_ret2;
    TextButton.TextSize = 13;
    TextButton.TextColor3 = p34 and Color3_fromRGB_ret or Color3_fromRGB_ret3;
    TextButton.Text = p30;
    TextButton.Parent = p29;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p34 and Color3_fromRGB_ret or Color3.fromRGB(80, 80, 80);
    UIStroke.Thickness = 1;
    UIStroke.Transparency = p34 and 0.2 or 0;
    UIStroke.Parent = TextButton;
    TextButton.MouseButton1Click:Connect(p33);

    return TextButton;
end;

local function actionButton(p35, p36, p37, p38, p39) -- Line: 170
    -- upvalues: button (copy), Color3_fromRGB_ret12 (copy)
    local v40 = button(p35, p36, p37, p38, p39);
    v40.BackgroundColor3 = Color3_fromRGB_ret12;
    v40.BackgroundTransparency = 0.05;

    return v40;
end;

local function corner(p41, p42) -- Line: 177
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, p42 or 4);
    UICorner.Parent = p41;
end;

local function itemIcon(p43, p44, p45, p46) -- Line: 183
    -- upvalues: Color3_fromRGB_ret10 (copy), ItemDatabase (copy), ItemIconStyle (copy)
    local Frame = Instance.new("Frame");
    Frame.Position = p46;
    Frame.Size = UDim2.fromOffset(p45, p45);
    Frame.BackgroundColor3 = Color3_fromRGB_ret10;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p43;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 3);
    UICorner.Parent = Frame;
    local v47 = ItemDatabase[p44];
    local v48 = type(v47) == "table" and v47 and v47 or nil;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(0.9, 0.9);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = v48 and (v48.ImageID or "") or "";
    ImageLabel.ScaleType = ItemIconStyle.ScaleTypeFor(v48);
    ImageLabel.Parent = Frame;

    return Frame;
end;

local function hrow(p49, p50, p51, p52) -- Line: 203
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 0, p50);
    Frame.BackgroundTransparency = 1;
    Frame.LayoutOrder = p51 or 0;
    Frame.Parent = p49;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, p52 or 4);
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.Parent = Frame;

    return Frame;
end;

local function inquiriesFor(p53) -- Line: 218
    -- upvalues: RadioClient (copy)
    local v54 = 0;

    for _, v in ipairs(RadioClient:Notices()) do
        if v.id == p53 then
            v54 = v54 + 1;
        end;
    end;

    return v54;
end;

local function sortedBoard(p55, p56) -- Line: 227
    -- upvalues: RadioClient (copy), LocalPlayer (copy), ItemDatabase (copy), u2 (copy)
    local v57 = {};

    for _, v in ipairs(RadioClient:Board()) do
        local v58 = v.u == LocalPlayer.UserId;

        if p55.filter == "all" or p55.filter == "sell" and v.k == "sell" or p55.filter == "buy" and v.k == "buy" then
            v58 = true;
        elseif p55.filter ~= "mine" then
            v58 = false;
        end;

        local v59;

        if p55.category == "all" then
            v59 = true;
        else
            local v60 = ItemDatabase[v.item];
            local v61 = type(v60) == "table" and v60 and v60 or nil;
            v59 = (v61 and u2[v61.ItemType] or "other") == p55.category;
        end;

        if v58 and (v59 and (p56 == "" and true or string.find(string.lower(v.n or ""), p56, 1, true) ~= nil)) then
            table.insert(v57, v);
        end;
    end;

    local sortBy = p55.sortBy;
    local sortDir = p55.sortDir;
    table.sort(v57, function(p62, p63) -- Line: 240
        -- upvalues: sortBy (copy), sortDir (copy)
        if sortBy == "price" then
            if p62.pr ~= p63.pr then
                return sortDir == "asc" == ((p62.pr or 0) < (p63.pr or 0));
            end;
        elseif sortBy == "qty" then
            local v64;

            if p62.k == "buy" then
                v64 = p62.q or 1;
            else
                local v65;

                if type(p62.d) == "string" then
                    v65 = tonumber(p62.d:match("^(%d+) rds$"));
                else
                    v65 = false;
                end;

                v64 = v65 or 1;
            end;

            local v66;

            if p63.k == "buy" then
                v66 = p63.q or 1;
            else
                local v67;

                if type(p63.d) == "string" then
                    v67 = tonumber(p63.d:match("^(%d+) rds$"));
                else
                    v67 = false;
                end;

                v66 = v67 or 1;
            end;

            if v64 ~= v66 then
                return sortDir == "asc" == (v64 < v66);
            end;
        end;

        return (p62.ts or 0) > (p63.ts or 0);
    end);

    return v57;
end;

local function buildRow(p68, u69, p70, u71) -- Line: 252
    -- upvalues: LocalPlayer (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret (copy), itemIcon (copy), label (copy), Font_new_ret2 (copy), u3 (copy), ItemDatabase (copy), u2 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret2 (copy), Font_new_ret3 (copy), RadioRules (copy), Font_new_ret (copy), Color3_fromRGB_ret4 (copy), RadioConfig (copy), RadioClient (copy), button (copy), Color3_fromRGB_ret12 (copy)
    local state = u71.state;
    local v72 = u69.u == LocalPlayer.UserId;
    local v73 = u69.k == "sell";
    local v74 = state.selectedId == u69.id;
    local TextButton = Instance.new("TextButton");
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.Size = UDim2.new(1, -6, 0, 46);
    TextButton.BackgroundColor3 = p70 % 2 == 0 and Color3_fromRGB_ret9 or Color3_fromRGB_ret8;
    TextButton.BorderSizePixel = 0;
    TextButton.LayoutOrder = p70;
    TextButton.Parent = p68;

    if v74 then
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3_fromRGB_ret;
        UIStroke.Thickness = 1;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Parent = TextButton;
    end;

    TextButton.MouseButton1Click:Connect(function() -- Line: 273
        -- upvalues: state (copy), u69 (copy), u71 (copy)
        local _ = state.selectedId == u69.id;
        state.selectedId = u69.id;
        u71.rerender();
    end);
    itemIcon(TextButton, u69.item, 38, UDim2.fromOffset(4, 4));
    label(TextButton, {
        size = 14,
        text = not (v73 or (not u69.q or u69.q <= 1)) and u69.q .. "x " .. u69.n or u69.n,
        font = Font_new_ret2,
        pos = UDim2.new(0, 48, 0, 4),
        sizeU = UDim2.new(0.37, -52, 0, 20)
    });
    local v75 = ItemDatabase[u69.item];
    local v76 = type(v75) == "table" and v75 and v75 or nil;
    local v77 = u3[v76 and u2[v76.ItemType] or "other"] or "Other";
    local d = u69.d;
    local v78;

    if type(d) == "string" then
        v78 = tonumber(d:match("^(%d+)%%$"));
    else
        v78 = false;
    end;

    if v78 and math.clamp(v78 / 100, 0, 1) or nil then
        v77 = v77 .. "  ·  " .. u69.d;
    end;

    label(TextButton, {
        size = 12,
        text = v73 and v77 and v77 or "WANTED  ·  " .. v77,
        color = v73 and Color3_fromRGB_ret5 or Color3_fromRGB_ret2,
        pos = UDim2.new(0, 48, 0, 24),
        sizeU = UDim2.new(0.37, -52, 0, 16)
    }).FontFace = v73 and Font_new_ret3 or Font_new_ret2;
    local v79 = {
        size = 14
    };
    local v80;

    if u69.k == "buy" then
        v80 = u69.q or 1;
    else
        local v81;

        if type(u69.d) == "string" then
            v81 = tonumber(u69.d:match("^(%d+) rds$"));
        else
            v81 = false;
        end;

        v80 = v81 or 1;
    end;

    v79.text = tostring(v80);
    v79.pos = UDim2.new(0.37, 0, 0, 13);
    v79.sizeU = UDim2.new(0.09000000000000002, -4, 0, 20);
    label(TextButton, v79);
    label(TextButton, {
        size = 14,
        text = RadioRules.FormatRoubles(u69.pr),
        font = Font_new_ret,
        color = v73 and Color3_fromRGB_ret or Color3_fromRGB_ret2,
        pos = UDim2.new(0.46, 0, 0, 13),
        sizeU = UDim2.new(0.13999999999999996, -4, 0, 20)
    });
    label(TextButton, {
        size = 13,
        text = v72 and "You" or u69.dn,
        color = Color3_fromRGB_ret4,
        pos = UDim2.new(0.6, 0, 0, 13),
        sizeU = UDim2.new(0.13, -4, 0, 20)
    });
    local v82;

    if v72 then
        local LIFETIME = RadioConfig.Trade.LIFETIME;
        local os_time_ret = os.time();
        local v83 = u69.ts or os.time();
        local math_max_ret = math.max(0, LIFETIME - (os_time_ret - v83));
        local id = u69.id;
        local v84 = 0;

        for _, v in ipairs(RadioClient:Notices()) do
            if v.id == id then
                v84 = v84 + 1;
            end;
        end;

        v82 = math_max_ret // 60 .. " min left" .. (v84 > 0 and ("  ·  " .. v84 .. " inquir" .. (v84 == 1 and "y" or "ies") or "") or "");
    else
        local ts = u69.ts;
        local os_time_ret = os.time();
        local v85 = ts or os.time();
        local math_max_ret = math.max(0, os_time_ret - v85);

        if math_max_ret < 60 then
            v82 = "just now";
        elseif math_max_ret < 3600 then
            v82 = math_max_ret // 60 .. "m ago";
        else
            v82 = math_max_ret // 3600 .. "h ago";
        end;
    end;

    label(TextButton, {
        size = 12,
        text = v82,
        color = Color3_fromRGB_ret5,
        pos = UDim2.new(0.73, 0, 0, 14),
        sizeU = UDim2.new(0.10999999999999999, -4, 0, 18)
    });
    local v86 = not v72 and RadioClient:SentInterest(u69.id);
    local UDim2_new_ret = UDim2.new(0.84, 0, 0, 9);
    local UDim2_new_ret2 = UDim2.new(0.16000000000000003, -8, 0, 28);

    if v72 then
        button(TextButton, "CANCEL", UDim2_new_ret, UDim2_new_ret2, function() -- Line: 313
            -- upvalues: RadioClient (ref), u69 (copy), u71 (copy)
            local v87 = RadioClient:Cancel(u69.id);
            u71.setStatus(v87.ok and "Listing removed." or (u71.reasons[v87.reason] or u71.reasons.try_later));
        end);

        return;
    end;

    if v86 then
        local v89 = button(TextButton, "JOIN", UDim2_new_ret, UDim2_new_ret2, function() -- Line: 318
            -- upvalues: RadioClient (ref), u69 (copy), u71 (copy)
            local v88 = RadioClient:Join(u69.u);

            if not v88.ok then
                u71.setStatus(u71.reasons[v88.reason] or u71.reasons.join_failed);
            end;
        end);
        v89.BackgroundColor3 = Color3_fromRGB_ret12;
        v89.BackgroundTransparency = 0.05;

        return;
    end;

    if not v86 then
        if u71.allowed then
            local v91 = button(TextButton, "INQUIRE", UDim2_new_ret, UDim2_new_ret2, function() -- Line: 327
                -- upvalues: RadioClient (ref), u69 (copy), u71 (copy)
                local v90 = RadioClient:Interested(u69.id);
                u71.setStatus(v90.ok and "Inquiry sent." or (u71.reasons[v90.reason] or u71.reasons.try_later));
                u71.rerender();
            end);
            v91.BackgroundColor3 = Color3_fromRGB_ret12;
            v91.BackgroundTransparency = 0.05;
        end;

        return;
    end;

    local v92 = button(TextButton, "INQUIRED", UDim2_new_ret, UDim2_new_ret2, function() -- Line: 323
    end);
    v92.TextColor3 = Color3_fromRGB_ret5;
    v92.AutoButtonColor = false;
end;

local function header(p93, u94, u95) -- Line: 335
    -- upvalues: Font_new_ret2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret5 (copy), label (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, -6, 0, 22);
    Frame.BackgroundTransparency = 1;
    Frame.LayoutOrder = 9;
    Frame.Parent = p93;

    local function head(p96, p97, p98, u99) -- Line: 341
        -- upvalues: u94 (copy), Font_new_ret2 (ref), Color3_fromRGB_ret (ref), Color3_fromRGB_ret5 (ref), Frame (copy), u95 (copy), label (ref)
        if not u99 then
            label(Frame, {
                size = 12,
                text = p96,
                font = Font_new_ret2,
                color = Color3_fromRGB_ret5,
                pos = UDim2.new(p97, p97 == 0 and 6 or 0, 0, 2),
                sizeU = UDim2.new(p98 - p97, -4, 1, 0)
            });

            return;
        end;

        local v100 = u94.sortBy == u99;
        local v101 = v100 and (u94.sortDir == "asc" and " ▲" or " ▼") or " ↕";
        local TextButton = Instance.new("TextButton");
        TextButton.BackgroundTransparency = 1;
        TextButton.FontFace = Font_new_ret2;
        TextButton.TextSize = 12;
        TextButton.TextColor3 = v100 and Color3_fromRGB_ret or Color3_fromRGB_ret5;
        TextButton.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton.Text = p96 .. v101;
        TextButton.Position = UDim2.new(p97, 0, 0, 0);
        TextButton.Size = UDim2.new(p98 - p97, -4, 1, 0);
        TextButton.Parent = Frame;
        TextButton.MouseButton1Click:Connect(function() -- Line: 355
            -- upvalues: u94 (ref), u99 (copy), u95 (ref)
            if u94.sortBy == u99 then
                u94.sortDir = u94.sortDir == "asc" and "desc" or "asc";
            else
                u94.sortBy = u99;
                u94.sortDir = "asc";
            end;

            u95.rerender();
        end);
    end;

    label(Frame, {
        text = "ITEM",
        size = 12,
        font = Font_new_ret2,
        color = Color3_fromRGB_ret5,
        pos = UDim2.new(0, 6, 0, 2),
        sizeU = UDim2.new(0.37, -4, 1, 0)
    });
    head("QTY", 0.37, 0.46, "qty");
    head("PRICE", 0.46, 0.6, "price");
    label(Frame, {
        text = "SELLER",
        size = 12,
        font = Font_new_ret2,
        color = Color3_fromRGB_ret5,
        pos = UDim2.new(0.6, 0, 0, 2),
        sizeU = UDim2.new(0.13, -4, 1, 0)
    });
    label(Frame, {
        text = "TIME",
        size = 12,
        font = Font_new_ret2,
        color = Color3_fromRGB_ret5,
        pos = UDim2.new(0.73, 0, 0, 2),
        sizeU = UDim2.new(0.10999999999999999, -4, 1, 0)
    });
end;

local function topBar(u102, p103) -- Line: 376
    -- upvalues: hrow (copy), RadioClient (copy), button (copy), u1 (copy)
    local state = u102.state;
    local v104 = hrow(u102.bar, 32, 1, 6);
    u102.search.Visible = true;
    u102.search.Parent = v104;
    u102.search.LayoutOrder = 1;
    u102.search.PlaceholderText = p103;
    local v105 = #RadioClient:Notices() - (state.noticesSeen or 0);
    u102.search.Size = UDim2.new(1, -(116 + (v105 > 0 and 118 or 0) + 38 + 118), 0, 30);
    button(v104, "X", UDim2.new(), UDim2.fromOffset(32, 30), function() -- Line: 386
        -- upvalues: u102 (copy)
        u102.search.Text = "";
        u102.rerender();
    end).LayoutOrder = 2;
    button(v104, "FILTERS", UDim2.new(), UDim2.fromOffset(100, 30), function() -- Line: 390
        -- upvalues: state (copy), u102 (copy)
        state.showFilters = not state.showFilters;
        u102.rerender();
    end, state.showFilters).LayoutOrder = 3;
    local State = RadioClient:GetState();
    local u106 = State and (State.mutes and State.mutes.channels) and State.mutes.channels.trade_summary == true;
    button(v104, u106 and "UPDATES OFF" or "UPDATES ON", UDim2.new(), UDim2.fromOffset(110, 30), function() -- Line: 398
        -- upvalues: RadioClient (ref), u106 (copy)
        RadioClient:SetMute("channel", "trade_summary", not u106);
    end, not u106).LayoutOrder = 5;

    if v105 > 0 then
        button(v104, v105 .. (v105 == 1 and " INQUIRY" or " INQUIRIES"), UDim2.new(), UDim2.fromOffset(110, 30), function() -- Line: 402
            -- upvalues: state (copy), RadioClient (ref), u102 (copy)
            state.noticesOpen = true;
            state.noticesSeen = #RadioClient:Notices();
            u102.rerender();
        end, true).LayoutOrder = 4;
    end;

    local v107 = 32;

    if state.showFilters and not state.posting then
        local v108 = hrow(u102.bar, 26, 2);

        for i, v in ipairs({ { "all", "ALL" }, { "sell", "SELLING" }, { "buy", "BUYING" }, { "mine", "MINE" } }) do
            button(v108, v[2], UDim2.new(), UDim2.fromOffset(i == 1 and 48 or 80, 24), function() -- Line: 412
                -- upvalues: state (copy), v (copy), u102 (copy)
                state.filter = v[1];
                u102.rerender();
            end, state.filter == v[1]).LayoutOrder = i;
        end;

        v107 = v107 + 30;
    end;

    local v109 = hrow(u102.bar, 26, 3);

    for i, v in ipairs(u1) do
        local v110 = button(v109, v[2], UDim2.new(), UDim2.fromOffset(i == 1 and 38 or math.max(48, #v[2] * 8 + 10), 24), function() -- Line: 421
            -- upvalues: state (copy), v (copy), u102 (copy)
            state.category = v[1];
            u102.rerender();
        end, state.category == v[1]);
        v110.LayoutOrder = i;
        v110.TextSize = 12;
    end;

    return v107 + 30;
end;

local function renderPicker(u111) -- Line: 432
    -- upvalues: RadioClient (copy), ItemDatabase (copy), u2 (copy), Color3_fromRGB_ret8 (copy), itemIcon (copy), label (copy), Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy), u4 (copy), RadioConfig (copy), Color3_fromRGB_ret5 (copy)
    local state = u111.state;
    local offer = state.offer;
    offer.choices = offer.choices or (offer.k == "sell" and RadioClient:MyItems() or RadioClient:Catalog());
    local string_lower_ret = string.lower(u111.search.Text);
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, -8, 0, 0);
    Frame.AutomaticSize = Enum.AutomaticSize.Y;
    Frame.BackgroundTransparency = 1;
    Frame.Parent = u111.feed;
    local UIGridLayout = Instance.new("UIGridLayout");
    UIGridLayout.CellSize = UDim2.new(0.2, -6, 0, 100);
    UIGridLayout.CellPadding = UDim2.fromOffset(6, 6);
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIGridLayout.Parent = Frame;
    local v112 = 0;

    for _, v in ipairs(offer.choices) do
        if v112 >= 80 then
            break;
        end;

        local v113;

        if state.category == "all" then
            v113 = true;
        else
            local v114 = ItemDatabase[v.item];
            local v115 = type(v114) == "table" and v114 and v114 or nil;
            v113 = (v115 and u2[v115.ItemType] or "other") == state.category;
        end;

        if v113 and (string_lower_ret == "" and true or string.find(string.lower(v.n), string_lower_ret, 1, true) ~= nil) then
            v112 = v112 + 1;
            local TextButton = Instance.new("TextButton");
            TextButton.Text = "";
            TextButton.AutoButtonColor = true;
            TextButton.BackgroundColor3 = Color3_fromRGB_ret8;
            TextButton.BorderSizePixel = 0;
            TextButton.LayoutOrder = v112;
            TextButton.Parent = Frame;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0, 4);
            UICorner.Parent = TextButton;
            itemIcon(TextButton, v.item, 52, UDim2.new(0.5, -26, 0, 6));
            label(TextButton, {
                size = 11,
                text = v.n,
                font = Font_new_ret2,
                align = Enum.TextXAlignment.Center,
                pos = UDim2.fromOffset(3, 60),
                sizeU = UDim2.new(1, -6, 0, 24)
            }).TextWrapped = true;

            if v.d then
                label(TextButton, {
                    size = 10,
                    text = v.d,
                    color = Color3_fromRGB_ret4,
                    align = Enum.TextXAlignment.Center,
                    pos = UDim2.fromOffset(3, 84),
                    sizeU = UDim2.new(1, -6, 0, 14)
                });
            end;

            TextButton.MouseButton1Click:Connect(function() -- Line: 473
                -- upvalues: offer (copy), v (copy), u4 (ref), RadioConfig (ref), state (copy), u111 (copy)
                local n = v.n;
                local d = v.d;
                local ref = v.ref;
                offer.item = v.item;
                offer.n = n;
                offer.d = d;
                offer.ref = ref;
                local v116 = u4.VendorHint(v.item, v.d, offer.q);
                local v117;

                if v116 and v116 > 0 then
                    local v118 = v116 < 1000 and 50 or (v116 < 10000 and 250 or (v116 < 100000 and 1000 or 5000));
                    v117 = math.floor(v116 / v118 + 0.5) * v118;

                    if v117 <= 0 then
                        v117 = v116;
                    end;
                else
                    v117 = 100;
                end;

                offer.pr = math.max(RadioConfig.Trade.PRICE_MIN, v117);
                state.posting = nil;
                u111.search.Text = "";
                u111.rerender();
            end);
        end;
    end;

    if v112 == 0 then
        label(u111.feed, {
            size = 15,
            text = offer.k == "sell" and "Nothing here to sell." or "No items match.",
            color = Color3_fromRGB_ret5,
            align = Enum.TextXAlignment.Center,
            sizeU = UDim2.new(1, 0, 0, 50)
        });
    end;
end;

local function renderNotices(u119) -- Line: 497
    -- upvalues: hrow (copy), button (copy), label (copy), Font_new_ret (copy), RadioClient (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret9 (copy), Color3_fromRGB_ret8 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret12 (copy)
    local state = u119.state;
    local v120 = hrow(u119.bar, 32, 1);
    button(v120, "BACK", UDim2.new(), UDim2.fromOffset(70, 30), function() -- Line: 500
        -- upvalues: state (copy), u119 (copy)
        state.noticesOpen = false;
        u119.rerender();
    end).LayoutOrder = 1;
    label(v120, {
        text = "INQUIRIES ABOUT YOUR LISTINGS",
        size = 14,
        order = 2,
        font = Font_new_ret,
        sizeU = UDim2.fromOffset(300, 30)
    });
    local v121 = RadioClient:Notices();

    if #v121 == 0 then
        label(u119.feed, {
            text = "Nobody yet.",
            size = 15,
            color = Color3_fromRGB_ret5,
            align = Enum.TextXAlignment.Center,
            sizeU = UDim2.new(1, 0, 0, 50)
        });
    end;

    for i = #v121, 1, -1 do
        local u122 = v121[i];
        local Frame = Instance.new("Frame");
        Frame.Size = UDim2.new(1, -6, 0, 44);
        Frame.BackgroundColor3 = i % 2 == 0 and Color3_fromRGB_ret9 or Color3_fromRGB_ret8;
        Frame.BorderSizePixel = 0;
        Frame.LayoutOrder = #v121 - i + 1;
        Frame.Parent = u119.feed;
        label(Frame, {
            size = 14,
            text = RadioClient.NoticeText(u122),
            font = Font_new_ret2,
            pos = UDim2.fromOffset(10, 4),
            sizeU = UDim2.new(1, -140, 0, 20)
        });
        label(Frame, {
            size = 12,
            text = "In " .. tostring(u122.p),
            color = Color3_fromRGB_ret5,
            pos = UDim2.fromOffset(10, 24),
            sizeU = UDim2.new(1, -140, 0, 16)
        });
        local v124 = button(Frame, "JOIN", UDim2.new(1, -120, 0, 8), UDim2.fromOffset(110, 28), function() -- Line: 523
            -- upvalues: RadioClient (ref), u122 (copy), u119 (copy)
            local v123 = RadioClient:Join(u122.from);

            if not v123.ok then
                u119.setStatus(u119.reasons[v123.reason] or u119.reasons.join_failed);
            end;
        end);
        v124.BackgroundColor3 = Color3_fromRGB_ret12;
        v124.BackgroundTransparency = 0.05;
        local _ = i;
    end;

    return 32;
end;

local function stepOf(p125) -- Line: 532
    -- upvalues: RadioRules (copy)
    local offer = p125.offer;

    return p125.posting and 2 or (offer.item and (RadioRules.ValidPrice(offer.pr) and 4 or 3) or 1);
end;

local function stepper(p126, p127) -- Line: 540
    -- upvalues: hrow (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret7 (copy), Font_new_ret (copy), Color3_fromRGB_ret4 (copy), label (copy)
    local v128 = hrow(p126, 26, 3, 6);
    v128.Position = UDim2.fromOffset(250, 5);
    v128.Size = UDim2.new(1, -290, 0, 26);

    for i, v in ipairs({ "Search Item", "Select Item", "Enter Price", "Post Listing" }) do
        local v129 = i == p127;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.fromOffset(20, 20);
        TextLabel.BackgroundColor3 = v129 and Color3_fromRGB_ret or (i < p127 and Color3_fromRGB_ret6 or Color3_fromRGB_ret7);
        TextLabel.BorderSizePixel = 0;
        TextLabel.FontFace = Font_new_ret;
        TextLabel.TextSize = 11;
        TextLabel.TextColor3 = v129 and Color3.fromRGB(30, 30, 30) or Color3_fromRGB_ret4;
        TextLabel.Text = tostring(i);
        TextLabel.LayoutOrder = i * 2 - 1;
        TextLabel.Parent = v128;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 10);
        UICorner.Parent = TextLabel;

        if v129 then
            label(v128, {
                size = 11,
                text = v,
                color = Color3_fromRGB_ret,
                sizeU = UDim2.fromOffset(#v * 7 + 8, 20),
                order = i * 2
            }).TextTruncate = Enum.TextTruncate.None;
        end;
    end;
end;

local function stepperBox(p130, p131, p132, p133, p134, u135, p136) -- Line: 566
    -- upvalues: Color3_fromRGB_ret11 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret5 (copy), button (copy)
    local TextBox = Instance.new("TextBox");
    TextBox.Name = "priceBox";
    TextBox.Position = UDim2.fromOffset(p131, p132);
    TextBox.Size = UDim2.fromOffset(p133 - 26, 30);
    TextBox.BackgroundColor3 = Color3_fromRGB_ret11;
    TextBox.BorderSizePixel = 0;
    TextBox.ClearTextOnFocus = false;
    TextBox.FontFace = Font_new_ret2;
    TextBox.TextSize = 14;
    TextBox.TextColor3 = p136 and Color3_fromRGB_ret3 or Color3_fromRGB_ret5;
    TextBox.PlaceholderColor3 = Color3_fromRGB_ret5;
    TextBox.TextXAlignment = Enum.TextXAlignment.Left;
    TextBox.TextEditable = p136;
    TextBox.Text = p134 and tostring(p134) or "";
    TextBox.Parent = p130;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 8);
    UIPadding.Parent = TextBox;
    TextBox.FocusLost:Connect(function() -- Line: 585
        -- upvalues: TextBox (copy), u135 (copy)
        local v137 = TextBox.Text:gsub("[^%d]", "");
        local v138 = tonumber(v137);

        if v138 then
            u135(v138, true);
        end;
    end);
    local v139 = button(p130, "▲", UDim2.fromOffset(p131 + p133 - 24, p132), UDim2.fromOffset(24, 15), function() -- Line: 589
        -- upvalues: u135 (copy)
        u135(1, false);
    end);
    local v140 = button(p130, "▼", UDim2.fromOffset(p131 + p133 - 24, p132 + 15), UDim2.fromOffset(24, 15), function() -- Line: 590
        -- upvalues: u135 (copy)
        u135(-1, false);
    end);
    v139.TextSize = 9;
    v140.TextSize = 9;
    v139.Active = p136;
    v140.Active = p136;

    return TextBox;
end;

local function renderFooter(u141) -- Line: 596
    -- upvalues: RadioConfig (copy), Color3_fromRGB_ret8 (copy), label (copy), Font_new_ret (copy), Color3_fromRGB_ret (copy), button (copy), Color3_fromRGB_ret4 (copy), u4 (copy), hrow (copy), stepper (copy), RadioRules (copy), Color3_fromRGB_ret11 (copy), itemIcon (copy), Font_new_ret2 (copy), Color3_fromRGB_ret5 (copy), stepperBox (copy), RadioClient (copy), Color3_fromRGB_ret12 (copy)
    local state = u141.state;
    local offer = state.offer;
    local Trade = RadioConfig.Trade;
    local footer = u141.footer;

    for _, child in ipairs(footer:GetChildren()) do
        child:Destroy();
    end;

    if not u141.allowed then
        return 0;
    end;

    footer.BackgroundColor3 = Color3_fromRGB_ret8;
    footer.BackgroundTransparency = 0.05;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 4);
    UICorner.Parent = footer;
    label(footer, {
        text = "CREATE OFFER",
        size = 17,
        font = Font_new_ret,
        color = Color3_fromRGB_ret,
        pos = UDim2.fromOffset(10, 6),
        sizeU = UDim2.fromOffset(140, 26)
    });

    if not state.offerOpen then
        for i, v in ipairs({ { "sell", "SELL" }, { "buy", "BUY" } }) do
            button(footer, v[2], UDim2.fromOffset(150 + (i - 1) * 76, 6), UDim2.fromOffset(70, 28), function() -- Line: 613
                -- upvalues: state (copy), v (copy), u141 (copy)
                state.offer = {
                    q = 1,
                    k = v[1]
                };
                state.offerOpen = true;
                u141.rerender();
            end).TextSize = 13;
        end;

        state.cdLabel = label(footer, {
            size = 12,
            color = Color3_fromRGB_ret4,
            align = Enum.TextXAlignment.Right,
            pos = UDim2.new(1, -170, 0, 12),
            sizeU = UDim2.fromOffset(160, 16)
        });
        state.postBtn = nil;
        u4.Tick(u141);

        return 40;
    end;

    button(footer, "X", UDim2.new(1, -34, 0, 6), UDim2.fromOffset(26, 24), function() -- Line: 626
        -- upvalues: state (copy), u141 (copy)
        state.offerOpen = false;
        state.posting = nil;
        u141.rerender();
    end);
    local v142 = hrow(footer, 24, 2, 2);
    v142.Position = UDim2.fromOffset(150, 5);
    v142.Size = UDim2.fromOffset(96, 24);

    for i, v in ipairs({ { "sell", "SELL" }, { "buy", "BUY" } }) do
        button(v142, v[2], UDim2.new(), UDim2.fromOffset(46, 22), function() -- Line: 636
            -- upvalues: offer (copy), v (copy), state (copy), u141 (copy)
            if offer.k ~= v[1] then
                state.offer = {
                    q = 1,
                    k = v[1]
                };
                state.posting = nil;
                u141.rerender();
            end;
        end, offer.k == v[1]).LayoutOrder = i;
    end;

    local offer2 = state.offer;
    stepper(footer, state.posting and 2 or (offer2.item and (RadioRules.ValidPrice(offer2.pr) and 4 or 3) or 1));
    local TextButton = Instance.new("TextButton");
    TextButton.Text = offer.item and "" or "?";
    TextButton.FontFace = Font_new_ret;
    TextButton.TextSize = 30;
    TextButton.TextColor3 = Color3_fromRGB_ret4;
    TextButton.Position = UDim2.fromOffset(10, 38);
    TextButton.Size = UDim2.fromOffset(70, 70);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret11;
    TextButton.BorderSizePixel = 0;
    TextButton.Parent = footer;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = state.posting and Color3_fromRGB_ret or Color3.fromRGB(90, 90, 90);
    UIStroke.Thickness = 1;
    UIStroke.Parent = TextButton;

    if offer.item then
        itemIcon(TextButton, offer.item, 62, UDim2.fromOffset(4, 4));
    end;

    TextButton.MouseButton1Click:Connect(function() -- Line: 662
        -- upvalues: state (copy), u141 (copy)
        state.posting = not state.posting;
        u141.search.Text = "";
        u141.rerender();
    end);
    label(footer, {
        size = 14,
        text = offer.item and ((offer.k == "buy" and offer.q > 1 and (offer.q .. "x " or "") or "") .. offer.n or "No item selected") or "No item selected",
        font = Font_new_ret2,
        pos = UDim2.fromOffset(88, 40),
        sizeU = UDim2.fromOffset(172, 20)
    });
    local v143 = offer.item and u4.VendorHint(offer.item, offer.d, offer.q);
    local v144;

    if offer.item then
        v144 = (offer.d and (offer.d .. "  ·  " or "") or "") .. (v143 and "Vendors pay about " .. RadioRules.FormatRoubles(v143) or "");
    else
        v144 = offer.k == "sell" and "Pick one of your items to sell." or "Pick the item you want to buy.";
    end;

    local v145 = label(footer, {
        size = 12,
        text = v144,
        color = Color3_fromRGB_ret4,
        pos = UDim2.fromOffset(88, 60),
        sizeU = UDim2.fromOffset(172, 44)
    });
    v145.TextWrapped = true;
    v145.TextYAlignment = Enum.TextYAlignment.Top;
    label(footer, {
        size = 11,
        text = offer.k == "sell" and "YOUR PRICE (₽)" or "YOUR OFFER (₽)",
        font = Font_new_ret2,
        color = Color3_fromRGB_ret5,
        pos = UDim2.fromOffset(268, 40),
        sizeU = UDim2.fromOffset(120, 16)
    });
    stepperBox(footer, 268, 58, 120, offer.pr, function(p146, p147) -- Line: 680
        -- upvalues: offer (copy), Trade (copy), u141 (copy)
        if not offer.item then
            return;
        end;

        local v148 = offer.pr or 0;
        local math_floor_ret = math.floor(p147 and p146 and p146 or v148 + p146 * (v148 < 1000 and 50 or (v148 < 10000 and 250 or (v148 < 100000 and 1000 or 5000))));
        offer.pr = math.clamp(math_floor_ret, Trade.PRICE_MIN, Trade.PRICE_MAX);
        u141.rerender();
    end, offer.item ~= nil).PlaceholderText = "Enter price...";
    label(footer, {
        text = "QUANTITY",
        size = 11,
        font = Font_new_ret2,
        color = Color3_fromRGB_ret5,
        pos = UDim2.fromOffset(396, 40),
        sizeU = UDim2.fromOffset(64, 16)
    });
    stepperBox(footer, 396, 58, 62, offer.q or 1, function(p149, p150) -- Line: 692
        -- upvalues: offer (copy), u141 (copy)
        if offer.k ~= "buy" then
            return;
        end;

        offer.q = math.clamp(p150 and p149 and p149 or (offer.q or 1) + p149, 1, 99);
        u141.rerender();
    end, offer.k == "buy");
    local v152 = button(footer, "POST LISTING", UDim2.new(1, -118, 0, 40), UDim2.fromOffset(108, 34), function() -- Line: 699
        -- upvalues: offer (copy), u141 (copy), RadioClient (ref), state (copy)
        if not offer.item then
            u141.setStatus("Pick an item first.");

            return;
        end;

        local v151 = RadioClient:Post({
            k = offer.k,
            ref = offer.ref,
            item = offer.item,
            q = offer.q,
            pr = offer.pr
        });

        if v151.ok then
            state.offer = {
                q = 1,
                k = offer.k
            };
            state.offerOpen = false;
            state.filter = "mine";
            u141.setStatus("Listing posted.");
        else
            u141.setStatus(u141.reasonText(v151));
        end;

        u141.rerender();
    end);
    v152.BackgroundColor3 = Color3_fromRGB_ret12;
    v152.BackgroundTransparency = 0.05;
    state.postBtn = v152;
    state.postBtn.TextSize = 12;
    state.cdLabel = label(footer, {
        size = 11,
        color = Color3_fromRGB_ret4,
        align = Enum.TextXAlignment.Center,
        pos = UDim2.new(1, -118, 0, 78),
        sizeU = UDim2.fromOffset(108, 16)
    });
    u4.Tick(u141);

    return 118;
end;

function u4.Tick(p153) -- Line: 723
    -- upvalues: RadioClient (copy), RadioRules (copy), RadioConfig (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret3 (copy)
    local state = p153.state;
    local cdLabel = state.cdLabel;
    local postBtn = state.postBtn;

    if not (cdLabel and cdLabel.Parent) then
        return;
    end;

    local v154 = RadioClient:CooldownLeft();

    if v154 > 0 then
        cdLabel.Text = ("Cooldown: %d:%02d"):format(v154 // 60, v154 % 60);
    else
        cdLabel.Text = "Fee: " .. RadioRules.FormatRoubles(RadioConfig.Trade.FEE);
    end;

    if postBtn and postBtn.Parent then
        postBtn.TextColor3 = v154 > 0 and Color3_fromRGB_ret5 or Color3_fromRGB_ret3;
    end;
end;

function u4.Render(p155) -- Line: 740
    -- upvalues: renderNotices (copy), renderFooter (copy), topBar (copy), renderPicker (copy), header (copy), sortedBoard (copy), label (copy), Color3_fromRGB_ret5 (copy), buildRow (copy)
    local state = p155.state;
    state.offer = state.offer or {
        k = "sell",
        q = 1
    };
    state.category = state.category or "all";
    local v156 = state.sortDir or "desc";
    state.sortBy = state.sortBy or "time";
    state.sortDir = v156;
    p155.search.Visible = false;
    p155.search.Parent = p155.bar;

    for _, child in ipairs(p155.bar:GetChildren()) do
        if child ~= p155.search and not child:IsA("UIListLayout") then
            child:Destroy();
        end;
    end;

    state.postBtn = nil;
    state.cdLabel = nil;

    if state.noticesOpen then
        return renderNotices(p155), renderFooter(p155);
    end;

    local v157;

    if state.posting then
        v157 = topBar(p155, "Search the catalogue...");
        renderPicker(p155);
    else
        local v158 = topBar(p155, "Search listings...");
        header(p155.bar, state, p155);
        v157 = v158 + 26;
        local v159 = sortedBoard(state, string.lower(p155.search.Text));

        if #v159 == 0 then
            label(p155.feed, {
                size = 15,
                text = state.filter == "mine" and "You have no listings." or "No listings match.",
                color = Color3_fromRGB_ret5,
                align = Enum.TextXAlignment.Center,
                sizeU = UDim2.new(1, 0, 0, 50)
            });
        end;

        for i, v in ipairs(v159) do
            buildRow(p155.feed, v, i, p155);
        end;
    end;

    return v157, renderFooter(p155);
end;

return u4;