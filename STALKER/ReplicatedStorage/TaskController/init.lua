-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = Players.LocalPlayer;
local TaskRemotes = ReplicatedStorage:WaitForChild("TaskRemotes");
local success, result = pcall(function() -- Line: 8
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("PdaSound", 5));
end);

local function sfx(p1) -- Line: 11
    -- upvalues: success (copy), result (copy)
    if success and result then
        result.Play(p1);
    end;
end;

local u2 = {
    _record = {
        schema_version = 1,
        active = {},
        finished = {},
        giver_cooldowns = {}
    },
    _listeners = {},
    _pendingShares = {},
    _shareListeners = {},
    _shareToastListeners = {},
    _toastFn = nil,
    _initialized = false,
    _pinnedId = nil,
    _pinListeners = {},
    _daily = nil,
    _ecologistRep = 0,
    _dailyListeners = {},
    _main = nil,
    _mainListeners = {},
    _contractTargetPos = {}
};

local function broadcastPin() -- Line: 38
    -- upvalues: u2 (copy)
    for _, v in ipairs(u2._pinListeners) do
        task.spawn(v, u2._pinnedId);
    end;
end;

local function broadcast() -- Line: 44
    -- upvalues: u2 (copy), broadcastPin (copy)
    if u2._pinnedId and (u2._pinnedId:sub(1, 5) ~= "main:" and not u2._record.active[u2._pinnedId]) then
        u2._pinnedId = nil;
        broadcastPin();
    end;

    for _, v in ipairs(u2._listeners) do
        task.spawn(v, u2._record);
    end;
end;

local function broadcastDaily() -- Line: 58
    -- upvalues: u2 (copy)
    for _, v in ipairs(u2._dailyListeners) do
        task.spawn(v, u2._daily);
    end;
end;

local function mainAsTask(p3, p4) -- Line: 68
    if not p3 then
        return nil;
    end;

    local v5 = {
        id = "stage",
        complete = false,
        text = p3.stageText
    };

    if p3.killTarget then
        v5.progress = p3.killProgress or 0;
        v5.target = p3.killTarget;
    end;

    return {
        __mainTask = true,
        id = "main:" .. p3.id,
        title = p3.title,
        objectives = { v5 },
        stageKind = p3.stageKind,
        zone = p3.zone,
        promptId = p3.promptId,
        camp = p3.camp,
        targetPos = p3.targetPos,
        giver = {
            npcId = p3.turnInGiver or (p4 or "Crow")
        }
    };
end;

local function broadcastMain() -- Line: 96
    -- upvalues: u2 (copy), broadcastPin (copy)
    local _pinnedId = u2._pinnedId;

    if _pinnedId and _pinnedId:sub(1, 5) == "main:" then
        local v6 = u2._main and u2._main.active;

        if not v6 or "main:" .. v6.id ~= _pinnedId then
            u2._pinnedId = nil;
            broadcastPin();
        end;
    end;

    for _, v in ipairs(u2._mainListeners) do
        task.spawn(v, u2._main);
    end;
end;

local function pendingShareList() -- Line: 112
    -- upvalues: u2 (copy)
    local v7 = {};

    for _, v in pairs(u2._pendingShares) do
        table.insert(v7, v);
    end;

    table.sort(v7, function(p8, p9) -- Line: 115
        return (p8.received_at or 0) > (p9.received_at or 0);
    end);

    return v7;
end;

local function broadcastShares() -- Line: 119
    -- upvalues: pendingShareList (copy), u2 (copy)
    local v10 = pendingShareList();

    for _, v in ipairs(u2._shareListeners) do
        task.spawn(v, v10);
    end;
end;

local function fireShareToast(p11) -- Line: 126
    -- upvalues: u2 (copy)
    for _, v in ipairs(u2._shareToastListeners) do
        task.spawn(v, p11);
    end;
end;

function u2.GetRecord(p12) -- Line: 132
    return p12._record;
end;

function u2.GetActiveTasks(p13) -- Line: 135
    local v14 = {};

    for _, v in pairs(p13._record.active) do
        table.insert(v14, v);
    end;

    table.sort(v14, function(p15, p16) -- Line: 138
        return (p15.timing and p15.timing.accepted_at or 0) > (p16.timing and p16.timing.accepted_at or 0);
    end);

    return v14;
end;

function u2.GetTask(p17, p18) -- Line: 145
    return p17._record.active[p18];
end;

function u2.GetContractTargetPos(p19, p20) -- Line: 151
    return p20 and p19._contractTargetPos[p20] or nil;
