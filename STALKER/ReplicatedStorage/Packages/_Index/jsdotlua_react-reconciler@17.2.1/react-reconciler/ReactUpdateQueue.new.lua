-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local _G___YOLO__ = _G.__YOLO__;
local Object = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Object;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
local NoLane = ReactFiberLane.NoLane;
local NoLanes = ReactFiberLane.NoLanes;
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes;
local mergeLanes = ReactFiberLane.mergeLanes;
local u1 = nil;

local function enterDisallowedContextReadInDEV() -- Line: 113
    -- upvalues: u1 (ref)
    if not u1 then
        u1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"));
    end;

    u1.enterDisallowedContextReadInDEV();
end;

local function exitDisallowedContextReadInDEV() -- Line: 119
    -- upvalues: u1 (ref)
    if not u1 then
        u1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"));
    end;

    u1.exitDisallowedContextReadInDEV();
end;

local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local Callback = ReactFiberFlags.Callback;
local ShouldCapture = ReactFiberFlags.ShouldCapture;
local DidCapture = ReactFiberFlags.DidCapture;
local debugRenderPhaseSideEffectsForStrictMode = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.debugRenderPhaseSideEffectsForStrictMode;
local StrictMode = require(script.Parent:WaitForChild("ReactTypeOfMode")).StrictMode;
local markSkippedUpdateLanes = require(script.Parent:WaitForChild("ReactFiberWorkInProgress")).markSkippedUpdateLanes;
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError;
local ConsolePatchingDev = require(script.Parent.Parent:WaitForChild("shared")).ConsolePatchingDev;
local disableLogs = ConsolePatchingDev.disableLogs;
local reenableLogs = ConsolePatchingDev.reenableLogs;
local v2 = {
    UpdateState = 0,
    ReplaceState = 1,
    ForceUpdate = 2,
    CaptureUpdate = 3
};
local u3 = false;
local u4, u5;

if _G___DEV__ then
    u4 = false;
    u5 = nil;

    function v2.resetCurrentlyProcessingQueue() -- Line: 179
        -- upvalues: u5 (ref)
        u5 = nil;
    end;
else
    u5 = nil;
    u4 = nil;
end;

local table_create_ret = table.create(210);
local u6 = 210;

for i = 1, 210 do
    table_create_ret[i] = {
        eventTime = -1,
        lane = -1,
        tag = -1,
        payload = nil,
        callback = nil,
        next = nil
    };
    local _ = i;
end;

function v2.initializeUpdateQueue(p7) -- Line: 200
    p7.updateQueue = {
        firstBaseUpdate = nil,
        lastBaseUpdate = nil,
        effects = nil,
        baseState = p7.memoizedState,
        shared = {
            pending = nil
        }
    };
end;

function v2.cloneUpdateQueue(p8, p9) -- Line: 214
    local updateQueue = p8.updateQueue;

    if p9.updateQueue == updateQueue then
        p9.updateQueue = table.clone(updateQueue);
    end;
end;

function v2.createUpdate(p10: number, p11: any, p12: any, p13: function?) -- Line: 228
    -- upvalues: u6 (ref), table_create_ret (copy)
    if u6 <= 0 then
        return {
            tag = 0,
            next = nil,
            eventTime = p10,
            lane = p11,
            payload = p12,
            callback = p13
        };
    end;

    local v14 = table_create_ret[u6];
    table_create_ret[u6] = nil;
    u6 = u6 - 1;
    v14.eventTime = p10;
    v14.lane = p11;
    v14.tag = 0;
    v14.payload = p12;
    v14.callback = p13;

    return v14;
end;

function v2.enqueueUpdate(p15, p16) -- Line: 278
    -- upvalues: _G___DEV__ (copy), u5 (ref), u4 (ref), console (copy)
    local updateQueue = p15.updateQueue;

    if updateQueue == nil then
        return;
    end;

    local shared = updateQueue.shared;
    local pending = shared.pending;

    if pending == nil then
        p16.next = p16;
    else
        p16.next = pending.next;
        pending.next = p16;
    end;

    shared.pending = p16;

    if _G___DEV__ and (u5 == shared and not u4) then
        console.error("An update (setState, replaceState, or forceUpdate) was scheduled from inside an update function. Update functions should be pure, with zero side-effects. Consider using componentDidUpdate or a callback.");
        u4 = true;
    end;
end;

function v2.enqueueCapturedUpdate(p17, p18) -- Line: 310
    local updateQueue = p17.updateQueue;
    local alternate = p17.alternate;

    if alternate ~= nil then
        local updateQueue2 = alternate.updateQueue;

        if updateQueue == updateQueue2 then
            local firstBaseUpdate = updateQueue.firstBaseUpdate;
            local v19;

            if firstBaseUpdate == nil then
                v19 = p18;
            else
                local v20 = nil;
                v19 = nil;
                local v21;

                while true do
                    if true then
                        v21 = {
                            next = nil,
                            eventTime = firstBaseUpdate.eventTime,
                            lane = firstBaseUpdate.lane,
                            tag = firstBaseUpdate.tag,
                            payload = firstBaseUpdate.payload,
                            callback = firstBaseUpdate.callback
                        };

                        if v20 == nil then
                            v19 = v21;
                        else
                            v20.next = v21;
                        end;
                    end;

                    firstBaseUpdate = firstBaseUpdate.next;

                    if firstBaseUpdate == nil then
                        break;
                    end;

                    v20 = v21;
                end;

                if v21 == nil then
                    v19 = p18;
                else
                    v21.next = p18;
                end;
            end;

            p17.updateQueue = {
                baseState = updateQueue2.baseState,
                firstBaseUpdate = v19,
                lastBaseUpdate = p18,
                shared = updateQueue2.shared,
                effects = updateQueue2.effects
            };

            return;
        end;
    end;

    local lastBaseUpdate = updateQueue.lastBaseUpdate;

    if lastBaseUpdate == nil then
        updateQueue.firstBaseUpdate = p18;
    else
        lastBaseUpdate.next = p18;
    end;

    updateQueue.lastBaseUpdate = p18;
