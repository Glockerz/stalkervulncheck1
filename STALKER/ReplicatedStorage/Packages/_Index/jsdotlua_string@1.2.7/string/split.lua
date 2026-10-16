-- Decompiled with Potassium's decompiler.

local findOr = require(script.Parent:WaitForChild("findOr"));
local slice = require(script.Parent:WaitForChild("slice"));
require(script.Parent.Parent:WaitForChild("es7-types"));
local MAX_SAFE_INTEGER = require(script.Parent.Parent:WaitForChild("number")).MAX_SAFE_INTEGER;

return function(p1: string, p2: any, p3: number?) -- Line: 10, Name: split
    -- upvalues: MAX_SAFE_INTEGER (copy), findOr (copy), slice (copy)
    if p2 == nil then
        return { p1 };
    end;

    if p3 == 0 then
        return {};
    end;

    if p3 == nil or p3 < 0 then
        p3 = MAX_SAFE_INTEGER;
    end;

    if typeof(p2) == "string" then
        if p2 == "" then
            local v4 = {};

            for i in p1:gmatch(".") do
                table.insert(v4, i);
            end;

            return v4;
        end;

        p2 = { p2 };
    end;

    local utf8_len_ret, v5 = utf8.len(p1);
    local v6 = tostring(v5);
    assert(utf8_len_ret ~= nil, ("string `%s` has an invalid byte at position %s"):format(p1, v6));
    local v7 = 1;
    local v8 = {};
    local v9 = nil;

    while true do
        local v10 = findOr(p1, p2, v7);

        if v10 == nil then
            table.insert(v8, slice(p1, v7, nil));
        else
            table.insert(v8, slice(p1, v7, v10.index));
            local utf8_len_ret2 = utf8.len(v10.match);
            v7 = v10.index + utf8_len_ret2;
        end;

        if v10 ~= nil then
            v9 = v10;
        end;

        if v10 == nil or (utf8_len_ret < v7 or p3 <= #v8) then
            if v9 ~= nil then
                local utf8_len_ret2, v11 = utf8.len(v9.match);
                local match = v9.match;
                local v12 = tostring(v11);
                assert(utf8_len_ret2 ~= nil, ("string `%s` has an invalid byte at position %s"):format(match, v12));

                if v9.index + utf8_len_ret2 == utf8_len_ret + 1 then
                    table.insert(v8, "");
                end;
            end;

            return v8;
        end;
    end;
end;