end;

function u2.OnChanged(p21, p22) -- Line: 154
    table.insert(p21._listeners, p22);
    task.spawn(p22, p21._record);
end;

function u2.OnSharesChanged(p23, p24) -- Line: 158
    -- upvalues: pendingShareList (copy)
    table.insert(p23._shareListeners, p24);
    task.spawn(p24, (pendingShareList()));
end;

function u2.OnShareToast(p25, p26) -- Line: 162
    table.insert(p25._shareToastListeners, p26);
end;

function u2.GetPendingShares(p27) -- Line: 165
    -- upvalues: pendingShareList (copy)
    return pendingShareList();
end;

function u2.GetPendingShare(p28, p29) -- Line: 168
    return p29 and p28._pendingShares[p29] or nil;
end;

function u2.GetDaily(p30) -- Line: 171
    return p30._daily;
end;

function u2.GetDailyTasks(p31) -- Line: 174
    return p31._daily and p31._daily.tasks or {};
end;

function u2.GetEcologistRep(p32) -- Line: 177
    return p32._ecologistRep or 0;
end;

function u2.GetDailyTurnIn(p33) -- Line: 198
    local _daily = p33._daily;
    local v34;

    if _daily then
        v34 = tonumber(_daily.turninRoubles);
    else
        v34 = _daily;
    end;

    local v35 = _daily and tonumber(_daily.turninRep) or 1;

    if not v34 then
        return nil, nil, v35;
    end;

    local math_floor_ret = math.floor(v34);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), v34, v35;
end;

function u2.OnDailyChanged(p36, p37) -- Line: 209
    table.insert(p36._dailyListeners, p37);
    task.spawn(p37, p36._daily);
end;

function u2.TurnInDaily(p38, u39) -- Line: 213
    local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
    local success2, result2 = pcall(function() -- Line: 215
        -- upvalues: Remotes (copy), u39 (copy)
        return Remotes.DailyTaskTurnIn:InvokeServer(u39);
    end);

    return not success2 and {
        ok = false,
        err = tostring(result2)
    } or result2;
end;

function u2.GetMain(p40) -- Line: 223
    return p40._main;
end;

function u2.GetMainActive(p41) -- Line: 226
    return p41._main and p41._main.active or nil;
end;

function u2.GetMainAvailable(p42) -- Line: 229
    return p42._main and p42._main.available or {};
end;

function u2.GetMainCompleted(p43) -- Line: 232
    return p43._main and p43._main.completed or {};
end;

function u2.GetMainSideDone(p44) -- Line: 236
    return p44._main and p44._main.sideDone or 0;
end;

function u2.OnMainChanged(p45, p46) -- Line: 239
    table.insert(p45._mainListeners, p46);
    task.spawn(p46, p45._main);
end;

function u2.AcceptMain(p47, u48) -- Line: 243
    -- upvalues: success (copy), result (copy), broadcastPin (copy)
    local v49 = nil;

    for _, v in ipairs(p47:GetMainAvailable()) do
        if v.id == u48 then
            v49 = v.title;
            break;
        end;
    end;

    local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
    local v50, v51, v52, v53 = pcall(function() -- Line: 252
        -- upvalues: Remotes (copy), u48 (copy)
        return Remotes.MainTaskAccept:InvokeServer(u48);
    end);

    if not v50 then
        return false, "error";
    end;

    if v51 then
        if success and result then
            result.Play("pda_objective");
        end;

        p47:ShowToast("Accepted: " .. (v49 or "Story task"));
        local v54 = "main:" .. u48;

        if p47._pinnedId ~= v54 then
            p47._pinnedId = v54;
            broadcastPin();
        end;
    end;

    return v51, v52, v53;
end;

function u2.ParleyAsk(p55, u56) -- Line: 281
    if type(u56) ~= "string" then
        return;
    end;

    local MainTaskParleyAsk = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("MainTaskParleyAsk");

    if MainTaskParleyAsk then
        pcall(function() -- Line: 285
            -- upvalues: MainTaskParleyAsk (copy), u56 (copy)
            MainTaskParleyAsk:FireServer(u56);
        end);
    end;
end;

function u2.BreakTruce(p57) -- Line: 288
    local MainTaskTruceBreak = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("MainTaskTruceBreak");

    if MainTaskTruceBreak then
        pcall(function() -- Line: 291
            -- upvalues: MainTaskTruceBreak (copy)
            MainTaskTruceBreak:FireServer(true);
        end);
    end;
end;

