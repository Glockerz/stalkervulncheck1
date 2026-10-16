-- Decompiled with Potassium's decompiler.

return function(p1: string, p2: any, p3: any) -- Line: 1, Name: slice
    local utf8_len_ret, v4 = utf8.len(p1);
    local v5 = tostring(v4);
    assert(utf8_len_ret ~= nil, ("string `%s` has an invalid byte at position %s"):format(p1, v5));
    local v6 = tonumber(p2);
    local v7 = typeof(v6) == "number";
    assert(v7, "startIndexStr should be a number");
    local v8 = v6 + utf8_len_ret < 0 and 1 or v6;

    if utf8_len_ret < v8 then
        return "";
    end;

    local v9 = p3 ~= nil and (tonumber(p3) or (0 / 0)) or utf8_len_ret + 1;
    local v10 = typeof(v9) == "number";
    assert(v10, "lastIndexStr should convert to number");

    if utf8_len_ret < v9 then
        v9 = utf8_len_ret + 1;
    end;

    local utf8_offset_ret = utf8.offset(p1, v8);
    local v11 = utf8.offset(p1, v9) - 1;

    return string.sub(p1, utf8_offset_ret, v11);
end;