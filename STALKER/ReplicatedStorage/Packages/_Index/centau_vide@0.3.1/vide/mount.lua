-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local root = require(script.Parent.root);
local apply = require(script.Parent.apply);

return function(u1: function, u2: userdata?) -- Line: 6, Name: mount
    -- upvalues: root (copy), apply (copy)
    return root(function() -- Line: 7
        -- upvalues: u1 (copy), u2 (copy), apply (ref)
        local v3 = u1();

        if u2 then
            apply(u2, { v3 });
        end;
    end);
end;