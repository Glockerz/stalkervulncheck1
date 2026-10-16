-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local supportsTestSelectors = require(script.Parent:WaitForChild("ReactFiberHostConfig")).supportsTestSelectors;
local v1 = {};
local u2 = {};

function v1.onCommitRoot() -- Line: 511
    -- upvalues: supportsTestSelectors (copy), u2 (copy)
    if supportsTestSelectors then
        for _, v in u2 do
            v();
        end;
    end;
end;

return v1;