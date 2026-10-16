-- Decompiled with Potassium's decompiler.

local console = require(script.Parent:WaitForChild("console"));
local ReactSymbols = require(script.Parent:WaitForChild("ReactSymbols"));
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE;
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE;
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE;
local REACT_PORTAL_TYPE = ReactSymbols.REACT_PORTAL_TYPE;
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE;
local REACT_PROFILER_TYPE = ReactSymbols.REACT_PROFILER_TYPE;
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE;
local REACT_STRICT_MODE_TYPE = ReactSymbols.REACT_STRICT_MODE_TYPE;
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE;
local REACT_SUSPENSE_LIST_TYPE = ReactSymbols.REACT_SUSPENSE_LIST_TYPE;
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE;
local REACT_BLOCK_TYPE = ReactSymbols.REACT_BLOCK_TYPE;
require(script.Parent:WaitForChild("ReactTypes"));
local describeError = require(script.Parent:WaitForChild("ErrorHandling.roblox")).describeError;

local function getWrappedName(p1: any, p2: any, p3: string) -- Line: 40
    local v4 = typeof(p2) == "table" and (p2.displayName or (p2.name or "")) or "<function>";
    local displayName = p1.displayName;

    if displayName then
        p3 = displayName;
    elseif v4 ~= "" then
        p3 = string.format("%s(%s)", p3, v4) or p3;
    end;

    return p3;
end;

local function getContextName(p5) -- Line: 53
    return p5.displayName or "Context";
end;

local function getComponentName(p6) -- Line: 57
    -- upvalues: console (copy), REACT_FRAGMENT_TYPE (copy), REACT_PORTAL_TYPE (copy), REACT_PROFILER_TYPE (copy), REACT_STRICT_MODE_TYPE (copy), REACT_SUSPENSE_TYPE (copy), REACT_SUSPENSE_LIST_TYPE (copy), REACT_CONTEXT_TYPE (copy), REACT_PROVIDER_TYPE (copy), REACT_FORWARD_REF_TYPE (copy), REACT_MEMO_TYPE (copy), getComponentName (copy), REACT_BLOCK_TYPE (copy), REACT_LAZY_TYPE (copy), describeError (copy)
    if p6 == nil then
        return nil;
    end;

    local v7 = typeof(p6);

    if _G.__DEV__ and (v7 == "table" and typeof(p6.tag) == "number") then
        console.warn("Received an unexpected object in getComponentName(). This is likely a bug in React. Please file an issue.");
    end;

    if v7 == "function" then
        local debug_info_ret = debug.info(p6, "n");

        if debug_info_ret and string.len(debug_info_ret) > 0 then
            return debug_info_ret;
        end;

        return nil;
    end;

    if v7 == "string" then
        return p6;
    end;

    if p6 == REACT_FRAGMENT_TYPE then
        return "Fragment";
    end;

    if p6 == REACT_PORTAL_TYPE then
        return "Portal";
    end;

    if p6 == REACT_PROFILER_TYPE then
        return "Profiler";
    end;

    if p6 == REACT_STRICT_MODE_TYPE then
        return "StrictMode";
    end;

    if p6 == REACT_SUSPENSE_TYPE then
        return "Suspense";
    end;

    if p6 == REACT_SUSPENSE_LIST_TYPE then
        return "SuspenseList";
    end;

    if v7 == "table" then
        local v8 = p6["$$typeof"];

        if v8 == REACT_CONTEXT_TYPE then
            return (p6.displayName or "Context") .. ".Consumer";
        end;

        if v8 == REACT_PROVIDER_TYPE then
            return (p6._context.displayName or "Context") .. ".Provider";
        end;

        if v8 == REACT_FORWARD_REF_TYPE then
            local render = p6.render;
            local v9 = typeof(render) == "table" and (render.displayName or (render.name or "")) or "<function>";

            return p6.displayName or (v9 ~= "" and string.format("%s(%s)", "ForwardRef", v9) or "ForwardRef");
        end;

        if v8 == REACT_MEMO_TYPE then
            return getComponentName(p6.type);
        end;

        if v8 == REACT_BLOCK_TYPE then
            return getComponentName(p6._render);
        end;

        if v8 == REACT_LAZY_TYPE then
            local v10, v11 = xpcall(p6._init, describeError, p6._payload);

            if v10 then
                return getComponentName(v11);
            end;

            return nil;
        end;

        if p6.displayName then
            return p6.displayName;
        end;

        if p6.name then
            return p6.name;
        end;

        local v12 = getmetatable(p6);

        if v12 and rawget(v12, "__tostring") then
            return tostring(p6);
        end;
    end;

    return nil;
end;

return getComponentName;