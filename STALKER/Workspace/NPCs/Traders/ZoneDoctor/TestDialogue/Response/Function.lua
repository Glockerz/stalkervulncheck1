-- Decompiled with Potassium's decompiler.

return {
    Decide = function() -- Line: 2, Name: Decide
        local InvokeNpcService = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InvokeNpcService");
        local v1, v2, v3 = pcall(function() -- Line: 6
            -- upvalues: InvokeNpcService (copy)
            return InvokeNpcService:InvokeServer("PatchUp");
        end);

        if not v1 then
            return "PatchedUp";
        end;

        if v2 == "no_funds" then
            return "NoFunds";
        end;

        if v2 == "already_full" then
            return "AlreadyFull";
        end;

        return "PatchedUp", v3;
    end
};