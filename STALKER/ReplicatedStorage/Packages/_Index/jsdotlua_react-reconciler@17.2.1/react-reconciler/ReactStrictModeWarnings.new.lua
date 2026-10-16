-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"));
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber;
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local StrictMode = require(script.Parent:WaitForChild("ReactTypeOfMode")).StrictMode;
local v5 = {
    recordUnsafeLifecycleWarnings = function(p1, p2) -- Line: 30, Name: recordUnsafeLifecycleWarnings
    end,

    flushPendingUnsafeLifecycleWarnings = function() -- Line: 31, Name: flushPendingUnsafeLifecycleWarnings
    end,

    recordLegacyContextWarning = function(p3, p4) -- Line: 32, Name: recordLegacyContextWarning
    end,

    flushLegacyContextWarning = function() -- Line: 33, Name: flushLegacyContextWarning
    end,

    discardPendingWarnings = function() -- Line: 34, Name: discardPendingWarnings
    end
};

if _G.__DEV__ then
    local function _(p6) -- Line: 38
        -- upvalues: StrictMode (copy)
        local v7 = nil;

        while p6 ~= nil do
            if bit32.band(p6.mode, StrictMode) ~= 0 then
                v7 = p6;
            end;

            p6 = p6.return_;
        end;

        return v7;
    end;

    local function u10(p8) -- Line: 53
        local v9 = {};

        for i, _ in p8 do
            table.insert(v9, i);
        end;

        table.sort(v9);

        return table.concat(v9, ", ");
    end;

    local u11 = {};
    local u12 = {};
    local u13 = {};
    local u14 = {};
    local u15 = {};
    local u16 = {};
    local u17 = {};

    function v5.recordUnsafeLifecycleWarnings(p18, p19) -- Line: 73
        -- upvalues: u17 (copy), u11 (copy), StrictMode (copy), u12 (copy), u13 (copy), u14 (copy), u15 (copy), u16 (copy)
        if u17[p18.type] then
            return;
        end;

        if typeof(p19.componentWillMount) == "function" then
            table.insert(u11, p18);
        end;

        if bit32.band(p18.mode, StrictMode) ~= 0 and typeof(p19.UNSAFE_componentWillMount) == "function" then
            table.insert(u12, p18);
        end;

        if typeof(p19.componentWillReceiveProps) == "function" then
            table.insert(u13, p18);
        end;

        if bit32.band(p18.mode, StrictMode) ~= 0 and typeof(p19.UNSAFE_componentWillReceiveProps) == "function" then
            table.insert(u14, p18);
        end;

        if typeof(p19.componentWillUpdate) == "function" then
            table.insert(u15, p18);
        end;

        if bit32.band(p18.mode, StrictMode) ~= 0 and typeof(p19.UNSAFE_componentWillUpdate) == "function" then
            table.insert(u16, p18);
        end;
    end;

    function v5.flushPendingUnsafeLifecycleWarnings() -- Line: 126
        -- upvalues: u11 (copy), getComponentName (copy), u17 (copy), u12 (copy), u13 (copy), u14 (copy), u15 (copy), u16 (copy), u10 (copy), console (copy)
        local v20 = {};

        if #u11 > 0 then
            for _, v in u11 do
                v20[getComponentName(v.type) or "Component"] = true;
                u17[v.type] = true;
            end;

            table.clear(u11);
        end;

        local v21 = {};

        if #u12 > 0 then
            for _, v in u12 do
                v21[getComponentName(v.type) or "Component"] = true;
                u17[v.type] = true;
            end;

            table.clear(u12);
        end;

        local v22 = {};

        if #u13 > 0 then
            for _, v in u13 do
                v22[getComponentName(v.type) or "Component"] = true;
                u17[v.type] = true;
            end;

            table.clear(u13);
        end;

        local v23 = {};

        if #u14 > 0 then
            for _, v in u14 do
                v23[getComponentName(v.type) or "Component"] = true;
                u17[v.type] = true;
            end;

            table.clear(u14);
        end;

        local v24 = {};

        if #u15 > 0 then
            for _, v in u15 do
                v24[getComponentName(v.type) or "Component"] = true;
                u17[v.type] = true;
            end;

            table.clear(u15);
        end;

        local v25 = {};

        if #u16 > 0 then
            for _, v in u16 do
                v25[getComponentName(v.type) or "Component"] = true;
                u17[v.type] = true;
            end;

            table.clear(u16);
        end;

        if next(v21) ~= nil then
            local v26 = u10(v21);
            console.error("Using UNSAFE_componentWillMount in strict mode is not recommended and may indicate bugs in your code. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move code with side effects to componentDidMount, and set initial state in the constructor.\n\nPlease update the following components: %s", v26);
        end;

        if next(v23) ~= nil then
            local v27 = u10(v23);
            console.error("Using UNSAFE_componentWillReceiveProps in strict mode is not recommended and may indicate bugs in your code. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n* If you\'re updating state whenever props change, refactor your code to use memoization techniques or move it to static getDerivedStateFromProps. Learn more at: https://reactjs.org/link/derived-state\n\nPlease update the following components: %s", v27);
        end;

        if next(v25) ~= nil then
            local v28 = u10(v25);
            console.error("Using UNSAFE_componentWillUpdate in strict mode is not recommended and may indicate bugs in your code. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n\nPlease update the following components: %s", v28);
        end;

        if next(v20) ~= nil then
            local v29 = u10(v20);
            console.warn("componentWillMount has been renamed, and is not recommended for use. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move code with side effects to componentDidMount, and set initial state in the constructor.\n* Rename componentWillMount to UNSAFE_componentWillMount to suppress this warning in non-strict mode. In React 18.x, only the UNSAFE_ name will work.\n\nPlease update the following components: %s", v29);
        end;

        if next(v22) ~= nil then
            local v30 = u10(v22);
            console.warn("componentWillReceiveProps has been renamed, and is not recommended for use. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n* If you\'re updating state whenever props change, refactor your code to use memoization techniques or move it to static getDerivedStateFromProps. Learn more at: https://reactjs.org/link/derived-state\n* Rename componentWillReceiveProps to UNSAFE_componentWillReceiveProps to suppress this warning in non-strict mode. In React 18.x, only the UNSAFE_ name will work.\n\nPlease update the following components: %s", v30);
        end;

        if next(v24) ~= nil then
            local v31 = u10(v24);
            console.warn("componentWillUpdate has been renamed, and is not recommended for use. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n* Rename componentWillUpdate to UNSAFE_componentWillUpdate to suppress this warning in non-strict mode. In React 18.x, only the UNSAFE_ name will work.\n\nPlease update the following components: %s", v31);
        end;
    end;

    local u32 = {};
    local u33 = {};

    function v5.recordLegacyContextWarning(p34, p35) -- Line: 300
        -- upvalues: StrictMode (copy), console (copy), u33 (copy), u32 (copy)
        local v36 = p34;
        local v37 = nil;

        while p34 ~= nil do
            if bit32.band(p34.mode, StrictMode) ~= 0 then
                v37 = p34;
            end;

            p34 = p34.return_;
        end;

        if v37 == nil then
            console.error("Expected to find a StrictMode component in a strict mode tree. This error is likely caused by a bug in React. Please file an issue.");

            return;
        end;

        if u33[v36.type] then
            return;
        end;

        local v38 = u32[v37];

        if typeof(v36.type) ~= "function" and (v36.type.contextTypes ~= nil or (v36.type.childContextTypes ~= nil or p35 ~= nil and typeof(p35.getChildContext) == "function")) then
            if v38 == nil then
                v38 = {};
                u32[v37] = v38;
            end;

            table.insert(v38, v36);
        end;
    end;

    function v5.flushLegacyContextWarning() -- Line: 339
        -- upvalues: u32 (copy), getComponentName (copy), u33 (copy), u10 (copy), setCurrentFiber (copy), console (copy), resetCurrentFiber (copy)
        for _, v in u32 do
            if #v == 0 then
                return;
            end;

            local u39 = v[1];
            local v40 = {};

            for _, v2 in v do
                v40[getComponentName(v2.type) or "Component"] = true;
                u33[v2.type] = true;
            end;

            local u41 = u10(v40);
            local success, result = pcall(function() -- Line: 354
                -- upvalues: setCurrentFiber (ref), u39 (copy), console (ref), u41 (copy)
                setCurrentFiber(u39);
                console.error("Legacy context API has been detected within a strict-mode tree.\n\nThe old API will be supported in all 16.x releases, but applications using it should migrate to the new version.\n\nPlease update the following components: %s\n\nLearn more about this warning here: https://reactjs.org/link/legacy-context", u41);
            end);
            resetCurrentFiber();

            if not success then
                error(result);
            end;
        end;
    end;

    function v5.discardPendingWarnings() -- Line: 377
        -- upvalues: u11 (copy), u12 (copy), u13 (copy), u14 (copy), u15 (copy), u16 (copy), u32 (copy)
        table.clear(u11);
        table.clear(u12);
        table.clear(u13);
        table.clear(u14);
        table.clear(u15);
        table.clear(u16);
        table.clear(u32);
    end;
end;

return v5;