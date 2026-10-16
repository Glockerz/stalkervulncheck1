-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local TextChatService = game:GetService("TextChatService");
local RadioRules = require(ReplicatedStorage:WaitForChild("RadioRules"));
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(215, 175, 75);
local u1 = {};
local u2 = false;
local u3 = nil;
local u4 = nil;
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = 0;
local u10 = {};
local u11 = {};
local u12 = (-1 / 0);
local u13 = {};
local u14 = {};

local function changed() -- Line: 42
    -- upvalues: u13 (copy)
    for _, v in ipairs(u13) do
        task.spawn(v);
    end;
end;

local function push(p15, p16) -- Line: 43
    table.insert(p15, p16);

    while #p15 > 100 do
        table.remove(p15, 1);
    end;
end;

local function mutes() -- Line: 44
    -- upvalues: u4 (ref)
    return u4 and u4.mutes;
end;

local function refreshBlocked() -- Line: 46
    -- upvalues: StarterGui (copy), u10 (ref)
    local success, result = pcall(function() -- Line: 47
        -- upvalues: StarterGui (ref)
        return StarterGui:GetCore("GetBlockedUserIds");
    end);

    if success and type(result) == "table" then
        local v17 = {};

        for _, v in ipairs(result) do
            v17[v] = true;
        end;

        u10 = v17;
    end;
end;

local function tradeLine(p18) -- Line: 57
    -- upvalues: push (copy), u5 (copy)
    push(u5, {
        u = 0,
        dn = "[TRADE]",
        sys = true,
        t = p18,
        ts = os.time()
    });
end;

local u19 = {};
local u20 = {};
local u21 = false;

function u1._noteNewListings(p22) -- Line: 64
    -- upvalues: u19 (copy), u21 (ref), LocalPlayer (copy), u20 (ref)
    for _, v in ipairs(p22) do
        if type(v) == "table" and (v.id and not u19[v.id]) then
            u19[v.id] = true;

            if u21 and v.u ~= LocalPlayer.UserId then
                table.insert(u20, v);
            end;
        end;
    end;

    if not u21 then
        u21 = true;
    end;
end;

