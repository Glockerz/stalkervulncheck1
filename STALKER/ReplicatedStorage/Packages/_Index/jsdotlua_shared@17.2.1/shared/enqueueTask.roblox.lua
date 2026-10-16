-- Decompiled with Potassium's decompiler.

local setTimeout = require(script.Parent.Parent:WaitForChild("luau-polyfill")).setTimeout;

return function(p1) -- Line: 13
    -- upvalues: setTimeout (copy)
    return setTimeout(p1, 0);
end;