-- Decompiled with Potassium's decompiler.

local v1 = {};

for _, child in ipairs(script.Profiles:GetChildren()) do
    if child:IsA("ModuleScript") then
        v1[child.Name] = require(child);
    end;
end;

return {
    Roubles = {
        DeathLossPercent = 0.05,
        DeathLossCap = 1000,
        DropModelName = "Roubles",
        StartingBalance = 5000,
        SurvivorStipend = 500,
        DropKeybind = Enum.KeyCode.R,
        DropKeybindModifier = Enum.KeyCode.LeftShift
    },
    Traders = v1
};