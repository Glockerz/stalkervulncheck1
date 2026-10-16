-- Decompiled with Potassium's decompiler.

local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Array = v1.Array;
local Boolean = v1.Boolean;
local Object = v1.Object;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local inspect = v1.util.inspect;
require(script.Parent.Parent:WaitForChild("shared"));
local isValidElementType = require(script.Parent.Parent:WaitForChild("shared")).isValidElementType;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols;
local getIteratorFn = ReactSymbols.getIteratorFn;
local _ = ReactSymbols.REACT_FORWARD_REF_TYPE;
local _ = ReactSymbols.REACT_MEMO_TYPE;
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE;
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE;
local warnAboutSpreadingKeyToJSX = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.warnAboutSpreadingKeyToJSX;
local checkPropTypes = require(script.Parent.Parent:WaitForChild("shared")).checkPropTypes;
local ReactCurrentOwner = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals.ReactCurrentOwner;
local ReactElement = require(script.Parent:WaitForChild("ReactElement"));
local isValidElement = ReactElement.isValidElement;
local createElement = ReactElement.createElement;
local cloneElement = ReactElement.cloneElement;
local jsxDEV = ReactElement.jsxDEV;
local setExtraStackFrame = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals.ReactDebugCurrentFrame.setExtraStackFrame;
local describeUnknownElementTypeFrameInDEV = require(script.Parent.Parent:WaitForChild("shared")).ReactComponentStackFrame.describeUnknownElementTypeFrameInDEV;
local v2 = {};

local function setCurrentlyValidatingElement(p3) -- Line: 63
    -- upvalues: describeUnknownElementTypeFrameInDEV (copy), setExtraStackFrame (copy)
    if _G.__DEV__ then
        if p3 then
            local _owner = p3._owner;
            local v4;

            if _owner then
                v4 = _owner.type;
            else
                v4 = nil;
            end;

            setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p3.type, p3._source, v4)));

            return;
        end;

        setExtraStackFrame(nil);
    end;
end;

local u5;

if _G.__DEV__ then
    u5 = false;
else
    u5 = nil;
end;

local function hasOwnProperty(p6, p7) -- Line: 91
    return p6[p7] ~= nil;
end;

local function getDeclarationErrorAddendum() -- Line: 95
    -- upvalues: ReactCurrentOwner (copy), getComponentName (copy)
    local v8 = ReactCurrentOwner.current and getComponentName(ReactCurrentOwner.current.type);

    return not v8 and "" or "\n\nCheck the render method of `" .. v8 .. "`.";
end;

local function getSourceInfoErrorAddendum(p9) -- Line: 106
    return p9 == nil and "" or "\n\nCheck your code at " .. string.gsub(p9.fileName, "^.*[\\/]", "") .. ":" .. p9.lineNumber .. ".";
end;

local function getSourceInfoErrorAddendumForProps(p10) -- Line: 116
    if p10 == nil then
        return "";
    end;

    local __source = p10.__source;

    return __source == nil and "" or "\n\nCheck your code at " .. string.gsub(__source.fileName, "^.*[\\/]", "") .. ":" .. __source.lineNumber .. ".";
end;

local u11 = {};

local function getCurrentComponentErrorInfo(p12) -- Line: 133
    -- upvalues: ReactCurrentOwner (copy), getComponentName (copy), Boolean (copy)
    local v13 = ReactCurrentOwner.current and getComponentName(ReactCurrentOwner.current.type);
    local v14 = not v13 and "" or "\n\nCheck the render method of `" .. v13 .. "`.";

    if not Boolean.toJSBoolean(v14) then
        local v15;

        if typeof(p12) == "string" then
            v15 = p12;
        elseif typeof(p12) == "table" then
            v15 = p12.displayName or p12.name;
        else
            v15 = nil;
        end;

        if not v15 and typeof(p12) == "function" then
            v15 = debug.info(p12, "n");

            if v15 == "" then
                v15 = nil;
            end;
        end;

        if v15 then
            v14 = string.format("\n\nCheck the top-level render call using <%s>.", v15);
        end;
    end;

    return v14;
