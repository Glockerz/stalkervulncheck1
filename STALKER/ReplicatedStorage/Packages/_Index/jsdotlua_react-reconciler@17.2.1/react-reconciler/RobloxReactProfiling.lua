-- Decompiled with Potassium's decompiler.

local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local v1 = _G.__REACT_MICROPROFILER_LEVEL or 0;
local u2 = false;
local u3 = nil;

function startTimerSampling(p4: function)
    -- upvalues: u2 (ref), u3 (ref)
    if u2 then
        warn("RobloxReactProfiling Timer Sampling already running.");
    end;

    u2 = true;
    u3 = p4;
end;

function endTimerSampling()
    -- upvalues: u2 (ref), u3 (ref)
    u2 = false;
    u3 = nil;
end;

function getFirstStringKey(p5: table)
    for i, _ in p5 do
        if type(i) == "string" then
            return i;
        end;
    end;

    return nil;
end;

function startTimer(p6: table)
    -- upvalues: u2 (ref)
    if u2 then
        p6.startTime = os.clock();
    end;
end;

function endTimer(p7: table)
    -- upvalues: u2 (ref), u3 (ref)
    if u2 then
        p7.endTime = os.clock();

        if u3 then
            u3(p7);
        end;
    end;
end;

function profileRootBeforeUnitOfWork(p8)
    local current = p8.current;
    local v9 = nil;

    if current then
        if current.memoizedProps then
            v9 = getFirstStringKey(current.memoizedProps);
        end;

        if v9 == nil and (current.stateNode and current.stateNode.containerInfo) then
            v9 = current.stateNode.containerInfo.Name;
        end;
    end;

    local v10;

    if v9 == "Folder" and current.child then
        local child = current.child;

        if child.memoizedProps then
            v10 = getFirstStringKey(child.memoizedProps);
        else
            v10 = nil;
        end;

        if v10 == nil and (child.stateNode and child.stateNode.containerInfo) then
            v10 = child.stateNode.containerInfo.Name;
        end;

        if v10 == nil then
            v10 = v9;
        end;
    else
        v10 = v9;
    end;

    if v10 == nil then
        return nil;
    end;

    local v11 = {
        startTime = 0,
        endTime = 0,
        id = v10
    };
    startTimer(v11);
    debug.profilebegin(v10);

    return v11;
end;

function profileRootAfterYielding(p12: table?)
    if p12 then
        endTimer(p12);
        debug.profileend();
    end;
end;

function profileUnitOfWorkBefore(p13)
    -- upvalues: getComponentName (copy), ReactWorkTags (copy)
    local v14 = getComponentName(p13.type);

    if p13.key then
        v14 = tostring(p13.key) .. "=" .. (v14 or "?");
    end;

    local v15 = nil;

    if p13.stateNode and (p13.tag == ReactWorkTags.HostComponent or p13.tag == ReactWorkTags.HostText) then
        local v16 = p13.stateNode:FindFirstAncestorWhichIsA("LayerCollector");

        if v16 then
            v15 = "[" .. v16:GetFullName() .. "] ";
        end;
    end;

    if v15 then
        v14 = v15 .. " : " .. (v14 or "?");
    end;

    if v14 == nil then
        return false;
    end;

    debug.profilebegin(v14);

    return true;
end;

function profileUnitOfWorkAfter(p17: boolean)
    if p17 then
        debug.profileend();
    end;
end;

function profileCommitBefore()
    debug.profilebegin("Commit");
end;

function profileCommitAfter()
    debug.profileend();
end;

function noop(...)
end;

local v18 = {
    startTimerSampling = startTimerSampling,
    endTimerSampling = endTimerSampling
};
local v19;

if v1 >= 1 then
    v19 = profileRootBeforeUnitOfWork;
else
    v19 = noop;
end;

v18.profileRootBeforeUnitOfWork = v19;
local v20;

if v1 >= 1 then
    v20 = profileRootAfterYielding;
else
    v20 = noop;
end;

v18.profileRootAfterYielding = v20;
local v21;

if v1 >= 10 then
    v21 = profileUnitOfWorkBefore;
else
    v21 = noop;
end;

v18.profileUnitOfWorkBefore = v21;
local v22;

if v1 >= 10 then
    v22 = profileUnitOfWorkAfter;
else
    v22 = noop;
end;

v18.profileUnitOfWorkAfter = v22;
local v23;

if v1 >= 1 then
    v23 = profileCommitBefore;
else
    v23 = noop;
end;

v18.profileCommitBefore = v23;
local v24;

if v1 >= 1 then
    v24 = profileCommitAfter;
else
    v24 = noop;
end;

v18.profileCommitAfter = v24;

return v18;