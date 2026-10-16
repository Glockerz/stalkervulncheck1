-- Decompiled with Potassium's decompiler.

local u1 = {
    __mode = "k"
};

local function isCallable(p2) -- Line: 10
    if type(p2) == "function" then
        return true;
    end;

    local v3 = type(p2) == "table" and getmetatable(p2);

    if v3 then
        local v4 = rawget(v3, "__call");

        if type(v4) == "function" then
            return true;
        end;
    end;

    return false;
end;

local function makeEnum(u5, p6) -- Line: 28
    local v7 = {};

    for _, v in ipairs(p6) do
        v7[v] = v;
    end;

    return setmetatable(v7, {
        __index = function(p8, p9) -- Line: 36, Name: __index
            -- upvalues: u5 (copy)
            error(string.format("%s is not in %s!", p9, u5), 2);
        end,

        __newindex = function() -- Line: 39, Name: __newindex
            -- upvalues: u5 (copy)
            error(string.format("Creating new members in %s is not allowed!", u5), 2);
        end
    });
end;

local u10 = {
    Kind = makeEnum("Promise.Error.Kind", { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" })
};
u10.__index = u10;

function u10.new(p11, p12) -- Line: 64
    -- upvalues: u10 (ref)
    local v13 = p11 or {};
    local v14 = {
        error = tostring(v13.error) or "[This error has no error text.]",
        trace = v13.trace,
        context = v13.context,
        kind = v13.kind,
        parent = p12,
        createdTick = os.clock(),
        createdTrace = debug.traceback()
    };

    return setmetatable(v14, u10);
end;

function u10.is(p15) -- Line: 77
    if type(p15) == "table" then
        local v16 = getmetatable(p15);

        if type(v16) == "table" then
            local v17;

            if rawget(p15, "error") == nil then
                v17 = false;
            else
                local v18 = rawget(v16, "extend");
                v17 = type(v18) == "function";
            end;

            return v17;
        end;
    end;

    return false;
end;

function u10.isKind(p19, p20) -- Line: 89
    -- upvalues: u10 (ref)
    assert(p20 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil");
    local v21 = u10.is(p19) and p19.kind == p20;

    return v21;
end;

function u10.extend(p22, p23) -- Line: 95
    -- upvalues: u10 (ref)
    local v24 = p23 or {};
    v24.kind = v24.kind or p22.kind;

    return u10.new(v24, p22);
end;

function u10.getErrorChain(p25) -- Line: 103
    local v26 = { p25 };

    while v26[#v26].parent do
        table.insert(v26, v26[#v26].parent);
    end;

    return v26;
end;

function u10.__tostring(p27) -- Line: 113
    local v28 = { string.format("-- Promise.Error(%s) --", p27.kind or "?") };

    for _, v in ipairs(p27:getErrorChain()) do
        table.insert(v28, table.concat({ v.trace or v.error, v.context }, "\n"));
    end;

    return table.concat(v28, "\n");
end;

local function pack(...) -- Line: 137
    return select("#", ...), { ... };
end;

local function packResult(p29, ...) -- Line: 144
    return p29, select("#", ...), { ... };
end;

local function makeErrorHandler(u30) -- Line: 148
    -- upvalues: u10 (ref)
    assert(u30 ~= nil, "traceback is nil");

    return function(p31) -- Line: 151
        -- upvalues: u10 (ref), u30 (copy)
        if type(p31) == "table" then
            return p31;
        end;

        return u10.new({
            error = p31,
            kind = u10.Kind.ExecutionError,
            trace = debug.traceback(tostring(p31), 2),
            context = "Promise created at:\n\n" .. u30
        });
    end;
end;

local function runExecutor(u32, p33, ...) -- Line: 171
    -- upvalues: packResult (copy), u10 (ref)
    local v34 = xpcall;
    assert(u32 ~= nil, "traceback is nil");

    return packResult(v34(p33, function(p35) -- Line: 151
        -- upvalues: u10 (ref), u32 (copy)
        if type(p35) == "table" then
            return p35;
        end;

        return u10.new({
            error = p35,
            kind = u10.Kind.ExecutionError,
            trace = debug.traceback(tostring(p35), 2),
            context = "Promise created at:\n\n" .. u32
        });
    end, ...));
end;

local function createAdvancer(u36, u37, u38, u39) -- Line: 179
    -- upvalues: runExecutor (copy)
    return function(...) -- Line: 180
        -- upvalues: runExecutor (ref), u36 (copy), u37 (copy), u38 (copy), u39 (copy)
        local v40, v41, v42 = runExecutor(u36, u37, ...);

        if v40 then
            u38(unpack(v42, 1, v41));

            return;
        end;

        u39(v42[1]);
    end;
end;

local function isEmpty(p43) -- Line: 191
    return next(p43) == nil;
end;

local u44 = {
    Error = u10,
    Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
    _getTime = os.clock,
    _timeEvent = game:GetService("RunService").Heartbeat,
    _unhandledRejectionCallbacks = {},
    prototype = {}
};
u44.__index = u44.prototype;

function u44._new(p45, u46, p47) -- Line: 230
    -- upvalues: u44 (copy), u1 (copy), runExecutor (copy)
    if p47 ~= nil and not u44.is(p47) then
        error("Argument #2 to Promise.new must be a promise or nil", 2);
    end;

    local u48 = {
        _thread = nil,
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = true,
        _cancellationHook = nil,
        _source = p45,
        _status = u44.Status.Started,
        _queuedResolve = {},
        _queuedReject = {},
        _queuedFinally = {},
        _parent = p47,
        _consumers = setmetatable({}, u1)
    };

    if p47 and p47._status == u44.Status.Started then
        p47._consumers[u48] = true;
    end;

    setmetatable(u48, u44);

    local function resolve(...) -- Line: 278
        -- upvalues: u48 (copy)
        u48:_resolve(...);
    end;

    local function reject(...) -- Line: 282
        -- upvalues: u48 (copy)
        u48:_reject(...);
    end;

    local function onCancel(p49) -- Line: 286
        -- upvalues: u48 (copy), u44 (ref)
        if p49 then
            if u48._status == u44.Status.Cancelled then
                p49();
            else
                u48._cancellationHook = p49;
            end;
        end;

        return u48._status == u44.Status.Cancelled;
    end;

    u48._thread = coroutine.create(function() -- Line: 298
        -- upvalues: runExecutor (ref), u48 (copy), u46 (copy), resolve (copy), reject (copy), onCancel (copy)
        local v50, _, v51 = runExecutor(u48._source, u46, resolve, reject, onCancel);

        if not v50 then
            reject(v51[1]);
        end;
    end);
    task.spawn(u48._thread);

    return u48;
end;

function u44.new(p52) -- Line: 349
    -- upvalues: u44 (copy)
    return u44._new(debug.traceback(nil, 2), p52);
end;

function u44.__tostring(p53) -- Line: 353
    return string.format("Promise(%s)", p53._status);
end;

function u44.defer(u54) -- Line: 375
    -- upvalues: u44 (copy), runExecutor (copy)
    local debug_traceback_ret = debug.traceback(nil, 2);

    return u44._new(debug_traceback_ret, function(u55, u56, u57) -- Line: 378
        -- upvalues: u44 (ref), runExecutor (ref), debug_traceback_ret (copy), u54 (copy)
        local u58 = nil;
        u58 = u44._timeEvent:Connect(function() -- Line: 380
            -- upvalues: u58 (ref), runExecutor (ref), debug_traceback_ret (ref), u54 (ref), u55 (copy), u56 (copy), u57 (copy)
            u58:Disconnect();
            local v59, _, v60 = runExecutor(debug_traceback_ret, u54, u55, u56, u57);

            if not v59 then
                u56(v60[1]);
            end;
        end);
    end);
end;

u44.async = u44.defer;

function u44.resolve(...) -- Line: 418
    -- upvalues: pack (copy), u44 (copy)
    local u61, u62 = pack(...);

    return u44._new(debug.traceback(nil, 2), function(p63) -- Line: 420
        -- upvalues: u62 (copy), u61 (copy)
        p63(unpack(u62, 1, u61));
    end);
end;

function u44.reject(...) -- Line: 435
    -- upvalues: pack (copy), u44 (copy)
    local u64, u65 = pack(...);

    return u44._new(debug.traceback(nil, 2), function(p66, p67) -- Line: 437
        -- upvalues: u65 (copy), u64 (copy)
        p67(unpack(u65, 1, u64));
    end);
end;

function u44._try(p68, u69, ...) -- Line: 446
    -- upvalues: pack (copy), u44 (copy)
    local u70, u71 = pack(...);

    return u44._new(p68, function(p72) -- Line: 449
        -- upvalues: u69 (copy), u71 (copy), u70 (copy)
        p72(u69(unpack(u71, 1, u70)));
    end);
end;

function u44.try(p73, ...) -- Line: 477
    -- upvalues: u44 (copy)
    return u44._try(debug.traceback(nil, 2), p73, ...);
end;

function u44._all(p74, u75, u76) -- Line: 486
    -- upvalues: u44 (copy)
    if type(u75) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3);
    end;

    for i, v in pairs(u75) do
        if not u44.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(i))), 3);
        end;
    end;

    if #u75 == 0 or u76 == 0 then
        return u44.resolve({});
    end;

    return u44._new(p74, function(u77, u78, p79) -- Line: 504
        -- upvalues: u76 (copy), u75 (copy)
        local u80 = {};
        local u81 = {};
        local u82 = 0;
        local u83 = 0;
        local u84 = false;

        local function resolveOne(p85, ...) -- Line: 522
            -- upvalues: u84 (ref), u82 (ref), u76 (ref), u80 (copy), u75 (ref), u77 (copy), u81 (copy)
            if u84 then
                return;
            end;

            u82 = u82 + 1;

            if u76 == nil then
                u80[p85] = ...;
            else
                u80[u82] = ...;
            end;

            if u82 >= (u76 or #u75) then
                u84 = true;
                u77(u80);

                for _, v in ipairs(u81) do
                    v:cancel();
                end;
            end;
        end;

        p79(function() -- Line: 515, Name: cancel
            -- upvalues: u81 (copy)
            for _, v in ipairs(u81) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u75) do
            u81[i] = v:andThen(function(...) -- Line: 547
                -- upvalues: resolveOne (copy), i (copy)
                resolveOne(i, ...);
            end, function(...) -- Line: 549
                -- upvalues: u83 (ref), u76 (ref), u75 (ref), u81 (copy), u84 (ref), u78 (copy)
                u83 = u83 + 1;

                if u76 == nil or #u75 - u83 < u76 then
                    for _, v2 in ipairs(u81) do
                        v2:cancel();
                    end;

                    u84 = true;
                    u78(...);
                end;
            end);
        end;

        if u84 then
            for _, v in ipairs(u81) do
                v:cancel();
            end;
        end;
    end);
end;

function u44.all(...) -- Line: 591
    -- upvalues: u44 (copy)
    local v86 = { ... };

    if type(v86[1]) == "table" and not u44.is(v86[1]) then
        v86 = v86[1];
    end;

    return u44._all(debug.traceback(nil, 2), v86);
end;

function u44.fold(p87, u88, p89) -- Line: 628
    -- upvalues: u44 (copy)
    local v90 = type(p87) == "table";
    assert(v90, "Bad argument #1 to Promise.fold: must be a table");
    local v91;

    if type(u88) == "function" then
        v91 = true;
    elseif type(u88) == "table" then
        local v92 = getmetatable(u88);

        if v92 then
            local v93 = rawget(v92, "__call");
            v91 = type(v93) == "function";
        else
            v91 = false;
        end;
    else
        v91 = false;
    end;

    assert(v91, "Bad argument #2 to Promise.fold: must be a function");
    local u94 = u44.resolve(p89);

    return u44.each(p87, function(u95, u96) -- Line: 633
        -- upvalues: u94 (ref), u88 (copy)
        u94 = u94:andThen(function(p97) -- Line: 634
            -- upvalues: u88 (ref), u95 (copy), u96 (copy)
            return u88(p97, u95, u96);
        end);
    end):andThen(function() -- Line: 637
        -- upvalues: u94 (ref)
        return u94;
    end);
end;

function u44.some(p98, p99) -- Line: 661
    -- upvalues: u44 (copy)
    local v100 = type(p99) == "number";
    assert(v100, "Bad argument #2 to Promise.some: must be a number");

    return u44._all(debug.traceback(nil, 2), p98, p99);
end;

function u44.any(p101) -- Line: 685
    -- upvalues: u44 (copy)
    return u44._all(debug.traceback(nil, 2), p101, 1):andThen(function(p102) -- Line: 686
        return p102[1];
    end);
end;

function u44.allSettled(u103) -- Line: 707
    -- upvalues: u44 (copy)
    if type(u103) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2);
    end;

    for i, v in pairs(u103) do
        if not u44.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(i))), 2);
        end;
    end;

    if #u103 == 0 then
        return u44.resolve({});
    end;

    return u44._new(debug.traceback(nil, 2), function(u104, p105, p106) -- Line: 725
        -- upvalues: u103 (copy)
        local u107 = {};
        local u108 = {};
        local u109 = 0;

        local function u111(p110, ...) -- Line: 735
            -- upvalues: u109 (ref), u107 (copy), u103 (ref), u104 (copy)
            u109 = u109 + 1;
            u107[p110] = ...;

            if u109 >= #u103 then
                u104(u107);
            end;
        end;

        p106(function() -- Line: 745
            -- upvalues: u108 (copy)
            for _, v in ipairs(u108) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u103) do
            u108[i] = v:finally(function(...) -- Line: 754
                -- upvalues: u111 (copy), i (copy)
                u111(i, ...);
            end);
        end;
    end);
