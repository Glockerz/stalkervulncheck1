-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1) -- Line: 6
    assert(p1 ~= nil, "cannot get entries from a nil value");
    local v2 = typeof(p1);
    local v3 = {};

    if v2 == "table" then
        for i, v in pairs(p1) do
            table.insert(v3, { i, v });
        end;

        return v3;
    end;

    if v2 == "string" then
        for i = 1, string.len(p1) do
            v3[i] = { tostring(i), (string.sub(p1, i, i)) };
            local _ = i;
        end;
    end;

    return v3;
end;