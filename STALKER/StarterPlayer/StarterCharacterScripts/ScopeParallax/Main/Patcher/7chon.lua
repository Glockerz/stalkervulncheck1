-- Decompiled with Potassium's decompiler.

local u1 = {
    aimpartZOffset = 0.5,
    _7CHON_CLIENT_SCRIPT_NAME = "ACS_Clientv2",
    _7CHON_NEW_VERSION_IDENTIFIER = "Debugs"
};
local StarterCharacterScripts = game:GetService("StarterPlayer").StarterCharacterScripts;
local Default = require(script.Parent:WaitForChild("Default"));
local _ = workspace.CurrentCamera;

function u1.autoDetectMethod() -- Line: 12
    -- upvalues: StarterCharacterScripts (copy), u1 (copy)
    local Saude = StarterCharacterScripts:FindFirstChild("Saude");

    if Saude then
        local v2 = Saude:FindFirstChild(u1._7CHON_CLIENT_SCRIPT_NAME);

        if v2 and v2:FindFirstChild(u1._7CHON_NEW_VERSION_IDENTIFIER) then
            return script.Name;
        end;
    end;
end;

u1.modelDetectionPath = Default.modelDetectionPath;
u1.modelDetectionMethod = Default.modelDetectionMethod;

function u1.parentingMethod(u3: userdata) -- Line: 30
    task.spawn(function() -- Line: 31
        -- upvalues: u3 (copy)
        repeat
            task.wait();
        until u3:FindFirstChildWhichIsA("Motor6D");

        u3.Parent = workspace;
    end);
end;

return u1;