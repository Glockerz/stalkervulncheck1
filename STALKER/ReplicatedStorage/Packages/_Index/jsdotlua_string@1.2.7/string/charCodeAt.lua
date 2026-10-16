-- Decompiled with Potassium's decompiler.

local NaN = require(script.Parent.Parent:WaitForChild("number")).NaN;

return function(p1: string, p2: number) -- Line: 7
    -- upvalues: NaN (copy)
    local v3 = type(p2) ~= "number" and 1 or p2;
    local string_len_ret = string.len(p1);

    if v3 < 1 or string_len_ret < v3 then
        return NaN;
    end;

    local utf8_offset_ret = utf8.offset(p1, v3);

    if utf8_offset_ret == nil or string_len_ret < utf8_offset_ret then
        return NaN;
    end;

    local utf8_codepoint_ret = utf8.codepoint(p1, utf8_offset_ret, utf8_offset_ret);

    if utf8_codepoint_ret == nil then
        return NaN;
    end;

    return utf8_codepoint_ret;
end;