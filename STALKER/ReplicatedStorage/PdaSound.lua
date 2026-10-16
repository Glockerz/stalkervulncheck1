-- Decompiled with Potassium's decompiler.

local SoundService = game:GetService("SoundService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};
local u2 = {};

local function indexFolder() -- Line: 10
    -- upvalues: ReplicatedStorage (copy), u2 (copy)
    local v3 = nil;

    for _, child in ipairs(ReplicatedStorage:GetChildren()) do
        if string.lower(child.Name) == "pdasounds" then
            v3 = child;
            break;
        end;
    end;

    if v3 then
        for _, descendant in ipairs(v3:GetDescendants()) do
            if descendant:IsA("Sound") then
                u2[string.lower(descendant.Name)] = descendant;
            end;
        end;

        return;
    end;

    warn("[PdaSound] Pdasounds folder not found in ReplicatedStorage");
end;

indexFolder();
local os_clock_ret = os.clock();

local function lookup(p4) -- Line: 36
    -- upvalues: u2 (copy), os_clock_ret (ref), indexFolder (copy)
    local string_lower_ret = string.lower(p4);
    local v5 = u2[string_lower_ret];

    if not v5 and os.clock() - os_clock_ret >= 2 then
        os_clock_ret = os.clock();
        indexFolder();
        v5 = u2[string_lower_ret];
    end;

    return v5;
end;

local u6 = nil;

local function volumeScale() -- Line: 52
    -- upvalues: u6 (ref), ReplicatedStorage (copy)
    if u6 == nil then
        local success, result = pcall(function() -- Line: 54
            -- upvalues: ReplicatedStorage (ref)
            return require(ReplicatedStorage:WaitForChild("ClientSettings", 5));
        end);
        u6 = success and result and result or false;
    end;

    if not u6 then
        return 1;
    end;

    local v7 = u6.Get("pdaVolume");

    return type(v7) == "number" and v7 and v7 or 1;
end;

function v1.Play(p8, p9) -- Line: 62
    -- upvalues: u2 (copy), os_clock_ret (ref), indexFolder (copy), volumeScale (copy), SoundService (copy)
    if not p8 then
        return nil;
    end;

    local string_lower_ret = string.lower(p8);
    local v10 = u2[string_lower_ret];

    if not v10 and os.clock() - os_clock_ret >= 2 then
        os_clock_ret = os.clock();
        indexFolder();
        v10 = u2[string_lower_ret];
    end;

    if not v10 then
        return nil;
    end;

    local v11 = volumeScale();

    if v11 <= 0 then
        return nil;
    end;

    local u12 = v10:Clone();
    u12.Volume = (p9 or v10.Volume) * v11;
    u12.Looped = false;
    u12.Parent = SoundService;
    u12:Play();
    local u13 = nil;
    u13 = u12.Ended:Connect(function() -- Line: 74
        -- upvalues: u13 (ref), u12 (copy)
        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;

        u12:Destroy();
    end);
    task.delay((u12.TimeLength > 0 and (u12.TimeLength or 3) or 3) + 1, function() -- Line: 79
        -- upvalues: u12 (copy), u13 (ref)
        if u12.Parent then
            if u13 then
                u13:Disconnect();
                u13 = nil;
            end;

            u12:Destroy();
        end;
    end);

    return u12;
end;

local u14 = nil;

function v1.PlayClick(p15) -- Line: 91
    -- upvalues: u2 (copy), os_clock_ret (ref), indexFolder (copy), u14 (ref), SoundService (copy), volumeScale (copy)
    local string_lower_ret = string.lower("pda_click");
    local v16 = u2[string_lower_ret];

    if not v16 and os.clock() - os_clock_ret >= 2 then
        os_clock_ret = os.clock();
        indexFolder();
        v16 = u2[string_lower_ret];
    end;

    if not v16 then
        return;
    end;

    if not (u14 and u14.Parent) then
        u14 = v16:Clone();
        u14.Name = "PdaClickChannel";
        u14.Looped = false;
        u14.Parent = SoundService;
    end;

    u14:Stop();
    local v17 = volumeScale();

    if v17 <= 0 then
        return;
    end;

    u14.Volume = (p15 or 5) * v17;
    u14:Play();
end;

return v1;