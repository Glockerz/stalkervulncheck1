-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local inspect = require(script.Parent:WaitForChild("inspect"));
local isArray = require(script.Parent:WaitForChild("Array"):WaitForChild("isArray"));
local forEach = require(script.Parent:WaitForChild("Array"):WaitForChild("forEach"));
local fromString = require(script.Parent:WaitForChild("Array"):WaitForChild("from"):WaitForChild("fromString"));
require(script.Parent.Parent:WaitForChild("es7-types"));
local u4 = {
    __iter = function(p1) -- Line: 23, Name: __iter
        return next, p1._array;
    end,

    __tostring = function(p2) -- Line: 26, Name: __tostring
        -- upvalues: inspect (copy)
        local v3 = "Set ";

        if #p2._array > 0 then
            v3 = v3 .. "(" .. tostring(#p2._array) .. ") ";
        end;

        return v3 .. inspect(p2._array);
    end
};
u4.__index = u4;

function u4.new(p5) -- Line: 38
    -- upvalues: isArray (copy), _G___DEV__ (copy), fromString (copy), u4 (copy)
    local v6 = {};
    local v7;

    if p5 == nil then
        v7 = {};
    else
        local v8 = nil;

        if typeof(p5) == "table" then
            if isArray(p5) then
                v8 = table.clone(p5);
            else
                local v9 = getmetatable(p5);

                if v9 and rawget(v9, "__iter") then
                    v8 = p5;
                elseif _G___DEV__ then
                    error("cannot create array from an object-like table");
                end;
            end;
        elseif typeof(p5) == "string" then
            v8 = fromString(p5);
        else
            error(("cannot create array from value of type `%s`"):format((typeof(p5))));
        end;

        if v8 then
            v7 = table.create(#v8);

            for _, v in v8 do
                if not v6[v] then
                    v6[v] = true;
                    table.insert(v7, v);
                end;
            end;
        else
            v7 = {};
        end;
    end;

    return setmetatable({
        size = #v7,
        _map = v6,
        _array = v7
    }, u4);
end;

function u4.add(p10, p11) -- Line: 84
    if not p10._map[p11] then
        p10.size = p10.size + 1;
        p10._map[p11] = true;
        table.insert(p10._array, p11);
    end;

    return p10;
end;

function u4.clear(p12) -- Line: 94
    p12.size = 0;
    table.clear(p12._map);
    table.clear(p12._array);
end;

function u4.delete(p13, p14) -- Line: 100
    if not p13._map[p14] then
        return false;
    end;

    p13.size = p13.size - 1;
    p13._map[p14] = nil;
    local table_find_ret = table.find(p13._array, p14);

    if table_find_ret then
        table.remove(p13._array, table_find_ret);
    end;

    return true;
end;

function u4.forEach(u15, u16, u17) -- Line: 116
    -- upvalues: forEach (copy)
    if typeof(u16) ~= "function" then
        error("callback is not a function");
    end;

    forEach(u15._array, function(p18) -- Line: 122
        -- upvalues: u17 (copy), u16 (copy), u15 (copy)
        if u17 == nil then
            u16(p18, p18, u15);

            return;
        end;

        u16(u17, p18, p18, u15);
    end);
end;

function u4.has(p19, p20) -- Line: 131
    return p19._map[p20] ~= nil;
end;

function u4.ipairs(p21) -- Line: 135
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        warn(debug.traceback(
            "`for _,_ in mySet:ipairs() do` is deprecated and will be removed in a future release, please use `for _,_ in mySet do` instead\n",
            2
        ));
    end;

    return ipairs(p21._array);
end;

return u4;