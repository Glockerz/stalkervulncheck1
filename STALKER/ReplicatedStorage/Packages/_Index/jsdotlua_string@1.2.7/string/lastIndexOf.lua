-- Decompiled with Potassium's decompiler.

return function(p1: string, p2: string, p3: number?) -- Line: 1, Name: lastIndexOf
    local string_len_ret = string.len(p1);
    local v4 = p3 and p3 < 1 and 1 or (p3 or string_len_ret);

    if p3 then
        if string_len_ret >= p3 then
            string_len_ret = v4;
        end;
    else
        string_len_ret = v4;
    end;

    if p2 == "" then
        return string_len_ret;
    end;

    local v5 = nil;
    local v6 = 0;

    while true do
        local v7;
        v7, v6 = string.find(p1, p2, v6 + 1, true);

        if v7 == nil or string_len_ret < v7 then
            break;
        end;

        v5 = v7;
    end;

    return v5 == nil and -1 or v5;
end;