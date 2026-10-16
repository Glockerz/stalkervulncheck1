-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

return function(p1) -- Line: 8, Name: preventExtensions
    local u2 = tostring(p1);

    return setmetatable(p1, {
        __metatable = false,

        __newindex = function(p3, p4, p5) -- Line: 13, Name: __newindex
            -- upvalues: u2 (copy)
            local v6 = ("%q (%s) is not a valid member of %s"):format(tostring(p4), typeof(p4), u2);
            error(v6, 2);
        end
    });
end;