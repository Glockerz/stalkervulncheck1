-- Decompiled with Potassium's decompiler.

local REACT_PORTAL_TYPE = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols.REACT_PORTAL_TYPE;
require(script.Parent.Parent:WaitForChild("shared"));

return {
    createPortal = function(p1: any, p2: any, p3: any, p4: string?) -- Line: 17, Name: createPortal
        -- upvalues: REACT_PORTAL_TYPE (copy)
        if p4 ~= nil then
            p4 = tostring(p4);
        end;

        return {
            ["$$typeof"] = REACT_PORTAL_TYPE,
            key = p4,
            children = p1,
            containerInfo = p2,
            implementation = p3
        };
    end
};