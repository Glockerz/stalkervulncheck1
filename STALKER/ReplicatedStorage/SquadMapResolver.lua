-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"));

return {
    COLOR_SQUAD = Color3.fromRGB(80, 220, 100),

    Resolve = function() -- Line: 19, Name: Resolve
        -- upvalues: Players (copy), SquadController (copy)
        local v1 = {};
        local LocalPlayer = Players.LocalPlayer;

        if not LocalPlayer then
            return v1;
        end;

        local v2 = SquadController:GetMemberIds() or {};

        if #v2 < 2 then
            return v1;
        end;

        for _, v in ipairs(v2) do
            if v ~= LocalPlayer.UserId and tostring(v) ~= tostring(LocalPlayer.UserId) then
                local PlayerByUserId = Players:GetPlayerByUserId(tonumber(v) or v);

                if PlayerByUserId then
                    PlayerByUserId = PlayerByUserId.Character;
                end;

                if PlayerByUserId then
                    PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
                end;

                if PlayerByUserId then
                    v1[#v1 + 1] = {
                        pos = PlayerByUserId.Position
                    };
                end;
            end;
        end;

        return v1;
    end
};