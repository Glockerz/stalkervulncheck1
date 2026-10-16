-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local _G___COMPAT_WARNINGS__ = _G.__COMPAT_WARNINGS__;
local Object = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Object;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent.Parent:WaitForChild("shared"));
local ReactNoopUpdateQueue = require(script.Parent:WaitForChild("ReactNoopUpdateQueue"));
local u1 = {};

if _G___DEV__ then
    Object.freeze(u1);
end;

local UninitializedState = require(script.Parent.Parent:WaitForChild("shared")).UninitializedState;

local function trimPath(p2: string) -- Line: 48
    local string_match_ret = string.match(p2, "%.%u[%.%w]-$");

    if string_match_ret then
        return string.gsub(string_match_ret, "^%.", "");
    end;

    return p2;
end;

local function warnAboutExistingLifecycle(p3, p4, p5) -- Line: 62
    -- upvalues: console (copy)
    console.warn("%s already defined \'%s\', but it also defining the deprecated Roact method \'%s\'. %s should only implement one of these methods, preferably using the non-deprecated name.", p3, p5, p4, p3);
end;

local function warnAboutDeprecatedLifecycleName(p6, p7, p8) -- Line: 72
    -- upvalues: _G___DEV__ (copy), _G___COMPAT_WARNINGS__ (copy), console (copy)
    if _G___DEV__ and _G___COMPAT_WARNINGS__ then
        local debug_info_ret, v9 = debug.info(3, "sln");
        local warn = console.warn;
        local string_match_ret = string.match(debug_info_ret, "%.%u[%.%w]-$");

        if string_match_ret then
            debug_info_ret = string.gsub(string_match_ret, "^%.", "");
        end;

        warn("%s is using method \'%s\', which is no longer supported and should be updated to \'%s\'\nFile: %s:%s", p6, p7, p8, debug_info_ret, (tostring(v9)));
    end;
end;

local u10 = {
    didMount = "componentDidMount",
    shouldUpdate = "shouldComponentUpdate",
    willUpdate = "UNSAFE_componentWillUpdate",
    didUpdate = "componentDidUpdate",
    willUnmount = "componentWillUnmount"
};

local function handleNewLifecycle(p11, p12, p13) -- Line: 94
    -- upvalues: u10 (copy), console (copy), _G___DEV__ (copy), _G___COMPAT_WARNINGS__ (copy)
    if u10[p12] ~= nil then
        if p11[u10[p12]] == nil then
            if p12 == "willUpdate" and p11.componentWillUpdate then
                local __componentName = p11.__componentName;
                console.warn("%s already defined \'%s\', but it also defining the deprecated Roact method \'%s\'. %s should only implement one of these methods, preferably using the non-deprecated name.", __componentName, "UNSAFE_componentWillUpdate", p12, __componentName);
            else
                local __componentName = p11.__componentName;
                local v14 = u10[p12];

                if _G___DEV__ and _G___COMPAT_WARNINGS__ then
                    local debug_info_ret, v15 = debug.info(3, "sln");
                    local warn = console.warn;
                    local string_match_ret = string.match(debug_info_ret, "%.%u[%.%w]-$");

                    if string_match_ret then
                        debug_info_ret = string.gsub(string_match_ret, "^%.", "");
                    end;

                    warn("%s is using method \'%s\', which is no longer supported and should be updated to \'%s\'\nFile: %s:%s", __componentName, p12, v14, debug_info_ret, (tostring(v15)));
                end;
            end;
        else
            local __componentName = p11.__componentName;
            console.warn("%s already defined \'%s\', but it also defining the deprecated Roact method \'%s\'. %s should only implement one of these methods, preferably using the non-deprecated name.", __componentName, u10[p12], p12, __componentName);
        end;

        p12 = u10[p12];
    end;

    rawset(p11, p12, p13);
end;

local u17 = setmetatable({
    __componentName = "Component"
}, {
    __newindex = handleNewLifecycle,
    __index = {
        isReactComponent = true
    },

    __tostring = function(p16) -- Line: 124, Name: __tostring
        return p16.__componentName;
    end
});
local u18 = _G.__TESTEZ_RUNNING_TEST__ and 0 or 900;
local table_create_ret = table.create(u18);
local u19 = 1;

for i = 1, u18 do
    table.insert(table_create_ret, {
        props = nil,
        context = nil,
        state = UninitializedState,
        __refs = u1,
        __updater = ReactNoopUpdateQueue
    });
    local _ = i;
end;

