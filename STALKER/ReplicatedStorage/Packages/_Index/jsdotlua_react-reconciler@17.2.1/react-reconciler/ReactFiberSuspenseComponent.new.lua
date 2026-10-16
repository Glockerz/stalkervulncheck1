-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"));
require(script.Parent:WaitForChild("ReactFiberLane"));
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local NoFlags = ReactFiberFlags.NoFlags;
local DidCapture = ReactFiberFlags.DidCapture;
local isSuspenseInstancePending = ReactFiberHostConfig.isSuspenseInstancePending;
local isSuspenseInstanceFallback = ReactFiberHostConfig.isSuspenseInstanceFallback;

return {
    shouldCaptureSuspense = function(p1: any, p2: boolean) -- Line: 83
        local memoizedState = p1.memoizedState;

        if memoizedState then
            return memoizedState.dehydrated ~= nil;
        end;

        local memoizedProps = p1.memoizedProps;

        if memoizedProps.fallback == nil then
            return false;
        end;

        return memoizedProps.unstable_avoidThisFallback ~= true and true or not p2;
    end,

    findFirstSuspended = function(p3) -- Line: 112
        -- upvalues: SuspenseComponent (copy), isSuspenseInstancePending (copy), isSuspenseInstanceFallback (copy), SuspenseListComponent (copy), DidCapture (copy), NoFlags (copy)
        local v4 = p3;

        while true do
            while true do
                if p3 == nil then
                    return nil;
                end;

                if p3.tag == SuspenseComponent then
                    break;
                end;

                if p3.tag == SuspenseListComponent and p3.memoizedProps.revealOrder ~= nil then
                    if bit32.band(p3.flags, DidCapture) ~= NoFlags then
                        return p3;
                    end;

                    if p3 == v4 then
                        return nil;
                    end;

                    while p3.sibling == nil do
                        if p3.return_ == nil or p3.return_ == v4 then
                            return nil;
                        end;

                        p3 = p3.return_;
                    end;

                    p3.sibling.return_ = p3.return_;
                    p3 = p3.sibling;
                end;

                if p3.child == nil then
                    if p3 == v4 then
                        return nil;
                    end;

                    while p3.sibling == nil do
                        if p3.return_ == nil or p3.return_ == v4 then
                            return nil;
                        end;

                        p3 = p3.return_;
                    end;

                    p3.sibling.return_ = p3.return_;
                    p3 = p3.sibling;
                end;

                p3.child.return_ = p3;
                p3 = p3.child;
            end;

            local memoizedState = p3.memoizedState;

            if memoizedState then
                local dehydrated = memoizedState.dehydrated;

                if dehydrated == nil or (isSuspenseInstancePending(dehydrated) or isSuspenseInstanceFallback(dehydrated)) then
                    return p3;
                end;
            end;

            if p3 == v4 then
                return nil;
            end;

            while p3.sibling == nil do
                if p3.return_ == nil or p3.return_ == v4 then
                    return nil;
                end;

                p3 = p3.return_;
            end;

            p3.sibling.return_ = p3.return_;
            p3 = p3.sibling;
        end;
    end
};