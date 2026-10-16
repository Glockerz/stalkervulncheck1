-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local u7 = {
    _encounters = {},
    _listeners = {},
    _initialized = false,

    GetList = function(p1) -- Line: 16, Name: GetList
        local os_time_ret = os.time();

        for i, v in pairs(p1._encounters) do
            if os_time_ret - v.lastSeen > 3600 then
                p1._encounters[i] = nil;
            end;
        end;

        local v2 = {};

        for i, v in pairs(p1._encounters) do
            table.insert(v2, {
                userId = i,
                name = v.name,
                displayName = v.displayName,
                lastSeen = v.lastSeen,
                lastDistance = v.lastDistance
            });
        end;

        table.sort(v2, function(p3, p4) -- Line: 35
            return p3.lastSeen > p4.lastSeen;
        end);

        return v2;
    end,

    OnChanged = function(p5, p6) -- Line: 39, Name: OnChanged
        table.insert(p5._listeners, p6);
        task.spawn(p6, p5:GetList());
    end
};

local function broadcast() -- Line: 44
    -- upvalues: u7 (copy)
    local List = u7:GetList();

    for _, v in ipairs(u7._listeners) do
        task.spawn(v, List);
    end;
end;

local function scan() -- Line: 51
    -- upvalues: LocalPlayer (copy), Players (copy), u7 (copy), broadcast (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local os_time_ret = os.time();
    local v8 = false;

    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            local Character2 = v.Character;

            if Character2 then
                Character2 = Character2:FindFirstChild("HumanoidRootPart");
            end;

            if Character2 then
                local Magnitude = (Character2.Position - Character.Position).Magnitude;

                if Magnitude <= 100 then
                    u7._encounters[v.UserId] = {
                        name = v.Name,
                        displayName = v.DisplayName,
                        lastSeen = os_time_ret,
                        lastDistance = math.floor(Magnitude)
                    };
                    v8 = true;
                end;
            end;
        end;
    end;

    if v8 then
        broadcast();
    end;
end;

function u7.Init(p9) -- Line: 78
    -- upvalues: scan (copy)
    if p9._initialized then
        return;
    end;

    p9._initialized = true;
    task.spawn(function() -- Line: 81
        -- upvalues: scan (ref)
        while true do
            task.wait(5);
            scan();
        end;
    end);
end;

return u7;