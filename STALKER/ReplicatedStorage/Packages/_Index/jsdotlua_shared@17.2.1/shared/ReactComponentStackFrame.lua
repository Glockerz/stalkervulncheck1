-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("ReactElementType"));
require(script.Parent:WaitForChild("flowtypes.roblox"));
local ReactSymbols = require(script.Parent:WaitForChild("ReactSymbols"));
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE;
local REACT_SUSPENSE_LIST_TYPE = ReactSymbols.REACT_SUSPENSE_LIST_TYPE;
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE;
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE;
local REACT_BLOCK_TYPE = ReactSymbols.REACT_BLOCK_TYPE;
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE;
local v1 = require(script.Parent:WaitForChild("ConsolePatchingDev.roblox"));
local disableLogs = v1.disableLogs;
local reenableLogs = v1.reenableLogs;
local ReactCurrentDispatcher = require(script.Parent:WaitForChild("ReactSharedInternals")).ReactCurrentDispatcher;
local u2 = nil;

local function describeOwner(p3) -- Line: 57
    if type(p3) == "function" then
        return debug.info(p3, "n");
    end;

    if type(p3) == "table" then
        return tostring(p3);
    end;

    return nil;
end;

local function describeBuiltInComponentFrame(p4: string, p5: any, p6: any) -- Line: 66
    -- upvalues: u2 (ref)
    local v7;

    if _G.__DEV__ and p6 then
        if type(p6) == "function" then
            v7 = debug.info(p6, "n");
        elseif type(p6) == "table" then
            v7 = tostring(p6);
        else
            v7 = nil;
        end;
    else
        v7 = nil;
    end;

    return u2(p4, p5, v7);
end;

local u8 = false;
local u9;

if _G.__DEV__ then
    u9 = setmetatable({}, {
        __mode = "k"
    });
else
    u9 = nil;
end;

local function describeNativeComponentFrame(u10: any, u11: boolean) -- Line: 113
    -- upvalues: u8 (ref), u9 (ref), ReactCurrentDispatcher (copy), disableLogs (copy), reenableLogs (copy), u2 (ref)
    if not u10 or u8 then
        return "";
    end;

    if _G.__DEV__ then
        local v12 = u9[u10];

        if v12 ~= nil then
            return v12;
        end;
    end;

    local u13 = nil;
    u8 = true;
    local v14;

    if _G.__DEV__ then
        v14 = ReactCurrentDispatcher.current;
        ReactCurrentDispatcher.current = nil;
        disableLogs();
    else
        v14 = nil;
    end;

    local u15 = nil;
    local _, v17 = xpcall(function() -- Line: 153
        -- upvalues: u11 (copy), u15 (ref), u13 (ref), u10 (copy)
        if u11 then
            return;
        end;

        local _, result = pcall(function() -- Line: 159
            -- upvalues: u15 (ref)
            u15 = debug.traceback();
            error({
                stack = u15
            });
        end);
        u13 = result;
        u10();
    end, function(p16) -- Line: 169
        -- upvalues: u15 (ref)
        return {
            message = p16,
            stack = u15
        };
    end);
    local v18 = nil;

    if v17 and (u13 and type(v17.stack) == "string") then
        local string_split_ret = string.split(v17.stack, "\n");
        local string_split_ret2 = string.split(u13.stack, "\n");
        local v19 = #string_split_ret - 1;
        local v20 = #string_split_ret2 - 1;

        while v19 >= 2 and (v20 >= 0 and string_split_ret[v19] ~= string_split_ret2[v20]) do
            v20 = v20 - 1;
        end;

        while v19 >= 3 and v20 >= 1 do
            v19 = v19 - 1;
            v20 = v20 - 1;

            if string_split_ret[v19] ~= string_split_ret2[v20] then
                if v19 == 1 and v20 == 1 then
                    break;
                end;

                while true do
                    v19 = v19 - 1;
                    v20 = v20 - 1;

                    if v20 < 0 or string_split_ret[v19] ~= string_split_ret2[v20] then
                        v18 = "\n" .. "    in " .. string_split_ret[v19];

                        if _G.__DEV__ then
                            u9[u10] = v18;
                        end;
                    end;

                    if v19 < 3 or v20 < 1 then
                        break;
                    end;
                end;
            end;
        end;
    end;

    u8 = false;

    if _G.__DEV__ then
        ReactCurrentDispatcher.current = v14;
        reenableLogs();
    end;

    if v18 ~= nil then
        return v18;
    end;

    local v21;

    if type(u10) == "function" then
        v21 = debug.info(u10, "n");
    else
        v21 = type(u10) ~= "table" and "" or tostring(u10);
    end;

    local v22;

    if v21 == nil or v21 == "" then
        v22 = "";
    else
        local _ = _G.__DEV__;
        v22 = u2(v21, nil, nil);
    end;

    if _G.__DEV__ then
        u9[u10] = v22;
    end;

    return v22;
