-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;

local function unimplemented(p1: string) -- Line: 16
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. p1);
    error("FIXME (roblox): " .. p1 .. " is unimplemented", 2);
end;

require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"));
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"));
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local HostComponent = ReactWorkTags.HostComponent;
local HostText = ReactWorkTags.HostText;
local HostRoot = ReactWorkTags.HostRoot;
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local Placement = ReactFiberFlags.Placement;
local Hydrating = ReactFiberFlags.Hydrating;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local createFiberFromDehydratedFragment = require(script.Parent:WaitForChild("ReactFiber.new")).createFiberFromDehydratedFragment;
local supportsHydration = ReactFiberHostConfig.supportsHydration;
local getNextHydratableSibling = ReactFiberHostConfig.getNextHydratableSibling;
local getFirstHydratableChild = ReactFiberHostConfig.getFirstHydratableChild;
local canHydrateInstance = ReactFiberHostConfig.canHydrateInstance;
local canHydrateTextInstance = ReactFiberHostConfig.canHydrateTextInstance;
local canHydrateSuspenseInstance = ReactFiberHostConfig.canHydrateSuspenseInstance;
local hydrateInstance = ReactFiberHostConfig.hydrateInstance;
local hydrateTextInstance = ReactFiberHostConfig.hydrateTextInstance;
local hydrateSuspenseInstance = ReactFiberHostConfig.hydrateSuspenseInstance;
local getNextHydratableInstanceAfterSuspenseInstance = ReactFiberHostConfig.getNextHydratableInstanceAfterSuspenseInstance;
local didNotMatchHydratedContainerTextInstance = ReactFiberHostConfig.didNotMatchHydratedContainerTextInstance;
local didNotMatchHydratedTextInstance = ReactFiberHostConfig.didNotMatchHydratedTextInstance;
local shouldSetTextContent = ReactFiberHostConfig.shouldSetTextContent;
local enableSuspenseServerRenderer = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableSuspenseServerRenderer;
local OffscreenLane = require(script.Parent:WaitForChild("ReactFiberLane")).OffscreenLane;
local u2 = nil;
local u3 = nil;
local u4 = false;

function warnIfHydrating()
    -- upvalues: u4 (ref), console (copy)
    if _G.__DEV__ and u4 then
        console.error("We should not be hydrating here. This is a bug in React. Please file a bug.");
    end;
end;

function enterHydrationState(p5)
    -- upvalues: supportsHydration (copy), u3 (ref), getFirstHydratableChild (copy), u2 (ref), u4 (ref)
    if not supportsHydration then
        return false;
    end;

    u3 = getFirstHydratableChild(p5.stateNode.containerInfo);
    u2 = p5;
    u4 = true;

    return true;
end;

function reenterHydrationStateFromDehydratedSuspenseInstance(p6, p7)
    -- upvalues: supportsHydration (copy), u3 (ref), getNextHydratableSibling (copy), u4 (ref)
    if not supportsHydration then
        return false;
    end;

    u3 = getNextHydratableSibling(p7);
    popToNextHostParent(p6);
    u4 = true;

    return true;
end;

function deleteHydratableInstance(p8, p9)
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: deleteHydratableInstance");
    error("FIXME (roblox): deleteHydratableInstance is unimplemented", 2);
end;

function insertNonHydratedInstance(p10, p11)
    -- upvalues: Hydrating (copy), Placement (copy)
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: insertNonHydratedInstance");
    error("FIXME (roblox): insertNonHydratedInstance is unimplemented", 2);
    local flags = p11.flags;
    local bit32_bnot_ret = bit32.bnot(Hydrating);
    local bit32_band_ret = bit32.band(flags, bit32_bnot_ret);
    p11.flags = bit32.bor(bit32_band_ret, Placement);
    local _ = _G.__DEV__;
end;