end;

local function validateExplicitKey(p16, p17, p18) -- Line: 175
    -- upvalues: getCurrentComponentErrorInfo (copy), u11 (copy), ReactCurrentOwner (copy), getComponentName (copy), describeUnknownElementTypeFrameInDEV (copy), setExtraStackFrame (copy), console (copy)
    if p16._store == nil or p16._store.validated then
        return;
    end;

    p16._store.validated = true;

    if p16.key ~= nil ~= (p18 ~= nil) then
        return;
    end;

    local v19 = getCurrentComponentErrorInfo(p17);

    if u11[v19] then
        return;
    end;

    u11[v19] = true;
    local v20 = not (p16 and (p16._owner and p16._owner ~= ReactCurrentOwner.current)) and "" or string.format(" It was passed a child from %s.", (tostring(getComponentName(p16._owner.type))));

    if _G.__DEV__ then
        if _G.__DEV__ then
            if p16 then
                local _owner = p16._owner;
                local v21;

                if _owner then
                    v21 = _owner.type;
                else
                    v21 = nil;
                end;

                setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p16.type, p16._source, v21)));
            else
                setExtraStackFrame(nil);
            end;
        end;

        if p16.key == nil or p18 == nil then
            console.error("Each child in a list should have a unique \"key\" prop.%s%s See https://reactjs.org/link/warning-keys for more information.", v19, v20);
        else
            console.error("Child element received a \"key\" prop (\"%s\") in addition to a key in the \"children\" table of its parent (\"%s\"). Please provide only one key definition. When both are present, the \"key\" prop will take precedence.%s%s See https://reactjs.org/link/warning-keys for more information.", tostring(p16.key), tostring(p18), v19, v20);
        end;

        if _G.__DEV__ then
            setExtraStackFrame(nil);
        end;
    end;
end;

local function validateChildKeys(p22, p23) -- Line: 250
    -- upvalues: Array (copy), isValidElement (copy), validateExplicitKey (copy), getIteratorFn (copy)
    if typeof(p22) ~= "table" then
        return;
    end;

    if Array.isArray(p22) then
        for i = 1, #p22 do
            local v24 = p22[i];
            local v25;

            if isValidElement(v24) then
                validateExplicitKey(v24, p23);
                v25 = i;
            else
                v25 = i;
            end;
        end;

        return;
    end;

    if isValidElement(p22) then
        if p22._store then
            p22._store.validated = true;
        end;
    elseif p22 then
        local v26 = getIteratorFn(p22);

        if typeof(v26) == "function" and v26 ~= p22.entries then
            local v27 = v26(p22);
            local v28 = v27.next();

            while not v28.done do
                if isValidElement(v28.value) then
                    validateExplicitKey(v28.value, p23, v28.key);
                end;

                v28 = v27.next();
            end;
        end;
    end;
end;

local function validatePropTypes(p29) -- Line: 293
    -- upvalues: getComponentName (copy), checkPropTypes (copy), u5 (ref), console (copy)
    if _G.__DEV__ or _G.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        local type = p29.type;

        if type == nil or typeof(type) == "string" then
            return;
        end;

        if typeof(type) == "function" then
            return;
        end;

        if typeof(type) ~= "table" then
            return;
        end;

        local propTypes = type.propTypes;
        local validateProps = type.validateProps;

        if propTypes or validateProps then
            local v30 = getComponentName(type);
            checkPropTypes(propTypes, validateProps, p29.props, "prop", v30, p29);
        elseif type.PropTypes ~= nil and not u5 then
            u5 = true;
            local v31 = getComponentName(type);
            console.error("Component %s declared `PropTypes` instead of `propTypes`. Did you misspell the property assignment?", v31 or "Unknown");
        end;

        if type.getDefaultProps ~= nil then
            console.error("getDefaultProps is only used on classic React.createClass definitions. Use a static property named `defaultProps` instead.");
        end;
    end;
end;

