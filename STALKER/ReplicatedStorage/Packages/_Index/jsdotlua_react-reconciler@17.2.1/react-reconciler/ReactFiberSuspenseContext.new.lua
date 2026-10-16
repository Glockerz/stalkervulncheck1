-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("ReactInternalTypes"));
local v1 = require(script.Parent:WaitForChild("ReactFiberStack.new"));
local push = v1.push;
local pop = v1.pop;
local v2 = {
    InvisibleParentSuspenseContext = 1,
    ForceSuspenseFallback = 2
};
local u3 = v1.createCursor(0);
v2.suspenseStackCursor = u3;

function v2.hasSuspenseContext(p4: number, p5: number) -- Line: 59
    return bit32.band(p4, p5) ~= 0;
end;

function v2.setDefaultShallowSuspenseContext(p6: number) -- Line: 66
    return bit32.band(p6, 1);
end;

function v2.setShallowSuspenseContext(p7: number, p8: number) -- Line: 72
    local bit32_band_ret = bit32.band(p7, 1);

    return bit32.bor(bit32_band_ret, p8);
end;

function v2.addSubtreeSuspenseContext(p9: number, p10: number) -- Line: 82
    return bit32.bor(p9, p10);
end;

function v2.pushSuspenseContext(p11: any, p12: number) -- Line: 89
    -- upvalues: push (copy), u3 (copy)
    push(u3, p12, p11);
end;

function v2.popSuspenseContext(p13) -- Line: 93
    -- upvalues: pop (copy), u3 (copy)
    pop(u3, p13);
end;

return v2;