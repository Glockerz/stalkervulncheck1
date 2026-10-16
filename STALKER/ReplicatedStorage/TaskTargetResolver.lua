-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Workspace = game:GetService("Workspace");
local CollectionService = game:GetService("CollectionService");
local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
local u1 = {
    COLOR_KILL = Color3.fromRGB(220, 50, 50),
    COLOR_TURN_IN = Color3.fromRGB(255, 205, 60),
    COLOR_EXPLORE = Color3.fromRGB(110, 180, 255)
};
local u2 = nil;

local function pdaMapData() -- Line: 19
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    u2 = u2 or require(ReplicatedStorage:WaitForChild("PdaMapData"));

    return u2;
end;

local function taskRegionZone(p3) -- Line: 40
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if p3 then
        p3 = p3.objective_location;
    end;

    local v4 = p3 and p3.zone;

    if not v4 then
        u2 = u2 or require(ReplicatedStorage:WaitForChild("PdaMapData"));
        v4 = u2.CurrentZone();
    end;

    return v4;
end;

local function findLocationPos(p5, p6) -- Line: 54
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if not p5 then
        return nil;
    end;

    u2 = u2 or require(ReplicatedStorage:WaitForChild("PdaMapData"));
    local v7 = u2.FindLocation(p6, p5);

    if v7 then
        return v7;
    end;

    local CollectionService2 = game:GetService("CollectionService");

    for _, v in ipairs(CollectionService2:GetTagged("LocationZone")) do
        if v:IsA("BasePart") and v:GetAttribute("LocationName") == p5 then
            return v.Position;
        end;
    end;

    return nil;
end;

local function findNpcPos(p8) -- Line: 70
    -- upvalues: Workspace (copy)
    if not p8 then
        return nil;
    end;

    local NPCs = Workspace:FindFirstChild("NPCs");

    if not NPCs then
        return nil;
    end;

    local Traders = NPCs:FindFirstChild("Traders");

    if Traders then
        Traders = Traders:FindFirstChild(p8);
    end;

    local v9 = Traders and Traders:FindFirstChild("HumanoidRootPart", true);

    if v9 then
        return v9.Position;
    end;

    for _, descendant in ipairs(NPCs:GetDescendants()) do
        if descendant:IsA("Model") and descendant.Name == p8 then
            local HumanoidRootPart = descendant:FindFirstChild("HumanoidRootPart", true);

            if HumanoidRootPart then
                return HumanoidRootPart.Position;
            end;
        end;
    end;

    return nil;
end;

local function findPromptPos(p10) -- Line: 94
    if not p10 then
        return nil;
    end;

    local CollectionService2 = game:GetService("CollectionService");

    for _, v in ipairs(CollectionService2:GetTagged("MainTaskPrompt")) do
        if v:GetAttribute("PromptId") == p10 then
            if v:IsA("BasePart") then
                return v.Position;
            end;

            if v:IsA("Model") then
                local v11 = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart");

                if v11 then
                    return v11.Position;
                end;
            end;
        end;
    end;

    return nil;
end;

local function findCampPos(p12) -- Line: 111
    -- upvalues: ReplicatedStorage (copy), Workspace (copy)
    if not p12 then
        return nil;
    end;

    local TaskCamps = ReplicatedStorage:FindFirstChild("TaskCamps");

    if TaskCamps then
        TaskCamps = TaskCamps:FindFirstChild(p12);
    end;

    if TaskCamps then
        TaskCamps = TaskCamps:FindFirstChild("tp_point");
    end;

    if TaskCamps then
        TaskCamps = TaskCamps.Value;
    end;

    if not TaskCamps then
        return nil;
    end;

    local TransitPoints = Workspace:FindFirstChild("TransitPoints");

    if TransitPoints then
        TransitPoints = TransitPoints:FindFirstChild(TaskCamps);
    end;

    return TransitPoints and (TransitPoints:IsA("BasePart") and TransitPoints.Position) or nil;
end;

local function killObjectivesDone(p13) -- Line: 123
    if not (p13 and p13.objectives) then
        return true;
    end;

    for _, v in ipairs(p13.objectives) do
        if v.id ~= "return" and (v.id ~= "deliver" and not v.complete) then
            return false;
        end;
    end;

    return true;
end;