end;

u2 = function(p23: string?, p24: any, p25: string?) -- Line: 283, Name: describeComponentFrame
    local v26 = "";

    if _G.__DEV__ and p24 then
        local fileName = p24.fileName;
        local string_gsub_ret = string.gsub(fileName, "^(.*)[\\/]", "");

        if string.match(string_gsub_ret, "^init%.") then
            local string_match_ret = string.match(fileName, "^(.*)[\\/]");

            if string_match_ret and #string_match_ret ~= 0 then
                string_gsub_ret = string.gsub(string_match_ret, "^(.*)[\\/]", "") .. "/" .. string_gsub_ret;
            end;
        end;

        v26 = " (at " .. string_gsub_ret .. ":" .. p24.lineNumber .. ")";
    elseif p25 then
        v26 = " (created by " .. p25 .. ")";
    end;

    return "\n    in " .. (p23 or "Unknown") .. v26;
end;

local function describeClassComponentFrame(p27, p28, p29) -- Line: 316
    -- upvalues: u2 (ref)
    local v30 = tostring(p27);
    local v31;

    if _G.__DEV__ and p29 then
        if type(p29) == "function" then
            v31 = debug.info(p29, "n");
        elseif type(p29) == "table" then
            v31 = tostring(p29);
        else
            v31 = nil;
        end;
    else
        v31 = nil;
    end;

    return u2(v30, p28, v31);
end;

local function describeFunctionComponentFrame(p32: function?, p33: any, p34: any) -- Line: 340
    -- upvalues: u2 (ref)
    if not p32 then
        return "";
    end;

    local v35;

    if type(p32) == "function" then
        v35 = debug.info(p32, "n");
    else
        v35 = tostring(p32);
    end;

    local v36;

    if _G.__DEV__ and p34 then
        if type(p34) == "function" then
            v36 = debug.info(p34, "n");
        elseif type(p34) == "table" then
            v36 = tostring(p34);
        else
            v36 = nil;
        end;
    else
        v36 = nil;
    end;

    return u2(v35, p33, v36);
end;

local function describeUnknownElementTypeFrameInDEV(p37, u38, u39) -- Line: 387
    -- upvalues: describeClassComponentFrame (copy), describeFunctionComponentFrame (ref), describeBuiltInComponentFrame (copy), REACT_SUSPENSE_TYPE (copy), REACT_SUSPENSE_LIST_TYPE (copy), REACT_FORWARD_REF_TYPE (copy), REACT_MEMO_TYPE (copy), describeUnknownElementTypeFrameInDEV (copy), REACT_BLOCK_TYPE (copy), REACT_LAZY_TYPE (copy)
    if not _G.__DEV__ then
        return "";
    end;

    if p37 == nil then
        return "";
    end;

    if type(p37) == "table" and type(p37.__ctor) == "function" then
        return describeClassComponentFrame(p37, u38, u39);
    end;

    if type(p37) == "function" then
        return describeFunctionComponentFrame(p37, u38, u39);
    end;

    if type(p37) == "string" then
        return describeBuiltInComponentFrame(p37, u38, u39);
    end;

    if p37 == REACT_SUSPENSE_TYPE then
        return describeBuiltInComponentFrame("Suspense", u38, u39);
    end;

    if p37 == REACT_SUSPENSE_LIST_TYPE then
        return describeBuiltInComponentFrame("SuspenseList", u38, u39);
    end;

    if type(p37) == "table" then
        local v40 = p37["$$typeof"];

        if v40 == REACT_FORWARD_REF_TYPE then
            return describeFunctionComponentFrame(p37.render, u38, u39);
        end;

        if v40 == REACT_MEMO_TYPE then
            return describeUnknownElementTypeFrameInDEV(p37.type, u38, u39);
        end;

        if v40 == REACT_BLOCK_TYPE then
            return describeFunctionComponentFrame(p37._render, u38, u39);
        end;

        if v40 == REACT_LAZY_TYPE then
            local _payload = p37._payload;
            local _init = p37._init;
            local success, result = pcall(function() -- Line: 446
                -- upvalues: describeUnknownElementTypeFrameInDEV (ref), _init (copy), _payload (copy), u38 (copy), u39 (copy)
                describeUnknownElementTypeFrameInDEV(_init(_payload), u38, u39);
            end);

            if success then
                return result;
            end;
        end;
    end;

    return "";
end;

return {
    describeComponentFrame = u2,
    describeBuiltInComponentFrame = describeBuiltInComponentFrame,
    describeNativeComponentFrame = describeNativeComponentFrame,
    describeClassComponentFrame = describeClassComponentFrame,
    describeFunctionComponentFrame = describeFunctionComponentFrame,
    describeUnknownElementTypeFrameInDEV = describeUnknownElementTypeFrameInDEV
};