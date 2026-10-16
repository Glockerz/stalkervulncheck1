-- Decompiled with Potassium's decompiler.

require(script:WaitForChild("ReactInternalTypes"));
require(script:WaitForChild("ReactRootTags"));

return function(p1) -- Line: 28, Name: initialize
    local ReactFiberHostConfig = require(script:WaitForChild("ReactFiberHostConfig"));

    for i, v in p1 do
        ReactFiberHostConfig[i] = v;
    end;

    return require(script:WaitForChild("ReactFiberReconciler"));
end;