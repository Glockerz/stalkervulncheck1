-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Panel = require(script:WaitForChild("Panel"));
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;

local function inventory() -- Line: 31
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("InventoryController"));
end;

local function toast(u6) -- Line: 35
    -- upvalues: ReplicatedStorage (copy)
    if u6 then
        pcall(function() -- Line: 36
            -- upvalues: ReplicatedStorage (ref), u6 (copy)
            require(ReplicatedStorage:WaitForChild("InventoryController")):ShowToast(u6);
        end);
    end;
end;

local function call(u7, ...) -- Line: 40
    -- upvalues: u2 (ref)
    local table_pack_ret = table.pack(...);
    local v8, v9, v10 = pcall(function() -- Line: 42
        -- upvalues: u2 (ref), u7 (copy), table_pack_ret (copy)
        return u2:InvokeServer(u7, table.unpack(table_pack_ret, 1, table_pack_ret.n));
    end);

    if v8 then
        return v9 == true, v10;
    end;

    return false, "Trading is unavailable right now.";
end;

local function callAndToast(u11, ...) -- Line: 49
    -- upvalues: call (copy), ReplicatedStorage (copy)
    local table_pack_ret = table.pack(...);
    task.spawn(function() -- Line: 51
        -- upvalues: call (ref), u11 (copy), table_pack_ret (copy), ReplicatedStorage (ref)
        local v12, u13 = call(u11, table.unpack(table_pack_ret, 1, table_pack_ret.n));

        if not v12 and u13 then
            pcall(function() -- Line: 36
                -- upvalues: ReplicatedStorage (ref), u13 (copy)
                require(ReplicatedStorage:WaitForChild("InventoryController")):ShowToast(u13);
            end);
        end;
    end);
end;

local function offeredSet(p14) -- Line: 57
    local v15 = {};

    if p14 then
        for _, v in ipairs(p14.mine.items) do
            v15[tostring(v.key) .. "#" .. tostring(v.index)] = true;
        end;
    end;

    return v15;
end;

local function onState(p16) -- Line: 67
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), u4 (ref), Panel (copy), offeredSet (copy)
    local InventoryController = require(ReplicatedStorage:WaitForChild("InventoryController"));
    local InventoryGui = LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

    if InventoryGui and not InventoryGui.Enabled then
        InventoryController:OpenInventoryUI();
    end;

    u4 = p16;
    Panel.Show(p16, InventoryGui, InventoryController);
    InventoryController:SetTradeOffered((offeredSet(p16)));
end;

local function onClosed(p17) -- Line: 76
    -- upvalues: u4 (ref), Panel (copy), ReplicatedStorage (copy), LocalPlayer (copy)
    u4 = nil;
    Panel.Hide();
    local InventoryController = require(ReplicatedStorage:WaitForChild("InventoryController"));
    InventoryController:SetTradeOffered({});
    local InventoryGui = LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

    if InventoryGui and InventoryGui.Enabled then
        pcall(function() -- Line: 85
            -- upvalues: InventoryController (copy)
            InventoryController:LoadVicinity();
        end);
    end;

    local text = p17.text;

    if text then
        pcall(function() -- Line: 36
            -- upvalues: ReplicatedStorage (ref), text (copy)
            require(ReplicatedStorage:WaitForChild("InventoryController")):ShowToast(text);
        end);
    end;
end;

function u1.Request(p18, u19) -- Line: 89
    -- upvalues: call (copy), ReplicatedStorage (copy)
    task.spawn(function() -- Line: 90
        -- upvalues: call (ref), u19 (copy), ReplicatedStorage (ref)
        local v20, u21 = call("request", u19);

        if v20 then
            u21 = "Trade request sent to " .. u19.DisplayName .. "." or u21;
        end;

        if u21 then
            pcall(function() -- Line: 36
                -- upvalues: ReplicatedStorage (ref), u21 (copy)
                require(ReplicatedStorage:WaitForChild("InventoryController")):ShowToast(u21);
            end);
        end;
    end);
end;