end;

function u44.race(u112) -- Line: 785
    -- upvalues: u44 (copy)
    local v113 = type(u112) == "table";
    assert(v113, string.format("Please pass a list of promises to %s", "Promise.race"));

    for i, v in pairs(u112) do
        local v114 = u44.is(v);
        local string_format = string.format;
        local v115 = tostring(i);
        assert(v114, string_format("Non-promise value passed into %s at index %s", "Promise.race", v115));
    end;

    return u44._new(debug.traceback(nil, 2), function(u116, u117, p118) -- Line: 792
        -- upvalues: u112 (copy)
        local u119 = {};
        local u120 = false;

        local function cancel() -- Line: 796
            -- upvalues: u119 (copy)
            for _, v in ipairs(u119) do
                v:cancel();
            end;
        end;

        local function finalize(u121) -- Line: 802
            -- upvalues: u119 (copy), u120 (ref)
            return function(...) -- Line: 803
                -- upvalues: u119 (ref), u120 (ref), u121 (copy)
                for _, v in ipairs(u119) do
                    v:cancel();
                end;

                u120 = true;

                return u121(...);
            end;
        end;

        if p118(function(...) -- Line: 803
            -- upvalues: u119 (copy), u120 (ref), u117 (copy)
            for _, v in ipairs(u119) do
                v:cancel();
            end;

            u120 = true;

            return u117(...);
        end) then
            return;
        end;

        for i, v in ipairs(u112) do
            u119[i] = v:andThen(function(...) -- Line: 803
                -- upvalues: u119 (copy), u120 (ref), u116 (copy)
                for _, v2 in ipairs(u119) do
                    v2:cancel();
                end;

                u120 = true;

                return u116(...);
            end, function(...) -- Line: 803
                -- upvalues: u119 (copy), u120 (ref), u117 (copy)
                for _, v2 in ipairs(u119) do
                    v2:cancel();
                end;

                u120 = true;

                return u117(...);
            end);
        end;

        if u120 then
            for _, v in ipairs(u119) do
                v:cancel();
            end;
        end;
    end);
