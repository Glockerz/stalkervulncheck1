-- Decompiled with Potassium's decompiler.

local v1 = {};
local Debugger = require(script.Parent.Debug.Debugger);

function v1.solve(p2, p3, p4) -- Line: 4
    -- upvalues: Debugger (copy)
    if p4 then
        Debugger(p3.Attachment.WorldPosition - p3.Attachment0.WorldPosition, CFrame.new(p3.Attachment.WorldPosition, p3.Attachment0.WorldPosition));
    end;

    return p3.Attachment.WorldPosition, p3.Attachment0.WorldPosition - p3.Attachment.WorldPosition;
end;

function v1.lastPosition(p5, p6) -- Line: 12
    p6.LastPosition = p6.Attachment.WorldPosition;
end;

return v1;