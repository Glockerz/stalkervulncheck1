-- Decompiled with Potassium's decompiler.

local v1 = {};
local Debugger = require(script.Parent.Debug.Debugger);

function v1.solve(p2, p3, p4) -- Line: 4
    -- upvalues: Debugger (copy)
    if not p3.LastPosition then
        p3.LastPosition = p3.Attachment.WorldPosition;
    end;

    if p4 then
        Debugger(p3.Attachment.WorldPosition - p3.LastPosition, CFrame.new(p3.Attachment.WorldPosition, p3.LastPosition));
    end;

    return p3.LastPosition, p3.Attachment.WorldPosition - p3.LastPosition;
end;

function v1.lastPosition(p5, p6) -- Line: 15
    p6.LastPosition = p6.Attachment.WorldPosition;
end;

return v1;