end;

function u44.each(u122, u123) -- Line: 880
    -- upvalues: u44 (copy), u10 (ref)
    local v124 = type(u122) == "table";
    assert(v124, string.format("Please pass a list of promises to %s", "Promise.each"));
    local v125;

    if type(u123) == "function" then
        v125 = true;
    elseif type(u123) == "table" then
        local v126 = getmetatable(u123);

        if v126 then
            local v127 = rawget(v126, "__call");
            v125 = type(v127) == "function";
        else
            v125 = false;
        end;
    else
        v125 = false;
    end;

    assert(v125, string.format("Please pass a handler function to %s!", "Promise.each"));

    return u44._new(debug.traceback(nil, 2), function(p128, p129, p130) -- Line: 884
        -- upvalues: u122 (copy), u44 (ref), u10 (ref), u123 (copy)
        local v131 = {};
        local u132 = {};
        local u133 = false;

        local function _() -- Line: 890
            -- upvalues: u132 (copy)
            for _, v in ipairs(u132) do
                v:cancel();
            end;
        end;

        p130(function() -- Line: 896
            -- upvalues: u133 (ref), u132 (copy)
            u133 = true;

            for _, v in ipairs(u132) do
                v:cancel();
            end;
        end);
        local v134 = {};

        for i, v in ipairs(u122) do
            if u44.is(v) then
                if v:getStatus() == u44.Status.Cancelled then
                    for _, v2 in ipairs(u132) do
                        v2:cancel();
                    end;

                    return p129(u10.new({
                        error = "Promise is cancelled",
                        kind = u10.Kind.AlreadyCancelled,
                        context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", i, v._source)
                    }));
                end;

                if v:getStatus() == u44.Status.Rejected then
                    for _, v2 in ipairs(u132) do
                        v2:cancel();
                    end;

                    return p129(select(2, v:await()));
                end;

                local v135 = v:andThen(function(...) -- Line: 929
                    return ...;
                end);
                table.insert(u132, v135);
                v134[i] = v135;
            else
                v134[i] = v;
            end;
        end;

        for i, v in ipairs(v134) do
            local v136;

            if u44.is(v) then
                local v137;
                v137, v136 = v:await();

                if not v137 then
                    for _, v2 in ipairs(u132) do
                        v2:cancel();
                    end;

                    return p129(v136);
                end;
            else
                v136 = v;
            end;

            if u133 then
                return;
            end;

            local v138 = u44.resolve(u123(v136, i));
            table.insert(u132, v138);
            local v139, v140 = v138:await();

            if not v139 then
                for _, v2 in ipairs(u132) do
                    v2:cancel();
                end;

                return p129(v140);
            end;

            v131[i] = v140;
        end;

        p128(v131);
    end);
