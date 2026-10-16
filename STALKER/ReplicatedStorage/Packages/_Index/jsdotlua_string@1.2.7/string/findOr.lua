-- Decompiled with Potassium's decompiler.

local u1 = "([" .. ("$%^()-[].?"):gsub("(.)", "%%%1") .. "])";

return function(p2: string, p3: table, p4: number?) -- Line: 9, Name: findOr
    -- upvalues: u1 (copy)
    local utf8_offset_ret = utf8.offset(p2, p4 or 1);
    local v5 = {};

    for _, v in p3 do
        local v6 = v:gsub(u1, "%%%1");
        local string_find_ret, v7 = string.find(p2, v6, utf8_offset_ret);

        if string_find_ret then
            local string_sub_ret = string.sub(p2, 1, string_find_ret - 1);
            local utf8_len_ret, v8 = utf8.len(string_sub_ret);

            if utf8_len_ret == nil then
                error(("string `%s` has an invalid byte at position %s"):format(string_sub_ret, (tostring(v8))));
            end;

            local v9 = {
                index = utf8_len_ret + 1,
                match = string.sub(p2, string_find_ret, v7)
            };
            table.insert(v5, v9);
        end;
    end;

    if #v5 == 0 then
        return nil;
    end;

    local v10 = nil;

    for _, v in v5 do
        if v10 == nil then
            v10 = v;
        end;

        if v.index < v10.index then
            v10 = v;
        end;
    end;

    return v10;
end;