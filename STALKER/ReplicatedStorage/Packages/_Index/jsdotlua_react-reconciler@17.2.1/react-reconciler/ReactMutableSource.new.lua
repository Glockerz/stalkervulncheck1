-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local v1 = {};
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local isPrimaryRenderer = require(script.Parent:WaitForChild("ReactFiberHostConfig")).isPrimaryRenderer;
local u2 = {};
local u3 = _G.__DEV__ and {} or nil;

function v1.markSourceAsDirty(p4) -- Line: 37
    -- upvalues: u2 (copy)
    table.insert(u2, p4);
end;

function v1.resetWorkInProgressVersions() -- Line: 41
    -- upvalues: u2 (copy), isPrimaryRenderer (copy)
    for _, v in u2 do
        if isPrimaryRenderer then
            v._workInProgressVersionPrimary = nil;
        else
            v._workInProgressVersionSecondary = nil;
        end;
    end;

    table.clear(u2);
end;

function v1.getWorkInProgressVersion(p5) -- Line: 53
    -- upvalues: isPrimaryRenderer (copy)
    if isPrimaryRenderer then
        return p5._workInProgressVersionPrimary;
    end;

    return p5._workInProgressVersionSecondary;
end;

function v1.setWorkInProgressVersion(p6, p7) -- Line: 62
    -- upvalues: isPrimaryRenderer (copy), u2 (copy)
    if isPrimaryRenderer then
        p6._workInProgressVersionPrimary = p7;
    else
        p6._workInProgressVersionSecondary = p7;
    end;

    table.insert(u2, p6);
end;

function v1.warnAboutMultipleRenderersDEV(p8) -- Line: 71
    -- upvalues: isPrimaryRenderer (copy), u3 (ref), console (copy)
    if _G.__DEV__ then
        if isPrimaryRenderer then
            if p8._currentPrimaryRenderer == nil then
                p8._currentPrimaryRenderer = u3;

                return;
            end;

            if p8._currentPrimaryRenderer ~= u3 then
                console.error("Detected multiple renderers concurrently rendering the same mutable source. This is currently unsupported.");
            end;
        else
            if p8._currentSecondaryRenderer == nil then
                p8._currentSecondaryRenderer = u3;

                return;
            end;

            if p8._currentSecondaryRenderer ~= u3 then
                console.error("Detected multiple renderers concurrently rendering the same mutable source. This is currently unsupported.");
            end;
        end;
    end;
end;

function v1.registerMutableSourceForHydration(p9, p10) -- Line: 100
    local v11 = p10._getVersion(p10._source);

    if p9.mutableSourceEagerHydrationData == nil then
        p9.mutableSourceEagerHydrationData = { p10, v11 };
    end;
end;

return v1;