local function validateFragmentProps(p32) -- Line: 343
    -- upvalues: Object (copy), describeUnknownElementTypeFrameInDEV (copy), setExtraStackFrame (copy), console (copy)
    if _G.__DEV__ then
        local v33 = Object.keys(p32.props);

        for i = 1, #v33 do
            local v34 = v33[i];

            if v34 ~= "children" and v34 ~= "key" then
                if _G.__DEV__ then
                    if p32 then
                        local _owner = p32._owner;
                        local v35;

                        if _owner then
                            v35 = _owner.type;
                        else
                            v35 = nil;
                        end;

                        setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p32.type, p32._source, v35)));
                    else
                        setExtraStackFrame(nil);
                    end;
                end;

                console.error("Invalid prop `%s` supplied to `React.Fragment`. React.Fragment can only have `key` and `children` props.", v34);

                if _G.__DEV__ then
                    setExtraStackFrame(nil);
                end;

                break;
            end;

            local _ = i;
        end;

        if p32.ref ~= nil then
            if _G.__DEV__ then
                if p32 then
                    local _owner = p32._owner;
                    local v36;

                    if _owner then
                        v36 = _owner.type;
                    else
                        v36 = nil;
                    end;

                    setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p32.type, p32._source, v36)));
                else
                    setExtraStackFrame(nil);
                end;
            end;

            console.error("Invalid attribute `ref` supplied to `React.Fragment`.");

            if _G.__DEV__ then
                setExtraStackFrame(nil);
            end;
        end;
    end;
end;

local function jsxWithValidation(p37, p38, p39, p40, p41, p42) -- Line: 369
    -- upvalues: isValidElementType (copy), Object (copy), ReactCurrentOwner (copy), getComponentName (copy), Array (copy), REACT_ELEMENT_TYPE (copy), inspect (copy), console (copy), jsxDEV (copy), validateChildKeys (copy), warnAboutSpreadingKeyToJSX (copy), REACT_FRAGMENT_TYPE (copy), validateFragmentProps (copy), validatePropTypes (copy)
    local v43 = isValidElementType(p37);

    if not v43 then
        local v44 = "";

        if p37 == nil or typeof(p37) == "table" and #Object.keys(p37) == 0 then
            v44 = v44 .. " You likely forgot to export your component from the file it\'s defined in, or you might have mixed up default and named imports.";
        end;

        local v45 = p41 == nil and "" or "\n\nCheck your code at " .. string.gsub(p41.fileName, "^.*[\\/]", "") .. ":" .. p41.lineNumber .. ".";
        local v46;

        if v45 then
            v46 = v44 .. v45;
        else
            local v47 = ReactCurrentOwner.current and getComponentName(ReactCurrentOwner.current.type);
            v46 = v44 .. (not v47 and "" or "\n\nCheck the render method of `" .. v47 .. "`.");
        end;

        local v48;

        if p37 == nil then
            v48 = "nil";
        elseif Array.isArray(p37) then
            v48 = "array";
        elseif typeof(p37) == "table" and p37["$$typeof"] == REACT_ELEMENT_TYPE then
            v48 = string.format("<%s />", getComponentName(p37.type) or "Unknown");
            v46 = v46 .. " Did you accidentally export a JSX literal or Element instead of a component?";
        else
            v48 = typeof(p37);
            v46 = v46 .. "\n" .. inspect(p37);
        end;

        if _G.__DEV__ then
            console.error("React.jsx: type is invalid -- expected a string (for built-in components) or a class/function (for composite components) but got: %s.%s", v48, v46);
        end;
    end;

    local v49 = jsxDEV(p37, p38, p39, p41, p42);

    if v49 == nil then
        return v49;
    end;

    if v43 then
        local children = p38.children;

        if children ~= nil then
            if p40 then
                if Array.isArray(children) then
                    for i = 1, #children do
                        validateChildKeys(children[i], p37);
                        local _ = i;
                    end;

                    Object.freeze(children);
                elseif _G.__DEV__ then
                    console.error("React.jsx: Static children should always be an array. You are likely explicitly calling React.jsxs or React.jsxDEV. Use the Babel transform instead.");
                end;
            else
                validateChildKeys(children, p37);
            end;
        end;
    end;

    if _G.__DEV__ and warnAboutSpreadingKeyToJSX and p38.key ~= nil then
        console.error("React.jsx: Spreading a key to JSX is a deprecated pattern. Explicitly pass a key after spreading props in your JSX call. E.g. <%s {...props} key={key} />", getComponentName(p37) or "ComponentName");
    end;

    if p37 == REACT_FRAGMENT_TYPE then
        validateFragmentProps(v49);

        return v49;
    end;

    validatePropTypes(v49);

    return v49;
