-- Decompiled with Potassium's decompiler.

local DependencyGraph = require(script.Parent.DependencyGraph);
local Pipeline = require(script.Parent.Pipeline);
local Phase = require(script.Parent.Phase);
local utils = require(script.Parent.utils);
local hooks = require(script.Parent.hooks);
local conditions = require(script.Parent.conditions);
local getSystem = utils.getSystem;
local getSystemName = utils.getSystemName;
local isPhase = utils.isPhase;
local isPipeline = utils.isPipeline;
local isValidEvent = utils.isValidEvent;
local getEventIdentifier = utils.getEventIdentifier;
local u1 = {};
local os_clock_ret = os.clock();
local u2 = {};
u2.__index = u2;
u2.Hooks = hooks.Hooks;

function u2.addPlugin(p3, p4) -- Line: 51
    p4:build(p3);
    table.insert(p3._plugins, p4);

    return p3;
end;

function u2._addHook(p5, p6, p7) -- Line: 57
    local v8 = p5._hooks[p6];
    local v9 = `Unknown Hook: {p6}`;
    assert(v8, v9);
    table.insert(p5._hooks[p6], p7);
end;

function u2.getDeltaTime(p10) -- Line: 68
    local debug_info_ret = debug.info(2, "f");

    if not (debug_info_ret and p10._systemInfo[debug_info_ret]) then
        error("Scheduler:getDeltaTime() must be used within a registered system");
    end;

    return p10._systemInfo[debug_info_ret].deltaTime or 0;
end;

function u2._handleLogs(p11, p12) -- Line: 80
    if not p12.timeLastLogged then
        p12.timeLastLogged = os.clock();
    end;

    if not p12.recentLogs then
        p12.recentLogs = {};
    end;

    if os.clock() - p12.timeLastLogged > 10 then
        p12.timeLastLogged = os.clock();
        p12.recentLogs = {};
    end;

    local debug_info_ret = debug.info(p12.system, "n");

    for _, v in p12.logs do
        if not p12.recentLogs[v] then
            task.spawn(error, v, 0);
            warn((`Planck: Error occurred in system{string.len(debug_info_ret) > 0 and (` '{debug_info_ret}'` or "") or ""}, this error will be ignored for 10 seconds`));
            p12.recentLogs[v] = true;
        end;
    end;

    table.clear(p12.logs);
end;