end;

function u44.is(p141) -- Line: 979
    -- upvalues: u44 (copy)
    if type(p141) ~= "table" then
        return false;
    end;

    local v142 = getmetatable(p141);

    if v142 == u44 then
        return true;
    end;

    if v142 ~= nil then
        if type(v142) == "table" then
            local v143 = rawget(v142, "__index");

            if type(v143) == "table" then
                local v144 = rawget(v142, "__index");
                local v145 = rawget(v144, "andThen");
                local v146;

                if type(v145) == "function" then
                    v146 = true;
                else
                    local v147 = type(v145) == "table" and getmetatable(v145);

                    if v147 then
                        local v148 = rawget(v147, "__call");
                        v146 = type(v148) == "function";
                    else
                        v146 = false;
                    end;
                end;

                if v146 then
                    return true;
                end;
            end;
        end;

        return false;
    end;

    local andThen = p141.andThen;

    if type(andThen) == "function" then
        return true;
    end;

    local v149 = type(andThen) == "table" and getmetatable(andThen);

    if v149 then
        local v150 = rawget(v149, "__call");

        if type(v150) == "function" then
            return true;
        end;
    end;

    return false;
end;

function u44.promisify(u151) -- Line: 1028
    -- upvalues: u44 (copy)
    return function(...) -- Line: 1029
        -- upvalues: u44 (ref), u151 (copy)
        return u44._try(debug.traceback(nil, 2), u151, ...);
    end;
end;

local u152 = nil;
local u153 = nil;

function u44.delay(p154) -- Line: 1059
    -- upvalues: u44 (copy), u153 (ref), u152 (ref)
    local v155 = type(p154) == "number";
    assert(v155, "Bad argument #1 to Promise.delay, must be a number.");
    local u156 = (p154 < 0.016666666666666666 or p154 == (1 / 0)) and 0.016666666666666666 or p154;

    return u44._new(debug.traceback(nil, 2), function(p157, p158, p159) -- Line: 1067
        -- upvalues: u44 (ref), u156 (ref), u153 (ref), u152 (ref)
        local v160 = u44._getTime();
        local v161 = v160 + u156;
        local u162 = {
            resolve = p157,
            startTime = v160,
            endTime = v161
        };

        if u153 == nil then
            u152 = u162;
            u153 = u44._timeEvent:Connect(function() -- Line: 1079
                -- upvalues: u44 (ref), u152 (ref), u153 (ref)
                local v163 = u44._getTime();

                while u152 ~= nil and u152.endTime < v163 do
                    local v164 = u152;
                    u152 = v164.next;

                    if u152 == nil then
                        u153:Disconnect();
                        u153 = nil;
                    else
                        u152.previous = nil;
                    end;

                    v164.resolve(u44._getTime() - v164.startTime);
                end;
            end);
        elseif u152.endTime < v161 then
            local v165 = u152;
            local next2 = v165.next;

            while next2 ~= nil and next2.endTime < v161 do
                v165 = next2;
                next2 = next2.next;
            end;

            v165.next = u162;
            u162.previous = v165;

            if next2 ~= nil then
                u162.next = next2;
                next2.previous = u162;
            end;
        else
            u162.next = u152;
            u152.previous = u162;
            u152 = u162;
        end;

        p159(function() -- Line: 1124
            -- upvalues: u162 (copy), u152 (ref), u153 (ref)
            local next2 = u162.next;

            if u152 == u162 then
                if next2 == nil then
                    u153:Disconnect();
                    u153 = nil;
                else
                    next2.previous = nil;
                end;

                u152 = next2;

                return;
            end;

            local previous = u162.previous;
            previous.next = next2;

            if next2 ~= nil then
                next2.previous = previous;
            end;
        end);
    end);
end;

function u44.prototype.timeout(p166, u167, u168) -- Line: 1188
    -- upvalues: u44 (copy), u10 (ref)
    local debug_traceback_ret = debug.traceback(nil, 2);

    return u44.race({ u44.delay(u167):andThen(function() -- Line: 1192
            -- upvalues: u44 (ref), u168 (copy), u10 (ref), u167 (copy), debug_traceback_ret (copy)
            return u44.reject(u168 == nil and u10.new({
                error = "Timed out",
                kind = u10.Kind.TimedOut,
                context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", u167, debug_traceback_ret)
            }) or u168);
        end), p166 });
