-- Decompiled with Potassium's decompiler.

local Heartbeat = game:GetService("RunService").Heartbeat;
local CollectionService = game:GetService("CollectionService");
local VisualizerCache = require(script.Parent.VisualizerCache);
local u1 = {};
local Solvers = script.Parent:WaitForChild("Solvers");
local u2 = {};
u2.__index = u2;
u2.__type = "RaycastHitbox";
u2.CastModes = {
    LinkAttachments = 1,
    Attachment = 2,
    Vector3 = 3,
    Bone = 4
};

function u2.HitStart(p3: table, p4: number?) -- Line: 54
    if p3.HitboxActive then
        p3:HitStop();
    end;

    if p4 then
        p3.HitboxStopTime = os.clock() + math.max(0.016666666666666666, p4);
    end;

    p3.HitboxActive = true;
end;

function u2.HitStop(p5) -- Line: 68
    p5.HitboxActive = false;
    p5.HitboxStopTime = 0;
    table.clear(p5.HitboxHitList);
end;

function u2.Destroy(p6) -- Line: 75
    -- upvalues: CollectionService (copy)
    p6.HitboxPendingRemoval = true;

    if p6.HitboxObject then
        CollectionService:RemoveTag(p6.HitboxObject, p6.Tag);
    end;

    p6:HitStop();
    p6.OnHit:Destroy();
    p6.OnUpdate:Destroy();
end;

function u2.Recalibrate(p7) -- Line: 88
    -- upvalues: u2 (copy)
    local Descendants = p7.HitboxObject:GetDescendants();
    local v8 = 0;

    for _, v in ipairs(Descendants) do
        if v:IsA("Attachment") and v.Name == "DmgPoint" then
            local v9 = p7:_CreatePoint(v:GetAttribute("Group"), u2.CastModes.Attachment, v.WorldPosition);
            table.insert(v9.Instances, v);
            table.insert(p7.HitboxRaycastPoints, v9);
            v8 = v8 + 1;
        end;
    end;

    if p7.DebugLog then
        print(string.format("%s%s", "[ Raycast Hitbox V4 ]\n", v8 > 0 and string.format("%s attachments found in object: %s.", v8, p7.HitboxObject.Name) or string.format("No attachments found in object: %s. Can be safely ignored if using SetPoints.", p7.HitboxObject.Name)));
    end;
end;

function u2.LinkAttachments(p10: table, p11: userdata, p12: userdata) -- Line: 117
    -- upvalues: u2 (copy)
    local v13 = p10:_CreatePoint(p11:GetAttribute("Group"), u2.CastModes.LinkAttachments);
    v13.Instances[1] = p11;
    v13.Instances[2] = p12;
    table.insert(p10.HitboxRaycastPoints, v13);
end;

function u2.UnlinkAttachments(p14: table, p15: userdata) -- Line: 128
    for i = #p14.HitboxRaycastPoints, 1, -1 do
        local v16;

        if #p14.HitboxRaycastPoints[i].Instances >= 2 and (p14.HitboxRaycastPoints[i].Instances[1] == p15 or p14.HitboxRaycastPoints[i].Instances[2] == p15) then
            table.remove(p14.HitboxRaycastPoints, i);
            v16 = i;
        else
            v16 = i;
        end;
    end;
end;

function u2.SetPoints(p17: table, p18: userdata, p19: table, p20: string?) -- Line: 142
    -- upvalues: u2 (copy)
    for _, v in ipairs(p19) do
        local v21 = p17:_CreatePoint(p20, u2.CastModes[p18:IsA("Bone") and "Bone" or "Vector3"]);
        v21.Instances[1] = p18;
        v21.Instances[2] = v;
        table.insert(p17.HitboxRaycastPoints, v21);
    end;
end;

function u2.RemovePoints(p22: table, p23: userdata, p24: table) -- Line: 155
    for i = #p22.HitboxRaycastPoints, 1, -1 do
        local v25;

        if p22.HitboxRaycastPoints[i].Instances[1] == p23 then
            local v26 = p22.HitboxRaycastPoints[i].Instances[2];
            v25 = i;

            for _, v in ipairs(p24) do
                if v == v26 then
                    table.remove(p22.HitboxRaycastPoints, v25);
                    break;
                end;
            end;
        else
            v25 = i;
        end;
    end;
end;

function u2._CreatePoint(p27: table, p28: string?, p29: number, p30: vector?) -- Line: 176
    return {
        WorldSpace = nil,
        Group = p28,
        CastMode = p29,
        LastPosition = p30,
        Instances = {}
    };
end;

function u2._FindHitbox(p31, p32) -- Line: 188
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1) do
        if v.HitboxObject == p32 then
            return v;
        end;
    end;
end;

