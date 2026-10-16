-- Decompiled with Potassium's decompiler.

local u1 = "([" .. ("$%^()-[].?"):gsub("(.)", "%%%1") .. "])";

return function(p2: string, p3: string, p4: any) -- Line: 4, Name: includes
    -- upvalues: u1 (copy)
    local utf8_len_ret, v5 = utf8.len(p2);
    local v6 = tostring(v5);
    assert(utf8_len_ret ~= nil, ("string `%s` has an invalid byte at position %s"):format(p2, v6));

    if utf8_len_ret == 0 then
        return false;
    end;

    if #p3 == 0 then
        return true;
    end;

    local v7;

    if p4 == nil then
        v7 = 1;
    else
        v7 = tonumber(p4) or 1;

        if utf8_len_ret < v7 then
            return false;
        end;
    end;

    local utf8_offset_ret = utf8.offset(p2, v7 < 1 and 1 or v7);
    local v8 = p3:gsub(u1, "%%%1");
    local string_find_ret, _ = string.find(p2, v8, utf8_offset_ret);

    return string_find_ret ~= nil;
end;