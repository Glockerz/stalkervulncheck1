-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ = _G.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__;
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Object = v1.Object;
local Error = v1.Error;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent:WaitForChild("ReactInternalTypes"));
local v2 = require(script.Parent:WaitForChild("ReactFiberStack.new"));
local isFiberMounted = require(script.Parent:WaitForChild("ReactFiberTreeReflection")).isFiberMounted;
local disableLegacyContext = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.disableLegacyContext;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local ClassComponent = ReactWorkTags.ClassComponent;
local HostRoot = ReactWorkTags.HostRoot;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local checkPropTypes = require(script.Parent.Parent:WaitForChild("shared")).checkPropTypes;
local createCursor = v2.createCursor;
local push = v2.push;
local pop = v2.pop;
local u3 = _G___DEV__ and {} or nil;
local u4 = {};

if _G___DEV__ then
    Object.freeze(u4);
end;

local u5 = createCursor(u4);
local u6 = createCursor(false);
local u7 = u4;
local u8 = nil;

local function getUnmaskedContext(p9: any, p10: any, p11: boolean) -- Line: 67
    -- upvalues: u8 (ref), u7 (ref), u5 (copy)
    if p11 and u8(p10) then
        return u7;
    end;

    return u5.current;
end;

u8 = function(p12) -- Line: 160, Name: isContextProvider
    if type(p12) == "function" then
        return false;
    end;

    return p12.childContextTypes ~= nil;
end;

local function processChildContext(p13: any, p14: any, p15: table) -- Line: 218
    -- upvalues: _G___DEV__ (copy), getComponentName (copy), u3 (ref), console (copy), Error (copy), _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), checkPropTypes (copy), Object (copy)
    local stateNode = p13.stateNode;
    local childContextTypes = p14.childContextTypes;

    if stateNode.getChildContext == nil or type(stateNode.getChildContext) ~= "function" then
        if _G___DEV__ then
            local v16 = getComponentName(p14) or "Unknown";

            if not u3[v16] then
                u3[v16] = true;
                console.error("%s.childContextTypes is specified but there is no getChildContext() method on the instance. You can either define getChildContext() on %s or remove childContextTypes from it.", v16, v16);
            end;
        end;

        return p15;
    end;

    local ChildContext = stateNode:getChildContext();

    for i, _ in ChildContext do
        if childContextTypes[i] == nil then
            local v17 = getComponentName(p14) or "Unknown";
            error(Error.new(string.format("%s.getChildContext(): key \"%s\" is not defined in childContextTypes.", v17, i)));
        end;
    end;

    if _G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        checkPropTypes(childContextTypes, nil, ChildContext, "child context", getComponentName(p14) or "Unknown");
    end;

    return Object.assign({}, p15, ChildContext);
end;

return {
    emptyContextObject = u4,
    getUnmaskedContext = getUnmaskedContext,

    cacheContext = function(p18: any, p19: table, p20: table) -- Line: 87, Name: cacheContext
        local stateNode = p18.stateNode;
        stateNode.__reactInternalMemoizedUnmaskedChildContext = p19;
        stateNode.__reactInternalMemoizedMaskedChildContext = p20;
    end,

    getMaskedContext = function(p21: any, p22: table) -- Line: 102, Name: getMaskedContext
        -- upvalues: u4 (copy), _G___DEV__ (copy), _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ (copy), getComponentName (copy), checkPropTypes (copy)
        local type2 = p21.type;

        if type(type2) == "function" then
            return p22;
        end;

        local contextTypes = type2.contextTypes;

        if not contextTypes then
            return u4;
        end;

        local stateNode = p21.stateNode;

        if stateNode and stateNode.__reactInternalMemoizedUnmaskedChildContext == p22 then
            return stateNode.__reactInternalMemoizedMaskedChildContext;
        end;

        local v23 = {};

        for i, _ in contextTypes do
            v23[i] = p22[i];
        end;

        if _G___DEV__ or _G___DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
            checkPropTypes(contextTypes, nil, v23, "context", getComponentName(type2) or "Unknown");
        end;

        if stateNode then
            local stateNode2 = p21.stateNode;
            stateNode2.__reactInternalMemoizedUnmaskedChildContext = p22;
            stateNode2.__reactInternalMemoizedMaskedChildContext = v23;
        end;

        return v23;
    end,

    hasContextChanged = function() -- Line: 151, Name: hasContextChanged
        -- upvalues: disableLegacyContext (copy), u6 (copy)
        if disableLegacyContext then
            return false;
        end;

        return u6.current;
    end,

    popContext = function(p24) -- Line: 175, Name: popContext
        -- upvalues: pop (copy), u6 (copy), u5 (copy)
        pop(u6, p24);
        pop(u5, p24);
    end,

    popTopLevelContextObject = function(p25) -- Line: 185, Name: popTopLevelContextObject
        -- upvalues: pop (copy), u6 (copy), u5 (copy)
        pop(u6, p25);
        pop(u5, p25);
    end,

    pushTopLevelContextObject = function(p26: any, p27: table, p28: boolean) -- Line: 195, Name: pushTopLevelContextObject
        -- upvalues: u5 (copy), u4 (copy), Error (copy), push (copy), u6 (copy)
        if u5.current ~= u4 then
            error(Error.new("Unexpected context found on stack. This error is likely caused by a bug in React. Please file an issue."));
        end;

        push(u5, p27, p26);
        push(u6, p28, p26);
    end,

    processChildContext = processChildContext,
    isContextProvider = u8,

    pushContextProvider = function(p29) -- Line: 278, Name: pushContextProvider
        -- upvalues: u4 (copy), u7 (ref), u5 (copy), push (copy), u6 (copy)
        local stateNode = p29.stateNode;
        u7 = u5.current;
        push(u5, stateNode and stateNode.__reactInternalMemoizedMergedChildContext or u4, p29);
        push(u6, u6.current, p29);

        return true;
    end,

    invalidateContextProvider = function(p30: any, p31: any, p32: boolean) -- Line: 301, Name: invalidateContextProvider
        -- upvalues: Error (copy), processChildContext (copy), u7 (ref), pop (copy), u6 (copy), u5 (copy), push (copy)
        local stateNode = p30.stateNode;

        if not stateNode then
            error(Error.new("Expected to have an instance by this point. This error is likely caused by a bug in React. Please file an issue."));
        end;

        if not p32 then
            pop(u6, p30);
            push(u6, p32, p30);

            return;
        end;

        local v33 = processChildContext(p30, p31, u7);
        stateNode.__reactInternalMemoizedMergedChildContext = v33;
        pop(u6, p30);
        pop(u5, p30);
        push(u5, v33, p30);
        push(u6, p32, p30);
    end,

    findCurrentUnmaskedContext = function(p34) -- Line: 342, Name: findCurrentUnmaskedContext
        -- upvalues: ClassComponent (copy), isFiberMounted (copy), Error (copy), HostRoot (copy)
        if p34.tag ~= ClassComponent or not isFiberMounted(p34) then
            error(Error.new("Expected subtree parent to be a mounted class component. This error is likely caused by a bug in React. Please file an issue."));
        end;

        while p34.tag ~= HostRoot do
            if p34.tag == ClassComponent and p34.type.childContextTypes ~= nil then
                return p34.stateNode.__reactInternalMemoizedMergedChildContext;
            end;

            p34 = p34.return_;

            if p34 == nil then
                error(Error.new("Found unexpected detached subtree parent. This error is likely caused by a bug in React. Please file an issue."));

                return;
            end;
        end;

        return p34.stateNode.context;
    end
};