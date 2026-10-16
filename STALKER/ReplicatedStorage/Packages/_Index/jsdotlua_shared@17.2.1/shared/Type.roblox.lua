-- Decompiled with Potassium's decompiler.

local u1 = require(script.Parent:WaitForChild("Symbol.roblox"));
local u2 = newproxy(true);
local u3 = {};

local function addType(p4) -- Line: 32
    -- upvalues: u3 (copy), u1 (copy)
    u3[p4] = u1.named("Roact" .. p4);
end;

u3.HostChangeEvent = u1.named("RoactHostChangeEvent");
u3.HostEvent = u1.named("RoactHostEvent");

function u3.of(p5) -- Line: 39
    -- upvalues: u2 (copy)
    if typeof(p5) == "table" then
        return p5[u2];
    end;

    return nil;
end;

getmetatable(u2).__index = u3;

getmetatable(u2).__tostring = function() -- Line: 49
    return "RoactType";
end;

return u2;