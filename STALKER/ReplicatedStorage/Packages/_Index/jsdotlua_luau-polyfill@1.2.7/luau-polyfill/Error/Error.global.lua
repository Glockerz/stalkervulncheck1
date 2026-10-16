-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));
local u1 = {};
u1.__index = u1;

function u1.__tostring(p2) -- Line: 12
    -- upvalues: u1 (copy)
    return getmetatable(u1).__tostring(p2);
end;

local function __createError(p3: string?) -- Line: 18
    -- upvalues: u1 (copy)
    local v4 = setmetatable({
        name = "Error",
        message = p3 or ""
    }, u1);
    u1.__captureStackTrace(v4, 4);

    return v4;
end;

function u1.new(p5: string?) -- Line: 27
    -- upvalues: u1 (copy)
    local v6 = setmetatable({
        name = "Error",
        message = p5 or ""
    }, u1);
    u1.__captureStackTrace(v6, 4);

    return v6;
end;

function u1.captureStackTrace(p7: table, p8: any) -- Line: 31
    -- upvalues: u1 (copy)
    u1.__captureStackTrace(p7, 3, p8);
end;

function u1.__captureStackTrace(p9: table, p10: number, p11: any) -- Line: 35
    -- upvalues: u1 (copy)
    if typeof(p11) == "function" then
        local debug_traceback_ret = debug.traceback(nil, p10);
        local debug_info_ret = debug.info(p11, "n");
        local debug_info_ret2 = debug.info(p11, "s");
        local v12 = string.gsub(debug_info_ret2, "([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1") .. ":%d* function " .. debug_info_ret;
        local string_find_ret = string.find(debug_traceback_ret, v12);
        local v13;

        if string_find_ret == nil then
            v13 = nil;
        else
            local v14;
            v14, v13 = string.find(debug_traceback_ret, "\n", string_find_ret + 1);
        end;

        if v13 ~= nil then
            debug_traceback_ret = string.sub(debug_traceback_ret, v13 + 1);
        end;

        p9.__stack = debug_traceback_ret;
    else
        p9.__stack = debug.traceback(nil, p10);
    end;

    u1.__recalculateStacktrace(p9);
end;

function u1.__recalculateStacktrace(p15: table) -- Line: 59
    local message = p15.message;
    p15.stack = ((p15.name or "Error") .. ((message == nil or message == "") and "" or ": " .. message)) .. "\n" .. (not p15.__stack and "" or p15.__stack);
end;

return setmetatable(u1, {
    __call = function(p16, ...) -- Line: 71, Name: __call
        -- upvalues: u1 (copy)
        local v17 = setmetatable({
            name = "Error",
            message = ... or ""
        }, u1);
        u1.__captureStackTrace(v17, 4);

        return v17;
    end,

    __tostring = function(p18) -- Line: 74, Name: __tostring
        if p18.name == nil then
            return tostring("Error");
        end;

        if p18.message and p18.message ~= "" then
            return string.format("%s: %s", tostring(p18.name), (tostring(p18.message)));
        end;

        return tostring(p18.name);
    end
});