function tryHydrate(p12, p13)
    -- upvalues: HostComponent (copy), canHydrateInstance (copy), HostText (copy), canHydrateTextInstance (copy), SuspenseComponent (copy), enableSuspenseServerRenderer (copy), canHydrateSuspenseInstance (copy), OffscreenLane (copy), createFiberFromDehydratedFragment (copy)
    if p12.tag == HostComponent then
        local v14 = canHydrateInstance(p13, p12.type, p12.pendingProps);

        if v14 == nil then
            return false;
        end;

        p12.stateNode = v14;

        return true;
    end;

    if p12.tag ~= HostText then
        if p12.tag ~= SuspenseComponent then
            return false;
        end;

        if enableSuspenseServerRenderer then
            local v15 = canHydrateSuspenseInstance(p13);

            if v15 ~= nil then
                p12.memoizedState = {
                    dehydrated = v15,
                    retryLane = OffscreenLane
                };
                local v16 = createFiberFromDehydratedFragment(v15);
                v16.return_ = p12;
                p12.child = v16;

                return true;
            end;
        end;

        return false;
    end;

    local v17 = canHydrateTextInstance(p13, p12.pendingProps);

    if v17 == nil then
        return false;
    end;

    p12.stateNode = v17;

    return true;
end;

function tryToClaimNextHydratableInstance(p18)
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), getNextHydratableSibling (copy), getFirstHydratableChild (copy)
    if not u4 then
        return;
    end;

    local v19 = u3;

    if v19 then
        local v20;

        if tryHydrate(p18, v19) then
            v20 = v19;
        else
            v20 = getNextHydratableSibling(v19);

            if not (v20 and tryHydrate(p18, v20)) then
                insertNonHydratedInstance(u2, p18);
                u4 = false;
                u2 = p18;

                return;
            end;

            deleteHydratableInstance(u2, v19);
        end;

        u2 = p18;
        u3 = getFirstHydratableChild(v20);

        return;
    end;

    insertNonHydratedInstance(u2, p18);
    u4 = false;
    u2 = p18;
end;

function prepareToHydrateHostInstance(p21, p22, p23)
    -- upvalues: supportsHydration (copy), invariant (copy), hydrateInstance (copy)
    if not supportsHydration then
        invariant(
            false,
            "Expected prepareToHydrateHostInstance() to never be called. This error is likely caused by a bug in React. Please file an issue."
        );
    end;

    local v24 = hydrateInstance(p21.stateNode, p21.type, p21.memoizedProps, p22, p23, p21);
    p21.updateQueue = v24;

    return v24 ~= nil;
end;

function prepareToHydrateHostTextInstance(p25)
    -- upvalues: supportsHydration (copy), invariant (copy), hydrateTextInstance (copy), u2 (ref), HostRoot (copy), didNotMatchHydratedContainerTextInstance (copy), HostComponent (copy), didNotMatchHydratedTextInstance (copy)
    if not supportsHydration then
        invariant(
            false,
            "Expected prepareToHydrateHostTextInstance() to never be called. This error is likely caused by a bug in React. Please file an issue."
        );
    end;

    local stateNode = p25.stateNode;
    local memoizedProps = p25.memoizedProps;
    local v26 = hydrateTextInstance(stateNode, memoizedProps, p25);

    if _G.__DEV__ and v26 then
        local v27 = u2;

        if v27 ~= nil then
            if v27.tag == HostRoot then
                didNotMatchHydratedContainerTextInstance(v27.stateNode.containerInfo, stateNode, memoizedProps);

                return v26;
            end;

            if v27.tag == HostComponent then
                didNotMatchHydratedTextInstance(v27.type, v27.memoizedProps, v27.stateNode, stateNode, memoizedProps);
            end;
        end;
    end;

    return v26;
end;