function u1.OfferFromDrag(p22, p23, p24) -- Line: 97
    -- upvalues: u4 (ref), call (copy), ReplicatedStorage (copy)
    if not u4 then
        return;
    end;

    local v25, u26 = call("offer_add", p23, p24);

    if not v25 and u26 then
        pcall(function() -- Line: 36
            -- upvalues: ReplicatedStorage (ref), u26 (copy)
            require(ReplicatedStorage:WaitForChild("InventoryController")):ShowToast(u26);
        end);
    end;
end;

function u1.RemoveFromDrag(p27, p28) -- Line: 105
    -- upvalues: u4 (ref), callAndToast (copy)
    local v29 = u4;

    if v29 then
        if type(p28) == "number" then
            v29 = u4.mine.items[p28];
        else
            v29 = false;
        end;
    end;

    if v29 then
        callAndToast("offer_remove", v29.key, v29.index);
    end;
end;

function u1.IsTrading(p30) -- Line: 110
    -- upvalues: u4 (ref)
    return u4 ~= nil;
end;

function u1.Init(p31) -- Line: 114
    -- upvalues: u5 (ref), ReplicatedStorage (copy), u2 (ref), u3 (ref), Panel (copy), callAndToast (copy), onState (copy), onClosed (copy), LocalPlayer (copy), u4 (ref), offeredSet (copy)
    if u5 then
        return;
    end;

    u5 = true;
    local Remotes = ReplicatedStorage:WaitForChild("Remotes");
    u2 = Remotes:WaitForChild("PlayerTradeAction");
    u3 = Remotes:WaitForChild("PlayerTradeState");
    Panel.Build({
        onReady = function(p32) -- Line: 122, Name: onReady
            -- upvalues: callAndToast (ref)
            callAndToast("ready", p32);
        end,

        onCancel = function() -- Line: 123, Name: onCancel
            -- upvalues: callAndToast (ref)
            callAndToast("cancel");
        end,

        onRoubles = function(p33) -- Line: 124, Name: onRoubles
            -- upvalues: callAndToast (ref)
            callAndToast("roubles", p33);
        end
    });
    u3.OnClientEvent:Connect(function(u34) -- Line: 127
        -- upvalues: onState (ref), onClosed (ref), ReplicatedStorage (ref), Panel (ref), callAndToast (ref)
        if type(u34) ~= "table" then
            return;
        end;

        if u34.kind == "state" then
            onState(u34);

            return;
        end;

        if u34.kind == "closed" then
            onClosed(u34);

            return;
        end;

        if u34.kind == "result" then
            local text = u34.text;

            if text then
                pcall(function() -- Line: 36
                    -- upvalues: ReplicatedStorage (ref), text (copy)
                    require(ReplicatedStorage:WaitForChild("InventoryController")):ShowToast(text);
                end);
            end;
        elseif u34.kind == "request" then
            Panel.ShowRequest(u34.from, u34.ttl, function(p35) -- Line: 136
                -- upvalues: callAndToast (ref), u34 (copy)
                callAndToast("respond", u34.fromId, p35);
            end);
        end;
    end);
    task.spawn(function() -- Line: 142
        -- upvalues: LocalPlayer (ref), u4 (ref), callAndToast (ref)
        local InventoryGui = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("InventoryGui");
        InventoryGui:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 144
            -- upvalues: InventoryGui (copy), u4 (ref), callAndToast (ref)
            if not InventoryGui.Enabled and u4 then
                callAndToast("cancel");
            end;
        end);
    end);
    task.spawn(function() -- Line: 149
        -- upvalues: u4 (ref), ReplicatedStorage (ref), offeredSet (ref)
        while true do
            repeat
                task.wait(0.5);
            until u4;

            pcall(function() -- Line: 152
                -- upvalues: ReplicatedStorage (ref), offeredSet (ref), u4 (ref)
                require(ReplicatedStorage:WaitForChild("InventoryController")):SetTradeOffered((offeredSet(u4)));
            end);
        end;
    end);
end;

task.defer(function() -- Line: 157
    -- upvalues: u1 (copy)
    u1:Init();
end);

return u1;