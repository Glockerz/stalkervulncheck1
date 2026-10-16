-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: function?, p3: any) -- Line: 8
    if p2 then
        local v4 = {};

        for i, v in p1 do
            if p3 == nil then
                v4[i] = p2(v, i);
            else
                v4[i] = p2(p3, v, i);
            end;
        end;

        return v4;
    end;

    local v5 = {};

    for i, v in p1 do
        v5[i] = v;
    end;

    return v5;
end;