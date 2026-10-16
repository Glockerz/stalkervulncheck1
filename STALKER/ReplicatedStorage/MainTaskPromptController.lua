-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TextChatService = game:GetService("TextChatService");
local v1 = {
    _initialized = false,
    _prompt = nil,
    _promptId = nil,
    _wanted = nil,
    _retrying = false,
    _meetingNpc = nil,
    _tagConns = {}
};

local function sayInChat(u2) -- Line: 43
    -- upvalues: TextChatService (copy)
    if type(u2) ~= "string" or u2 == "" then
        return;
    end;

    task.spawn(function() -- Line: 45
        -- upvalues: TextChatService (ref), u2 (copy)
        local TextChannels = TextChatService:FindFirstChild("TextChannels");

        if TextChannels then
            TextChannels = TextChannels:FindFirstChild("RBXGeneralChannel") or TextChannels:FindFirstChild("RBXGeneral");
        end;

        if not TextChannels then
            return;
        end;

        pcall(function() -- Line: 50
            -- upvalues: TextChannels (copy), u2 (ref)
            TextChannels:SendAsync(u2);
        end);
    end);
end;

local function hasTruce() -- Line: 59
    -- upvalues: Players (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        return os.time() < (tonumber(LocalPlayer:GetAttribute("MT_TruceUntil")) or 0);
    end;

    return false;
end;

local function findMeetingNpc(p3) -- Line: 82
    local PlayerCharacters = workspace:FindFirstChild("PlayerCharacters");

    if PlayerCharacters then
        PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
    end;

    if not PlayerCharacters then
        return nil;
    end;

    for _, child in ipairs(PlayerCharacters:GetChildren()) do
        if child:IsA("Model") and child:GetAttribute("NpcId") == p3 then
            local v4 = child:FindFirstChildOfClass("Humanoid");

            if v4 and (v4.Health > 0 and child:FindFirstChild("Head")) then
                return child;
            end;
        end;
    end;

    return nil;
end;

local function findProp(p5) -- Line: 95
    -- upvalues: CollectionService (copy)
    for _, v in ipairs(CollectionService:GetTagged("MainTaskPrompt")) do
        if v:GetAttribute("PromptId") == p5 then
            return v;
        end;
    end;

    return nil;
end;

local function hostPartOf(p6) -- Line: 102
    if p6:IsA("BasePart") then
        return p6;
    end;

    if p6:IsA("Model") then
        return p6.PrimaryPart or p6:FindFirstChildWhichIsA("BasePart");
    end;

    return nil;
end;

function v1._clear(p7) -- Line: 110
    if p7._prompt then
        p7._prompt:Destroy();
        p7._prompt = nil;
    end;

    p7._promptId = nil;
end;

function v1._wantedMeetingId(p8) -- Line: 130
    -- upvalues: Players (copy)
    local v9 = p8._tc and (p8._tc.GetMainActive and p8._tc:GetMainActive()) or nil;

    if v9 then
        local LocalPlayer = Players.LocalPlayer;
        local v10;

        if LocalPlayer then
            v10 = os.time() < (tonumber(LocalPlayer:GetAttribute("MT_TruceUntil")) or 0);
        else
            v10 = false;
        end;

        if v10 then
            return v9.meetingPromptId;
        end;
    end;

    return nil;
end;

function v1._syncMeeting(p11) -- Line: 143
    -- upvalues: findMeetingNpc (copy)
    local v12 = p11:_wantedMeetingId();

    if not v12 then
        p11._meetingNpc = nil;
        p11._meetingId = nil;

        return nil;
    end;

    local v13 = findMeetingNpc(v12);
    p11._meetingNpc = v13;
    p11._meetingId = v13 and v12 and v12 or nil;

    return v13;
end;

function v1._settled(p14) -- Line: 159
    local _wanted = p14._wanted;
    local v15;

    if _wanted == nil then
        v15 = true;
    else
        v15 = p14._prompt and p14._prompt.Parent and p14._promptId == _wanted;
    end;

    local v16 = p14:_wantedMeetingId();
    local v17;

    if v16 == nil then
        v17 = true;
    else
        v17 = p14._meetingNpc and p14._meetingNpc.Parent and p14._meetingId == v16;
    end;

    return v15 and v17 and true or false;
end;

function v1._startRetry(u18) -- Line: 180
    if u18._retrying then
        return;
    end;

    u18._retrying = true;
    task.spawn(function() -- Line: 183
        -- upvalues: u18 (copy)
        while u18._retrying do
            task.wait(2);

            if u18:_settled() then
                break;
            end;

            local _wanted = u18._wanted;
            u18._promptId = nil;
            u18:_apply(_wanted);
        end;

        u18._retrying = false;
    end);
end;

function v1._apply(u19, u20) -- Line: 198
    -- upvalues: findProp (copy), Players (copy), TextChatService (copy), ReplicatedStorage (copy)
    u19._wanted = u20;
    u19:_syncMeeting();

    if u20 == u19._promptId and (u19._prompt and u19._prompt.Parent) then
        if not u19:_settled() then
            u19:_startRetry();
        end;

        return;
    end;

    u19:_clear();

    if not u20 then
        u19._retrying = false;

        return;
    end;

    local v21 = findProp(u20);

    if not v21 then
        u19:_startRetry();

        return;
    end;

    local v22;

    if u19._tc and u19._tc.GetMainActive then
        v22 = u19._tc:GetMainActive() or nil;
    else
        v22 = nil;
    end;

    local v23 = v22 and v22.parley and v22.promptId == u20;

    if v23 then
        local LocalPlayer = Players.LocalPlayer;
        local v24;

        if LocalPlayer then
            v24 = os.time() < (tonumber(LocalPlayer:GetAttribute("MT_TruceUntil")) or 0);
        else
            v24 = false;
        end;

        if not v24 then
            u19:_startRetry();

            return;
        end;
    end;

    local v25;

    if v21:IsA("BasePart") then
        v25 = v21;
    elseif v21:IsA("Model") then
        v25 = v21.PrimaryPart or v21:FindFirstChildWhichIsA("BasePart");
    else
        v25 = nil;
    end;

    if v23 then
        local _meetingNpc = u19._meetingNpc;

        if not (_meetingNpc and _meetingNpc.Parent) then
            u19:_startRetry();

            return;
        end;

        v25 = _meetingNpc:FindFirstChild("Head") or (_meetingNpc.PrimaryPart or _meetingNpc:FindFirstChild("HumanoidRootPart") or (_meetingNpc:FindFirstChildWhichIsA("BasePart", true) or v25));
    end;

    if not v25 then
        warn(("[MainTaskPrompt] %s has no BasePart to host a prompt"):format(v21:GetFullName()));

        return;
    end;

    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.Name = "MainTaskPrompt";
    ProximityPrompt.ActionText = v21:GetAttribute("PromptText") or "Search";
    ProximityPrompt.ObjectText = "";
    ProximityPrompt.HoldDuration = 0.5;
    ProximityPrompt.MaxActivationDistance = 10;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
    ProximityPrompt.Parent = v25;
    ProximityPrompt.Triggered:Connect(function() -- Line: 313
        -- upvalues: u19 (copy), u20 (copy), TextChatService (ref), ReplicatedStorage (ref)
        local v26 = u19._tc and (u19._tc.GetMainActive and u19._tc:GetMainActive()) or nil;

        if v26 and v26.promptId == u20 then
            local promptSay = v26.promptSay;

            if type(promptSay) == "string" and promptSay ~= "" then
                task.spawn(function() -- Line: 45
                    -- upvalues: TextChatService (ref), promptSay (copy)
                    local TextChannels = TextChatService:FindFirstChild("TextChannels");

                    if TextChannels then
                        TextChannels = TextChannels:FindFirstChild("RBXGeneralChannel") or TextChannels:FindFirstChild("RBXGeneral");
                    end;

                    if not TextChannels then
                        return;
                    end;

                    pcall(function() -- Line: 50
                        -- upvalues: TextChannels (copy), promptSay (ref)
                        TextChannels:SendAsync(promptSay);
                    end);
                end);
            end;

            if v26.parley then
                local function commas(p27) -- Line: 336
                    local v28 = tonumber(p27) or 0;
                    local math_floor_ret = math.floor(v28);

                    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                end;

                local function bestOffer(p29, p30) -- Line: 341
                    local v31 = nil;

                    for _, v in ipairs(p29.offers or {}) do
                        local v32 = v;
                        local v33 = true;

                        for _, v2 in ipairs(v.requires or {}) do
                            if not (p30 and p30[v2]) then
                                v33 = false;
                                break;
                            end;
                        end;

                        for _, v2 in ipairs(v32.excludes or {}) do
                            if p30 and p30[v2] then
                                v33 = false;
                                break;
                            end;
                        end;

                        if v33 and (not v31 or (v32.cost or 0) < (v31.cost or 0)) then
                            v31 = v32;
                        end;
                    end;

                    return v31 or {
                        cost = p29.cost or 0,
                        text = p29.accept
                    };
                end;

                local u34 = v26.parleySettled == true;
                local success, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 2));

                if success and (result and result.OpenTurnIn) then
                    u19._tc:ParleyPause(true);

                    if result.Gui and not u19._pauseConn then
                        u19._pauseConn = result.Gui:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 374
                            -- upvalues: result (copy), u19 (ref)
                            if not result.Gui.Enabled then
                                u19._tc:ParleyPause(false);

                                if u19._pauseConn then
                                    u19._pauseConn:Disconnect();
                                    u19._pauseConn = nil;
                                end;
                            end;
                        end);
                    end;

                    local parley = v26.parley;
                    local squadPaid = parley.squadPaid;
                    local v35 = {
                        DisplayName = "Sych"
                    };
                    local v36 = {
                        intro = u34 and squadPaid and squadPaid.line or parley.intro
                    };
                    local v37;

                    if u34 then
                        v37 = nil;
                    else
                        v37 = parley.topics or nil;
                    end;

                    v36.topics = v37;
                    v36.accept = parley.accept;
                    v36.decline = parley.decline;
                    v36.close = parley.close;
                    local v38;

                    if u34 then
                        v38 = nil;
                    else
                        v38 = parley.acceptRequires or nil;
                    end;

                    v36.acceptRequires = v38;
                    v36.asked = v26.parleyAsked;
                    v36.resumeIntro = parley.resumeIntro;
                    v36.breakOff = parley.breakOff;
                    v36.breakSay = parley.breakSay;
                    v36.breakClose = parley.breakClose;

                    function v36.onBreak() -- Line: 404
                        -- upvalues: u19 (ref)
                        u19._tc:BreakTruce();
                    end;

                    function v36.onAsk(p39) -- Line: 405
                        -- upvalues: u19 (ref)
                        u19._tc:ParleyAsk(p39);
                    end;

                    function v36.resolveAccept(p40) -- Line: 411
                        -- upvalues: u34 (copy), squadPaid (copy), bestOffer (copy), parley (copy)
                        if u34 then
                            return squadPaid and squadPaid.button or "Take it.", nil, 0;
                        end;

                        local v41 = bestOffer(parley, p40);
                        local v42 = v41.cost or (parley.cost or 0);
                        local v43 = tonumber(v42) or 0;
                        local math_floor_ret = math.floor(v43);

                        return ("Pay %s₽"):format((tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))), v41.text or parley.accept, v42;
                    end;

                    function v36.onTurnIn() -- Line: 428
                        -- upvalues: u19 (ref)
                        return u19._tc:Parley();
                    end;

                    if result:OpenTurnIn(nil, v35, v36) then
                        return;
                    end;

                    u19._tc:ParleyPause(false);

                    if u19._pauseConn then
                        u19._pauseConn:Disconnect();
                        u19._pauseConn = nil;
                    end;
                end;
            end;
        end;

        local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

        if Remotes then
            Remotes = Remotes:FindFirstChild("MainTaskPromptFire");
        end;

        if Remotes then
            Remotes:FireServer(u20);
        end;
    end);
    u19._prompt = ProximityPrompt;
    u19._promptId = u20;

    if u19:_settled() then
        u19._retrying = false;

        return;
    end;

    u19:_startRetry();
