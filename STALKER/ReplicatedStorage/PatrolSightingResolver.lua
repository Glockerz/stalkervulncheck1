-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local MonolithSighting = require(ReplicatedStorage:WaitForChild("ZoneChatter"):WaitForChild("MonolithSighting"));
local u1 = {
    FADE_SECONDS = 60
};
local u2 = {};

local function store(p3) -- Line: 22
    -- upvalues: u2 (copy)
    if type(p3) == "table" and (type(p3.key) == "string" and (typeof(p3.center) == "Vector3" and (type(p3.radius) == "number" and type(p3.expiresAt) == "number"))) then
        local key = p3.key;
        local v4 = {};
        local v5;

        if type(p3.faction) == "string" then
            v5 = p3.faction or nil;
        else
            v5 = nil;
        end;

        v4.faction = v5;
        v4.center = p3.center;
        v4.radius = p3.radius;
        v4.expiresAt = p3.expiresAt;
        u2[key] = v4;
    end;
end;

if RunService:IsClient() then
    task.spawn(function() -- Line: 33
        -- upvalues: ReplicatedStorage (copy), store (copy), u2 (copy)
        local PatrolSighting = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PatrolSighting", 30);

        if not PatrolSighting then
            return;
        end;

        PatrolSighting.OnClientEvent:Connect(function(p6, p7) -- Line: 36
            -- upvalues: store (ref), u2 (ref)
            if p6 == "set" then
                store(p7);

                return;
            end;

            if p6 == "remove" and (type(p7) == "table" and p7.key) then
                u2[p7.key] = nil;

                return;
            end;

            if p6 == "snapshot" and type(p7) == "table" then
                table.clear(u2);

                for _, v in ipairs(p7) do
                    store(v);
                end;
            end;
        end);
        PatrolSighting:FireServer("snapshot");
    end);
end;

function u1.Resolve() -- Line: 52
    -- upvalues: u2 (copy), MonolithSighting (copy), u1 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v8 = {};

    for i, v in pairs(u2) do
        local v9 = v.expiresAt - ServerTimeNow;

        if v9 <= 0 then
            u2[i] = nil;
        else
            local v10 = MonolithSighting.Style(v.faction);
            local v11 = {
                center = v.center,
                radius = v.radius,
                alpha = math.clamp(v9 / u1.FADE_SECONDS, 0, 1),
                label = v10.label,
                color = v10.color
            };
            table.insert(v8, v11);
        end;
    end;

    return v8;
end;

return u1;