function u2.Parley(p58) -- Line: 294
    -- upvalues: success (copy), result (copy)
    local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
    local v59, v60, v61, v62, v63 = pcall(function() -- Line: 299
        -- upvalues: Remotes (copy)
        return Remotes.MainTaskParley:InvokeServer();
    end);

    if not v59 then
        return false, "error";
    end;

    if v60 and (success and result) then
        result.Play("pda_objective");
    end;

    return v60, v61, v62, v63;
end;

function u2.ParleyPause(p64, u65) -- Line: 309
    local MainTaskParleyPause = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("MainTaskParleyPause");

    if MainTaskParleyPause then
        pcall(function() -- Line: 312
            -- upvalues: MainTaskParleyPause (copy), u65 (copy)
            MainTaskParleyPause:FireServer(u65 and true or false);
        end);
    end;
end;

function u2.TurnInMain(p66, u67) -- Line: 315
    -- upvalues: success (copy), result (copy)
    local v68 = p66._main and p66._main.active;
    local v69 = v68 and (v68.title or "Story task") or "Story task";
    local v70 = v68 and v68.reward and (v68.reward.money or 0) or 0;
    local v71 = v68 and (v68.reward and type(v68.reward.rep) == "number") and (v68.reward.rep or 0) or 0;
    local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
    local v72, v73, v74, v75 = pcall(function() -- Line: 326
        -- upvalues: Remotes (copy), u67 (copy)
        return Remotes.MainTaskTurnIn:InvokeServer(u67);
    end);

    if not v72 then
        return false, "error";
    end;

    if v73 then
        if success and result then
            result.Play("pda_note");
        end;

        p66:ShowToast(string.format("Completed: %s | +%d₽", v69, v70) .. (v71 > 0 and string.format(" | +%d Loner rep", v71) or ""));
    end;

    return v73, v74, v75;
end;

function u2.SetPinned(p76, p77) -- Line: 339
    -- upvalues: broadcastPin (copy)
    if p76._pinnedId == p77 then
        p76._pinnedId = nil;
    else
        p76._pinnedId = p77;
    end;

    broadcastPin();
end;

function u2.GetPinnedId(p78) -- Line: 347
    return p78._pinnedId;
end;

function u2.GetPinnedTask(p79) -- Line: 350
    -- upvalues: mainAsTask (copy)
    if not p79._pinnedId then
        return nil;
    end;

    if p79._pinnedId:sub(1, 5) ~= "main:" then
        return p79._record.active[p79._pinnedId];
    end;

    local v80 = p79._main and p79._main.active;

    if v80 and "main:" .. v80.id == p79._pinnedId then
        return mainAsTask(v80, p79._main.giver);
    end;

    return nil;
end;

function u2.OnPinnedChanged(p81, p82) -- Line: 363
    table.insert(p81._pinListeners, p82);
    task.spawn(p82, p81._pinnedId);
end;

function u2.SetToastHandler(p83, p84) -- Line: 367
    p83._toastFn = p84;
end;

function u2.ShowToast(p85, p86) -- Line: 370
    if p85._toastFn then
        p85._toastFn(p86);
    end;
end;

function u2.RequestOffers(p87, p88) -- Line: 374
    -- upvalues: TaskRemotes (copy)
    return TaskRemotes.RequestOffers:InvokeServer(p88);
end;

function u2.AcceptOffer(p89, p90) -- Line: 377
    -- upvalues: TaskRemotes (copy), broadcast (copy)
    local v91 = TaskRemotes.AcceptTask:InvokeServer(p90);

    if v91 and v91.ok then
        p89._record.active[v91.task.id] = v91.task;
        broadcast();
    end;

    return v91;
end;

function u2.Handin(p92, p93, p94, p95) -- Line: 387
    -- upvalues: TaskRemotes (copy), broadcast (copy)
    local v96 = TaskRemotes.HandinTask:InvokeServer(p93, p94, p95);

    if v96 and v96.ok then
        p92._record.active[p93] = nil;
        broadcast();
    end;

    return v96;
end;

function u2.Abandon(p97, p98) -- Line: 395
    -- upvalues: TaskRemotes (copy), broadcast (copy)
    local v99 = TaskRemotes.AbandonTask:InvokeServer(p98);

    if v99 and v99.ok then
        p97._record.active[p98] = nil;
        broadcast();
    end;

    return v99;
end;

function u2.Share(p100, p101) -- Line: 403
    -- upvalues: TaskRemotes (copy)
    return TaskRemotes.ShareTask:InvokeServer(p101);
