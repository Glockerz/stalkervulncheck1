-- Decompiled with Potassium's decompiler.

local ReactCurrentBatchConfig = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals.ReactCurrentBatchConfig;

return {
    NoTransition = 0,

    requestCurrentTransition = function() -- Line: 18, Name: requestCurrentTransition
        -- upvalues: ReactCurrentBatchConfig (copy)
        return ReactCurrentBatchConfig.transition;
    end
};