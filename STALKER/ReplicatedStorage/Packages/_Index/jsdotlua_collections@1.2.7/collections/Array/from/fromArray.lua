-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: function?, p3: any) -- Line: 8
    if not p2 then
        return table.clone(p1);
    end;

    local v4 = #p1;
    local table_create_ret = table.create(v4);

    for i = 1, v4 do
        local v5;

        if p3 == nil then
            table_create_ret[i] = p2(p1[i], i);
            v5 = i;
        else
            table_create_ret[i] = p2(p3, p1[i], i);
            v5 = i;
        end;
    end;

    return table_create_ret;
end;