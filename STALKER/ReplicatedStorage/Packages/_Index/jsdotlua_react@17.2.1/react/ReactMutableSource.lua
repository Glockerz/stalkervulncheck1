-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent:WaitForChild("shared"));

return function(p1, p2) -- Line: 16, Name: createMutableSource
    local v3 = {
        _workInProgressVersionPrimary = nil,
        _workInProgressVersionSecondary = nil,
        _getVersion = p2,
        _source = p1
    };

    if _G.__DEV__ then
        v3._currentPrimaryRenderer = nil;
        v3._currentSecondaryRenderer = nil;
    end;

    return v3;
end;