-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local vide = require(script.Parent.Parent.Parent.Parent.vide);
local create = vide.create;
local source = vide.source;
local cleanup = vide.cleanup;
local effect = vide.effect;
local action = vide.action;
local changed = vide.changed;
local untrack = vide.untrack;
local read = vide.read;

local function in_bounds(p1, p2, p3) -- Line: 33
    local v4;

    if p1.X >= p2.X and (p1.X <= p2.X + p3.X and p1.Y >= p2.Y) then
        v4 = p1.Y <= p2.Y + p3.Y;
    else
        v4 = false;
    end;

    return v4;
end;

return function() -- Line: 37
    -- upvalues: source (copy), create (copy), changed (copy), action (copy), cleanup (copy), effect (copy), untrack (copy), read (copy), UserInputService (copy)
    local u5 = {};
    local u6 = source(Vector2.zero);

    local function snap_area(u7: table) -- Line: 42
        -- upvalues: source (ref), create (ref), changed (ref), action (ref), u5 (copy), cleanup (ref)
        local u8 = source(Vector2.zero);
        local u9 = source(Vector2.zero);
        local u10 = source(false);

        return create("Frame")({
            Name = "SnapArea",
            AutoLocalize = false,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            changed("AbsoluteSize", u9),
            changed("AbsolutePosition", u8),
            action(function(u11) -- Line: 57
                -- upvalues: u5 (ref), u8 (copy), u10 (copy), u9 (copy), u7 (copy), cleanup (ref)
                u5[u11] = {
                    position = u8,
                    docked = u10,
                    size = u9,
                    zindex = u7.zindex or 0
                };
                cleanup(function() -- Line: 65
                    -- upvalues: u5 (ref), u11 (copy)
                    u5[u11] = nil;
                end);
            end)
        });
    end;

    local function snappable(u12: table) -- Line: 72
        -- upvalues: source (ref), effect (ref), u6 (copy), untrack (ref), u5 (copy), read (ref)
        local u13 = source();
        effect(function() -- Line: 75
            -- upvalues: u12 (copy), u6 (ref), untrack (ref), u13 (copy), u5 (ref), read (ref)
            if u12.dragging() == false then
                return;
            end;

            local u14 = u6();
            untrack(function() -- Line: 79
                -- upvalues: u13 (ref), u5 (ref), u14 (copy), read (ref), u12 (ref)
                if u13() then
                    u13().docked(false);
                end;

                local v15 = nil;

                for _, v in u5 do
                    local v16 = u14;
                    local v17 = v.position();
                    local v18 = v.size();
                    local v19;

                    if v16.X >= v17.X and (v16.X <= v17.X + v18.X and v16.Y >= v17.Y) then
                        v19 = v16.Y <= v17.Y + v18.Y;
                    else
                        v19 = false;
                    end;

                    if v19 and (not v15 or read(v.zindex) > read(v15.zindex)) then
                        v15 = v;
                    end;
                end;

                if not v15 and read(u12.allow_floating) == false then
                    return;
                end;

                if v15 and v15.docked() then
                    return;
                end;

                if v15 then
                    v15.docked(true);
                end;

                u13(v15);
            end);
        end);
        effect(function() -- Line: 98
            -- upvalues: u12 (copy), u13 (copy)
            u12.snapped(u13() and true or false);
        end);
        effect(function() -- Line: 102
            -- upvalues: u13 (copy), u12 (copy)
            if not u13() then
                return;
            end;

            local v20 = u13();
            local v21 = v20.position();
            local v22 = v20.size();
            u12.position(UDim2.fromOffset(v21.X, v21.Y));
            u12.size(UDim2.fromOffset(v22.X, v22.Y));
        end);
    end;

    cleanup(UserInputService.InputChanged:Connect(function(p23) -- Line: 113
        -- upvalues: u6 (copy)
        if p23.UserInputType ~= Enum.UserInputType.MouseMovement then
            return;
        end;

        u6(Vector2.new(p23.Position.X, p23.Position.Y));
    end));

    return {
        snap_area = snap_area,
        snappable = snappable
    };
end;