end;

function v1.Init(u44) -- Line: 458
    -- upvalues: ReplicatedStorage (copy), Players (copy), CollectionService (copy)
    if u44._initialized then
        return;
    end;

    u44._initialized = true;
    local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
    u44._tc = TaskController;

    local function sync() -- Line: 465
        -- upvalues: TaskController (copy), u44 (copy)
        local v45 = TaskController.GetMainActive and TaskController:GetMainActive() or nil;
        u44:_apply(v45 and v45.promptId or nil);
    end;

    TaskController:OnMainChanged(function() -- Line: 470
        -- upvalues: TaskController (copy), u44 (copy)
        local v46 = TaskController.GetMainActive and TaskController:GetMainActive() or nil;
        u44:_apply(v46 and v46.promptId or nil);
    end);
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        local function onTruceChanged() -- Line: 483
            -- upvalues: Players (ref), ReplicatedStorage (ref), TaskController (copy), u44 (copy)
            local LocalPlayer2 = Players.LocalPlayer;
            local v47;

            if LocalPlayer2 then
                v47 = os.time() < (tonumber(LocalPlayer2:GetAttribute("MT_TruceUntil")) or 0);
            else
                v47 = false;
            end;

            if not v47 then
                local success, result = pcall(require, ReplicatedStorage:FindFirstChild("TalkController"));

                if success and (result and (result.IsOpen and result.Close)) then
                    pcall(function() -- Line: 487
                        -- upvalues: result (copy)
                        result:Close();
                    end);
                end;
            end;

            local v48 = TaskController.GetMainActive and TaskController:GetMainActive() or nil;
            u44:_apply(v48 and v48.promptId or nil);
        end;

        local _tagConns = u44._tagConns;
        local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("MT_TruceUntil");
        table.insert(_tagConns, AttributeChangedSignal:Connect(onTruceChanged));
        local _tagConns2 = u44._tagConns;
        local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("MT_TruceGroup");
        table.insert(_tagConns2, AttributeChangedSignal2:Connect(onTruceChanged));
    end;

    local _tagConns = u44._tagConns;
    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("MainTaskPrompt");
    table.insert(_tagConns, InstanceAddedSignal:Connect(function() -- Line: 499
        -- upvalues: TaskController (copy), u44 (copy)
        local v49 = TaskController.GetMainActive and TaskController:GetMainActive() or nil;
        u44:_apply(v49 and v49.promptId or nil);
    end));
    local _tagConns2 = u44._tagConns;
    local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal("MainTaskPrompt");
    table.insert(_tagConns2, InstanceRemovedSignal:Connect(function(p50) -- Line: 501
        -- upvalues: u44 (copy), TaskController (copy)
        if u44._prompt and not u44._prompt.Parent then
            u44:_clear();
        end;

        local v51 = TaskController.GetMainActive and TaskController:GetMainActive() or nil;
        u44:_apply(v51 and v51.promptId or nil);
    end));
    local v52 = TaskController.GetMainActive and TaskController:GetMainActive() or nil;
    u44:_apply(v52 and v52.promptId or nil);
end;

return v1;