function u1.GetTrackedTask() -- Line: 131
    -- upvalues: TaskController (copy)
    local PinnedTask = TaskController:GetPinnedTask();

    if PinnedTask then
        return PinnedTask;
    end;

    local v14 = TaskController.GetMainActive and TaskController:GetMainActive() or nil;

    if v14 then
        return {
            __mainTask = true,
            id = v14.id,
            title = v14.title,
            stageKind = v14.stageKind,
            zone = v14.zone,
            promptId = v14.promptId,
            camp = v14.camp,
            targetPos = v14.targetPos,
            giver = {
                npcId = v14.turnInGiver or "Crow"
            }
        };
    end;

    local ActiveTasks = TaskController:GetActiveTasks();

    return ActiveTasks and ActiveTasks[1] or nil;
end;

function u1.Resolve(p15) -- Line: 158
    -- upvalues: u1 (copy), findLocationPos (copy), u2 (ref), ReplicatedStorage (copy), findPromptPos (copy), findCampPos (copy), findNpcPos (copy), killObjectivesDone (copy), Workspace (copy), CollectionService (copy), TaskController (copy)
    if not p15 then
        return {};
    end;

    local u16 = {};

    local function add(p17, p18, p19, p20, p21) -- Line: 166
        -- upvalues: u16 (copy), u1 (ref)
        if p17 then
            u16[#u16 + 1] = {
                pos = p17,
                color = p18 or u1.COLOR_KILL,
                kind = p19 or "kill",
                npcId = p20,
                subject = p21
            };
        end;
    end;

    local v22 = p15.giver and p15.giver.npcId;

    if p15.__mainTask then
        local stageKind = p15.stageKind;
        local targetPos = p15.targetPos;

        if stageKind == "reach_location" then
            if not targetPos then
                local zone = p15.zone;

                if p15 then
                    p15 = p15.objective_location;
                end;

                local v23 = p15 and p15.zone;

                if not v23 then
                    u2 = u2 or require(ReplicatedStorage:WaitForChild("PdaMapData"));
                    v23 = u2.CurrentZone();
                end;

                targetPos = findLocationPos(zone, v23);
            end;

            local COLOR_EXPLORE = u1.COLOR_EXPLORE;

            if targetPos then
                u16[#u16 + 1] = {
                    kind = "explore",
                    npcId = nil,
                    subject = nil,
                    pos = targetPos,
                    color = COLOR_EXPLORE or u1.COLOR_KILL
                };

                return u16;
            end;
        elseif stageKind == "investigate" or stageKind == "pickup" then
            local v24 = targetPos or findPromptPos(p15.promptId);
            local COLOR_EXPLORE = u1.COLOR_EXPLORE;

            if v24 then
                u16[#u16 + 1] = {
                    kind = "explore",
                    npcId = nil,
                    subject = nil,
                    pos = v24,
                    color = COLOR_EXPLORE or u1.COLOR_KILL
                };

                return u16;
            end;
        elseif stageKind == "kill" then
            local v25 = targetPos or findCampPos(p15.camp);
            local COLOR_KILL = u1.COLOR_KILL;

            if v25 then
                u16[#u16 + 1] = {
                    kind = "kill",
                    npcId = nil,
                    subject = "bandit",
                    pos = v25,
                    color = COLOR_KILL or u1.COLOR_KILL
                };

                return u16;
            end;
        elseif stageKind == "turn_in" then
            local v26 = targetPos or findNpcPos(v22);
            local COLOR_TURN_IN = u1.COLOR_TURN_IN;

            if v26 then
                u16[#u16 + 1] = {
                    kind = "turnin",
                    subject = nil,
                    pos = v26,
                    color = COLOR_TURN_IN or u1.COLOR_KILL,
                    npcId = v22
                };
            end;
        end;

        return u16;
    end;

    if p15.type == "fetching" then
        local v27 = findNpcPos(v22);
        local COLOR_TURN_IN = u1.COLOR_TURN_IN;

        if v27 then
            u16[#u16 + 1] = {
                kind = "turnin",
                subject = nil,
                pos = v27,
                color = COLOR_TURN_IN or u1.COLOR_KILL,
                npcId = v22
            };

            return u16;
        end;
    elseif p15.type == "delivery" then
        local v28 = p15.params and p15.params.destination_npc;
        local v29 = findNpcPos(v28);
        local COLOR_TURN_IN = u1.COLOR_TURN_IN;

        if v29 then
            u16[#u16 + 1] = {
                kind = "turnin",
                subject = nil,
                pos = v29,
                color = COLOR_TURN_IN or u1.COLOR_KILL,
                npcId = v28
            };

            return u16;
        end;
    elseif p15.type == "mutant_hunting" then
        local v30 = false;
        local v31 = false;

        for _, v in ipairs(p15.objectives or {}) do
            v30 = v.id == "hunt" and v.complete and true or v30;

            if v.id == "butcher" and not v.complete then
                v31 = true;
            end;
        end;

        if v30 and v31 then
            return u16;
        end;

        if killObjectivesDone(p15) or v30 then
            local v32 = findNpcPos(v22);
            local COLOR_TURN_IN = u1.COLOR_TURN_IN;

            if v32 then
                u16[#u16 + 1] = {
                    kind = "turnin",
                    subject = nil,
                    pos = v32,
                    color = COLOR_TURN_IN or u1.COLOR_KILL,
                    npcId = v22
                };

                return u16;
            end;
        else
            local u33 = (p15.params and p15.params.mutant_type or ""):lower();
            local u34 = u33 == "any";

            if u33 ~= "" then
                local u35 = u33 .. "_";
                local v36 = "mutantspawn_" .. u33;
                local u37 = Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame.Position or Vector3.new();
                local v38 = {};

                for _, child in ipairs(Workspace:GetChildren()) do
                    if child:IsA("BasePart") and child.Name:lower() == v36 then
                        v38[#v38 + 1] = child.Position;
                    end;
                end;

                if u34 then
                    for _, v in ipairs(CollectionService:GetTagged("MutantZone")) do
                        if v:IsA("BasePart") then
                            v38[#v38 + 1] = v.Position;
                        end;
                    end;
                end;

                local u39 = {};

                local function collect(p40) -- Line: 236
                    -- upvalues: u34 (copy), u33 (copy), u35 (copy), u39 (copy)
                    if not p40:IsA("Model") then
                        return;
                    end;

                    local v41 = p40.Name:lower();

                    if u34 then
                        if p40:GetAttribute("MutantType") == nil then
                            return;
                        end;
                    elseif v41 ~= u33 and v41:sub(1, #u35) ~= u35 then
                        return;
                    end;

                    local v42 = p40:FindFirstChildOfClass("Humanoid");
                    local HumanoidRootPart = p40:FindFirstChild("HumanoidRootPart");

                    if v42 and (v42.Health > 0 and HumanoidRootPart) then
                        u39[#u39 + 1] = HumanoidRootPart.Position;
                    end;
                end;

                local Mutants = Workspace:FindFirstChild("Mutants");

                if Mutants then
                    for _, child in ipairs(Mutants:GetChildren()) do
                        collect(child);
                    end;
                end;

                for _, child in ipairs(Workspace:GetChildren()) do
                    collect(child);
                end;

                if #u39 > 0 then
                    local v43 = (1 / 0);
                    local v44 = nil;

                    for _, v in ipairs(u39) do
                        local Magnitude = (v - u37).Magnitude;

                        if Magnitude < v43 then
                            v44 = v;
                            v43 = Magnitude;
                        end;
                    end;

                    if v44 then
                        for _, v in ipairs(u39) do
                            if (v - v44).Magnitude <= 150 then
                                local COLOR_KILL = u1.COLOR_KILL;

                                if v then
                                    u16[#u16 + 1] = {
                                        kind = "kill",
                                        npcId = nil,
                                        subject = "mutant",
                                        pos = v,
                                        color = COLOR_KILL or u1.COLOR_KILL
                                    };
                                end;
                            end;
                        end;

                        return u16;
                    end;
                elseif v38[1] then
                    table.sort(v38, function(p45, p46) -- Line: 266
                        -- upvalues: u37 (copy)
                        return (p45 - u37).Magnitude < (p46 - u37).Magnitude;
                    end);
                    local v47 = v38[1];
                    local COLOR_KILL = u1.COLOR_KILL;

                    if v47 then
                        u16[#u16 + 1] = {
                            kind = "kill",
                            npcId = nil,
                            subject = "mutant",
                            pos = v47,
                            color = COLOR_KILL or u1.COLOR_KILL
                        };

                        return u16;
                    end;
                end;
            end;
        end;
    elseif p15.type == "deposit" then
        local v48 = false;

        for _, v in ipairs(p15.objectives or {}) do
            if v.id == "deposit" and v.complete then
                v48 = true;
                break;
            end;
        end;

        if v48 then
            local v49 = findNpcPos(v22);
            local COLOR_TURN_IN = u1.COLOR_TURN_IN;

            if v49 then
                u16[#u16 + 1] = {
                    kind = "turnin",
                    subject = nil,
                    pos = v49,
                    color = COLOR_TURN_IN or u1.COLOR_KILL,
                    npcId = v22
                };

                return u16;
            end;
        else
            local v50 = p15.params and p15.params.target_map;
            local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"));
            local v51 = p15.params and p15.params.target_stash_pos;

            if v51 and (not v50 or v50 == PlaceConfig.Id) then
                local Vector3_new_ret = Vector3.new(v51.X or 0, v51.Y or 0, v51.Z or 0);
                local COLOR_EXPLORE = u1.COLOR_EXPLORE;

                if Vector3_new_ret then
                    u16[#u16 + 1] = {
                        kind = "deposit",
                        npcId = nil,
                        subject = nil,
                        pos = Vector3_new_ret,
                        color = COLOR_EXPLORE or u1.COLOR_KILL
                    };

                    return u16;
                end;
            end;
        end;
    elseif p15.type == "exploration" then
        local v52 = true;

        for _, v in ipairs(p15.objectives or {}) do
            if v.id == "visit" and not v.complete then
                v52 = false;
                break;
            end;
        end;

        if v52 then
            local v53 = findNpcPos(v22);
            local COLOR_TURN_IN = u1.COLOR_TURN_IN;

            if v53 then
                u16[#u16 + 1] = {
                    kind = "turnin",
                    subject = nil,
                    pos = v53,
                    color = COLOR_TURN_IN or u1.COLOR_KILL,
                    npcId = v22
                };

                return u16;
            end;
        else
            local v54 = p15.params and p15.params.location_name;

            if p15 then
                p15 = p15.objective_location;
            end;

            local v55 = p15 and p15.zone;

            if not v55 then
                u2 = u2 or require(ReplicatedStorage:WaitForChild("PdaMapData"));
                v55 = u2.CurrentZone();
            end;

            local v56 = findLocationPos(v54, v55);
            local COLOR_EXPLORE = u1.COLOR_EXPLORE;

            if v56 then
                u16[#u16 + 1] = {
                    kind = "explore",
                    npcId = nil,
                    subject = nil,
                    pos = v56,
                    color = COLOR_EXPLORE or u1.COLOR_KILL
                };

                return u16;
            end;
        end;
    elseif p15.type == "kill_contract" then
        if killObjectivesDone(p15) then
            local v57 = findNpcPos(v22);
            local COLOR_TURN_IN = u1.COLOR_TURN_IN;

            if v57 then
                u16[#u16 + 1] = {
                    kind = "turnin",
                    subject = nil,
                    pos = v57,
                    color = COLOR_TURN_IN or u1.COLOR_KILL,
                    npcId = v22
                };

                return u16;
            end;
        else
            local v58 = p15.params and p15.params.target_id;
            local v59 = nil;

            if v58 then
                local PlayerCharacters = Workspace:FindFirstChild("PlayerCharacters");

                if PlayerCharacters then
                    PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
                end;

                for _, v in ipairs(PlayerCharacters and PlayerCharacters:GetChildren() or {}) do
                    if v:IsA("Model") and v:GetAttribute("ContractTarget") == v58 then
                        local v60 = v:FindFirstChildOfClass("Humanoid");
                        local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

                        if v60 and (v60.Health > 0 and HumanoidRootPart) then
                            v59 = HumanoidRootPart.Position;
                            break;
                        end;
                    end;
                end;
            end;

            if not v59 and TaskController.GetContractTargetPos then
                v59 = TaskController:GetContractTargetPos(p15.id);
            end;

            local COLOR_KILL = u1.COLOR_KILL;

            if v59 then
                u16[#u16 + 1] = {
                    kind = "kill",
                    npcId = nil,
                    subject = "bandit",
                    pos = v59,
                    color = COLOR_KILL or u1.COLOR_KILL
                };

                return u16;
            end;
        end;
    elseif p15.type == "clearing" then
        if killObjectivesDone(p15) then
            local v61 = findNpcPos(v22);
            local COLOR_TURN_IN = u1.COLOR_TURN_IN;

            if v61 then
                u16[#u16 + 1] = {
                    kind = "turnin",
                    subject = nil,
                    pos = v61,
                    color = COLOR_TURN_IN or u1.COLOR_KILL,
                    npcId = v22
                };

                return u16;
            end;
        else
            local v62 = nil;
            local v63 = nil;
            local v64 = p15.params and p15.params.camp_id;
            local TaskBanditSpawns = Workspace:FindFirstChild("TaskBanditSpawns");

            if TaskBanditSpawns then
                if v64 then
                    v64 = TaskBanditSpawns:FindFirstChild(v64);
                end;
            else
                v64 = TaskBanditSpawns;
            end;

            if v64 then
                local v65 = (-1 / 0);
                local v66 = (1 / 0);
                local v67 = (-1 / 0);
                local v68 = (1 / 0);
                local v69 = (-1 / 0);
                local v70 = (1 / 0);

                for _, child in ipairs(v64:GetChildren()) do
                    if child:IsA("BasePart") then
                        local X = child.Position.X;
                        local Y = child.Position.Y;
                        local Z = child.Position.Z;

                        if X < v66 then
                            v66 = X;
                        end;

                        if v67 >= X then
                            X = v67;
                        end;

                        if Y < v68 then
                            v68 = Y;
                        end;

                        if v69 >= Y then
                            Y = v69;
                        end;

                        if Z < v70 then
                            v70 = Z;
                        end;

                        if v65 < Z then
                            v69 = Y;
                            v67 = X;
                            v65 = Z;
                        else
                            v69 = Y;
                            v67 = X;
                        end;
                    end;
                end;

                if v66 < (1 / 0) then
                    v62 = Vector3.new((v66 + v67) / 2, (v68 + v69) / 2, (v70 + v65) / 2);
                    local v71 = 0;

                    for _, child in ipairs(v64:GetChildren()) do
                        if child:IsA("BasePart") then
                            local Magnitude = (child.Position - v62).Magnitude;

                            if v71 < Magnitude then
                                v71 = Magnitude;
                            end;
                        end;
                    end;

                    v63 = v71 + 30;
                end;
            end;

            if not v62 then
                local tp_point = p15.tp_point;

                if typeof(tp_point) == "Vector3" then
                    v62 = tp_point;
                elseif type(tp_point) == "table" then
                    v62 = Vector3.new(tp_point.X or (tp_point[1] or 0), tp_point.Y or (tp_point[2] or 0), tp_point.Z or (tp_point[3] or 0));
                end;

                if v62 then
                    v63 = p15.radius or 60;
                end;
            end;

            if v62 then
                local v72 = 0;
                local PlayerCharacters = Workspace:FindFirstChild("PlayerCharacters");

                if PlayerCharacters then
                    PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
                end;

                if PlayerCharacters then
                    for _, child in ipairs(PlayerCharacters:GetChildren()) do
                        if child:IsA("Model") then
                            local v73 = child:FindFirstChildOfClass("Humanoid");
                            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

                            if v73 and (v73.Health > 0 and (HumanoidRootPart and (HumanoidRootPart.Position - v62).Magnitude <= v63)) then
                                local Position = HumanoidRootPart.Position;
                                local COLOR_KILL = u1.COLOR_KILL;

                                if Position then
                                    u16[#u16 + 1] = {
                                        kind = "kill",
                                        npcId = nil,
                                        subject = "bandit",
                                        pos = Position,
                                        color = COLOR_KILL or u1.COLOR_KILL
                                    };
                                end;

                                v72 = v72 + 1;
                            end;
                        end;
                    end;
                end;

                if v72 == 0 then
                    local COLOR_KILL = u1.COLOR_KILL;

                    if v62 then
                        u16[#u16 + 1] = {
                            kind = "kill",
                            npcId = nil,
                            subject = "bandit",
                            pos = v62,
                            color = COLOR_KILL or u1.COLOR_KILL
                        };
                    end;
                end;
            end;
        end;
    end;

    return u16;
end;

return u1;