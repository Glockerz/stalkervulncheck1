-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("ReactRobloxHostTypes.roblox"));
require(script.Parent.Parent.Parent:WaitForChild("react-reconciler"));
require(script.Parent.Parent.Parent:WaitForChild("shared"));
require(script.Parent.Parent.Parent:WaitForChild("react-reconciler"));
local ReactRobloxComponentTree = require(script.Parent:WaitForChild("ReactRobloxComponentTree"));
local markContainerAsRoot = ReactRobloxComponentTree.markContainerAsRoot;
local unmarkContainerAsRoot = ReactRobloxComponentTree.unmarkContainerAsRoot;
local v1 = require(script.Parent.Parent:WaitForChild("ReactReconciler.roblox"));
local createContainer = v1.createContainer;
local updateContainer = v1.updateContainer;
local invariant = require(script.Parent.Parent.Parent:WaitForChild("shared")).invariant;
local enableEagerRootListeners = require(script.Parent.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableEagerRootListeners;
local flushSync = v1.flushSync;
local flushPassiveEffects = v1.flushPassiveEffects;
local BlockingRoot = v1.ReactRootTags.BlockingRoot;
local ConcurrentRoot = v1.ReactRootTags.ConcurrentRoot;
local LegacyRoot = v1.ReactRootTags.LegacyRoot;
local u2 = nil;
local u3 = {};
u3.__index = u3;

function u3.new(p4, p5) -- Line: 63
    -- upvalues: u3 (copy), u2 (ref), ConcurrentRoot (copy)
    local v6 = setmetatable({}, u3);
    v6._internalRoot = u2(p4, ConcurrentRoot, p5);

    return v6;
end;

local function createBlockingRoot(p7, p8, p9) -- Line: 70
    -- upvalues: u3 (copy), u2 (ref)
    local v10 = setmetatable({}, u3);
    v10._internalRoot = u2(p7, p8, p9);

    return v10;
end;

function u3.render(p11, p12) -- Line: 82
    -- upvalues: updateContainer (copy)
    updateContainer(p12, p11._internalRoot, nil);
end;

function u3.unmount(p13) -- Line: 110
    -- upvalues: flushSync (copy), updateContainer (copy), unmarkContainerAsRoot (copy), flushPassiveEffects (copy)
    local _internalRoot = p13._internalRoot;
    local containerInfo = _internalRoot.containerInfo;
    flushSync(function() -- Line: 123
        -- upvalues: updateContainer (ref), _internalRoot (copy), unmarkContainerAsRoot (ref), containerInfo (copy)
        updateContainer(nil, _internalRoot, nil, function() -- Line: 124
            -- upvalues: unmarkContainerAsRoot (ref), containerInfo (ref)
            unmarkContainerAsRoot(containerInfo);
        end);
    end);
    flushPassiveEffects();
end;

u2 = function(p14, p15, p16) -- Line: 138
    -- upvalues: createContainer (copy), markContainerAsRoot (copy), enableEagerRootListeners (copy)
    local v17;

    if p16 == nil then
        v17 = false;
    else
        v17 = p16.hydrate == true;
    end;

    local v18;

    if p16 == nil then
        v18 = nil;
    else
        v18 = p16.hydrationOptions;
    end;

    local v19;

    if p16 == nil or p16.hydrationOptions == nil then
        v19 = nil;
    else
        v19 = p16.hydrationOptions.mutableSources or nil;
    end;

    local v20 = createContainer(p14, p15, v17, v18);
    markContainerAsRoot(v20.current, p14);

    return v20;
end;

local v30 = {
    isValidContainer = function(p21) -- Line: 186, Name: isValidContainer
        return typeof(p21) == "Instance";
    end,

    createRoot = function(p22, p23) -- Line: 203
        -- upvalues: invariant (copy), u3 (copy)
        invariant(typeof(p22) == "Instance", "createRoot(...): Target container is not a Roblox Instance.");
        warnIfReactDOMContainerInDEV(p22);

        return u3.new(p22, p23);
    end,

    createBlockingRoot = function(p24, p25) -- Line: 214
        -- upvalues: invariant (copy), BlockingRoot (copy), u3 (copy), u2 (ref)
        invariant(typeof(p24) == "Instance", "createRoot(...): Target container is not a Roblox Instance.");
        warnIfReactDOMContainerInDEV(p24);
        local v26 = setmetatable({}, u3);
        v26._internalRoot = u2(p24, BlockingRoot, p25);

        return v26;
    end,

    createLegacyRoot = function(p27, p28) -- Line: 224
        -- upvalues: LegacyRoot (copy), u3 (copy), u2 (ref)
        local v29 = setmetatable({}, u3);
        v29._internalRoot = u2(p27, LegacyRoot, p28);

        return v29;
    end
};

function warnIfReactDOMContainerInDEV(p31)
    local _ = _G.__DEV__;
end;

return v30;