function u2.runSystem(u13, u14) -- Line: 109
    -- upvalues: hooks (copy), os_clock_ret (ref), u1 (ref)
    if u13:_canRun(u14) == false then
        return;
    end;

    local u15 = u13._systemInfo[u14];
    local os_clock_ret2 = os.clock();
    u15.deltaTime = os_clock_ret2 - (u15.lastTime or os_clock_ret2);
    u15.lastTime = os_clock_ret2;

    if not u13._thread then
        u13._thread = coroutine.create(function() -- Line: 121
            -- upvalues: u13 (copy)
            while true do
                local coroutine_yield_ret = coroutine.yield();
                u13._yielded = true;
                coroutine_yield_ret();
                u13._yielded = false;
            end;
        end);
        coroutine.resume(u13._thread);
    end;

    local u16 = false;

    local function systemCall() -- Line: 135
        -- upvalues: u13 (copy), u14 (copy), u16 (ref), u15 (copy), hooks (ref)
        hooks.systemCall(u13, "SystemCall", u15, function() -- Line: 136, Name: noYield
            -- upvalues: u13 (ref), u14 (ref), u16 (ref), u15 (ref), hooks (ref)
            local u17 = nil;
            local u18 = nil;
            coroutine.resume(u13._thread, function() -- Line: 138
                -- upvalues: u17 (ref), u18 (ref), u14 (ref), u13 (ref)
                local v20, v21 = xpcall(u14, function(p19) -- Line: 139
                    return debug.traceback(p19);
                end, table.unpack(u13._vargs));
                u17 = v20;
                u18 = v21;
            end);

            if u17 ~= false then
                if u13._yielded then
                    u16 = true;
                    local debug_info_ret, v22 = debug.info(u13._thread, 1, "sl");
                    local v23 = `{debug_info_ret}:{v22}: System yielded`;
                    table.insert(u15.logs, debug.traceback(u13._thread, v23, 2));
                    hooks.systemError(u13, u15, debug.traceback(u13._thread, v23, 2));
                end;

                return;
            end;

            u16 = true;
            table.insert(u15.logs, u18);
            hooks.systemError(u13, u15, u18);
        end);
    end;

    local function inner() -- Line: 170
        -- upvalues: hooks (ref), u13 (copy), u15 (copy), systemCall (copy)
        hooks.systemCall(u13, "InnerSystemCall", u15, systemCall);
    end;

    local function outer() -- Line: 174
        -- upvalues: hooks (ref), u13 (copy), u15 (copy), inner (copy)
        hooks.systemCall(u13, "OuterSystemCall", u15, inner);
    end;

    if os.clock() - os_clock_ret > 10 then
        os_clock_ret = os.clock();
        u1 = {};
    end;

    local success, result = pcall(outer);

    if not (success or u1[result]) then
        task.spawn(error, result, 0);
        warn("Planck: Error occurred while running hooks, this error will be ignored for 10 seconds");
        hooks.systemError(u13, u15, (`Error occurred while running hooks: {result}`));
        u1[result] = true;
    end;

    if u16 then
        coroutine.close(u13._thread);
        u13._thread = coroutine.create(function() -- Line: 200
            -- upvalues: u13 (copy)
            while true do
                local coroutine_yield_ret = coroutine.yield();
                u13._yielded = true;
                coroutine_yield_ret();
                u13._yielded = false;
            end;
        end);
        coroutine.resume(u13._thread);
    end;

    u13:_handleLogs(u15);
end;

function u2.runPhase(p24, p25) -- Line: 215
    -- upvalues: hooks (copy)
    if p24:_canRun(p25) == false then
        return;
    end;

    hooks.phaseBegan(p24, p25);

    if not p24._phaseToSystems[p25] then
        p24._phaseToSystems[p25] = {};
    end;

    for _, v in p24._phaseToSystems[p25] do
        p24:runSystem(v);
    end;
end;

function u2.runPipeline(p26, p27) -- Line: 231
    if p26:_canRun(p27) == false then
        return;
    end;

    local OrderedList = p27.dependencyGraph:getOrderedList();
    local v28 = `Pipeline {p27} contains a circular dependency, check it's Phases`;
    assert(OrderedList, v28);

    for _, v in OrderedList do
        p26:runPhase(v);
    end;
end;

function u2._canRun(p29, p30) -- Line: 247
    local v31 = p29._runIfConditions[p30];

    if v31 then
        for _, v in v31 do
            if v(table.unpack(p29._vargs)) == false then
                return false;
            end;
        end;
    end;

    return true;
end;

function u2.run(p32, p33) -- Line: 282
    -- upvalues: Pipeline (copy), getSystem (copy), isPhase (copy), isPipeline (copy)
    if not p33 then
        error("No dependent specified in Scheduler:run(_)");
    end;

    p32:runPipeline(Pipeline.Startup);

    if getSystem(p33) then
        p32:runSystem(p33);

        return p32;
    end;

    if isPhase(p33) then
        p32:runPhase(p33);

        return p32;
    end;

    if isPipeline(p33) then
        p32:runPipeline(p33);

        return p32;
    end;

    error("Unknown dependent passed into Scheduler:run(unknown)");

    return p32;
end;

function u2.runAll(p34) -- Line: 320
    local OrderedList = p34._defaultDependencyGraph:getOrderedList();
    assert(OrderedList, "Default Group contains a circular dependency, check your Pipelines/Phases");

    for _, v in OrderedList do
        p34:run(v);
    end;

    for i, v in p34._eventDependencyGraphs do
        local OrderedList2 = v:getOrderedList();
        local v35 = `Event Group '{i}' contains a circular dependency, check your Pipelines/Phases`;
        assert(OrderedList, v35);

        for _, v2 in OrderedList2 do
            p34:run(v2);
        end;
    end;

    return p34;
