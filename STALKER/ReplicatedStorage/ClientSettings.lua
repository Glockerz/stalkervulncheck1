-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SettingsRules = require(ReplicatedStorage:WaitForChild("SettingsRules"));
local v1 = {};
local u2 = SettingsRules.Defaults();
local u3 = {};
local u4 = false;
local u5 = false;
local u6 = 0;

local function fire(p7: string, p8: any) -- Line: 28
    -- upvalues: u3 (copy)
    for _, v in ipairs(u3[p7] or {}) do
        task.spawn(v, p8);
    end;
end;

function v1.Get(p9: string) -- Line: 34
    -- upvalues: u2 (ref)
    return u2[p9];
end;

function v1.OnChanged(u10: string, u11: function) -- Line: 39
    -- upvalues: u3 (copy), u2 (ref)
    u3[u10] = u3[u10] or {};
    table.insert(u3[u10], u11);
    task.spawn(u11, u2[u10]);

    return function() -- Line: 43
        -- upvalues: u3 (ref), u10 (copy), u11 (copy)
        local v12 = u3[u10];
        local v13;

        if v12 then
            v13 = table.find(v12, u11);
        else
            v13 = v12;
        end;

        if v13 then
            table.remove(v12, v13);
        end;
    end;
end;

local function send() -- Line: 50
    -- upvalues: ReplicatedStorage (copy), u2 (ref)
    local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

    if Remotes then
        Remotes = Remotes:FindFirstChild("SettingsSave");
    end;

    if Remotes and Remotes:IsA("RemoteEvent") then
        Remotes:FireServer(u2);
    end;
end;

function v1.Set(p14: string, p15: any) -- Line: 56
    -- upvalues: u2 (ref), SettingsRules (copy), fire (copy), u4 (ref), u5 (ref), u6 (ref), ReplicatedStorage (copy)
    local table_clone_ret = table.clone(u2);
    table_clone_ret[p14] = p15;
    local v16 = SettingsRules.Sanitize(table_clone_ret);

    if v16[p14] == u2[p14] then
        return;
    end;

    u2 = v16;
    fire(p14, u2[p14]);

    if not u4 then
        u5 = true;

        return;
    end;

    u6 = u6 + 1;
    local u17 = u6;
    task.delay(0.75, function() -- Line: 66
        -- upvalues: u17 (copy), u6 (ref), ReplicatedStorage (ref), u2 (ref)
        if u17 == u6 then
            local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

            if Remotes then
                Remotes = Remotes:FindFirstChild("SettingsSave");
            end;

            if Remotes and Remotes:IsA("RemoteEvent") then
                Remotes:FireServer(u2);
            end;
        end;
    end);
end;

if RunService:IsClient() and Players.LocalPlayer then
    task.spawn(function() -- Line: 73
        -- upvalues: ReplicatedStorage (copy), SettingsRules (copy), u5 (ref), u4 (ref), u2 (ref), fire (copy)
        local SettingsGet = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SettingsGet", 60);

        if not (SettingsGet and SettingsGet:IsA("RemoteFunction")) then
            return;
        end;

        local v18;

        while true do
            local v19, v20, v21;
            v19, v18, v20, v21 = pcall(function() -- Line: 78
                -- upvalues: SettingsGet (copy)
                return SettingsGet:InvokeServer();
            end);

            if v19 and (not v21 and type(v18) == "table") then
                break;
            end;

            task.wait(2);
        end;

        local v22 = SettingsRules.Sanitize(v18);

        if u5 then
            u4 = true;
            local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

            if Remotes then
                Remotes = Remotes:FindFirstChild("SettingsSave");
            end;

            if Remotes and Remotes:IsA("RemoteEvent") then
                Remotes:FireServer(u2);
            end;
        else
            for i, v in pairs(v22) do
                if u2[i] ~= v then
                    u2[i] = v;
                    fire(i, v);
                end;
            end;

            u4 = true;
        end;
    end);
end;

return v1;