-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local vide = require(script.Parent.Parent.Parent.Parent.vide);
local theme = require(script.Parent.Parent.Parent.util.theme);
local padding = require(script.Parent.Parent.util.padding);
local rounded_frame = require(script.Parent.Parent.util.rounded_frame);
local typography = require(script.Parent.typography);
local create = vide.create;
local source = vide.source;
local derive = vide.derive;
local effect = vide.effect;
local cleanup = vide.cleanup;
local indexes = vide.indexes;
local changed = vide.changed;
local untrack = vide.untrack;
local u1 = source(0);
local u2 = source(1);

return function(u3: table) -- Line: 34
    -- upvalues: source (copy), derive (copy), effect (copy), vide (copy), u1 (copy), u2 (copy), untrack (copy), rounded_frame (copy), theme (copy), create (copy), indexes (copy), typography (copy), padding (copy), changed (copy), cleanup (copy), RunService (copy), UserInputService (copy)
    local meaning = u3.meaning;
    local sizes = u3.sizes;
    local u4 = u3.min_sizes or source({});
    local u5 = u3.suggested_sizes or {};
    local u6 = source(Vector2.one);
    local u7 = source(Vector2.one);
    local u8 = derive(function() -- Line: 43
        -- upvalues: meaning (copy)
        return #meaning();
    end);
    local u9 = u3.splits or source({});
    local u10 = derive(function() -- Line: 48
        -- upvalues: u3 (copy)
        return #u3.meaning();
    end);
    effect(function(p11) -- Line: 52
        -- upvalues: u10 (copy), vide (ref), source (ref), u5 (copy), u9 (copy)
        local v12 = {};

        for i = 1, u10() - 1 do
            local v13;

            if p11 then
                v13 = p11[i] or nil;
            else
                v13 = nil;
            end;

            local v14 = vide.read(v13);
            local v15 = (not v14 or v14 == 1) and (u5[i] or 1) or v14;
            local v16 = i / u10();
            v12[i] = source((math.min(v15, v16)));
            local _ = i;
        end;

        u9(v12);

        return v12;
    end);

    for i, v in u3.base_splits or {} do
        u9()[i](v);
    end;

    local function get_size(p17: number) -- Line: 68
        -- upvalues: u9 (copy), u1 (ref), u2 (ref)
        local v18 = u9()[p17 - 1] or u1;

        return (u9()[p17] or u2)() - v18();
    end;

    local function get_min_size(p19: number) -- Line: 76
        -- upvalues: u4 (copy)
        local v20 = u4()[p19];

        return v20 and v20() or 0.025;
    end;

    effect(function() -- Line: 81
        -- upvalues: u8 (copy), u4 (copy), source (ref), untrack (ref), derive (ref), u9 (copy), u1 (ref), u2 (ref), sizes (copy)
        local u21 = setmetatable({}, {
            __index = function() -- Line: 83, Name: __index
                return function() -- Line: 84
                    return 0;
                end;
            end
        });

        for i = 1, u8() do
            u4()[i] = u4()[i] or source(0.025);
            untrack(function() -- Line: 90
                -- upvalues: u21 (copy), i (copy), derive (ref), u9 (ref), u1 (ref), u2 (ref)
                u21[i] = derive(function() -- Line: 91
                    -- upvalues: i (ref), u9 (ref), u1 (ref), u2 (ref)
                    local v22 = i;
                    local v23 = u9()[v22 - 1] or u1;

                    return (u9()[v22] or u2)() - v23();
                end);
            end);
            local _ = i;
        end;

        sizes(u21);
    end);
    local u24 = false;
    local u25 = 0;

    return rounded_frame({
        size = function() -- Line: 104, Name: size
            return UDim2.new(1, 0, 0, 32);
        end,

        topleft = UDim.new(0, 8),
        topright = UDim.new(0, 8),
        color = theme.bg[1],
        create("TextButton")({
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            AutoLocalize = false,
            Text = "",
            create("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 0)
            }),
            indexes(meaning, function(u26, u27) -- Line: 122
                -- upvalues: typography (ref), u9 (copy), u1 (ref), u2 (ref), padding (ref)
                return typography({
                    size = function() -- Line: 124, Name: size
                        -- upvalues: u27 (copy), u9 (ref), u1 (ref), u2 (ref)
                        local UDim2_fromScale = UDim2.fromScale;
                        local v28 = u27;
                        local v29 = u9()[v28 - 1] or u1;

                        return UDim2_fromScale((u9()[v28] or u2)() - v29(), 1);
                    end,

                    automaticsize = Enum.AutomaticSize.None,

                    text = function() -- Line: 128, Name: text
                        -- upvalues: u26 (copy)
                        return u26() or "";
                    end,

                    xalignment = Enum.TextXAlignment.Left,
                    truncate = Enum.TextTruncate.AtEnd,
                    header = true,
                    textsize = 18,
                    padding({
                        x = UDim.new(0, 8)
                    })
                });
            end),
            changed("AbsoluteSize", u6),
            changed("AbsolutePosition", u7),

            MouseButton1Down = function(p30: number) -- Line: 143, Name: MouseButton1Down
                -- upvalues: u7 (copy), u6 (copy), u9 (copy), u24 (ref), u25 (ref)
                local v31 = p30 - u7().X;
                local v32 = u6();
                local v33 = -1;

                for i, v in u9() do
                    local v34 = v31 - v32.X * v();

                    if math.abs(v34) <= 32 then
                        v33 = i;
                    end;
                end;

                u24 = v33 ~= -1;
                u25 = v33;
            end,

            MouseButton1Up = function() -- Line: 159, Name: MouseButton1Up
                -- upvalues: u24 (ref)
                u24 = false;
            end,

            cleanup(RunService.Heartbeat:Connect(function() -- Line: 163
                -- upvalues: UserInputService (ref), u7 (copy), u24 (ref), u6 (copy), u9 (copy), u25 (ref), u8 (copy), u4 (copy), u1 (ref), u2 (ref)
                local v35 = UserInputService:GetMouseLocation().X - u7().X;

                if u24 == false then
                    return;
                end;

                u24 = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == true;
                local v36 = v35 / u6().X - u9()[u25]();

                if v36 > 0 then
                    for i = u25, u8() - 1 do
                        local v37 = u4()[i + 1];
                        local v38 = v37 and v37() or 0.025;
                        local v39 = i + 1;
                        local v40 = u9()[v39 - 1] or u1;
                        local v41 = (u9()[v39] or u2)() - v40();
                        local v42 = v41 - math.max(v41 - v36, v38);
                        u9()[i](u9()[i]() + v42);
                        v36 = v36 - v42;

                        if v36 == 0 then
                            return;
                        end;

                        local _ = i;
                    end;

                    return;
                end;

                for i = u25, 1, -1 do
                    local v43 = u4()[i];
                    local v44 = v43 and v43() or 0.025;
                    local v45 = u9()[i - 1] or u1;
                    local v46 = (u9()[i] or u2)() - v45();
                    local math_max_ret = math.max(v46, v44);
                    local v47 = math.max(math_max_ret + v36, v44) - math_max_ret;
                    u9()[i](u9()[i]() + v47);
                    v36 = v36 - v47;

                    if v36 == 0 then
                        break;
                    end;

                    local _ = i;
                end;
            end))
        })
    });
end;