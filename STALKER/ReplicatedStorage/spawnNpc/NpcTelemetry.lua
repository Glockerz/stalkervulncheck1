-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local u3 = {};
local os_clock_ret = os.clock();
local u4 = nil;

function u1.Enabled() -- Line: 20
    -- upvalues: u4 (ref)
    if u4 == nil then
        local success, result = pcall(function() -- Line: 22
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.Telemetry == true;
            else
                success = false;
            end;
        end;

        u4 = success;
    end;

    return u4;
end;

function u1.SetEnabled(p5) -- Line: 29
    -- upvalues: u4 (ref)
    u4 = p5 == true;
end;

function u1.Bump(p6, p7) -- Line: 33
    -- upvalues: u1 (copy), u2 (copy)
    if not u1.Enabled() then
        return;
    end;

    u2[p6] = (u2[p6] or 0) + (p7 or 1);
end;

function u1.AddTime(p8, p9) -- Line: 38
    -- upvalues: u1 (copy), u3 (copy)
    if not (u1.Enabled() and (p9 and p9 > 0)) then
        return;
    end;

    u3[p8] = (u3[p8] or 0) + p9;
end;

local function tag(p10) -- Line: 43
    return string.format("%s.%s.%s", tostring(p10:GetAttribute("Faction")), tostring(p10:GetAttribute("Rank")), (tostring(p10:GetAttribute("Personality"))));
end;

function u1.Death(p11, p12, p13) -- Line: 49
    -- upvalues: u1 (copy)
    if not u1.Enabled() then
        return;
    end;

    u1.Bump("death." .. string.format("%s.%s.%s", tostring(p11:GetAttribute("Faction")), tostring(p11:GetAttribute("Rank")), (tostring(p11:GetAttribute("Personality")))));
    u1.Bump("death." .. tostring(p11:GetAttribute("Faction")));

    if p13 then
        u1.Bump("kill.player");

        return;
    end;

    if p12 and p12:GetAttribute("MutantType") then
        u1.Bump("kill.mutant." .. tostring(p12:GetAttribute("MutantType")));
        u1.Bump("kill.mutant." .. tostring(p12:GetAttribute("MutantType")) .. "." .. tostring(p11:GetAttribute("Faction")));

        return;
    end;

    if not (p12 and p12:GetAttribute("Faction")) then
        u1.Bump("kill.unknown");

        return;
    end;

    u1.Bump("kill." .. string.format("%s.%s.%s", tostring(p12:GetAttribute("Faction")), tostring(p12:GetAttribute("Rank")), (tostring(p12:GetAttribute("Personality")))));
    u1.Bump("kill." .. tostring(p12:GetAttribute("Faction")));
end;

function u1.Snapshot() -- Line: 67
    -- upvalues: u2 (copy), u3 (copy), os_clock_ret (ref)
    local v14 = {};
    local v15 = {};

    for i, v in pairs(u2) do
        v14[i] = v;
    end;

    for i, v in pairs(u3) do
        v15[i] = v;
    end;

    return {
        counts = v14,
        times = v15,
        since = os.clock() - os_clock_ret
    };
end;

function u1.Reset() -- Line: 74
    -- upvalues: u2 (copy), u3 (copy), os_clock_ret (ref)
    table.clear(u2);
    table.clear(u3);
    os_clock_ret = os.clock();
end;

local RunService = game:GetService("RunService");

if RunService:IsServer() and RunService:IsRunning() then
    local ServerStorage = game:GetService("ServerStorage");

    if not ServerStorage:FindFirstChild("NpcTelemetry") then
        local BindableFunction = Instance.new("BindableFunction");
        BindableFunction.Name = "NpcTelemetry";

        function BindableFunction.OnInvoke(p16) -- Line: 88
            -- upvalues: u1 (copy)
            if p16 ~= "reset" then
                return u1.Snapshot();
            end;

            u1.Reset();

            return "reset";
        end;

        BindableFunction.Parent = ServerStorage;
    end;
end;

return u1;