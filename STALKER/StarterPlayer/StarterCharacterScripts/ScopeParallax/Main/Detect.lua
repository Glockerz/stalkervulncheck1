-- Decompiled with Potassium's decompiler.

local u1 = {
    timeout = 5
};
local Patcher = require(script.Parent:WaitForChild("Patcher"));

function u1.init() -- Line: 6
    -- upvalues: u1 (copy), Patcher (copy)
    local u2 = {};
    local u3 = 0;

    for _, child in script.Parent.Patcher:GetChildren() do
        local autoDetectMethod = require(child).autoDetectMethod;
        table.insert(u2, autoDetectMethod);
    end;

    task.spawn(function() -- Line: 14
        -- upvalues: u3 (ref), u1 (ref), u2 (copy), Patcher (ref)
        while u3 < u1.timeout do
            u3 = u3 + task.wait();

            for _, v in u2 do
                local v4 = v();

                if v4 then
                    Patcher.update(v4);

                    return;
                end;
            end;
        end;
    end);
end;

return u1;