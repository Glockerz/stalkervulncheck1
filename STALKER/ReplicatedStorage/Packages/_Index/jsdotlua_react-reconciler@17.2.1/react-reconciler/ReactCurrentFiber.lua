-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals;
local getStackByFiberInDevAndProd = require(script.Parent:WaitForChild("ReactFiberComponentStack")).getStackByFiberInDevAndProd;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame;
local u1 = {
    current = nil,
    isRendering = false
};

function u1.getCurrentFiberOwnerNameInDevOrNull() -- Line: 36
    -- upvalues: _G___DEV__ (copy), u1 (copy), getComponentName (copy)
    if _G___DEV__ then
        if u1.current == nil then
            return nil;
        end;

        local _debugOwner = u1.current._debugOwner;

        if _debugOwner then
            return getComponentName(_debugOwner.type);
        end;
    end;

    return nil;
end;

local function getCurrentFiberStackInDev() -- Line: 50
    -- upvalues: _G___DEV__ (copy), u1 (copy), getStackByFiberInDevAndProd (copy)
    return not _G___DEV__ and "" or (u1.current == nil and "" or getStackByFiberInDevAndProd(u1.current));
end;

function u1.resetCurrentFiber() -- Line: 63
    -- upvalues: _G___DEV__ (copy), ReactDebugCurrentFrame (copy), u1 (copy)
    if _G___DEV__ then
        ReactDebugCurrentFrame.getCurrentStack = nil;
        u1.current = nil;
        u1.isRendering = false;
    end;
end;

function u1.setCurrentFiber(p2) -- Line: 72
    -- upvalues: _G___DEV__ (copy), ReactDebugCurrentFrame (copy), getCurrentFiberStackInDev (copy), u1 (copy)
    if _G___DEV__ then
        ReactDebugCurrentFrame.getCurrentStack = getCurrentFiberStackInDev;
        u1.current = p2;
        u1.isRendering = false;
    end;
end;

function u1.setIsRendering(p3: boolean) -- Line: 81
    -- upvalues: _G___DEV__ (copy), u1 (copy)
    if _G___DEV__ then
        u1.isRendering = p3;
    end;
end;

function u1.getIsRendering() -- Line: 87
    -- upvalues: _G___DEV__ (copy), u1 (copy)
    if _G___DEV__ then
        return u1.isRendering;
    end;

    return false;
end;

return u1;