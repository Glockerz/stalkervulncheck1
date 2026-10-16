-- Decompiled with Potassium's decompiler.

return function(p1: string, p2: number, p3: number?) -- Line: 1
    if p3 and p3 <= 0 then
        return "";
    end;

    local v4;

    if p3 then
        v4 = p2 + p3 - 1 or nil;
    else
        v4 = nil;
    end;

    return string.sub(p1, p2, v4);
end;