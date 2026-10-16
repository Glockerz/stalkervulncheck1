-- Decompiled with Potassium's decompiler.

local v1 = {};
local Debugger = require(script.Parent.Debug.Debugger);

function v1.solve(p2, p3, p4) -- Line: 4
    -- upvalues: Debugger (copy)
    local v5 = p3.IsAttachment and p3.RelativePart.WorldPosition + p3.RelativePart.WorldCFrame:VectorToWorldSpace(p3.Attachment) or p3.RelativePart.Position + p3.RelativePart.CFrame:VectorToWorldSpace(p3.Attachment);

    if not p3.LastPosition then
        p3.LastPosition = v5;
    end;

    if p4 then
        Debugger(v5 - p3.LastPosition, CFrame.new(v5, p3.LastPosition));
    end;

    return p3.LastPosition, v5 - (p3.LastPosition and p3.LastPosition or Vector3.new()), v5;
end;

function v1.lastPosition(p6, p7, p8) -- Line: 18
    p7.LastPosition = p8;
end;

return v1;