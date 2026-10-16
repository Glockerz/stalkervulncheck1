-- Decompiled with Potassium's decompiler.

local u1 = "([" .. ("$%^()-[].?"):gsub("(.)", "%%%1") .. "])";

return function(p2: string, p3: string, p4: number?) -- Line: 7
    -- upvalues: u1 (copy)
    local v5 = #p2;
    local v6 = p4 == nil and 1 or (p4 < 1 and 1 or p4);

    if #p3 == 0 then
        if v5 < v6 then
            return v5;
        end;

        return v6;
    end;

    if v5 < v6 then
        return -1;
    end;

    local v7 = p3:gsub(u1, "%%%1");
    local v8 = #v7;

    for i = v6, v5 do
        if string.sub(p2, i, i + v8 - 1) == v7 then
            return i;
        end;

        local _ = i;
    end;

    return -1;
end;