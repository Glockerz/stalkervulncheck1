-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local _ = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols.REACT_FORWARD_REF_TYPE;

return {
    resolveFunctionForHotReloading = function(p1) -- Line: 82, Name: resolveFunctionForHotReloading
        if _G.__DEV__ then
            return p1;
        end;

        return p1;
    end,

    resolveClassForHotReloading = function(p2) -- Line: 100, Name: resolveClassForHotReloading
        if _G.__DEV__ then
            return p2;
        end;

        return p2;
    end,

    resolveForwardRefForHotReloading = function(p3) -- Line: 106, Name: resolveForwardRefForHotReloading
        if _G.__DEV__ then
            return p3;
        end;

        return p3;
    end,

    isCompatibleFamilyForHotReloading = function(p4, p5) -- Line: 144
        warn("isCompatibleFamilyForHotReloading is stubbed (returns false)");

        return false;
    end,

    markFailedErrorBoundaryForHotReloading = function(p6) -- Line: 224
        if _G.__DEV__ then
        end;
    end
};