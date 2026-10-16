-- Decompiled with Potassium's decompiler.

require(script.Parent.TypeDefinitions);
local TypeMarshaller = require(script.Parent.TypeMarshaller);
local u1 = {};
u1.__index = u1;
u1.__type = "ActiveCast";
local RunService = game:GetService("RunService");
local Table = require(script.Parent.Table);
local u2 = nil;

local function GetFastCastVisualizationContainer() -- Line: 61
    local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects");

    if FastCastVisualizationObjects ~= nil then
        return FastCastVisualizationObjects;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "FastCastVisualizationObjects";
    Folder.Archivable = false;
    Folder.Parent = workspace.Terrain;

    return Folder;
end;

local function PrintDebug(p3: string) -- Line: 79
    -- upvalues: u2 (ref)
    if u2.DebugLogging == true then
        print(p3);
    end;
end;

function DbgVisualizeSegment(p4, p5: number)
    -- upvalues: u2 (ref)
    if u2.VisualizeCasts ~= true then
        return nil;
    end;

    local ConeHandleAdornment = Instance.new("ConeHandleAdornment");
    ConeHandleAdornment.Adornee = workspace.Terrain;
    ConeHandleAdornment.CFrame = p4;
    ConeHandleAdornment.Height = p5;
    ConeHandleAdornment.Color3 = Color3.new();
    ConeHandleAdornment.Radius = 0.25;
    ConeHandleAdornment.Transparency = 0.5;
    local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects");

    if FastCastVisualizationObjects == nil then
        FastCastVisualizationObjects = Instance.new("Folder");
        FastCastVisualizationObjects.Name = "FastCastVisualizationObjects";
        FastCastVisualizationObjects.Archivable = false;
        FastCastVisualizationObjects.Parent = workspace.Terrain;
    end;

    ConeHandleAdornment.Parent = FastCastVisualizationObjects;

    return ConeHandleAdornment;
end;

function DbgVisualizeHit(p6, p7: boolean)
    -- upvalues: u2 (ref)
    if u2.VisualizeCasts ~= true then
        return nil;
    end;

    local SphereHandleAdornment = Instance.new("SphereHandleAdornment");
    SphereHandleAdornment.Adornee = workspace.Terrain;
    SphereHandleAdornment.CFrame = p6;
    SphereHandleAdornment.Radius = 0.4;
    SphereHandleAdornment.Transparency = 0.25;
    SphereHandleAdornment.Color3 = p7 == false and Color3.new(0.2, 1, 0.5) or Color3.new(1, 0.2, 0.2);
    local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects");

    if FastCastVisualizationObjects == nil then
        FastCastVisualizationObjects = Instance.new("Folder");
        FastCastVisualizationObjects.Name = "FastCastVisualizationObjects";
        FastCastVisualizationObjects.Archivable = false;
        FastCastVisualizationObjects.Parent = workspace.Terrain;
    end;

    SphereHandleAdornment.Parent = FastCastVisualizationObjects;

    return SphereHandleAdornment;
end;

local function GetPositionAtTime(p8: number, p9: vector, p10: vector, p11: vector) -- Line: 120
    local Vector3_new_ret = Vector3.new(p11.X * p8 ^ 2 / 2, p11.Y * p8 ^ 2 / 2, p11.Z * p8 ^ 2 / 2);

    return p9 + p10 * p8 + Vector3_new_ret;
end;

local function GetVelocityAtTime(p12: number, p13: vector, p14: vector) -- Line: 126
    return p13 + p14 * p12;
end;

