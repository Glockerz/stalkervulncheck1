-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = { "BackpackContents", "ChestRigContents", "BattleBeltContents" };

function u1.IsEncoded(p3) -- Line: 61
    if type(p3) ~= "table" then
        return false;
    end;

    local v4 = p3[1];
    local v5;

    if type(v4) == "table" and v4.Index ~= nil then
        v5 = type(v4.Item) == "table";
    else
        v5 = false;
    end;

    return v5;
end;

local function encodeItem(p6, p7, p8) -- Line: 90
    -- upvalues: u2 (copy), u1 (copy)
    if type(p6) ~= "table" then
        return p6;
    end;

    local v9 = p7 or {};
    local v10 = p8 or 0;

    if v9[p6] then
        warn(string.format("[InventoryWire] CYCLE: item \'%s\' is inside itself -- sending one copy with empty contents. The stored data still holds the loop and needs repairing.", (tostring(p6.ID))));
        local table_clone_ret = table.clone(p6);

        for _, v in ipairs(u2) do
            if type(table_clone_ret[v]) == "table" then
                table_clone_ret[v] = {};
            end;
        end;

        return table_clone_ret;
    end;

    local table_clone_ret = table.clone(p6);
    v9[p6] = true;

    for _, v in ipairs(u2) do
        local v11 = table_clone_ret[v];

        if type(v11) == "table" then
            if v9[v11] then
                warn(string.format("[InventoryWire] CYCLE: item \'%s\' has %s that contains the item itself -- sending it empty. The stored data still holds the loop and needs repairing.", tostring(p6.ID), v));
                table_clone_ret[v] = {};
            elseif v10 >= 8 then
                warn(string.format("[InventoryWire] item \'%s\' nests deeper than %d levels at %s -- sending it empty", tostring(p6.ID), 8, v));
                table_clone_ret[v] = {};
            else
                table_clone_ret[v] = u1.EncodeItems(v11, v9, v10 + 1);
            end;
        end;
    end;

    v9[p6] = nil;

    return table_clone_ret;
end;

local function decodeItem(p12) -- Line: 136
    -- upvalues: u2 (copy), u1 (copy)
    if type(p12) ~= "table" then
        return p12;
    end;

    local table_clone_ret = table.clone(p12);

    for _, v in ipairs(u2) do
        if u1.IsEncoded(table_clone_ret[v]) then
            table_clone_ret[v] = u1.DecodeItems(table_clone_ret[v]);
        end;
    end;

    return table_clone_ret;
end;

function u1.EncodeItems(p13, p14, p15) -- Line: 153
    -- upvalues: u1 (copy), encodeItem (copy)
    local v16 = {};

    if type(p13) ~= "table" then
        return v16;
    end;

    local v17 = p14 or {};
    local v18 = p15 or 0;

    if v17[p13] then
        warn("[InventoryWire] CYCLE: contents table reached itself -- encoding it empty");

        return v16;
    end;

    v17[p13] = true;

    if u1.IsEncoded(p13) then
        for i, v in ipairs(p13) do
            v16[i] = {
                Index = v.Index,
                Item = encodeItem(v.Item, v17, v18)
            };
        end;

        v17[p13] = nil;

        return v16;
    end;

    local v19 = {};

    for i, v in pairs(p13) do
        if v ~= nil then
            table.insert(v19, i);
        end;
    end;

    table.sort(v19, function(p20, p21) -- Line: 178
        local v22 = type(p20);

        if v22 ~= type(p21) then
            return v22 == "number";
        end;

        if v22 == "number" then
            return p20 < p21;
        end;

        return tostring(p20) < tostring(p21);
    end);

    for i, v in ipairs(v19) do
        v16[i] = {
            Index = v,
            Item = encodeItem(p13[v], v17, v18)
        };
    end;

    v17[p13] = nil;

    return v16;
end;

function u1.DecodeItems(p23) -- Line: 192
    -- upvalues: u1 (copy), decodeItem (copy)
    local v24 = {};

    if type(p23) ~= "table" then
        return v24;
    end;

    if u1.IsEncoded(p23) then
        for _, v in ipairs(p23) do
            if v ~= nil and v.Index ~= nil then
                v24[v.Index] = decodeItem(v.Item);
            end;
        end;

        return v24;
    end;

    for i, v in pairs(p23) do
        v24[i] = decodeItem(v);
    end;

    return v24;
end;

function u1.EncodeInventory(p25) -- Line: 213
    -- upvalues: u1 (copy)
    if type(p25) ~= "table" then
        return p25;
    end;

    local table_clone_ret = table.clone(p25);
    table_clone_ret.Items = u1.EncodeItems(p25.Items);
    table_clone_ret.WireVersion = 1;

    return table_clone_ret;
end;

function u1.SafeEncode(p26, p27) -- Line: 235
    -- upvalues: u1 (copy)
    if type(p26) ~= "table" or type(p26.Items) ~= "table" then
        return p26;
    end;

    local v28 = u1.EncodeInventory(p26);
    local v29 = u1.Count(p26.Items);
    local v30 = u1.Count(v28.Items);

    if v29 == v30 then
        return v28;
    end;

    warn(string.format("[WIRE] %s encode count mismatch %d -> %d -- sending RAW", tostring(p27), v29, v30));

    return p26;
end;

function u1.SafeEncodeItems(p31, p32) -- Line: 253
    -- upvalues: u1 (copy)
    if type(p31) ~= "table" then
        return p31;
    end;

    local v33 = u1.EncodeItems(p31);
    local v34 = u1.Count(p31);
    local v35 = u1.Count(v33);

    if v34 == v35 then
        return v33;
    end;

    warn(string.format("[WIRE] %s encode count mismatch %d -> %d -- sending RAW", tostring(p32), v34, v35));

    return p31;
end;

function u1.EncodeEquipPayload(p36) -- Line: 279
    -- upvalues: u2 (copy), u1 (copy)
    if type(p36) ~= "table" then
        return p36;
    end;

    local table_clone_ret = table.clone(p36);

    for _, v in ipairs(u2) do
        if type(table_clone_ret[v]) == "table" then
            table_clone_ret[v] = u1.EncodeItems(table_clone_ret[v]);
        end;
    end;

    return table_clone_ret;
end;

function u1.Each(u37) -- Line: 312
    -- upvalues: u1 (copy)
    if type(u37) ~= "table" then
        return function() -- Line: 314
            return nil;
        end;
    end;

    if not u1.IsEncoded(u37) then
        return pairs(u37);
    end;

    local u38 = 0;

    return function() -- Line: 320
        -- upvalues: u38 (ref), u37 (copy)
        while true do
            u38 = u38 + 1;
            local v39 = u37[u38];

            if v39 == nil then
                break;
            end;

            if type(v39) == "table" and (v39.Index ~= nil and type(v39.Item) == "table") then
                return v39.Index, v39.Item;
            end;
        end;

        return nil;
    end;
end;

function u1.Count(p40) -- Line: 334
    -- upvalues: u1 (copy)
    if type(p40) ~= "table" then
        return 0;
    end;

    local v41 = 0;

    if u1.IsEncoded(p40) then
        for _, v in ipairs(p40) do
            if v and v.Item then
                v41 = v41 + 1;
            end;
        end;

        return v41;
    end;

    for _, v in pairs(p40) do
        if v then
            v41 = v41 + 1;
        end;
    end;

    return v41;
end;

return u1;