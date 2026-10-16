-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("RunService");
local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EquipAnimConfig = require(ReplicatedStorage:WaitForChild("EquipAnimConfig"));
local LocalPlayer = Players.LocalPlayer;
local v1 = {
    _started = false,
    _suppressUntil = 0,
    _tracks = {},
    _conns = {},
    _activeTrack = nil,
    _lastEquipped = {},
    _pendingEntry = nil,
    _pendingType = nil,
    _pendingUnequip = false,
    _pendingRank = (1 / 0),
    _resolveScheduled = false,
    _soundMap = {},
    _hookedAnimators = setmetatable({}, {
        __mode = "k"
    }),
    _boundTracks = setmetatable({}, {
        __mode = "k"
    })
};

local function log(p2, ...) -- Line: 49
    -- upvalues: EquipAnimConfig (copy)
    if not EquipAnimConfig.Debug then
        return;
    end;

    print("[EquipAnim] " .. string.format(p2, ...));
end;

local function isConfigured(p3) -- Line: 54
    -- upvalues: EquipAnimConfig (copy)
    local v4;

    if type(p3) == "string" and p3 ~= EquipAnimConfig.PLACEHOLDER then
        v4 = p3:match("^rbxassetid://%d+$") ~= nil;
    else
        v4 = false;
    end;

    return v4;
end;

function v1._entryFor(p5, p6, p7) -- Line: 65
    -- upvalues: EquipAnimConfig (copy)
    if type(p6) ~= "string" then
        return nil;
    end;

    if not EquipAnimConfig.ByType[p6] then
        return nil;
    end;

    if p7 and EquipAnimConfig.ByItem[p7] then
        return EquipAnimConfig.ByItem[p7];
    end;

    return EquipAnimConfig.ByType[p6];
end;

function v1._onEquipmentEvent(u8, p9, p10, p11) -- Line: 81
    -- upvalues: log (copy), EquipAnimConfig (copy)
    if type(p9) ~= "string" or type(p10) ~= "string" then
        return;
    end;

    local v12 = p10 == "unequip";

    if not v12 and p10 ~= "equip" then
        return;
    end;

    if v12 then
        p11 = p11 or u8._lastEquipped[p9];
        u8._lastEquipped[p9] = nil;
    else
        u8._lastEquipped[p9] = p11;
    end;

    local v13 = u8:_entryFor(p9, p11);

    if not v13 then
        return;
    end;

    log("%s %s (%s)", p9, p10, (tostring(p11)));
    local v14 = (EquipAnimConfig.TypeRank[p9] or 99) + (v12 and 100 or 0);

    if v14 < u8._pendingRank then
        u8._pendingRank = v14;
        u8._pendingEntry = v13;
        u8._pendingType = p9;
        u8._pendingUnequip = v12;
    end;

    if not u8._resolveScheduled then
        u8._resolveScheduled = true;
        task.delay(EquipAnimConfig.CoalesceWindow, function() -- Line: 112
            -- upvalues: u8 (copy)
            u8:_resolvePending();
        end);
    end;
end;

function v1._resolvePending(p15) -- Line: 118
    -- upvalues: LocalPlayer (copy), log (copy), EquipAnimConfig (copy)
    p15._resolveScheduled = false;
    local _pendingEntry = p15._pendingEntry;
    local _pendingType = p15._pendingType;
    local _pendingUnequip = p15._pendingUnequip;
    p15._pendingEntry = nil;
    p15._pendingType = nil;
    p15._pendingUnequip = false;
    p15._pendingRank = (1 / 0);

    if not (_pendingEntry and _pendingType) then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if not Character or Character.Health <= 0 then
        log("character dead or absent -- not animating");

        return;
    end;

    if os.clock() < p15._suppressUntil then
        log("inside spawn-suppress window -- not animating");

        return;
    end;

    local animId = _pendingEntry.animId;

    if _pendingUnequip and _pendingEntry.unequipAnimId then
        animId = _pendingEntry.unequipAnimId;
    end;

    local v16;

    if type(animId) == "string" and animId ~= EquipAnimConfig.PLACEHOLDER then
        v16 = animId:match("^rbxassetid://%d+$") ~= nil;
    else
        v16 = false;
    end;

    if not v16 then
        log("%s %s: no animation id configured yet", _pendingType, _pendingUnequip and "unequip" or "equip");

        return;
    end;

    log("PLAY %s %s -> %s", _pendingType, _pendingUnequip and "unequip" or "equip", animId);
    p15:PlayEquipAnim(_pendingEntry, _pendingUnequip);