local function GetTrajectoryInfo(p15: any, p16: number) -- Line: 130
    assert(p15.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    local v17 = p15.StateInfo.Trajectories[p16];
    local v18 = v17.EndTime - v17.StartTime;
    local Origin = v17.Origin;
    local InitialVelocity = v17.InitialVelocity;
    local Acceleration = v17.Acceleration;
    local v19 = {};
    local Vector3_new_ret = Vector3.new(Acceleration.X * v18 ^ 2 / 2, Acceleration.Y * v18 ^ 2 / 2, Acceleration.Z * v18 ^ 2 / 2);
    v19[1], v19[2] = Origin + InitialVelocity * v18 + Vector3_new_ret, InitialVelocity + Acceleration * v18;

    return v19;
end;

local function GetLatestTrajectoryEndInfo(p20) -- Line: 143
    -- upvalues: GetTrajectoryInfo (copy)
    assert(p20.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");

    return GetTrajectoryInfo(p20, #p20.StateInfo.Trajectories);
end;

local function CloneCastParams(p21: userdata) -- Line: 148
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.CollisionGroup = p21.CollisionGroup;
    RaycastParams_new_ret.FilterType = p21.FilterType;
    RaycastParams_new_ret.FilterDescendantsInstances = p21.FilterDescendantsInstances;
    RaycastParams_new_ret.IgnoreWater = p21.IgnoreWater;

    return RaycastParams_new_ret;
end;

local function SendRayHit(p22: any, p23, p24: vector, p25: userdata?) -- Line: 157
    p22.Caster.RayHit:Fire(p22, p23, p24, p25);
end;

local function SendRayPierced(p26: any, p27, p28: vector, p29: userdata?) -- Line: 162
    p26.Caster.RayPierced:Fire(p26, p27, p28, p29);
end;

local function SendLengthChanged(p30: any, p31: vector, p32: vector, p33: number, p34: vector, p35: userdata?) -- Line: 167
    p30.Caster.LengthChanged:Fire(p30, p31, p32, p33, p34, p35);
end;

local function SimulateCast(p36: any, p37: number, p38: boolean) -- Line: 173
    -- upvalues: u2 (ref), Table (copy)
    assert(p36.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");

    if u2.DebugLogging == true then
        print("Casting for frame.");
    end;

    local v39 = p36.StateInfo.Trajectories[#p36.StateInfo.Trajectories];
    local Origin = v39.Origin;
    local v40 = p36.StateInfo.TotalRuntime - v39.StartTime;
    local InitialVelocity = v39.InitialVelocity;
    local Acceleration = v39.Acceleration;
    local Vector3_new_ret = Vector3.new(Acceleration.X * v40 ^ 2 / 2, Acceleration.Y * v40 ^ 2 / 2, Acceleration.Z * v40 ^ 2 / 2);
    local v41 = Origin + InitialVelocity * v40 + Vector3_new_ret;
    local _ = InitialVelocity + Acceleration * v40;
    local v42 = p36.StateInfo.TotalRuntime - v39.StartTime;
    local StateInfo = p36.StateInfo;
    StateInfo.TotalRuntime = StateInfo.TotalRuntime + p37;
    local v43 = p36.StateInfo.TotalRuntime - v39.StartTime;
    local Vector3_new_ret2 = Vector3.new(Acceleration.X * v43 ^ 2 / 2, Acceleration.Y * v43 ^ 2 / 2, Acceleration.Z * v43 ^ 2 / 2);
    local v44 = Origin + InitialVelocity * v43 + Vector3_new_ret2;
    local v45 = InitialVelocity + Acceleration * v43;
    local v46 = (v44 - v41).Unit * v45.Magnitude * p37;
    local WorldRoot = p36.RayInfo.WorldRoot;
    local v47 = WorldRoot:Raycast(v41, v46, p36.RayInfo.Parameters);
    local _ = Enum.Material.Air;
    Vector3.new();
    local v48, v49;

    if v47 == nil then
        v48 = v44;
        v49 = nil;
    else
        v48 = v47.Position;
        v49 = v47.Instance;
        local _ = v47.Material;
        local _ = v47.Normal;
    end;

    local Magnitude = (v48 - v41).Magnitude;
    p36.Caster.LengthChanged:Fire(p36, v41, v46.Unit, Magnitude, v45, p36.RayInfo.CosmeticBulletObject);
    local StateInfo2 = p36.StateInfo;
    StateInfo2.DistanceCovered = StateInfo2.DistanceCovered + Magnitude;
    local v50;

    if p37 > 0 then
        v50 = DbgVisualizeSegment(CFrame.new(v41, v41 + v46), Magnitude);
    else
        v50 = nil;
    end;

    if v49 and v49 ~= p36.RayInfo.CosmeticBulletObject then
        tick();

        if u2.DebugLogging == true then
            print("Hit something, testing now.");
        end;

        if p36.RayInfo.CanPierceCallback ~= nil then
            if p38 == false and p36.StateInfo.IsActivelySimulatingPierce then
                p36:Terminate();
                error("ERROR: The latest call to CanPierceCallback took too long to complete! This cast is going to suffer desyncs which WILL cause unexpected behavior and errors. Please fix your performance problems, or remove statements that yield (e.g. wait() calls)");
            end;

            p36.StateInfo.IsActivelySimulatingPierce = true;
        end;

        if p36.RayInfo.CanPierceCallback == nil or p36.RayInfo.CanPierceCallback ~= nil and p36.RayInfo.CanPierceCallback(p36, v47, v45, p36.RayInfo.CosmeticBulletObject) == false then
            if u2.DebugLogging == true then
                print("Piercing function is nil or it returned FALSE to not pierce this hit.");
            end;

            p36.StateInfo.IsActivelySimulatingPierce = false;

            if p36.StateInfo.HighFidelityBehavior == 2 and (v39.Acceleration ~= Vector3.new() and p36.StateInfo.HighFidelitySegmentSize ~= 0) then
                p36.StateInfo.CancelHighResCast = false;

                if p36.StateInfo.IsActivelyResimulating then
                    p36:Terminate();
                    error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.");
                end;

                p36.StateInfo.IsActivelyResimulating = true;

                if u2.DebugLogging == true then
                    print("Hit was registered, but recalculation is on for physics based casts. Recalculating to verify a real hit...");
                end;

                local math_floor_ret = math.floor(Magnitude / p36.StateInfo.HighFidelitySegmentSize);
                local _ = Magnitude / math_floor_ret;
                local v51 = p37 / math_floor_ret;

                for i = 1, math_floor_ret do
                    if p36.StateInfo.CancelHighResCast then
                        p36.StateInfo.CancelHighResCast = false;
                        break;
                    end;

                    local v52 = v42 + v51 * i;
                    local Vector3_new_ret3 = Vector3.new(Acceleration.X * v52 ^ 2 / 2, Acceleration.Y * v52 ^ 2 / 2, Acceleration.Z * v52 ^ 2 / 2);
                    local v53 = Origin + InitialVelocity * v52 + Vector3_new_ret3;
                    local v54 = InitialVelocity + Acceleration * (v42 + v51 * i);
                    local v55 = WorldRoot:Raycast(v53, v54 * p37, p36.RayInfo.Parameters);
                    local Magnitude2 = (v53 - (v53 + v54)).Magnitude;
                    local v56;

                    if v55 == nil then
                        local v57 = DbgVisualizeSegment(CFrame.new(v53, v53 + v54), Magnitude2);

                        if v57 == nil then
                            v56 = i;
                        else
                            v57.Color3 = Color3.new(0.286275, 0.329412, 0.247059);
                            v56 = i;
                        end;
                    else
                        local Magnitude3 = (v53 - v55.Position).Magnitude;
                        local v58 = DbgVisualizeSegment(CFrame.new(v53, v53 + v54), Magnitude3);

                        if v58 ~= nil then
                            v58.Color3 = Color3.new(0.286275, 0.329412, 0.247059);
                        end;

                        if p36.RayInfo.CanPierceCallback == nil or p36.RayInfo.CanPierceCallback ~= nil and p36.RayInfo.CanPierceCallback(p36, v55, v54, p36.RayInfo.CosmeticBulletObject) == false then
                            p36.StateInfo.IsActivelyResimulating = false;
                            p36.Caster.RayHit:Fire(p36, v55, v54, p36.RayInfo.CosmeticBulletObject);
                            p36:Terminate();
                            local v59 = DbgVisualizeHit(CFrame.new(v48), false);

                            if v59 ~= nil then
                                v59.Color3 = Color3.new(0.0588235, 0.87451, 1);
                            end;

                            return;
                        end;

                        p36.Caster.RayPierced:Fire(p36, v55, v54, p36.RayInfo.CosmeticBulletObject);
                        local v60 = DbgVisualizeHit(CFrame.new(v48), true);

                        if v60 ~= nil then
                            v60.Color3 = Color3.new(1, 0.113725, 0.588235);
                        end;

                        if v58 == nil then
                            v56 = i;
                        else
                            v58.Color3 = Color3.new(0.305882, 0.243137, 0.329412);
                            v56 = i;
                        end;
                    end;
                end;

                p36.StateInfo.IsActivelyResimulating = false;
            else
                if p36.StateInfo.HighFidelityBehavior == 1 or p36.StateInfo.HighFidelityBehavior == 3 then
                    if u2.DebugLogging == true then
                        print("Hit was successful. Terminating.");
                    end;

                    p36.Caster.RayHit:Fire(p36, v47, v45, p36.RayInfo.CosmeticBulletObject);
                    p36:Terminate();
                    DbgVisualizeHit(CFrame.new(v48), false);

                    return;
                end;

                p36:Terminate();
                error("Invalid value " .. p36.StateInfo.HighFidelityBehavior .. " for HighFidelityBehavior.");
            end;
        else
            if u2.DebugLogging == true then
                print("Piercing function returned TRUE to pierce this part.");
            end;

            if v50 ~= nil then
                v50.Color3 = Color3.new(0.4, 0.05, 0.05);
            end;

            DbgVisualizeHit(CFrame.new(v48), true);
            local Parameters = p36.RayInfo.Parameters;
            local FilterDescendantsInstances = Parameters.FilterDescendantsInstances;
            local v61 = {};
            local v62 = false;
            local v63 = 0;

            while true do
                if Parameters.FilterType == Enum.RaycastFilterType.Blacklist then
                    local FilterDescendantsInstances2 = Parameters.FilterDescendantsInstances;
                    Table.insert(FilterDescendantsInstances2, v47.Instance);
                    Table.insert(v61, v47.Instance);
                    Parameters.FilterDescendantsInstances = FilterDescendantsInstances2;
                else
                    local FilterDescendantsInstances2 = Parameters.FilterDescendantsInstances;
                    Table.removeObject(FilterDescendantsInstances2, v47.Instance);
                    Table.insert(v61, v47.Instance);
                    Parameters.FilterDescendantsInstances = FilterDescendantsInstances2;
                end;

                p36.Caster.RayPierced:Fire(p36, v47, v45, p36.RayInfo.CosmeticBulletObject);
                v47 = WorldRoot:Raycast(v41, v46, Parameters);

                if v47 == nil then
                    break;
                end;

                if v63 >= 100 then
                    warn("WARNING: Exceeded maximum pierce test budget for a single ray segment (attempted to test the same segment " .. 100 .. " times!)");
                    break;
                end;

                v63 = v63 + 1;

                if p36.RayInfo.CanPierceCallback(p36, v47, v45, p36.RayInfo.CosmeticBulletObject) == false then
                    v62 = true;
                    break;
                end;
            end;

            p36.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances;
            p36.StateInfo.IsActivelySimulatingPierce = false;

            if v62 then
                local v64 = "Broke because the ray hit something solid (" .. tostring(v47.Instance) .. ") while testing for a pierce. Terminating the cast.";

                if u2.DebugLogging == true then
                    print(v64);
                end;

                p36.Caster.RayHit:Fire(p36, v47, v45, p36.RayInfo.CosmeticBulletObject);
                p36:Terminate();
                DbgVisualizeHit(CFrame.new(v47.Position), false);

                return;
            end;
        end;
    end;

    if p36.StateInfo.DistanceCovered >= p36.RayInfo.MaxDistance then
        p36:Terminate();
        DbgVisualizeHit(CFrame.new(v44), false);
    end;
end;

function u1.new(p65: any, p66: vector, p67: vector, p68: any, p69: any) -- Line: 422
    -- upvalues: TypeMarshaller (copy), Table (copy), RunService (copy), u1 (copy), u2 (ref), SimulateCast (copy)
    if TypeMarshaller(p68) == "number" then
        p68 = p67.Unit * p68;
    end;

    if p69.HighFidelitySegmentSize <= 0 then
        error("Cannot set FastCastBehavior.HighFidelitySegmentSize <= 0!", 0);
    end;

    local u70 = {
        Caster = p65,
        StateInfo = {
            UpdateConnection = nil,
            Paused = false,
            TotalRuntime = 0,
            DistanceCovered = 0,
            IsActivelySimulatingPierce = false,
            IsActivelyResimulating = false,
            CancelHighResCast = false,
            HighFidelitySegmentSize = p69.HighFidelitySegmentSize,
            HighFidelityBehavior = p69.HighFidelityBehavior,
            Trajectories = {
                {
                    StartTime = 0,
                    EndTime = -1,
                    Origin = p66,
                    InitialVelocity = p68,
                    Acceleration = p69.Acceleration
                }
            }
        },
        RayInfo = {
            Parameters = p69.RaycastParams,
            WorldRoot = workspace,
            MaxDistance = p69.MaxDistance or 1000,
            CosmeticBulletObject = p69.CosmeticBulletTemplate,
            CanPierceCallback = p69.CanPierceFunction
        },
        UserData = {}
    };

    if u70.StateInfo.HighFidelityBehavior == 2 then
        u70.StateInfo.HighFidelityBehavior = 3;
    end;

    if u70.RayInfo.Parameters == nil then
        u70.RayInfo.Parameters = RaycastParams.new();
    else
        local RayInfo = u70.RayInfo;
        local Parameters = u70.RayInfo.Parameters;
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.CollisionGroup = Parameters.CollisionGroup;
        RaycastParams_new_ret.FilterType = Parameters.FilterType;
        RaycastParams_new_ret.FilterDescendantsInstances = Parameters.FilterDescendantsInstances;
        RaycastParams_new_ret.IgnoreWater = Parameters.IgnoreWater;
        RayInfo.Parameters = RaycastParams_new_ret;
    end;

    local v71 = false;

    if p69.CosmeticBulletProvider == nil then
        if u70.RayInfo.CosmeticBulletObject ~= nil then
            u70.RayInfo.CosmeticBulletObject = u70.RayInfo.CosmeticBulletObject:Clone();
            u70.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(p66, p66 + p67);
            u70.RayInfo.CosmeticBulletObject.Parent = p69.CosmeticBulletContainer;
        end;
    elseif TypeMarshaller(p69.CosmeticBulletProvider) == "PartCache" then
        if u70.RayInfo.CosmeticBulletObject ~= nil then
            warn("Do not define FastCastBehavior.CosmeticBulletTemplate and FastCastBehavior.CosmeticBulletProvider at the same time! The provider will be used, and CosmeticBulletTemplate will be set to nil.");
            u70.RayInfo.CosmeticBulletObject = nil;
            p69.CosmeticBulletTemplate = nil;
        end;

        u70.RayInfo.CosmeticBulletObject = p69.CosmeticBulletProvider:GetPart();
        u70.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(p66, p66 + p67);
        v71 = true;
    else
        warn("FastCastBehavior.CosmeticBulletProvider was not an instance of the PartCache module (an external/separate model)! Are you inputting an instance created via PartCache.new? If so, are you on the latest version of PartCache? Setting FastCastBehavior.CosmeticBulletProvider to nil.");
        p69.CosmeticBulletProvider = nil;
    end;

    local v72;

    if v71 then
        v72 = p69.CosmeticBulletProvider.CurrentCacheParent;
    else
        v72 = p69.CosmeticBulletContainer;
    end;

    if p69.AutoIgnoreContainer == true and v72 ~= nil then
        local FilterDescendantsInstances = u70.RayInfo.Parameters.FilterDescendantsInstances;

        if Table.find(FilterDescendantsInstances, v72) == nil then
            Table.insert(FilterDescendantsInstances, v72);
            u70.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances;
        end;
    end;

    local v73;

    if RunService:IsClient() then
        v73 = RunService.RenderStepped;
    else
        v73 = RunService.Heartbeat;
    end;

    setmetatable(u70, u1);
    u70.StateInfo.UpdateConnection = v73:Connect(function(p74) -- Line: 535
        -- upvalues: u70 (copy), u2 (ref), SimulateCast (ref)
        if u70.StateInfo.Paused then
            return;
        end;

        if u2.DebugLogging == true then
            print("Casting for frame.");
        end;

        local v75 = u70.StateInfo.Trajectories[#u70.StateInfo.Trajectories];

        if u70.StateInfo.HighFidelityBehavior == 3 and (v75.Acceleration ~= Vector3.new() and u70.StateInfo.HighFidelitySegmentSize > 0) then
            local v76 = tick();

            if u70.StateInfo.IsActivelyResimulating then
                u70:Terminate();
                error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.");
            end;

            u70.StateInfo.IsActivelyResimulating = true;
            local Origin = v75.Origin;
            local v77 = u70.StateInfo.TotalRuntime - v75.StartTime;
            local InitialVelocity = v75.InitialVelocity;
            local Acceleration = v75.Acceleration;
            local Vector3_new_ret = Vector3.new(Acceleration.X * v77 ^ 2 / 2, Acceleration.Y * v77 ^ 2 / 2, Acceleration.Z * v77 ^ 2 / 2);
            local v78 = Origin + InitialVelocity * v77 + Vector3_new_ret;
            local _ = InitialVelocity + Acceleration * v77;
            local _ = u70.StateInfo.TotalRuntime - v75.StartTime;
            local StateInfo = u70.StateInfo;
            StateInfo.TotalRuntime = StateInfo.TotalRuntime + p74;
            local v79 = u70.StateInfo.TotalRuntime - v75.StartTime;
            local Vector3_new_ret2 = Vector3.new(Acceleration.X * v79 ^ 2 / 2, Acceleration.Y * v79 ^ 2 / 2, Acceleration.Z * v79 ^ 2 / 2);
            local v80 = Origin + InitialVelocity * v79 + Vector3_new_ret2;
            local v81 = u70.RayInfo.WorldRoot:Raycast(v78, (v80 - v78).Unit * (InitialVelocity + Acceleration * v79).Magnitude * p74, u70.RayInfo.Parameters);

            if v81 ~= nil then
                v80 = v81.Position;
            end;

            local Magnitude = (v80 - v78).Magnitude;
            local StateInfo2 = u70.StateInfo;
            StateInfo2.TotalRuntime = StateInfo2.TotalRuntime - p74;
            local math_floor_ret = math.floor(Magnitude / u70.StateInfo.HighFidelitySegmentSize);
            local v82 = math_floor_ret == 0 and 1 or math_floor_ret;
            local v83 = p74 / v82;

            for i = 1, v82 do
                if getmetatable(u70) == nil then
                    return;
                end;

                if u70.StateInfo.CancelHighResCast then
                    u70.StateInfo.CancelHighResCast = false;
                    break;
                end;

                local v84 = "[" .. i .. "] Subcast of time increment " .. v83;

                if u2.DebugLogging == true then
                    print(v84);
                end;

                SimulateCast(u70, v83, true);
                local _ = i;
            end;

            if getmetatable(u70) == nil then
                return;
            end;

            u70.StateInfo.IsActivelyResimulating = false;

            if tick() - v76 > 0.08 then
                warn("Extreme cast lag encountered! Consider increasing HighFidelitySegmentSize.");
            end;
        else
            SimulateCast(u70, p74, false);
        end;
    end);

    return u70;
end;

function u1.SetStaticFastCastReference(p85) -- Line: 619
    -- upvalues: u2 (ref)
    u2 = p85;
end;

local function ModifyTransformation(p86: any, p87: vector?, p88: vector?, p89: vector?) -- Line: 625
    -- upvalues: GetTrajectoryInfo (copy), Table (copy)
    local Trajectories = p86.StateInfo.Trajectories;
    local v90 = Trajectories[#Trajectories];

    if v90.StartTime == p86.StateInfo.TotalRuntime then
        if p87 == nil then
            p87 = v90.InitialVelocity;
        end;

        if p88 == nil then
            p88 = v90.Acceleration;
        end;

        if p89 == nil then
            p89 = v90.Origin;
        end;

        v90.Origin = p89;
        v90.InitialVelocity = p87;
        v90.Acceleration = p88;

        return;
    end;

    v90.EndTime = p86.StateInfo.TotalRuntime;
    assert(p86.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    local v91 = GetTrajectoryInfo(p86, #p86.StateInfo.Trajectories);
    local v92, v93 = unpack(v91);

    if p87 == nil then
        p87 = v93;
    end;

    if p88 == nil then
        p88 = v90.Acceleration;
    end;

    if p89 ~= nil then
        v92 = p89;
    end;

    Table.insert(p86.StateInfo.Trajectories, {
        EndTime = -1,
        StartTime = p86.StateInfo.TotalRuntime,
        Origin = v92,
        InitialVelocity = p87,
        Acceleration = p88
    });
    p86.StateInfo.CancelHighResCast = true;
end;

function u1.SetVelocity(p94: table, p95: vector) -- Line: 671
    -- upvalues: u1 (copy), ModifyTransformation (copy)
    local v96 = getmetatable(p94) == u1;
    assert(v96, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetVelocity", "ActiveCast.new(...)"));
    assert(p94.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    ModifyTransformation(p94, p95, nil, nil);
end;

function u1.SetAcceleration(p97: table, p98: vector) -- Line: 677
    -- upvalues: u1 (copy), ModifyTransformation (copy)
    local v99 = getmetatable(p97) == u1;
    assert(v99, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetAcceleration", "ActiveCast.new(...)"));
    assert(p97.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    ModifyTransformation(p97, nil, p98, nil);
end;

function u1.SetPosition(p100: table, p101: vector) -- Line: 683
    -- upvalues: u1 (copy), ModifyTransformation (copy)
    local v102 = getmetatable(p100) == u1;
    assert(v102, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetPosition", "ActiveCast.new(...)"));
    assert(p100.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    ModifyTransformation(p100, nil, nil, p101);
end;

function u1.GetVelocity(p103) -- Line: 689
    -- upvalues: u1 (copy)
    local v104 = getmetatable(p103) == u1;
    assert(v104, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetVelocity", "ActiveCast.new(...)"));
    assert(p103.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    local v105 = p103.StateInfo.Trajectories[#p103.StateInfo.Trajectories];

    return v105.InitialVelocity + v105.Acceleration * (p103.StateInfo.TotalRuntime - v105.StartTime);
end;

function u1.GetAcceleration(p106) -- Line: 696
    -- upvalues: u1 (copy)
    local v107 = getmetatable(p106) == u1;
    assert(v107, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetAcceleration", "ActiveCast.new(...)"));
    assert(p106.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");

    return p106.StateInfo.Trajectories[#p106.StateInfo.Trajectories].Acceleration;
end;

function u1.GetPosition(p108) -- Line: 703
    -- upvalues: u1 (copy)
    local v109 = getmetatable(p108) == u1;
    assert(v109, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPosition", "ActiveCast.new(...)"));
    assert(p108.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    local v110 = p108.StateInfo.Trajectories[#p108.StateInfo.Trajectories];
    local v111 = p108.StateInfo.TotalRuntime - v110.StartTime;
    local Origin = v110.Origin;
    local InitialVelocity = v110.InitialVelocity;
    local Acceleration = v110.Acceleration;
    local Vector3_new_ret = Vector3.new(Acceleration.X * v111 ^ 2 / 2, Acceleration.Y * v111 ^ 2 / 2, Acceleration.Z * v111 ^ 2 / 2);

    return Origin + InitialVelocity * v111 + Vector3_new_ret;
end;

function u1.AddVelocity(p112: table, p113: vector) -- Line: 712
    -- upvalues: u1 (copy)
    local v114 = getmetatable(p112) == u1;
    assert(v114, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("AddVelocity", "ActiveCast.new(...)"));
    assert(p112.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    p112:SetVelocity(p112:GetVelocity() + p113);
end;

function u1.AddAcceleration(p115: table, p116: vector) -- Line: 718
    -- upvalues: u1 (copy)
    local v117 = getmetatable(p115) == u1;
    assert(v117, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("AddAcceleration", "ActiveCast.new(...)"));
    assert(p115.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    p115:SetAcceleration(p115:GetAcceleration() + p116);
end;

function u1.AddPosition(p118: table, p119: vector) -- Line: 724
    -- upvalues: u1 (copy)
    local v120 = getmetatable(p118) == u1;
    assert(v120, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("AddPosition", "ActiveCast.new(...)"));
    assert(p118.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    p118:SetPosition(p118:GetPosition() + p119);
end;

function u1.Pause(p121) -- Line: 732
    -- upvalues: u1 (copy)
    local v122 = getmetatable(p121) == u1;
    assert(v122, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Pause", "ActiveCast.new(...)"));
    assert(p121.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    p121.StateInfo.Paused = true;
end;

function u1.Resume(p123) -- Line: 738
    -- upvalues: u1 (copy)
    local v124 = getmetatable(p123) == u1;
    assert(v124, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Resume", "ActiveCast.new(...)"));
    assert(p123.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    p123.StateInfo.Paused = false;
end;

function u1.Terminate(p125) -- Line: 744
    -- upvalues: u1 (copy)
    local v126 = getmetatable(p125) == u1;
    assert(v126, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Terminate", "ActiveCast.new(...)"));
    assert(p125.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.");
    local Trajectories = p125.StateInfo.Trajectories;
    Trajectories[#Trajectories].EndTime = p125.StateInfo.TotalRuntime;
    p125.StateInfo.UpdateConnection:Disconnect();
    p125.Caster.CastTerminating:FireSync(p125);
    p125.StateInfo.UpdateConnection = nil;
    p125.Caster = nil;
    p125.StateInfo = nil;
    p125.RayInfo = nil;
    p125.UserData = nil;
    setmetatable(p125, nil);
end;

return u1;