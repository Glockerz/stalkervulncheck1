-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Heartbeat = RunService.Heartbeat;
local _ = script.Parent;
local u1 = {};
local u2 = {};
local os_clock = os.clock;

function u2.add(p3, p4) -- Line: 16
    -- upvalues: u1 (copy)
    local v5 = typeof(p4) ~= "Instance";
    assert(v5, "Make sure you are initializing from the Raycast module, not from this handler.");
    table.insert(u1, p4);
end;

function u2.remove(p6, p7) -- Line: 21
    -- upvalues: u1 (copy)
    for i in ipairs(u1) do
        if u1[i].object == p7 then
            u1[i]:Destroy();
            setmetatable(u1[i], nil);
            table.remove(u1, i);
        end;
    end;
end;

function u2.check(p8, p9) -- Line: 31
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1) do
        if v.object == p9 then
            return v;
        end;
    end;
end;

function OnTagRemoved(p10)
    -- upvalues: u2 (copy)
    u2:remove(p10);
end;

CollectionService:GetInstanceRemovedSignal("RaycastModuleManaged"):Connect(OnTagRemoved);
Heartbeat:Connect(function() -- Line: 47
    -- upvalues: u1 (copy), u2 (copy), os_clock (copy)
    for _, v in ipairs(u1) do
        if v.deleted then
            u2:remove(v.object);
        else
            local v11 = v;

            for _, v2 in ipairs(v.points) do
                if v11.active then
                    local v12, v13, v14 = v2.solver:solve(v2, v11.debugMode);
                    local v15 = workspace:Raycast(v12, v13, v11.raycastParams);
                    v2.solver:lastPosition(v2, v14);

                    if v15 then
                        local Instance = v15.Instance;
                        local v16 = not v11.partMode and Instance:FindFirstAncestorOfClass("Model");

                        if v16 then
                            v16 = v16:FindFirstChildOfClass("Humanoid");
                        end;

                        local v17 = v16 or v11.partMode and Instance;

                        if v17 and not v11.targetsHit[v17] then
                            v11.targetsHit[v17] = true;
                            v11.OnHit:Fire(Instance, v16, v15, v2.group);
                        end;
                    end;

                    if v11.endTime > 0 and v11.endTime <= os_clock() then
                        v11.endTime = 0;
                        v11:HitStop();
                    end;

                    v11.OnUpdate:Fire(v2.LastPosition);
                else
                    v2.LastPosition = nil;
                end;
            end;
        end;
    end;
end);

return u2;