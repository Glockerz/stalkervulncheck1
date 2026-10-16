-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local scroll_frame = require(script.Parent.Parent.display.scroll_frame);
local container = require(script.Parent.container);
local create = vide.create;
local source = vide.source;
local values = vide.values;
local changed = vide.changed;
local effect = vide.effect;
local untrack = vide.untrack;
local batch = vide.batch;

return function(u1: table) -- Line: 34
    -- upvalues: source (copy), effect (copy), untrack (copy), batch (copy), scroll_frame (copy), values (copy), create (copy), container (copy), changed (copy)
    local u2 = source({});
    local u3 = source(Vector2.zero);
    local u4 = source(Vector2.zero);
    local item_size = u1.item_size;
    local u5 = u1.separator_size or 0;
    local item = u1.item;
    local separator = u1.separator;
    effect(function() -- Line: 49
        -- upvalues: u3 (copy), u4 (copy), item_size (copy), u5 (copy), untrack (ref), u2 (copy), u1 (copy), batch (ref), source (ref)
        local v6 = u3();
        local v7 = u4();
        local v8 = item_size + u5;
        local u9 = math.ceil(v6.Y / v8) + 4;
        local u10 = untrack(u2);
        local math_floor_ret = math.floor(v7.Y / v8);
        local math_ceil_ret = math.ceil((v7.Y + v6.Y) / v8);
        local u11 = not u1.max_items and (1 / 0) or u1.max_items();
        batch(function() -- Line: 65
            -- upvalues: untrack (ref), u10 (copy), math_floor_ret (copy), math_ceil_ret (copy), u11 (ref), u9 (copy), source (ref), u2 (ref)
            untrack(function() -- Line: 66
                -- upvalues: u10 (ref), math_floor_ret (ref), math_ceil_ret (ref), u11 (ref), u9 (ref), source (ref), u2 (ref)
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
    end);

    return scroll_frame({
        unpack(u1),
        Size = u1.size or UDim2.fromScale(1, 1),
        Position = u1.position,
        AnchorPoint = u1.anchorpoint,
        BackgroundTransparency = 1,

        CanvasSize = function() -- Line: 138, Name: CanvasSize
            -- upvalues: u1 (copy), item_size (copy), u5 (copy), u3 (copy), u4 (copy)
            if u1.max_items then
                return UDim2.fromOffset(0, u1.max_items() * (item_size + u5));
            end;

            local v17 = u3();
            local v18 = u4();
            local v19 = item_size + u5;
            local v20 = math.ceil((v18.Y + v17.Y) / v19) + 4;

            return UDim2.fromOffset(0, v20 * v19);
        end,

        values(u2, function(u21) -- Line: 150
            -- upvalues: create (ref), item_size (copy), u5 (copy), container (ref), item (copy), separator (copy)
            local v22 = create("Frame");
            local v23 = {
                Name = u21,
                AutoLocalize = false,

                Position = function() -- Line: 155, Name: Position
                    -- upvalues: u21 (copy), item_size (ref), u5 (ref)
                    if u21() == -1 then
                        UDim2.fromOffset(0, -1000);
                    end;

                    return UDim2.fromOffset(0, (item_size + u5) * (u21() - 1));
                end,

                Size = UDim2.new(1, 0, 0, item_size + u5),
                BackgroundTransparency = 1
            };
            local v24 = container({
                Name = "Item",
                item(u21)
            });
            local v25;

            if separator then
                v25 = container({
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
        changed("CanvasPosition", u4)
    });
end;