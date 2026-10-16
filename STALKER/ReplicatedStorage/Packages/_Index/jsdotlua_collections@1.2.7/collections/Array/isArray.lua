-- Decompiled with Potassium's decompiler.

return function(p1) -- Line: 1
    if typeof(p1) ~= "table" then
        return false;
    end;

    if next(p1) == nil then
        return true;
    end;

    if #p1 == 0 then
        return false;
    end;

    local v2 = 0;
    local v3 = 0;

    for i in pairs(p1) do
        if typeof(i) ~= "number" then
            return false;
        end;

        if i % 1 ~= 0 or i < 1 then
            return false;
        end;

        v2 = v2 + 1;
        v3 = v3 + i;
    end;

    return v3 == v2 * (v2 + 1) / 2;
end;