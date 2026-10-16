-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("luau-polyfill")).console;

local function onlyInTestError(u1: string) -- Line: 26
    -- upvalues: console (copy)
    return function() -- Line: 27
        -- upvalues: console (ref), u1 (copy)
        console.error(u1 .. " is only available in tests, not in production");
    end;
end;

local ReactCurrentDispatcher = require(script:WaitForChild("ReactCurrentDispatcher"));
local ReactCurrentBatchConfig = require(script:WaitForChild("ReactCurrentBatchConfig"));
local ReactCurrentOwner = require(script:WaitForChild("ReactCurrentOwner"));
local ReactDebugCurrentFrame = require(script:WaitForChild("ReactDebugCurrentFrame"));

return {
    ReactCurrentDispatcher = ReactCurrentDispatcher,
    ReactCurrentBatchConfig = ReactCurrentBatchConfig,
    ReactCurrentOwner = ReactCurrentOwner,
    IsSomeRendererActing = require(script:WaitForChild("IsSomeRendererActing")),
    ReactDebugCurrentFrame = not _G.__DEV__ and {
        setExtraStackFrame = function(p2: string?) -- Line: 50, Name: setExtraStackFrame
        end
    } or ReactDebugCurrentFrame
};