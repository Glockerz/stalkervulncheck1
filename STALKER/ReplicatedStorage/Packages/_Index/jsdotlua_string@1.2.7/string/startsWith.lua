-- Decompiled with Potassium's decompiler.

return function(p1: string, p2: string, p3: number?) -- Line: 1, Name: startsWith
    if string.len(p2) == 0 then
        return true;
    end;

    local v4 = (p3 == nil or p3 < 1) and 1 or p3;

    if string.len(p1) < v4 then
        return false;
    end;

    return p1:find(p2, v4, true) == v4;
end;