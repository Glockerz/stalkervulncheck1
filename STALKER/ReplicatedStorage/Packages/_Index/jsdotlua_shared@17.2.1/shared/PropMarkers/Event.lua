-- Decompiled with Potassium's decompiler.

local u1 = require(script.Parent.Parent:WaitForChild("Type.roblox"));
local u2 = {};
local u4 = {
    __tostring = function(p3) -- Line: 35, Name: __tostring
        return string.format("RoactHostEvent(%s)", p3.name);
    end
};
setmetatable(u2, {
    __index = function(p5, p6) -- Line: 41, Name: __index
        -- upvalues: u1 (copy), u4 (copy), u2 (copy)
        local v7 = {
            [u1] = u1.HostEvent,
            name = p6
        };
        setmetatable(v7, u4);
        u2[p6] = v7;

        return v7;
    end
});

return u2;