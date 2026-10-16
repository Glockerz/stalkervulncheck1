-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: any, p3: number?) -- Line: 10
    local v4 = p3 or 1;
    local v5 = #p1;

    if v4 < 1 then
        local v6 = v5 - math.abs(v4);
        v4 = math.max(v6, 1);
    end;

    for i = v4, v5 do
        if p1[i] == p2 then
            return i;
        end;

        local _ = i;
    end;

    return -1;
end;