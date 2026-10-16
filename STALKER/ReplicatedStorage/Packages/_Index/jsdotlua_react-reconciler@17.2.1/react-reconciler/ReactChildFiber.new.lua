-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Array = v1.Array;
local Error = v1.Error;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError;
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent.Parent:WaitForChild("react"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
require(script.Parent:WaitForChild("ReactFiberLane"));
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local Placement = ReactFiberFlags.Placement;
local Deletion = ReactFiberFlags.Deletion;
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols;
local getIteratorFn = ReactSymbols.getIteratorFn;
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE;
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE;
local REACT_PORTAL_TYPE = ReactSymbols.REACT_PORTAL_TYPE;
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE;
local REACT_BLOCK_TYPE = ReactSymbols.REACT_BLOCK_TYPE;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local _ = ReactWorkTags.FunctionComponent;
local _ = ReactWorkTags.ClassComponent;
local HostText = ReactWorkTags.HostText;
local HostPortal = ReactWorkTags.HostPortal;
local _ = ReactWorkTags.ForwardRef;
local Fragment = ReactWorkTags.Fragment;
local _ = ReactWorkTags.SimpleMemoComponent;
local Block = ReactWorkTags.Block;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableLazyElements = ReactFeatureFlags.enableLazyElements;
local enableBlocksAPI = ReactFeatureFlags.enableBlocksAPI;
local v2 = require(script.Parent:WaitForChild("ReactFiber.new"));
local createWorkInProgress = v2.createWorkInProgress;
local resetWorkInProgress = v2.resetWorkInProgress;
local createFiberFromElement = v2.createFiberFromElement;
local createFiberFromFragment = v2.createFiberFromFragment;
local createFiberFromText = v2.createFiberFromText;
local createFiberFromPortal = v2.createFiberFromPortal;
local v3 = {};
local u4, u5, u6;

if _G___DEV__ then
    u4 = false;
    local u7 = {};

    u5 = function(p8, p9) -- Line: 112
        -- upvalues: invariant (copy), getComponentName (copy), u7 (ref), console (copy)
        if p8 == nil or type(p8) ~= "table" then
            return;
        end;

        if not (p8._store and (not p8._store.validated and p8.key == nil)) then
            return;
        end;

        local v10;

        if p8._store == nil then
            v10 = false;
        else
            v10 = type(p8._store) == "table";
        end;

        invariant(v10, "React Component in warnForMissingKey should have a _store. This error is likely caused by a bug in React. Please file an issue.");
        p8._store.validated = true;
        local v11 = getComponentName(p9.type) or "Component";

        if u7[v11] then
            return;
        end;

        u7[v11] = true;
        console.error("Each child in a list should have a unique \"key\" prop. See https://reactjs.org/link/warning-keys for more information.");
    end;

    u6 = {};
else
    u6 = nil;
    u4 = nil;

    u5 = function(p12, p13) -- Line: 90
    end;
end;

local isArray = Array.isArray;

function coerceRef(p14, p15, p16)
    -- upvalues: _G___DEV__ (copy), getComponentName (copy), Error (copy)
    local ref = p16.ref;

    if ref ~= nil and type(ref) == "string" then
        if not (p16._owner and (p16._self and p16._owner.stateNode ~= p16._self)) then
            local v17 = _G___DEV__ and (getComponentName(p14.type) or "Component") or "<enable __DEV__ mode for component names>";
            error(Error.new(string.format("Component \"%s\" contains the string ref \"%s\". Support for string refs has been removed. We recommend using useRef() or createRef() instead. Learn more about using refs safely here: https://reactjs.org/link/strict-mode-string-ref", v17, (tostring(ref)))));
        end;

        if not p16._owner then
            error("Expected ref to be a function or an object returned by React.createRef(), or nil.");
        end;
    end;

    return ref;
end;

local function warnOnFunctionType(p18) -- Line: 316
    -- upvalues: _G___DEV__ (copy), getComponentName (copy), u6 (ref), console (copy)
    if _G___DEV__ then
        local v19 = getComponentName(p18.type) or "Component";

        if u6[v19] then
            return;
        end;

        u6[v19] = true;
        console.error("Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it.");
    end;
end;

function resolveLazyType(p20)
    -- upvalues: describeError (copy)
    local v21, v22 = xpcall(p20._init, describeError, p20._payload);

    if v21 then
        return v22;
    end;

    return p20;
end;

local function ChildReconciler(u23) -- Line: 353
    -- upvalues: Deletion (copy), createWorkInProgress (copy), Placement (copy), HostText (copy), createFiberFromText (copy), _G___DEV__ (copy), enableBlocksAPI (copy), Block (copy), REACT_LAZY_TYPE (copy), REACT_BLOCK_TYPE (copy), createFiberFromElement (copy), HostPortal (copy), createFiberFromPortal (copy), Fragment (copy), createFiberFromFragment (copy), REACT_ELEMENT_TYPE (copy), REACT_PORTAL_TYPE (copy), enableLazyElements (copy), getComponentName (copy), u6 (ref), console (copy), REACT_FRAGMENT_TYPE (copy), u5 (ref), u4 (ref), isArray (copy), getIteratorFn (copy)
    local function deleteChild(p24, p25) -- Line: 354
        -- upvalues: u23 (copy), Deletion (ref)
        if not u23 then
            return;
        end;

        local deletions = p24.deletions;

        if deletions ~= nil then
            table.insert(deletions, p25);

            return;
        end;

        p24.deletions = { p25 };
        p24.flags = bit32.bor(p24.flags, Deletion);
    end;

    local function deleteRemainingChildren(p26, p27) -- Line: 368
        -- upvalues: u23 (copy), Deletion (ref)
        if not u23 then
            return nil;
        end;

        while p27 ~= nil do
            if u23 then
                local deletions = p26.deletions;

                if deletions == nil then
                    p26.deletions = { p27 };
                    p26.flags = bit32.bor(p26.flags, Deletion);
                else
                    table.insert(deletions, p27);
                end;
            end;

            p27 = p27.sibling;
        end;

        return nil;
    end;

    local function mapRemainingChildren(p28, p29) -- Line: 387
        local v30 = {};

        while p29 ~= nil do
            if p29.key == nil then
                v30[p29.index] = p29;
            else
                v30[p29.key] = p29;
            end;

            p29 = p29.sibling;
        end;

        return v30;
    end;

    local function useFiber(p31, p32) -- Line: 409
        -- upvalues: createWorkInProgress (ref)
        local v33 = createWorkInProgress(p31, p32);
        v33.index = 1;
        v33.sibling = nil;

        return v33;
    end;

    local function placeChild(p34: any, p35: number, p36: number) -- Line: 419
        -- upvalues: u23 (copy), Placement (ref)
        p34.index = p36;

        if not u23 then
            return p35;
        end;

        local alternate = p34.alternate;

        if alternate == nil then
            p34.flags = bit32.bor(p34.flags, Placement);

            return p35;
        end;

        local index = alternate.index;

        if index >= p35 then
            return index;
        end;

        p34.flags = bit32.bor(p34.flags, Placement);

        return p35;
    end;

    local function placeSingleChild(p37) -- Line: 447
        -- upvalues: u23 (copy), Placement (ref)
        if u23 and p37.alternate == nil then
            p37.flags = bit32.bor(p37.flags, Placement);
        end;

        return p37;
    end;

    local function updateTextNode(p38: any, p39: any, p40: string, p41: any) -- Line: 456
        -- upvalues: HostText (ref), createFiberFromText (ref), createWorkInProgress (ref)
        if p39 == nil or p39.tag ~= HostText then
            local v42 = createFiberFromText(p40, p38.mode, p41);
            v42.return_ = p38;

            return v42;
        end;

        local v43 = createWorkInProgress(p39, p40);
        v43.index = 1;
        v43.sibling = nil;
        v43.return_ = p38;

        return v43;
    end;

    local function updateElement(p44, p45, p46, p47) -- Line: 476
        -- upvalues: createWorkInProgress (ref), _G___DEV__ (ref), enableBlocksAPI (ref), Block (ref), REACT_LAZY_TYPE (ref), REACT_BLOCK_TYPE (ref), createFiberFromElement (ref)
        if p45 ~= nil then
            if p45.elementType == p46.type then
                local v48 = createWorkInProgress(p45, p46.props);
                v48.index = 1;
                v48.sibling = nil;
                v48.ref = coerceRef(p44, p45, p46);
                v48.return_ = p44;

                if _G___DEV__ then
                    v48._debugSource = p46._source;
                    v48._debugOwner = p46._owner;
                end;

                return v48;
            end;

            if enableBlocksAPI and p45.tag == Block then
                local type2 = p46.type;

                if type(type2) == "table" and type2["$$typeof"] == REACT_LAZY_TYPE then
                    type2 = resolveLazyType(type2);
                end;

                if type2["$$typeof"] == REACT_BLOCK_TYPE and type2._render == p45.type._render then
                    local v49 = createWorkInProgress(p45, p46.props);
                    v49.index = 1;
                    v49.sibling = nil;
                    v49.return_ = p44;
                    v49.type = type2;

                    if _G___DEV__ then
                        v49._debugSource = p46._source;
                        v49._debugOwner = p46._owner;
                    end;

                    return v49;
                end;
            end;
        end;

        local v50 = createFiberFromElement(p46, p44.mode, p47);
        v50.ref = coerceRef(p44, p45, p46);
        v50.return_ = p44;

        return v50;
    end;

    local function updatePortal(p51, p52, p53, p54) -- Line: 529
        -- upvalues: HostPortal (ref), createFiberFromPortal (ref), createWorkInProgress (ref)
        if p52 == nil or (p52.tag ~= HostPortal or (p52.stateNode.containerInfo ~= p53.containerInfo or p52.stateNode.implementation ~= p53.implementation)) then
            local v55 = createFiberFromPortal(p53, p51.mode, p54);
            v55.return_ = p51;

            return v55;
        end;

        local v56 = createWorkInProgress(p52, p53.children or {});
        v56.index = 1;
        v56.sibling = nil;
        v56.return_ = p51;

        return v56;
    end;

    local function updateFragment(p57: any, p58: any, p59: any, p60: any, p61: string?) -- Line: 554
        -- upvalues: Fragment (ref), createFiberFromFragment (ref), createWorkInProgress (ref)
        if p58 == nil or p58.tag ~= Fragment then
            local v62 = createFiberFromFragment(p59, p57.mode, p60, p61);
            v62.return_ = p57;

            return v62;
        end;

        local v63 = createWorkInProgress(p58, p59);
        v63.index = 1;
        v63.sibling = nil;
        v63.return_ = p57;

        return v63;
    end;

    local function assignStableKey(p64: any, p65: table) -- Line: 581
        if p65.key == nil then
            local v66 = type(p64);

            if v66 == "string" or v66 == "number" then
                p65.key = p64;

                return;
            end;

            if v66 == "table" then
                p65.key = tostring(p64);
            end;
        end;
    end;

    local function createChild(p67, p68, p69, p70) -- Line: 600
        -- upvalues: REACT_ELEMENT_TYPE (ref), createFiberFromElement (ref), REACT_PORTAL_TYPE (ref), createFiberFromPortal (ref), REACT_LAZY_TYPE (ref), enableLazyElements (ref), createChild (copy), createFiberFromFragment (ref), createFiberFromText (ref), _G___DEV__ (ref), getComponentName (ref), u6 (ref), console (ref)
        if p68 == nil then
            return nil;
        end;

        local v71 = type(p68);

        if v71 ~= "table" then
            if v71 ~= "string" and v71 ~= "number" then
                if _G___DEV__ and (v71 == "function" and _G___DEV__) then
                    local v72 = getComponentName(p67.type) or "Component";

                    if not u6[v72] then
                        u6[v72] = true;
                        console.error("Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it.");
                    end;
                end;

                return nil;
            end;

            local v73 = createFiberFromText(tostring(p68), p67.mode, p69);
            v73.return_ = p67;

            return v73;
        end;

        if p68.key == nil then
            local v74 = type(p70);

            if v74 == "string" or v74 == "number" then
                p68.key = p70;
            elseif v74 == "table" then
                p68.key = tostring(p70);
            end;
        end;

        local v75 = p68["$$typeof"];

        if v75 == REACT_ELEMENT_TYPE then
            local v76 = createFiberFromElement(p68, p67.mode, p69);
            v76.ref = coerceRef(p67, nil, p68);
            v76.return_ = p67;

            return v76;
        end;

        if v75 == REACT_PORTAL_TYPE then
            local v77 = createFiberFromPortal(p68, p67.mode, p69);
            v77.return_ = p67;

            return v77;
        end;

        if v75 == REACT_LAZY_TYPE and enableLazyElements then
            return createChild(p67, p68._init(p68._payload), p69);
        end;

        local v78 = createFiberFromFragment(p68, p67.mode, p69, nil);
        v78.return_ = p67;

        return v78;
    end;

    local function updateSlot(p79, p80, p81, p82, p83) -- Line: 671
        -- upvalues: REACT_ELEMENT_TYPE (ref), REACT_FRAGMENT_TYPE (ref), Fragment (ref), createFiberFromFragment (ref), createWorkInProgress (ref), updateElement (copy), REACT_PORTAL_TYPE (ref), updatePortal (copy), REACT_LAZY_TYPE (ref), enableLazyElements (ref), updateSlot (copy), HostText (ref), createFiberFromText (ref), _G___DEV__ (ref), getComponentName (ref), u6 (ref), console (ref)
        if p81 == nil then
            return nil;
        end;

        local v84;

        if p80 == nil then
            v84 = nil;
        else
            v84 = p80.key;
        end;

        local v85 = type(p81);

        if v85 ~= "table" then
            if v85 ~= "string" and v85 ~= "number" then
                if _G___DEV__ and (v85 == "function" and _G___DEV__) then
                    local v86 = getComponentName(p79.type) or "Component";

                    if not u6[v86] then
                        u6[v86] = true;
                        console.error("Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it.");
                    end;
                end;

                return nil;
            end;

            if v84 ~= nil then
                return nil;
            end;

            local v87 = tostring(p81);

            if p80 == nil or p80.tag ~= HostText then
                local v88 = createFiberFromText(v87, p79.mode, p82);
                v88.return_ = p79;

                return v88;
            end;

            local v89 = createWorkInProgress(p80, v87);
            v89.index = 1;
            v89.sibling = nil;
            v89.return_ = p79;

            return v89;
        end;

        if p81.key == nil then
            local v90 = type(p83);

            if v90 == "string" or v90 == "number" then
                p81.key = p83;
            elseif v90 == "table" then
                p81.key = tostring(p83);
            end;
        end;

        local v91 = p81["$$typeof"];

        if v91 == REACT_ELEMENT_TYPE then
            if p81.key ~= v84 then
                return nil;
            end;

            if p81.type ~= REACT_FRAGMENT_TYPE then
                return updateElement(p79, p80, p81, p82);
            end;

            local children = p81.props.children;

            if p80 == nil or p80.tag ~= Fragment then
                local v92 = createFiberFromFragment(children, p79.mode, p82, v84);
                v92.return_ = p79;

                return v92;
            end;

            local v93 = createWorkInProgress(p80, children);
            v93.index = 1;
            v93.sibling = nil;
            v93.return_ = p79;

            return v93;
        end;

        if v91 == REACT_PORTAL_TYPE then
            if p81.key == v84 then
                return updatePortal(p79, p80, p81, p82);
            end;

            return nil;
        end;

        if v91 == REACT_LAZY_TYPE and enableLazyElements then
            return updateSlot(p79, p80, p81._init(p81._payload), p82);
        end;

        if v84 ~= nil then
            return nil;
        end;

        if p80 == nil or p80.tag ~= Fragment then
            local v94 = createFiberFromFragment(p81, p79.mode, p82, nil);
            v94.return_ = p79;

            return v94;
        end;

        local v95 = createWorkInProgress(p80, p81);
        v95.index = 1;
        v95.sibling = nil;
        v95.return_ = p79;

        return v95;
    end;

    local function updateFromMap(p96: table, p97: any, p98: number, p99: any, p100: any, p101: any) -- Line: 759
        -- upvalues: REACT_ELEMENT_TYPE (ref), REACT_FRAGMENT_TYPE (ref), Fragment (ref), createFiberFromFragment (ref), createWorkInProgress (ref), updateElement (copy), REACT_PORTAL_TYPE (ref), updatePortal (copy), REACT_LAZY_TYPE (ref), enableLazyElements (ref), updateFromMap (copy), HostText (ref), createFiberFromText (ref), _G___DEV__ (ref), getComponentName (ref), u6 (ref), console (ref)
        if p99 == nil then
            return nil;
        end;

        local v102 = type(p99);

        if v102 ~= "table" then
            if v102 ~= "string" and v102 ~= "number" then
                if _G___DEV__ and (v102 == "function" and _G___DEV__) then
                    local v103 = getComponentName(p97.type) or "Component";

                    if not u6[v103] then
                        u6[v103] = true;
                        console.error("Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it.");
                    end;
                end;

                return nil;
            end;

            local v104 = p96[p98] or nil;
            local v105 = tostring(p99);

            if v104 == nil or v104.tag ~= HostText then
                local v106 = createFiberFromText(v105, p97.mode, p100);
                v106.return_ = p97;

                return v106;
            end;

            local v107 = createWorkInProgress(v104, v105);
            v107.index = 1;
            v107.sibling = nil;
            v107.return_ = p97;

            return v107;
        end;

        if p99.key == nil then
            local v108 = type(p101);

            if v108 == "string" or v108 == "number" then
                p99.key = p101;
            elseif v108 == "table" then
                p99.key = tostring(p101);
            end;
        end;

        local v109 = p99["$$typeof"];

        if v109 ~= REACT_ELEMENT_TYPE then
            if v109 == REACT_PORTAL_TYPE then
                if p99.key ~= nil then
                    p98 = p99.key;
                end;

                return updatePortal(p97, p96[p98], p99, p100);
            end;

            if v109 == REACT_LAZY_TYPE and enableLazyElements then
                return updateFromMap(p96, p97, p98, p99._init(p99._payload), p100);
            end;

            local v110 = p96[p98];

            if v110 == nil or v110.tag ~= Fragment then
                local v111 = createFiberFromFragment(p99, p97.mode, p100, nil);
                v111.return_ = p97;

                return v111;
            end;

            local v112 = createWorkInProgress(v110, p99);
            v112.index = 1;
            v112.sibling = nil;
            v112.return_ = p97;

            return v112;
        end;

        if p99.key ~= nil then
            p98 = p99.key;
        end;

        local v113 = p96[p98];

        if p99.type ~= REACT_FRAGMENT_TYPE then
            return updateElement(p97, v113, p99, p100);
        end;

        local children = p99.props.children;
        local key = p99.key;

        if v113 == nil or v113.tag ~= Fragment then
            local v114 = createFiberFromFragment(children, p97.mode, p100, key);
            v114.return_ = p97;

            return v114;
        end;

        local v115 = createWorkInProgress(v113, children);
        v115.index = 1;
        v115.sibling = nil;
        v115.return_ = p97;

        return v115;
    end;

    local function warnOnInvalidKey(p116: any, p117: table?, p118: any) -- Line: 853
        -- upvalues: _G___DEV__ (ref), REACT_ELEMENT_TYPE (ref), REACT_PORTAL_TYPE (ref), u5 (ref), console (ref), REACT_LAZY_TYPE (ref), enableLazyElements (ref), warnOnInvalidKey (copy)
        if _G___DEV__ then
            if p116 == nil or type(p116) ~= "table" then
                return p117;
            end;

            local v119 = p116["$$typeof"];

            if v119 == REACT_ELEMENT_TYPE or v119 == REACT_PORTAL_TYPE then
                u5(p116, p118);
                local key = p116.key;

                if type(key) ~= "string" then
                    return p117;
                end;

                if p117 == nil then
                    return {
                        [key] = true
                    };
                end;

                if p117[key] then
                    console.error("Encountered two children with the same key, `%s`. Keys should be unique so that components maintain their identity across updates. Non-unique keys may cause children to be duplicated and/or omitted — the behavior is unsupported and could change in a future version.", key);

                    return p117;
                end;

                p117[key] = true;

                return p117;
            end;

            if v119 == REACT_LAZY_TYPE and enableLazyElements then
                warnOnInvalidKey(p116._init(p116._payload), p117, p118);
            end;
        end;

        return p117;
    end;

    local function reconcileChildrenArray(p120: any, p121: any, p122: table, p123: any) -- Line: 895
        -- upvalues: _G___DEV__ (ref), warnOnInvalidKey (copy), updateSlot (copy), u23 (copy), Deletion (ref), Placement (ref), createChild (copy), mapRemainingChildren (copy), updateFromMap (copy)
        if _G___DEV__ then
            local v124 = nil;

            for _, v in p122 do
                v124 = warnOnInvalidKey(v, v124, p120);
            end;
        end;

        local v125 = #p122;
        local v126 = 1;
        local v127 = nil;
        local v128 = nil;
        local v129 = 1;
        local v130;

        while true do
            if p121 == nil or v126 > v125 then
                v130 = p121;
                break;
            end;

            if v126 < p121.index then
                v130 = p121;
                p121 = nil;
            else
                v130 = p121.sibling;
            end;

            local v131 = p122[v126];
            local v132;

            if v131 == nil or (type(v131) ~= "table" or v131["$$typeof"] == nil) then
                v132 = updateSlot(p120, p121, v131, p123);
            else
                v132 = updateSlot(p120, p121, v131, p123, v126);
            end;

            if v132 == nil then
                if p121 ~= nil then
                    v130 = p121;
                end;

                break;
            end;

            if u23 and (p121 and (v132.alternate == nil and u23)) then
                local deletions = p120.deletions;

                if deletions == nil then
                    p120.deletions = { p121 };
                    p120.flags = bit32.bor(p120.flags, Deletion);
                else
                    table.insert(deletions, p121);
                end;
            end;

            v132.index = v126;

            if u23 then
                local alternate = v132.alternate;

                if alternate == nil then
                    v132.flags = bit32.bor(v132.flags, Placement);
                else
                    local index = alternate.index;

                    if index < v129 then
                        v132.flags = bit32.bor(v132.flags, Placement);
                    else
                        v129 = index;
                    end;
                end;
            end;

            if v127 == nil then
                v128 = v132;
            else
                v127.sibling = v132;
            end;

            v126 = v126 + 1;
            v127 = v132;
            p121 = v130;
        end;

        if v125 < v126 then
            if not u23 then
                return v128;
            end;

            while v130 ~= nil do
                if u23 then
                    local deletions = p120.deletions;

                    if deletions == nil then
                        p120.deletions = { v130 };
                        p120.flags = bit32.bor(p120.flags, Deletion);
                    else
                        table.insert(deletions, v130);
                    end;
                end;

                v130 = v130.sibling;
            end;

            return v128;
        end;

        if v130 == nil then
            while v126 <= v125 do
                local v133 = p122[v126];
                local v134;

                if v133 == nil or (type(v133) ~= "table" or v133["$$typeof"] == nil) then
                    v134 = createChild(p120, v133, p123);
                else
                    v134 = createChild(p120, v133, p123, v126);
                end;

                if v134 == nil then
                    v126 = v126 + 1;
                    v134 = v127;
                else
                    v134.index = v126;

                    if u23 then
                        local alternate = v134.alternate;

                        if alternate == nil then
                            v134.flags = bit32.bor(v134.flags, Placement);
                        else
                            local index = alternate.index;

                            if index < v129 then
                                v134.flags = bit32.bor(v134.flags, Placement);
                            else
                                v129 = index;
                            end;
                        end;
                    end;

                    if v127 == nil then
                        v128 = v134;
                    else
                        v127.sibling = v134;
                    end;

                    v126 = v126 + 1;
                end;

                v127 = v134;
            end;

            return v128;
        end;

        local v135 = mapRemainingChildren(p120, v130);

        while v126 <= v125 do
            local v136 = updateFromMap(v135, p120, v126, p122[v126], p123, v126);

            if v136 == nil then
                v136 = v127;
            else
                if u23 and v136.alternate ~= nil then
                    local v137;

                    if v136.key == nil then
                        v137 = v126;
                    else
                        v137 = v136.key;
                    end;

                    v135[v137] = nil;
                end;

                v136.index = v126;

                if u23 then
                    local alternate = v136.alternate;

                    if alternate == nil then
                        v136.flags = bit32.bor(v136.flags, Placement);
                    else
                        local index = alternate.index;

                        if index < v129 then
                            v136.flags = bit32.bor(v136.flags, Placement);
                        else
                            v129 = index;
                        end;
                    end;
                end;

                if v127 == nil then
                    v128 = v136;
                else
                    v127.sibling = v136;
                end;
            end;

            v126 = v126 + 1;
            v127 = v136;
        end;

        if u23 then
            for _, v in v135 do
                if u23 then
                    local deletions = p120.deletions;

                    if deletions == nil then
                        p120.deletions = { v };
                        p120.flags = bit32.bor(p120.flags, Deletion);
                    else
                        table.insert(deletions, v);
                    end;
                end;
            end;
        end;

        return v128;
    end;

    local function reconcileChildrenIterator(p138: any, p139: any, p140: any, p141: any, p142: function) -- Line: 1102
        -- upvalues: _G___DEV__ (ref), u4 (ref), console (ref), warnOnInvalidKey (copy), updateSlot (copy), u23 (copy), Deletion (ref), Placement (ref), createChild (copy), mapRemainingChildren (copy), updateFromMap (copy)
        if _G___DEV__ then
            if p140.entries == p142 then
                if not u4 then
                    console.error("Using Maps as children is not supported. Use an array of keyed ReactElements instead.");
                end;

                u4 = true;
            end;

            local v143 = p142(p140);

            if v143 then
                local v144 = v143.next();
                local v145 = nil;

                while not v144.done do
                    v144 = v143.next();
                    v145 = warnOnInvalidKey(v144.value, v145, p138);
                end;
            end;
        end;

        local v146 = p142(p140);
        local v147 = v146.next();
        local v148 = 1;
        local v149 = nil;
        local v150 = 1;
        local v151 = nil;
        local v152;

        while true do
            if p139 == nil or v147.done then
                v152 = p139;
                break;
            end;

            if v148 < p139.index then
                v152 = p139;
                p139 = nil;
            else
                v152 = p139.sibling;
            end;

            local v153 = updateSlot(p138, p139, v147.value, p141, v147.key);

            if v153 == nil then
                if p139 ~= nil then
                    v152 = p139;
                end;

                break;
            end;

            if u23 and (p139 and (v153.alternate == nil and u23)) then
                local deletions = p138.deletions;

                if deletions == nil then
                    p138.deletions = { p139 };
                    p138.flags = bit32.bor(p138.flags, Deletion);
                else
                    table.insert(deletions, p139);
                end;
            end;

            v153.index = v148;

            if u23 then
                local alternate = v153.alternate;

                if alternate == nil then
                    v153.flags = bit32.bor(v153.flags, Placement);
                else
                    local index = alternate.index;

                    if index < v150 then
                        v153.flags = bit32.bor(v153.flags, Placement);
                    else
                        v150 = index;
                    end;
                end;
            end;

            if v151 == nil then
                v149 = v153;
            else
                v151.sibling = v153;
            end;

            v148 = v148 + 1;
            v147 = v146.next();
            v151 = v153;
            p139 = v152;
        end;

        if v147.done then
            if not u23 then
                return v149;
            end;

            while v152 ~= nil do
                if u23 then
                    local deletions = p138.deletions;

                    if deletions == nil then
                        p138.deletions = { v152 };
                        p138.flags = bit32.bor(p138.flags, Deletion);
                    else
                        table.insert(deletions, v152);
                    end;
                end;

                v152 = v152.sibling;
            end;

            return v149;
        end;

        if v152 == nil then
            while not v147.done do
                local v154 = createChild(p138, v147.value, p141, v147.key);

                if v154 == nil then
                    v148 = v148 + 1;
                    v147 = v146.next();
                    v154 = v151;
                else
                    v154.index = v148;

                    if u23 then
                        local alternate = v154.alternate;

                        if alternate == nil then
                            v154.flags = bit32.bor(v154.flags, Placement);
                        else
                            local index = alternate.index;

                            if index < v150 then
                                v154.flags = bit32.bor(v154.flags, Placement);
                            else
                                v150 = index;
                            end;
                        end;
                    end;

                    if v151 == nil then
                        v149 = v154;
                    else
                        v151.sibling = v154;
                    end;

                    v148 = v148 + 1;
                    v147 = v146.next();
                end;

                v151 = v154;
            end;

            return v149;
        end;

        local v155 = nil;

        while not v147.done do
            v155 = v155 or mapRemainingChildren(p138, v152);
            local v156 = updateFromMap(v155, p138, v148, v147.value, p141, v147.key);

            if v156 == nil then
                v156 = v151;
            else
                if u23 and v156.alternate ~= nil then
                    if v156.key == nil then
                        v155[v148] = nil;
                    else
                        v155[v156.key] = nil;
                    end;
                end;

                v156.index = v148;

                if u23 then
                    local alternate = v156.alternate;

                    if alternate == nil then
                        v156.flags = bit32.bor(v156.flags, Placement);
                    else
                        local index = alternate.index;

                        if index < v150 then
                            v156.flags = bit32.bor(v156.flags, Placement);
                        else
                            v150 = index;
                        end;
                    end;
                end;

                if v151 == nil then
                    v149 = v156;
                else
                    v151.sibling = v156;
                end;
            end;

            v148 = v148 + 1;
            v147 = v146.next();
            v151 = v156;
        end;

        if u23 then
            for _, v in v155 do
                if u23 then
                    local deletions = p138.deletions;

                    if deletions == nil then
                        p138.deletions = { v };
                        p138.flags = bit32.bor(p138.flags, Deletion);
                    else
                        table.insert(deletions, v);
                    end;
                end;
            end;
        end;

        return v149;
    end;

    local function reconcileSingleTextNode(p157: any, p158: any, p159: string, p160: any) -- Line: 1315
        -- upvalues: HostText (ref), u23 (copy), Deletion (ref), createWorkInProgress (ref), createFiberFromText (ref)
        if p158 == nil or p158.tag ~= HostText then
            if u23 then
                while p158 ~= nil do
                    if u23 then
                        local deletions = p157.deletions;

                        if deletions == nil then
                            p157.deletions = { p158 };
                            p157.flags = bit32.bor(p157.flags, Deletion);
                        else
                            table.insert(deletions, p158);
                        end;
                    end;

                    p158 = p158.sibling;
                end;
            end;

            local v161 = createFiberFromText(p159, p157.mode, p160);
            v161.return_ = p157;

            return v161;
        end;

        local sibling = p158.sibling;

        if u23 then
            while sibling ~= nil do
                if u23 then
                    local deletions = p157.deletions;

                    if deletions == nil then
                        p157.deletions = { sibling };
                        p157.flags = bit32.bor(p157.flags, Deletion);
                    else
                        table.insert(deletions, sibling);
                    end;
                end;

                sibling = sibling.sibling;
            end;
        end;

        local v162 = createWorkInProgress(p158, p159);
        v162.index = 1;
        v162.sibling = nil;
        v162.return_ = p157;

        return v162;
    end;

    local function reconcileSingleElement(p163, p164, p165, p166) -- Line: 1340
        -- upvalues: Fragment (ref), REACT_FRAGMENT_TYPE (ref), u23 (copy), Deletion (ref), createWorkInProgress (ref), _G___DEV__ (ref), createFiberFromFragment (ref), createFiberFromElement (ref)
        local key = p165.key;
        local v167 = p164;

        while p164 ~= nil do
            if p164.key == key then
                if p164.tag == Fragment then
                    if p165.type == REACT_FRAGMENT_TYPE then
                        local sibling = p164.sibling;

                        if u23 then
                            while sibling ~= nil do
                                if u23 then
                                    local deletions = p163.deletions;

                                    if deletions == nil then
                                        p163.deletions = { sibling };
                                        p163.flags = bit32.bor(p163.flags, Deletion);
                                    else
                                        table.insert(deletions, sibling);
                                    end;
                                end;

                                sibling = sibling.sibling;
                            end;
                        end;

                        local v168 = createWorkInProgress(p164, p165.props.children);
                        v168.index = 1;
                        v168.sibling = nil;
                        v168.return_ = p163;

                        if _G___DEV__ then
                            v168._debugSource = p165._source;
                            v168._debugOwner = p165._owner;
                        end;

                        return v168;
                    end;
                elseif p164.elementType == p165.type then
                    local sibling = p164.sibling;

                    if u23 then
                        while sibling ~= nil do
                            if u23 then
                                local deletions = p163.deletions;

                                if deletions == nil then
                                    p163.deletions = { sibling };
                                    p163.flags = bit32.bor(p163.flags, Deletion);
                                else
                                    table.insert(deletions, sibling);
                                end;
                            end;

                            sibling = sibling.sibling;
                        end;
                    end;

                    local v169 = createWorkInProgress(p164, p165.props);
                    v169.index = 1;
                    v169.sibling = nil;
                    v169.ref = coerceRef(p163, p164, p165);
                    v169.return_ = p163;

                    if _G___DEV__ then
                        v169._debugSource = p165._source;
                        v169._debugOwner = p165._owner;
                    end;

                    return v169;
                end;

                if u23 then
                    while p164 ~= nil do
                        if u23 then
                            local deletions = p163.deletions;

                            if deletions == nil then
                                p163.deletions = { p164 };
                                p163.flags = bit32.bor(p163.flags, Deletion);
                            else
                                table.insert(deletions, p164);
                            end;
                        end;

                        p164 = p164.sibling;
                    end;
                end;

                break;
            end;

            if u23 then
                local deletions = p163.deletions;

                if deletions == nil then
                    p163.deletions = { p164 };
                    p163.flags = bit32.bor(p163.flags, Deletion);
                else
                    table.insert(deletions, p164);
                end;
            end;

            p164 = p164.sibling;
        end;

        if p165.type == REACT_FRAGMENT_TYPE then
            local v170 = createFiberFromFragment(p165.props.children, p163.mode, p166, p165.key);
            v170.return_ = p163;

            return v170;
        end;

        local v171 = createFiberFromElement(p165, p163.mode, p166);
        v171.ref = coerceRef(p163, v167, p165);
        v171.return_ = p163;

        return v171;
    end;

    local function reconcileSinglePortal(p172, p173, p174, p175) -- Line: 1440
        -- upvalues: HostPortal (ref), u23 (copy), Deletion (ref), createWorkInProgress (ref), createFiberFromPortal (ref)
        local key = p174.key;

        while p173 ~= nil do
            if p173.key == key then
                if p173.tag == HostPortal and (p173.stateNode.containerInfo == p174.containerInfo and p173.stateNode.implementation == p174.implementation) then
                    local sibling = p173.sibling;

                    if u23 then
                        while sibling ~= nil do
                            if u23 then
                                local deletions = p172.deletions;

                                if deletions == nil then
                                    p172.deletions = { sibling };
                                    p172.flags = bit32.bor(p172.flags, Deletion);
                                else
                                    table.insert(deletions, sibling);
                                end;
                            end;

                            sibling = sibling.sibling;
                        end;
                    end;

                    local v176 = createWorkInProgress(p173, p174.children or {});
                    v176.index = 1;
                    v176.sibling = nil;
                    v176.return_ = p172;

                    return v176;
                end;

                if u23 then
                    while p173 ~= nil do
                        if u23 then
                            local deletions = p172.deletions;

                            if deletions == nil then
                                p172.deletions = { p173 };
                                p172.flags = bit32.bor(p172.flags, Deletion);
                            else
                                table.insert(deletions, p173);
                            end;
                        end;

                        p173 = p173.sibling;
                    end;
                end;

                break;
            end;

            if u23 then
                local deletions = p172.deletions;

                if deletions == nil then
                    p172.deletions = { p173 };
                    p172.flags = bit32.bor(p172.flags, Deletion);
                else
                    table.insert(deletions, p173);
                end;
            end;

            p173 = p173.sibling;
        end;

        local v177 = createFiberFromPortal(p174, p172.mode, p175);
        v177.return_ = p172;

        return v177;
    end;

    local function reconcileChildFibers(p178, p179, p180, p181) -- Line: 1479
        -- upvalues: REACT_FRAGMENT_TYPE (ref), isArray (ref), REACT_ELEMENT_TYPE (ref), reconcileSingleElement (copy), u23 (copy), Placement (ref), REACT_PORTAL_TYPE (ref), reconcileSinglePortal (copy), REACT_LAZY_TYPE (ref), enableLazyElements (ref), reconcileChildFibers (copy), reconcileChildrenArray (copy), reconcileSingleTextNode (copy), getIteratorFn (ref), reconcileChildrenIterator (copy), _G___DEV__ (ref), getComponentName (ref), u6 (ref), console (ref), Deletion (ref)
        local v182 = type(p180);
        local v183;

        if p180 == nil or (v182 ~= "table" or p180.type ~= REACT_FRAGMENT_TYPE) then
            v183 = false;
        else
            v183 = p180.key == nil;
        end;

        if v183 then
            p180 = p180.props.children;
            v182 = type(p180);
        end;

        local v184 = isArray(p180);
        local v185;

        if p180 == nil or v182 ~= "table" then
            v185 = false;
        else
            v185 = not v184;
        end;

        if v185 then
            local v186 = p180["$$typeof"];

            if v186 == REACT_ELEMENT_TYPE then
                local v187 = reconcileSingleElement(p178, p179, p180, p181);

                if u23 and v187.alternate == nil then
                    v187.flags = bit32.bor(v187.flags, Placement);
                end;

                return v187;
            end;

            if v186 == REACT_PORTAL_TYPE then
                local v188 = reconcileSinglePortal(p178, p179, p180, p181);

                if u23 and v188.alternate == nil then
                    v188.flags = bit32.bor(v188.flags, Placement);
                end;

                return v188;
            end;

            if v186 == REACT_LAZY_TYPE and enableLazyElements then
                return reconcileChildFibers(p178, p179, p180._init(p180._payload), p181);
            end;
        else
            if v184 then
                return reconcileChildrenArray(p178, p179, p180, p181);
            end;

            if v182 == "string" or v182 == "number" then
                local v189 = reconcileSingleTextNode(p178, p179, tostring(p180), p181);

                if u23 and v189.alternate == nil then
                    v189.flags = bit32.bor(v189.flags, Placement);
                end;

                return v189;
            end;
        end;

        local v190 = getIteratorFn(p180);

        if v190 then
            return reconcileChildrenIterator(p178, p179, p180, p181, v190);
        end;

        if _G___DEV__ and (v182 == "function" and _G___DEV__) then
            local v191 = getComponentName(p178.type) or "Component";

            if not u6[v191] then
                u6[v191] = true;
                console.error("Functions are not valid as a React child. This may happen if you return a Component instead of <Component /> from render. Or maybe you meant to call this function rather than return it.");
            end;
        end;

        local _ = p180 == nil;

        if not u23 then
            return nil;
        end;

        while p179 ~= nil do
            if u23 then
                local deletions = p178.deletions;

                if deletions == nil then
                    p178.deletions = { p179 };
                    p178.flags = bit32.bor(p178.flags, Deletion);
                else
                    table.insert(deletions, p179);
                end;
            end;

            p179 = p179.sibling;
        end;

        return nil;
    end;

    return reconcileChildFibers;
end;

v3.reconcileChildFibers = ChildReconciler(true);
v3.mountChildFibers = ChildReconciler(false);

function v3.cloneChildFibers(p192, p193) -- Line: 1627
    -- upvalues: createWorkInProgress (copy)
    if p193.child == nil then
        return;
    end;

    local child = p193.child;
    local v194 = createWorkInProgress(child, child.pendingProps);
    p193.child = v194;
    v194.return_ = p193;

    while child.sibling ~= nil do
        child = child.sibling;
        v194.sibling = createWorkInProgress(child, child.pendingProps);
        v194 = v194.sibling;
        v194.return_ = p193;
    end;

    v194.sibling = nil;
end;

function v3.resetChildFibers(p195, p196) -- Line: 1654
    -- upvalues: resetWorkInProgress (copy)
    local child = p195.child;

    while child ~= nil do
        resetWorkInProgress(child, p196);
        child = child.sibling;
    end;
end;

return v3;