-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local u1 = {};
local u2 = {
    Primary = "PRIMARY",
    Secondary = "SECONDARY",
    Sidearm = "SIDEARM",
    Melee = "MELEE",
    Head = "HEAD",
    FaceWear = "FACE",
    EyeWear = "EYES",
    NightOptical = "NIGHT VISION",
    Body = "BODY",
    BeltGear = "BELT",
    Backpack = "BACKPACK"
};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = {};
local u12 = {};
local u13 = {};
local u14 = false;
local u15 = 0;
local u16 = {};

local function money(p17) -- Line: 35
    local v18 = tonumber(p17) or 0;
    local math_floor_ret = math.floor(v18);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " ₽";
end;

local function text(p19, p20) -- Line: 41
    -- upvalues: u3 (ref)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = p20.font or Enum.Font.RobotoCondensed;
    TextLabel.TextColor3 = p20.color or u3.text;
    TextLabel.TextSize = p20.size or 18;
    TextLabel.TextXAlignment = p20.align or Enum.TextXAlignment.Left;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.TextWrapped = p20.wrap or false;
    TextLabel.Text = p20.text or "";
    TextLabel.Size = p20.sz or UDim2.new(1, 0, 0, (p20.size or 18) + 8);
    TextLabel.Position = p20.pos or UDim2.new();
    TextLabel.AnchorPoint = p20.anchor or Vector2.zero;
    TextLabel.LayoutOrder = p20.order or 0;
    TextLabel.ZIndex = 3;
    TextLabel.Parent = p19;

    return TextLabel;
end;

local function fireChanged() -- Line: 60
    -- upvalues: u16 (copy)
    for _, v in ipairs(u16) do
        task.spawn(v);
    end;
end;

local function itemsByKey() -- Line: 64
    -- upvalues: u10 (ref)
    local v21 = {};

    for _, v in ipairs(u10 and u10.items or {}) do
        v21[v.key] = v;
    end;

    return v21;
end;

function u1.Total() -- Line: 70
    -- upvalues: itemsByKey (copy), u11 (ref)
    local v22 = itemsByKey();
    local v23 = 0;

    for i in pairs(u11) do
        v23 = v23 + (v22[i] and (v22[i].fee or 0) or 0);
    end;

    return v23;
end;

function u1.PurchasePending() -- Line: 78
    -- upvalues: u15 (ref)
    return os.clock() < u15;
end;

function u1.HasSelection() -- Line: 82
    -- upvalues: u10 (ref), u11 (ref)
    local v24;

    if u10 == nil then
        v24 = false;
    else
        v24 = next(u11) ~= nil;
    end;

    return v24;
end;

local function paint() -- Line: 86
    -- upvalues: itemsByKey (copy), u13 (ref), u12 (ref), u11 (ref), u3 (ref), money (copy), u7 (ref), u1 (copy), u9 (ref), u10 (ref)
    local v25 = itemsByKey();

    for i, v in pairs(u13) do
        local v26 = u12[i];
        local v27 = u11[i];
        v.check.Text = v26 and "[+]" or (v27 and "[X]" or "[ ]");
        v.check.TextColor3 = v26 and u3.money or (v27 and u3.paper or u3.dim);
        v.fee.Text = v26 and "RECOVERED" or money(v25[i].fee);
        v.fee.TextColor3 = v26 and u3.money or u3.paper;
        v.frame.BackgroundColor3 = v27 and u3.hover or u3.row;
    end;

    if u7 then
        u7.Text = "SELECTED COVERAGE: " .. money(u1.Total());
    end;

    if u9 and u10 then
        local v28 = false;

        for _, v in ipairs(u10.items) do
            if not u12[v.key] then
                v28 = true;
                break;
            end;
        end;

        if v28 then
            v28 = (u10.productId or 0) ~= 0;
        end;

        u9.Visible = v28;
        u9.Text = (tonumber(u10.credits) or 0) > 0 and "FREE: INSURE ALL EQUIPPED (" .. tostring(u10.credits) .. ")" or "INSURE ALL EQUIPPED (ROBUX)";
    end;
end;

function u1.ShowError(p29) -- Line: 108
    -- upvalues: u8 (ref), u3 (ref)
    if u8 then
        u8.Text = tostring(p29 or "");
        u8.TextColor3 = u3.blood;
    end;
end;

local function markRecovered(p30) -- Line: 115
    -- upvalues: u12 (ref), u11 (ref), paint (copy), u16 (copy)
    for _, v in ipairs(p30 or {}) do
        u12[v] = true;
        u11[v] = nil;
    end;

    paint();

    for _, v in ipairs(u16) do
        task.spawn(v);
    end;
end;

