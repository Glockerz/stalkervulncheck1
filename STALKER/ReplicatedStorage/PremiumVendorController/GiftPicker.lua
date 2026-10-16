-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = nil;

function u1.IsOpen() -- Line: 26
    -- upvalues: u2 (ref)
    return u2 ~= nil;
end;

function u1.Close() -- Line: 30
    -- upvalues: u2 (ref)
    if not u2 then
        return;
    end;

    for _, v in ipairs(u2.conns) do
        v:Disconnect();
    end;

    if u2.frame then
        u2.frame:Destroy();
    end;

    u2 = nil;
end;

local function rebuild(u3) -- Line: 37
    -- upvalues: u2 (ref), Players (copy), LocalPlayer (copy), ReplicatedStorage (copy), u1 (copy)
    if not u2 then
        return;
    end;

    local function raiseRows() -- Line: 39
        -- upvalues: u2 (ref)
        for _, descendant in ipairs(u2.list:GetDescendants()) do
            if descendant:IsA("GuiObject") then
                descendant.ZIndex = 52;
            end;
        end;
    end;

    for _, child in ipairs(u2.list:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy();
        end;
    end;

    local v4 = {};

    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            table.insert(v4, v);
        end;
    end;

    table.sort(v4, function(p5, p6) -- Line: 51
        return p5.DisplayName:lower() < p6.DisplayName:lower();
    end);

    if #v4 == 0 then
        u3.label(u2.list, "No one else is in this server.", {
            Size = UDim2.new(1, 0, 0, 44),
            TextColor3 = u3.DIM,
            TextXAlignment = Enum.TextXAlignment.Center
        });
        raiseRows();

        return;
    end;

    for i, v in ipairs(v4) do
        local v7 = u2.marks[tostring(v.UserId)];
        local v8 = u3.make("TextButton", {
            BorderSizePixel = 0,
            Text = "",
            Name = "Row_" .. v.UserId,
            LayoutOrder = i,
            Size = UDim2.new(1, 0, 0, 44),
            BackgroundColor3 = u3.BOX,
            AutoButtonColor = v7 == nil
        }, u2.list);
        u3.outline(v8);
        u3.label(v8, v.DisplayName, {
            TextSize = 14,
            Position = UDim2.fromOffset(12, 4),
            Size = UDim2.new(1, -130, 0, 20),
            FontFace = u3.FONT_BOLD,
            TextColor3 = v7 and u3.DIM or u3.TEXT
        });
        u3.label(v8, "@" .. v.Name, {
            TextSize = 12,
            Position = UDim2.fromOffset(12, 22),
            Size = UDim2.new(1, -130, 0, 16),
            TextColor3 = u3.DIM
        });
        u3.label(v8, v7 or "GIFT", {
            TextSize = 13,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -12, 0, 0),
            Size = UDim2.fromOffset(100, 44),
            FontFace = u3.FONT_BOLD,
            TextXAlignment = Enum.TextXAlignment.Right,
            TextColor3 = v7 and u3.GREEN or u3.GOLD
        });

        if not v7 then
            local UserId = v.UserId;
            v8.Activated:Connect(function() -- Line: 73
                -- upvalues: u2 (ref), u3 (copy), ReplicatedStorage (ref), UserId (copy), u1 (ref)
                if not u2 or u2.busy then
                    return;
                end;

                u2.busy = true;
                local status = u2.status;
                local DIM = u3.DIM;
                u2.status.Text = "Opening the purchase...";
                status.TextColor3 = DIM;
                local Gift_Request = ReplicatedStorage.Remotes:FindFirstChild("Gift_Request");
                local v9, v10, v11 = pcall(function() -- Line: 78
                    -- upvalues: Gift_Request (copy), u2 (ref), UserId (ref)
                    return Gift_Request:InvokeServer(u2.product.id, UserId);
                end);

                if not u2 then
                    return;
                end;

                u2.busy = false;

                if v9 and v10 then
                    u1.Close();

                    return;
                end;

                u2.status.Text = v9 and v11 and v11 or "Gift service unavailable, try again.";
                u2.status.TextColor3 = u3.GOLD;
            end);
        end;
    end;

    raiseRows();
end;

function u1.Open(p12, u13, u14) -- Line: 93
    -- upvalues: u1 (copy), u2 (ref), Players (copy), rebuild (copy), ReplicatedStorage (copy)
    u1.Close();
    local v15 = u14.make("Frame", {
        Name = "GiftPicker",
        BorderSizePixel = 0,
        ZIndex = 50,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(420, 420),
        BackgroundColor3 = u14.PANEL
    }, p12);
    u14.outline(v15, u14.GOLD);
    local v16 = u14.gradientBar(v15, "GIFT TO", {
        Size = UDim2.new(1, 0, 0, 36)
    });
    local v17 = u14.make("TextButton", {
        BorderSizePixel = 0,
        Text = "Q  BACK",
        TextSize = 12,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        Size = UDim2.fromOffset(90, 24),
        BackgroundColor3 = u14.BOX,
        FontFace = u14.FONT_BOLD,
        TextColor3 = u14.DIM
    }, v16);
    u14.outline(v17);
    u14.label(v15, string.upper(u13.name or ""), {
        TextSize = 14,
        Position = UDim2.fromOffset(12, 42),
        Size = UDim2.new(1, -24, 0, 20),
        FontFace = u14.FONT_BOLD,
        TextColor3 = u14.GOLD
    });
    local v18 = u14.make("ScrollingFrame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        Position = UDim2.fromOffset(12, 68),
        Size = UDim2.new(1, -24, 1, -112),
        ScrollBarImageColor3 = u14.STROKE,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    }, v15);
    u14.make("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    }, v18);
    local v19 = u14.label(v15, "Pick who receives it. They must be in this server.", {
        TextWrapped = true,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 12, 1, -10),
        Size = UDim2.new(1, -24, 0, 28),
        TextColor3 = u14.DIM,
        TextTruncate = Enum.TextTruncate.None
    });

    for _, descendant in ipairs(v15:GetDescendants()) do
        if descendant:IsA("GuiObject") then
            descendant.ZIndex = 51;
        end;
    end;

    u2 = {
        busy = false,
        frame = v15,
        list = v18,
        status = v19,
        product = u13,
        conns = {},
        marks = {}
    };
    v17.Activated:Connect(u1.Close);
    table.insert(u2.conns, Players.PlayerAdded:Connect(function() -- Line: 122
        -- upvalues: rebuild (ref), u14 (copy)
        rebuild(u14);
    end));
    table.insert(u2.conns, Players.PlayerRemoving:Connect(function() -- Line: 123
        -- upvalues: rebuild (ref), u14 (copy)
        task.defer(rebuild, u14);
    end));
    rebuild(u14);
    task.spawn(function() -- Line: 125
        -- upvalues: ReplicatedStorage (ref), u13 (copy), u2 (ref), rebuild (ref), u14 (copy)
        local Gift_Check = ReplicatedStorage.Remotes:FindFirstChild("Gift_Check");
        local success, result = pcall(function() -- Line: 127
            -- upvalues: Gift_Check (copy), u13 (ref)
            local v20 = Gift_Check and Gift_Check:InvokeServer(u13.id);

            return v20;
        end);

        if u2 and (u2.product == u13 and (success and type(result) == "table")) then
            u2.marks = result;
            rebuild(u14);
        end;
    end);
end;

return u1;