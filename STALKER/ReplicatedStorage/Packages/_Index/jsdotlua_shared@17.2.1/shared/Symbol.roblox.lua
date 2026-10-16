-- Decompiled with Potassium's decompiler.

return {
    named = function(p1) -- Line: 30, Name: named
        local v2 = type(p1) == "string";
        assert(v2, "Symbols must be created using a string name!");
        local v3 = newproxy(true);
        local string_format_ret = string.format("Symbol(%s)", p1);

        getmetatable(v3).__tostring = function() -- Line: 37
            -- upvalues: string_format_ret (copy)
            return string_format_ret;
        end;

        return v3;
    end
};