local function setStateInInit(p20: any, p21: any, p22: nil) -- Line: 160
    -- upvalues: _G___DEV__ (copy), console (copy), Object (copy)
    if _G___DEV__ and p22 ~= nil then
        console.warn("Received a `callback` argument to `setState` during initialization of \"%s\". The callback behavior is not supported when using `setState` in `init`.\n\nConsider defining similar behavior in a `compontentDidMount` method instead.", p20.__componentName);
    end;

    local v23;

    if p21 then
        v23 = type(p21);
    else
        v23 = p21;
    end;

    if p21 == nil or v23 ~= "table" and v23 ~= "function" then
        error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.");
    end;

    local state = p20.state;

    if v23 == "function" then
        p21 = p21(state, p20.props);
    end;

    p20.state = Object.assign({}, state, p21);
end;

function u17.extend(p24, p25) -- Line: 200
    -- upvalues: _G___COMPAT_WARNINGS__ (copy), console (copy), u19 (ref), u18 (copy), table_create_ret (copy), UninitializedState (copy), u1 (copy), ReactNoopUpdateQueue (copy), setStateInInit (copy)
    if p25 == nil then
        if _G___COMPAT_WARNINGS__ then
            console.warn("Component:extend() accepting no arguments is deprecated, and will not be supported in a future version of Roact. Please provide an explicit name.");
            p25 = "";
        else
            p25 = "";
        end;
    elseif type(p25) ~= "string" then
        error("Component class name must be a string");
    end;

    local u26 = {
        init = nil,
        __componentName = p25,
        setState = p24.setState,
        forceUpdate = p24.forceUpdate
    };
    u26.__index = u26;

    function u26.__ctor(p27, p28, p29) -- Line: 234
        -- upvalues: u19 (ref), u18 (ref), table_create_ret (ref), UninitializedState (ref), u1 (ref), ReactNoopUpdateQueue (ref), u26 (copy), setStateInInit (ref)
        local v30;

        if u19 <= u18 then
            v30 = table_create_ret[u19];
            v30.props = p27;
            v30.context = p28;
            table_create_ret[u19] = nil;
            u19 = u19 + 1;
        else
            v30 = {
                props = p27,
                context = p28,
                state = UninitializedState,
                __refs = u1,
                __updater = p29 or ReactNoopUpdateQueue
            };
        end;

        local v31 = setmetatable(v30, u26);

        if u26.init and type(u26.init) == "function" then
            v31.setState = setStateInInit;
            u26.init(v31, p27, p28);
            v31.setState = nil;
        end;

        return v31;
    end;

    local v32 = getmetatable(p24);
    setmetatable(u26, v32);

    return u26;
end;

function u17.setState(p33, p34, p35) -- Line: 326
    if p34 ~= nil and (type(p34) ~= "table" and type(p34) ~= "function") then
        error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.");
    end;

    p33.__updater.enqueueSetState(p33, p34, p35, "setState");
end;

function u17.forceUpdate(p36, p37) -- Line: 355
    p36.__updater.enqueueForceUpdate(p36, p37, "forceUpdate");
end;

if _G___DEV__ then
    local v38 = {
        isMounted = { "isMounted", "Instead, make sure to clean up subscriptions and pending requests in componentWillUnmount to prevent memory leaks." },
        replaceState = { "replaceState", "Refactor your code to use setState instead (see https://github.com/facebook/react/issues/3236)." }
    };

    local function _(p39, u40) -- Line: 379
        -- upvalues: u17 (copy), console (copy)
        u17[p39] = function() -- Line: 380
            -- upvalues: console (ref), u40 (copy)
            console.warn("%s(...) is deprecated in plain JavaScript React classes. %s", u40[1], u40[2]);

            return nil;
        end;
    end;

    for i, _ in v38 do
        if v38[i] ~= nil then
            local u41 = v38[i];

            u17[i] = function() -- Line: 380
                -- upvalues: console (copy), u41 (copy)
                console.warn("%s(...) is deprecated in plain JavaScript React classes. %s", u41[1], u41[2]);

                return nil;
            end;
        end;
    end;
end;

local v42 = u17:extend("PureComponent");
v42.extend = u17.extend;
setmetatable(v42, {
    __newindex = handleNewLifecycle,
    __index = {
        isReactComponent = true,
        isPureReactComponent = true
    },

    __tostring = function(p43) -- Line: 427, Name: __tostring
        return p43.__componentName;
    end
});

return {
    Component = u17,
    PureComponent = v42
};