-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent:WaitForChild("luau-polyfill"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local HostComponent = ReactWorkTags.HostComponent;
local LazyComponent = ReactWorkTags.LazyComponent;
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent;
local FunctionComponent = ReactWorkTags.FunctionComponent;
local IndeterminateComponent = ReactWorkTags.IndeterminateComponent;
local ForwardRef = ReactWorkTags.ForwardRef;
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent;
local ClassComponent = ReactWorkTags.ClassComponent;
local ReactComponentStackFrame = require(script.Parent.Parent:WaitForChild("shared")).ReactComponentStackFrame;
local describeBuiltInComponentFrame = ReactComponentStackFrame.describeBuiltInComponentFrame;
local describeFunctionComponentFrame = ReactComponentStackFrame.describeFunctionComponentFrame;
local describeClassComponentFrame = ReactComponentStackFrame.describeClassComponentFrame;

local function describeFiber(p1) -- Line: 37
    -- upvalues: HostComponent (copy), describeBuiltInComponentFrame (copy), LazyComponent (copy), SuspenseComponent (copy), SuspenseListComponent (copy), FunctionComponent (copy), IndeterminateComponent (copy), SimpleMemoComponent (copy), describeFunctionComponentFrame (copy), ForwardRef (copy), ClassComponent (copy), describeClassComponentFrame (copy)
    local v2 = nil;

    if _G.__DEV__ then
        local _debugOwner = p1._debugOwner;

        if _debugOwner then
            v2 = _debugOwner.type;
        end;
    end;

    local v3;

    if _G.__DEV__ then
        v3 = p1._debugSource;
    else
        v3 = nil;
    end;

    if p1.tag == HostComponent then
        return describeBuiltInComponentFrame(p1.type, v3, v2);
    end;

    if p1.tag == LazyComponent then
        return describeBuiltInComponentFrame("Lazy", v3, v2);
    end;

    if p1.tag == SuspenseComponent then
        return describeBuiltInComponentFrame("Suspense", v3, v2);
    end;

    if p1.tag == SuspenseListComponent then
        return describeBuiltInComponentFrame("SuspenseList", v3, v2);
    end;

    if p1.tag == FunctionComponent or (p1.tag == IndeterminateComponent or p1.tag == SimpleMemoComponent) then
        return describeFunctionComponentFrame(p1.type, v3, v2);
    end;

    if p1.tag == ForwardRef then
        return describeFunctionComponentFrame(p1.type.render, v3, v2);
    end;

    return p1.tag ~= ClassComponent and "" or describeClassComponentFrame(p1.type, v3, v2);
end;

return {
    getStackByFiberInDevAndProd = function(u4) -- Line: 75, Name: getStackByFiberInDevAndProd
        -- upvalues: describeFiber (copy)
        local success, result = pcall(function() -- Line: 76
            -- upvalues: u4 (copy), describeFiber (ref)
            local v5 = u4;
            local v6 = "";

            repeat
                v6 = v6 .. describeFiber(v5);
                v5 = v5.return_;
            until v5 == nil;

            return v6;
        end);

        if success then
            return result;
        end;

        if typeof(result) == "table" and (result.message and result.stack) then
            return "\nError generating stack: " .. result.message .. "\n" .. tostring(result.stack);
        end;

        return "\nError generating stack: " .. tostring(result);
    end
};