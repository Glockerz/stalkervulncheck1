-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local v1 = {};

local function isCallable(p2) -- Line: 27
    if typeof(p2) == "function" then
        return true;
    end;

    if typeof(p2) == "table" then
        local v3 = getmetatable(p2);

        if v3 and rawget(v3, "__call") then
            return true;
        end;

        if p2._isMockFunction then
            return true;
        end;
    end;

    return false;
end;

local enableProfilerTimer = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableProfilerTimer;
require(script.Parent:WaitForChild("ReactInternalTypes"));
require(script.Parent.Parent:WaitForChild("shared"));
local DidCapture = require(script.Parent:WaitForChild("ReactFiberFlags")).DidCapture;
local u4 = nil;
local u5 = nil;
local u6 = false;

function v1.isDevToolsPresent() -- Line: 63
    return _G.__REACT_DEVTOOLS_GLOBAL_HOOK__ ~= nil;
end;

function v1.injectInternals(u7) -- Line: 67
    -- upvalues: console (copy), u4 (ref), u5 (ref)
    if _G.__REACT_DEVTOOLS_GLOBAL_HOOK__ == nil then
        return false;
    end;

    local _G___REACT_DEVTOOLS_GLOBAL_HOOK__ = _G.__REACT_DEVTOOLS_GLOBAL_HOOK__;

    if _G___REACT_DEVTOOLS_GLOBAL_HOOK__.isDisabled then
        return true;
    end;

    if not _G___REACT_DEVTOOLS_GLOBAL_HOOK__.supportsFiber then
        if _G.__DEV__ then
            console.error("The installed version of React DevTools is too old and will not work with the current version of React. Please update React DevTools. https://reactjs.org/link/react-devtools");
        end;

        return true;
    end;

    local success, result = pcall(function() -- Line: 90
        -- upvalues: u4 (ref), _G___REACT_DEVTOOLS_GLOBAL_HOOK__ (copy), u7 (copy), u5 (ref)
        u4 = _G___REACT_DEVTOOLS_GLOBAL_HOOK__.inject(u7);
        u5 = _G___REACT_DEVTOOLS_GLOBAL_HOOK__;
    end);

    if not success and _G.__DEV__ then
        console.error("React instrumentation encountered an error: %s.", result);
    end;

    return true;
end;

function v1.onScheduleRoot(p8, p9) -- Line: 106
    -- upvalues: u5 (ref), u4 (ref), u6 (ref), console (copy)
    if _G.__DEV__ and u5 then
        local onScheduleFiberRoot = u5.onScheduleFiberRoot;
        local v10;

        if typeof(onScheduleFiberRoot) == "function" then
            v10 = true;
        elseif typeof(onScheduleFiberRoot) == "table" then
            local v11 = getmetatable(onScheduleFiberRoot);
            v10 = v11 and rawget(v11, "__call") and true or (onScheduleFiberRoot._isMockFunction and true or false);
        else
            v10 = false;
        end;

        if v10 then
            local success, result = pcall(u5.onScheduleFiberRoot, u4, p8, p9);

            if not (success or (not _G.__DEV__ or u6)) then
                u6 = true;
                console.error("React instrumentation encountered an error: %s", result);
            end;
        end;
    end;
end;

function v1.onCommitRoot(u12, u13) -- Line: 126
    -- upvalues: u5 (ref), DidCapture (copy), enableProfilerTimer (copy), u4 (ref), u6 (ref), console (copy)
    if u5 then
        local onCommitFiberRoot = u5.onCommitFiberRoot;
        local v14;

        if typeof(onCommitFiberRoot) == "function" then
            v14 = true;
        elseif typeof(onCommitFiberRoot) == "table" then
            local v15 = getmetatable(onCommitFiberRoot);
            v14 = v15 and rawget(v15, "__call") and true or (onCommitFiberRoot._isMockFunction and true or false);
        else
            v14 = false;
        end;

        if v14 then
            local success, result = pcall(function() -- Line: 132
                -- upvalues: u12 (copy), DidCapture (ref), enableProfilerTimer (ref), u5 (ref), u4 (ref), u13 (copy)
                local v16 = bit32.band(u12.current.flags, DidCapture) == DidCapture;

                if enableProfilerTimer then
                    u5.onCommitFiberRoot(u4, u12, u13, v16);

                    return;
                end;

                u5.onCommitFiberRoot(u4, u12, nil, v16);
            end);

            if not (success or (not _G.__DEV__ or u6)) then
                u6 = true;
                console.error("React instrumentation encountered an error: %s", result);
            end;
        end;
    end;
end;

function v1.onCommitUnmount(p17) -- Line: 151
    -- upvalues: u5 (ref), u4 (ref), u6 (ref), console (copy)
    if u5 then
        local onCommitFiberUnmount = u5.onCommitFiberUnmount;
        local v18;

        if typeof(onCommitFiberUnmount) == "function" then
            v18 = true;
        elseif typeof(onCommitFiberUnmount) == "table" then
            local v19 = getmetatable(onCommitFiberUnmount);
            v18 = v19 and rawget(v19, "__call") and true or (onCommitFiberUnmount._isMockFunction and true or false);
        else
            v18 = false;
        end;

        if v18 then
            local success, result = pcall(u5.onCommitFiberUnmount, u4, p17);

            if not (success or (not _G.__DEV__ or u6)) then
                u6 = true;
                console.error("React instrumentation encountered an error: %s", result);
            end;
        end;
    end;
end;

return v1;