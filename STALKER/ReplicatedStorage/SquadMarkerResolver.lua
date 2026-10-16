-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"));
local u1 = {
    COLORS = {
        Color3.fromRGB(40, 220, 230),
        Color3.fromRGB(255, 105, 180),
        Color3.fromRGB(160, 110, 255),
        Color3.fromRGB(120, 255, 190)
    },
    PULSE_SECONDS = 2
};
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
local u3 = nil;
local u4 = nil;

local function store(p5) -- Line: 34
    -- upvalues: LocalPlayer (copy), u1 (copy), u4 (ref), u2 (copy)
    if type(p5) ~= "table" or (type(p5.owner) ~= "number" or typeof(p5.pos) ~= "Vector3") then
        return;
    end;

    local v6 = {
        pulseUntil = 0,
        pos = p5.pos,
        colorIndex = tonumber(p5.colorIndex) or 1
    };

    if p5.fresh and p5.owner ~= LocalPlayer.UserId then
        v6.pulseUntil = os.clock() + u1.PULSE_SECONDS;

        if u4 then
            u4.Play("pda_objective");
        end;
    end;

    u2[p5.owner] = v6;
end;

if RunService:IsClient() and PlaceConfig.HasMapData then
    task.spawn(function() -- Line: 46
        -- upvalues: ReplicatedStorage (copy), u4 (ref), u3 (ref), store (copy), u2 (copy)
        local success, result = pcall(require, ReplicatedStorage:WaitForChild("PdaSound"));

        if success then
            u4 = result;
        end;

        u3 = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SquadMarkers");
        u3.OnClientEvent:Connect(function(p7, p8) -- Line: 50
            -- upvalues: store (ref), u2 (ref)
            if p7 == "set" then
                store(p8);

                return;
            end;

            if p7 == "remove" and (type(p8) == "table" and p8.owner) then
                u2[p8.owner] = nil;

                return;
            end;

            if p7 == "snapshot" and type(p8) == "table" then
                table.clear(u2);

                for _, v in ipairs(p8) do
                    store(v);
                end;
            end;
        end);
        u3:FireServer("snapshot");
    end);
end;

function u1.Resolve() -- Line: 66
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy)
    local os_clock_ret = os.clock();
    local v9 = {};

    for i, v in pairs(u2) do
        local v10 = {
            owner = i,
            pos = v.pos,
            colorIndex = v.colorIndex,
            color = u1.COLORS[v.colorIndex] or u1.COLORS[1],
            isMine = i == LocalPlayer.UserId,
            pulse = math.clamp((v.pulseUntil - os_clock_ret) / u1.PULSE_SECONDS, 0, 1)
        };
        table.insert(v9, v10);
    end;

    table.sort(v9, function(p11, p12) -- Line: 77
        return p11.colorIndex < p12.colorIndex;
    end);

    return v9;
end;

function u1.GetMine() -- Line: 81
    -- upvalues: u2 (copy), LocalPlayer (copy)
    return u2[LocalPlayer.UserId];
end;

function u1.Place(p13, p14) -- Line: 85
    -- upvalues: u3 (ref)
    if u3 then
        u3:FireServer("place", p13, p14);
    end;
end;

function u1.Remove() -- Line: 89
    -- upvalues: u3 (ref)
    if u3 then
        u3:FireServer("remove");
    end;
end;

return u1;