end;

function u44.prototype.getStatus(p169) -- Line: 1212
    return p169._status;
end;

function u44.prototype._andThen(u170, u171, u172, u173) -- Line: 1221
    -- upvalues: u44 (copy), runExecutor (copy), u10 (ref)
    u170._unhandledRejection = false;

    return u44._new(u171, function(u174, u175) -- Line: 1225
        -- upvalues: u172 (copy), u171 (copy), runExecutor (ref), u173 (copy), u170 (copy), u44 (ref), u10 (ref)
        local v176;

        if u172 then
            local u177 = u171;
            local u178 = u172;

            v176 = function(...) -- Line: 180
                -- upvalues: runExecutor (ref), u177 (copy), u178 (copy), u174 (copy), u175 (copy)
                local v179, v180, v181 = runExecutor(u177, u178, ...);

                if v179 then
                    u174(unpack(v181, 1, v180));

                    return;
                end;

                u175(v181[1]);
            end;
        else
            v176 = u174;
        end;

        local v182;

        if u173 then
            local u183 = u171;
            local u184 = u173;

            v182 = function(...) -- Line: 180
                -- upvalues: runExecutor (ref), u183 (copy), u184 (copy), u174 (copy), u175 (copy)
                local v185, v186, v187 = runExecutor(u183, u184, ...);

                if v185 then
                    u174(unpack(v187, 1, v186));

                    return;
                end;

                u175(v187[1]);
            end;
        else
            v182 = u175;
        end;

        if u170._status == u44.Status.Started then
            table.insert(u170._queuedResolve, v176);
            table.insert(u170._queuedReject, v182);

            return;
        end;

        if u170._status == u44.Status.Resolved then
            v176(unpack(u170._values, 1, u170._valuesLength));

            return;
        end;

        if u170._status == u44.Status.Rejected then
            v182(unpack(u170._values, 1, u170._valuesLength));

            return;
        end;

        if u170._status == u44.Status.Cancelled then
            u175(u10.new({
                error = "Promise is cancelled",
                kind = u10.Kind.AlreadyCancelled,
                context = "Promise created at\n\n" .. u171
            }));
        end;
    end, u170);
end;

