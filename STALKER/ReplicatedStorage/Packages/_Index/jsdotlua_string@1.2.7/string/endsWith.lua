-- Decompiled with Potassium's decompiler.

return function(p1: string, p2: string, p3: number?) -- Line: 1, Name: endsWith
    local v4 = p2:len();

    if v4 == 0 then
        return true;
    end;

    local v5 = p1:len();
    local v6 = p3 or v5;

    if v5 >= v6 then
        v5 = v6;
    end;

    if v5 < 1 then
        return false;
    end;

    local v7 = v5 - v4 + 1;

    return p1:find(p2, v7, true) == v7;
end;