-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: string, p2: function?, p3: any) -- Line: 8
    local v4 = #p1;
    local table_create_ret = table.create(v4);

    if p2 then
        for i = 1, v4 do
            local v5;

            if p3 == nil then
                table_create_ret[i] = p2(string.sub(p1, i, i), i);
                v5 = i;
            else
                table_create_ret[i] = p2(p3, string.sub(p1, i, i), i);
                v5 = i;
            end;
        end;

        return table_create_ret;
    end;

    for i = 1, v4 do
        table_create_ret[i] = string.sub(p1, i, i);
        local _ = i;
    end;

    return table_create_ret;
end;