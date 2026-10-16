-- Decompiled with Potassium's decompiler.

return function(p1: table) -- Line: 3, Name: average
    local v2 = 0;

    for _, v in p1 do
        v2 = v2 + v;
    end;

    return v2 / #p1;
end;