function prepareToHydrateHostSuspenseInstance(p28)
    -- upvalues: supportsHydration (copy), invariant (copy), hydrateSuspenseInstance (copy)
    if not supportsHydration then
        invariant(
            false,
            "Expected prepareToHydrateHostSuspenseInstance() to never be called. This error is likely caused by a bug in React. Please file an issue."
        );
    end;

    local memoizedState = p28.memoizedState;
    local v29;

    if memoizedState == nil then
        v29 = nil;
    else
        v29 = memoizedState.dehydrated;
    end;

    invariant(v29, "Expected to have a hydrated suspense instance. This error is likely caused by a bug in React. Please file an issue.");
    hydrateSuspenseInstance(v29, p28);
end;

function skipPastDehydratedSuspenseInstance(p30)
    -- upvalues: supportsHydration (copy), invariant (copy), getNextHydratableInstanceAfterSuspenseInstance (copy)
    if not supportsHydration then
        invariant(
            false,
            "Expected skipPastDehydratedSuspenseInstance() to never be called. This error is likely caused by a bug in React. Please file an issue."
        );
    end;

    local memoizedState = p30.memoizedState;
    local v31;

    if memoizedState == nil then
        v31 = nil;
    else
        v31 = memoizedState.dehydrated;
    end;

    invariant(v31, "Expected to have a hydrated suspense instance. This error is likely caused by a bug in React. Please file an issue.");

    return getNextHydratableInstanceAfterSuspenseInstance(v31);
end;

function popToNextHostParent(p32)
    -- upvalues: HostComponent (copy), HostRoot (copy), SuspenseComponent (copy), u2 (ref)
    local return_ = p32.return_;

    while return_ ~= nil and (return_.tag ~= HostComponent and (return_.tag ~= HostRoot and return_.tag ~= SuspenseComponent)) do
        return_ = return_.return_;
    end;

    u2 = return_;
end;

function popHydrationState(p33)
    -- upvalues: supportsHydration (copy), u2 (ref), u4 (ref), HostComponent (copy), shouldSetTextContent (copy), u3 (ref), getNextHydratableSibling (copy), SuspenseComponent (copy)
    if not supportsHydration then
        return false;
    end;

    if p33 ~= u2 then
        return false;
    end;

    if not u4 then
        popToNextHostParent(p33);
        u4 = true;

        return false;
    end;

    local type = p33.type;

    if p33.tag ~= HostComponent or type ~= "head" and (type ~= "body" and not shouldSetTextContent(type, p33.memoizedProps)) then
        local v34 = u3;

        while v34 do
            deleteHydratableInstance(p33, v34);
            v34 = getNextHydratableSibling(v34);
        end;
    end;

    popToNextHostParent(p33);

    if p33.tag == SuspenseComponent then
        u3 = skipPastDehydratedSuspenseInstance(p33);
    elseif u2 then
        u3 = getNextHydratableSibling(p33.stateNode);
    else
        u3 = nil;
    end;

    return true;
end;

function resetHydrationState()
    -- upvalues: supportsHydration (copy), u2 (ref), u3 (ref), u4 (ref)
    if not supportsHydration then
        return;
    end;

    u2 = nil;
    u3 = nil;
    u4 = false;
end;

function getIsHydrating()
    -- upvalues: u4 (ref)
    return u4;
end;

return {
    warnIfHydrating = warnIfHydrating,
    enterHydrationState = enterHydrationState,
    getIsHydrating = getIsHydrating,
    reenterHydrationStateFromDehydratedSuspenseInstance = reenterHydrationStateFromDehydratedSuspenseInstance,
    resetHydrationState = resetHydrationState,
    tryToClaimNextHydratableInstance = tryToClaimNextHydratableInstance,
    prepareToHydrateHostInstance = prepareToHydrateHostInstance,
    prepareToHydrateHostTextInstance = prepareToHydrateHostTextInstance,
    prepareToHydrateHostSuspenseInstance = prepareToHydrateHostSuspenseInstance,
    popHydrationState = popHydrationState
};