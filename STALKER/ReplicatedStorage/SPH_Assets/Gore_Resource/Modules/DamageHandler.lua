-- Decompiled with Potassium's decompiler.

local SPH_Assets = game.ReplicatedStorage.SPH_Assets;
local Gore_Resource = SPH_Assets.Gore_Resource;
local GoreHandler = require(Gore_Resource.Modules.GoreHandler);
local GameConfig = require(SPH_Assets.GameConfig);

return {
    ApplyDamage = function(p1, p2, p3) -- Line: 11, Name: ApplyDamage
        -- upvalues: GameConfig (copy), Gore_Resource (copy), GoreHandler (copy)
        if GameConfig.gibbing then
            local LimbHealth = p1.Parent:FindFirstChild("LimbHealth");

            if not LimbHealth then
                return;
            end;

            if p2.Name == "HumanoidRootPart" then
                p2 = p1.Parent:WaitForChild("Torso");
            end;

            local Children = Gore_Resource.Gibs.GunGibs[p2.Name]:GetChildren();
            local v4 = Children[math.random(#Children)][p2.Name];
            local v5 = LimbHealth[p2.Name];

            if v5.Value > 0 then
                v5.Value = math.max(v5.Value - p3 / 1.5, 0);
            end;

            if v5.Value == 0 then
                p2.Parent:WaitForChild("Torso").Velocity = p1.Parent.Torso.CFrame.LookVector * 18;
                GoreHandler.gore(p2, p1.Parent, v4);
            end;
        end;
    end
};