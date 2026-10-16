-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("RunService");
game:GetService("ReplicatedStorage");
local _ = workspace.CurrentCamera;
local Detect = require(script:WaitForChild("Detect"));
local Patcher = require(script:WaitForChild("Patcher"));

function v1.init() -- Line: 11
    -- upvalues: Patcher (copy), Detect (copy)
    Patcher.init();
    Detect.init();
end;

return v1;