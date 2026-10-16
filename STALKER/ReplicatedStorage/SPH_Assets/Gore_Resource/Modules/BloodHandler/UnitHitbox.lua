-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local Heartbeat = game:GetService("RunService").Heartbeat;

function u1.getUnit(p2, p3, p4, p5) -- Line: 6
    return (p3 - p2).Unit * p4 * p5;
end;

function u1.new(p6: userdata, p7: number, p8: userdata) -- Line: 10
    -- upvalues: u1 (copy)
    local v9 = setmetatable({}, u1);
    v9.connection = nil;
    v9.increment = p7 or 0.25;
    v9.active = false;
    v9.destroyed = false;
    v9.instance = p6;
    v9.params = p8 or RaycastParams.new();
    v9._onHitEvent = Instance.new("BindableEvent");
    v9.onHit = v9._onHitEvent.Event;
    v9.oldPosition = p6.Position;

    return v9;
end;

function u1.Destroy(p10) -- Line: 25
    if p10.destroyed then
        return;
    end;

    p10:HitStop();
    p10.destroyed = true;
    p10._onHitEvent:Destroy();
end;

function u1.HitStart(u11) -- Line: 33
    -- upvalues: Heartbeat (copy), u1 (copy)
    if u11.destroyed or u11.active then
        return;
    end;

    local instance = u11.instance;
    u11.active = true;
    u11.oldPosition = instance.Position;
    u11.connection = Heartbeat:Connect(function(p12) -- Line: 40
        -- upvalues: instance (copy), u11 (copy), u1 (ref)
        if not (instance and instance.Parent) then
            u11:HitStop();

            return;
        end;

        local Unit = u1.getUnit(u11.oldPosition, instance.Position, p12 * 60, u11.increment);
        local v13 = workspace:Raycast(instance.Position, Unit, u11.params);

        if v13 then
            u11._onHitEvent:Fire(v13);
        end;

        u11.oldPosition = instance.Position;
    end);
end;

function u1.HitStop(p14) -- Line: 58
    if p14.destroyed or not p14.active then
        return;
    end;

    p14.active = false;
    p14.connection:Disconnect();
end;

return u1;