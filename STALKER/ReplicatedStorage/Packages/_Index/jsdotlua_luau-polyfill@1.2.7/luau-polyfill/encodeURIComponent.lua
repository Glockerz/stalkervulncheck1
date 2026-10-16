-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local charCodeAt = require(script.Parent.Parent:WaitForChild("string")).charCodeAt;
local Error = require(script.Parent:WaitForChild("Error"));

return function(p1: string) -- Line: 8, Name: encodeURIComponent
    -- upvalues: charCodeAt (copy), Error (copy), HttpService (copy)
    local utf8_len_ret = utf8.len(p1);

    if utf8_len_ret == 0 or utf8_len_ret == nil then
        return "";
    end;

    local v2 = charCodeAt(p1, 1);

    if utf8_len_ret == 1 then
        if v2 == 55296 then
            error(Error.new("URI malformed"));
        end;

        if v2 == 57343 then
            error(Error.new("URI malformed"));
        end;
    end;

    if v2 >= 56320 and v2 < 57343 then
        error(Error.new("URI malformed"));
    end;

    return HttpService:UrlEncode(p1):gsub("%%2D", "-"):gsub("%%5F", "_"):gsub("%%2E", "."):gsub("%%21", "!"):gsub("%%7E", "~"):gsub("%%2A", "*"):gsub("%%27", "\'"):gsub("%%28", "("):gsub("%%29", ")");
end;