-- Decompiled with Potassium's decompiler.

local Head = game.Players.LocalPlayer.Character:WaitForChild("Head");
game:GetService("RunService").RenderStepped:connect(function() -- Line: 9
    -- upvalues: Head (copy)
    local Position = Head.Position;
    local SoundService = game:GetService("SoundService");
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterDescendantsInstances = { Head.Parent };
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Blacklist;
    local v1 = workspace:Raycast(Position, Vector3.new(0, 90, 0), RaycastParams_new_ret);

    if v1 then
        local Instance = v1.Instance;

        if Instance:IsDescendantOf(workspace) and Instance.Transparency == 0 then
            SoundService.AmbientReverb = "City";
        end;
    else
        SoundService.AmbientReverb = "NoReverb";
    end;
end);