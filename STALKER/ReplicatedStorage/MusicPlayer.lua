-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local MarketplaceService = game:GetService("MarketplaceService");
local MusicConfig = require(ReplicatedStorage:WaitForChild("MusicConfig"));
local MusicRules = require(ReplicatedStorage:WaitForChild("MusicRules"));
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"));
local u1 = {};
local u2 = false;
local u3 = {};
local u4 = nil;
local u5 = MusicRules.Defaults();
local u6 = false;
local u7 = "curated";
local u8 = {};
local u9 = 0;
local u10 = false;
local u11 = nil;
local u12 = 0;
local u13 = 0;
local u14 = {};
local u15 = 0;
local u16 = false;
local u17 = nil;
local u18 = false;
local u19 = nil;

local function emit() -- Line: 40
    -- upvalues: u3 (copy)
    for i in pairs(u3) do
        task.spawn(i);
    end;
end;

function u1.Enabled(p20) -- Line: 44
    -- upvalues: u2 (ref)
    return u2;
end;

function u1.OnChanged(p21, u22) -- Line: 48
    -- upvalues: u3 (copy)
    u3[u22] = true;

    return function() -- Line: 50
        -- upvalues: u3 (ref), u22 (copy)
        u3[u22] = nil;
    end;
end;

function u1.List(p23, p24) -- Line: 53
    -- upvalues: u5 (ref), u14 (copy), MusicConfig (copy)
    local v25 = {};

    if p24 == "custom" then
        for _, v in ipairs(u5.custom) do
            table.insert(v25, {
                artist = "Custom",
                curated = nil,
                id = v,
                name = u14[v] or "Audio " .. v
            });
        end;

        return v25;
    end;

    for i, v in ipairs(MusicConfig.TRACKS) do
        table.insert(v25, {
            id = v.id,
            name = v.name,
            artist = v.artist,
            curated = i
        });
    end;

    return v25;
end;

local function currentEntry() -- Line: 67
    -- upvalues: u1 (copy), u7 (ref), u8 (ref), u9 (ref)
    local v26 = u1:List(u7);
    local v27 = u8[u9];

    return v27 and v26[v27] or nil;
end;

function u1.GetState(p28) -- Line: 73
    -- upvalues: u4 (ref), u7 (ref), u1 (copy), u8 (ref), u9 (ref), u10 (ref), u5 (ref), u6 (ref), u11 (ref)
    local v29 = u4;
    local v30 = {
        source = u7
    };
    local v31 = u1:List(u7);
    local v32 = u8[u9];
    v30.entry = v32 and v31[v32] or nil;
    v30.playing = u10;
    v30.position = v29 and (v29.TimePosition or 0) or 0;
    v30.length = v29 and v29.TimeLength or 0;
    v30.settings = u5;
    v30.loaded = u6;
    v30.error = u11;

    return v30;
end;

local function queueSave() -- Line: 89
    -- upvalues: u16 (ref), u15 (ref), MusicConfig (copy), u19 (ref), u5 (ref)
    if not u16 then
        return;
    end;

    u15 = u15 + 1;
    local u33 = u15;
    task.delay(MusicConfig.SAVE_DEBOUNCE, function() -- Line: 93
        -- upvalues: u33 (copy), u15 (ref), u19 (ref), u5 (ref)
        if u33 ~= u15 then
            return;
        end;

        u19.MusicSaveSettings:FireServer(u5);
    end);
end;

local function pushSpeaker() -- Line: 101
    -- upvalues: u1 (copy), u7 (ref), u8 (ref), u9 (ref), u5 (ref), u10 (ref), u17 (ref), u4 (ref), u18 (ref), u19 (ref), MusicConfig (copy)
    local v34 = u1:List(u7);
    local v35 = u8[u9];
    local v36 = v35 and v34[v35] or nil;

    if not (u5.speaker and (u10 and v36)) then
        v36 = nil;
    end;

    local v37 = {};
    local v38;

    if v36 then
        v38 = v36.curated or nil;
    else
        v38 = nil;
    end;

    v37.track = v38;
    local v39;

    if v36 and v36.curated == nil then
        v39 = v36.id or nil;
    else
        v39 = nil;
    end;

    v37.custom = v39;
    v37.position = u4 and u4.TimePosition or 0;
    u17 = v37;

    if u18 then
        return;
    end;

    u18 = true;
    task.spawn(function() -- Line: 113
        -- upvalues: u17 (ref), u19 (ref), MusicConfig (ref), u18 (ref)
        while u17 do
            local u40 = u17;
            u17 = nil;
            pcall(function() -- Line: 117
                -- upvalues: u19 (ref), u40 (copy)
                u19.MusicSetSpeaker:InvokeServer(u40.track, u40.position, u40.custom);
            end);
            task.wait(MusicConfig.SPEAKER_THROTTLE + 0.05);
        end;

        u18 = false;
    end);
