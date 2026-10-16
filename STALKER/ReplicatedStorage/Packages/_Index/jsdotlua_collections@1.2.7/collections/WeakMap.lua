-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent:WaitForChild("es7-types"));
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 19
    -- upvalues: u1 (copy)
    local v2 = {
        _weakMap = setmetatable({}, {
            __mode = "k"
        })
    };

    return setmetatable(v2, u1);
end;

function u1.get(p3, p4) -- Line: 24
    return p3._weakMap[p4];
end;

function u1.set(p5, p6, p7) -- Line: 28
    p5._weakMap[p6] = p7;

    return p5;
end;

function u1.has(p8, p9) -- Line: 33
    return p8._weakMap[p9] ~= nil;
end;

return u1;