function u1.Commit() -- Line: 121
    -- upvalues: u10 (ref), u14 (ref), u11 (ref), ReplicatedStorage (copy), markRecovered (copy)
    if not u10 or u14 then
        return false, "Busy.";
    end;

    local u31 = {};

    for i in pairs(u11) do
        table.insert(u31, i);
    end;

    u14 = true;
    local InsuranceCommit = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("InsuranceCommit");
    local success, result = pcall(function() -- Line: 127
        -- upvalues: InsuranceCommit (copy), u10 (ref), u31 (copy)
        local v32 = InsuranceCommit and InsuranceCommit:InvokeServer(u10.deathId, u31);

        return v32;
    end);
    u14 = false;

    if not (success and (type(result) == "table" and result.ok)) then
        return false, success and type(result) == "table" and (result.err or "No answer from the server.") or "No answer from the server.";
    end;

    markRecovered(u31);

    return true;
end;

function u1.Build(p33, p34, p35) -- Line: 136
    -- upvalues: u3 (ref), u4 (ref), u5 (ref), text (copy), u6 (ref), u7 (ref), money (copy), u8 (ref), u9 (ref), u10 (ref), u14 (ref), ReplicatedStorage (copy), u1 (copy), MarketplaceService (copy), Players (copy), u15 (ref), paint (copy), markRecovered (copy)
    u3 = p35.C;
    u4 = p35.OSWALD;
    u5 = Instance.new("Frame");
    u5.Name = "InsuranceContract";
    u5.BackgroundTransparency = 1;
    u5.Size = UDim2.new(1, -8, 0, 0);
    u5.AutomaticSize = Enum.AutomaticSize.Y;
    u5.LayoutOrder = -100;
    u5.Visible = false;
    u5.Parent = p33;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Padding = UDim.new(0, 4);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = u5;
    text(u5, {
        text = "GEAR RECOVERY CONTRACT",
        size = 26,
        order = 1,
        font = u4,
        color = u3.paper
    });
    text(u5, {
        text = "Equipped gear only. Items stored inside containers stay on the body.",
        size = 17,
        order = 2,
        color = u3.dim
    });
    u6 = Instance.new("Frame");
    u6.Name = "Rows";
    u6.BackgroundTransparency = 1;
    u6.Size = UDim2.new(1, 0, 0, 0);
    u6.AutomaticSize = Enum.AutomaticSize.Y;
    u6.LayoutOrder = 3;
    u6.Parent = u5;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.Padding = UDim.new(0, 3);
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.Parent = u6;
    u7 = text(u5, {
        size = 22,
        order = 4,
        text = "SELECTED COVERAGE: " .. money(0),
        font = u4,
        color = u3.money,
        align = Enum.TextXAlignment.Right
    });
    u8 = text(u5, {
        text = "",
        size = 17,
        order = 5,
        color = u3.blood
    });
    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = u3.line;
    Frame.BorderSizePixel = 0;
    Frame.Size = UDim2.new(1, 0, 0, 1);
    Frame.LayoutOrder = 6;
    Frame.Parent = u5;
    u9 = Instance.new("TextButton");
    u9.Name = "FullCoverage";
    u9.Size = UDim2.fromOffset(300, 72);
    u9.Position = UDim2.fromOffset(226, 863);
    u9.BackgroundColor3 = Color3.fromRGB(35, 33, 30);
    u9.BorderSizePixel = 0;
    u9.Font = u4;
    u9.TextSize = 24;
    u9.TextColor3 = u3.money;
    u9.AutoButtonColor = true;
    u9.Visible = false;
    u9.ZIndex = 3;
    u9.Parent = p34;
    Instance.new("UICorner", u9).CornerRadius = UDim.new(0, 3);
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = u3.amber;
    UIStroke.Thickness = 2;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    UIStroke.Parent = u9;
    u9.MouseButton1Click:Connect(function() -- Line: 192
        -- upvalues: u10 (ref), u14 (ref), ReplicatedStorage (ref), u1 (ref), MarketplaceService (ref), Players (ref)
        if not u10 or u14 then
            return;
        end;

        if (tonumber(u10.credits) or 0) > 0 then
            u14 = true;
            local InsuranceCommit = ReplicatedStorage:WaitForChild("Remotes"):FindFirstChild("InsuranceCommit");
            local success, result = pcall(function() -- Line: 197
                -- upvalues: InsuranceCommit (copy), u10 (ref)
                local v36 = InsuranceCommit and InsuranceCommit:InvokeServer(u10.deathId, "credit");

                return v36;
            end);
            u14 = false;

            if not (success and (type(result) == "table" and result.ok)) then
                u1.ShowError(success and type(result) == "table" and (result.err or "No answer from the server.") or "No answer from the server.");
            end;
        else
            MarketplaceService:PromptProductPurchase(Players.LocalPlayer, u10.productId);
        end;
    end);
    MarketplaceService.PromptProductPurchaseFinished:Connect(function(p37, p38, p39) -- Line: 209
        -- upvalues: Players (ref), u10 (ref), u15 (ref), u8 (ref), u3 (ref)
        if p37 == Players.LocalPlayer.UserId and (u10 and (p38 == u10.productId and p39)) then
            u15 = os.clock() + 15;

            if u8 then
                u8.Text = "Purchase received. Recovering your gear...";
                u8.TextColor3 = u3.money;
            end;
        end;
    end);
    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("InsuranceResult").OnClientEvent:Connect(function(p40) -- Line: 220
        -- upvalues: u15 (ref), u10 (ref), u8 (ref), u3 (ref), paint (ref), markRecovered (ref)
        if type(p40) ~= "table" then
            return;
        end;

        u15 = 0;

        if not p40.credit then
            if u10 and p40.deathId == u10.deathId then
                markRecovered(p40.recovered);
            end;

            return;
        end;

        if u10 then
            u10.credits = p40.credits;
        end;

        if u8 then
            u8.Text = "Purchase saved as free coverage for your next death.";
            u8.TextColor3 = u3.money;
        end;

        paint();
    end);

    if u10 then
        u1.SetOffer(u10);
    end;