function u2._Init(u33) -- Line: 198
    -- upvalues: u1 (copy), CollectionService (copy)
    if not u33.HitboxObject then
        return;
    end;

    local u34 = nil;

    local function onTagRemoved(p35: userdata) -- Line: 203
        -- upvalues: u33 (copy), u34 (ref)
        if p35 == u33.HitboxObject then
            u34:Disconnect();
            u33:Destroy();
        end;
    end;

    u33:Recalibrate();
    table.insert(u1, u33);
    CollectionService:AddTag(u33.HitboxObject, u33.Tag);
    u34 = CollectionService:GetInstanceRemovedSignal(u33.Tag):Connect(onTagRemoved);
end;

(function() -- Line: 217, Name: Init
    -- upvalues: Solvers (copy), Heartbeat (copy), u1 (copy), VisualizerCache (copy), u2 (copy)
    local table_create_ret = table.create(#Solvers:GetChildren());
    Heartbeat:Connect(function(p36: number) -- Line: 221
        -- upvalues: u1 (ref), table_create_ret (copy), VisualizerCache (ref)
        for i = #u1, 1, -1 do
            local v37;

            if u1[i].HitboxPendingRemoval then
                local table_remove_ret = table.remove(u1, i);
                setmetatable(table_remove_ret, nil);
                v37 = i;
            else
                v37 = i;

                for _, v in ipairs(u1[i].HitboxRaycastPoints) do
                    if u1[v37].HitboxActive then
                        local v38 = table_create_ret[v.CastMode];
                        local v39, v40 = v38:Solve(v);
                        local v41 = workspace:Raycast(v39, v40, u1[v37].RaycastParams);
                        local v42 = u1[v37].Visualizer and VisualizerCache:GetAdornment();

                        if v42 then
                            local v43 = v38:Visualize(v);
                            v42.Adornment.Length = v40.Magnitude;
                            v42.Adornment.CFrame = v43;
                        end;

                        v.LastPosition = v38:UpdateToNextPosition(v);

                        if v41 then
                            local Instance = v41.Instance;
                            local v44 = nil;
                            local v45;

                            if u1[v37].DetectionMode == 1 then
                                local v46 = Instance:FindFirstAncestorOfClass("Model");

                                if v46 then
                                    v44 = v46:FindFirstChildOfClass("Humanoid");
                                end;

                                v45 = v44;
                            else
                                v45 = v44;
                                v44 = Instance;
                            end;

                            if not v44 then
                                if u1[v37].HitboxStopTime > 0 and u1[v37].HitboxStopTime <= os.clock() then
                                    u1[v37].HitboxStopTime = 0;
                                    u1[v37]:HitStop();
                                end;

                                u1[v37].OnUpdate:Fire(v.LastPosition);
                            end;

                            if u1[v37].DetectionMode > 2 then
                                u1[v37].OnHit:Fire(Instance, v45, v41, v.Group);

                                if u1[v37].HitboxStopTime > 0 and u1[v37].HitboxStopTime <= os.clock() then
                                    u1[v37].HitboxStopTime = 0;
                                    u1[v37]:HitStop();
                                end;

                                u1[v37].OnUpdate:Fire(v.LastPosition);
                            end;

                            if not u1[v37].HitboxHitList[v44] then
                                u1[v37].HitboxHitList[v44] = true;
                                u1[v37].OnHit:Fire(Instance, v45, v41, v.Group);

                                if u1[v37].HitboxStopTime > 0 and u1[v37].HitboxStopTime <= os.clock() then
                                    u1[v37].HitboxStopTime = 0;
                                    u1[v37]:HitStop();
                                end;

                                u1[v37].OnUpdate:Fire(v.LastPosition);
                            end;
                        else
                            if u1[v37].HitboxStopTime > 0 and u1[v37].HitboxStopTime <= os.clock() then
                                u1[v37].HitboxStopTime = 0;
                                u1[v37]:HitStop();
                            end;

                            u1[v37].OnUpdate:Fire(v.LastPosition);
                        end;
                    else
                        v.LastPosition = nil;
                    end;
                end;
            end;
        end;

        local v47 = #VisualizerCache._AdornmentInUse;

        if v47 > 0 then
            for i = v47, 1, -1 do
                local v48;

                if os.clock() - VisualizerCache._AdornmentInUse[i].LastUse >= 0.25 then
                    local table_remove_ret = table.remove(VisualizerCache._AdornmentInUse, i);

                    if table_remove_ret then
                        VisualizerCache:ReturnAdornment(table_remove_ret);
                        v48 = i;
                    else
                        v48 = i;
                    end;
                else
                    v48 = i;
                end;
            end;
        end;
    end);

    for i, v in pairs(u2.CastModes) do
        local v49 = Solvers:FindFirstChild(i);

        if v49 then
            table_create_ret[v] = require(v49);
        end;
    end;
end)();

return u2;