end;

function v1.StopAnim(p17) -- Line: 164
    -- upvalues: EquipAnimConfig (copy)
    for _, v in ipairs(p17._conns) do
        v:Disconnect();
    end;

    table.clear(p17._conns);

    if p17._activeTrack then
        p17._activeTrack:Stop(EquipAnimConfig.BlendTime);
        p17._activeTrack = nil;
    end;
end;

function v1._bindCancels(u18, p19) -- Line: 178
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if not Character then
        return;
    end;

    local _conns = u18._conns;

    local function add(p20) -- Line: 184
        -- upvalues: _conns (copy)
        _conns[#_conns + 1] = p20;
    end;

    local Health = Character.Health;
    local v23 = Character.HealthChanged:Connect(function(p21) -- Line: 195
        -- upvalues: Health (ref), u18 (copy)
        local v22 = p21 < Health;
        Health = p21;

        if v22 then
            u18:StopAnim();
        end;
    end);
    _conns[#_conns + 1] = v23;
    local v24 = Character.Died:Connect(function() -- Line: 201
        -- upvalues: u18 (copy)
        u18:StopAnim();
    end);
    _conns[#_conns + 1] = v24;
    local v25 = p19.Stopped:Connect(function() -- Line: 205
        -- upvalues: u18 (copy)
        u18:StopAnim();
    end);
    _conns[#_conns + 1] = v25;
end;

function v1.PlayEquipAnim(p26, p27, p28) -- Line: 215
    -- upvalues: LocalPlayer (copy), EquipAnimConfig (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if Character then
        Character = Character:FindFirstChildOfClass("Animator");
    end;

    if not Character then
        return;
    end;

    local animId = p27.animId;
    local v29 = false;

    if p28 then
        if p27.unequip == false then
            return;
        end;

        if p27.unequipAnimId then
            animId = p27.unequipAnimId;
        else
            v29 = true;
        end;
    end;

    local v30;

    if type(animId) == "string" and animId ~= EquipAnimConfig.PLACEHOLDER then
        v30 = animId:match("^rbxassetid://%d+$") ~= nil;
    else
        v30 = false;
    end;

    if not v30 then
        return;
    end;

    p26:StopAnim();
    local v31 = p26._tracks[animId];

    if not v31 then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = animId;
        local v32;
        v32, v31 = pcall(function() -- Line: 240
            -- upvalues: Character (copy), Animation (copy)
            return Character:LoadAnimation(Animation);
        end);

        if not (v32 and v31) then
            warn(("[EquipAnim] failed to load %s"):format((tostring(animId))));

            return;
        end;

        p26._tracks[animId] = v31;
    end;

    v31.Priority = Enum.AnimationPriority.Action4;
    v31.Looped = false;
    local v33 = p27.speed or 1;
    v31:Play(EquipAnimConfig.BlendTime);

    if v29 then
        v31.TimePosition = v31.Length;
        v31:AdjustSpeed(-v33);
    else
        v31:AdjustSpeed(v33);
    end;

    p26._activeTrack = v31;
    p26:_bindCancels(v31);
end;

function v1._buildSoundMap(p34) -- Line: 287
    -- upvalues: EquipAnimConfig (copy)
    local u35 = {};
    local u36 = {};

    local function addFor(p37, p38, p39) -- Line: 290
        -- upvalues: EquipAnimConfig (ref), u35 (copy), u36 (copy)
        local v40;

        if type(p38) == "string" and p38 ~= EquipAnimConfig.PLACEHOLDER then
            v40 = p38:match("^rbxassetid://%d+$") ~= nil;
        else
            v40 = false;
        end;

        if not v40 then
            return;
        end;

        if type(p39) ~= "table" or next(p39) == nil then
            return;
        end;

        if u35[p38] and u35[p38] ~= p39 then
            warn(("[EquipAnim] two entries share %s with different sounds (%s vs %s); %s wins"):format(p38, u36[p38], p37, p37));
        end;

        u35[p38] = p39;
        u36[p38] = p37;
    end;

    local function addAll(p41, p42) -- Line: 304
        -- upvalues: addFor (copy)
        local v43 = {};

        for i in pairs(p41) do
            v43[#v43 + 1] = i;
        end;

        table.sort(v43);

        for _, v in ipairs(v43) do
            local v44 = p41[v];

            if type(v44) == "table" then
                addFor(p42 .. "." .. v, v44.animId, v44.sounds);
                addFor(p42 .. "." .. v, v44.unequipAnimId, v44.sounds);
            end;
        end;
    end;

    addAll(EquipAnimConfig.ByType, "ByType");
    addAll(EquipAnimConfig.ByItem, "ByItem");

    return u35;
end;

function v1._playMarkerSound(p45, p46, p47) -- Line: 324
    -- upvalues: EquipAnimConfig (copy)
    if not (p47 and p47.Parent) then
        return;
    end;

    if type(p46) == "table" then
        if #p46 == 0 then
            return;
        end;

        p46 = p46[math.random(#p46)];
    end;

    if type(p46) ~= "string" or p46 == "" then
        return;
    end;

    local v48 = p47:FindFirstChild("HumanoidRootPart") or (p47:FindFirstChild("Torso") or p47:FindFirstChildWhichIsA("BasePart"));

    if not v48 then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = p46;
    Sound.Volume = EquipAnimConfig.SoundVolume;
    Sound.RollOffMaxDistance = EquipAnimConfig.SoundMaxDistance;
    Sound.Parent = v48;
    Sound:Play();
    Sound.Ended:Connect(function() -- Line: 349
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    game:GetService("Debris"):AddItem(Sound, 10);
end;

function v1._bindMarkerSounds(u49, u50, p51, u52) -- Line: 353
    -- upvalues: EquipAnimConfig (copy)
    if u49._boundTracks[u50] then
        return;
    end;

    u49._boundTracks[u50] = true;

    for i, v in pairs(p51) do
        u50:GetMarkerReachedSignal(i):Connect(function() -- Line: 362
            -- upvalues: u50 (copy), EquipAnimConfig (ref), u49 (copy), v (copy), u52 (copy)
            if u50.Speed < 0 and not EquipAnimConfig.SoundsOnUnequip then
                return;
            end;

            u49:_playMarkerSound(v, u52);
        end);
    end;
end;

function v1._hookAnimator(u53, p54, u55) -- Line: 371
    if not p54 or u53._hookedAnimators[p54] then
        return;
    end;

    u53._hookedAnimators[p54] = true;
    p54.AnimationPlayed:Connect(function(p56) -- Line: 375
        -- upvalues: u53 (copy), u55 (copy)
        local v57;

        if p56 then
            v57 = p56.Animation;
        else
            v57 = p56;
        end;

        if v57 then
            v57 = v57.AnimationId;
        end;

        if not v57 then
            return;
        end;

        local v58 = u53._soundMap[v57];

        if not v58 then
            return;
        end;

        u53:_bindMarkerSounds(p56, v58, u55);
    end);
end;

function v1._watchCharacter(p59, p60) -- Line: 387
    if not p60 then
        return;
    end;

    local v61 = p60:FindFirstChildOfClass("Humanoid") or p60:WaitForChild("Humanoid", 10);

    if not v61 then
        return;
    end;

    local v62 = v61:FindFirstChildOfClass("Animator") or v61:WaitForChild("Animator", 10);

    if not v62 then
        return;
    end;

    p59:_hookAnimator(v62, p60);
end;

function v1._watchPlayer(u63, u64) -- Line: 398
    if u64.Character then
        task.spawn(function() -- Line: 400
            -- upvalues: u63 (copy), u64 (copy)
            u63:_watchCharacter(u64.Character);
        end);
    end;

    u64.CharacterAdded:Connect(function(u65) -- Line: 402
        -- upvalues: u63 (copy)
        task.spawn(function() -- Line: 403
            -- upvalues: u63 (ref), u65 (copy)
            u63:_watchCharacter(u65);
        end);
    end);
end;

function v1._preload(p66) -- Line: 412
    -- upvalues: EquipAnimConfig (copy), log (copy), ContentProvider (copy)
    local u67 = {};
    local u68 = {};

    local function addId(p69) -- Line: 415
        -- upvalues: EquipAnimConfig (ref), u67 (copy), u68 (copy)
        local v70;

        if type(p69) == "string" and p69 ~= EquipAnimConfig.PLACEHOLDER then
            v70 = p69:match("^rbxassetid://%d+$") ~= nil;
        else
            v70 = false;
        end;

        if not v70 then
            return;
        end;

        if u67[p69] then
            return;
        end;

        u67[p69] = true;
        local Animation = Instance.new("Animation");
        Animation.AnimationId = p69;
        u68[#u68 + 1] = Animation;
    end;

    local function addEntry(p71) -- Line: 424
        -- upvalues: EquipAnimConfig (ref), u67 (copy), u68 (copy)
        if type(p71) ~= "table" then
            return;
        end;

        local animId = p71.animId;
        local v72;

        if type(animId) == "string" and animId ~= EquipAnimConfig.PLACEHOLDER then
            v72 = animId:match("^rbxassetid://%d+$") ~= nil;
        else
            v72 = false;
        end;

        if v72 and not u67[animId] then
            u67[animId] = true;
            local Animation = Instance.new("Animation");
            Animation.AnimationId = animId;
            u68[#u68 + 1] = Animation;
        end;

        local unequipAnimId = p71.unequipAnimId;
        local v73;

        if type(unequipAnimId) == "string" and unequipAnimId ~= EquipAnimConfig.PLACEHOLDER then
            v73 = unequipAnimId:match("^rbxassetid://%d+$") ~= nil;
        else
            v73 = false;
        end;

        if not v73 then
            return;
        end;

        if u67[unequipAnimId] then
            return;
        end;

        u67[unequipAnimId] = true;
        local Animation = Instance.new("Animation");
        Animation.AnimationId = unequipAnimId;
        u68[#u68 + 1] = Animation;
    end;

    local function addSounds(p74) -- Line: 430
        -- upvalues: u67 (copy), u68 (copy)
        if type(p74) ~= "table" or type(p74.sounds) ~= "table" then
            return;
        end;

        for _, v in pairs(p74.sounds) do
            local v75 = type(v) == "table" and v and v or { v };

            for _, v2 in ipairs(v75) do
                if type(v2) == "string" and (v2 ~= "" and not u67[v2]) then
                    u67[v2] = true;
                    local Sound = Instance.new("Sound");
                    Sound.SoundId = v2;
                    u68[#u68 + 1] = Sound;
                end;
            end;
        end;
    end;

    for _, v in pairs(EquipAnimConfig.ByType) do
        if type(v) == "table" then
            local animId = v.animId;
            local v76;

            if type(animId) == "string" and animId ~= EquipAnimConfig.PLACEHOLDER then
                v76 = animId:match("^rbxassetid://%d+$") ~= nil;
            else
                v76 = false;
            end;

            if v76 and not u67[animId] then
                u67[animId] = true;
                local Animation = Instance.new("Animation");
                Animation.AnimationId = animId;
                u68[#u68 + 1] = Animation;
            end;

            local unequipAnimId = v.unequipAnimId;
            local v77;

            if type(unequipAnimId) == "string" and unequipAnimId ~= EquipAnimConfig.PLACEHOLDER then
                v77 = unequipAnimId:match("^rbxassetid://%d+$") ~= nil;
            else
                v77 = false;
            end;

            if v77 and not u67[unequipAnimId] then
                u67[unequipAnimId] = true;
                local Animation = Instance.new("Animation");
                Animation.AnimationId = unequipAnimId;
                u68[#u68 + 1] = Animation;
            end;
        end;

        addSounds(v);
    end;

    for _, v in pairs(EquipAnimConfig.ByItem) do
        if type(v) == "table" then
            local animId = v.animId;
            local v78;

            if type(animId) == "string" and animId ~= EquipAnimConfig.PLACEHOLDER then
                v78 = animId:match("^rbxassetid://%d+$") ~= nil;
            else
                v78 = false;
            end;

            if v78 and not u67[animId] then
                u67[animId] = true;
                local Animation = Instance.new("Animation");
                Animation.AnimationId = animId;
                u68[#u68 + 1] = Animation;
            end;

            local unequipAnimId = v.unequipAnimId;
            local v79;

            if type(unequipAnimId) == "string" and unequipAnimId ~= EquipAnimConfig.PLACEHOLDER then
                v79 = unequipAnimId:match("^rbxassetid://%d+$") ~= nil;
            else
                v79 = false;
            end;

            if v79 and not u67[unequipAnimId] then
                u67[unequipAnimId] = true;
                local Animation = Instance.new("Animation");
                Animation.AnimationId = unequipAnimId;
                u68[#u68 + 1] = Animation;
            end;
        end;

        addSounds(v);
    end;

    if #u68 == 0 then
        log("nothing to preload (all entries are placeholders)");

        return;
    end;

    task.spawn(function() -- Line: 453
        -- upvalues: ContentProvider (ref), u68 (copy), log (ref)
        pcall(function() -- Line: 454
            -- upvalues: ContentProvider (ref), u68 (ref)
            ContentProvider:PreloadAsync(u68);
        end);
        log("preloaded %d animation(s)", #u68);
    end);
end;

function v1.Init(u80) -- Line: 461
    -- upvalues: ReplicatedStorage (copy), EquipAnimConfig (copy), LocalPlayer (copy), Players (copy), log (copy)
    if u80._started then
        return;
    end;

    u80._started = true;
    local EquipAnimEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("EquipAnimEvent", 30);

    if not EquipAnimEvent then
        warn("[EquipAnim] Remotes.EquipAnimEvent never appeared -- is EquipAnimRelay running?");

        return;
    end;

    EquipAnimEvent.OnClientEvent:Connect(function(p81, p82, p83) -- Line: 472
        -- upvalues: u80 (copy)
        u80:_onEquipmentEvent(p81, p82, p83);
    end);

    local function onCharacter() -- Line: 476
        -- upvalues: u80 (copy), EquipAnimConfig (ref)
        u80._suppressUntil = os.clock() + EquipAnimConfig.SpawnSuppress;
        u80:StopAnim();
        table.clear(u80._tracks);
        u80._activeTrack = nil;
        table.clear(u80._lastEquipped);
    end;

    if LocalPlayer.Character then
        u80._suppressUntil = os.clock() + EquipAnimConfig.SpawnSuppress;
        u80:StopAnim();
        table.clear(u80._tracks);
        u80._activeTrack = nil;
        table.clear(u80._lastEquipped);
    end;

    LocalPlayer.CharacterAdded:Connect(onCharacter);
    u80._soundMap = u80:_buildSoundMap();

    if next(u80._soundMap) ~= nil then
        for _, v in ipairs(Players:GetPlayers()) do
            u80:_watchPlayer(v);
        end;

        Players.PlayerAdded:Connect(function(p84) -- Line: 496
            -- upvalues: u80 (copy)
            u80:_watchPlayer(p84);
        end);
        local v85 = 0;

        for _ in pairs(u80._soundMap) do
            v85 = v85 + 1;
        end;

        log("marker sounds active for %d animation(s)", v85);
    end;

    u80:_preload();
    print("[EquipAnim] ready");
end;

return v1;