end;

function u2.insert(p36, p37, p38, p39) -- Line: 395
    -- upvalues: isPhase (copy), isPipeline (copy), isValidEvent (copy), hooks (copy)
    local v40 = isPhase(p37) or isPipeline(p37);
    assert(v40, "Unknown dependency passed to Scheduler:insert(unknown, _, _)");

    if p38 then
        local v41 = isValidEvent(p38, p39);
        assert(v41, "Unknown instance/event passed to Scheduler:insert(_, instance, event)");
        p36:_getEventDependencyGraph(p38, p39):insert(p37);
    else
        p36._defaultDependencyGraph:insertBefore(p37, p36._defaultPhase);
    end;

    if isPhase(p37) then
        p36._phaseToSystems[p37] = {};
        hooks.phaseAdd(p36, p37);
    end;

    return p36;
end;

function u2.insertAfter(p42, p43, p44) -- Line: 441
    -- upvalues: isPhase (copy), isPipeline (copy), hooks (copy)
    local v45 = isPhase(p44) or isPipeline(p44);
    assert(v45, "Unknown dependency passed in Scheduler:insertAfter(_, unknown)");
    local v46 = isPhase(p43) or isPipeline(p43);
    assert(v46, "Unknown dependent passed in Scheduler:insertAfter(unknown, _)");
    p42:_getGraphOfDependency(p44):insertAfter(p43, p44);

    if isPhase(p43) then
        p42._phaseToSystems[p43] = {};
        hooks.phaseAdd(p42, p43);
    end;

    return p42;
end;

function u2.insertBefore(p47, p48, p49) -- Line: 481
    -- upvalues: isPhase (copy), isPipeline (copy), hooks (copy)
    local v50 = isPhase(p49) or isPipeline(p49);
    assert(v50, "Unknown dependency passed in Scheduler:insertBefore(_, unknown)");
    local v51 = isPhase(p48) or isPipeline(p48);
    assert(v51, "Unknown dependent passed in Scheduler:insertBefore(unknown, _)");
    p47:_getGraphOfDependency(p49):insertBefore(p48, p49);

    if isPhase(p48) then
        p47._phaseToSystems[p48] = {};
        hooks.phaseAdd(p47, p48);
    end;

    return p47;
end;

function u2.addSystem(p52, p53, p54) -- Line: 509
    -- upvalues: getSystem (copy), getSystemName (copy), hooks (copy)
    local v55 = getSystem(p53);

    if not v55 then
        error("Unknown system passed to Scheduler:addSystem(unknown, phase?)");
    end;

    local v56 = getSystemName(v55);

    if type(p53) == "table" and p53.name then
        v56 = p53.name;
    end;

    local v57 = {
        system = v55,
        phase = p54,
        name = v56,
        logs = {}
    };

    if not p54 then
        if type(p53) == "table" and p53.phase then
            v57.phase = p53.phase;
        else
            v57.phase = p52._defaultPhase;
        end;
    end;

    p52._systemInfo[v55] = v57;

    if not p52._phaseToSystems[v57.phase] then
        p52._phaseToSystems[v57.phase] = {};
    end;

    table.insert(p52._phaseToSystems[v57.phase], v55);
    hooks.systemAdd(p52, v57);

    if type(p53) == "table" and p53.runConditions then
        for _, v in p53.runConditions do
            p52:addRunCondition(v55, v);
        end;
    end;

    return p52;
end;