end;

local function getStateFromUpdate(p22, p23, p24, p25, p26, p27) -- Line: 391
    -- upvalues: _G___DEV__ (copy), u1 (ref), debugRenderPhaseSideEffectsForStrictMode (copy), StrictMode (copy), disableLogs (copy), _G___YOLO__ (copy), describeError (copy), reenableLogs (copy), ShouldCapture (copy), DidCapture (copy), Object (copy), u3 (ref)
    local tag = p24.tag;

    if tag == 1 then
        local payload = p24.payload;

        if type(payload) ~= "function" then
            return payload;
        end;

        if _G___DEV__ then
            if not u1 then
                u1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"));
            end;

            u1.enterDisallowedContextReadInDEV();
        end;

        local v28 = payload(p25, p26);

        if _G___DEV__ then
            if debugRenderPhaseSideEffectsForStrictMode and bit32.band(p22.mode, StrictMode) ~= 0 then
                disableLogs();
                local v29 = nil;
                local v30;

                if _G___YOLO__ then
                    payload(p25, p26);
                    v30 = true;
                else
                    v30, v29 = xpcall(payload, describeError, p25, p26);
                end;

                reenableLogs();

                if not v30 then
                    error(v29);
                end;
            end;

            if not u1 then
                u1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"));
            end;

            u1.exitDisallowedContextReadInDEV();
        end;

        return v28;
    end;

    if tag ~= 3 and tag ~= 0 then
        if tag ~= 2 then
            return p25;
        end;

        u3 = true;

        return p25;
    end;

    if tag == 3 then
        local flags = p22.flags;
        local bit32_bnot_ret = bit32.bnot(ShouldCapture);
        local bit32_band_ret = bit32.band(flags, bit32_bnot_ret);
        p22.flags = bit32.bor(bit32_band_ret, DidCapture);
    end;

    local payload = p24.payload;
    local v31;

    if type(payload) == "function" then
        if _G___DEV__ then
            if not u1 then
                u1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"));
            end;

            u1.enterDisallowedContextReadInDEV();
        end;

        v31 = payload(p25, p26);

        if _G___DEV__ then
            if debugRenderPhaseSideEffectsForStrictMode and bit32.band(p22.mode, StrictMode) ~= 0 then
                disableLogs();
                local v32 = nil;
                local v33;

                if _G___YOLO__ then
                    payload(p25, p26);
                    v33 = true;
                else
                    v33, v32 = xpcall(payload, describeError, p25, p26);
                end;

                reenableLogs();

                if not v33 then
                    error(v32);
                end;
            end;

            if not u1 then
                u1 = require(script.Parent:WaitForChild("ReactFiberNewContext.new"));
            end;

            u1.exitDisallowedContextReadInDEV();
        end;
    else
        v31 = payload;
    end;

    if v31 == nil then
        return p25;
    end;

    return Object.assign({}, p25, v31);
end;

v2.getStateFromUpdate = getStateFromUpdate;

function v2.processUpdateQueue() -- Line: 500
    -- upvalues: u3 (ref), _G___DEV__ (copy), u5 (ref), NoLanes (copy), isSubsetOfLanes (copy), mergeLanes (copy), NoLane (copy), getStateFromUpdate (copy), Callback (copy), markSkippedUpdateLanes (copy)
    -- failed to decompile: called `Option::unwrap()` on a `None` value
end;

local function callCallback(p34, p35) -- Line: 692
    if type(p34) ~= "function" then
        error(string.format("Invalid argument passed as callback. Expected a function. Instead received: %s", (tostring(p34))));
    end;

    p34(p35);
end;

function v2.resetHasForceUpdateBeforeProcessing() -- Line: 707
    -- upvalues: u3 (ref)
    u3 = false;
end;

function v2.checkHasForceUpdateAfterProcessing() -- Line: 711
    -- upvalues: u3 (ref)
    return u3;
end;

function v2.commitUpdateQueue(p36, p37, p38) -- Line: 715
    -- upvalues: table_create_ret (copy), u6 (ref)
    local effects = p37.effects;
    p37.effects = nil;

    if effects ~= nil then
        for _, v in effects do
            local callback = v.callback;

            if callback ~= nil then
                if type(callback) ~= "function" then
                    error(string.format("Invalid argument passed as callback. Expected a function. Instead received: %s", (tostring(callback))));
                end;

                callback(p38);
            end;

            table.clear(v);
            table.insert(table_create_ret, v);
            u6 = u6 + 1;
        end;
    end;
end;

return v2;