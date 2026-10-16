-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: number?, p3: number?) -- Line: 6
    if typeof(p1) ~= "table" then
        error(string.format("Array.slice called on %s", (typeof(p1))));
    end;

    local v4 = #p1;
    local v5 = p2 or 1;

    if p3 == nil or v4 + 1 < p3 then
        p3 = v4 + 1;
    end;

    if v4 + 1 < v5 then
        return {};
    end;

    local v6 = {};

    if v5 < 1 then
        local v7 = v4 - math.abs(v5);
        v5 = math.max(v7, 1);
    end;

    if p3 < 1 then
        local v8 = v4 - math.abs(p3);
        p3 = math.max(v8, 1);
    end;

    local v9 = 1;

    while v5 < p3 do
        v6[v9] = p1[v5];
        v5 = v5 + 1;
        v9 = v9 + 1;
    end;

    return v6;
end;