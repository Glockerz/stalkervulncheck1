-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: number, p3: number?, ...) -- Line: 7
    if #p1 < p2 then
        for i = 1, select("#", ...) do
            local v4 = select(i, ...);
            table.insert(p1, v4);
            local _ = i;
        end;

        return {};
    end;

    local v5 = #p1;

    if p2 < 1 then
        local v6 = v5 - math.abs(p2);
        p2 = math.max(v6, 1);
    end;

    local v7 = {};
    local v8 = p3 or v5;

    if v8 > 0 then
        local v9 = p2 + math.max(0, v8 - 1);

        for i = p2, math.min(v5, v9) do
            local table_remove_ret = table.remove(p1, p2);
            table.insert(v7, table_remove_ret);
            local _ = i;
        end;
    end;

    for i = select("#", ...), 1, -1 do
        local v10 = select(i, ...);
        table.insert(p1, p2, v10);
        local _ = i;
    end;

    return v7;
end;