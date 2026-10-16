-- Decompiled with Potassium's decompiler.

local NpcSight = require(game:GetService("ReplicatedStorage"):WaitForChild("NpcSight"));
local v1 = {};
local NpcMutants = require(script.Parent:WaitForChild("NpcMutants"));
local NpcThreat = require(script.Parent:WaitForChild("NpcThreat"));
local u2 = nil;

local function MutantCombatOn() -- Line: 7
    -- upvalues: u2 (ref)
    if u2 == nil then
        local success, result = pcall(function() -- Line: 9
            return require(game:GetService("ServerScriptService"):WaitForChild("NPCConfig", 5));
        end);

        if success then
            if type(result) == "table" and type(result.AI) == "table" then
                success = result.AI.MutantCombat == true;
            else
                success = false;
            end;
        end;

        u2 = success;
    end;

    return u2;
end;

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathfindingService = game:GetService("PathfindingService");
local SimplePath = require(ReplicatedStorage.SimplePath);
local u3 = { 0, 45, -45, 90, -90 };
local u4 = { 10, 20, 32 };

local function flat(p5) -- Line: 101
    return Vector3.new(p5.X, 0, p5.Z);
end;

function v1.New(u6) -- Line: 103
    -- upvalues: SimplePath (copy), PathfindingService (copy), NpcSight (copy), u4 (copy), u3 (copy), NpcThreat (copy), MutantCombatOn (copy), NpcMutants (copy)
    local u7 = {};
    local npcConfig = u6.npcConfig;
    local u8 = SimplePath.new(u6.CharacterAsset);
    local u9 = false;
    local u10 = false;
    local u11 = nil;
    local u12 = 0;
    local u13 = nil;
    local u14 = 0;
    local u15 = nil;
    local u16 = 0;
    local u17 = 0;
    local u18 = false;
    local u19 = nil;
    u7.pathComputes = 0;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { u6.CharacterAsset };
    RaycastParams_new_ret.RespectCanCollide = true;

    local function clearDistance(p20, p21, p22) -- Line: 131
        -- upvalues: RaycastParams_new_ret (copy)
        local v23 = 0;

        for i = 2, p22, 2 do
            if workspace:Raycast(p20, p21 * i, RaycastParams_new_ret) or not workspace:Raycast(p20 + p21 * i, Vector3.new(0, -7, 0), RaycastParams_new_ret) then
                break;
            end;

            v23 = i;
            local v24 = v23;
            local v25 = v23;
            v23 = v24;
            v25 = v24;
        end;

        return v23;
    end;

    local function nearestOtherNpc(p26) -- Line: 142
        -- upvalues: u6 (copy)
        local PlayerCharacters = workspace:FindFirstChild("PlayerCharacters");
        local v27 = (1 / 0);
        local v28 = nil;

        for _, v in ipairs({ "HostileNPCs", "NPCs" }) do
            local v29;

            if PlayerCharacters then
                v29 = PlayerCharacters:FindFirstChild(v);
            else
                v29 = PlayerCharacters;
            end;

            for _, v2 in ipairs(v29 and v29:GetChildren() or {}) do
                if v2 ~= u6.CharacterAsset then
                    local HumanoidRootPart = v2:FindFirstChild("HumanoidRootPart");
                    local v30 = v2:FindFirstChildOfClass("Humanoid");

                    if HumanoidRootPart and (v30 and v30.Health > 0) then
                        local v31 = HumanoidRootPart.Position - p26;
                        local Magnitude = Vector3.new(v31.X, 0, v31.Z).Magnitude;

                        if Magnitude < v27 then
                            v28 = v2;
                            v27 = Magnitude;
                        end;
                    end;
                end;
            end;
        end;

        return v28, v27;
    end;

    local function stopPath() -- Line: 166
        -- upvalues: u9 (ref), u11 (ref), u8 (copy), SimplePath (ref)
        u9 = false;
        u11 = nil;

        if u8.Status == SimplePath.StatusType.Active then
            pcall(function() -- Line: 172
                -- upvalues: u8 (ref)
                u8:Stop();
            end);
        end;
    end;

    local u32 = nil;
    local u33 = 0;
    local u34 = nil;
    local u35 = PathfindingService:CreatePath();
    local RaycastParams_new_ret2 = RaycastParams.new();
    RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret2.FilterDescendantsInstances = { u6.CharacterAsset };

    local function resetFallback() -- Line: 195
        -- upvalues: u32 (ref), u33 (ref)
        u32 = nil;
        u33 = 0;
    end;

    local u36 = nil;

    local function directMove(p37) -- Line: 201
        -- upvalues: u17 (ref), u36 (ref), u9 (ref), u11 (ref), u8 (copy), SimplePath (ref), u32 (ref), u33 (ref), u6 (copy)
        u17 = u17 + 1;

        if u36 then
            u36();
        end;

        u9 = false;
        u11 = nil;

        if u8.Status == SimplePath.StatusType.Active then
            pcall(function() -- Line: 172
                -- upvalues: u8 (ref)
                u8:Stop();
            end);
        end;

        u32 = nil;
        u33 = 0;
        u6.Humanoid:MoveTo(p37);
    end;

    local u38 = nil;

    function u7.SprintTo(p39, p40) -- Line: 215
        -- upvalues: u10 (ref), u38 (ref), u6 (copy), u17 (ref), u36 (ref), u9 (ref), u11 (ref), u8 (copy), SimplePath (ref), u32 (ref), u33 (ref)
        if u10 then
            return;
        end;

        if not u38 then
            u38 = {
                savedSpeed = u6.Humanoid.WalkSpeed
            };
        end;

        u38.speed = p40;
        u38.goal = p39;
        local os_clock_ret = os.clock();
        local Position = u6.HumanoidRootPart.Position;
        u38.checkAt = os_clock_ret;
        u38.checkPos = Position;
        u6.Humanoid.WalkSpeed = p40;
        u6.setTrack(u6.tracks.sprint, true);
        u17 = u17 + 1;

        if u36 then
            u36();
        end;

        u9 = false;
        u11 = nil;

        if u8.Status == SimplePath.StatusType.Active then
            pcall(function() -- Line: 172
                -- upvalues: u8 (ref)
                u8:Stop();
            end);
        end;

        u32 = nil;
        u33 = 0;
        u6.Humanoid:MoveTo(p39);
    end;

    function u7.SprintStatus() -- Line: 226
        -- upvalues: u38 (ref), u6 (copy)
        if not u38 then
            return "none";
        end;

        local Position = u6.HumanoidRootPart.Position;
        local v41 = u38.goal - Position;

        if Vector3.new(v41.X, 0, v41.Z).Magnitude <= 2.5 then
            return "arrived";
        end;

        local os_clock_ret = os.clock();

        if os_clock_ret - u38.checkAt >= 1.5 then
            local v42 = Position - u38.checkPos;

            if Vector3.new(v42.X, 0, v42.Z).Magnitude < 1.5 then
                return "stalled";
            end;

            u38.checkAt = os_clock_ret;
            u38.checkPos = Position;
        end;

        return "moving";
    end;

    function u7.StopSprint() -- Line: 238
        -- upvalues: u38 (ref), u6 (copy)
        if not u38 then
            return;
        end;

        local v43 = u38;
        u38 = nil;

        if u6.Humanoid.WalkSpeed == v43.speed then
            u6.Humanoid.WalkSpeed = v43.savedSpeed;
        end;

        u6.setTrack(u6.tracks.sprint, false);
    end;

    function u7.StopMoving() -- Line: 252
        -- upvalues: u17 (ref), u36 (ref), u7 (copy), u9 (ref), u11 (ref), u8 (copy), SimplePath (ref), u32 (ref), u33 (ref), u13 (ref), u6 (copy)
        u17 = u17 + 1;

        if u36 then
            u36();
        end;

        u7.StopSprint();
        u9 = false;
        u11 = nil;

        if u8.Status == SimplePath.StatusType.Active then
            pcall(function() -- Line: 172
                -- upvalues: u8 (ref)
                u8:Stop();
            end);
        end;

        u32 = nil;
        u33 = 0;
        u13 = nil;
        u6.Humanoid:MoveTo(u6.HumanoidRootPart.Position);
    end;

    local function pathExists(u44, u45) -- Line: 262
        -- upvalues: u7 (copy), u35 (copy)
        local v46 = u7;
        v46.pathComputes = v46.pathComputes + 1;
        local v47 = pcall(function() -- Line: 264
            -- upvalues: u35 (ref), u44 (copy), u45 (copy)
            u35:ComputeAsync(u44, u45);
        end) and u35.Status == Enum.PathStatus.Success;

        return v47;
    end;

    local function spotKey(p48) -- Line: 268
        return math.floor(p48.X / 4) .. "," .. math.floor(p48.Y / 4) .. "," .. math.floor(p48.Z / 4);
    end;

    local function floorAt(p49, p50, p51, p52) -- Line: 274
        -- upvalues: RaycastParams_new_ret (copy)
        local v53 = math.max(p51.Y, p52.Y) + 8;
        local v54 = v53 - math.min(p51.Y, p52.Y) + 40;
        local v55 = workspace:Raycast(Vector3.new(p49, v53, p50), Vector3.new(0, -v54, 0), RaycastParams_new_ret);

        if v55 then
            v55 = v55.Position + Vector3.new(0, 3, 0);
        end;

        return v55;
    end;

    local function seesGoal(p56, p57) -- Line: 281
        -- upvalues: NpcSight (ref), RaycastParams_new_ret2 (copy)
        local v58 = p56 + Vector3.new(0, 1.5, 0);
        local v59 = p57 - v58;
        local v60;

        if v59.Magnitude > 3 then
            v60 = NpcSight.Cast(v58, v59.Unit * (v59.Magnitude - 2.5), RaycastParams_new_ret2) == nil;
        else
            v60 = false;
        end;

        return v60;
    end;

    local function tryProbe(u61, u62, p63) -- Line: 291
        -- upvalues: u7 (copy), u35 (copy)
        if p63.failed[math.floor(u62.X / 4) .. "," .. math.floor(u62.Y / 4) .. "," .. math.floor(u62.Z / 4)] then
            return false;
        end;

        local v64 = u7;
        v64.pathComputes = v64.pathComputes + 1;
        local v65 = pcall(function() -- Line: 264
            -- upvalues: u35 (ref), u61 (copy), u62 (copy)
            u35:ComputeAsync(u61, u62);
        end) and u35.Status == Enum.PathStatus.Success;

        if v65 then
            return true;
        end;

        p63.failed[math.floor(u62.X / 4) .. "," .. math.floor(u62.Y / 4) .. "," .. math.floor(u62.Z / 4)] = true;

        return false;
    end;

    local function chooseSpot(p66, u67, p68) -- Line: 305
        -- upvalues: u4 (ref), RaycastParams_new_ret (copy), NpcSight (ref), RaycastParams_new_ret2 (copy), u7 (copy), u35 (copy), u34 (ref)
        local v69 = p66 - u67;
        local v70 = Vector3.new(v69.X, 0, v69.Z).Magnitude - 8;

        if v70 <= 0 then
            return nil;
        end;

        local v71 = {};

        for _, v in ipairs(u4) do
            local v72 = v;

            for i = 0, 7 do
                local v73 = i / 8 * 3.141592653589793 * 2;
                local v74 = p66.X + math.cos(v73) * v72;
                local v75 = p66.Z + math.sin(v73) * v72;
                local v76 = math.max(p66.Y, u67.Y) + 8;
                local v77 = v76 - math.min(p66.Y, u67.Y) + 40;
                local v78 = workspace:Raycast(Vector3.new(v74, v76, v75), Vector3.new(0, -v77, 0), RaycastParams_new_ret);

                if v78 then
                    v78 = v78.Position + Vector3.new(0, 3, 0);
                end;

                local v79;

                if v78 then
                    local v80 = p66 - v78;

                    if Vector3.new(v80.X, 0, v80.Z).Magnitude <= v70 and not p68.failed[math.floor(v78.X / 4) .. "," .. math.floor(v78.Y / 4) .. "," .. math.floor(v78.Z / 4)] then
                        local v81 = v78 + Vector3.new(0, 1.5, 0);
                        local v82 = p66 - v81;
                        local v83;

                        if v82.Magnitude > 3 then
                            v83 = NpcSight.Cast(v81, v82.Unit * (v82.Magnitude - 2.5), RaycastParams_new_ret2) == nil;
                        else
                            v83 = false;
                        end;

                        if v83 then
                            local v84 = {
                                pos = v78
                            };
                            local v85 = math.abs(v78.Y - u67.Y) > 8 and 1000 or 0;
                            local v86 = p66 - v78;
                            v84.key = v85 + Vector3.new(v86.X, 0, v86.Z).Magnitude;
                            table.insert(v71, v84);
                            v79 = i;
                        else
                            v79 = i;
                        end;
                    else
                        v79 = i;
                    end;
                else
                    v79 = i;
                end;
            end;
        end;

        table.sort(v71, function(p87, p88) -- Line: 322
            return p87.key < p88.key;
        end);

        if v71[1] then
            local pos = v71[1].pos;
            local v89;

            if p68.failed[math.floor(pos.X / 4) .. "," .. math.floor(pos.Y / 4) .. "," .. math.floor(pos.Z / 4)] then
                v89 = false;
            else
                local v90 = u7;
                v90.pathComputes = v90.pathComputes + 1;
                local v91 = pcall(function() -- Line: 264
                    -- upvalues: u35 (ref), u67 (copy), pos (copy)
                    u35:ComputeAsync(u67, pos);
                end) and u35.Status == Enum.PathStatus.Success;

                if v91 then
                    v89 = true;
                else
                    p68.failed[math.floor(pos.X / 4) .. "," .. math.floor(pos.Y / 4) .. "," .. math.floor(pos.Z / 4)] = true;
                    v89 = false;
                end;
            end;

            if v89 then
                return v71[1].pos;
            end;
        end;

        if u34 then
            local v92 = p66 - u34;

            if Vector3.new(v92.X, 0, v92.Z).Magnitude <= v70 then
                local u93 = u34;
                local v94;

                if p68.failed[math.floor(u93.X / 4) .. "," .. math.floor(u93.Y / 4) .. "," .. math.floor(u93.Z / 4)] then
                    v94 = false;
                else
                    local v95 = u7;
                    v95.pathComputes = v95.pathComputes + 1;
                    local v96 = pcall(function() -- Line: 264
                        -- upvalues: u35 (ref), u67 (copy), u93 (copy)
                        u35:ComputeAsync(u67, u93);
                    end) and u35.Status == Enum.PathStatus.Success;

                    if v96 then
                        v94 = true;
                    else
                        p68.failed[math.floor(u93.X / 4) .. "," .. math.floor(u93.Y / 4) .. "," .. math.floor(u93.Z / 4)] = true;
                        v94 = false;
                    end;
                end;

                if v94 then
                    return u34;
                end;
            end;
        end;

        local v97 = p66 - u67;
        local Vector3_new_ret = Vector3.new(v97.X, 0, v97.Z);
        local v98 = {};

        for i = 1, 8 do
            local v99 = u67 + Vector3_new_ret * (i / 8);
            local X = v99.X;
            local Z = v99.Z;
            local v100 = math.max(p66.Y, u67.Y) + 8;
            local v101 = v100 - math.min(p66.Y, u67.Y) + 40;
            local v102 = workspace:Raycast(Vector3.new(X, v100, Z), Vector3.new(0, -v101, 0), RaycastParams_new_ret);

            if v102 then
                v102 = v102.Position + Vector3.new(0, 3, 0);
            end;

            local v103;

            if v102 then
                local v104 = p66 - v102;

                if Vector3.new(v104.X, 0, v104.Z).Magnitude <= v70 then
                    table.insert(v98, v102);
                    v103 = i;
                else
                    v103 = i;
                end;
            else
                v103 = i;
            end;
        end;

        local v105 = #v98;
        local v106 = 1;
        local v107 = nil;

        while v106 <= v105 do
            local v108 = (v106 + v105) // 2;
            local u109 = v98[v108];
            local v110;

            if p68.failed[math.floor(u109.X / 4) .. "," .. math.floor(u109.Y / 4) .. "," .. math.floor(u109.Z / 4)] then
                v110 = false;
            else
                local v111 = u7;
                v111.pathComputes = v111.pathComputes + 1;
                local v112 = pcall(function() -- Line: 264
                    -- upvalues: u35 (ref), u67 (copy), u109 (copy)
                    u35:ComputeAsync(u67, u109);
                end) and u35.Status == Enum.PathStatus.Success;

                if v112 then
                    v110 = true;
                else
                    p68.failed[math.floor(u109.X / 4) .. "," .. math.floor(u109.Y / 4) .. "," .. math.floor(u109.Z / 4)] = true;
                    v110 = false;
                end;
            end;

            if v110 then
                v107 = v98[v108];
                v106 = v108 + 1;
            else
                v105 = v108 - 1;
            end;
        end;

        return v107;
    end;

    local function stepFallback(p113, p114) -- Line: 360
        -- upvalues: u32 (ref), u6 (copy), u11 (ref), u12 (ref), u7 (copy), u8 (copy), u34 (ref), u33 (ref), SimplePath (ref), chooseSpot (copy), u9 (ref)
        local v115 = u32;
        local Position = u6.HumanoidRootPart.Position;
        local v116 = (p113 - u32.goal).Magnitude >= 6;

        if p114 - u32.lastTry >= 2 or v116 and p114 - u32.lastTry >= 0.5 then
            u32.lastTry = p114;
            u32.goal = p113;
            u11 = p113;
            u12 = p114;
            local v117 = u7;
            v117.pathComputes = v117.pathComputes + 1;

            if u8:Run(p113) then
                u34 = p113;
                u32 = nil;
                u33 = 0;

                return;
            end;

            if u32 ~= v115 then
                return;
            end;

            if v116 then
                u32.spot = nil;
                u32.lastSelect = 0;
                u32.failed = {};
            end;
        end;

        if u32.spot then
            local v118 = u32.spot - Position;

            if Vector3.new(v118.X, 0, v118.Z).Magnitude >= 3 and (p114 - u32.spotSetAt < 8 and u8.Status == SimplePath.StatusType.Active) then
                return;
            end;
        end;

        if p114 - u32.lastSelect < 3 then
            return;
        end;

        u32.lastSelect = p114;
        local v119 = chooseSpot(p113, Position, v115);

        if u32 ~= v115 then
            return;
        end;

        if not v119 then
            u32.spot = nil;
            u9 = false;
            u11 = nil;

            if u8.Status == SimplePath.StatusType.Active then
                pcall(function() -- Line: 172
                    -- upvalues: u8 (ref)
                    u8:Stop();
                end);
            end;

            return;
        end;

        u32.spot = v119;
        u32.spotSetAt = p114;
        u11 = v119;
        u12 = p114;
        local v120 = u7;
        v120.pathComputes = v120.pathComputes + 1;
        u8:Run(v119);
    end;

    local u121 = 0;

    function u7.WalkTo(u122, p123) -- Line: 407
        -- upvalues: u10 (ref), u18 (ref), u32 (ref), u12 (ref), u11 (ref), u8 (copy), SimplePath (ref), u9 (ref), u17 (ref), stepFallback (copy), u7 (copy), u33 (ref), u34 (ref), u121 (ref), u36 (ref), u6 (copy)
        if u10 then
            return;
        end;

        if not u122 then
            return;
        end;

        if p123 then
            if u18 then
                return;
            end;

            local os_clock_ret = os.clock();

            if not u32 then
                local v124 = os_clock_ret - u12;

                if u11 then
                    if v124 < 0.5 then
                        return;
                    end;

                    local Magnitude = (u122 - u11).Magnitude;

                    if u8.Status == SimplePath.StatusType.Active then
                        if Magnitude < 1.5 then
                            return;
                        end;

                        if Magnitude < 6 and v124 < 1 then
                            return;
                        end;
                    end;
                end;

                u9 = true;
                u11 = u122;
                u12 = os_clock_ret;
            end;

            u18 = true;
            local u125 = u17;
            task.spawn(function() -- Line: 433
                -- upvalues: u32 (ref), stepFallback (ref), u122 (copy), os_clock_ret (copy), u7 (ref), u8 (ref), u33 (ref), u34 (ref), SimplePath (ref), u18 (ref), u121 (ref), u125 (copy), u17 (ref), u10 (ref)
                local success, result = pcall(function() -- Line: 434
                    -- upvalues: u32 (ref), stepFallback (ref), u122 (ref), os_clock_ret (ref), u7 (ref), u8 (ref), u33 (ref), u34 (ref), SimplePath (ref)
                    if u32 then
                        stepFallback(u122, os_clock_ret);

                        return;
                    end;

                    local v126 = u7;
                    v126.pathComputes = v126.pathComputes + 1;

                    if not u8:Run(u122) then
                        if u8.LastError == SimplePath.ErrorType.ComputationError then
                            u33 = u33 + 1;

                            if u33 >= 2 then
                                u32 = {
                                    lastSelect = 0,
                                    spot = nil,
                                    spotSetAt = 0,
                                    goal = u122,
                                    lastTry = os_clock_ret,
                                    failed = {}
                                };
                                stepFallback(u122, os_clock_ret);
                            end;
                        end;

                        return;
                    end;

                    u33 = 0;
                    u34 = u122;
                end);
                u18 = false;

                if not success and os.clock() - u121 > 10 then
                    u121 = os.clock();
                    warn("[NPCSEARCH5] path compute error: " .. tostring(result));
                end;

                if u125 ~= u17 and (not u10 and u8.Status == SimplePath.StatusType.Active) then
                    pcall(function() -- Line: 460
                        -- upvalues: u8 (ref)
                        u8:Stop();
                    end);
                end;
            end);

            return;
        end;

        u17 = u17 + 1;

        if u36 then
            u36();
        end;

        u9 = false;
        u11 = nil;

        if u8.Status == SimplePath.StatusType.Active then
            pcall(function() -- Line: 172
                -- upvalues: u8 (ref)
                u8:Stop();
            end);
        end;

        u32 = nil;
        u33 = 0;
        u6.Humanoid:MoveTo(u122);
    end;

    u36 = function() -- Line: 471
        -- upvalues: u19 (ref), u6 (copy)
        local v127 = u19;

        if not v127 then
            return;
        end;

        u19 = nil;

        if v127.speed and u6.Humanoid.WalkSpeed == v127.speed then
            u6.Humanoid.WalkSpeed = v127.savedSpeed;
            u6.setTrack(u6.tracks.sprint, false);
        end;
    end;

    function u7.GoTo(u128, p129) -- Line: 480
        -- upvalues: u10 (ref), u7 (copy), u6 (copy), u19 (ref), u18 (ref), u8 (copy), SimplePath (ref)
        if u10 or not u128 then
            return;
        end;

        u7.StopMoving();
        local u130 = {
            status = "computing",
            goal = u128,
            at = os.clock()
        };
        local Position = u6.HumanoidRootPart.Position;
        u130.checkAt = u130.at;
        u130.checkPos = Position;

        if p129 then
            u130.savedSpeed = u6.Humanoid.WalkSpeed;
            u130.speed = p129;
        end;

        u19 = u130;
        task.spawn(function() -- Line: 487
            -- upvalues: u18 (ref), u19 (ref), u130 (copy), u10 (ref), u7 (ref), u8 (ref), u128 (copy), SimplePath (ref), u6 (ref)
            local os_clock_ret = os.clock();

            while u18 and os.clock() - os_clock_ret < 1.5 do
                task.wait(0.05);
            end;

            if u19 ~= u130 or u10 then
                return;
            end;

            if u18 then
                u130.status = "failed";

                return;
            end;

            u18 = true;

            while true do
                local v131 = u7;
                v131.pathComputes = v131.pathComputes + 1;
                local success, result = pcall(function() -- Line: 496
                    -- upvalues: u8 (ref), u128 (ref)
                    return u8:Run(u128);
                end);
                local v132 = success and not result and u8.LastError == SimplePath.ErrorType.LimitReached;

                if v132 then
                    local v133 = u7;
                    v133.pathComputes = v133.pathComputes - 1;
                    task.wait(0.1);
                end;

                if not (v132 and (u19 == u130 and (not u10 and os.clock() - u130.at <= 1.5))) then
                    u18 = false;

                    if u19 == u130 and (not u10 and u130.status == "computing") then
                        if success and result then
                            u130.status = "moving";
                            local os_clock_ret2 = os.clock();
                            local Position2 = u6.HumanoidRootPart.Position;
                            u130.checkAt = os_clock_ret2;
                            u130.checkPos = Position2;

                            if u130.speed then
                                u6.Humanoid.WalkSpeed = u130.speed;
                                u6.setTrack(u6.tracks.sprint, true);

                                return;
                            end;
                        else
                            u130.status = "failed";
                        end;

                        return;
                    end;

                    if not u10 and u8.Status == SimplePath.StatusType.Active then
                        pcall(function() -- Line: 509
                            -- upvalues: u8 (ref)
                            u8:Stop();
                        end);
                    end;

                    return;
                end;
            end;
        end);
    end;

    function u7.GoToStatus() -- Line: 524
        -- upvalues: u19 (ref), u6 (copy), u8 (copy), SimplePath (ref), u36 (ref), u9 (ref), u11 (ref)
        local v134 = u19;

        if not v134 then
            return "none";
        end;

        local os_clock_ret = os.clock();

        if v134.status == "computing" and os_clock_ret - v134.at > 1.5 then
            v134.status = "failed";
        elseif v134.status == "moving" then
            local Position = u6.HumanoidRootPart.Position;
            local v135 = v134.goal - Position;

            if Vector3.new(v135.X, 0, v135.Z).Magnitude <= 4 then
                v134.status = "arrived";
            elseif u8.Status == SimplePath.StatusType.Active then
                if os_clock_ret - v134.checkAt >= 3 then
                    local v136 = Position - v134.checkPos;

                    if Vector3.new(v136.X, 0, v136.Z).Magnitude < 1 then
                        v134.status = "failed";
                    end;

                    v134.checkAt = os_clock_ret;
                    v134.checkPos = Position;
                end;
            else
                local v137 = v134.goal - Position;
                v134.status = Vector3.new(v137.X, 0, v137.Z).Magnitude <= 8 and "arrived" or "failed";
            end;
        end;

        local status = v134.status;

        if v134.goal and (status == "arrived" or status == "failed") then
            u36();

            if status == "failed" then
                u9 = false;
                u11 = nil;

                if u8.Status == SimplePath.StatusType.Active then
                    pcall(function() -- Line: 172
                        -- upvalues: u8 (ref)
                        u8:Stop();
                    end);
                end;
            end;

            u19 = {
                status = status
            };
        end;

        return status;
    end;

    function u7.Retreat(p138) -- Line: 555
        -- upvalues: u6 (copy), u13 (ref), u14 (ref), u16 (ref), u7 (copy), u15 (ref), u3 (ref), clearDistance (copy), nearestOtherNpc (copy), u17 (ref), u36 (ref), u9 (ref), u11 (ref), u8 (copy), SimplePath (ref), u32 (ref), u33 (ref)
        local os_clock_ret = os.clock();
        local Position = u6.HumanoidRootPart.Position;

        if u13 and os_clock_ret - u14 > 2 then
            u13 = nil;
        end;

        if os_clock_ret < u16 then
            if u13 then
                u7.StopMoving();
            end;

            return false;
        end;

        if u13 then
            local v139;

            if os_clock_ret - u14 >= 0.75 then
                local v140 = Position - u15;
                v139 = Vector3.new(v140.X, 0, v140.Z).Magnitude < 0.5;
            else
                v139 = false;
            end;

            if v139 then
                u7.StopMoving();
                u16 = os_clock_ret + 1.5;

                return false;
            end;

            local v141 = u13 - Position;

            if Vector3.new(v141.X, 0, v141.Z).Magnitude > 2 and os_clock_ret - u14 < 1 then
                return true;
            end;
        end;

        local v142 = Position - p138;
        local Vector3_new_ret = Vector3.new(v142.X, 0, v142.Z);

        if Vector3_new_ret.Magnitude < 0.01 then
            local LookVector = u6.HumanoidRootPart.CFrame.LookVector;
            Vector3_new_ret = -Vector3.new(LookVector.X, 0, LookVector.Z);
        end;

        local Unit = (Vector3_new_ret.Magnitude < 0.01 and Vector3.new(0, 0, 1) or Vector3_new_ret).Unit;

        for _, v in ipairs(u3) do
            local v143 = CFrame.Angles(0, math.rad(v), 0):VectorToWorldSpace(Unit);
            local v144 = clearDistance(Position, v143, 15);
            local v145 = Position + v143 * (v144 - 1.5);

            if v144 >= 4 then
                local _, v146 = nearestOtherNpc(v145);

                if v146 >= 4 then
                    u13 = v145;
                    u14 = os_clock_ret;
                    u15 = Position;
                    u17 = u17 + 1;

                    if u36 then
                        u36();
                    end;

                    u9 = false;
                    u11 = nil;

                    if u8.Status == SimplePath.StatusType.Active then
                        pcall(function() -- Line: 172
                            -- upvalues: u8 (ref)
                            u8:Stop();
                        end);
                    end;

                    u32 = nil;
                    u33 = 0;
                    u6.Humanoid:MoveTo(u13);

                    return true;
                end;
            end;
        end;

        u7.StopMoving();
        u16 = os_clock_ret + 1.5;

        return false;
    end;

    function u7.ClearSpotAway(p147, p148) -- Line: 600
        -- upvalues: u6 (copy), u3 (ref), RaycastParams_new_ret (copy), nearestOtherNpc (copy)
        local Position = u6.HumanoidRootPart.Position;
        local v149 = Position - p147;
        local Vector3_new_ret = Vector3.new(v149.X, 0, v149.Z);

        if Vector3_new_ret.Magnitude < 0.01 then
            local LookVector = u6.HumanoidRootPart.CFrame.LookVector;
            Vector3_new_ret = -Vector3.new(LookVector.X, 0, LookVector.Z);
        end;

        if Vector3_new_ret.Magnitude < 0.01 then
            return nil;
        end;

        local Unit = Vector3_new_ret.Unit;

        for _, v in ipairs(u3) do
            local v150 = CFrame.Angles(0, math.rad(v), 0):VectorToWorldSpace(Unit);
            local v151 = workspace:Raycast(Position, v150 * p148, RaycastParams_new_ret);
            local v152;

            if v151 then
                v152 = (v151.Position - Position).Magnitude or p148;
            else
                v152 = p148;
            end;

            local v153 = 0;

            for i = 5, v152, 5 do
                if not workspace:Raycast(Position + v150 * i, Vector3.new(0, -7, 0), RaycastParams_new_ret) then
                    break;
                end;

                v153 = i;
                local v154 = v153;
                local v155 = v153;
                v153 = v154;
                v155 = v154;
            end;

            if v153 >= 4 then
                local v156 = Position + v150 * math.max(v153 - 1.5, 0);
                local _, v157 = nearestOtherNpc(v156);

                if v157 >= 4 then
                    return v156;
                end;
            end;
        end;

        return nil;
    end;

    function u7.IsCrowded(p158) -- Line: 161
        -- upvalues: nearestOtherNpc (copy)
        local _, v159 = nearestOtherNpc(p158);

        return v159 < 4;
    end;

    local u160 = 0;

    function u7.MakeRoom() -- Line: 629
        -- upvalues: u160 (ref), u6 (copy), nearestOtherNpc (copy), clearDistance (copy), u17 (ref), u36 (ref), u9 (ref), u11 (ref), u8 (copy), SimplePath (ref), u32 (ref), u33 (ref)
        local os_clock_ret = os.clock();

        if os_clock_ret - u160 < 1.5 then
            return false;
        end;

        local Position = u6.HumanoidRootPart.Position;
        local v161, v162 = nearestOtherNpc(Position);

        if not v161 or v162 >= 3 then
            return false;
        end;

        u160 = os_clock_ret;
        local v163 = Position - v161.HumanoidRootPart.Position;
        local Vector3_new_ret = Vector3.new(v163.X, 0, v163.Z);

        if Vector3_new_ret.Magnitude < 0.01 then
            local RightVector = u6.HumanoidRootPart.CFrame.RightVector;
            Vector3_new_ret = Vector3.new(RightVector.X, 0, RightVector.Z);
        end;

        if Vector3_new_ret.Magnitude < 0.01 then
            return false;
        end;

        local Unit = Vector3_new_ret.Unit;
        local v164 = clearDistance(Position, Unit, 4);

        if v164 < 2 then
            return false;
        end;

        u17 = u17 + 1;

        if u36 then
            u36();
        end;

        u9 = false;
        u11 = nil;

        if u8.Status == SimplePath.StatusType.Active then
            pcall(function() -- Line: 172
                -- upvalues: u8 (ref)
                u8:Stop();
            end);
        end;

        u32 = nil;
        u33 = 0;
        u6.Humanoid:MoveTo(Position + Unit * v164);

        return true;
    end;

    function u7.CheckLOSFromPosition(p165, p166) -- Line: 646
        -- upvalues: u6 (copy), NpcSight (ref)
        local RaycastParams_new_ret3 = RaycastParams.new();
        RaycastParams_new_ret3.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret3.FilterDescendantsInstances = { u6.CharacterAsset };

        if u6.CharacterAsset.Target.Value then
            RaycastParams_new_ret3.FilterDescendantsInstances = { u6.CharacterAsset, u6.CharacterAsset.Target.Value };
        end;

        local v167 = p166 - p165;

        return NpcSight.Cast(p165, v167.Unit * v167.Magnitude, RaycastParams_new_ret3) == nil;
    end;

    function u7.GetDistToTarget() -- Line: 660
        -- upvalues: u6 (copy)
        local Value = u6.CharacterAsset.Target.Value;

        return not (Value and Value:FindFirstChild("HumanoidRootPart")) and (1 / 0) or (Value.HumanoidRootPart.Position - u6.HumanoidRootPart.Position).Magnitude;
    end;

    function u7.Strafe() -- Line: 668
        -- upvalues: u6 (copy), clearDistance (copy), nearestOtherNpc (copy), u7 (copy), u17 (ref), u36 (ref), u9 (ref), u11 (ref), u8 (copy), SimplePath (ref), u32 (ref), u33 (ref)
        local Value = u6.CharacterAsset.Target.Value;

        if not (Value and Value:FindFirstChild("HumanoidRootPart")) then
            return;
        end;

        local v168 = { u6.HumanoidRootPart.CFrame.RightVector, -u6.HumanoidRootPart.CFrame.RightVector };

        if math.random(2) == 1 then
            local v169 = v168[1];
            v168[1] = v168[2];
            v168[2] = v169;
        end;

        local Position = u6.HumanoidRootPart.Position;
        local Position2 = Value.HumanoidRootPart.Position;

        for _, v in ipairs(v168) do
            local Vector3_new_ret = Vector3.new(v.X, 0, v.Z);

            if Vector3_new_ret.Magnitude >= 0.01 then
                local Unit = Vector3_new_ret.Unit;
                local v170 = clearDistance(Position, Unit, 8);

                if v170 >= 4 then
                    local v171 = Position + Unit * v170;
                    local _, v172 = nearestOtherNpc(v171);

                    if v172 >= 4 and u7.CheckLOSFromPosition(v171 + Vector3.new(0, 2, 0), Position2) then
                        u17 = u17 + 1;

                        if u36 then
                            u36();
                        end;

                        u9 = false;
                        u11 = nil;

                        if u8.Status == SimplePath.StatusType.Active then
                            pcall(function() -- Line: 172
                                -- upvalues: u8 (ref)
                                u8:Stop();
                            end);
                        end;

                        u32 = nil;
                        u33 = 0;
                        u6.Humanoid:MoveTo(v171);

                        return;
                    end;
                end;
            end;
        end;
    end;

    function u7.FindNearestTarget(p173, u174, u175) -- Line: 703
        -- upvalues: npcConfig (copy), u6 (copy), NpcThreat (ref), MutantCombatOn (ref), NpcMutants (ref)
        local u176 = nil;
        local MaximumMagnitude = npcConfig.MaximumMagnitude;
        local v177 = (npcConfig.AllyTag or "") == "LONER_FACTION" and true or u6.CharacterAsset:GetAttribute("PassiveToPlayers") == true;
        local Value = u6.CharacterAsset.Target.Value;
        local u178 = (1 / 0);

        local function consider(p179, p180, p181) -- Line: 730
            -- upvalues: MaximumMagnitude (copy), Value (copy), NpcThreat (ref), u178 (ref), u175 (copy), u176 (ref)
            if MaximumMagnitude <= p180 then
                return;
            end;

            p181.current = p179 == Value;
            local v182 = NpcThreat.Effective(p180, p181);

            if v182 and (v182 < u178 and (p181.current or (not u175 or u175(p179)))) then
                u176 = p179;
                u178 = v182;
            end;
        end;

        local function checkCandidate(p183) -- Line: 741
            -- upvalues: u6 (ref), u174 (copy), MaximumMagnitude (copy), Value (copy), NpcThreat (ref), u178 (ref), u175 (copy), u176 (ref)
            if p183:FindFirstChild("HumanoidRootPart") and (p183:FindFirstChild("Humanoid") and (p183.Humanoid.Health > 0 and (p183 ~= u6.CharacterAsset and not u174(p183)))) then
                local Magnitude = (p183.HumanoidRootPart.Position - u6.HumanoidRootPart.Position).Magnitude;
                local v184 = {
                    kind = "human"
                };

                if MaximumMagnitude <= Magnitude then
                    return;
                end;

                v184.current = p183 == Value;
                local v185 = NpcThreat.Effective(Magnitude, v184);

                if v185 and (v185 < u178 and (v184.current or (not u175 or u175(p183)))) then
                    u176 = p183;
                    u178 = v185;
                end;
            end;
        end;

        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and (v:GetAttribute("AdminIgnore") ~= true and (not v177 or v.Character == Value)) then
                checkCandidate(v.Character);
            end;
        end;

        if p173 then
            for _, child in pairs(workspace.PlayerCharacters.NPCs:GetChildren()) do
                checkCandidate(child);
            end;

            for _, child in pairs(workspace.PlayerCharacters.HostileNPCs:GetChildren()) do
                checkCandidate(child);
            end;
        end;

        if MutantCombatOn() then
            local Position = u6.HumanoidRootPart.Position;

            for _, v in ipairs(NpcMutants.Live()) do
                if v.hrp.Parent and v.hum.Health > 0 then
                    local Magnitude = (v.hrp.Position - Position).Magnitude;

                    if Magnitude <= NpcThreat.MUTANT_RANGE then
                        local model = v.model;
                        local v186 = {
                            kind = "mutant",
                            aggro = v.model:GetAttribute("Aggro") == true
                        };

                        if MaximumMagnitude > Magnitude then
                            v186.current = model == Value;
                            local v187 = NpcThreat.Effective(Magnitude, v186);

                            if v187 and (v187 < u178 and (v186.current or (not u175 or u175(model)))) then
                                u176 = model;
                                u178 = v187;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        return u176;
    end;

    function u7.Release() -- Line: 789
        -- upvalues: u10 (ref), u7 (copy), u9 (ref), u11 (ref), u32 (ref), u33 (ref), u8 (copy), u35 (copy)
        if u10 then
            return;
        end;

        u10 = true;
        pcall(u7.StopSprint);
        u9 = false;
        u11 = nil;
        u32 = nil;
        u33 = 0;
        pcall(function() -- Line: 796
            -- upvalues: u8 (ref)
            u8:Destroy();
        end);
        pcall(function() -- Line: 797
            -- upvalues: u35 (ref)
            u35:Destroy();
        end);
    end;

    u7.IdealMinRange = npcConfig.IdealMinRange;
    u7.IdealMaxRange = npcConfig.IdealMaxRange;
    u7.TooCloseRange = npcConfig.TooCloseRange;

    return u7;
end;

return v1;