-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage:WaitForChild("TalkController")):Init();
local PlayVoicelineClient = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayVoicelineClient", 10);

if PlayVoicelineClient then
    PlayVoicelineClient.OnClientEvent:Connect(function(p1, p2) -- Line: 14
        if not (p1 and (p1.Parent and (p2 and p2.Parent))) then
            return;
        end;

        local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart", true);

        if not HumanoidRootPart then
            return;
        end;

        local u3 = p2:Clone();
        u3.Parent = HumanoidRootPart;
        u3:Play();
        u3.Ended:Connect(function() -- Line: 21
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);
        task.delay(30, function() -- Line: 23
            -- upvalues: u3 (copy)
            if u3 and u3.Parent then
                u3:Destroy();
            end;
        end);
    end);
end;