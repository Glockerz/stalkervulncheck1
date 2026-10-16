-- Decompiled with Potassium's decompiler.

return function(u1, u2, u3) -- Line: 16
    local u4 = {};
    u4.__index = u4;

    function u4.__tostring(p5) -- Line: 19
        -- upvalues: u1 (copy)
        return getmetatable(u1).__tostring(p5);
    end;

    local v6 = {};

    function u4.new(...) -- Line: 25
        -- upvalues: u3 (copy), u4 (copy)
        local v7 = {};
        u3(v7, ...);

        return setmetatable(v7, u4);
    end;

    local v8 = getmetatable(u1);

    if typeof(v8) == "table" and getmetatable(u1).__call then
        function v6.__call(p9, ...) -- Line: 32
            -- upvalues: u4 (copy)
            return u4.new(...);
        end;
    end;

    v6.__index = u1;

    function v6.__tostring(p10) -- Line: 38
        -- upvalues: u4 (copy), u2 (copy), u1 (copy)
        if p10 == u4 then
            return tostring(u2);
        end;

        return getmetatable(u1).__tostring(p10);
    end;

    setmetatable(u4, v6);

    return u4;
end;