end;

v2.jsxWithValidation = jsxWithValidation;

function v2.jsxWithValidationStatic(p50, p51, p52) -- Line: 491
    -- upvalues: jsxWithValidation (copy)
    return jsxWithValidation(p50, p51, p52, true);
end;

function v2.jsxWithValidationDynamic(p53, p54, p55) -- Line: 495
    -- upvalues: jsxWithValidation (copy)
    return jsxWithValidation(p53, p54, p55, false);
end;

function v2.createElementWithValidation(p56, p57, ...) -- Line: 500
    -- upvalues: isValidElementType (copy), Object (copy), ReactCurrentOwner (copy), getComponentName (copy), Array (copy), REACT_ELEMENT_TYPE (copy), inspect (copy), console (copy), createElement (copy), validateChildKeys (copy), REACT_FRAGMENT_TYPE (copy), validateFragmentProps (copy), validatePropTypes (copy)
    local v58 = isValidElementType(p56);

    if not v58 then
        local v59 = "";

        if p56 == nil or typeof(p56) == "table" and #Object.keys(p56) == 0 then
            v59 = v59 .. " You likely forgot to export your component from the file it\'s defined in, or you might have mixed up default and named imports.";
        end;

        local v60;

        if p57 == nil then
            v60 = "";
        else
            local __source = p57.__source;
            v60 = __source == nil and "" or "\n\nCheck your code at " .. string.gsub(__source.fileName, "^.*[\\/]", "") .. ":" .. __source.lineNumber .. ".";
        end;

        local v61;

        if v60 then
            v61 = v59 .. v60;
        else
            local v62 = ReactCurrentOwner.current and getComponentName(ReactCurrentOwner.current.type);
            v61 = v59 .. (not v62 and "" or "\n\nCheck the render method of `" .. v62 .. "`.");
        end;

        local v63;

        if p56 == nil then
            v63 = "nil";
        elseif Array.isArray(p56) then
            v63 = "array";
        elseif p56 == nil or (typeof(p56) ~= "table" or p56["$$typeof"] ~= REACT_ELEMENT_TYPE) then
            v63 = typeof(p56);

            if p56 ~= nil then
                v61 = v61 .. "\n" .. inspect(p56);
            end;
        else
            v63 = string.format("<%s />", getComponentName(p56.type) or "Unknown");
            v61 = v61 .. " Did you accidentally export a JSX literal or Element instead of a component?";
        end;

        if _G.__DEV__ then
            console.error("React.createElement: type is invalid -- expected a string (for built-in components) or a class/function (for composite components) but got: %s.%s", v63, v61);
        end;
    end;

    local v64 = createElement(p56, p57, ...);

    if v64 == nil then
        return v64;
    end;

    if v58 then
        for i = 1, select("#", ...) do
            validateChildKeys(select(i, ...), p56);
            local _ = i;
        end;
    end;

    if p56 == REACT_FRAGMENT_TYPE then
        validateFragmentProps(v64);

        return v64;
    end;

    validatePropTypes(v64);

    return v64;
end;

function v2.cloneElementWithValidation(p65, p66, ...) -- Line: 633
    -- upvalues: cloneElement (copy), validateChildKeys (copy), validatePropTypes (copy)
    local v67 = { p65, p66, ... };
    local v68 = cloneElement(p65, p66, ...);

    for i = 3, #v67 do
        validateChildKeys(v67[i], v68.type);
        local _ = i;
    end;

    validatePropTypes(v68);

    return v68;
end;

return v2;