end;

function u1.SetOffer(p41) -- Line: 241
    -- upvalues: u13 (ref), u11 (ref), u12 (ref), u10 (ref), u15 (ref), u8 (ref), u5 (ref), u9 (ref), u16 (copy), ItemDatabase (copy), u3 (ref), u6 (ref), text (copy), u4 (ref), u2 (copy), money (copy), u14 (ref), paint (copy)
    for _, v in pairs(u13) do
        v.frame:Destroy();
    end;

    u13 = {};
    u11 = {};
    u12 = {};

    if type(p41) ~= "table" or (type(p41.items) ~= "table" or (#p41.items <= 0 or not p41)) then
        p41 = nil;
    end;

    u10 = p41;
    u15 = 0;

    if u8 then
        u8.Text = "";
    end;

    if not u5 then
        return;
    end;

    u5.Visible = u10 ~= nil;

    if not u10 then
        if u9 then
            u9.Visible = false;
        end;

        for _, v in ipairs(u16) do
            task.spawn(v);
        end;

        return;
    end;

    for i, v in ipairs(u10.items) do
        local ItemData = ItemDatabase.GetItemData(v.id);
        local TextButton = Instance.new("TextButton");
        TextButton.Name = "Row_" .. v.key;
        TextButton.AutoButtonColor = false;
        TextButton.Text = "";
        TextButton.BackgroundColor3 = u3.row;
        TextButton.BorderSizePixel = 0;
        TextButton.Size = UDim2.new(1, 0, 0, 40);
        TextButton.LayoutOrder = i;
        TextButton.ZIndex = 2;
        TextButton.Parent = u6;
        local v42 = text(TextButton, {
            text = "[ ]",
            size = 22,
            font = u4,
            pos = UDim2.fromOffset(10, 0),
            sz = UDim2.new(0, 40, 1, 0)
        });
        text(TextButton, {
            size = 15,
            text = u2[v.slot] or v.slot,
            color = u3.dim,
            pos = UDim2.fromOffset(54, 0),
            sz = UDim2.new(0, 110, 1, 0)
        });
        text(TextButton, {
            size = 19,
            text = ItemData and ItemData.Name or v.id,
            color = u3.paper,
            pos = UDim2.fromOffset(166, 0),
            sz = UDim2.new(1, -330, 1, 0)
        });
        local v43 = text(TextButton, {
            size = 20,
            text = money(v.fee),
            font = u4,
            align = Enum.TextXAlignment.Right,
            pos = UDim2.new(1, -12, 0, 0),
            anchor = Vector2.new(1, 0),
            sz = UDim2.new(0, 150, 1, 0)
        });
        u13[v.key] = {
            frame = TextButton,
            check = v42,
            fee = v43
        };
        TextButton.MouseButton1Click:Connect(function() -- Line: 275
            -- upvalues: u14 (ref), u12 (ref), v (copy), u11 (ref), u8 (ref), paint (ref), u16 (ref)
            if u14 or u12[v.key] then
                return;
            end;

            u11[v.key] = not u11[v.key] or nil;

            if u8 then
                u8.Text = "";
            end;

            paint();

            for _, v2 in ipairs(u16) do
                task.spawn(v2);
            end;
        end);
    end;

    paint();

    for _, v in ipairs(u16) do
        task.spawn(v);
    end;
end;

function u1.OnChanged(p44) -- Line: 287
    -- upvalues: u16 (copy)
    table.insert(u16, p44);
end;

function u1.Clear() -- Line: 289
    -- upvalues: u1 (copy)
    u1.SetOffer(nil);
end;

return u1;