function u2.addSystems(p58, p59, p60) -- Line: 562
    -- upvalues: getSystem (copy)
    if type(p59) ~= "table" then
        error("Unknown systems passed to Scheduler:addSystems(unknown, phase?)");
    end;

    local v61 = 0;
    local v62 = false;

    for _, v in p59 do
        v61 = v61 + 1;

        if getSystem(v) then
            p58:addSystem(v, p60);
            v62 = true;
        end;
    end;

    if v61 == 0 then
        error("Empty table passed to Scheduler:addSystems({ }, phase?)");
    end;

    if not v62 then
        error("Unknown table passed to Scheduler:addSystems({ unknown }, phase?)");
    end;

    return p58;
end;

function u2.editSystem(p63, p64, p65) -- Line: 597
    -- upvalues: getSystem (copy)
    local v66 = getSystem(p64);
    local v67 = p63._systemInfo[v66];
    assert(v67, "Attempt to remove a non-exist system in Scheduler:removeSystem(_)");
    local _ = p65 and p63._phaseToSystems[p65] ~= nil;
    assert(true, "Phase never initialized before using Scheduler:editSystem(_, Phase)");
    local v68 = p63._phaseToSystems[v67.phase];
    local table_find_ret = table.find(v68, v66);
    assert(table_find_ret, "Unable to find system within phase");
    table.remove(v68, table_find_ret);

    if not p63._phaseToSystems[p65] then
        p63._phaseToSystems[p65] = {};
    end;

    table.insert(p63._phaseToSystems[p65], v66);
    v67.phase = p65;

    return p63;
end;

function u2._removeCondition(p69, p70, p71) -- Line: 626
    -- upvalues: conditions (copy)
    p69._runIfConditions[p70] = nil;

    for _, v in p69._runIfConditions do
        if table.find(v, p71) then
            return;
        end;
    end;

    conditions.cleanupCondition(p71);
end;

function u2.removeSystem(p72, p73) -- Line: 643
    -- upvalues: getSystem (copy), hooks (copy)
    local v74 = getSystem(p73);
    local v75 = p72._systemInfo[v74];
    assert(v75, "Attempt to remove a non-exist system in Scheduler:removeSystem(_)");
    local v76 = p72._phaseToSystems[v75.phase];
    local table_find_ret = table.find(v76, v74);
    assert(table_find_ret, "Unable to find system within phase");
    table.remove(v76, table_find_ret);
    p72._systemInfo[v74] = nil;

    if p72._runIfConditions[p73] then
        for _, v in p72._runIfConditions[p73] do
            p72:_removeCondition(p73, v);
        end;

        p72._runIfConditions[p73] = nil;
    end;

    hooks.systemRemove(p72, v75);

    return p72;
end;

function u2.replaceSystem(p77, p78, p79) -- Line: 678
    -- upvalues: getSystem (copy), getSystemName (copy), hooks (copy)
    local v80 = getSystem(p78);
    local v81 = p77._systemInfo[v80];
    assert(v81, "Attempt to replace a non-existent system in Scheduler:replaceSystem(unknown, _)");
    local v82 = getSystem(p79);
    assert(v82, "Attempt to pass non-system in Scheduler:replaceSystem(_, unknown)");
    local v83 = p77._phaseToSystems[v81.phase];
    local table_find_ret = table.find(v83, v80);
    assert(table_find_ret, "Unable to find system within phase");
    table.remove(v83, table_find_ret);
    table.insert(v83, table_find_ret, v82);
    local table_clone_ret = table.clone(v81);
    v81.system = v82;
    v81.name = getSystemName(v82);
    hooks.systemReplace(p77, table_clone_ret, v81);
    p77._systemInfo[v82] = p77._systemInfo[v80];
    p77._systemInfo[v80] = nil;

    return p77;
end;

function u2.addRunCondition(p84, p85, p86) -- Line: 737
    -- upvalues: getSystem (copy), isPhase (copy), isPipeline (copy)
    local v87 = getSystem(p85);
    local v88 = v87 or p85;
    local v89 = v87 or (isPhase(v88) or isPipeline(v88));
    assert(v89, "Attempt to pass unknown dependent into Scheduler:addRunCondition(unknown, _)");

    if not p84._runIfConditions[v88] then
        p84._runIfConditions[v88] = {};
    end;

    table.insert(p84._runIfConditions[v88], p86);

    return p84;
