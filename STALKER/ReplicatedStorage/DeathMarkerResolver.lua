-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local v1 = {
    COLOR = Color3.fromRGB(225, 220, 205),
    COLOR_URGENT = Color3.fromRGB(220, 60, 60),
    URGENT_SECONDS = 60
};
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"));
local u2 = {};

local function store(p3) -- Line: 28
    -- upvalues: u2 (copy)
    if type(p3) == "table" and (type(p3.key) == "string" and (typeof(p3.pos) == "Vector3" and type(p3.expiresAt) == "number")) then
        u2[p3.key] = {
            pos = p3.pos,
            expiresAt = p3.expiresAt
        };
    end;
end;

if RunService:IsClient() and PlaceConfig.AllowDeathLoot then
    task.spawn(function() -- Line: 38
        -- upvalues: ReplicatedStorage (copy), store (copy), u2 (copy)
        local DeathMarkers = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DeathMarkers");
        DeathMarkers.OnClientEvent:Connect(function(p4, p5) -- Line: 40
            -- upvalues: store (ref), u2 (ref)
            if p4 == "set" then
                store(p5);

                return;
            end;

            if p4 == "remove" and (type(p5) == "table" and p5.key) then
                u2[p5.key] = nil;

                return;
            end;

            if p4 == "snapshot" and type(p5) == "table" then
                table.clear(u2);

                for _, v in ipairs(p5) do
                    store(v);
                end;
            end;
        end);
        DeathMarkers:FireServer("snapshot");
    end);
end;

function v1.Resolve() -- Line: 57
    -- upvalues: u2 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v6 = {};

    for i, v in pairs(u2) do
        local v7 = {
            key = i,
            pos = v.pos,
            secondsLeft = math.max(0, v.expiresAt - ServerTimeNow)
        };
        table.insert(v6, v7);
    end;

    table.sort(v6, function(p8, p9) -- Line: 63
        return p8.secondsLeft < p9.secondsLeft;
    end);

    return v6;
end;

function v1.FormatTime(p10) -- Line: 68
    local math_ceil_ret = math.ceil(p10);
    local math_max_ret = math.max(0, math_ceil_ret);

    return string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
end;

return v1;