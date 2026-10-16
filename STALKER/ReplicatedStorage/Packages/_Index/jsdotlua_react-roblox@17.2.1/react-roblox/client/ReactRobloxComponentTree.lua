-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("ReactRobloxHostTypes.roblox"));
require(script.Parent.Parent.Parent:WaitForChild("react-reconciler"));
local shared = require(script.Parent.Parent.Parent:WaitForChild("shared"));
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local invariant = shared.invariant;
local v7 = {};
local u8 = {};
local u9 = {};
local u10 = {};
local v11 = tostring(math.random());
local string_sub_ret = string.sub(v11, 3);
local u12 = "__reactFiber$" .. string_sub_ret;
local u13 = "__reactContainer$" .. string_sub_ret;

function v7.precacheFiberNode(p14, p15) -- Line: 65
    -- upvalues: u9 (copy)
    u9[p15] = p14;
end;

function v7.uncacheFiberNode(p16) -- Line: 70
    -- upvalues: u9 (copy), u10 (copy)
    u9[p16] = nil;
    u10[p16] = nil;
end;

function v7.markContainerAsRoot(p17, p18) -- Line: 75
    -- upvalues: u8 (copy)
    u8[p18] = p17;
end;

function v7.unmarkContainerAsRoot(p19) -- Line: 81
    -- upvalues: u8 (copy)
    u8[p19] = nil;
end;

function v7.isContainerMarkedAsRoot(p20) -- Line: 87
    -- upvalues: u8 (copy)
    return u8[p20] and true or false;
end;

function v7.getClosestInstanceFromNode(p21: userdata) -- Line: 101
    -- upvalues: u9 (copy), u6 (ref)
    local v22 = u9[p21];

    if v22 then
        return v22;
    end;

    local Parent = p21.Parent;

    while Parent do
        local v23 = u9[Parent];

        if v23 then
            local alternate = v23.alternate;

            if v23.child ~= nil or alternate ~= nil and alternate.child ~= nil then
                if u6 == nil then
                    u6 = require(script.Parent.ReactRobloxHostConfig).getParentSuspenseInstance;
                end;

                local v24 = u6(p21);

                while v24 ~= nil do
                    local v25 = u9[v24];

                    if v25 then
                        return v25;
                    end;

                    v24 = u6(v24);
                end;
            end;

            return v23;
        end;

        p21 = Parent;
        Parent = Parent.Parent;
    end;

    return nil;
end;

function v7.getInstanceFromNode(p26) -- Line: 185
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u12 (copy), u13 (copy)
    if u1 == nil then
        u1 = require(script.Parent.Parent:WaitForChild("ReactReconciler.roblox")).ReactWorkTags;
        u2 = u1.HostComponent;
        u3 = u1.HostComponent;
        u4 = u1.HostComponent;
        u5 = u1.HostComponent;
    end;

    local v27 = p26[u12] or p26[u13];

    if not v27 then
        return nil;
    end;

    if v27.tag == u2 or (v27.tag == u3 or (v27.tag == u5 or v27.tag == u4)) then
        return v27;
    end;

    return nil;
end;

function v7.getNodeFromInstance(p28) -- Line: 218
    -- upvalues: u2 (ref), u3 (ref), invariant (copy)
    if p28.tag == u2 or p28.tag == u3 then
        return p28.stateNode;
    end;

    invariant(false, "getNodeFromInstance: Invalid argument.");
    error("getNodeFromInstance: Invalid argument.");
end;

function v7.getFiberCurrentPropsFromNode(p29) -- Line: 233
    -- upvalues: u10 (copy)
    return u10[p29];
end;

function v7.updateFiberProps(p30, p31) -- Line: 237
    -- upvalues: u10 (copy)
    u10[p30] = p31;
end;

return v7;