function u1._postSummary() -- Line: 73
    -- upvalues: u20 (ref), u4 (ref), RadioRules (copy), push (copy), u5 (copy), u13 (copy)
    if #u20 == 0 then
        return;
    end;

    local v23 = u4 and u4.mutes;
    local v24 = u20;
    u20 = {};

    if v23 and v23.channels and v23.channels.trade_summary == true then
        return;
    end;

    local v25 = {};

    for i = 1, math.min(#v24, 3) do
        table.insert(v25, RadioRules.ListingLine(v24[i]));
        local _ = i;
    end;

    local v26 = "New on the board: " .. table.concat(v25, ", ");

    if #v24 > 3 then
        v26 = v26 .. (" (+%d more)"):format(#v24 - 3);
    end;

    push(u5, {
        u = 0,
        dn = "[TRADE]",
        sys = true,
        t = v26,
        ts = os.time()
    });

    for _, v in ipairs(u13) do
        task.spawn(v);
    end;
end;

local function entryOf(p27) -- Line: 90
    -- upvalues: Players (copy)
    local v28 = p27.TextSource and (p27.TextSource.UserId or 0) or 0;
    local v29;

    if v28 == 0 then
        v29 = false;
    else
        v29 = Players:GetPlayerByUserId(v28);
    end;

    return {
        u = v28,
        dn = v29 and v29.DisplayName or "?",
        t = p27.Text,
        ts = os.time()
    };
end;

local function onChat(p30) -- Line: 96
    -- upvalues: entryOf (copy), RadioRules (copy), u10 (ref), u4 (ref), push (copy), u5 (copy), u13 (copy), LocalPlayer (copy), u8 (copy)
    local TextChannel = p30.TextChannel;

    if not TextChannel or p30.Status ~= Enum.TextChatMessageStatus.Success then
        return;
    end;

    if TextChannel.Name == "RBXGeneral" or TextChannel.Name == "RBXGeneralChannel" then
        local v31 = entryOf(p30);

        if v31.u ~= 0 then
            if RadioRules.ShouldShow(v31, u10, u4 and u4.mutes, "map") then
                push(u5, v31);

                for _, v in ipairs(u13) do
                    task.spawn(v);
                end;
            end;
        end;

        return;
    end;

    local v32, v33 = TextChannel.Name:match("^PdaDM_(%d+)_(%d+)$");

    if v32 then
        local v34 = tonumber(v32) == LocalPlayer.UserId and tonumber(v33) or tonumber(v32);
        local v35 = entryOf(p30);

        if RadioRules.ShouldShow(v35, u10, u4 and u4.mutes, "dm") then
            u8[v34] = u8[v34] or {};
            push(u8[v34], v35);

            for _, v in ipairs(u13) do
                task.spawn(v);
            end;
        end;
    end;
end;

function u1.Init(p36) -- Line: 116
    -- upvalues: u2 (ref), u3 (ref), ReplicatedStorage (copy), TextChatService (copy), onChat (copy), u4 (ref), u13 (copy), RadioRules (copy), u10 (ref), u6 (ref), u1 (copy), push (copy), u7 (copy), u5 (copy), Players (copy), refreshBlocked (copy)
    if u2 then
        return;
    end;

    u2 = true;
    u3 = ReplicatedStorage:WaitForChild("Remotes");
    TextChatService.MessageReceived:Connect(onChat);
    u3:WaitForChild("RadioState").OnClientEvent:Connect(function(p37) -- Line: 121
        -- upvalues: u4 (ref), u13 (ref)
        u4 = p37;

        for _, v in ipairs(u13) do
            task.spawn(v);
        end;
    end);
    u3:WaitForChild("TradeBoard").OnClientEvent:Connect(function(p38) -- Line: 122
        -- upvalues: RadioRules (ref), u10 (ref), u4 (ref), u6 (ref), u1 (ref), u13 (ref)
        local v39 = {};

        for _, v in ipairs(p38 or {}) do
            if RadioRules.ShouldShow(v, u10, u4 and u4.mutes, "trade") then
                table.insert(v39, v);
            end;
        end;

        u6 = v39;
        u1._noteNewListings(v39);

        for _, v in ipairs(u13) do
            task.spawn(v);
        end;
    end);
    task.spawn(function() -- Line: 131
        -- upvalues: u1 (ref)
        while true do
            task.wait(360);
            u1._postSummary();
        end;
    end);
    u3:WaitForChild("TradeNotice").OnClientEvent:Connect(function(p40) -- Line: 137
        -- upvalues: u10 (ref), push (ref), u7 (ref), u1 (ref), u5 (ref), u13 (ref), ReplicatedStorage (ref)
        if type(p40) == "table" and not u10[p40.from] then
            push(u7, p40);
            push(u5, {
                u = 0,
                dn = "[TRADE]",
                sys = true,
                t = u1.NoticeText(p40),
                ts = os.time()
            });

            for _, v in ipairs(u13) do
                task.spawn(v);
            end;

            local success, result = pcall(require, ReplicatedStorage:WaitForChild("ToastUI", 5));

            if success and result then
                result.Show(u1.NoticeText(p40), "info");
            end;
        end;
    end);
    task.spawn(function() -- Line: 149
        -- upvalues: u3 (ref), u1 (ref)
        local TradeHighlight = u3:WaitForChild("TradeHighlight", 30);

        if TradeHighlight then
            TradeHighlight.OnClientEvent:Connect(function(p41) -- Line: 152
                -- upvalues: u1 (ref)
                if type(p41) ~= "table" then
                    return;
                end;

                if type(p41.on) == "number" then
                    u1._setHighlight(p41.on);

                    return;
                end;

                if type(p41.off) == "number" then
                    u1._clearHighlight(p41.off);
                end;
            end);
        end;
    end);
    Players.PlayerRemoving:Connect(function(p42) -- Line: 159
        -- upvalues: u1 (ref)
        u1._clearHighlight(p42.UserId);
    end);
    refreshBlocked();
    task.spawn(function() -- Line: 161
        -- upvalues: refreshBlocked (ref)
        while true do
            task.wait(60);
            refreshBlocked();
        end;
    end);
    task.spawn(function() -- Line: 162
        -- upvalues: u3 (ref), u4 (ref), u13 (ref)
        local success, result = pcall(function() -- Line: 163
            -- upvalues: u3 (ref)
            return u3.RadioGetState:InvokeServer();
        end);

        if success and type(result) == "table" then
            u4 = result;

            for _, v in ipairs(u13) do
                task.spawn(v);
            end;
        end;
    end);
end;

function u1.GetState(p43) -- Line: 168
    -- upvalues: u4 (ref)
    return u4;
end;

function u1.MapMessages(p44) -- Line: 169
    -- upvalues: u5 (copy)
    return u5;
end;

function u1.Board(p45) -- Line: 170
    -- upvalues: u6 (ref)
    return u6;
end;

function u1.Notices(p46) -- Line: 171
    -- upvalues: u7 (copy)
    return u7;
end;

function u1.NoticeText(p47) -- Line: 174
    if p47.waiting then
        return ("%s is waiting for you in the Lobby for your trade offer (%s)"):format(tostring(p47.dn), (tostring(p47.n)));
    end;

    return ("%s inquired about your %s"):format(tostring(p47.dn), (tostring(p47.n)));
end;

local u48 = {};

function u1._clearHighlight(p49) -- Line: 183
    -- upvalues: u48 (copy)
    local v50 = u48[p49];

    if not v50 then
        return;
    end;

    u48[p49] = nil;

    if v50.conn then
        v50.conn:Disconnect();
    end;

    if v50.hl then
        v50.hl:Destroy();
    end;
end;

function u1._setHighlight(u51) -- Line: 190
    -- upvalues: u1 (copy), Players (copy), Color3_fromRGB_ret (copy), u48 (copy)
    u1._clearHighlight(u51);
    local PlayerByUserId = Players:GetPlayerByUserId(u51);

    if not PlayerByUserId then
        return;
    end;

    local u52 = {};

    local function attach(p53) -- Line: 195
        -- upvalues: u52 (copy), Color3_fromRGB_ret (ref)
        if u52.hl then
            u52.hl:Destroy();
        end;

        local Highlight = Instance.new("Highlight");
        Highlight.Name = "TradePartnerHighlight";
        Highlight.FillTransparency = 1;
        Highlight.OutlineColor = Color3_fromRGB_ret;
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.Adornee = p53;
        Highlight.Parent = p53;
        u52.hl = Highlight;
    end;

    if PlayerByUserId.Character then
        local Character = PlayerByUserId.Character;

        if u52.hl then
            u52.hl:Destroy();
        end;

        local Highlight = Instance.new("Highlight");
        Highlight.Name = "TradePartnerHighlight";
        Highlight.FillTransparency = 1;
        Highlight.OutlineColor = Color3_fromRGB_ret;
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.Adornee = Character;
        Highlight.Parent = Character;
        u52.hl = Highlight;
    end;

    u52.conn = PlayerByUserId.CharacterAdded:Connect(attach);
    u48[u51] = u52;
    task.delay(600, function() -- Line: 209
        -- upvalues: u48 (ref), u51 (copy), u52 (copy), u1 (ref)
        if u48[u51] == u52 then
            u1._clearHighlight(u51);
        end;
    end);
end;

function u1.Thread(p54, p55) -- Line: 213
    -- upvalues: u8 (copy)
    return u8[p55] or {};
end;

function u1.CooldownLeft(p56) -- Line: 214
    -- upvalues: u9 (ref)
    local v57 = u9 - os.time();

    return math.max(0, v57);
end;

local function general() -- Line: 216
    -- upvalues: TextChatService (copy)
    local TextChannels = TextChatService:FindFirstChild("TextChannels");

    if TextChannels then
        TextChannels = TextChannels:FindFirstChild("RBXGeneralChannel") or TextChannels:FindFirstChild("RBXGeneral");
    end;

    return TextChannels;
end;

function u1.SendMap(p58, u59) -- Line: 221
    -- upvalues: TextChatService (copy)
    local TextChannels = TextChatService:FindFirstChild("TextChannels");

    if TextChannels then
        TextChannels = TextChannels:FindFirstChild("RBXGeneralChannel") or TextChannels:FindFirstChild("RBXGeneral");
    end;

    if TextChannels and u59 ~= "" then
        return pcall(function() -- Line: 224
            -- upvalues: TextChannels (copy), u59 (copy)
            TextChannels:SendAsync(u59);
        end);
    end;

    return false;
end;

local function invoke(u60, ...) -- Line: 227
    -- upvalues: u3 (ref)
    local table_pack_ret = table.pack(...);
    local success, result = pcall(function() -- Line: 229
        -- upvalues: u3 (ref), u60 (copy), table_pack_ret (copy)
        return u3[u60]:InvokeServer(table.unpack(table_pack_ret, 1, table_pack_ret.n));
    end);

    return (not success or type(result) ~= "table") and {
        ok = false,
        reason = "try_later"
    } or result;
end;

function u1.OpenDM(p61, p62) -- Line: 234
    -- upvalues: invoke (copy)
    return invoke("RadioOpenDM", p62);
end;

function u1.SendDM(p63, p64, u65) -- Line: 236
    -- upvalues: TextChatService (copy)
    if u65 == "" then
        return {
            ok = false,
            reason = "try_later"
        };
    end;

    local v66 = p63:OpenDM(p64);

    if not v66.ok then
        return v66;
    end;

    local u67 = TextChatService.TextChannels:FindFirstChild(v66.channel);

    if not u67 then
        return {
            ok = false,
            reason = "try_later"
        };
    end;

    local success = pcall(function() -- Line: 242
        -- upvalues: u67 (copy), u65 (copy)
        u67:SendAsync(u65);
    end);

    return {
        ok = success,
        reason = not success and "try_later" or nil
    };
end;

function u1.Post(p68, p69) -- Line: 246
    -- upvalues: invoke (copy), u9 (ref), u13 (copy)
    local v70 = invoke("TradePost", p69);

    if v70.cooldownUntil then
        u9 = v70.cooldownUntil;
    end;

    for _, v in ipairs(u13) do
        task.spawn(v);
    end;

    return v70;
end;

function u1.Cancel(p71, p72) -- Line: 252
    -- upvalues: invoke (copy)
    return invoke("TradeCancel", p72);
end;

local u73 = {};

function u1.Interested(p74, p75) -- Line: 256
    -- upvalues: invoke (copy), u73 (copy)
    local v76 = invoke("TradeInterested", p75);

    if v76.ok or v76.reason == "already" then
        u73[p75] = true;
    end;

    return v76;
end;

function u1.SentInterest(p77, p78) -- Line: 261
    -- upvalues: u73 (copy)
    return u73[p78] == true;
end;

function u1.Join(p79, p80) -- Line: 262
    -- upvalues: invoke (copy)
    return invoke("TradeJoin", p80);
end;

function u1.MyItems(p81) -- Line: 264
    -- upvalues: u3 (ref)
    local success, result = pcall(function() -- Line: 265
        -- upvalues: u3 (ref)
        return u3.TradeMyItems:InvokeServer();
    end);

    return not (success and (type(result) == "table" and result)) and {} or result;
end;

function u1.Catalog(p82) -- Line: 268
    -- upvalues: u3 (ref)
    local success, result = pcall(function() -- Line: 269
        -- upvalues: u3 (ref)
        return u3.TradeCatalog:InvokeServer();
    end);

    return not (success and (type(result) == "table" and result)) and {} or result;
end;

function u1.SetMute(p83, p84, p85, p86) -- Line: 273
    -- upvalues: invoke (copy), u4 (ref), u13 (copy)
    local v87 = invoke("RadioSetMute", p84, p85, p86);

    if v87.ok and u4 then
        u4.mutes = v87.mutes or u4.mutes;

        for _, v in ipairs(u13) do
            task.spawn(v);
        end;
    end;

    return v87.ok == true;
end;

function u1.ContactsOnline(p88) -- Line: 279
    -- upvalues: u12 (ref), u3 (ref), u11 (ref), u13 (copy)
    if os.clock() - u12 >= 15 then
        u12 = os.clock();
        task.spawn(function() -- Line: 282
            -- upvalues: u3 (ref), u11 (ref), u13 (ref)
            local success, result = pcall(function() -- Line: 283
                -- upvalues: u3 (ref)
                return u3.RadioContactsOnline:InvokeServer();
            end);

            if success and type(result) == "table" then
                u11 = result;

                for _, v in ipairs(u13) do
                    task.spawn(v);
                end;
            end;
        end);
    end;

    return u11;
end;

function u1.OnChanged(p89, u90) -- Line: 290
    -- upvalues: u13 (copy)
    table.insert(u13, u90);

    return function() -- Line: 292
        -- upvalues: u13 (ref), u90 (copy)
        local table_find_ret = table.find(u13, u90);

        if table_find_ret then
            table.remove(u13, table_find_ret);
        end;
    end;
end;

function u1.FocusDM(p91, p92) -- Line: 294
    -- upvalues: u14 (copy)
    for _, v in ipairs(u14) do
        task.spawn(v, p92);
    end;
end;

function u1.OnFocusDM(p93, u94) -- Line: 295
    -- upvalues: u14 (copy)
    table.insert(u14, u94);

    return function() -- Line: 297
        -- upvalues: u14 (ref), u94 (copy)
        local table_find_ret = table.find(u14, u94);

        if table_find_ret then
            table.remove(u14, table_find_ret);
        end;
    end;
end;

return u1;