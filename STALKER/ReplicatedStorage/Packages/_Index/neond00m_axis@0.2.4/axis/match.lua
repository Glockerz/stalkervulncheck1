-- Decompiled with Potassium's decompiler.

return function(u1, ...) -- Line: 12
    local u2 = { ... };

    return function(p3: table) -- Line: 14
        -- upvalues: u1 (copy), u2 (copy)
        local v4 = type(p3) == "table";
        assert(v4, "cases needs to be table");

        for i = 1, #p3, 2 do
            if u1 == p3[i] then
                local v5 = p3[i + 1];

                if type(v5) == "function" then
                    return v5(u1, unpack(u2));
                end;

                return v5;
            end;

            local _ = i;
        end;

        return nil;
    end;
end;