-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("common"));
local u1 = {};
u1.__index = u1;

function u1.handle(p2: table, p3: function) -- Line: 28
    p2.handle_callback = p3;
end;

function create(p4: string, p5: function?)
    -- upvalues: u1 (copy)
    return setmetatable({
        identifier = p4,
        handle_callback = p5
    }, u1);
end;

return {
    create = create
};