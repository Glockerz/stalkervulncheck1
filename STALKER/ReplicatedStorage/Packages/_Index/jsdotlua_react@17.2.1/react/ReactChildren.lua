-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent:WaitForChild("shared"));
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols;
local getIteratorFn = ReactSymbols.getIteratorFn;
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE;
local REACT_PORTAL_TYPE = ReactSymbols.REACT_PORTAL_TYPE;
local Array = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Array;
local ReactElement = require(script.Parent:WaitForChild("ReactElement"));
local isValidElement = ReactElement.isValidElement;
local cloneAndReplaceKey = ReactElement.cloneAndReplaceKey;

local function escape(p1: string) -- Line: 43
    local string_gsub_ret = string.gsub(p1, "=", "=0");

    return "$" .. string.gsub(string_gsub_ret, ":", "=2");
end;

local function escapeUserProvidedKey(p2: string) -- Line: 58
    return p2;
end;

local function getElementKey(p3: any, p4: number) -- Line: 71
    if typeof(p3) ~= "table" or (p3 == nil or p3.key == nil) then
        return tostring(p4);
    end;

    local v5 = tostring(p3.key);
    local string_gsub_ret = string.gsub(v5, "=", "=0");

    return "$" .. string.gsub(string_gsub_ret, ":", "=2");
end;

local function mapIntoArray(p6: any, p7: any, p8: string, p9: string, p10: function) -- Line: 84
    -- upvalues: REACT_ELEMENT_TYPE (copy), REACT_PORTAL_TYPE (copy), Array (copy), mapIntoArray (copy), isValidElement (copy), cloneAndReplaceKey (copy), getIteratorFn (copy)
    local v11 = typeof(p6);

    if v11 == "nil" or (v11 == "boolean" or v11 == "userdata") then
        p6 = nil;
    end;

    local v12 = false;

    if p6 == nil or (v11 == "string" or v11 == "number") then
        v12 = true;
    elseif v11 == "table" then
        local v13 = p6["$$typeof"];
        v12 = (v13 == REACT_ELEMENT_TYPE or v13 == REACT_PORTAL_TYPE) and true or v12;
    end;

    if v12 then
        local v14 = p10(p6);

        if p9 == "" then
            local v15;

            if typeof(p6) == "table" and (p6 ~= nil and p6.key ~= nil) then
                local v16 = tostring(p6.key);
                local string_gsub_ret = string.gsub(v16, "=", "=0");
                v15 = "$" .. string.gsub(string_gsub_ret, ":", "=2");
            else
                v15 = tostring(1);
            end;

            p9 = "." .. v15;
        end;

        if Array.isArray(v14) then
            mapIntoArray(v14, p7, p9 == nil and "" or p9 .. "/", "", function(p17) -- Line: 133
                return p17;
            end);
        elseif v14 ~= nil then
            if isValidElement(v14) then
                local key = v14.key;
                v14 = cloneAndReplaceKey(v14, p8 .. (not (key and (not p6 or p6.key ~= key)) and "" or tostring(key) .. "/") .. p9);
            end;

            table.insert(p7, v14);
        end;

        return 1;
    end;

    local v18 = 0;
    local v19 = p9 == "" and "." or p9 .. ":";

    if Array.isArray(p6) then
        for i = 1, #p6 do
            local v20 = p6[i];
            local v21;

            if typeof(v20) == "table" and (v20 ~= nil and v20.key ~= nil) then
                local v22 = tostring(v20.key);
                local string_gsub_ret = string.gsub(v22, "=", "=0");
                v21 = "$" .. string.gsub(string_gsub_ret, ":", "=2");
            else
                v21 = tostring(i);
            end;

            v18 = v18 + mapIntoArray(v20, p7, p8, v19 .. v21, p10);
            local _ = i;
        end;

        return v18;
    end;

    local v23 = getIteratorFn(p6);

    if typeof(v23) == "function" then
        local v24 = v23(p6);
        local v25 = v24.next();
        local v26 = 1;

        while not v25.done do
            local value = v25.value;
            local v27;

            if typeof(value) == "table" and (value ~= nil and value.key ~= nil) then
                local v28 = tostring(value.key);
                local string_gsub_ret = string.gsub(v28, "=", "=0");
                v27 = "$" .. string.gsub(string_gsub_ret, ":", "=2");
            else
                v27 = tostring(v26);
            end;

            v26 = v26 + 1;
            v18 = v18 + mapIntoArray(value, p7, p8, v19 .. v27, p10);
            v25 = v24.next();
        end;
    end;

    return v18;
end;

local function mapChildren(p29: any, u30: function, p31: any) -- Line: 251
    -- upvalues: mapIntoArray (copy)
    if p29 == nil then
        return nil;
    end;

    local v32 = {};
    local u33 = 1;
    mapIntoArray(p29, v32, "", "", function(p34) -- Line: 261
        -- upvalues: u30 (copy), u33 (ref)
        local v35 = u30(p34, u33);
        u33 = u33 + 1;

        return v35;
    end);

    return v32;
end;

return {
    forEach = function(p36: any, u37: function, p38: any) -- Line: 303, Name: forEachChildren
        -- upvalues: mapChildren (copy)
        mapChildren(p36, function(...) -- Line: 308
            -- upvalues: u37 (copy)
            u37(...);
        end, p38);
    end,

    map = mapChildren,

    count = function(p39) -- Line: 279, Name: countChildren
        -- upvalues: mapChildren (copy)
        local u40 = 0;
        mapChildren(p39, function() -- Line: 281
            -- upvalues: u40 (ref)
            u40 = u40 + 1;
        end);

        return u40;
    end,

    only = function(p41) -- Line: 343, Name: onlyChild
        -- upvalues: invariant (copy), isValidElement (copy)
        invariant(isValidElement(p41), "React.Children.only expected to receive a single React element child.");

        return p41;
    end,

    toArray = function(p42) -- Line: 322, Name: toArray
        -- upvalues: mapChildren (copy)
        return mapChildren(p42, function(p43) -- Line: 323
            return p43;
        end) or {};
    end
};