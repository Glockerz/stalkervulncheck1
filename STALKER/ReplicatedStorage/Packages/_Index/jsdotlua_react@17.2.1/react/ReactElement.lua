-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local Error = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Error;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactLazy"));
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local REACT_ELEMENT_TYPE = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols.REACT_ELEMENT_TYPE;
local ReactCurrentOwner = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals.ReactCurrentOwner;
local u1 = {
    key = true,
    ref = true,
    __self = true,
    __source = true
};
local u2 = nil;
local u3 = nil;
local u4 = _G___DEV__ and {} or nil;
local v5 = {};

local function hasValidRef(p6) -- Line: 59
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ and (p6.ref ~= nil and (type(p6.ref) == "table" and p6.ref.isReactWarning)) then
        return false;
    end;

    return p6.ref ~= nil;
end;

local function hasValidKey(p7) -- Line: 73
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ and (p7.key ~= nil and (type(p7.key) == "table" and p7.key.isReactWarning)) then
        return false;
    end;

    return p7.key ~= nil;
end;

local u8 = {
    isReactWarning = true
};

local function defineKeyPropWarningGetter(p9: any, u10: string) -- Line: 92
    -- upvalues: _G___DEV__ (copy), u2 (ref), console (copy), u8 (copy)
    local function _() -- Line: 93
        -- upvalues: _G___DEV__ (ref), u2 (ref), console (ref), u10 (copy)
        if _G___DEV__ and not u2 then
            u2 = true;
            console.error("%s: `key` is not a prop. Trying to access it will result in `nil` being returned. If you need to access the same value within the child component, you should pass it as a different prop. (https://reactjs.org/link/special-props)", u10);
        end;
    end;

    p9.key = nil;
    setmetatable(p9, {
        __index = function(p11, p12) -- Line: 112, Name: __index
            -- upvalues: _G___DEV__ (ref), u2 (ref), console (ref), u10 (copy), u8 (ref)
            if p12 ~= "key" then
                return nil;
            end;

            if _G___DEV__ and not u2 then
                u2 = true;
                console.error("%s: `key` is not a prop. Trying to access it will result in `nil` being returned. If you need to access the same value within the child component, you should pass it as a different prop. (https://reactjs.org/link/special-props)", u10);
            end;

            return u8;
        end
    });
end;

local function defineRefPropWarningGetter(p13: any, u14: string) -- Line: 124
    -- upvalues: _G___DEV__ (copy), u3 (ref), console (copy), u8 (copy)
    local function _() -- Line: 127
        -- upvalues: _G___DEV__ (ref), u3 (ref), console (ref), u14 (copy)
        if _G___DEV__ and not u3 then
            u3 = true;
            console.error("%s: `ref` is not a prop. Trying to access it will result in `nil` being returned. If you need to access the same value within the child component, you should pass it as a different prop. (https://reactjs.org/link/special-props)", u14);
        end;
    end;

    p13.ref = nil;
    setmetatable(p13, {
        __index = function(p15, p16) -- Line: 146, Name: __index
            -- upvalues: _G___DEV__ (ref), u3 (ref), console (ref), u14 (copy), u8 (ref)
            if p16 ~= "ref" then
                return nil;
            end;

            if _G___DEV__ and not u3 then
                u3 = true;
                console.error("%s: `ref` is not a prop. Trying to access it will result in `nil` being returned. If you need to access the same value within the child component, you should pass it as a different prop. (https://reactjs.org/link/special-props)", u14);
            end;

            return u8;
        end
    });
end;

local function warnIfStringRefCannotBeAutoConverted(p17) -- Line: 158
    -- upvalues: _G___DEV__ (copy), ReactCurrentOwner (copy), getComponentName (copy), u4 (ref)
    if _G___DEV__ and (type(p17.ref) == "string" and ReactCurrentOwner.current) then
        local v18 = getComponentName(ReactCurrentOwner.current.type);

        if not u4[v18] then
            error(string.format("Component \"%s\" contains the string ref \"%s\". Support for string refs has been removed. We recommend using useRef() or createRef() instead. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-string-ref", v18 or "Unknown", p17.ref));
        end;
    end;
end;

local function ReactElement(p19, p20, p21, p22, p23, p24, p25) -- Line: 209
    -- upvalues: REACT_ELEMENT_TYPE (copy), _G___DEV__ (copy)
    local v26 = {
        type = p19,
        key = p20,
        ref = p21,
        props = p25,
        _owner = p24,
        ["$$typeof"] = REACT_ELEMENT_TYPE
    };

    if _G___DEV__ then
        local u27 = {
            validated = false
        };
        v26._store = setmetatable({}, {
            __index = u27,

            __newindex = function(p28, p29, p30) -- Line: 246, Name: __newindex
                -- upvalues: u27 (copy)
                if p29 == "validated" then
                    u27.validated = p30;

                    return;
                end;

                rawset(p28, p29, p30);
            end
        });
        setmetatable(v26, {
            __index = {
                _self = p22,
                _source = p23
            }
        });
    end;

    return v26;
end;

function v5.jsx(p31, p32, p33) -- Line: 277
    error("JSX is currently unsupported");
end;

function v5.jsxDEV(p34, p35, p36, p37, p38) -- Line: 332
    error("JSX is currently unsupported");

    return nil;
end;

