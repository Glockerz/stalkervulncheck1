-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.__tostring(p2) -- Line: 8
    return p2._name;
end;

function u1.new(p3: string?) -- Line: 16
    -- upvalues: u1 (copy)
    local v4 = p3 or debug.info(2, "sl");

    return setmetatable({
        _type = "phase",
        _name = v4
    }, u1);
end;

u1.PreStartup = u1.new("PreStartup");
u1.Startup = u1.new("Startup");
u1.PostStartup = u1.new("PostStartup");

return u1;