-- Decompiled with Potassium's decompiler.

return {
    new = function(p1: string?) -- Line: 15, Name: new
        local v2 = newproxy(true);
        local u3 = not p1 and "Symbol()" or ("Symbol(%s)"):format(p1);

        getmetatable(v2).__tostring = function() -- Line: 23
            -- upvalues: u3 (ref)
            return u3;
        end;

        return v2;
    end
};