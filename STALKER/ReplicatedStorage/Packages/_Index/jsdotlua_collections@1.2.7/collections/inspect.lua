-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local isArray = require(script.Parent:WaitForChild("Array"):WaitForChild("isArray"));
require(script.Parent.Parent:WaitForChild("es7-types"));
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;

local function inspect(p6: any, p7: table?) -- Line: 34
    -- upvalues: u1 (ref)
    local v8 = p7 or {
        depth = 2
    };
    local v9 = v8.depth or 2;
    v8.depth = v9 < 0 and 2 or v9;

    return u1(p6, {}, v8);
end;

local function isIndexKey(p10, p11) -- Line: 41
    local v12;

    if type(p10) == "number" and (p10 <= p11 and p10 >= 1) then
        v12 = math.floor(p10) == p10;
    else
        v12 = false;
    end;

    return v12;
end;

local function getTableLength(p13) -- Line: 48
    local v14 = 1;
    local v15 = rawget(p13, v14);

    while v15 ~= nil do
        v14 = v14 + 1;
        v15 = rawget(p13, v14);
    end;

    return v14 - 1;
end;

local function sortKeysForPrinting(p16, p17) -- Line: 58
    local v18 = type(p16);
    local v19 = type(p17);

    if v18 == v19 and (v18 == "number" or v18 == "string") then
        return p16 < p17;
    end;

    return v18 < v19;
end;

local function rawpairs(p20) -- Line: 71
    return next, p20, nil;
end;

local function getFragmentedKeys(p21) -- Line: 75
    -- upvalues: sortKeysForPrinting (copy)
    local v22 = 1;
    local v23 = rawget(p21, v22);
    local v24 = 0;
    local v25 = {};

    while v23 ~= nil do
        v22 = v22 + 1;
        v23 = rawget(p21, v22);
    end;

    local v26 = v22 - 1;

    for i, _ in next, p21 do
        local v27;

        if type(i) == "number" and (i <= v26 and i >= 1) then
            v27 = math.floor(i) == i;
        else
            v27 = false;
        end;

        if not v27 then
            v24 = v24 + 1;
            v25[v24] = i;
        end;
    end;

    table.sort(v25, sortKeysForPrinting);

    return v25, v24, v26;
end;

u1 = function(p28: any, p29: any, p30: table) -- Line: 89, Name: formatValue
    -- upvalues: HttpService (copy), u2 (ref)
    local v31 = typeof(p28);

    if v31 == "string" then
        return HttpService:JSONEncode(p28);
    end;

    if v31 == "number" then
        return p28 ~= p28 and "NaN" or (p28 == (1 / 0) and "Infinity" or (p28 == (-1 / 0) and "-Infinity" or tostring(p28)));
    end;

    if v31 ~= "function" then
        if v31 == "table" then
            return u2(p28, p29, p30);
        end;

        return tostring(p28);
    end;

    local v32 = "[function";
    local debug_info_ret = debug.info(p28, "n");

    if debug_info_ret ~= nil and debug_info_ret ~= "" then
        v32 = v32 .. " " .. debug_info_ret;
    end;

    return v32 .. "]";
end;

u2 = function(p33: any, p34: any, p35: table) -- Line: 122, Name: formatObjectValue
    -- upvalues: u1 (ref), isArray (copy), u3 (ref), u4 (ref)
    if table.find(p34, p33) ~= nil then
        return "[Circular]";
    end;

    local v36 = { unpack(p34) };
    table.insert(v36, p33);

    if typeof(p33.toJSON) == "function" then
        local v37 = p33:toJSON(p33);

        if v37 ~= p33 then
            if typeof(v37) == "string" then
                return v37;
            end;

            return u1(v37, v36, p35);
        end;
    elseif isArray(p33) then
        return u3(p33, v36, p35);
    end;

    return u4(p33, v36, p35);
end;

u4 = function(p38: any, p39: any, p40: table) -- Line: 147, Name: formatObject
    -- upvalues: getFragmentedKeys (copy), u5 (ref), u1 (ref)
    local v41 = "";
    local v42 = getmetatable(p38);

    if v42 and rawget(v42, "__tostring") then
        return tostring(p38);
    end;

    local v43, v44, v45 = getFragmentedKeys(p38);

    if v45 == 0 and v44 == 0 then
        return v41 .. "{}";
    end;

    if #p39 > p40.depth then
        return v41 .. "[" .. u5(p38) .. "]";
    end;

    local v46 = {};

    for i = 1, v45 do
        local v47 = u1(p38[i], p39, p40);
        table.insert(v46, v47);
        local _ = i;
    end;

    for i = 1, v44 do
        local v48 = v43[i];
        local v49 = v48 .. ": " .. u1(p38[v48], p39, p40);
        table.insert(v46, v49);
        local _ = i;
    end;

    return v41 .. "{ " .. table.concat(v46, ", ") .. " }";
end;

u3 = function(p50: any, p51: any, p52: table) -- Line: 183, Name: formatArray
    -- upvalues: u1 (ref)
    local v53 = #p50;

    if v53 == 0 then
        return "[]";
    end;

    if #p51 > p52.depth then
        return "[Array]";
    end;

    local math_min_ret = math.min(10, v53);
    local v54 = v53 - math_min_ret;
    local v55 = {};

    for i = 1, math_min_ret do
        v55[i] = u1(p50[i], p51, p52);
        local _ = i;
    end;

    if v54 == 1 then
        table.insert(v55, "... 1 more item");
    elseif v54 > 1 then
        local v56 = tostring(v54);
        table.insert(v55, ("... %s more items"):format(v56));
    end;

    return "[" .. table.concat(v55, ", ") .. "]";
end;

u5 = function(p57) -- Line: 209, Name: getObjectTag
    return "Object";
end;

return inspect;