-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	enableFilterEmptyStringAttributesDOM = true,
	enableDebugTracing = false
}

t.enableSchedulingProfiler = _G.__PROFILE__ and _G.__EXPERIMENTAL__
t.debugRenderPhaseSideEffectsForStrictMode = _G.__DEV__
t.replayFailedUnitOfWorkWithInvokeGuardedCallback = _G.__DEV__
t.warnAboutDeprecatedLifecycles = true
t.enableProfilerTimer = _G.__PROFILE__
t.enableProfilerCommitHooks = false
t.enableSchedulerTracing = _G.__PROFILE__
t.enableSuspenseServerRenderer = _G.__EXPERIMENTAL__
t.enableSelectiveHydration = _G.__EXPERIMENTAL__
t.enableBlocksAPI = _G.__EXPERIMENTAL__
t.enableLazyElements = _G.__EXPERIMENTAL__
t.enableSchedulerDebugging = false
t.disableJavaScriptURLs = false
t.enableFundamentalAPI = false
t.enableScopeAPI = false
t.enableCreateEventHandleAPI = false
t.warnAboutUnmockedScheduler = false
t.enableSuspenseCallback = false
t.warnAboutDefaultPropsOnFunctionComponents = false
t.disableSchedulerTimeoutBasedOnReactExpirationTime = false
t.enableTrustedTypesIntegration = false
t.warnAboutSpreadingKeyToJSX = true
t.enableComponentStackLocations = true
t.enableNewReconciler = true
t.skipUnmountedBoundaries = true
t.disableInputAttributeSyncing = true
t.warnAboutStringRefs = false
t.disableLegacyContext = false
t.disableTextareaChildren = false
t.disableModulePatternComponents = false
t.warnUnstableRenderSubtreeIntoContainer = false
t.enableLegacyFBSupport = true
t.deferRenderPhaseUpdateToNextBatch = false
t.decoupleUpdatePriorityFromScheduler = true
t.enableDiscreteEventFlushingChange = false
t.enableEagerRootListeners = false
t.enableDoubleInvokingEffects = false

return t