function u44.prototype.andThen(p188, p189, p190) -- Line: 1282
    local v191;

    if p189 == nil or type(p189) == "function" then
        v191 = true;
    elseif type(p189) == "table" then
        local v192 = getmetatable(p189);

        if v192 then
            local v193 = rawget(v192, "__call");
            v191 = type(v193) == "function";
        else
            v191 = false;
        end;
    else
        v191 = false;
    end;

    assert(v191, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    local v194;

    if p190 == nil or type(p190) == "function" then
        v194 = true;
    elseif type(p190) == "table" then
        local v195 = getmetatable(p190);

        if v195 then
            local v196 = rawget(v195, "__call");
            v194 = type(v196) == "function";
        else
            v194 = false;
        end;
    else
        v194 = false;
    end;

    assert(v194, string.format("Please pass a handler function to %s!", "Promise:andThen"));

    return p188:_andThen(debug.traceback(nil, 2), p189, p190);
end;

function u44.prototype.andThenAsync(p197, p198, p199) -- Line: 1310
    -- upvalues: pack (copy), u44 (copy)
    local v200;

    if p198 == nil or type(p198) == "function" then
        v200 = true;
    elseif type(p198) == "table" then
        local v201 = getmetatable(p198);

        if v201 then
            local v202 = rawget(v201, "__call");
            v200 = type(v202) == "function";
        else
            v200 = false;
        end;
    else
        v200 = false;
    end;

    assert(v200, string.format("Please pass a handler function to %s!", "Promise:andThenAsync"));
    local v203;

    if p199 == nil or type(p199) == "function" then
        v203 = true;
    elseif type(p199) == "table" then
        local v204 = getmetatable(p199);

        if v204 then
            local v205 = rawget(v204, "__call");
            v203 = type(v205) == "function";
        else
            v203 = false;
        end;
    else
        v203 = false;
    end;

    assert(v203, string.format("Please pass a handler function to %s!", "Promise:andThenAsync"));

    return p197:_andThen(debug.traceback(nil, 2), function(...) -- Line: 1317
        -- upvalues: pack (ref), u44 (ref)
        local u206, u207 = pack(...);

        return u44.defer(function(p208) -- Line: 1319
            -- upvalues: u207 (copy), u206 (copy)
            p208(unpack(u207, 1, u206));
        end);
    end, function(...) -- Line: 1323
        -- upvalues: pack (ref), u44 (ref)
        local u209, u210 = pack(...);

        return u44.defer(function(p211, p212) -- Line: 1325
            -- upvalues: u210 (copy), u209 (copy)
            p212(unpack(u210, 1, u209));
        end);
    end):andThen(p198, p199);
end;

function u44.prototype.catch(p213, p214) -- Line: 1352
    local v215;

    if p214 == nil or type(p214) == "function" then
        v215 = true;
    elseif type(p214) == "table" then
        local v216 = getmetatable(p214);

        if v216 then
            local v217 = rawget(v216, "__call");
            v215 = type(v217) == "function";
        else
            v215 = false;
        end;
    else
        v215 = false;
    end;

    assert(v215, string.format("Please pass a handler function to %s!", "Promise:catch"));

    return p213:_andThen(debug.traceback(nil, 2), nil, p214);
end;

function u44.prototype.tap(p218, u219) -- Line: 1373
    -- upvalues: u44 (copy), pack (copy)
    local v220;

    if type(u219) == "function" then
        v220 = true;
    elseif type(u219) == "table" then
        local v221 = getmetatable(u219);

        if v221 then
            local v222 = rawget(v221, "__call");
            v220 = type(v222) == "function";
        else
            v220 = false;
        end;
    else
        v220 = false;
    end;

    assert(v220, string.format("Please pass a handler function to %s!", "Promise:tap"));

    return p218:_andThen(debug.traceback(nil, 2), function(...) -- Line: 1375
        -- upvalues: u219 (copy), u44 (ref), pack (ref)
        local v223 = u219(...);

        if not u44.is(v223) then
            return ...;
        end;

        local u224, u225 = pack(...);

        return v223:andThen(function() -- Line: 1380
            -- upvalues: u225 (copy), u224 (copy)
            return unpack(u225, 1, u224);
        end);
    end);
end;

function u44.prototype.andThenCall(p226, u227, ...) -- Line: 1408
    -- upvalues: pack (copy)
    local v228;

    if type(u227) == "function" then
        v228 = true;
    elseif type(u227) == "table" then
        local v229 = getmetatable(u227);

        if v229 then
            local v230 = rawget(v229, "__call");
            v228 = type(v230) == "function";
        else
            v228 = false;
        end;
    else
        v228 = false;
    end;

    assert(v228, string.format("Please pass a handler function to %s!", "Promise:andThenCall"));
    local u231, u232 = pack(...);

    return p226:_andThen(debug.traceback(nil, 2), function() -- Line: 1411
        -- upvalues: u227 (copy), u232 (copy), u231 (copy)
        return u227(unpack(u232, 1, u231));
    end);
end;

function u44.prototype.andThenReturn(p233, ...) -- Line: 1438
    -- upvalues: pack (copy)
    local u234, u235 = pack(...);

    return p233:_andThen(debug.traceback(nil, 2), function() -- Line: 1440
        -- upvalues: u235 (copy), u234 (copy)
        return unpack(u235, 1, u234);
    end);
end;

function u44.prototype.cancel(p236) -- Line: 1456
    -- upvalues: u44 (copy)
    if p236._status ~= u44.Status.Started then
        return;
    end;

    p236._status = u44.Status.Cancelled;

    if p236._cancellationHook then
        p236._cancellationHook();
    end;

    coroutine.close(p236._thread);

    if p236._parent then
        p236._parent:_consumerCancelled(p236);
    end;

    for i in pairs(p236._consumers) do
        i:cancel();
    end;

    p236:_finalize();
end;

function u44.prototype._consumerCancelled(p237, p238) -- Line: 1484
    -- upvalues: u44 (copy)
    if p237._status ~= u44.Status.Started then
        return;
    end;

    p237._consumers[p238] = nil;

    if next(p237._consumers) == nil then
        p237:cancel();
    end;
end;

function u44.prototype._finally(u239, u240, u241, u242) -- Line: 1500
    -- upvalues: u44 (copy), runExecutor (copy)
    if not u242 then
        u239._unhandledRejection = false;
    end;

    return u44._new(u240, function(u243, u244) -- Line: 1506
        -- upvalues: u241 (copy), u240 (copy), runExecutor (ref), u242 (copy), u239 (copy), u44 (ref)
        local u245;

        if u241 then
            local u246 = u240;
            local u247 = u241;

            u245 = function(...) -- Line: 180
                -- upvalues: runExecutor (ref), u246 (copy), u247 (copy), u243 (copy), u244 (copy)
                local v248, v249, v250 = runExecutor(u246, u247, ...);

                if v248 then
                    u243(unpack(v250, 1, v249));

                    return;
                end;

                u244(v250[1]);
            end;
        else
            u245 = u243;
        end;

        local v251 = u242 and function(...) -- Line: 1514
            -- upvalues: u239 (ref), u44 (ref), u243 (copy), u245 (copy)
            if u239._status == u44.Status.Rejected then
                return u243(u239);
            end;

            return u245(...);
        end or u245;

        if u239._status == u44.Status.Started then
            table.insert(u239._queuedFinally, v251);

            return;
        end;

        v251(u239._status);
    end, u239);
end;

function u44.prototype.finally(p252, p253) -- Line: 1582
    local v254;

    if p253 == nil or type(p253) == "function" then
        v254 = true;
    elseif type(p253) == "table" then
        local v255 = getmetatable(p253);

        if v255 then
            local v256 = rawget(v255, "__call");
            v254 = type(v256) == "function";
        else
            v254 = false;
        end;
    else
        v254 = false;
    end;

    assert(v254, string.format("Please pass a handler function to %s!", "Promise:finally"));

    return p252:_finally(debug.traceback(nil, 2), p253);
end;

function u44.prototype.finallyCall(p257, u258, ...) -- Line: 1596
    -- upvalues: pack (copy)
    local v259;

    if type(u258) == "function" then
        v259 = true;
    elseif type(u258) == "table" then
        local v260 = getmetatable(u258);

        if v260 then
            local v261 = rawget(v260, "__call");
            v259 = type(v261) == "function";
        else
            v259 = false;
        end;
    else
        v259 = false;
    end;

    assert(v259, string.format("Please pass a handler function to %s!", "Promise:finallyCall"));
    local u262, u263 = pack(...);

    return p257:_finally(debug.traceback(nil, 2), function() -- Line: 1599
        -- upvalues: u258 (copy), u263 (copy), u262 (copy)
        return u258(unpack(u263, 1, u262));
    end);
end;

function u44.prototype.finallyReturn(p264, ...) -- Line: 1622
    -- upvalues: pack (copy)
    local u265, u266 = pack(...);

    return p264:_finally(debug.traceback(nil, 2), function() -- Line: 1624
        -- upvalues: u266 (copy), u265 (copy)
        return unpack(u266, 1, u265);
    end);
end;

function u44.prototype.done(p267, p268) -- Line: 1632
    local v269;

    if p268 == nil or type(p268) == "function" then
        v269 = true;
    elseif type(p268) == "table" then
        local v270 = getmetatable(p268);

        if v270 then
            local v271 = rawget(v270, "__call");
            v269 = type(v271) == "function";
        else
            v269 = false;
        end;
    else
        v269 = false;
    end;

    assert(v269, string.format("Please pass a handler function to %s!", "Promise:done"));

    return p267:_finally(debug.traceback(nil, 2), p268, true);
end;

function u44.prototype.doneCall(p272, u273, ...) -- Line: 1643
    -- upvalues: pack (copy)
    local v274;

    if type(u273) == "function" then
        v274 = true;
    elseif type(u273) == "table" then
        local v275 = getmetatable(u273);

        if v275 then
            local v276 = rawget(v275, "__call");
            v274 = type(v276) == "function";
        else
            v274 = false;
        end;
    else
        v274 = false;
    end;

    assert(v274, string.format("Please pass a handler function to %s!", "Promise:doneCall"));
    local u277, u278 = pack(...);

    return p272:_finally(debug.traceback(nil, 2), function() -- Line: 1646
        -- upvalues: u273 (copy), u278 (copy), u277 (copy)
        return u273(unpack(u278, 1, u277));
    end, true);
end;

function u44.prototype.doneReturn(p279, ...) -- Line: 1654
    -- upvalues: pack (copy)
    local u280, u281 = pack(...);

    return p279:_finally(debug.traceback(nil, 2), function() -- Line: 1656
        -- upvalues: u281 (copy), u280 (copy)
        return unpack(u281, 1, u280);
    end, true);
end;

function u44.prototype.awaitStatus(p282) -- Line: 1668
    -- upvalues: u44 (copy)
    p282._unhandledRejection = false;

    if p282._status == u44.Status.Started then
        local coroutine_running_ret = coroutine.running();
        p282:finally(function() -- Line: 1674
            -- upvalues: coroutine_running_ret (copy)
            task.spawn(coroutine_running_ret);
        end);
        coroutine.yield();
    end;

    if p282._status == u44.Status.Resolved then
        return p282._status, unpack(p282._values, 1, p282._valuesLength);
    end;

    if p282._status == u44.Status.Rejected then
        return p282._status, unpack(p282._values, 1, p282._valuesLength);
    end;

    return p282._status;
end;

local function awaitHelper(p283, ...) -- Line: 1690
    -- upvalues: u44 (copy)
    return p283 == u44.Status.Resolved, ...;
end;

function u44.prototype.await(p284) -- Line: 1715
    -- upvalues: awaitHelper (copy)
    return awaitHelper(p284:awaitStatus());
end;

local function expectHelper(p285, ...) -- Line: 1719
    -- upvalues: u44 (copy)
    if p285 ~= u44.Status.Resolved then
        error(... == nil and "Expected Promise rejected with no value." or ..., 3);
    end;

    return ...;
end;

function u44.prototype.expect(p286) -- Line: 1752
    -- upvalues: expectHelper (copy)
    return expectHelper(p286:awaitStatus());
end;

u44.prototype.awaitValue = u44.prototype.expect;

function u44.prototype._unwrap(p287) -- Line: 1766
    -- upvalues: u44 (copy)
    if p287._status == u44.Status.Started then
        error("Promise has not resolved or rejected.", 2);
    end;

    return p287._status == u44.Status.Resolved, unpack(p287._values, 1, p287._valuesLength);
end;

function u44.prototype._resolve(u288, ...) -- Line: 1776
    -- upvalues: u44 (copy), u10 (ref), pack (copy)
    if u288._status ~= u44.Status.Started then
        if u44.is((...)) then
            (...):_consumerCancelled(u288);
        end;

        return;
    end;

    if u44.is((...)) then
        if select("#", ...) > 1 then
            local string_format_ret = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", u288._source);
            warn(string_format_ret);
        end;

        local u289 = ...;
        local v291 = u289:andThen(function(...) -- Line: 1797
            -- upvalues: u288 (copy)
            u288:_resolve(...);
        end, function(...) -- Line: 1799
            -- upvalues: u289 (copy), u10 (ref), u288 (copy)
            local v290 = u289._values[1];

            if u289._error then
                v290 = u10.new({
                    context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
                    error = u289._error,
                    kind = u10.Kind.ExecutionError
                });
            end;

            if u10.isKind(v290, u10.Kind.ExecutionError) then
                return u288:_reject(v290:extend({
                    error = "This Promise was chained to a Promise that errored.",
                    trace = "",
                    context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", u288._source)
                }));
            end;

            u288:_reject(...);
        end);

        if v291._status == u44.Status.Cancelled then
            u288:cancel();

            return;
        end;

        if v291._status == u44.Status.Started then
            u288._parent = v291;
            v291._consumers[u288] = true;
        end;

        return;
    end;

    u288._status = u44.Status.Resolved;
    local v292, v293 = pack(...);
    u288._valuesLength = v292;
    u288._values = v293;

    for _, v in ipairs(u288._queuedResolve) do
        coroutine.wrap(v)(...);
    end;

    u288:_finalize();
end;

function u44.prototype._reject(u294, ...) -- Line: 1847
    -- upvalues: u44 (copy), pack (copy)
    if u294._status ~= u44.Status.Started then
        return;
    end;

    u294._status = u44.Status.Rejected;
    local v295, v296 = pack(...);
    u294._valuesLength = v295;
    u294._values = v296;

    if next(u294._queuedReject) == nil then
        local u297 = tostring((...));
        coroutine.wrap(function() -- Line: 1869
            -- upvalues: u44 (ref), u294 (copy), u297 (copy)
            u44._timeEvent:Wait();

            if not u294._unhandledRejection then
                return;
            end;

            local string_format_ret = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", u297, u294._source);

            for _, v in ipairs(u44._unhandledRejectionCallbacks) do
                task.spawn(v, u294, unpack(u294._values, 1, u294._valuesLength));
            end;

            if u44.TEST then
                return;
            end;

            warn(string_format_ret);
        end)();
    else
        for _, v in ipairs(u294._queuedReject) do
            coroutine.wrap(v)(...);
        end;
    end;

    u294:_finalize();
end;

function u44.prototype._finalize(p298) -- Line: 1901
    -- upvalues: u44 (copy)
    for _, v in ipairs(p298._queuedFinally) do
        coroutine.wrap(v)(p298._status);
    end;

    p298._queuedFinally = nil;
    p298._queuedReject = nil;
    p298._queuedResolve = nil;

    if not u44.TEST then
        p298._parent = nil;
        p298._consumers = nil;
    end;

    task.defer(coroutine.close, p298._thread);
end;

function u44.prototype.now(p299, p300) -- Line: 1938
    -- upvalues: u44 (copy), u10 (ref)
    local debug_traceback_ret = debug.traceback(nil, 2);

    if p299._status == u44.Status.Resolved then
        return p299:_andThen(debug_traceback_ret, function(...) -- Line: 1941
            return ...;
        end);
    end;

    local reject = u44.reject;

    if p300 == nil then
        p300 = u10.new({
            error = "This Promise was not resolved in time for :now()",
            kind = u10.Kind.NotResolvedInTime,
            context = ":now() was called at:\n\n" .. debug_traceback_ret
        }) or p300;
    end;

    return reject(p300);
end;

function u44.retry(u301, u302, ...) -- Line: 1983
    -- upvalues: u44 (copy)
    local v303;

    if type(u301) == "function" then
        v303 = true;
    elseif type(u301) == "table" then
        local v304 = getmetatable(u301);

        if v304 then
            local v305 = rawget(v304, "__call");
            v303 = type(v305) == "function";
        else
            v303 = false;
        end;
    else
        v303 = false;
    end;

    assert(v303, "Parameter #1 to Promise.retry must be a function");
    local v306 = type(u302) == "number";
    assert(v306, "Parameter #2 to Promise.retry must be a number");
    local u307 = { ... };
    local u308 = select("#", ...);

    return u44.resolve(u301(...)):catch(function(...) -- Line: 1989
        -- upvalues: u302 (copy), u44 (ref), u301 (copy), u307 (copy), u308 (copy)
        if u302 > 0 then
            return u44.retry(u301, u302 - 1, unpack(u307, 1, u308));
        end;

        return u44.reject(...);
    end);
end;

function u44.retryWithDelay(u309, u310, u311, ...) -- Line: 2011
    -- upvalues: u44 (copy)
    local v312;

    if type(u309) == "function" then
        v312 = true;
    elseif type(u309) == "table" then
        local v313 = getmetatable(u309);

        if v313 then
            local v314 = rawget(v313, "__call");
            v312 = type(v314) == "function";
        else
            v312 = false;
        end;
    else
        v312 = false;
    end;

    assert(v312, "Parameter #1 to Promise.retry must be a function");
    local v315 = type(u310) == "number";
    assert(v315, "Parameter #2 (times) to Promise.retry must be a number");
    local v316 = type(u311) == "number";
    assert(v316, "Parameter #3 (seconds) to Promise.retry must be a number");
    local u317 = { ... };
    local u318 = select("#", ...);

    return u44.resolve(u309(...)):catch(function(...) -- Line: 2018
        -- upvalues: u310 (copy), u44 (ref), u311 (copy), u309 (copy), u317 (copy), u318 (copy)
        if u310 <= 0 then
            return u44.reject(...);
        end;

        u44.delay(u311):await();

        return u44.retryWithDelay(u309, u310 - 1, u311, unpack(u317, 1, u318));
    end);
end;

function u44.fromEvent(u319, p320) -- Line: 2053
    -- upvalues: u44 (copy)
    local u321 = p320 or function() -- Line: 2054
        return true;
    end;

    return u44._new(debug.traceback(nil, 2), function(u322, p323, p324) -- Line: 2058
        -- upvalues: u319 (copy), u321 (ref)
        local u325 = nil;
        local u326 = false;

        local function disconnect() -- Line: 2062
            -- upvalues: u325 (ref)
            u325:Disconnect();
            u325 = nil;
        end;

        u325 = u319:Connect(function(...) -- Line: 2071
            -- upvalues: u321 (ref), u322 (copy), u325 (ref), u326 (ref)
            local v327 = u321(...);

            if v327 ~= true then
                if type(v327) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean");
                end;

                return;
            end;

            u322(...);

            if not u325 then
                u326 = true;

                return;
            end;

            u325:Disconnect();
            u325 = nil;
        end);

        if u326 and u325 then
            return disconnect();
        end;

        p324(disconnect);
    end);
end;

function u44.onUnhandledRejection(u328) -- Line: 2105
    -- upvalues: u44 (copy)
    table.insert(u44._unhandledRejectionCallbacks, u328);

    return function() -- Line: 2108
        -- upvalues: u44 (ref), u328 (copy)
        local table_find_ret = table.find(u44._unhandledRejectionCallbacks, u328);

        if table_find_ret then
            table.remove(u44._unhandledRejectionCallbacks, table_find_ret);
        end;
    end;
end;

return u44;