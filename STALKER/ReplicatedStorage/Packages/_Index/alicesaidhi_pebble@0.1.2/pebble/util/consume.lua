-- Decompiled with Potassium's decompiler.

return function(p1: table, p2: string) -- Line: 7
    local v3 = p1[p2];
    p1[p2] = nil;

    return v3;
end;