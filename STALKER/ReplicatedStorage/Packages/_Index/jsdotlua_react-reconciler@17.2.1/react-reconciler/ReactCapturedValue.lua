-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("ReactInternalTypes"));
local getStackByFiberInDevAndProd = require(script.Parent:WaitForChild("ReactFiberComponentStack")).getStackByFiberInDevAndProd;

return {
    createCapturedValue = function(p1, p2) -- Line: 26
        -- upvalues: getStackByFiberInDevAndProd (copy)
        return {
            value = p1,
            source = p2,
            stack = getStackByFiberInDevAndProd(p2)
        };
    end
};