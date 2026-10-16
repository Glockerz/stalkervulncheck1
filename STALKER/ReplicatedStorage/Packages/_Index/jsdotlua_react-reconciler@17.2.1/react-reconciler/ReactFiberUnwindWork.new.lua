-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("ReactInternalTypes"));
require(script.Parent:WaitForChild("ReactFiberLane"));
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"));
local resetWorkInProgressVersions = require(script.Parent:WaitForChild("ReactMutableSource.new")).resetWorkInProgressVersions;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"));
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableSuspenseServerRenderer = ReactFeatureFlags.enableSuspenseServerRenderer;
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer;
local v1 = require(script.Parent:WaitForChild("ReactFiberHostContext.new"));
local popHostContainer = v1.popHostContainer;
local popHostContext = v1.popHostContext;
local popSuspenseContext = require(script.Parent:WaitForChild("ReactFiberSuspenseContext.new")).popSuspenseContext;
local resetHydrationState = require(script.Parent:WaitForChild("ReactFiberHydrationContext.new")).resetHydrationState;
local v2 = require(script.Parent:WaitForChild("ReactFiberContext.new"));
local isContextProvider = v2.isContextProvider;
local popContext = v2.popContext;
local popTopLevelContextObject = v2.popTopLevelContextObject;
local popProvider = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).popProvider;
local u3 = nil;

local function u4(...) -- Line: 44
    -- upvalues: u3 (ref)
    if not u3 then
        u3 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new")).popRenderLanes;
    end;

    return u3(...);
end;

local transferActualDuration = require(script.Parent:WaitForChild("ReactProfilerTimer.new")).transferActualDuration;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;

function unwindInterruptedWork(p5)
    -- upvalues: ReactWorkTags (copy), popContext (copy), popHostContainer (copy), popTopLevelContextObject (copy), resetWorkInProgressVersions (copy), popHostContext (copy), popSuspenseContext (copy), popProvider (copy), u4 (copy)
    if p5.tag == ReactWorkTags.ClassComponent then
        local v6;

        if typeof(p5.type) == "table" then
            v6 = p5.type.childContextTypes;
        else
            v6 = nil;
        end;

        if v6 == nil then
            return;
        end;

        popContext(p5);

        return;
    end;

    if p5.tag == ReactWorkTags.HostRoot then
        popHostContainer(p5);
        popTopLevelContextObject(p5);
        resetWorkInProgressVersions();

        return;
    end;

    if p5.tag == ReactWorkTags.HostComponent then
        popHostContext(p5);

        return;
    end;

    if p5.tag == ReactWorkTags.HostPortal then
        popHostContainer(p5);

        return;
    end;

    if p5.tag == ReactWorkTags.SuspenseComponent then
        popSuspenseContext(p5);

        return;
    end;

    if p5.tag == ReactWorkTags.SuspenseListComponent then
        popSuspenseContext(p5);

        return;
    end;

    if p5.tag == ReactWorkTags.ContextProvider then
        popProvider(p5);

        return;
    end;

    if p5.tag ~= ReactWorkTags.OffscreenComponent and p5.tag ~= ReactWorkTags.LegacyHiddenComponent then
        return;
    end;

    u4(p5);
end;

return {
    unwindWork = function(p7, p8) -- Line: 55, Name: unwindWork
        -- upvalues: ReactWorkTags (copy), isContextProvider (copy), popContext (copy), ReactFiberFlags (copy), enableProfilerTimer (copy), ReactTypeOfMode (copy), transferActualDuration (copy), popHostContainer (copy), popTopLevelContextObject (copy), resetWorkInProgressVersions (copy), invariant (copy), popHostContext (copy), popSuspenseContext (copy), enableSuspenseServerRenderer (copy), resetHydrationState (copy), popProvider (copy), u4 (copy)
        if p7.tag == ReactWorkTags.ClassComponent then
            if isContextProvider(p7.type) then
                popContext(p7);
            end;

            local flags = p7.flags;

            if bit32.band(flags, ReactFiberFlags.ShouldCapture) == 0 then
                return nil;
            end;

            local bit32_bnot_ret = bit32.bnot(ReactFiberFlags.ShouldCapture);
            local bit32_band_ret = bit32.band(flags, bit32_bnot_ret);
            p7.flags = bit32.bor(bit32_band_ret, ReactFiberFlags.DidCapture);

            if enableProfilerTimer and bit32.band(p7.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
                transferActualDuration(p7);
            end;

            return p7;
        end;

        if p7.tag == ReactWorkTags.HostRoot then
            popHostContainer(p7);
            popTopLevelContextObject(p7);
            resetWorkInProgressVersions();
            local flags = p7.flags;
            invariant(bit32.band(flags, ReactFiberFlags.DidCapture) == ReactFiberFlags.NoFlags, "The root failed to unmount after an error. This is likely a bug in React. Please file an issue.");
            local bit32_bnot_ret = bit32.bnot(ReactFiberFlags.ShouldCapture);
            local bit32_band_ret = bit32.band(flags, bit32_bnot_ret);
            p7.flags = bit32.bor(bit32_band_ret, ReactFiberFlags.DidCapture);

            return p7;
        end;

        if p7.tag == ReactWorkTags.HostComponent then
            popHostContext(p7);

            return nil;
        end;

        if p7.tag ~= ReactWorkTags.SuspenseComponent then
            if p7.tag == ReactWorkTags.SuspenseListComponent then
                popSuspenseContext(p7);

                return nil;
            end;

            if p7.tag == ReactWorkTags.HostPortal then
                popHostContainer(p7);

                return nil;
            end;

            if p7.tag == ReactWorkTags.ContextProvider then
                popProvider(p7);

                return nil;
            end;

            if p7.tag ~= ReactWorkTags.OffscreenComponent and p7.tag ~= ReactWorkTags.LegacyHiddenComponent then
                return nil;
            end;

            u4(p7);

            return nil;
        end;

        popSuspenseContext(p7);

        if enableSuspenseServerRenderer then
            local memoizedState = p7.memoizedState;

            if memoizedState ~= nil and memoizedState.dehydrated ~= nil then
                invariant(p7.alternate ~= nil, "Threw in newly mounted dehydrated component. This is likely a bug in React. Please file an issue.");
                resetHydrationState();
            end;
        end;

        local flags = p7.flags;

        if bit32.band(flags, ReactFiberFlags.ShouldCapture) == 0 then
            return nil;
        end;

        local bit32_bnot_ret = bit32.bnot(ReactFiberFlags.ShouldCapture);
        local bit32_band_ret = bit32.band(flags, bit32_bnot_ret);
        p7.flags = bit32.bor(bit32_band_ret, ReactFiberFlags.DidCapture);

        if enableProfilerTimer and bit32.band(p7.mode, ReactTypeOfMode.ProfileMode) ~= ReactTypeOfMode.NoMode then
            transferActualDuration(p7);
        end;

        return p7;
    end,

    unwindInterruptedWork = unwindInterruptedWork
};