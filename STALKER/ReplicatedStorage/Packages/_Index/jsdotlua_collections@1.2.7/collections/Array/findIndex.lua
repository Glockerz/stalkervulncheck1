-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1: any, p2: function) -- Line: 5
    for i = 1, #p1 do
        if p2(p1[i], i, p1) then
            return i;
        end;

        local _ = i;
    end;

    return -1;
end;