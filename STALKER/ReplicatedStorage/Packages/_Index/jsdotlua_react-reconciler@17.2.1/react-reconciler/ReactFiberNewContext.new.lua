-- Decompiled with Potassium's decompiler.

local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Number = v1.Number;
local Error = v1.Error;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local v2 = require(script.Parent:WaitForChild("ReactFiberStack.new"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
local v3 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"));
local isPrimaryRenderer = require(script.Parent:WaitForChild("ReactFiberHostConfig")).isPrimaryRenderer;
local createCursor = v2.createCursor;
local push = v2.push;
local pop = v2.pop;
local MAX_SIGNED_31_BIT_INT = require(script.Parent:WaitForChild("MaxInts")).MAX_SIGNED_31_BIT_INT;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local ContextProvider = ReactWorkTags.ContextProvider;
local ClassComponent = ReactWorkTags.ClassComponent;
local NoLanes = ReactFiberLane.NoLanes;
local NoTimestamp = ReactFiberLane.NoTimestamp;
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes;
local includesSomeLane = ReactFiberLane.includesSomeLane;
local mergeLanes = ReactFiberLane.mergeLanes;
local pickArbitraryLane = ReactFiberLane.pickArbitraryLane;
local objectIs = require(script.Parent.Parent:WaitForChild("shared")).objectIs;
local createUpdate = v3.createUpdate;
local ForceUpdate = v3.ForceUpdate;
local u4 = {};
local u5 = createCursor(nil);
local u6 = _G.__DEV__ and {} or nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = false;

function u4.resetContextDependencies() -- Line: 72
    -- upvalues: u7 (ref), u8 (ref), u9 (ref), u10 (ref)
    u7 = nil;
    u8 = nil;
    u9 = nil;

    if _G.__DEV__ then
        u10 = false;
    end;
end;

function u4.enterDisallowedContextReadInDEV() -- Line: 83
    -- upvalues: u10 (ref)
    if _G.__DEV__ then
        u10 = true;
    end;
end;

function u4.exitDisallowedContextReadInDEV() -- Line: 89
    -- upvalues: u10 (ref)
    if _G.__DEV__ then
        u10 = false;
    end;
end;

function u4.pushProvider(p11, p12) -- Line: 95
    -- upvalues: isPrimaryRenderer (copy), push (copy), u5 (copy), u6 (ref), console (copy)
    local _context = p11.type._context;

    if isPrimaryRenderer then
        push(u5, _context._currentValue, p11);
        _context._currentValue = p12;

        if _G.__DEV__ then
            if _context._currentRenderer ~= nil and _context._currentRenderer ~= u6 then
                console.error("Detected multiple renderers concurrently rendering the same context provider. This is currently unsupported.");
            end;

            _context._currentRenderer = u6;
        end;
    else
        push(u5, _context._currentValue2, p11);
        _context._currentValue2 = p12;

        if _G.__DEV__ then
            if _context._currentRenderer2 ~= nil and _context._currentRenderer2 ~= u6 then
                console.error("Detected multiple renderers concurrently rendering the same context provider. This is currently unsupported.");
            end;

            _context._currentRenderer2 = u6;
        end;
    end;
end;

function u4.popProvider(p13) -- Line: 133
    -- upvalues: u5 (copy), pop (copy), isPrimaryRenderer (copy)
    local current = u5.current;
    pop(u5, p13);
    local _context = p13.type._context;

    if isPrimaryRenderer then
        _context._currentValue = current;

        return;
    end;

    _context._currentValue2 = current;
end;

function u4.calculateChangedBits(p14, p15, p16) -- Line: 147
    -- upvalues: objectIs (copy), MAX_SIGNED_31_BIT_INT (copy)
    if objectIs(p16, p15) then
        return 0;
    end;

    local v17 = MAX_SIGNED_31_BIT_INT;

    if typeof(p14._calculateChangedBits) == "function" then
        v17 = p14._calculateChangedBits(p16, p15);
    end;

    return math.floor(v17);
end;

function u4.scheduleWorkOnParentPath(p18, p19) -- Line: 174
    -- upvalues: isSubsetOfLanes (copy), mergeLanes (copy)
    while p18 ~= nil do
        local alternate = p18.alternate;

        if isSubsetOfLanes(p18.childLanes, p19) then
            if alternate == nil or isSubsetOfLanes(alternate.childLanes, p19) then
                break;
            end;

            alternate.childLanes = mergeLanes(alternate.childLanes, p19);
        else
            p18.childLanes = mergeLanes(p18.childLanes, p19);

            if alternate ~= nil then
                alternate.childLanes = mergeLanes(alternate.childLanes, p19);
            end;
        end;

        p18 = p18.return_;
    end;
end;

function u4.propagateContextChange(p20: any, p21: any, p22: number, p23: any) -- Line: 197
    -- upvalues: ClassComponent (copy), createUpdate (copy), NoTimestamp (copy), pickArbitraryLane (copy), ForceUpdate (copy), u4 (copy), ContextProvider (copy)
    local child = p20.child;

    if child ~= nil then
        child.return_ = p20;
    end;

    while true do
        local v24;

        if true then
            if child == nil then
                return;
            end;

            local dependencies = child.dependencies;

            if dependencies == nil then
                if child.tag == ContextProvider then
                    if child.type == p20.type then
                        v24 = nil;
                    else
                        v24 = child.child;
                    end;
                else
                    v24 = child.child;
                end;
            else
                v24 = child.child;
                local firstContext = dependencies.firstContext;

                while firstContext ~= nil do
                    if firstContext.context == p21 and bit32.band(firstContext.observedBits, p22) ~= 0 then
                        if child.tag == ClassComponent then
                            local v25 = createUpdate(NoTimestamp, pickArbitraryLane(p23));
                            v25.tag = ForceUpdate;
                            local updateQueue = child.updateQueue;

                            if updateQueue ~= nil then
                                local shared = updateQueue.shared;
                                local pending = shared.pending;

                                if pending == nil then
                                    v25.next = v25;
                                else
                                    v25.next = pending.next;
                                    pending.next = v25;
                                end;

                                shared.pending = v25;
                            end;
                        end;

                        child.lanes = bit32.bor(child.lanes, p23);
                        local alternate = child.alternate;

                        if alternate ~= nil then
                            alternate.lanes = bit32.bor(alternate.lanes, p23);
                        end;

                        u4.scheduleWorkOnParentPath(child.return_, p23);
                        dependencies.lanes = bit32.bor(dependencies.lanes, p23);
                        break;
                    end;

                    firstContext = firstContext.next;
                end;
            end;
        end;

        if v24 == nil then
            while true do
                if child == nil then
                    v24 = child;
                end;

                if child == p20 then
                    v24 = nil;
                end;

                v24 = child.sibling;

                if v24 ~= nil then
                    v24.return_ = child.return_;
                end;

                child = child.return_;
            end;
        else
            v24.return_ = child;
        end;

        child = v24;
    end;
end;

function u4.prepareToReadContext(p26: any, p27: any, p28: function) -- Line: 336
    -- upvalues: u7 (ref), u8 (ref), u9 (ref), includesSomeLane (copy)
    u7 = p26;
    u8 = nil;
    u9 = nil;
    local dependencies = p26.dependencies;

    if dependencies ~= nil and dependencies.firstContext ~= nil then
        if includesSomeLane(dependencies.lanes, p27) then
            p28();
        end;

        dependencies.firstContext = nil;
    end;
end;

function u4.readContext(p29, p30) -- Line: 360
    -- upvalues: u10 (ref), console (copy), u9 (ref), Number (copy), u8 (ref), u7 (ref), Error (copy), NoLanes (copy), isPrimaryRenderer (copy)
    if _G.__DEV__ and u10 then
        console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().");
    end;

    if u9 ~= p29 and (p30 ~= false and p30 ~= 0) then
        if typeof(p30) ~= "number" or p30 == Number.MAX_SAFE_INTEGER then
            u9 = p29;
            p30 = Number.MAX_SAFE_INTEGER;
        end;

        local v31 = {
            next = nil,
            context = p29,
            observedBits = p30
        };

        if u8 == nil then
            if u7 == nil then
                error(Error.new("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo()."));
            end;

            u8 = v31;
            u7.dependencies = {
                responders = nil,
                lanes = NoLanes,
                firstContext = v31
            };
        else
            u8.next = v31;
            u8 = v31;
        end;
    end;

    if isPrimaryRenderer then
        return p29._currentValue;
    end;

    return p29._currentValue2;
end;

return u4;