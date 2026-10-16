-- Decompiled with Potassium's decompiler.

local u1 = require(script.Parent:FindFirstChild("jecs") or script.Parent:FindFirstChild("Jecs"));

local function duplicate(p2) -- Line: 7
    local v3 = p2.world:query();
    v3.filter_with = table.clone(p2.filter_with);

    if p2.filter_without then
        v3.filter_without = p2.filter_without;
    end;

    return v3:cached();
end;

return {
    monitor = function(p4) -- Line: 144, Name: monitors_new
        -- upvalues: u1 (copy)
        local v5 = p4.world:query();
        v5.filter_with = table.clone(p4.filter_with);

        if p4.filter_without then
            v5.filter_without = p4.filter_without;
        end;

        local v6 = v5:cached();
        local world = v6.world;
        local archetypes_map = v6.archetypes_map;
        local entity_index = world.entity_index;
        local u7 = nil;
        local u8 = nil;
        local u9 = nil;
        local u10 = nil;

        local function emplaced(p11, p12, p13, p14) -- Line: 160
            -- upvalues: u7 (ref), u1 (ref), entity_index (copy), archetypes_map (copy), u9 (ref), u10 (ref)
            if u7 == nil then
                return;
            end;

            local v15 = u1.entity_index_try_get_fast(entity_index, p11);

            if archetypes_map[p14.id] or not archetypes_map[v15.archetype.id] then
                u9 = nil;
                u10 = nil;

                return;
            end;

            if u9 == p14 and u10 == p11 then
                return;
            end;

            u9 = p14;
            u10 = p11;
            u7(p11);
        end;

        local function removed(p16: any, p17: any, p18: boolean?) -- Line: 186
            -- upvalues: u8 (ref), u1 (ref), world (copy), archetypes_map (copy), u10 (ref), u9 (ref)
            if u8 == nil then
                return;
            end;

            local v19 = u1.record(world, p16);

            if not v19 then
                return;
            end;

            local archetype = v19.archetype;

            if not archetype then
                return;
            end;

            if not archetypes_map[archetype.id] then
                return;
            end;

            if u10 == p16 and u9 == archetype then
                return;
            end;

            u10 = p16;
            u9 = archetype;
            u8(p16);
        end;

        local u20 = {};

        for _, v in v6.filter_with do
            if u1.IS_PAIR(v) then
                local v21 = u1.ECS_PAIR_FIRST(v);
                local u22 = u1.ECS_PAIR_SECOND(v) == u1.w;
                local v28 = world:added(v21, function(p23, p24, p25, p26) -- Line: 216
                    -- upvalues: u7 (ref), u22 (copy), v (copy), u1 (ref), entity_index (copy), archetypes_map (copy), u9 (ref), u10 (ref)
                    if u7 == nil then
                        return;
                    end;

                    if not u22 and p24 ~= v then
                        return;
                    end;

                    local v27 = u1.entity_index_try_get_fast(entity_index, p23);

                    if archetypes_map[p26.id] or not archetypes_map[v27.archetype.id] then
                        u9 = nil;
                        u10 = nil;

                        return;
                    end;

                    if u9 == p26 and u10 == p23 then
                        return;
                    end;

                    u9 = p26;
                    u10 = p23;
                    u7(p23);
                end);
                local v32 = world:removed(v21, function(p29, p30, p31) -- Line: 241
                    -- upvalues: u8 (ref), u22 (copy), v (copy), u1 (ref), world (copy), u10 (ref), u9 (ref), archetypes_map (copy)
                    if u8 == nil then
                        return;
                    end;

                    if not u22 and p30 ~= v then
                        return;
                    end;

                    local archetype = u1.record(world, p29).archetype;

                    if u10 == p29 and u9 == archetype then
                        return;
                    end;

                    if not archetypes_map[archetype.id] then
                        return;
                    end;

                    u10 = p29;
                    u9 = archetype;
                    u8(p29);
                end);
                table.insert(u20, v28);
                table.insert(u20, v32);
            else
                local v33 = world:added(v, emplaced);
                local v34 = world:removed(v, removed);
                table.insert(u20, v33);
                table.insert(u20, v34);
            end;
        end;

        local filter_without = p4.filter_without;

        if filter_without then
            for _, v in filter_without do
                if u1.IS_PAIR(v) then
                    local v35 = u1.ECS_PAIR_FIRST(v);
                    local u36 = u1.ECS_PAIR_SECOND(v) == u1.w;
                    local v41 = world:added(v35, function(p37, p38, p39, p40) -- Line: 279
                        -- upvalues: u8 (ref), u36 (copy), v (copy), u1 (ref), world (copy), archetypes_map (copy), u9 (ref)
                        if u8 == nil then
                            return;
                        end;

                        if not u36 and p38 ~= v then
                            return;
                        end;

                        local archetype = u1.record(world, p37).archetype;

                        if not archetype then
                            return;
                        end;

                        if archetypes_map[p40.id] and not archetypes_map[archetype.id] then
                            u9 = nil;
                            u8(p37);
                        end;
                    end);
                    local v45 = world:removed(v35, function(p42, p43, p44) -- Line: 297
                        -- upvalues: u7 (ref), u36 (copy), v (copy), u1 (ref), world (copy), u9 (ref), archetypes_map (copy)
                        if p44 then
                            return;
                        end;

                        if u7 == nil then
                            return;
                        end;

                        if not u36 and p43 ~= v then
                            return;
                        end;

                        local archetype = u1.record(world, p42).archetype;

                        if not archetype then
                            return;
                        end;

                        if u9 == archetype then
                            return;
                        end;

                        if archetypes_map[u1.archetype_traverse_remove(world, p43, archetype).id] then
                            u9 = archetype;
                            u7(p42);
                        end;
                    end);
                    table.insert(u20, v41);
                    table.insert(u20, v45);
                else
                    local v50 = world:added(v, function(p46, p47, p48, p49) -- Line: 327
                        -- upvalues: u8 (ref), u1 (ref), world (copy), archetypes_map (copy)
                        if u8 == nil then
                            return;
                        end;

                        local archetype = u1.record(world, p46).archetype;

                        if not archetype then
                            return;
                        end;

                        if archetypes_map[p49.id] and not archetypes_map[archetype.id] then
                            u8(p46);
                        end;
                    end);
                    local v54 = world:removed(v, function(p51, p52, p53) -- Line: 341
                        -- upvalues: u7 (ref), u1 (ref), world (copy), archetypes_map (copy)
                        if p53 then
                            return;
                        end;

                        if u7 == nil then
                            return;
                        end;

                        local archetype = u1.record(world, p51).archetype;

                        if not archetype then
                            return;
                        end;

                        if archetypes_map[u1.archetype_traverse_remove(world, p52, archetype).id] then
                            u7(p51);
                        end;
                    end);
                    table.insert(u20, v50);
                    table.insert(u20, v54);
                end;
            end;
        end;

        return {
            disconnect = function() -- Line: 365, Name: disconnect
                -- upvalues: u20 (copy)
                for _, v in u20 do
                    v();
                end;
            end,

            added = function(p55) -- Line: 371, Name: monitor_added
                -- upvalues: u7 (ref)
                u7 = p55;
            end,

            removed = function(p56) -- Line: 375, Name: monitor_removed
                -- upvalues: u8 (ref)
                u8 = p56;
            end
        };
    end,

    observer = function(p57: any, u58: function) -- Line: 27, Name: observers_new
        -- upvalues: u1 (copy)
        local v59 = p57.world:query();
        v59.filter_with = table.clone(p57.filter_with);

        if p57.filter_without then
            v59.filter_without = p57.filter_without;
        end;

        local v60 = v59:cached();
        local world = v60.world;
        local archetypes_map = v60.archetypes_map;
        local entity_index = world.entity_index;

        local function v65(p61, p62, p63, p64) -- Line: 41
            -- upvalues: entity_index (copy), u1 (ref), archetypes_map (copy), u58 (ref)
            if archetypes_map[entity_index.sparse_array[u1.ECS_ID(p61)].archetype.id] then
                u58(p61);
            end;
        end;

        local u66 = {};

        for _, v in p57.filter_with do
            if u1.IS_PAIR(v) then
                local v67 = u1.ECS_PAIR_FIRST(v);
                local u68 = u1.ECS_PAIR_SECOND(v) == u1.w;

                local function emplaced_w_pair(p69, p70, p71, p72) -- Line: 64
                    -- upvalues: u68 (copy), v (copy), u1 (ref), world (copy), archetypes_map (copy), u58 (ref)
                    if not u68 and p70 ~= v then
                        return;
                    end;

                    if archetypes_map[u1.record(world, p69).archetype.id] then
                        u58(p69);
                    end;
                end;

                local v73 = world:added(v67, emplaced_w_pair);
                local v74 = world:changed(v67, emplaced_w_pair);
                table.insert(u66, v73);
                table.insert(u66, v74);
            else
                local v75 = world:added(v, v65);
                local v76 = world:changed(v, v65);
                table.insert(u66, v75);
                table.insert(u66, v76);
            end;
        end;

        local filter_without = p57.filter_without;

        if filter_without then
            for _, v in filter_without do
                if u1.IS_PAIR(v) then
                    local v77 = u1.ECS_PAIR_FIRST(v);
                    local u78 = u1.ECS_PAIR_SECOND(v) == u1.w;
                    local v82 = world:removed(v77, function(p79: any, p80: any, p81: boolean?) -- Line: 93
                        -- upvalues: u78 (copy), v (copy), u1 (ref), world (copy), archetypes_map (copy), u58 (ref)
                        if p81 then
                            return;
                        end;

                        if not u78 and p80 ~= v then
                            return;
                        end;

                        local archetype = u1.record(world, p79).archetype;

                        if archetype and archetypes_map[u1.archetype_traverse_remove(world, p80, archetype).id] then
                            u58(p79);
                        end;
                    end);
                    table.insert(u66, v82);
                else
                    local v86 = world:removed(v, function(p83: any, p84: any, p85: boolean?) -- Line: 112
                        -- upvalues: u1 (ref), world (copy), archetypes_map (copy), u58 (ref)
                        if p85 then
                            return;
                        end;

                        local archetype = u1.record(world, p83).archetype;

                        if archetype and archetypes_map[u1.archetype_traverse_remove(world, p84, archetype).id] then
                            u58(p83);
                        end;
                    end);
                    table.insert(u66, v86);
                end;
            end;
        end;

        return {
            disconnect = function() -- Line: 131, Name: disconnect
                -- upvalues: u66 (copy)
                for _, v in u66 do
                    v();
                end;
            end
        };
    end
};