function v5.createElement(p39, p40, ...) -- Line: 408
    -- upvalues: _G___DEV__ (copy), warnIfStringRefCannotBeAutoConverted (copy), defineKeyPropWarningGetter (copy), defineRefPropWarningGetter (copy), ReactElement (copy), ReactCurrentOwner (copy)
    local v41 = p40 == nil and {} or table.clone(p40);
    local v42 = nil;
    local v43 = nil;
    local v44;

    if p40 == nil then
        v44 = nil;
    else
        local v45;

        if _G___DEV__ and (p40.ref ~= nil and (type(p40.ref) == "table" and p40.ref.isReactWarning)) then
            v45 = false;
        else
            v45 = p40.ref ~= nil;
        end;

        if v45 then
            v43 = p40.ref;

            if _G___DEV__ then
                warnIfStringRefCannotBeAutoConverted(p40);
            end;
        end;

        local v46;

        if _G___DEV__ and (p40.key ~= nil and (type(p40.key) == "table" and p40.key.isReactWarning)) then
            v46 = false;
        else
            v46 = p40.key ~= nil;
        end;

        if v46 then
            v42 = p40.key;

            if type(v42) ~= "number" then
                v42 = tostring(v42);
            end;
        end;

        if p40.__source == nil then
            v44 = nil;
        else
            v44 = p40.__source;
        end;

        if v41.key ~= nil then
            v41.key = nil;
        end;

        if v41.ref ~= nil then
            v41.ref = nil;
        end;

        if v41.__self ~= nil then
            v41.__self = nil;
        end;

        if v41.__source ~= nil then
            v41.__source = nil;
        end;
    end;

    local v47 = select("#", ...);

    if v47 == 1 then
        v41.children = select(1, ...);
    elseif v47 > 1 then
        local table_create_ret = table.create(v47);

        for i = 1, v47 do
            local v48 = select(i, ...);
            table.insert(table_create_ret, v48);
            local _ = i;
        end;

        if _G___DEV__ then
            table.freeze(table_create_ret);
        end;

        v41.children = table_create_ret;
    end;

    if type(p39) == "table" and p39.defaultProps then
        local defaultProps = p39.defaultProps;

        for i, _ in defaultProps do
            if v41[i] == nil then
                v41[i] = defaultProps[i];
            end;
        end;
    end;

    if _G___DEV__ then
        if v42 or v43 then
            local v49;

            if type(p39) == "function" then
                v49 = debug.info(p39, "n") or "<function>";
            else
                v49 = type(p39) == "table" and (p39.displayName or (p39.name or "Unknown")) or p39;
            end;

            if v42 then
                defineKeyPropWarningGetter(v41, v49);
            end;

            if v43 then
                defineRefPropWarningGetter(v41, v49);
            end;
        end;

        v44 = v44 == nil and {
            fileName = debug.info(3, "s"),
            lineNumber = debug.info(3, "l")
        } or v44;
    end;

    return ReactElement(p39, v42, v43, nil, v44, ReactCurrentOwner.current, v41);
end;

function v5.cloneAndReplaceKey(p50, p51) -- Line: 587
    -- upvalues: ReactElement (copy)
    return ReactElement(p50.type, p51, p50.ref, p50._self, p50._source, p50._owner, p50.props);
end;

function v5.cloneElement(p52, p53, ...) -- Line: 605
    -- upvalues: Error (copy), ReactCurrentOwner (copy), _G___DEV__ (copy), u1 (copy), ReactElement (copy)
    if p52 == nil then
        error(Error.new("React.cloneElement(...): The argument must be a React element, but you passed " .. tostring(p52)));
    end;

    local props = p52.props;
    local v54 = props == nil and {} or table.clone(props);
    local key = p52.key;
    local ref = p52.ref;
    local _source = p52._source;
    local _owner = p52._owner;

    if p53 ~= nil then
        local ref2 = p53.ref;

        if ref2 == nil then
            if not (_G___DEV__ and (p53.ref ~= nil and (type(p53.ref) == "table" and p53.ref.isReactWarning))) then
                local _ = p53.ref == nil;
            end;
        else
            _owner = ReactCurrentOwner.current;
            ref = ref2;
        end;

        local key2 = p53.key;

        if key2 == nil then
            if not (_G___DEV__ and (p53.key ~= nil and (type(p53.key) == "table" and p53.key.isReactWarning))) then
                local _ = p53.key == nil;
            end;
        elseif type(key2) == "number" then
            key = key2;
        else
            key = key2 or "nil";
        end;
    end;

    local type2 = p52.type;
    local v55;

    if type(type2) == "table" then
        v55 = type2.defaultProps;
    else
        v55 = nil;
    end;

    if p53 ~= nil then
        for i, _ in p53 do
            if p53[i] ~= nil and not u1[i] then
                if p53[i] == nil and v55 ~= nil then
                    v54[i] = v55[i];
                else
                    v54[i] = p53[i];
                end;
            end;
        end;
    end;

    local v56 = select("#", ...);

    if v56 == 1 then
        v54.children = select(1, ...);
    elseif v56 > 1 then
        v54.children = { ... };
    end;

    return ReactElement(p52.type, key, ref, nil, _source, _owner, v54);
end;

function v5.isValidElement(p57) -- Line: 721
    -- upvalues: REACT_ELEMENT_TYPE (copy)
    local v58;

    if type(p57) == "table" then
        v58 = p57["$$typeof"] == REACT_ELEMENT_TYPE;
    else
        v58 = false;
    end;

    return v58;
end;

return v5;