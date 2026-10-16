-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent:WaitForChild("ReactInternalTypes"));
require(script.Parent:WaitForChild("ReactFiberHostConfig"));
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"));
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local get = require(script.Parent.Parent:WaitForChild("shared")).ReactInstanceMap.get;
local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local ClassComponent = ReactWorkTags.ClassComponent;
local HostComponent = ReactWorkTags.HostComponent;
local HostRoot = ReactWorkTags.HostRoot;
local HostPortal = ReactWorkTags.HostPortal;
local HostText = ReactWorkTags.HostText;
local FundamentalComponent = ReactWorkTags.FundamentalComponent;
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local NoFlags = ReactFiberFlags.NoFlags;
local Placement = ReactFiberFlags.Placement;
local Hydrating = ReactFiberFlags.Hydrating;
local enableFundamentalAPI = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableFundamentalAPI;
local ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner;
local v1 = {};

local function getNearestMountedFiber(p2) -- Line: 47
    -- upvalues: Placement (copy), Hydrating (copy), NoFlags (copy), HostRoot (copy)
    local v3;

    if p2.alternate then
        v3 = p2;

        while p2.return_ do
            p2 = p2.return_;
        end;
    else
        v3 = p2;

        while true do
            local flags = p2.flags;
            local bit32_bor_ret = bit32.bor(Placement, Hydrating);

            if bit32.band(flags, bit32_bor_ret) ~= NoFlags then
                v3 = p2.return_;
            end;

            local return_ = p2.return_;

            if not return_ then
                break;
            end;

            p2 = return_;
        end;
    end;

    if p2.tag == HostRoot then
        return v3;
    end;

    return nil;
end;

v1.getNearestMountedFiber = getNearestMountedFiber;

function v1.getSuspenseInstanceFromFiber(p4) -- Line: 81
    -- upvalues: SuspenseComponent (copy)
    if p4.tag == SuspenseComponent then
        local memoizedState = p4.memoizedState;

        if memoizedState == nil then
            local alternate = p4.alternate;

            if alternate ~= nil then
                memoizedState = alternate.memoizedState;
            end;
        end;

        if memoizedState then
            return memoizedState.dehydrated;
        end;
    end;

    return nil;
end;

function v1.getContainerFromFiber(p5) -- Line: 97
    -- upvalues: HostRoot (copy)
    if p5.tag == HostRoot then
        return p5.stateNode.containerInfo;
    end;

    return nil;
end;

function v1.isFiberMounted(p6) -- Line: 101
    -- upvalues: getNearestMountedFiber (copy)
    return getNearestMountedFiber(p6) == p6;
end;

function v1.isMounted(p7) -- Line: 107
    -- upvalues: ReactCurrentOwner (copy), ClassComponent (copy), console (copy), getComponentName (copy), get (copy), getNearestMountedFiber (copy)
    if _G.__DEV__ then
        local current = ReactCurrentOwner.current;

        if current ~= nil and current.tag == ClassComponent then
            local stateNode = current.stateNode;

            if not stateNode._warnedAboutRefsInRender then
                console.error("%s is accessing isMounted inside its render() function. render() should be a pure function of props and state. It should never access something that requires stale data from the previous render, such as refs. Move this logic to componentDidMount and componentDidUpdate instead.", getComponentName(current.type) or "A component");
            end;

            stateNode._warnedAboutRefsInRender = true;
        end;
    end;

    local v8 = get(p7);

    if v8 then
        return getNearestMountedFiber(v8) == v8;
    end;

    return false;
end;

local function assertIsMounted(p9) -- Line: 137
    -- upvalues: invariant (copy), getNearestMountedFiber (copy)
    invariant(getNearestMountedFiber(p9) == p9, "Unable to find node on an unmounted component.");
end;