end;

function u2.AcceptShare(p102, p103) -- Line: 406
    -- upvalues: TaskRemotes (copy), broadcast (copy), broadcastShares (copy)
    local v104;

    if p103 then
        v104 = p102._pendingShares[p103];
    else
        v104 = p103;
    end;

    if not v104 then
        return {
            ok = false,
            error = "no_share"
        };
    end;

    local v105 = TaskRemotes.AcceptShare:InvokeServer(p103);

    if not (v105 and v105.ok) then
        if v105 and (v105.error == "share_gone" or v105.error == "share_expired") then
            p102._pendingShares[p103] = nil;
            broadcastShares();
        end;

        return v105;
    end;

    p102._record.active[v105.task.id] = v105.task;
    p102._pendingShares[p103] = nil;
    broadcast();
    broadcastShares();

    return v105;
end;

function u2.DeclineShare(p106, p107) -- Line: 422
    -- upvalues: broadcastShares (copy), TaskRemotes (copy)
    if not (p107 and p106._pendingShares[p107]) then
        return {
            ok = false,
            error = "no_share"
        };
    end;

    p106._pendingShares[p107] = nil;
    broadcastShares();
    TaskRemotes.DeclineShare:InvokeServer(p107);

    return {
        ok = true
    };
end;

function u2.Init(u108) -- Line: 430
    -- upvalues: TaskRemotes (copy), broadcast (copy), broadcastShares (copy), success (copy), result (copy), fireShareToast (copy), ReplicatedStorage (copy), broadcastMain (copy), broadcastDaily (copy)
    if u108._initialized then
        return;
    end;

    u108._initialized = true;
    task.spawn(function() -- Line: 434
        -- upvalues: TaskRemotes (ref), u108 (copy), broadcast (ref), broadcastShares (ref)
        local success2, result2 = pcall(function() -- Line: 435
            -- upvalues: TaskRemotes (ref)
            return TaskRemotes.RequestTaskList:InvokeServer();
        end);

        if success2 and result2 then
            u108._record.active = result2.active or {};
            u108._record.finished = result2.finished or {};
            u108._record.giver_cooldowns = result2.giver_cooldowns or {};
            u108._pendingShares = {};

            for i, v in pairs(result2.pending_shares or {}) do
                u108._pendingShares[i] = {
                    received_at = 0,
                    task = v,
                    fromName = v.shared_from_name or "Squadmate"
                };
            end;

            broadcast();
            broadcastShares();
        end;
    end);
    TaskRemotes.OnTaskAccepted.OnClientEvent:Connect(function(p109) -- Line: 449
        -- upvalues: u108 (copy), broadcast (ref), success (ref), result (ref)
        if p109 and p109.id then
            u108._record.active[p109.id] = p109;
            broadcast();

            if success and result then
                result.Play("pda_objective");
            end;

            u108:ShowToast("Accepted: " .. (p109.title or "Task"));
        end;
    end);
    TaskRemotes.OnTaskProgress.OnClientEvent:Connect(function(p110) -- Line: 458
        -- upvalues: u108 (copy), broadcast (ref), success (ref), result (ref)
        if p110 and p110.id then
            local v111 = u108._record.active[p110.id];
            local v112 = false;

            if v111 and (v111.objectives and p110.objectives) then
                local v113 = {};

                for _, v in ipairs(v111.objectives) do
                    if v.id then
                        v113[v.id] = v;
                    end;
                end;

                for _, v in ipairs(p110.objectives) do
                    local v114 = v.id and v113[v.id];

                    if v114 and (not v114.complete and v.complete) then
                        v112 = true;
                        break;
                    end;
                end;
            end;

            u108._record.active[p110.id] = p110;
            broadcast();

            if v112 and (success and result) then
                result.Play("pda_note");
            end;
        end;
    end);
    local OnContractTargetMoved = TaskRemotes:FindFirstChild("OnContractTargetMoved");

    if OnContractTargetMoved then
        OnContractTargetMoved.OnClientEvent:Connect(function(p115, p116) -- Line: 489
            -- upvalues: u108 (copy)
            if type(p115) == "string" and typeof(p116) == "Vector3" then
                u108._contractTargetPos[p115] = p116;
            end;
        end);
    end;

    TaskRemotes.OnTaskCompleted.OnClientEvent:Connect(function(p117) -- Line: 496
        -- upvalues: u108 (copy), broadcast (ref), success (ref), result (ref)
        if p117 and p117.id then
            u108._record.active[p117.id] = nil;
            u108._contractTargetPos[p117.id] = nil;
            broadcast();

            if success and result then
                result.Play("pda_note");
            end;

            u108:ShowToast(string.format("Completed: %s | +%d₽", p117.title or "Task", (p117.rewards or {}).money or 0));
        end;
    end);
    TaskRemotes.OnTaskFailed.OnClientEvent:Connect(function(p118, p119) -- Line: 507
        -- upvalues: u108 (copy), broadcast (ref), success (ref), result (ref)
        local v120 = u108._record.active[p118];

        if v120 then
            u108._record.active[p118] = nil;
            broadcast();

            if success and result then
                result.Play("pda_communication_lost");
            end;

            u108:ShowToast((v120.title or "Task") .. " - " .. (({
                abandoned = "Abandoned",
                died = "Failed: you died",
                lobby = "Failed: the case only travels by transit",
                deadline = "Failed: time\'s up",
                deadline_offline = "Failed: time\'s up",
                squad_done = "Completed by your squad",
                squad_dropped = "Squad task cancelled",
                squad_incomplete = "Squad finished it without your share"
            })[p119] or "Failed"));
        end;
    end);
    TaskRemotes.OnShareOffered.OnClientEvent:Connect(function(p121, p122) -- Line: 527
        -- upvalues: u108 (copy), broadcastShares (ref), success (ref), result (ref), fireShareToast (ref)
        if not (p121 and p121.id) then
            return;
        end;

        local v123 = {
            task = p121,
            fromName = p122 or "Squadmate",
            received_at = os.clock()
        };
        u108._pendingShares[p121.id] = v123;
        broadcastShares();

        if success and result then
            result.Play("pda_news");
        end;

        fireShareToast(v123);
    end);
    TaskRemotes.OnShareWithdrawn.OnClientEvent:Connect(function(p124) -- Line: 536
        -- upvalues: u108 (copy), broadcastShares (ref)
        if p124 and u108._pendingShares[p124] then
            u108._pendingShares[p124] = nil;
            broadcastShares();
        end;
    end);
    local Remotes = ReplicatedStorage:WaitForChild("Remotes");
    Remotes:WaitForChild("MainTaskState").OnClientEvent:Connect(function(p125) -- Line: 546
        -- upvalues: u108 (copy), broadcastMain (ref), success (ref), result (ref)
        local v126 = u108._main and u108._main.active;
        u108._main = p125;
        broadcastMain();

        if p125 then
            p125 = p125.active;
        end;

        if v126 and (p125 and (v126.id == p125.id and ((p125.stageIndex or 0) > (v126.stageIndex or 0) and (success and result)))) then
            result.Play("pda_objective");
        end;
    end);
    Remotes:WaitForChild("MainTaskMessage").OnClientEvent:Connect(function(p127) -- Line: 561
        -- upvalues: success (ref), result (ref), u108 (copy)
        if not (p127 and p127.text) then
            return;
        end;

        if p127.kind == "note" and (success and result) then
            result.Play("pda_note");
        end;

        u108:ShowToast(p127.text);
    end);
    task.spawn(function() -- Line: 568
        -- upvalues: Remotes (copy), u108 (copy), broadcastMain (ref)
        local success2, result2 = pcall(function() -- Line: 569
            -- upvalues: Remotes (ref)
            return Remotes:WaitForChild("MainTaskSnapshot"):InvokeServer();
        end);

        if success2 and result2 then
            u108._main = result2;
            broadcastMain();
        end;
    end);
    local Remotes2 = ReplicatedStorage:WaitForChild("Remotes");
    Remotes2:WaitForChild("DailyTaskAssigned").OnClientEvent:Connect(function(p128) -- Line: 582
        -- upvalues: u108 (copy), broadcastDaily (ref)
        u108._daily = p128;
        u108._ecologistRep = p128 and p128.ecologistRep or 0;
        broadcastDaily();
    end);
    Remotes2:WaitForChild("DailyTaskCompleted").OnClientEvent:Connect(function(p129) -- Line: 587
        -- upvalues: u108 (copy), broadcastDaily (ref), success (ref), result (ref)
        local v130 = u108._daily and (u108._daily.tasks and (p129 and (p129.taskIndex and u108._daily.tasks[p129.taskIndex])));

        if v130 then
            v130.completed = true;
            v130.progress = p129.progress or v130.progress;
            broadcastDaily();

            if success and result then
                result.Play("pda_note");
            end;

            u108:ShowToast("Daily complete — return to the Ecologist");
        end;
    end);
end;

return u2;