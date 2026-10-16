-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local forEach = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("forEach"));
local map = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("map"));
local isArray = require(script.Parent.Parent:WaitForChild("Array"):WaitForChild("isArray"));
local u1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));
local u2 = {};

function u2.new(p3) -- Line: 22
    -- upvalues: isArray (copy), _G___DEV__ (copy), u1 (copy), u2 (copy)
    local v4 = nil;
    local v5 = nil;

    if p3 == nil then
        v4 = {};
        v5 = {};
    elseif isArray(p3) then
        if _G___DEV__ and (#p3 > 0 and typeof(p3[1]) ~= "table") then
            error("Value `" .. typeof(p3[1]) .. "` is not an entry object.\n Cannot create Map from {K, V} form, it must be { {K, V}... }");
        end;

        v4 = table.create(#p3);
        v5 = {};

        for _, v in p3 do
            local v6 = v[1];

            if _G___DEV__ and v6 == nil then
                error("cannot create Map from a table that isn\'t an array.");
            end;

            local v7 = v[2];

            if v5[v6] == nil then
                table.insert(v4, v6);
            end;

            v5[v6] = v7;
        end;
    elseif u1(p3, u2) then
        v4 = table.clone(p3._array);
        v5 = table.clone(p3._map);
    else
        error(("`%s` `%s` is not iterable, cannot make Map using it"):format(typeof(p3), (tostring(p3))));
    end;

    return setmetatable({
        size = #v4,
        _map = v5,
        _array = v4
    }, u2);
end;

function u2.set(p8, p9, p10) -- Line: 71
    if p8._map[p9] == nil then
        p8.size = p8.size + 1;
        table.insert(p8._array, p9);
    end;

    p8._map[p9] = p10;

    return p8;
end;

function u2.get(p11, p12) -- Line: 83
    return p11._map[p12];
end;

function u2.clear(p13) -- Line: 87
    local v14 = table;
    p13.size = 0;
    v14.clear(p13._map);
    v14.clear(p13._array);
end;

function u2.delete(p15, p16) -- Line: 94
    if p15._map[p16] == nil then
        return false;
    end;

    p15.size = p15.size - 1;
    p15._map[p16] = nil;
    local table_find_ret = table.find(p15._array, p16);

    if table_find_ret then
        table.remove(p15._array, table_find_ret);
    end;

    return true;
end;

function u2.forEach(u17, u18, u19) -- Line: 110
    -- upvalues: _G___DEV__ (copy), forEach (copy)
    if _G___DEV__ and typeof(u18) ~= "function" then
        error("callback is not a function");
    end;

    forEach(u17._array, function(p20) -- Line: 117
        -- upvalues: u17 (copy), u19 (copy), u18 (copy)
        local v21 = u17._map[p20];

        if u19 == nil then
            u18(v21, p20, u17);

            return;
        end;

        u18(u19, v21, p20, u17);
    end);
end;

function u2.has(p22, p23) -- Line: 128
    return p22._map[p23] ~= nil;
end;

function u2.keys(p24) -- Line: 132
    return p24._array;
end;

function u2.values(u25) -- Line: 136
    -- upvalues: map (copy)
    return map(u25._array, function(p26) -- Line: 137
        -- upvalues: u25 (copy)
        return u25._map[p26];
    end);
end;

function u2.entries(u27) -- Line: 142
    -- upvalues: map (copy)
    return map(u27._array, function(p28) -- Line: 143
        -- upvalues: u27 (copy)
        return { p28, u27._map[p28] };
    end);
end;

function u2.ipairs(p29) -- Line: 148
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        warn(debug.traceback(
            "`for _,_ in myMap:ipairs() do` is deprecated and will be removed in a future release, please use `for _,_ in myMap do` instead\n",
            2
        ));
    end;

    return ipairs(p29:entries());
end;

function u2.__iter(p30) -- Line: 160
    return next, p30:entries();
end;

function u2.__index(p31, p32) -- Line: 164
    -- upvalues: u2 (copy), _G___DEV__ (copy)
    local v33 = rawget(u2, p32);

    if v33 ~= nil then
        return v33;
    end;

    if _G___DEV__ then
        local v34 = rawget(p31, "_map");
        assert(v34, "Map has been corrupted, and is missing private state! Did you accidentally call table.clear() instead of map:clear()?");
    end;

    return u2.get(p31, p32);
end;

function u2.__newindex(p35, p36, p37) -- Line: 180
    p35:set(p36, p37);
end;

return u2;