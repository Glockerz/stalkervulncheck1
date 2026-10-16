-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: function) -- Line: 5
    for i = 1, #p1 do
        local v3 = p1[i];

        if p2(v3, i, p1) then
            return v3;
        end;

        local _ = i;
    end;

    return nil;
end;