-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require(ReplicatedStorage.SPH_Assets.Modules.BridgeNet).CreateBridge("SystemMessage");
local u2 = game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.LegacyChatService;
local GameConfig = require(ReplicatedStorage.SPH_Assets.GameConfig);
task.wait(2);

if GameConfig.systemChat and u2 then
    v1:Connect(function(p3, p4) -- Line: 17
        -- upvalues: u2 (copy), StarterGui (copy)
        if not u2 then
            return;
        end;

        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = p3,
            Color = p4
        });
    end);
end;