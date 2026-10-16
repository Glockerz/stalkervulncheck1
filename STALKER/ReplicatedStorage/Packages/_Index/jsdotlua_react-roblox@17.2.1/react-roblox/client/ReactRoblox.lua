-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactRobloxHostTypes.roblox"));
local ReactRobloxRoot = require(script.Parent:WaitForChild("ReactRobloxRoot"));
local createRoot = ReactRobloxRoot.createRoot;
local createBlockingRoot = ReactRobloxRoot.createBlockingRoot;
local createLegacyRoot = ReactRobloxRoot.createLegacyRoot;
local isValidContainer = ReactRobloxRoot.isValidContainer;
local v1 = require(script.Parent.Parent:WaitForChild("ReactReconciler.roblox"));
local batchedUpdates = v1.batchedUpdates;
local flushSync = v1.flushSync;
local injectIntoDevTools = v1.injectIntoDevTools;
local flushPassiveEffects = v1.flushPassiveEffects;
local IsThisRendererActing = v1.IsThisRendererActing;
local createPortal = v1.createPortal;
local ReactVersion = require(script.Parent.Parent.Parent:WaitForChild("shared")).ReactVersion;
local invariant = require(script.Parent.Parent.Parent:WaitForChild("shared")).invariant;
local enableNewReconciler = require(script.Parent.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableNewReconciler;
local ReactRobloxComponentTree = require(script.Parent:WaitForChild("ReactRobloxComponentTree"));
local getClosestInstanceFromNode = ReactRobloxComponentTree.getClosestInstanceFromNode;
local v6 = {
    createPortal = function(p2: any, p3: any, p4: string?) -- Line: 122, Name: createPortal
        -- upvalues: invariant (copy), isValidContainer (copy), createPortal (copy)
        invariant(isValidContainer(p3), "Target container is not a Roblox Instance.");

        return createPortal(p2, p3, nil, p4);
    end,

    unstable_batchedUpdates = batchedUpdates,
    flushSync = flushSync,
    __SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = {
        Events = {
            getInstanceFromNode = ReactRobloxComponentTree.getInstanceFromNode,
            getNodeFromInstance = ReactRobloxComponentTree.getNodeFromInstance,
            getFiberCurrentPropsFromNode = ReactRobloxComponentTree.getFiberCurrentPropsFromNode,
            flushPassiveEffects = flushPassiveEffects,
            IsThisRendererActing = IsThisRendererActing
        }
    },
    version = ReactVersion,
    createRoot = createRoot,
    createBlockingRoot = createBlockingRoot,
    createLegacyRoot = createLegacyRoot,
    Event = require(script.Parent.Parent.Parent:WaitForChild("shared")).Event,
    Change = require(script.Parent.Parent.Parent:WaitForChild("shared")).Change,
    Tag = require(script.Parent.Parent.Parent:WaitForChild("shared")).Tag,
    unstable_isNewReconciler = enableNewReconciler,

    act = function(p5: function) -- Line: 255, Name: act
        error("ReactRoblox.act is only available in testing environments, not production. Enable the `__ROACT_17_MOCK_SCHEDULER__` global in your test configuration in order to use `act`.");
    end
};

if _G.__ROACT_17_MOCK_SCHEDULER__ then
    v6.act = v1.act;
end;

injectIntoDevTools({
    rendererPackageName = "ReactRoblox",
    findFiberByHostInstance = getClosestInstanceFromNode,
    bundleType = _G.__DEV__ and 1 or 0,
    version = ReactVersion
});
local _ = _G.__DEV__;
v6.robloxReactProfiling = v1.robloxReactProfiling;

return v6;