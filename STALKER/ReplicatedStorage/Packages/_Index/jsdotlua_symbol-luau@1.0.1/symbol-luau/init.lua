-- Decompiled with Potassium's decompiler.

local Symbol = require(script:WaitForChild("Symbol"));
local v1 = require(script:WaitForChild("Registry.global"));
local v4 = setmetatable({}, {
    __call = function(p2: any, p3: string?) -- Line: 15, Name: __call
        -- upvalues: Symbol (copy)
        return Symbol.new(p3);
    end
});
v4.for_ = v1.getOrInit;

return v4;