-- Decompiled with Potassium's decompiler.

local pebble = require(script.Parent.Parent.Parent.Parent.pebble);
local vide = require(script.Parent.Parent.Parent.Parent.vide);
local create = vide.create;
local source = vide.source;
local values = vide.values;
local changed = vide.changed;
local effect = vide.effect;
local untrack = vide.untrack;

return function(u1: table) -- Line: 32
    -- upvalues: source (copy), effect (copy), untrack (copy), create (copy), values (copy), pebble (copy), changed (copy)
    local u2 = source({});
    local u3 = source(Vector2.zero);
    local u4 = source(Vector2.zero);
    local item_size = u1.item_size;
    local u5 = u1.separator_size or 0;
    local item = u1.item;
    local separator = u1.separator;
    effect(function() -- Line: 47
        -- upvalues: u3 (copy), u4 (copy), item_size (copy), u5 (copy), untrack (ref), u2 (copy), u1 (copy), source (ref)
        local v6 = u3();
        local v7 = u4();
        local v8 = item_size + u5;
        local u9 = math.ceil(v6.X / v8) + 8;
        local u10 = untrack(u2);
        local math_floor_ret = math.floor(v7.X / v8);
        local math_ceil_ret = math.ceil((v7.X + v6.X) / v8);
        local u11 = not u1.max_items and (1 / 0) or u1.max_items();
        untrack(function() -- Line: 63
            -- upvalues: u10 (copy), math_floor_ret (copy), math_ceil_ret (copy), u11 (ref), u9 (copy), source (ref), u2 (ref)
            local v12 = {};

            for i, v in u10 do
                local v13 = v();

                if math.max(math_floor_ret, 1) > v13 or v13 > math.min(math_ceil_ret, u11) then
                    v12[i] = true;
                    v(-1);
                end;
            end;

            if #u10 < u9 then
                for i = #u10 + 1, u9 do
                    u10[i] = source(-1);
                    v12[i] = true;
                    local _ = i;
                end;

                u2(u10);
            end;

            local v14 = {};

            for i = math.max(math_floor_ret, 1), math.min(math_ceil_ret, u11) do
                v14[i] = true;
                local _ = i;
            end;

            for _, v in u10 do
                v14[v()] = nil;
            end;

            for i in v12 do
                local v15 = u10[i];
                local v16 = next(v14);

                if not v16 then
                    break;
                end;

                v15(v16);
                v14[v16] = nil;
                v12[i] = nil;
            end;

            if next(v14) then
                warn("missing source!", next(v14));
            end;

            if u9 < #u10 then
                for i = #u10, 1, -1 do
                    if v12[i] then
                        table.remove(u10, i);
                    end;

                    v12[i] = nil;

                    if #u10 < u9 then
                        break;
                    end;

                    local _ = i;
                end;

                u2(u10);
            end;
        end);
    end);

    return create("ScrollingFrame")({
        Size = u1.size or UDim2.fromScale(1, 1),
        Position = u1.position,
        AnchorPoint = u1.anchorpoint,
        BackgroundTransparency = 1,

        CanvasSize = function() -- Line: 134, Name: CanvasSize
            -- upvalues: u1 (copy), item_size (copy), u5 (copy), u3 (copy), u4 (copy)
            if u1.max_items then
                return UDim2.fromOffset(u1.max_items() * (item_size + u5), 0);
            end;

            local v17 = u3();
            local v18 = u4();
            local v19 = item_size + u5;
            local v20 = math.ceil((v18.X + v17.X) / v19) + 4;

            return UDim2.fromOffset(v20 * v19, 0);
        end,

        values(u2, function(u21) -- Line: 146
            -- upvalues: create (ref), item_size (copy), u5 (copy), pebble (ref), item (copy), separator (copy)
            local v22 = create("Frame");
            local v23 = {
                Name = u21,

                Position = function() -- Line: 150, Name: Position
                    -- upvalues: u21 (copy), item_size (ref), u5 (ref)
                    if u21() == -1 then
                        UDim2.fromOffset(0, -1000);
                    end;

                    return UDim2.fromOffset((item_size + u5) * (u21() - 1), 0);
                end,

                Size = UDim2.new(0, item_size + u5, 1, 0),
                BackgroundTransparency = 1
            };
            local v24 = pebble.container({
                Name = "Item",
                item(u21)
            });
            local v25;

            if separator then
                v25 = pebble.container({
                    Name = "Separator",
                    separator(u21)
                });
            else
                v25 = nil;
            end;

            v23[1], v23[2] = v24, v25;

            return v22(v23);
        end),
        changed("AbsoluteSize", u3),
        changed("CanvasPosition", u4),
        unpack(u1)
    });
end;