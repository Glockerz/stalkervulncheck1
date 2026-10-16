-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1) -- Line: 5
    if p1 == nil then
        error("cannot extract values from a nil value");
    end;

    local v2 = typeof(p1);
    local v3 = nil;

    if v2 ~= "table" then
        if v2 == "string" then
            local v4 = p1:len();
            v3 = table.create(v4);

            for i = 1, v4 do
                v3[i] = p1:sub(i, i);
                local _ = i;
            end;
        end;

        return v3;
    end;

    local v5 = {};

    for _, v in pairs(p1) do
        table.insert(v5, v);
    end;

    return v5;
end;