local function findCurrentFiberUsingSlowPath(p10) -- Line: 144
    -- upvalues: getNearestMountedFiber (copy), invariant (copy), HostRoot (copy)
    local alternate = p10.alternate;

    if not alternate then
        local v11 = getNearestMountedFiber(p10);
        invariant(v11 ~= nil, "Unable to find node on an unmounted component.");

        if v11 == p10 then
            return p10;
        end;

        return nil;
    end;

    local v12 = alternate;
    local v13 = p10;

    while true do
        local return_ = p10.return_;

        if return_ == nil then
            break;
        end;

        local alternate2 = return_.alternate;

        if alternate2 == nil then
            return_ = return_.return_;

            if return_ == nil then
                break;
            end;

            alternate2 = return_;
        else
            if return_.child == alternate2.child then
                local child = return_.child;

                while child do
                    if child == p10 then
                        invariant(getNearestMountedFiber(return_) == return_, "Unable to find node on an unmounted component.");

                        return v13;
                    end;

                    if child == alternate then
                        invariant(getNearestMountedFiber(return_) == return_, "Unable to find node on an unmounted component.");

                        return v12;
                    end;

                    child = child.sibling;
                end;

                invariant(false, "Unable to find node on an unmounted component.");
            end;

            if p10.return_ == alternate.return_ then
                local child = return_.child;
                local v14 = false;

                while child do
                    if child == p10 then
                        alternate = alternate2;
                        p10 = return_;
                        v14 = true;
                        break;
                    end;

                    if child == alternate then
                        alternate = return_;
                        p10 = alternate2;
                        v14 = true;
                        break;
                    end;

                    child = child.sibling;
                end;

                if v14 then
                    alternate2 = alternate;
                    return_ = p10;
                else
                    local child2 = alternate2.child;

                    while true do
                        if not child2 then
                            alternate2 = alternate;
                            return_ = p10;
                            break;
                        end;

                        if child2 == p10 then
                            local v15 = alternate2;
                            alternate2 = return_;
                            return_ = v15;
                            v14 = true;
                            break;
                        end;

                        if child2 == alternate then
                            v14 = true;
                            break;
                        end;

                        child2 = child2.sibling;
                    end;

                    invariant(v14, "Child was not found in either parent set. This indicates a bug in React related to the return pointer. Please file an issue.");
                end;
            end;

            invariant(return_.alternate == alternate2, "Return fibers should always be each others\' alternates. This error is likely caused by a bug in React. Please file an issue.");
        end;

        alternate = alternate2;
        p10 = return_;
    end;

    invariant(p10.tag == HostRoot, "Unable to find node on an unmounted component.");

    if p10.stateNode.current == p10 then
        return v13;
    end;

    return v12;
end;

v1.findCurrentFiberUsingSlowPath = findCurrentFiberUsingSlowPath;

function v1.findCurrentHostFiber(p16) -- Line: 279
    -- upvalues: findCurrentFiberUsingSlowPath (copy), HostComponent (copy), HostText (copy)
    local v17 = findCurrentFiberUsingSlowPath(p16);

    if not v17 then
        return nil;
    end;

    local v18 = v17;

    while true do
        local child = v17.child;

        if v17.tag == HostComponent or v17.tag == HostText then
            break;
        end;

        if child then
            child.return_ = v17;
        else
            if v17 == v18 then
                return nil;
            end;

            local return_ = v17.return_;
            child = v17.sibling;

            while not child do
                if not return_ or return_ == v18 then
                    return nil;
                end;
            end;

            child.return_ = return_;
        end;

        v17 = child;
    end;

    return v17;
end;

function v1.findCurrentHostFiberWithNoPortals(p19) -- Line: 318
    -- upvalues: findCurrentFiberUsingSlowPath (copy), HostComponent (copy), HostText (copy), enableFundamentalAPI (copy), FundamentalComponent (copy), HostPortal (copy)
    local v20 = findCurrentFiberUsingSlowPath(p19);

    if not v20 then
        return nil;
    end;

    local v21 = v20;

    while true do
        local child = v20.child;

        if v20.tag == HostComponent or (v20.tag == HostText or enableFundamentalAPI and v20.tag == FundamentalComponent) then
            break;
        end;

        if child and v20.tag ~= HostPortal then
            child.return_ = v20;
            v20 = child;
        else
            if v20 == v21 then
                return nil;
            end;

            local return_ = v20.return_;
            v20 = v20.sibling;

            while not v20 do
                if not return_ or return_ == v21 then
                    return nil;
                end;
            end;

            v20.return_ = return_;
        end;
    end;

    return v20;
end;

function v1.isFiberSuspenseAndTimedOut(p22) -- Line: 360
    -- upvalues: SuspenseComponent (copy)
    local memoizedState = p22.memoizedState;
    local v23;

    if p22.tag == SuspenseComponent and memoizedState ~= nil then
        v23 = memoizedState.dehydrated == nil;
    else
        v23 = false;
    end;

    return v23;
end;

function v1.doesFiberContain(p24, p25) -- Line: 367
    local alternate = p24.alternate;

    while p25 ~= nil do
        if p25 == p24 or p25 == alternate then
            return true;
        end;

        p25 = p25.return_;
    end;

    return false;
end;

return v1;