end;

local u41 = nil;

local function advance(p42: boolean) -- Line: 126
    -- upvalues: u12 (ref), MusicRules (copy), u8 (ref), u9 (ref), u5 (ref), u10 (ref), u4 (ref), u3 (copy), pushSpeaker (copy), u41 (ref)
    if p42 then
        u12 = u12 + 1;
        local v43 = MusicRules.NextAfterFailure(#u8, u9, u12, u5.repeatMode);

        if not v43 then
            u10 = false;

            if u4 then
                u4:Stop();
            end;

            for i in pairs(u3) do
                task.spawn(i);
            end;

            pushSpeaker();

            return;
        end;

        u9 = v43;
    else
        local v44 = MusicRules.NextPos(#u8, u9, u5.repeatMode);

        if not v44 then
            u10 = false;

            for i in pairs(u3) do
                task.spawn(i);
            end;

            pushSpeaker();

            return;
        end;

        u9 = v44;
    end;

    u41();
end;

u41 = function() -- Line: 149
    -- upvalues: u1 (copy), u7 (ref), u8 (ref), u9 (ref), u4 (ref), u10 (ref), u3 (copy), u13 (ref), pushSpeaker (copy), MusicConfig (copy), u12 (ref), u11 (ref), MusicRules (copy), u5 (ref), u41 (ref)
    local v45 = u1:List(u7);
    local v46 = u8[u9];
    local u47 = v46 and v45[v46] or nil;
    local v48 = u4;

    if not (u47 and v48) then
        u10 = false;

        for i in pairs(u3) do
            task.spawn(i);
        end;

        return;
    end;

    u13 = u13 + 1;
    local u49 = u13;
    v48:Stop();
    v48.SoundId = "rbxassetid://" .. u47.id;
    v48.TimePosition = 0;
    v48:Play();
    u10 = true;

    for i in pairs(u3) do
        task.spawn(i);
    end;

    pushSpeaker();
    task.delay(MusicConfig.LOAD_TIMEOUT, function() -- Line: 166
        -- upvalues: u49 (copy), u13 (ref), u4 (ref), u12 (ref), u11 (ref), u3 (ref), u47 (copy), u10 (ref), MusicRules (ref), u8 (ref), u9 (ref), u5 (ref), pushSpeaker (ref), u41 (ref)
        if u49 ~= u13 or not u4 then
            return;
        end;

        if u4.IsLoaded and u4.TimeLength > 0 then
            u12 = 0;

            if u11 then
                u11 = nil;

                for i in pairs(u3) do
                    task.spawn(i);
                end;
            end;

            return;
        end;

        u11 = ("%s: %s"):format(u47.name, "this track can\'t be played");

        for i in pairs(u3) do
            task.spawn(i);
        end;

        if not u10 then
            return;
        end;

        u12 = u12 + 1;
        local v50 = MusicRules.NextAfterFailure(#u8, u9, u12, u5.repeatMode);

        if v50 then
            u9 = v50;
            u41();

            return;
        end;

        u10 = false;

        if u4 then
            u4:Stop();
        end;

        for i in pairs(u3) do
            task.spawn(i);
        end;

        pushSpeaker();
    end);
end;

function u1.PlayFrom(p51, p52, p53) -- Line: 182
    -- upvalues: u2 (ref), u7 (ref), u8 (ref), MusicRules (copy), u5 (ref), u9 (ref), u12 (ref), u11 (ref), u41 (ref)
    if not u2 then
        return;
    end;

    local v54 = p51:List(p52);

    if not v54[p53] then
        return;
    end;

    u7 = p52;
    u8 = MusicRules.BuildOrder(#v54, u5.shuffle, p53);
    u9 = 1;
    u12 = 0;
    u11 = nil;
    u41();
end;

function u1.Toggle(p55) -- Line: 194
    -- upvalues: u4 (ref), u10 (ref), u1 (copy), u7 (ref), u8 (ref), u9 (ref), u41 (ref), u3 (copy), pushSpeaker (copy)
    local v56 = u4;

    if not v56 then
        return;
    end;

    if u10 then
        v56:Pause();
        u10 = false;
    else
        local v57 = u1:List(u7);
        local v58 = u8[u9];

        if not (v58 and v57[v58] and (v56.IsLoaded and v56.TimeLength > 0)) then
            local v59 = u1:List(u7);
            local v60 = u8[u9];

            if v60 and v59[v60] or nil then
                u41();

                return;
            end;

            local v61 = u7;
            local v62 = #p55:List(v61) == 0 and (v61 == "curated" and "custom" or "curated") or v61;

            if #p55:List(v62) > 0 then
                p55:PlayFrom(v62, 1);
            end;

            return;
        end;

        v56:Resume();
        u10 = true;
    end;

    for i in pairs(u3) do
        task.spawn(i);
    end;

    pushSpeaker();
end;

function u1.Next(p63) -- Line: 216
    -- upvalues: u8 (ref), u9 (ref), u12 (ref), u41 (ref)
    if #u8 == 0 then
        return;
    end;

    u9 = u9 % #u8 + 1;
    u12 = 0;
    u41();
end;

function u1.Prev(p64) -- Line: 223
    -- upvalues: u8 (ref), u4 (ref), MusicRules (copy), u9 (ref), u5 (ref), u3 (copy), pushSpeaker (copy), u41 (ref)
    if #u8 == 0 or not u4 then
        return;
    end;

    local v65 = MusicRules.PrevPos(#u8, u9, u5.repeatMode, u4.TimePosition);

    if v65 ~= u9 then
        u9 = v65;
        u41();

        return;
    end;

    u4.TimePosition = 0;

    for i in pairs(u3) do
        task.spawn(i);
    end;

    pushSpeaker();
end;

function u1.SeekFraction(p66: table, p67: number) -- Line: 235
    -- upvalues: u4 (ref), MusicRules (copy), u3 (copy), pushSpeaker (copy)
    local v68 = u4;

    if not v68 or v68.TimeLength <= 0 then
        return;
    end;

    v68.TimePosition = MusicRules.ClampSeek(p67 * v68.TimeLength, v68.TimeLength);

    for i in pairs(u3) do
        task.spawn(i);
    end;

    pushSpeaker();
end;

function u1.SetVolume(p69: table, p70: number) -- Line: 242
    -- upvalues: u5 (ref), MusicConfig (copy), u4 (ref), u3 (copy), u16 (ref), u15 (ref), u19 (ref)
    u5.volume = math.clamp(p70, 0, MusicConfig.VOLUME_MAX);

    if u4 then
        u4.Volume = u5.volume;
    end;

    for i in pairs(u3) do
        task.spawn(i);
    end;

    if not u16 then
        return;
    end;

    u15 = u15 + 1;
    local u71 = u15;
    task.delay(MusicConfig.SAVE_DEBOUNCE, function() -- Line: 93
        -- upvalues: u71 (copy), u15 (ref), u19 (ref), u5 (ref)
        if u71 ~= u15 then
            return;
        end;

        u19.MusicSaveSettings:FireServer(u5);
    end);
end;

function u1.SetShuffle(p72: table, p73: boolean) -- Line: 248
    -- upvalues: u5 (ref), u8 (ref), u9 (ref), MusicRules (copy), u7 (ref), u3 (copy), u16 (ref), u15 (ref), MusicConfig (copy), u19 (ref)
    u5.shuffle = p73;
    local v74 = u8[u9];

    if v74 then
        u8 = MusicRules.BuildOrder(#p72:List(u7), p73, v74);
        u9 = 1;
    end;

    for i in pairs(u3) do
        task.spawn(i);
    end;

    if not u16 then
        return;
    end;

    u15 = u15 + 1;
    local u75 = u15;
    task.delay(MusicConfig.SAVE_DEBOUNCE, function() -- Line: 93
        -- upvalues: u75 (copy), u15 (ref), u19 (ref), u5 (ref)
        if u75 ~= u15 then
            return;
        end;

        u19.MusicSaveSettings:FireServer(u5);
    end);
end;

function u1.CycleRepeat(p76) -- Line: 258
    -- upvalues: u5 (ref), MusicRules (copy), u3 (copy), u16 (ref), u15 (ref), MusicConfig (copy), u19 (ref)
    u5.repeatMode = MusicRules.CycleRepeat(u5.repeatMode);

    for i in pairs(u3) do
        task.spawn(i);
    end;

    if not u16 then
        return;
    end;

    u15 = u15 + 1;
    local u77 = u15;
    task.delay(MusicConfig.SAVE_DEBOUNCE, function() -- Line: 93
        -- upvalues: u77 (copy), u15 (ref), u19 (ref), u5 (ref)
        if u77 ~= u15 then
            return;
        end;

        u19.MusicSaveSettings:FireServer(u5);
    end);
end;

function u1.SetSpeaker(p78: table, p79: boolean) -- Line: 263
    -- upvalues: u5 (ref), u3 (copy), u16 (ref), u15 (ref), MusicConfig (copy), u19 (ref), pushSpeaker (copy)
    u5.speaker = p79;

    for i in pairs(u3) do
        task.spawn(i);
    end;

    if u16 then
        u15 = u15 + 1;
        local u80 = u15;
        task.delay(MusicConfig.SAVE_DEBOUNCE, function() -- Line: 93
            -- upvalues: u80 (copy), u15 (ref), u19 (ref), u5 (ref)
            if u80 ~= u15 then
                return;
            end;

            u19.MusicSaveSettings:FireServer(u5);
        end);
    end;

    pushSpeaker();
end;

function u1.SetHearOthers(p81: table, p82: boolean) -- Line: 268
    -- upvalues: u5 (ref), u3 (copy), u16 (ref), u15 (ref), MusicConfig (copy), u19 (ref)
    u5.hearOthers = p82;

    for i in pairs(u3) do
        task.spawn(i);
    end;

    if not u16 then
        return;
    end;

    u15 = u15 + 1;
    local u83 = u15;
    task.delay(MusicConfig.SAVE_DEBOUNCE, function() -- Line: 93
        -- upvalues: u83 (copy), u15 (ref), u19 (ref), u5 (ref)
        if u83 ~= u15 then
            return;
        end;

        u19.MusicSaveSettings:FireServer(u5);
    end);
end;

function u1.AddCustom(p84, p85) -- Line: 273
    -- upvalues: MusicRules (copy), u5 (ref), MusicConfig (copy), MarketplaceService (copy), u14 (copy), u3 (copy), u16 (ref), u15 (ref), u19 (ref)
    local v86 = MusicRules.ParseCustomId(p85);

    if not v86 then
        return false, "Enter an audio ID (numbers only)";
    end;

    if table.find(u5.custom, v86) then
        return false, "Already in your list";
    end;

    if #u5.custom >= MusicConfig.CUSTOM_MAX then
        return false, ("Your list is full (%d)"):format(MusicConfig.CUSTOM_MAX);
    end;

    local success, result = pcall(MarketplaceService.GetProductInfo, MarketplaceService, v86, Enum.InfoType.Asset);

    if success and type(result) == "table" then
        if result.AssetTypeId ~= Enum.AssetType.Audio.Value then
            return false, "That ID is not an audio track";
        end;

        u14[v86] = tostring(result.Name);
    end;

    table.insert(u5.custom, v86);

    for i in pairs(u3) do
        task.spawn(i);
    end;

    if u16 then
        u15 = u15 + 1;
        local u87 = u15;
        task.delay(MusicConfig.SAVE_DEBOUNCE, function() -- Line: 93
            -- upvalues: u87 (copy), u15 (ref), u19 (ref), u5 (ref)
            if u87 ~= u15 then
                return;
            end;

            u19.MusicSaveSettings:FireServer(u5);
        end);
    end;

    return true, nil;
end;

function u1.RemoveCustom(p88: table, p89: number) -- Line: 292
    -- upvalues: u5 (ref), u7 (ref), u1 (copy), u8 (ref), u9 (ref), u4 (ref), u10 (ref), pushSpeaker (copy), u3 (copy), u16 (ref), u15 (ref), MusicConfig (copy), u19 (ref)
    local table_find_ret = table.find(u5.custom, p89);

    if not table_find_ret then
        return;
    end;

    local v90;

    if u7 == "custom" then
        local v91 = u1:List(u7);
        local v92 = u8[u9];
        v90 = v92 and v91[v92] or nil;

        if v90 then
            local v93 = u1:List(u7);
            local v94 = u8[u9];
            v90 = (v94 and v93[v94] or nil).id == p89;
        end;
    else
        v90 = false;
    end;

    table.remove(u5.custom, table_find_ret);

    if v90 then
        if u4 then
            u4:Stop();
        end;

        u10 = false;
        u8 = {};
        u9 = 0;
        pushSpeaker();
    elseif u7 == "custom" then
        u8 = {};
        u9 = 0;
        u10 = false;

        if u4 then
            u4:Stop();
        end;
    end;

    for i in pairs(u3) do
        task.spawn(i);
    end;

    if not u16 then
        return;
    end;

    u15 = u15 + 1;
    local u95 = u15;
    task.delay(MusicConfig.SAVE_DEBOUNCE, function() -- Line: 93
        -- upvalues: u95 (copy), u15 (ref), u19 (ref), u5 (ref)
        if u95 ~= u15 then
            return;
        end;

        u19.MusicSaveSettings:FireServer(u5);
    end);
end;

local function fetchNames() -- Line: 308
    -- upvalues: u5 (ref), u14 (copy), MarketplaceService (copy), u3 (copy)
    for _, v in ipairs(u5.custom) do
        if not u14[v] then
            local success, result = pcall(MarketplaceService.GetProductInfo, MarketplaceService, v, Enum.InfoType.Asset);

            if success and type(result) == "table" then
                u14[v] = tostring(result.Name);
            end;
        end;
    end;

    for i in pairs(u3) do
        task.spawn(i);
    end;
end;

function u1.Init(p96) -- Line: 318
    -- upvalues: u2 (ref), PlaceConfig (copy), u19 (ref), ReplicatedStorage (copy), SoundService (copy), u5 (ref), u4 (ref), MusicRules (copy), u8 (ref), u9 (ref), u10 (ref), u3 (copy), pushSpeaker (copy), u41 (ref), u6 (ref), u16 (ref), fetchNames (copy), Players (copy)
    if u2 or PlaceConfig.IsLobby then
        return;
    end;

    u2 = true;
    u19 = ReplicatedStorage:WaitForChild("Remotes");
    local Music = SoundService:FindFirstChild("Music");

    if not Music then
        Music = Instance.new("SoundGroup");
        Music.Name = "Music";
        Music.Parent = SoundService;
    end;

    local Sound = Instance.new("Sound");
    Sound.Name = "PdaMusic";
    Sound.SoundGroup = Music;
    Sound.Volume = u5.volume;
    Sound.Parent = SoundService;
    u4 = Sound;
    Sound.Ended:Connect(function() -- Line: 335
        -- upvalues: MusicRules (ref), u8 (ref), u9 (ref), u5 (ref), u10 (ref), u3 (ref), pushSpeaker (ref), u41 (ref)
        local v97 = MusicRules.NextPos(#u8, u9, u5.repeatMode);

        if v97 then
            u9 = v97;
            u41();

            return;
        end;

        u10 = false;

        for i in pairs(u3) do
            task.spawn(i);
        end;

        pushSpeaker();
    end);
    task.spawn(function() -- Line: 339
        -- upvalues: u19 (ref), u5 (ref), MusicRules (ref), u6 (ref), u16 (ref), Sound (copy), u3 (ref), fetchNames (ref)
        local v98 = 1;
        local v99, v100;

        while true do
            local v101, v102;
            v101, v99, v100, v102 = pcall(function() -- Line: 342
                -- upvalues: u19 (ref)
                return u19.MusicGetSettings:InvokeServer();
            end);

            if v101 and (type(v99) == "table" and not v102) then
                break;
            end;

            task.wait(v98);
            v98 = math.min(v98 * 2, 30);
        end;

        u5 = MusicRules.Sanitize(v99);
        u6 = v100 == true;
        u16 = true;
        Sound.Volume = u5.volume;

        for i in pairs(u3) do
            task.spawn(i);
        end;

        fetchNames();
    end);
    Players.LocalPlayer.CharacterAdded:Connect(function() -- Line: 358
        -- upvalues: pushSpeaker (ref)
        task.wait(1);
        pushSpeaker();
    end);
end;

return u1;