end;

function u2._addBuiltins(p90) -- Line: 757
    -- upvalues: Phase (copy), DependencyGraph (copy), Pipeline (copy), conditions (copy)
    p90._defaultPhase = Phase.new("Default");
    p90._defaultDependencyGraph = DependencyGraph.new();
    p90._defaultDependencyGraph:insert(Pipeline.Startup);
    p90._defaultDependencyGraph:insert(p90._defaultPhase);
    p90:addRunCondition(Pipeline.Startup, conditions.runOnce());

    for _, v in Pipeline.Startup.dependencyGraph.nodes do
        p90:addRunCondition(v, conditions.runOnce());
    end;
end;

function u2._scheduleEvent(u91, p92, p93) -- Line: 770
    -- upvalues: utils (copy), getEventIdentifier (copy), DependencyGraph (copy), u1 (ref)
    local ConnectFunction = utils.getConnectFunction(p92, p93);
    assert(ConnectFunction, "Couldn\'t connect to event as no valid connect methods were found! Ensure the passed event has a \'Connect\' or an \'on\' method!");
    local u94 = getEventIdentifier(p92, p93);
    local u95 = DependencyGraph.new();
    u91._connectedEvents[u94] = ConnectFunction(function() -- Line: 781
        -- upvalues: u95 (copy), u94 (copy), u1 (ref), u91 (copy)
        local OrderedList = u95:getOrderedList();

        if OrderedList == nil then
            local v96 = `Event Group '{u94}' contains a circular dependency, check your Pipelines/Phases`;

            if not u1[v96] then
                task.spawn(error, v96, 0);
                warn("Planck: Error occurred while running event, this error will be ignored for 10 seconds");
                u1[v96] = true;
            end;
        end;

        for _, v in OrderedList do
            u91:run(v);
        end;
    end);
    u91._eventDependencyGraphs[u94] = u95;
end;

function u2._getEventDependencyGraph(p97, p98, p99) -- Line: 805
    -- upvalues: getEventIdentifier (copy)
    local v100 = getEventIdentifier(p98, p99);

    if not p97._connectedEvents[v100] then
        p97:_scheduleEvent(p98, p99);
    end;

    return p97._eventDependencyGraphs[v100];
end;

function u2._getGraphOfDependency(p101, p102) -- Line: 815
    if table.find(p101._defaultDependencyGraph.nodes, p102) then
        return p101._defaultDependencyGraph;
    end;

    for _, v in p101._eventDependencyGraphs do
        if table.find(v.nodes, p102) then
            return v;
        end;
    end;

    error("Dependency does not belong to a DependencyGraph");
end;

function u2.cleanup(p103) -- Line: 848
    -- upvalues: utils (copy), conditions (copy)
    for _, v in p103._connectedEvents do
        utils.disconnectEvent(v);
    end;

    for _, v in p103._plugins do
        if v.cleanup then
            v:cleanup();
        end;
    end;

    if p103._thread then
        coroutine.close(p103._thread);
    end;

    for _, v in p103._runIfConditions do
        for _, v2 in v do
            conditions.cleanupCondition(v2);
        end;
    end;
end;

function u2.new(...) -- Line: 876
    -- upvalues: u2 (copy), hooks (copy)
    local v104 = {
        _hooks = {},
        _vargs = { ... },
        _eventDependencyGraphs = {},
        _connectedEvents = {},
        _phaseToSystems = {},
        _systemInfo = {},
        _runIfConditions = {},
        _plugins = {}
    };
    setmetatable(v104, u2);

    for _, v in hooks.Hooks do
        if not v104._hooks[v] then
            v104._hooks[v] = {};
        end;
    end;

    v104:_addBuiltins();

    return v104;
end;

return u2;