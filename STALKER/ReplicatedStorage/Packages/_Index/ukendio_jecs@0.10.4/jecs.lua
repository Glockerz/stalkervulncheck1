-- Decompiled with Potassium's decompiler.

local table_freeze_ret = table.freeze({});
local u1 = newproxy(false);

local function ecs_assert(p2: any, p3: string?) -- Line: 396
    if not p2 then
        error(p3);
    end;
end;

local u4 = {};
local u5 = 0;
local u6 = 271;

local function ECS_COMPONENT() -- Line: 406
    -- upvalues: u5 (ref)
    u5 = u5 + 1;

    if u5 > 256 then
        error("Too many components");
    end;

    return u5;
end;

local function ECS_TAG() -- Line: 414
    -- upvalues: u6 (ref)
    u6 = u6 + 1;

    return u6;
end;

local function ECS_META(p7: number, p8: number, p9: any) -- Line: 419
    -- upvalues: u4 (ref), u1 (copy)
    local v10 = u4[p7];

    if v10 == nil then
        v10 = {};
        u4[p7] = v10;
    end;

    if p9 == nil then
        p9 = u1;
    end;

    v10[p8] = p9;
end;

local function ECS_META_RESET() -- Line: 428
    -- upvalues: u4 (ref), u5 (ref), u6 (ref)
    u4 = {};
    u5 = 0;
    u6 = 271;
end;

local function ECS_ID(p11: number) -- Line: 461
    return p11 % 16777216;
end;

local function ECS_ENTITY_T_HI(p12: number) -- Line: 469
    return p12 // 16777216;
end;

local function ecs_get_alive(p13: table, p14: number) -- Line: 545
    if p14 == 0 then
        return 0;
    end;

    local entity_index = p13.entity_index;
    local v15 = entity_index.sparse_array[p14 % 16777216];

    if not v15 or v15.dense == 0 then
        v15 = nil;
    end;

    if v15 then
        local dense = v15.dense;

        if entity_index.alive_count < dense then
            v15 = nil;
        elseif entity_index.dense_array[dense] ~= p14 then
            v15 = nil;
        end;
    end;

    if v15 ~= nil then
        return p14;
    end;

    if p14 > 16777216 then
        return 0;
    end;

    local v16 = entity_index.sparse_array[p14 % 16777216];

    if not v16 or v16.dense == 0 then
        v16 = nil;
    end;

    local v17;

    if v16 then
        local dense = v16.dense;

        if entity_index.alive_count < dense then
            v17 = nil;
        else
            v17 = entity_index.dense_array[dense];
        end;
    else
        v17 = nil;
    end;

    if v17 then
        local v18 = entity_index.sparse_array[v17 % 16777216];

        if not v18 or v18.dense == 0 then
            v18 = nil;
        end;

        if v18 then
            local dense = v18.dense;

            if entity_index.alive_count < dense then
                v18 = nil;
            elseif entity_index.dense_array[dense] ~= v17 then
                v18 = nil;
            end;
        end;

        if v18 ~= nil then
            return v17;
        end;
    end;

    return 0;
end;

local function ENTITY_INDEX_NEW_ID(p19: table) -- Line: 570
    local dense_array = p19.dense_array;
    local alive_count = p19.alive_count;
    local sparse_array = p19.sparse_array;
    local max_id = p19.max_id;
    local v20 = alive_count + 1;
    local v21 = alive_count < max_id and dense_array[v20];

    if v21 then
        p19.alive_count = v20;

        return v21;
    end;

    local v22 = max_id + 1;
    local range_end = p19.range_end;

    if range_end ~= nil and v22 >= range_end then
        error("Entity is outside range");
    end;

    p19.max_id = v22;
    p19.alive_count = v20;
    dense_array[v20] = v22;
    sparse_array[v22] = {
        dense = v20
    };

    return v22;
end;

local function archetype_move(p23: table, p24: number, p25: table, p26: number, p27: table, p28: number) -- Line: 637
    -- upvalues: table_freeze_ret (copy)
    local columns = p27.columns;
    local entities = p25.entities;
    local entities2 = p27.entities;
    local v29 = #entities2;
    local types = p27.types;
    local columns_map = p25.columns_map;

    if p28 == v29 then
        for i, v in columns do
            if v ~= table_freeze_ret then
                local v30 = columns_map[types[i]];

                if v30 then
                    v30[p26] = v[p28];
                end;

                v[v29] = nil;
            end;
        end;
    else
        for i, v in columns do
            if v ~= table_freeze_ret then
                local v31 = columns_map[types[i]];

                if v31 then
                    v31[p26] = v[p28];
                end;

                v[p28] = v[v29];
                v[v29] = nil;
            end;
        end;

        local v32 = entities2[v29];
        entities2[p28] = v32;
        p23.sparse_array[v32 % 16777216].row = p28;
    end;

    entities2[v29] = nil;
    entities[p26] = p24;
end;

local function archetype_append(p33: number, p34: table) -- Line: 707
    local entities = p34.entities;
    local v35 = #entities + 1;
    entities[v35] = p33;

    return v35;
end;

local function new_entity(p36: number, p37: table, p38: table) -- Line: 717
    local entities = p38.entities;
    local v39 = #entities + 1;
    entities[v39] = p36;
    p37.archetype = p38;
    p37.row = v39;

    return p37;
end;

local function hash(p40: table) -- Line: 742
    return table.concat(p40, "_");
end;

local function fetch(p41: number, p42: table, p43: number) -- Line: 746
    local v44 = p42[p41];

    if v44 then
        return v44[p43];
    end;

    return nil;
end;

local function WORLD_GET(p45: table, p46: number, p47: number, p48: number?, p49: number?, p50: number?, p51: number?) -- Line: 756
    local entity_index = p45.entity_index;
    local v52 = entity_index.sparse_array[p46 % 16777216];

    if not v52 or v52.dense == 0 then
        v52 = nil;
    end;

    if v52 then
        local dense = v52.dense;

        if entity_index.alive_count < dense then
            v52 = nil;
        elseif entity_index.dense_array[dense] ~= p46 then
            v52 = nil;
        end;
    end;

    if not v52 then
        return nil;
    end;

    local archetype = v52.archetype;

    if not archetype then
        return nil;
    end;

    local columns_map = archetype.columns_map;
    local row = v52.row;
    local v53 = columns_map[p47];
    local v54;

    if v53 then
        v54 = v53[row];
    else
        v54 = nil;
    end;

    if not p48 then
        return v54;
    end;

    if not p49 then
        local v55 = columns_map[p48];

        if v55 then
            return v54, v55[row];
        end;

        return v54, nil;
    end;

    if not p50 then
        local v56 = columns_map[p48];
        local v57;

        if v56 then
            v57 = v56[row];
        else
            v57 = nil;
        end;

        local v58 = columns_map[p49];

        if v58 then
            return v54, v57, v58[row];
        end;

        return v54, v57, nil;
    end;

    if not p51 then
        local v59 = columns_map[p48];
        local v60;

        if v59 then
            v60 = v59[row];
        else
            v60 = nil;
        end;

        local v61 = columns_map[p49];
        local v62;

        if v61 then
            v62 = v61[row];
        else
            v62 = nil;
        end;

        local v63 = columns_map[p50];

        if v63 then
            return v54, v60, v62, v63[row];
        end;

        return v54, v60, v62, nil;
    end;

    error("args exceeded");
end;

local function WORLD_HAS(p64: table, p65: number, p66: number) -- Line: 786
    local entity_index = p64.entity_index;
    local v67 = entity_index.sparse_array[p65 % 16777216];

    if not v67 or v67.dense == 0 then
        v67 = nil;
    end;

    if v67 then
        local dense = v67.dense;

        if entity_index.alive_count < dense then
            v67 = nil;
        elseif entity_index.dense_array[dense] ~= p65 then
            v67 = nil;
        end;
    end;

    if not v67 then
        return false;
    end;

    local archetype = v67.archetype;

    if archetype then
        return archetype.columns_map[p66] ~= nil;
    end;

    return false;
end;

local function WORLD_TARGET(p68: table, p69: number, p70: number, p71: number?) -- Line: 800
    local entity_index = p68.entity_index;
    local v72 = entity_index.sparse_array[p69 % 16777216];

    if not v72 or v72.dense == 0 then
        v72 = nil;
    end;

    if v72 then
        local dense = v72.dense;

        if entity_index.alive_count < dense then
            v72 = nil;
        elseif entity_index.dense_array[dense] ~= p69 then
            v72 = nil;
        end;
    end;

    if not v72 then
        return nil;
    end;

    local archetype = v72.archetype;

    if not archetype then
        return nil;
    end;

    local v73 = p68.component_index[260 % 16777216 + p70 % 16777216 * 16777216 + 281474976710656];

    if not v73 then
        return nil;
    end;

    local id = archetype.id;
    local v74 = v73.counts[id];

    if not v74 then
        return nil;
    end;

    local v75 = p71 or 0;

    if v74 <= v75 then
        return nil;
    end;

    local v76 = archetype.types[v75 + v73.records[id]];

    if not v76 then
        return nil;
    end;

    local v77 = entity_index.sparse_array[(v76 - 281474976710656) % 16777216 % 16777216];

    if not v77 or v77.dense == 0 then
        v77 = nil;
    end;

    if not v77 then
        return nil;
    end;

    local dense = v77.dense;

    if entity_index.alive_count < dense then
        return nil;
    end;

    return entity_index.dense_array[dense];
end;

local function id_record_create(p78: table, p79: table, p80: number) -- Line: 858
    -- upvalues: WORLD_TARGET (copy)
    local entity_index = p78.entity_index;
    local v81 = p80 > 281474976710656;
    local v82 = false;
    local v83 = false;
    local v84, v85;

    if v81 then
        local v86 = entity_index.sparse_array[(p80 - 281474976710656) // 16777216 % 16777216];

        if not v86 or v86.dense == 0 then
            v86 = nil;
        end;

        if v86 then
            local dense = v86.dense;

            if entity_index.alive_count < dense then
                v84 = nil;
            else
                v84 = entity_index.dense_array[dense];
            end;
        else
            v84 = nil;
        end;

        local v87;

        if v84 then
            local v88 = entity_index.sparse_array[v84 % 16777216];

            if not v88 or v88.dense == 0 then
                v88 = nil;
            end;

            if v88 then
                local dense = v88.dense;

                if entity_index.alive_count < dense then
                    v88 = nil;
                elseif entity_index.dense_array[dense] ~= v84 then
                    v88 = nil;
                end;
            end;

            v87 = v88 ~= nil;
        else
            v87 = v84;
        end;

        if not v87 then
            error("\tYou tried passing a pair that has invalid entities that are either unalive\n\tor non-existing entities. You can enable DEBUG mode by passing in true to\n\tjecs.world(true) and try doing it again in order to get better assertions so\n\tthat you can understand what went wrong.\n");
        end;

        local v89 = entity_index.sparse_array[(p80 - 281474976710656) % 16777216 % 16777216];

        if not v89 or v89.dense == 0 then
            v89 = nil;
        end;

        if v89 then
            local dense = v89.dense;

            if entity_index.alive_count < dense then
                v85 = nil;
            else
                v85 = entity_index.dense_array[dense];
            end;
        else
            v85 = nil;
        end;

        local v90;

        if v85 then
            local v91 = entity_index.sparse_array[v85 % 16777216];

            if not v91 or v91.dense == 0 then
                v91 = nil;
            end;

            if v91 then
                local dense = v91.dense;

                if entity_index.alive_count < dense then
                    v91 = nil;
                elseif entity_index.dense_array[dense] ~= v85 then
                    v91 = nil;
                end;
            end;

            v90 = v91 ~= nil;
        else
            v90 = v85;
        end;

        if not v90 then
            error("\tYou tried passing a pair that has invalid entities that are either unalive\n\tor non-existing entities. You can enable DEBUG mode by passing in true to\n\tjecs.world(true) and try doing it again in order to get better assertions so\n\tthat you can understand what went wrong.\n");
        end;

        v82 = WORLD_TARGET(p78, v84, 264, 0) == 265 and true or v82;
        local entity_index2 = p78.entity_index;
        local v92 = entity_index2.sparse_array[v84 % 16777216];

        if not v92 or v92.dense == 0 then
            v92 = nil;
        end;

        if v92 then
            local dense = v92.dense;

            if entity_index2.alive_count < dense then
                v92 = nil;
            elseif entity_index2.dense_array[dense] ~= v84 then
                v92 = nil;
            end;
        end;

        local v93;

        if v92 then
            local archetype = v92.archetype;

            if archetype then
                v93 = archetype.columns_map[270] ~= nil;
            else
                v93 = false;
            end;
        else
            v93 = false;
        end;

        if v93 then
            v83 = true;
        end;
    else
        v84 = p80;
        v85 = 0;
    end;

    local v94 = WORLD_TARGET(p78, v84, 263, 0) == 265 and true or v82;
    local entity_index2 = p78.entity_index;
    local v95 = entity_index2.sparse_array[v84 % 16777216];

    if not v95 or v95.dense == 0 then
        v95 = nil;
    end;

    if v95 then
        local dense = v95.dense;

        if entity_index2.alive_count < dense then
            v95 = nil;
        elseif entity_index2.dense_array[dense] ~= v84 then
            v95 = nil;
        end;
    end;

    local v96, v97, v98;

    if v95 then
        local archetype = v95.archetype;

        if archetype then
            local columns_map = archetype.columns_map;
            local row = v95.row;
            local v99 = columns_map[257];

            if v99 then
                v96 = v99[row];
            else
                v96 = nil;
            end;

            local v100 = columns_map[259];

            if v100 then
                v97 = v100[row];
            else
                v97 = nil;
            end;

            local v101 = columns_map[258];

            if v101 then
                v98 = v101[row];
            else
                v98 = nil;
            end;
        else
            v98 = nil;
            v96 = nil;
            v97 = nil;
        end;
    else
        v98 = nil;
        v96 = nil;
        v97 = nil;
    end;

    local entity_index3 = p78.entity_index;
    local v102 = entity_index3.sparse_array[v84 % 16777216];

    if not v102 or v102.dense == 0 then
        v102 = nil;
    end;

    if v102 then
        local dense = v102.dense;

        if entity_index3.alive_count < dense then
            v102 = nil;
        elseif entity_index3.dense_array[dense] ~= v84 then
            v102 = nil;
        end;
    end;

    local v103;

    if v102 then
        local archetype = v102.archetype;

        if archetype then
            v103 = archetype.columns_map[262] ~= nil;
        else
            v103 = false;
        end;
    else
        v103 = false;
    end;

    local v104 = not v103;

    if v104 and v81 then
        local entity_index4 = p78.entity_index;
        local v105 = entity_index4.sparse_array[v85 % 16777216];

        if not v105 or v105.dense == 0 then
            v105 = nil;
        end;

        if v105 then
            local dense = v105.dense;

            if entity_index4.alive_count < dense then
                v105 = nil;
            elseif entity_index4.dense_array[dense] ~= v85 then
                v105 = nil;
            end;
        end;

        local v106;

        if v105 then
            local archetype = v105.archetype;

            if archetype then
                v106 = archetype.columns_map[262] ~= nil;
            else
                v106 = false;
            end;
        else
            v106 = false;
        end;

        v104 = not v106;
    end;

    local v107 = {
        size = 0,
        records = {},
        counts = {},
        flags = bit32.bor(0, v94 and 1 or 0, v104 and 2 or 0, v83 and 4 or 0),
        on_add = v96,
        on_change = v97,
        on_remove = v98
    };
    p79[p80] = v107;

    return v107;
end;

local function archetype_create(p108: table, p109: table, p110: any, p111: number?) -- Line: 962
    -- upvalues: id_record_create (copy), table_freeze_ret (copy)
    local v112 = p108.max_archetype_id + 1;
    p108.max_archetype_id = v112;
    local table_create_ret = table.create(#p109);
    local v113 = {};
    local v114 = {
        columns = table_create_ret,
        columns_map = v113,
        entities = {},
        id = v112,
        type = p110,
        types = p109
    };

    for i, v in v114.types do
        local component_index = p108.component_index;
        local v115 = component_index[v] or id_record_create(p108, component_index, v);
        v115.size = v115.size + 1;
        local v116 = not bit32.btest(v115.flags, 2) and {} or table_freeze_ret;
        table_create_ret[i] = v116;
        local records = v115.records;
        local counts = v115.counts;

        if records[v112] then
            counts[v112] = counts[v112] + 1;
        else
            records[v112] = i;
            counts[v112] = 1;
            v113[v] = v116;
        end;

        if v > 281474976710656 then
            local v117 = 260 % 16777216 + (v - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656;
            local component_index2 = p108.component_index;
            local v118 = component_index2[v117] or id_record_create(p108, component_index2, v117);
            v118.size = v118.size + 1;
            local records2 = v118.records;
            local counts2 = v118.counts;

            if records2[v112] then
                counts2[v112] = counts2[v112] + 1;
            else
                records2[v112] = i;
                counts2[v112] = 1;
                v113[v117] = v116;
            end;

            local wildcard_pairs = v118.wildcard_pairs;

            if not wildcard_pairs then
                wildcard_pairs = {};
                v118.wildcard_pairs = wildcard_pairs;
            end;

            wildcard_pairs[v] = v115;
            local v119 = (v - 281474976710656) % 16777216 % 16777216 + 260 % 16777216 * 16777216 + 281474976710656;
            local component_index3 = p108.component_index;
            local v120 = component_index3[v119] or id_record_create(p108, component_index3, v119);
            v120.size = v120.size + 1;
            local records3 = v120.records;
            local counts3 = v120.counts;

            if records3[v112] then
                counts3[v112] = counts3[v112] + 1;
            else
                records3[v112] = i;
                counts3[v112] = 1;
                v113[v119] = v116;
            end;
        end;
    end;

    p108.archetype_index[p110] = v114;
    p108.archetypes[v112] = v114;
    p108.archetype_edges[v112] = {};

    for i in v113 do
        local v121 = p108.observable[268];
        local v122;

        if v121 then
            v122 = v121[i];
        else
            v122 = nil;
        end;

        if v122 then
            for _, v in v122 do
                local query = v.query;
                local columns_map = v114.columns_map;
                local v123 = v;
                local v124;

                for _, v2 in query.filter_with do
                    if not columns_map[v2] then
                        v124 = false;
                        break;
                    end;
                end;

                local filter_without = query.filter_without;

                if filter_without then
                    v124 = true;

                    for _, v2 in filter_without do
                        if columns_map[v2] then
                            v124 = false;
                            break;
                        end;
                    end;
                end;

                if v124 then
                    v123.callback(v114);
                end;
            end;
        end;
    end;

    return v114;
end;

local function world_range(p125: table, p126: number, p127: number?) -- Line: 1032
    local entity_index = p125.entity_index;
    entity_index.range_begin = p126;
    entity_index.range_end = p127;
    local max_id = entity_index.max_id;

    if max_id < p126 then
        local dense_array = entity_index.dense_array;
        local sparse_array = entity_index.sparse_array;

        for i = max_id + 1, p126 do
            dense_array[i] = i;
            sparse_array[i] = {
                dense = 0
            };
            local _ = i;
        end;

        entity_index.max_id = p126;
        entity_index.alive_count = p126;
    end;
end;

local function archetype_fast_delete_last(p128: table, p129: number) -- Line: 1165
    -- upvalues: table_freeze_ret (copy)
    for _, v in p128 do
        if v ~= table_freeze_ret then
            v[p129] = nil;
        end;
    end;
end;

local function archetype_fast_delete(p130: table, p131: number, p132: number) -- Line: 1173
    -- upvalues: table_freeze_ret (copy)
    for _, v in p130 do
        if v ~= table_freeze_ret then
            v[p132] = v[p131];
            v[p131] = nil;
        end;
    end;
end;

local function archetype_delete(p133: table, p134: table, p135: number) -- Line: 1182
    -- upvalues: table_freeze_ret (copy)
    local entity_index = p133.entity_index;
    local columns = p134.columns;
    local entities = p134.entities;
    local v136 = #entities;
    local v137 = #entities;
    local v138 = entities[v137];

    if p135 ~= v137 then
        local v139 = entity_index.sparse_array[v138 % 16777216];

        if not v139 or v139.dense == 0 then
            v139 = nil;
        end;

        if v139 then
            v139.row = p135;
        end;

        entities[p135] = v138;
    end;

    entities[v137] = nil;

    if p135 == v137 then
        for _, v in columns do
            if v ~= table_freeze_ret then
                v[v136] = nil;
            end;
        end;

        return;
    end;

    for _, v in columns do
        if v ~= table_freeze_ret then
            v[p135] = v[v136];
            v[v136] = nil;
        end;
    end;
end;

local function archetype_destroy(p140: table, p141: table) -- Line: 1210
    if p141 == p140.ROOT_ARCHETYPE then
        return;
    end;

    local component_index = p140.component_index;
    local archetype_edges = p140.archetype_edges;
    local v142 = archetype_edges[p141.id];

    for i, v in v142 do
        archetype_edges[v.id][i] = nil;
        v142[i] = nil;
    end;

    local id = p141.id;
    p140.archetypes[id] = nil;
    p140.archetype_index[p141.type] = nil;

    for i in p141.columns_map do
        local v143 = component_index[i];
        v143.records[id] = nil;
        v143.counts[id] = nil;
        v143.size = v143.size - 1;

        if v143.size == 0 then
            component_index[i] = nil;
        end;

        local v144 = p140.observable[269];
        local v145;

        if v144 then
            v145 = v144[i];
        else
            v145 = nil;
        end;

        if v145 then
            for _, v in v145 do
                local query = v.query;
                local columns_map = p141.columns_map;
                local v146 = v;
                local v147;

                for _, v2 in query.filter_with do
                    if not columns_map[v2] then
                        v147 = false;
                        break;
                    end;
                end;

                local filter_without = query.filter_without;

                if filter_without then
                    v147 = true;

                    for _, v2 in filter_without do
                        if columns_map[v2] then
                            v147 = false;
                            break;
                        end;
                    end;
                end;

                if v147 then
                    v146.callback(p141);
                end;
            end;
        end;
    end;
end;

local function NOOP() -- Line: 1248
end;

local function query_archetypes(p148: table, p149: boolean?) -- Line: 1250
    local compatible_archetypes = p148.compatible_archetypes;

    if not compatible_archetypes or p149 then
        compatible_archetypes = {};
        p148.compatible_archetypes = compatible_archetypes;
        local world = p148.world;
        local archetypes = world.archetypes;
        local component_index = world.component_index;
        local filter_with = p148.filter_with;
        local v150 = nil;

        for _, v in filter_with do
            local v151 = component_index[v];

            if v151 and (v150 == nil or v151.size < v150.size) then
                v150 = v151;
            end;
        end;

        if v150 == nil then
            return compatible_archetypes;
        end;

        local filter_without = p148.filter_without;

        for i in v150.records do
            local v152 = archetypes[i];
            local columns_map = v152.columns_map;
            local v153 = false;

            for _, v in filter_with do
                if not columns_map[v] then
                    v153 = true;
                    break;
                end;
            end;

            if not v153 then
                if filter_without then
                    for _, v in filter_without do
                        if columns_map[v] then
                            v153 = true;
                            break;
                        end;
                    end;
                end;

                if not v153 then
                    table.insert(compatible_archetypes, v152);
                end;
            end;
        end;
    end;

    return compatible_archetypes;
end;

local function query_with(p154: table, ...) -- Line: 1312
    local ids = p154.ids;
    local v155 = { ... };
    table.move(ids, 1, #ids, #v155 + 1, v155);
    p154.filter_with = v155;

    return p154;
end;

local function query_without(p156: table, ...) -- Line: 1320
    p156.filter_without = { ... };

    return p156;
end;

local function query_iter_init(p157: table) -- Line: 1326
    -- upvalues: query_archetypes (copy), NOOP (copy)
    local u158 = query_archetypes(p157);
    local u159 = 1;
    local u160 = u158[1];

    if not u160 then
        return NOOP;
    end;

    local entities = u160.entities;
    local u161 = #entities;
    local columns_map = u160.columns_map;
    local ids = p157.ids;
    local u162, u163, u164, u165, u166, u167, u168, u169, v170 = unpack(ids);
    local u171 = nil;
    local u172 = nil;
    local u173 = nil;
    local u174 = nil;
    local u175 = nil;
    local u176 = nil;
    local u177 = nil;

    if not u162 then
        local function world_query_iter_next() -- Line: 1345
            -- upvalues: entities (ref), u161 (ref), u159 (ref), u158 (copy), u160 (ref)
            local v178 = entities[u161];

            while v178 == nil do
                u159 = u159 + 1;
                local v179 = u158[u159];
                u160 = v179;

                if not v179 then
                    return nil;
                end;

                local entities2 = v179.entities;
                u161 = #entities2;

                if u161 ~= 0 then
                    v178 = entities2[u161];
                    entities = entities2;
                end;
            end;

            u161 = u161 - 1;

            return v178;
        end;

        p157.next = world_query_iter_next;

        return world_query_iter_next;
    end;

    local u180;

    if u163 then
        if u164 then
            if u165 then
                if u166 then
                    if u167 then
                        if u168 then
                            if u169 then
                                u180 = columns_map[u162];
                                u171 = columns_map[u163];
                                u172 = columns_map[u164];
                                u173 = columns_map[u165];
                                u174 = columns_map[u166];
                                u175 = columns_map[u167];
                                u176 = columns_map[u168];
                                u177 = columns_map[u169];
                            else
                                u180 = columns_map[u162];
                                u171 = columns_map[u163];
                                u172 = columns_map[u164];
                                u173 = columns_map[u165];
                                u174 = columns_map[u166];
                                u175 = columns_map[u167];
                                u176 = columns_map[u168];
                            end;
                        else
                            u180 = columns_map[u162];
                            u171 = columns_map[u163];
                            u172 = columns_map[u164];
                            u173 = columns_map[u165];
                            u174 = columns_map[u166];
                            u175 = columns_map[u167];
                        end;
                    else
                        u180 = columns_map[u162];
                        u171 = columns_map[u163];
                        u172 = columns_map[u164];
                        u173 = columns_map[u165];
                        u174 = columns_map[u166];
                    end;
                else
                    u180 = columns_map[u162];
                    u171 = columns_map[u163];
                    u172 = columns_map[u164];
                    u173 = columns_map[u165];
                end;
            else
                u180 = columns_map[u162];
                u171 = columns_map[u163];
                u172 = columns_map[u164];
            end;
        else
            u180 = columns_map[u162];
            u171 = columns_map[u163];
        end;
    else
        u180 = columns_map[u162];
    end;

    local v181;

    if u163 then
        if u164 then
            if u165 then
                if u166 then
                    if u167 then
                        if u168 then
                            if u169 then
                                if v170 then
                                    local u182 = {};
                                    local u183 = #ids;

                                    v181 = function() -- Line: 1768, Name: world_query_iter_next
                                        -- upvalues: entities (ref), u161 (ref), u180 (ref), u171 (ref), u172 (ref), u173 (ref), u174 (ref), u175 (ref), u176 (ref), u177 (ref), ids (copy), columns_map (ref), u159 (ref), u158 (copy), u160 (ref), u162 (copy), u163 (copy), u164 (copy), u165 (copy), u166 (copy), u167 (copy), u168 (copy), u169 (copy), u183 (copy), u182 (copy)
                                        local v184 = entities[u161];
                                        local v185 = u180;
                                        local v186 = u171;
                                        local v187 = u172;
                                        local v188 = u173;
                                        local v189 = u174;
                                        local v190 = u175;
                                        local v191 = u176;
                                        local v192 = u177;
                                        local v193 = ids;
                                        local v194 = columns_map;

                                        while v184 == nil do
                                            u159 = u159 + 1;
                                            local v195 = u158[u159];
                                            u160 = v195;

                                            if not v195 then
                                                return nil;
                                            end;

                                            local entities2 = v195.entities;
                                            u161 = #entities2;

                                            if u161 ~= 0 then
                                                v184 = entities2[u161];
                                                entities = entities2;
                                                v194 = v195.columns_map;
                                                columns_map = v194;
                                                v185 = v194[u162];
                                                v186 = v194[u163];
                                                v187 = v194[u164];
                                                v188 = v194[u165];
                                                v189 = v194[u166];
                                                v190 = v194[u167];
                                                v191 = v194[u168];
                                                v192 = v194[u169];
                                                u180 = v185;
                                                u171 = v186;
                                                u172 = v187;
                                                u173 = v188;
                                                u174 = v189;
                                                u175 = v190;
                                                u176 = v191;
                                                u177 = v192;
                                            end;
                                        end;

                                        local v196 = u161;
                                        u161 = u161 - 1;

                                        for i = 9, u183 do
                                            u182[i - 8] = v194[v193[i]][v196];
                                            local _ = i;
                                        end;

                                        return v184, v185[v196], v186[v196], v187[v196], v188[v196], v189[v196], v190[v196], v191[v196], v192[v196], unpack(u182);
                                    end;
                                else
                                    v181 = function() -- Line: 1712, Name: world_query_iter_next
                                        -- upvalues: entities (ref), u161 (ref), u180 (ref), u171 (ref), u172 (ref), u173 (ref), u174 (ref), u175 (ref), u176 (ref), u177 (ref), u159 (ref), u158 (copy), u160 (ref), columns_map (ref), u162 (copy), u163 (copy), u164 (copy), u165 (copy), u166 (copy), u167 (copy), u168 (copy), u169 (copy)
                                        local v197 = entities[u161];
                                        local v198 = u180;
                                        local v199 = u171;
                                        local v200 = u172;
                                        local v201 = u173;
                                        local v202 = u174;
                                        local v203 = u175;
                                        local v204 = u176;
                                        local v205 = u177;

                                        while v197 == nil do
                                            u159 = u159 + 1;
                                            local v206 = u158[u159];
                                            u160 = v206;

                                            if not v206 then
                                                return nil;
                                            end;

                                            local entities2 = v206.entities;
                                            u161 = #entities2;

                                            if u161 ~= 0 then
                                                v197 = entities2[u161];
                                                entities = entities2;
                                                local columns_map2 = v206.columns_map;
                                                columns_map = columns_map2;
                                                v198 = columns_map2[u162];
                                                v199 = columns_map2[u163];
                                                v200 = columns_map2[u164];
                                                v201 = columns_map2[u165];
                                                v202 = columns_map2[u166];
                                                v203 = columns_map2[u167];
                                                v204 = columns_map2[u168];
                                                v205 = columns_map2[u169];
                                                u180 = v198;
                                                u171 = v199;
                                                u172 = v200;
                                                u173 = v201;
                                                u174 = v202;
                                                u175 = v203;
                                                u176 = v204;
                                                u177 = v205;
                                            end;
                                        end;

                                        local v207 = u161;
                                        u161 = u161 - 1;

                                        return v197, v198[v207], v199[v207], v200[v207], v201[v207], v202[v207], v203[v207], v204[v207], v205[v207];
                                    end;
                                end;
                            else
                                v181 = function() -- Line: 1661, Name: world_query_iter_next
                                    -- upvalues: entities (ref), u161 (ref), u180 (ref), u171 (ref), u172 (ref), u173 (ref), u174 (ref), u175 (ref), u176 (ref), u159 (ref), u158 (copy), u160 (ref), columns_map (ref), u162 (copy), u163 (copy), u164 (copy), u165 (copy), u166 (copy), u167 (copy), u168 (copy)
                                    local v208 = entities[u161];
                                    local v209 = u180;
                                    local v210 = u171;
                                    local v211 = u172;
                                    local v212 = u173;
                                    local v213 = u174;
                                    local v214 = u175;
                                    local v215 = u176;

                                    while v208 == nil do
                                        u159 = u159 + 1;
                                        local v216 = u158[u159];
                                        u160 = v216;

                                        if not v216 then
                                            return nil;
                                        end;

                                        local entities2 = v216.entities;
                                        u161 = #entities2;

                                        if u161 ~= 0 then
                                            v208 = entities2[u161];
                                            entities = entities2;
                                            local columns_map2 = v216.columns_map;
                                            columns_map = columns_map2;
                                            v209 = columns_map2[u162];
                                            v210 = columns_map2[u163];
                                            v211 = columns_map2[u164];
                                            v212 = columns_map2[u165];
                                            v213 = columns_map2[u166];
                                            v214 = columns_map2[u167];
                                            v215 = columns_map2[u168];
                                            u180 = v209;
                                            u171 = v210;
                                            u172 = v211;
                                            u173 = v212;
                                            u174 = v213;
                                            u175 = v214;
                                            u176 = v215;
                                        end;
                                    end;

                                    local v217 = u161;
                                    u161 = u161 - 1;

                                    return v208, v209[v217], v210[v217], v211[v217], v212[v217], v213[v217], v214[v217], v215[v217];
                                end;
                            end;
                        else
                            v181 = function() -- Line: 1613, Name: world_query_iter_next
                                -- upvalues: entities (ref), u161 (ref), u180 (ref), u171 (ref), u172 (ref), u173 (ref), u174 (ref), u175 (ref), u159 (ref), u158 (copy), u160 (ref), columns_map (ref), u162 (copy), u163 (copy), u164 (copy), u165 (copy), u166 (copy), u167 (copy)
                                local v218 = entities[u161];
                                local v219 = u180;
                                local v220 = u171;
                                local v221 = u172;
                                local v222 = u173;
                                local v223 = u174;
                                local v224 = u175;

                                while v218 == nil do
                                    u159 = u159 + 1;
                                    local v225 = u158[u159];
                                    u160 = v225;

                                    if not v225 then
                                        return nil;
                                    end;

                                    local entities2 = v225.entities;
                                    u161 = #entities2;

                                    if u161 ~= 0 then
                                        v218 = entities2[u161];
                                        entities = entities2;
                                        local columns_map2 = v225.columns_map;
                                        columns_map = columns_map2;
                                        v219 = columns_map2[u162];
                                        v220 = columns_map2[u163];
                                        v221 = columns_map2[u164];
                                        v222 = columns_map2[u165];
                                        v223 = columns_map2[u166];
                                        v224 = columns_map2[u167];
                                        u180 = v219;
                                        u171 = v220;
                                        u172 = v221;
                                        u173 = v222;
                                        u174 = v223;
                                        u175 = v224;
                                    end;
                                end;

                                local v226 = u161;
                                u161 = u161 - 1;

                                return v218, v219[v226], v220[v226], v221[v226], v222[v226], v223[v226], v224[v226];
                            end;
                        end;
                    else
                        v181 = function() -- Line: 1568, Name: world_query_iter_next
                            -- upvalues: entities (ref), u161 (ref), u180 (ref), u171 (ref), u172 (ref), u173 (ref), u174 (ref), u159 (ref), u158 (copy), u160 (ref), columns_map (ref), u162 (copy), u163 (copy), u164 (copy), u165 (copy), u166 (copy)
                            local v227 = entities[u161];
                            local v228 = u180;
                            local v229 = u171;
                            local v230 = u172;
                            local v231 = u173;
                            local v232 = u174;

                            while v227 == nil do
                                u159 = u159 + 1;
                                local v233 = u158[u159];
                                u160 = v233;

                                if not v233 then
                                    return nil;
                                end;

                                local entities2 = v233.entities;
                                u161 = #entities2;

                                if u161 ~= 0 then
                                    v227 = entities2[u161];
                                    entities = entities2;
                                    local columns_map2 = v233.columns_map;
                                    columns_map = columns_map2;
                                    v228 = columns_map2[u162];
                                    v229 = columns_map2[u163];
                                    v230 = columns_map2[u164];
                                    v231 = columns_map2[u165];
                                    v232 = columns_map2[u166];
                                    u180 = v228;
                                    u171 = v229;
                                    u172 = v230;
                                    u173 = v231;
                                    u174 = v232;
                                end;
                            end;

                            local v234 = u161;
                            u161 = u161 - 1;

                            return v227, v228[v234], v229[v234], v230[v234], v231[v234], v232[v234];
                        end;
                    end;
                else
                    v181 = function() -- Line: 1526, Name: world_query_iter_next
                        -- upvalues: entities (ref), u161 (ref), u180 (ref), u171 (ref), u172 (ref), u173 (ref), u159 (ref), u158 (copy), u160 (ref), columns_map (ref), u162 (copy), u163 (copy), u164 (copy), u165 (copy)
                        local v235 = entities[u161];
                        local v236 = u180;
                        local v237 = u171;
                        local v238 = u172;
                        local v239 = u173;

                        while v235 == nil do
                            u159 = u159 + 1;
                            local v240 = u158[u159];
                            u160 = v240;

                            if not v240 then
                                return nil;
                            end;

                            local entities2 = v240.entities;
                            u161 = #entities2;

                            if u161 ~= 0 then
                                v235 = entities2[u161];
                                entities = entities2;
                                local columns_map2 = v240.columns_map;
                                columns_map = columns_map2;
                                v236 = columns_map2[u162];
                                v237 = columns_map2[u163];
                                v238 = columns_map2[u164];
                                v239 = columns_map2[u165];
                                u180 = v236;
                                u171 = v237;
                                u172 = v238;
                                u173 = v239;
                            end;
                        end;

                        local v241 = u161;
                        u161 = u161 - 1;

                        return v235, v236[v241], v237[v241], v238[v241], v239[v241];
                    end;
                end;
            else
                v181 = function() -- Line: 1487, Name: world_query_iter_next
                    -- upvalues: entities (ref), u161 (ref), u180 (ref), u171 (ref), u172 (ref), u159 (ref), u158 (copy), u160 (ref), columns_map (ref), u162 (copy), u163 (copy), u164 (copy)
                    local v242 = entities[u161];
                    local v243 = u180;
                    local v244 = u171;
                    local v245 = u172;

                    while v242 == nil do
                        u159 = u159 + 1;
                        local v246 = u158[u159];
                        u160 = v246;

                        if not v246 then
                            return nil;
                        end;

                        local entities2 = v246.entities;
                        u161 = #entities2;

                        if u161 ~= 0 then
                            v242 = entities2[u161];
                            entities = entities2;
                            local columns_map2 = v246.columns_map;
                            columns_map = columns_map2;
                            v243 = columns_map2[u162];
                            v244 = columns_map2[u163];
                            v245 = columns_map2[u164];
                            u180 = v243;
                            u171 = v244;
                            u172 = v245;
                        end;
                    end;

                    local v247 = u161;
                    u161 = u161 - 1;

                    return v242, v243[v247], v244[v247], v245[v247];
                end;
            end;
        else
            v181 = function() -- Line: 1451, Name: world_query_iter_next
                -- upvalues: entities (ref), u161 (ref), u180 (ref), u171 (ref), u159 (ref), u158 (copy), u160 (ref), columns_map (ref), u162 (copy), u163 (copy)
                local v248 = entities[u161];
                local v249 = u180;
                local v250 = u171;

                while v248 == nil do
                    u159 = u159 + 1;
                    local v251 = u158[u159];
                    u160 = v251;

                    if not v251 then
                        return nil;
                    end;

                    local entities2 = v251.entities;
                    u161 = #entities2;

                    if u161 ~= 0 then
                        v248 = entities2[u161];
                        entities = entities2;
                        local columns_map2 = v251.columns_map;
                        columns_map = columns_map2;
                        v249 = columns_map2[u162];
                        v250 = columns_map2[u163];
                        u180 = v249;
                        u171 = v250;
                    end;
                end;

                local v252 = u161;
                u161 = u161 - 1;

                return v248, v249[v252], v250[v252];
            end;
        end;
    else
        v181 = function() -- Line: 1418, Name: world_query_iter_next
            -- upvalues: entities (ref), u161 (ref), u180 (ref), u159 (ref), u158 (copy), u160 (ref), columns_map (ref), u162 (copy)
            local v253 = entities[u161];
            local v254 = u180;

            while v253 == nil do
                u159 = u159 + 1;
                local v255 = u158[u159];
                u160 = v255;

                if not v255 then
                    return nil;
                end;

                local entities2 = v255.entities;
                u161 = #entities2;

                if u161 ~= 0 then
                    v253 = entities2[u161];
                    entities = entities2;
                    local columns_map2 = v255.columns_map;
                    columns_map = columns_map2;
                    v254 = columns_map2[u162];
                    u180 = v254;
                end;
            end;

            local v256 = u161;
            u161 = u161 - 1;

            return v253, v254[v256];
        end;
    end;

    p157.next = v181;

    return v181;
end;

local function query_iter(p257) -- Line: 1833
    -- upvalues: query_iter_init (copy)
    return p257.next or query_iter_init(p257);
end;

local u258 = {};
u258.__index = u258;
u258.__iter = query_iter;
u258.iter = query_iter_init;
u258.without = query_without;
u258.with = query_with;
u258.archetypes = query_archetypes;

function u258.cached(p259: table) -- Line: 1841
    -- upvalues: query_archetypes (copy), NOOP (copy)
    local ids = p259.ids;
    local v260, u261, u262, u263, u264, u265, u266, u267, v268 = unpack(ids);
    local u269 = v260 or p259.filter_with[1];
    local u270 = query_archetypes(p259);
    local u271 = {};
    p259.archetypes_map = u271;
    local u272 = nil;
    local u273 = nil;
    local u274 = nil;
    local u275 = nil;
    local u276 = nil;
    local u277 = nil;
    local u278 = nil;
    local u279 = nil;
    local u280 = nil;

    for i, v in u270 do
        u271[v.id] = i;
    end;

    local u281 = u270;
    local u282 = 1;
    local u283 = u281[1];
    local u284, u285, u286;

    if u283 then
        u284 = u283.entities;
        u285 = #u284;
        u286 = u283.columns_map;
    else
        u284 = {};
        u285 = 0;
        u286 = {};
    end;

    local world = p259.world;
    local observable = world.observable;
    local v287 = observable[268];

    if not v287 then
        v287 = {};
        observable[268] = v287;
    end;

    local u288 = v287[u269];

    if not u288 then
        u288 = {};
        v287[u269] = u288;
    end;

    local v289 = observable[269];

    if not v289 then
        v289 = {};
        observable[269] = v289;
    end;

    local u290 = v289[u269];

    if not u290 then
        u290 = {};
        v289[u269] = u290;
    end;

    local u293 = {
        query = p259,

        callback = function(p291: table) -- Line: 1902, Name: on_create_callback
            -- upvalues: u270 (copy), u271 (copy)
            local v292 = #u270 + 1;
            u270[v292] = p291;
            u271[p291.id] = v292;
        end
    };
    local u298 = {
        query = p259,

        callback = function(p294) -- Line: 1908, Name: on_delete_callback
            -- upvalues: u270 (copy), u271 (copy)
            local v295 = #u270;
            local v296 = u270[v295];
            local id = p294.id;
            local v297 = u271[id];
            u270[v297] = v296;
            u270[v295] = nil;
            u271[id] = nil;
            u271[v296.id] = v297;
        end
    };
    table.insert(u288, u293);
    table.insert(u290, u298);

    local function cached_query_iter() -- Line: 1927
        -- upvalues: u282 (ref), u281 (ref), u283 (ref), NOOP (ref), u284 (ref), u285 (ref), u286 (ref), u269 (ref), u261 (copy), u272 (ref), u262 (copy), u277 (ref), u263 (copy), u279 (ref), u264 (copy), u275 (ref), u265 (copy), u273 (ref), u266 (copy), u278 (ref), u267 (copy), u280 (ref), u276 (ref), u274 (ref)
        u282 = 1;
        u283 = u281[u282];

        if not u283 then
            return NOOP;
        end;

        u284 = u283.entities;
        u285 = #u284;
        u286 = u283.columns_map;

        if u269 then
            if u261 then
                if u262 then
                    if u263 then
                        if u264 then
                            if u265 then
                                if u266 then
                                    if u267 then
                                        u272 = u286[u269];
                                        u277 = u286[u261];
                                        u279 = u286[u262];
                                        u275 = u286[u263];
                                        u273 = u286[u264];
                                        u278 = u286[u265];
                                        u280 = u286[u266];
                                        u276 = u286[u267];
                                    else
                                        u272 = u286[u269];
                                        u277 = u286[u261];
                                        u279 = u286[u262];
                                        u275 = u286[u263];
                                        u273 = u286[u264];
                                        u278 = u286[u265];
                                        u280 = u286[u266];
                                    end;
                                else
                                    u272 = u286[u269];
                                    u277 = u286[u261];
                                    u279 = u286[u262];
                                    u275 = u286[u263];
                                    u273 = u286[u264];
                                    u278 = u286[u265];
                                end;
                            else
                                u272 = u286[u269];
                                u277 = u286[u261];
                                u279 = u286[u262];
                                u275 = u286[u263];
                                u273 = u286[u264];
                            end;
                        else
                            u272 = u286[u269];
                            u277 = u286[u261];
                            u279 = u286[u262];
                            u275 = u286[u263];
                        end;
                    else
                        u272 = u286[u269];
                        u277 = u286[u261];
                        u279 = u286[u262];
                    end;
                else
                    u272 = u286[u269];
                    u277 = u286[u261];
                end;
            else
                u272 = u286[u269];
            end;
        end;

        return u274;
    end;

    if u269 then
        if u261 then
            if u262 then
                if u263 then
                    if u264 then
                        if u265 then
                            if u266 then
                                if u267 then
                                    if v268 then
                                        local u299 = {};
                                        local u300 = #ids;

                                        u274 = function() -- Line: 2363, Name: world_query_iter_next
                                            -- upvalues: u284 (ref), u285 (ref), u272 (ref), u277 (ref), u279 (ref), u275 (ref), u273 (ref), u278 (ref), u280 (ref), u276 (ref), ids (copy), u286 (ref), u282 (ref), u281 (ref), u283 (ref), u269 (ref), u261 (copy), u262 (copy), u263 (copy), u264 (copy), u265 (copy), u266 (copy), u267 (copy), u300 (copy), u299 (copy)
                                            local v301 = u284[u285];
                                            local v302 = u272;
                                            local v303 = u277;
                                            local v304 = u279;
                                            local v305 = u275;
                                            local v306 = u273;
                                            local v307 = u278;
                                            local v308 = u280;
                                            local v309 = u276;
                                            local v310 = ids;
                                            local v311 = u286;

                                            while v301 == nil do
                                                u282 = u282 + 1;
                                                local v312 = u281[u282];
                                                u283 = v312;

                                                if not v312 then
                                                    return nil;
                                                end;

                                                local entities = v312.entities;
                                                u285 = #entities;

                                                if u285 ~= 0 then
                                                    v301 = entities[u285];
                                                    u284 = entities;
                                                    v311 = v312.columns_map;
                                                    u286 = v311;
                                                    v302 = v311[u269];
                                                    v303 = v311[u261];
                                                    v304 = v311[u262];
                                                    v305 = v311[u263];
                                                    v306 = v311[u264];
                                                    v307 = v311[u265];
                                                    v308 = v311[u266];
                                                    v309 = v311[u267];
                                                    u272 = v302;
                                                    u277 = v303;
                                                    u279 = v304;
                                                    u275 = v305;
                                                    u273 = v306;
                                                    u278 = v307;
                                                    u280 = v308;
                                                    u276 = v309;
                                                end;
                                            end;

                                            local v313 = u285;
                                            u285 = u285 - 1;

                                            for i = 9, u300 do
                                                u299[i - 8] = v311[v310[i]][v313];
                                                local _ = i;
                                            end;

                                            return v301, v302[v313], v303[v313], v304[v313], v305[v313], v306[v313], v307[v313], v308[v313], v309[v313], unpack(u299);
                                        end;
                                    else
                                        u274 = function() -- Line: 2307, Name: world_query_iter_next
                                            -- upvalues: u284 (ref), u285 (ref), u272 (ref), u277 (ref), u279 (ref), u275 (ref), u273 (ref), u278 (ref), u280 (ref), u276 (ref), u282 (ref), u281 (ref), u283 (ref), u286 (ref), u269 (ref), u261 (copy), u262 (copy), u263 (copy), u264 (copy), u265 (copy), u266 (copy), u267 (copy)
                                            local v314 = u284[u285];
                                            local v315 = u272;
                                            local v316 = u277;
                                            local v317 = u279;
                                            local v318 = u275;
                                            local v319 = u273;
                                            local v320 = u278;
                                            local v321 = u280;
                                            local v322 = u276;

                                            while v314 == nil do
                                                u282 = u282 + 1;
                                                local v323 = u281[u282];
                                                u283 = v323;

                                                if not v323 then
                                                    return nil;
                                                end;

                                                local entities = v323.entities;
                                                u285 = #entities;

                                                if u285 ~= 0 then
                                                    v314 = entities[u285];
                                                    u284 = entities;
                                                    local columns_map = v323.columns_map;
                                                    u286 = columns_map;
                                                    v315 = columns_map[u269];
                                                    v316 = columns_map[u261];
                                                    v317 = columns_map[u262];
                                                    v318 = columns_map[u263];
                                                    v319 = columns_map[u264];
                                                    v320 = columns_map[u265];
                                                    v321 = columns_map[u266];
                                                    v322 = columns_map[u267];
                                                    u272 = v315;
                                                    u277 = v316;
                                                    u279 = v317;
                                                    u275 = v318;
                                                    u273 = v319;
                                                    u278 = v320;
                                                    u280 = v321;
                                                    u276 = v322;
                                                end;
                                            end;

                                            local v324 = u285;
                                            u285 = u285 - 1;

                                            return v314, v315[v324], v316[v324], v317[v324], v318[v324], v319[v324], v320[v324], v321[v324], v322[v324];
                                        end;
                                    end;
                                else
                                    u274 = function() -- Line: 2256, Name: world_query_iter_next
                                        -- upvalues: u284 (ref), u285 (ref), u272 (ref), u277 (ref), u279 (ref), u275 (ref), u273 (ref), u278 (ref), u280 (ref), u282 (ref), u281 (ref), u283 (ref), u286 (ref), u269 (ref), u261 (copy), u262 (copy), u263 (copy), u264 (copy), u265 (copy), u266 (copy)
                                        local v325 = u284[u285];
                                        local v326 = u272;
                                        local v327 = u277;
                                        local v328 = u279;
                                        local v329 = u275;
                                        local v330 = u273;
                                        local v331 = u278;
                                        local v332 = u280;

                                        while v325 == nil do
                                            u282 = u282 + 1;
                                            local v333 = u281[u282];
                                            u283 = v333;

                                            if not v333 then
                                                return nil;
                                            end;

                                            local entities = v333.entities;
                                            u285 = #entities;

                                            if u285 ~= 0 then
                                                v325 = entities[u285];
                                                u284 = entities;
                                                local columns_map = v333.columns_map;
                                                u286 = columns_map;
                                                v326 = columns_map[u269];
                                                v327 = columns_map[u261];
                                                v328 = columns_map[u262];
                                                v329 = columns_map[u263];
                                                v330 = columns_map[u264];
                                                v331 = columns_map[u265];
                                                v332 = columns_map[u266];
                                                u272 = v326;
                                                u277 = v327;
                                                u279 = v328;
                                                u275 = v329;
                                                u273 = v330;
                                                u278 = v331;
                                                u280 = v332;
                                            end;
                                        end;

                                        local v334 = u285;
                                        u285 = u285 - 1;

                                        return v325, v326[v334], v327[v334], v328[v334], v329[v334], v330[v334], v331[v334], v332[v334];
                                    end;
                                end;
                            else
                                u274 = function() -- Line: 2208, Name: world_query_iter_next
                                    -- upvalues: u284 (ref), u285 (ref), u272 (ref), u277 (ref), u279 (ref), u275 (ref), u273 (ref), u278 (ref), u282 (ref), u281 (ref), u283 (ref), u286 (ref), u269 (ref), u261 (copy), u262 (copy), u263 (copy), u264 (copy), u265 (copy)
                                    local v335 = u284[u285];
                                    local v336 = u272;
                                    local v337 = u277;
                                    local v338 = u279;
                                    local v339 = u275;
                                    local v340 = u273;
                                    local v341 = u278;

                                    while v335 == nil do
                                        u282 = u282 + 1;
                                        local v342 = u281[u282];
                                        u283 = v342;

                                        if not v342 then
                                            return nil;
                                        end;

                                        local entities = v342.entities;
                                        u285 = #entities;

                                        if u285 ~= 0 then
                                            v335 = entities[u285];
                                            u284 = entities;
                                            local columns_map = v342.columns_map;
                                            u286 = columns_map;
                                            v336 = columns_map[u269];
                                            v337 = columns_map[u261];
                                            v338 = columns_map[u262];
                                            v339 = columns_map[u263];
                                            v340 = columns_map[u264];
                                            v341 = columns_map[u265];
                                            u272 = v336;
                                            u277 = v337;
                                            u279 = v338;
                                            u275 = v339;
                                            u273 = v340;
                                            u278 = v341;
                                        end;
                                    end;

                                    local v343 = u285;
                                    u285 = u285 - 1;

                                    return v335, v336[v343], v337[v343], v338[v343], v339[v343], v340[v343], v341[v343];
                                end;
                            end;
                        else
                            u274 = function() -- Line: 2163, Name: world_query_iter_next
                                -- upvalues: u284 (ref), u285 (ref), u272 (ref), u277 (ref), u279 (ref), u275 (ref), u273 (ref), u282 (ref), u281 (ref), u283 (ref), u286 (ref), u269 (ref), u261 (copy), u262 (copy), u263 (copy), u264 (copy)
                                local v344 = u284[u285];
                                local v345 = u272;
                                local v346 = u277;
                                local v347 = u279;
                                local v348 = u275;
                                local v349 = u273;

                                while v344 == nil do
                                    u282 = u282 + 1;
                                    local v350 = u281[u282];
                                    u283 = v350;

                                    if not v350 then
                                        return nil;
                                    end;

                                    local entities = v350.entities;
                                    u285 = #entities;

                                    if u285 ~= 0 then
                                        v344 = entities[u285];
                                        u284 = entities;
                                        local columns_map = v350.columns_map;
                                        u286 = columns_map;
                                        v345 = columns_map[u269];
                                        v346 = columns_map[u261];
                                        v347 = columns_map[u262];
                                        v348 = columns_map[u263];
                                        v349 = columns_map[u264];
                                        u272 = v345;
                                        u277 = v346;
                                        u279 = v347;
                                        u275 = v348;
                                        u273 = v349;
                                    end;
                                end;

                                local v351 = u285;
                                u285 = u285 - 1;

                                return v344, v345[v351], v346[v351], v347[v351], v348[v351], v349[v351];
                            end;
                        end;
                    else
                        u274 = function() -- Line: 2121, Name: world_query_iter_next
                            -- upvalues: u284 (ref), u285 (ref), u272 (ref), u277 (ref), u279 (ref), u275 (ref), u282 (ref), u281 (ref), u283 (ref), u286 (ref), u269 (ref), u261 (copy), u262 (copy), u263 (copy)
                            local v352 = u284[u285];
                            local v353 = u272;
                            local v354 = u277;
                            local v355 = u279;
                            local v356 = u275;

                            while v352 == nil do
                                u282 = u282 + 1;
                                local v357 = u281[u282];
                                u283 = v357;

                                if not v357 then
                                    return nil;
                                end;

                                local entities = v357.entities;
                                u285 = #entities;

                                if u285 ~= 0 then
                                    v352 = entities[u285];
                                    u284 = entities;
                                    local columns_map = v357.columns_map;
                                    u286 = columns_map;
                                    v353 = columns_map[u269];
                                    v354 = columns_map[u261];
                                    v355 = columns_map[u262];
                                    v356 = columns_map[u263];
                                    u272 = v353;
                                    u277 = v354;
                                    u279 = v355;
                                    u275 = v356;
                                end;
                            end;

                            local v358 = u285;
                            u285 = u285 - 1;

                            return v352, v353[v358], v354[v358], v355[v358], v356[v358];
                        end;
                    end;
                else
                    u274 = function() -- Line: 2082, Name: world_query_iter_next
                        -- upvalues: u284 (ref), u285 (ref), u272 (ref), u277 (ref), u279 (ref), u282 (ref), u281 (ref), u283 (ref), u286 (ref), u269 (ref), u261 (copy), u262 (copy)
                        local v359 = u284[u285];
                        local v360 = u272;
                        local v361 = u277;
                        local v362 = u279;

                        while v359 == nil do
                            u282 = u282 + 1;
                            local v363 = u281[u282];
                            u283 = v363;

                            if not v363 then
                                return nil;
                            end;

                            local entities = v363.entities;
                            u285 = #entities;

                            if u285 ~= 0 then
                                v359 = entities[u285];
                                u284 = entities;
                                local columns_map = v363.columns_map;
                                u286 = columns_map;
                                v360 = columns_map[u269];
                                v361 = columns_map[u261];
                                v362 = columns_map[u262];
                                u272 = v360;
                                u277 = v361;
                                u279 = v362;
                            end;
                        end;

                        local v364 = u285;
                        u285 = u285 - 1;

                        return v359, v360[v364], v361[v364], v362[v364];
                    end;
                end;
            else
                u274 = function() -- Line: 2046, Name: world_query_iter_next
                    -- upvalues: u284 (ref), u285 (ref), u272 (ref), u277 (ref), u282 (ref), u281 (ref), u283 (ref), u286 (ref), u269 (ref), u261 (copy)
                    local v365 = u284[u285];
                    local v366 = u272;
                    local v367 = u277;

                    while v365 == nil do
                        u282 = u282 + 1;
                        local v368 = u281[u282];
                        u283 = v368;

                        if not v368 then
                            return nil;
                        end;

                        local entities = v368.entities;
                        u285 = #entities;

                        if u285 ~= 0 then
                            v365 = entities[u285];
                            u284 = entities;
                            local columns_map = v368.columns_map;
                            u286 = columns_map;
                            v366 = columns_map[u269];
                            v367 = columns_map[u261];
                            u272 = v366;
                            u277 = v367;
                        end;
                    end;

                    local v369 = u285;
                    u285 = u285 - 1;

                    return v365, v366[v369], v367[v369];
                end;
            end;
        else
            u274 = function() -- Line: 2013, Name: world_query_iter_next
                -- upvalues: u284 (ref), u285 (ref), u272 (ref), u282 (ref), u281 (ref), u283 (ref), u286 (ref), u269 (ref)
                local v370 = u284[u285];
                local v371 = u272;

                while v370 == nil do
                    u282 = u282 + 1;
                    local v372 = u281[u282];
                    u283 = v372;

                    if not v372 then
                        return nil;
                    end;

                    local entities = v372.entities;
                    u285 = #entities;

                    if u285 ~= 0 then
                        v370 = entities[u285];
                        u284 = entities;
                        local columns_map = v372.columns_map;
                        u286 = columns_map;
                        v371 = columns_map[u269];
                        u272 = v371;
                    end;
                end;

                local v373 = u285;
                u285 = u285 - 1;

                return v370, v371[v373];
            end;
        end;
    else
        u274 = function() -- Line: 1988, Name: world_query_iter_next
            -- upvalues: u284 (ref), u285 (ref), u282 (ref), u281 (ref), u283 (ref)
            local v374 = u284[u285];

            while v374 == nil do
                u282 = u282 + 1;
                local v375 = u281[u282];
                u283 = v375;

                if not v375 then
                    return nil;
                end;

                local entities = v375.entities;
                u285 = #entities;

                if u285 ~= 0 then
                    v374 = entities[u285];
                    u284 = entities;
                end;
            end;

            u285 = u285 - 1;

            return v374;
        end;
    end;

    local entity_index = world.entity_index;

    local function cached_query_fini() -- Line: 2440
        -- upvalues: u288 (ref), u293 (copy), u290 (ref), u298 (copy), u281 (ref)
        local table_find_ret = table.find(u288, u293);

        if table_find_ret then
            table.remove(u288, table_find_ret);
        end;

        local table_find_ret2 = table.find(u290, u298);

        if table_find_ret2 then
            table.remove(u290, table_find_ret2);
        end;

        u281 = nil;
    end;

    p259.archetypes = query_archetypes;
    p259.__iter = cached_query_iter;
    p259.iter = cached_query_iter;

    function p259.has(p376, p377) -- Line: 2426
        -- upvalues: entity_index (copy), u271 (copy)
        local v378 = entity_index;
        local v379 = v378.sparse_array[p377 % 16777216];

        if not v379 or v379.dense == 0 then
            v379 = nil;
        end;

        if v379 and v378.dense_array[v379.dense] ~= p377 then
            v379 = nil;
        end;

        if not v379 then
            return false;
        end;

        local archetype = v379.archetype;

        if archetype then
            return u271[archetype.id] ~= nil;
        end;

        return false;
    end;

    p259.fini = cached_query_fini;
    setmetatable(p259, p259);

    return p259;
end;

function u258.has(p380: table, p381: number) -- Line: 2468
    local entity_index = p380.world.entity_index;
    local v382 = entity_index.sparse_array[p381 % 16777216];

    if not v382 or v382.dense == 0 then
        v382 = nil;
    end;

    if v382 then
        local dense = v382.dense;

        if entity_index.alive_count < dense then
            v382 = nil;
        elseif entity_index.dense_array[dense] ~= p381 then
            v382 = nil;
        end;
    end;

    if not v382 then
        return false;
    end;

    local archetype = v382.archetype;

    if not archetype then
        return false;
    end;

    local columns_map = archetype.columns_map;

    for _, v in p380.filter_with do
        if not columns_map[v] then
            return false;
        end;
    end;

    local filter_without = p380.filter_without;

    if filter_without then
        for _, v in filter_without do
            if columns_map[v] then
                return false;
            end;
        end;
    end;

    return true;
end;

local function world_query(p383: table, ...) -- Line: 2508
    -- upvalues: u258 (copy)
    local v384 = { ... };

    return setmetatable({
        ids = v384,
        filter_with = v384,
        world = p383
    }, u258);
end;

local function world_each(p385: table, p386: number) -- Line: 2519
    -- upvalues: NOOP (copy)
    local v387 = p385.component_index[p386];

    if not v387 then
        return NOOP;
    end;

    local records = v387.records;
    local archetypes = p385.archetypes;
    local u388 = next(records, nil);
    local u389 = archetypes[u388];

    if not u389 then
        return NOOP;
    end;

    local entities = u389.entities;
    local u390 = #entities;

    return function() -- Line: 2536
        -- upvalues: entities (ref), u390 (ref), u388 (ref), records (copy), u389 (ref), archetypes (copy)
        local v391 = entities[u390];

        while not v391 do
            u388 = next(records, u388);

            if not u388 then
                return nil;
            end;

            u389 = archetypes[u388];
            entities = u389.entities;
            u390 = #entities;
            v391 = entities[u390];
        end;

        u390 = u390 - 1;

        return v391;
    end;
end;

local function world_children(p392: table, p393: number) -- Line: 2553
    -- upvalues: NOOP (copy)
    local v394 = p392.component_index[p393 % 16777216 + 261 % 16777216 * 16777216 + 281474976710656];

    if not v394 then
        return NOOP;
    end;

    local records = v394.records;
    local archetypes = p392.archetypes;
    local u395 = next(records, nil);
    local u396 = archetypes[u395];

    if not u396 then
        return NOOP;
    end;

    local entities = u396.entities;
    local u397 = #entities;

    return function() -- Line: 2536
        -- upvalues: entities (ref), u397 (ref), u395 (ref), records (copy), u396 (ref), archetypes (copy)
        local v398 = entities[u397];

        while not v398 do
            u395 = next(records, u395);

            if not u395 then
                return nil;
            end;

            u396 = archetypes[u395];
            entities = u396.entities;
            u397 = #entities;
            v398 = entities[u397];
        end;

        u397 = u397 - 1;

        return v398;
    end;
end;

local function world_new(p399: boolean?) -- Line: 2702
    -- upvalues: u5 (ref), archetype_create (copy), table_freeze_ret (copy), archetype_delete (copy), archetype_destroy (copy), archetype_move (copy), world_query (copy), world_each (copy), world_children (copy), world_range (copy), ECS_ID (copy), ENTITY_INDEX_NEW_ID (copy), u6 (ref), u4 (ref), u1 (copy)
    local u400 = {};
    local u401 = {};
    local u402 = {
        alive_count = 0,
        max_id = 0,
        dense_array = u400,
        sparse_array = u401
    };
    local table_create_ret = table.create(271);
    local u403 = {};
    local u404 = {};
    local u405 = {};
    local u406 = {
        added = {},
        changed = {},
        removed = {}
    };
    local u407 = u5;
    local u408 = {
        ROOT_ARCHETYPE = nil,
        max_archetype_id = 0,
        archetype_edges = u405,
        component_index = table_create_ret,
        entity_index = u402,
        archetypes = u404,
        archetype_index = u403,
        max_component_id = u5,
        observable = {},
        signals = u406
    };
    local u409 = archetype_create(u408, {}, "");
    u408.ROOT_ARCHETYPE = u409;

    local function entity_index_try_get_any(p410: number) -- Line: 2754
        -- upvalues: u401 (copy)
        return u401[p410 % 16777216];
    end;

    local function inner_archetype_move(p411: number, p412: table, p413: number, p414: table, p415: number) -- Line: 2759
        -- upvalues: table_freeze_ret (ref), u401 (copy)
        local columns = p414.columns;
        local entities = p412.entities;
        local entities2 = p414.entities;
        local v416 = #entities2;
        local types = p414.types;
        local columns_map = p412.columns_map;

        if p415 == v416 then
            for i, v in columns do
                if v ~= table_freeze_ret then
                    local v417 = columns_map[types[i]];

                    if v417 then
                        v417[p413] = v[p415];
                    end;

                    v[v416] = nil;
                end;
            end;
        else
            for i, v in columns do
                if v ~= table_freeze_ret then
                    local v418 = columns_map[types[i]];

                    if v418 then
                        v418[p413] = v[p415];
                    end;

                    v[p415] = v[v416];
                    v[v416] = nil;
                end;
            end;

            local v419 = entities2[v416];
            entities2[p415] = v419;
            u401[v419 % 16777216].row = p415;
        end;

        entities2[v416] = nil;
        entities[p413] = p411;
    end;

    local function inner_entity_move(p420: number, p421: table, p422: table) -- Line: 2815
        -- upvalues: inner_archetype_move (copy)
        local row = p421.row;
        local archetype = p421.archetype;
        local entities = p422.entities;
        local v423 = #entities + 1;
        entities[v423] = p420;
        inner_archetype_move(p420, p422, v423, archetype, row);
        p421.archetype = p422;
        p421.row = v423;
    end;

    local function entity_index_try_get_unsafe(p424: number) -- Line: 2842
        -- upvalues: u401 (copy), u400 (copy)
        local v425 = u401[p424 % 16777216];

        if v425 and u400[v425.dense] ~= p424 then
            return nil;
        end;

        return v425;
    end;

    local function exclusive_traverse_add(p426: table, p427: number, p428: number) -- Line: 2858
        -- upvalues: u405 (copy), u408 (copy), archetype_create (ref)
        local v429 = u405[p426.id];
        local v430 = v429[p428];

        if not v430 then
            local table_clone_ret = table.clone(p426.types);
            table_clone_ret[p427] = p428;
            local v431 = u408;

            if #table_clone_ret < 1 then
                v430 = v431.ROOT_ARCHETYPE;
            else
                local table_concat_ret = table.concat(table_clone_ret, "_");
                v430 = v431.archetype_index[table_concat_ret] or archetype_create(v431, table_clone_ret, table_concat_ret);
            end;

            v429[p428] = v430;
        end;

        return v430;
    end;

    local function world_set(p432: table, p433: number, p434: number, p435: any) -- Line: 2874
        -- upvalues: u401 (copy), u400 (copy), u409 (copy), table_create_ret (copy), u405 (copy), u408 (copy), archetype_create (ref), inner_archetype_move (copy)
        local v436 = u401[p433 % 16777216];

        if v436 and u400[v436.dense] ~= p433 then
            v436 = nil;
        end;

        if not v436 then
            return;
        end;

        local archetype = v436.archetype;
        local v437 = archetype or u409;
        local v438 = v437.columns_map[p434];

        if v438 then
            local v439 = table_create_ret[p434];
            v438[v436.row] = p435;
            local on_change = v439.on_change;

            if on_change then
                on_change(p433, p434, p435, v437);
            end;
        else
            local v440, v441;

            if p434 > 281474976710656 then
                local v442 = 260 % 16777216 + (p434 - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656;
                v440 = table_create_ret[v442];
                local v443 = u405[v437.id];
                v441 = v443[p434];

                if v441 == nil then
                    if v440 and bit32.btest(v440.flags, 4) == true then
                        local v444 = v440.records[v437.id];

                        if v444 then
                            local on_remove = v440.on_remove;
                            local types = v437.types;

                            if on_remove then
                                on_remove(p433, types[v444]);
                                v437 = v436.archetype;
                                local _ = v437.types;
                                v444 = v440.records[v437.id];
                            end;

                            local v445 = u405[v437.id];
                            v441 = v445[p434];

                            if not v441 then
                                local table_clone_ret = table.clone(v437.types);
                                table_clone_ret[v444] = p434;
                                local v446 = u408;

                                if #table_clone_ret < 1 then
                                    v441 = v446.ROOT_ARCHETYPE;
                                else
                                    local table_concat_ret = table.concat(table_clone_ret, "_");
                                    v441 = v446.archetype_index[table_concat_ret] or archetype_create(v446, table_clone_ret, table_concat_ret);
                                end;

                                v445[p434] = v441;
                            end;
                        end;
                    end;

                    if not v441 then
                        local types = v437.types;
                        local table_clone_ret = table.clone(types);
                        local v447;

                        for i, v in types do
                            if v == p434 then
                                v447 = -1;
                                break;
                            end;

                            if p434 < v then
                                v447 = i;
                                break;
                            end;
                        end;

                        v447 = #types + 1;
                        table.insert(table_clone_ret, v447, p434);

                        if #table_clone_ret < 1 then
                            v441 = p432.ROOT_ARCHETYPE;
                        else
                            local table_concat_ret = table.concat(table_clone_ret, "_");
                            v441 = p432.archetype_index[table_concat_ret] or archetype_create(p432, table_clone_ret, table_concat_ret);
                        end;

                        v440 = v440 or table_create_ret[v442];
                        v443[p434] = v441;
                        u405[v441.id][p434] = v437;
                    end;
                elseif bit32.btest(v440.flags, 4) then
                    local on_remove = v440.on_remove;

                    if on_remove then
                        local v448 = v440.records[v437.id];

                        if v448 then
                            on_remove(p433, v437.types[v448]);
                            local archetype2 = v436.archetype;

                            if v437 ~= archetype2 then
                                local _ = archetype2.types;
                                local v449 = v440.records[archetype2.id];
                                local v450 = u405[archetype2.id];
                                v441 = v450[p434];

                                if not v441 then
                                    local table_clone_ret = table.clone(archetype2.types);
                                    table_clone_ret[v449] = p434;
                                    local v451 = u408;

                                    if #table_clone_ret < 1 then
                                        v441 = v451.ROOT_ARCHETYPE;
                                    else
                                        local table_concat_ret = table.concat(table_clone_ret, "_");
                                        v441 = v451.archetype_index[table_concat_ret] or archetype_create(v451, table_clone_ret, table_concat_ret);
                                    end;

                                    v450[p434] = v441;
                                end;
                            end;
                        end;
                    end;
                end;
            else
                local v452 = u405;
                local v453 = v452[v437.id];
                v441 = v453[p434];

                if not v441 then
                    local types = v437.types;
                    local table_clone_ret = table.clone(types);
                    local v454;

                    for i, v in types do
                        if v == p434 then
                            v454 = -1;
                            break;
                        end;

                        if p434 < v then
                            v454 = i;
                            break;
                        end;
                    end;

                    v454 = #types + 1;
                    table.insert(table_clone_ret, v454, p434);

                    if #table_clone_ret < 1 then
                        v441 = p432.ROOT_ARCHETYPE;
                    else
                        local table_concat_ret = table.concat(table_clone_ret, "_");
                        v441 = p432.archetype_index[table_concat_ret] or archetype_create(p432, table_clone_ret, table_concat_ret);
                    end;

                    v453[p434] = v441;
                    v452[v441.id][p434] = v437;
                end;

                v440 = table_create_ret[p434];
            end;

            if archetype then
                local row = v436.row;
                local archetype2 = v436.archetype;
                local entities = v441.entities;
                local v455 = #entities + 1;
                entities[v455] = p433;
                inner_archetype_move(p433, v441, v455, archetype2, row);
                v436.archetype = v441;
                v436.row = v455;
            else
                local entities = v441.entities;
                local v456 = #entities + 1;
                entities[v456] = p433;
                v436.archetype = v441;
                v436.row = v456;
            end;

            v441.columns_map[p434][v436.row] = p435;
            local on_add = v440.on_add;

            if on_add then
                on_add(p433, p434, p435, v437);
            end;
        end;
    end;

    local function world_add(p457: table, p458: number, p459: number) -- Line: 2977
        -- upvalues: u401 (copy), u400 (copy), u409 (copy), table_create_ret (copy), u405 (copy), u408 (copy), archetype_create (ref), inner_archetype_move (copy)
        local v460 = u401[p458 % 16777216];

        if v460 and u400[v460.dense] ~= p458 then
            v460 = nil;
        end;

        if not v460 then
            return;
        end;

        local archetype = v460.archetype;
        local v461 = archetype or u409;

        if v461.columns_map[p459] then
            return;
        end;

        local v462, v463;

        if p459 > 281474976710656 then
            local v464 = 260 % 16777216 + (p459 - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656;
            v462 = table_create_ret[v464];
            local v465 = u405[v461.id];
            v463 = v465[p459];

            if v463 == nil then
                if v462 and bit32.btest(v462.flags, 4) == true then
                    local v466 = v462.records[v461.id];

                    if v466 then
                        local on_remove = v462.on_remove;
                        local types = v461.types;

                        if on_remove then
                            on_remove(p458, types[v466]);
                            v461 = v460.archetype;
                            local _ = v461.types;
                            v466 = v462.records[v461.id];
                        end;

                        local v467 = u405[v461.id];
                        v463 = v467[p459];

                        if not v463 then
                            local table_clone_ret = table.clone(v461.types);
                            table_clone_ret[v466] = p459;
                            local v468 = u408;

                            if #table_clone_ret < 1 then
                                v463 = v468.ROOT_ARCHETYPE;
                            else
                                local table_concat_ret = table.concat(table_clone_ret, "_");
                                v463 = v468.archetype_index[table_concat_ret] or archetype_create(v468, table_clone_ret, table_concat_ret);
                            end;

                            v467[p459] = v463;
                        end;
                    end;
                end;

                if not v463 then
                    local types = v461.types;
                    local table_clone_ret = table.clone(types);
                    local v469;

                    for i, v in types do
                        if v == p459 then
                            v469 = -1;
                            break;
                        end;

                        if p459 < v then
                            v469 = i;
                            break;
                        end;
                    end;

                    v469 = #types + 1;
                    table.insert(table_clone_ret, v469, p459);

                    if #table_clone_ret < 1 then
                        v463 = p457.ROOT_ARCHETYPE;
                    else
                        local table_concat_ret = table.concat(table_clone_ret, "_");
                        v463 = p457.archetype_index[table_concat_ret] or archetype_create(p457, table_clone_ret, table_concat_ret);
                    end;

                    v462 = v462 or table_create_ret[v464];
                    v465[p459] = v463;
                    u405[v463.id][p459] = v461;
                end;
            elseif bit32.btest(v462.flags, 4) then
                local on_remove = v462.on_remove;

                if on_remove then
                    local v470 = v462.records[v461.id];

                    if v470 then
                        on_remove(p458, v461.types[v470]);
                        local archetype2 = v460.archetype;

                        if v461 ~= archetype2 then
                            local _ = archetype2.types;
                            local v471 = v462.records[archetype2.id];
                            local v472 = u405[archetype2.id];
                            v463 = v472[p459];

                            if not v463 then
                                local table_clone_ret = table.clone(archetype2.types);
                                table_clone_ret[v471] = p459;
                                local v473 = u408;

                                if #table_clone_ret < 1 then
                                    v463 = v473.ROOT_ARCHETYPE;
                                else
                                    local table_concat_ret = table.concat(table_clone_ret, "_");
                                    v463 = v473.archetype_index[table_concat_ret] or archetype_create(v473, table_clone_ret, table_concat_ret);
                                end;

                                v472[p459] = v463;
                            end;
                        end;
                    end;
                end;
            end;
        else
            local v474 = u405;
            local v475 = v474[v461.id];
            v463 = v475[p459];

            if not v463 then
                local types = v461.types;
                local table_clone_ret = table.clone(types);
                local v476;

                for i, v in types do
                    if v == p459 then
                        v476 = -1;
                        break;
                    end;

                    if p459 < v then
                        v476 = i;
                        break;
                    end;
                end;

                v476 = #types + 1;
                table.insert(table_clone_ret, v476, p459);

                if #table_clone_ret < 1 then
                    v463 = p457.ROOT_ARCHETYPE;
                else
                    local table_concat_ret = table.concat(table_clone_ret, "_");
                    v463 = p457.archetype_index[table_concat_ret] or archetype_create(p457, table_clone_ret, table_concat_ret);
                end;

                v475[p459] = v463;
                v474[v463.id][p459] = v461;
            end;

            v462 = table_create_ret[p459];
        end;

        if archetype then
            local row = v460.row;
            local archetype2 = v460.archetype;
            local entities = v463.entities;
            local v477 = #entities + 1;
            entities[v477] = p458;
            inner_archetype_move(p458, v463, v477, archetype2, row);
            v460.archetype = v463;
            v460.row = v477;
        elseif #v463.types > 0 then
            local entities = v463.entities;
            local v478 = #entities + 1;
            entities[v478] = p458;
            v460.archetype = v463;
            v460.row = v478;
        end;

        local on_add = v462.on_add;

        if on_add then
            on_add(p458, p459, nil, v461);
        end;
    end;

    function u408.added(p479: table, p480: number, u481: any) -- Line: 3109
        -- upvalues: u406 (copy), u408 (copy), u401 (copy), u400 (copy), table_create_ret (copy), world_set (copy)
        local u482 = u406.added[p480];

        if not u482 then
            u482 = {};
            u406.added[p480] = u482;

            local function on_add(p483, p484, p485, p486) -- Line: 3115
                -- upvalues: u482 (ref)
                for _, v in u482 do
                    v(p483, p484, p485, p486);
                end;
            end;

            local v487 = u401[p480 % 16777216];

            if v487 and u400[v487.dense] ~= p480 then
                v487 = nil;
            end;

            local v488;

            if v487 then
                local archetype = v487.archetype;

                if archetype then
                    local row = v487.row;
                    local v489 = archetype.columns_map[257];

                    if v489 then
                        v488 = v489[row];
                    else
                        v488 = nil;
                    end;
                else
                    v488 = nil;
                end;
            else
                v488 = nil;
            end;

            if v488 then
                table.insert(u482, v488);
            end;

            local v490 = table_create_ret[260 % 16777216 + p480 % 16777216 * 16777216 + 281474976710656];

            if v490 then
                for _, v in v490.wildcard_pairs do
                    v.on_add = on_add;
                end;

                v490.on_add = on_add;
            else
                local v491 = table_create_ret[p480];

                if v491 then
                    v491.on_add = on_add;
                end;
            end;

            world_set(u408, p480, 257, on_add);
        end;

        table.insert(u482, u481);

        return function() -- Line: 3141
            -- upvalues: u482 (ref), u481 (copy)
            local v492 = #u482;
            u482[table.find(u482, u481)] = u482[v492];
            u482[v492] = nil;
        end;
    end;

    function u408.changed(p493: table, p494: number, u495: any) -- Line: 3149
        -- upvalues: u406 (copy), u408 (copy), u401 (copy), u400 (copy), table_create_ret (copy), world_set (copy)
        local u496 = u406.changed[p494];

        if not u496 then
            u496 = {};
            u406.changed[p494] = u496;

            local function on_change(p497, p498, p499, p500) -- Line: 3158
                -- upvalues: u496 (ref)
                for _, v in u496 do
                    v(p497, p498, p499, p500);
                end;
            end;

            local v501 = u401[p494 % 16777216];

            if v501 and u400[v501.dense] ~= p494 then
                v501 = nil;
            end;

            local v502;

            if v501 then
                local archetype = v501.archetype;

                if archetype then
                    local row = v501.row;
                    local v503 = archetype.columns_map[259];

                    if v503 then
                        v502 = v503[row];
                    else
                        v502 = nil;
                    end;
                else
                    v502 = nil;
                end;
            else
                v502 = nil;
            end;

            if v502 then
                table.insert(u496, v502);
            end;

            local v504 = table_create_ret[260 % 16777216 + p494 % 16777216 * 16777216 + 281474976710656];

            if v504 then
                for _, v in v504.wildcard_pairs do
                    v.on_change = on_change;
                end;

                v504.on_change = on_change;
            else
                local v505 = table_create_ret[p494];

                if v505 then
                    v505.on_change = on_change;
                end;
            end;

            world_set(u408, p494, 259, on_change);
        end;

        table.insert(u496, u495);

        return function() -- Line: 3186
            -- upvalues: u496 (ref), u495 (copy)
            local v506 = #u496;
            u496[table.find(u496, u495)] = u496[v506];
            u496[v506] = nil;
        end;
    end;

    function u408.removed(p507: table, p508: number, u509: function) -- Line: 3194
        -- upvalues: u406 (copy), u408 (copy), u401 (copy), u400 (copy), table_create_ret (copy), world_set (copy)
        local u510 = u406.removed[p508];

        if not u510 then
            u510 = {};
            u406.removed[p508] = u510;

            local function on_remove(p511, p512, p513) -- Line: 3199
                -- upvalues: u510 (ref)
                for _, v in u510 do
                    v(p511, p512, p513);
                end;
            end;

            local v514 = u401[p508 % 16777216];

            if v514 and u400[v514.dense] ~= p508 then
                v514 = nil;
            end;

            local v515;

            if v514 then
                local archetype = v514.archetype;

                if archetype then
                    local row = v514.row;
                    local v516 = archetype.columns_map[258];

                    if v516 then
                        v515 = v516[row];
                    else
                        v515 = nil;
                    end;
                else
                    v515 = nil;
                end;
            else
                v515 = nil;
            end;

            if v515 then
                table.insert(u510, v515);
            end;

            local v517 = table_create_ret[260 % 16777216 + p508 % 16777216 * 16777216 + 281474976710656];

            if v517 then
                for _, v in v517.wildcard_pairs do
                    v.on_remove = on_remove;
                end;

                v517.on_remove = on_remove;
            else
                local v518 = table_create_ret[p508];

                if v518 then
                    v518.on_remove = on_remove;
                end;
            end;

            world_set(u408, p508, 258, on_remove);
        end;

        table.insert(u510, u509);

        return function() -- Line: 3230
            -- upvalues: u510 (ref), u509 (copy)
            local v519 = #u510;
            u510[table.find(u510, u509)] = u510[v519];
            u510[v519] = nil;
        end;
    end;

    local function world_target(p520: table, p521: number, p522: number, p523: number?) -- Line: 3260
        -- upvalues: u401 (copy), u400 (copy)
        local v524 = u401[p521 % 16777216];

        if v524 and u400[v524.dense] ~= p521 then
            v524 = nil;
        end;

        if not v524 then
            return nil;
        end;

        local archetype = v524.archetype;

        if not archetype then
            return nil;
        end;

        local v525 = p520.component_index[260 % 16777216 + p522 % 16777216 * 16777216 + 281474976710656];

        if not v525 then
            return nil;
        end;

        local id = archetype.id;
        local v526 = v525.counts[id];

        if not v526 then
            return nil;
        end;

        local v527 = p523 or 0;

        if v526 <= v527 then
            return nil;
        end;

        local v528 = archetype.types[v527 + v525.records[id]];

        if not v528 then
            return nil;
        end;

        local entity_index = p520.entity_index;
        local v529 = entity_index.sparse_array[(v528 - 281474976710656) % 16777216 % 16777216];

        if not v529 or v529.dense == 0 then
            v529 = nil;
        end;

        if not v529 then
            return nil;
        end;

        local dense = v529.dense;

        if entity_index.alive_count < dense then
            return nil;
        end;

        return entity_index.dense_array[dense];
    end;

    local function world_remove(p530: table, p531: number, p532: number) -- Line: 3384
        -- upvalues: u401 (copy), u400 (copy), archetype_create (ref), inner_archetype_move (copy)
        local v533 = u401[p531 % 16777216];

        if v533 and u400[v533.dense] ~= p531 then
            v533 = nil;
        end;

        if not v533 then
            return;
        end;

        local archetype = v533.archetype;

        if not archetype then
            return;
        end;

        if archetype.columns_map[p532] then
            local on_remove = p530.component_index[p532].on_remove;

            if on_remove then
                on_remove(p531, p532);
            end;

            local archetype2 = v533.archetype;
            local archetype_edges = p530.archetype_edges;
            local v534 = archetype_edges[archetype2.id];
            local v535 = v534[p532];

            if v535 == nil then
                local types = archetype2.types;
                local table_find_ret = table.find(types, p532);
                local table_clone_ret = table.clone(types);
                table.remove(table_clone_ret, table_find_ret);

                if #table_clone_ret < 1 then
                    v535 = p530.ROOT_ARCHETYPE;
                else
                    local table_concat_ret = table.concat(table_clone_ret, "_");
                    v535 = p530.archetype_index[table_concat_ret] or archetype_create(p530, table_clone_ret, table_concat_ret);
                end;

                v534[p532] = v535;
                archetype_edges[v535.id][p532] = archetype2;
            end;

            local row = v533.row;
            local archetype3 = v533.archetype;
            local entities = v535.entities;
            local v536 = #entities + 1;
            entities[v536] = p531;
            inner_archetype_move(p531, v535, v536, archetype3, row);
            v533.archetype = v535;
            v533.row = v536;
        end;
    end;

    local function world_delete(p537: table, p538: number) -- Line: 3409
        -- upvalues: u401 (copy), u400 (copy), table_create_ret (copy), archetype_delete (ref), world_delete (ref), archetype_destroy (ref), archetype_create (ref), inner_archetype_move (copy), u402 (copy), archetype_move (ref)
        local v539 = u401[p538 % 16777216];

        if v539 and u400[v539.dense] ~= p538 then
            v539 = nil;
        end;

        if not v539 then
            return;
        end;

        local archetype = v539.archetype;

        if archetype then
            for _, v in archetype.types do
                local on_remove = table_create_ret[v].on_remove;

                if on_remove then
                    on_remove(p538, v, true);
                end;
            end;

            archetype_delete(p537, v539.archetype, v539.row);
        end;

        local component_index = p537.component_index;
        local archetypes = p537.archetypes;
        local v540 = component_index[p538 % 16777216 + 260 % 16777216 * 16777216 + 281474976710656];
        local v541 = component_index[p538];
        local v542 = component_index[260 % 16777216 + p538 % 16777216 * 16777216 + 281474976710656];

        if v541 then
            if bit32.btest(v541.flags, 1) == true then
                for i in v541.records do
                    local v543 = archetypes[i];
                    local entities = v543.entities;

                    for i2 = #entities, 1, -1 do
                        world_delete(p537, entities[i2]);
                        local _ = i2;
                    end;

                    archetype_destroy(p537, v543);
                end;
            else
                local on_remove = v541.on_remove;

                if on_remove then
                    for i in v541.records do
                        local v544 = archetypes[i];
                        local archetype_edges = p537.archetype_edges;
                        local v545 = archetype_edges[v544.id];
                        local v546 = v545[p538];

                        if v546 == nil then
                            local types = v544.types;
                            local table_find_ret = table.find(types, p538);
                            local table_clone_ret = table.clone(types);
                            table.remove(table_clone_ret, table_find_ret);

                            if #table_clone_ret < 1 then
                                v546 = p537.ROOT_ARCHETYPE;
                            else
                                local table_concat_ret = table.concat(table_clone_ret, "_");
                                v546 = p537.archetype_index[table_concat_ret] or archetype_create(p537, table_clone_ret, table_concat_ret);
                            end;

                            v545[p538] = v546;
                            archetype_edges[v546.id][p538] = v544;
                        end;

                        local entities = v544.entities;

                        for i2 = #entities, 1, -1 do
                            local v547 = entities[i2];
                            on_remove(v547, p538);
                            local v548 = u401[v547 % 16777216];
                            local archetype2 = v548.archetype;

                            if archetype2 ~= v544 then
                                local archetype_edges2 = p537.archetype_edges;
                                local v549 = archetype_edges2[archetype2.id];
                                v546 = v549[p538];

                                if v546 == nil then
                                    local types = archetype2.types;
                                    local table_find_ret = table.find(types, p538);
                                    local table_clone_ret = table.clone(types);
                                    table.remove(table_clone_ret, table_find_ret);

                                    if #table_clone_ret < 1 then
                                        v546 = p537.ROOT_ARCHETYPE;
                                    else
                                        local table_concat_ret = table.concat(table_clone_ret, "_");
                                        v546 = p537.archetype_index[table_concat_ret] or archetype_create(p537, table_clone_ret, table_concat_ret);
                                    end;

                                    v549[p538] = v546;
                                    archetype_edges2[v546.id][p538] = archetype2;
                                end;
                            end;

                            local row = v548.row;
                            local archetype3 = v548.archetype;
                            local entities2 = v546.entities;
                            local v550 = #entities2 + 1;
                            entities2[v550] = v547;
                            inner_archetype_move(v547, v546, v550, archetype3, row);
                            v548.archetype = v546;
                            v548.row = v550;
                            local _ = i2;
                        end;

                        archetype_destroy(p537, v544);
                    end;
                else
                    for i in v541.records do
                        local v551 = archetypes[i];
                        local archetype_edges = p537.archetype_edges;
                        local v552 = archetype_edges[v551.id];
                        local v553 = v552[p538];

                        if v553 == nil then
                            local types = v551.types;
                            local table_find_ret = table.find(types, p538);
                            local table_clone_ret = table.clone(types);
                            table.remove(table_clone_ret, table_find_ret);

                            if #table_clone_ret < 1 then
                                v553 = p537.ROOT_ARCHETYPE;
                            else
                                local table_concat_ret = table.concat(table_clone_ret, "_");
                                v553 = p537.archetype_index[table_concat_ret] or archetype_create(p537, table_clone_ret, table_concat_ret);
                            end;

                            v552[p538] = v553;
                            archetype_edges[v553.id][p538] = v551;
                        end;

                        local entities = v551.entities;

                        for i2 = #entities, 1, -1 do
                            local v554 = entities[i2];
                            local v555 = u401[v554 % 16777216];
                            local row = v555.row;
                            local archetype2 = v555.archetype;
                            local entities2 = v553.entities;
                            local v556 = #entities2 + 1;
                            entities2[v556] = v554;
                            archetype_move(u402, v554, v553, v556, archetype2, row);
                            v555.archetype = v553;
                            v555.row = v556;
                            local _ = i2;
                        end;

                        archetype_destroy(p537, v551);
                    end;
                end;
            end;
        end;

        if v540 then
            local records = v540.records;
            local v557 = {};
            local v558 = false;

            for i in records do
                local v559 = archetypes[i];

                if v559 then
                    local types = v559.types;
                    local entities = v559.entities;
                    local v560 = 0;
                    local v561 = false;

                    for _, v in types do
                        if v > 281474976710656 then
                            local v562 = u402;
                            local v563 = v562.sparse_array[(v - 281474976710656) % 16777216 % 16777216];

                            if not v563 or v563.dense == 0 then
                                v563 = nil;
                            end;

                            local v564;

                            if v563 then
                                local dense = v563.dense;

                                if v562.alive_count < dense then
                                    v564 = nil;
                                else
                                    v564 = v562.dense_array[dense];
                                end;
                            else
                                v564 = nil;
                            end;

                            if v564 == p538 then
                                local v565 = component_index[v];

                                if bit32.btest(v565.flags, 1) then
                                    for i2 = #entities, 1, -1 do
                                        world_delete(p537, entities[i2]);
                                        local _ = i2;
                                    end;

                                    v561 = true;
                                    break;
                                end;

                                v557[v] = v565;
                                v560 = v560 + 1;
                            end;
                        end;
                    end;

                    if v561 then
                        v558 = true;
                    else
                        if v560 == 1 then
                            local v566, v567 = next(v557);
                            local archetype_edges = p537.archetype_edges;
                            local v568 = archetype_edges[v559.id];
                            local v569 = v568[v566];

                            if v569 == nil then
                                local types2 = v559.types;
                                local table_find_ret = table.find(types2, v566);
                                local table_clone_ret = table.clone(types2);
                                table.remove(table_clone_ret, table_find_ret);

                                if #table_clone_ret < 1 then
                                    v569 = p537.ROOT_ARCHETYPE;
                                else
                                    local table_concat_ret = table.concat(table_clone_ret, "_");
                                    v569 = p537.archetype_index[table_concat_ret] or archetype_create(p537, table_clone_ret, table_concat_ret);
                                end;

                                v568[v566] = v569;
                                archetype_edges[v569.id][v566] = v559;
                            end;

                            local on_remove = v567.on_remove;

                            for i2 = #entities, 1, -1 do
                                local v570 = entities[i2];
                                local v571 = u401[v570 % 16777216];

                                if v571 and u400[v571.dense] ~= v570 then
                                    v571 = nil;
                                end;

                                local v572;

                                if on_remove then
                                    on_remove(v570, v566);
                                    local archetype2 = v571.archetype;

                                    if archetype2 == v559 then
                                        v572 = v569;
                                    else
                                        local archetype_edges2 = p537.archetype_edges;
                                        local v573 = archetype_edges2[archetype2.id];
                                        v572 = v573[v566];

                                        if v572 == nil then
                                            local types2 = archetype2.types;
                                            local table_find_ret = table.find(types2, v566);
                                            local table_clone_ret = table.clone(types2);
                                            table.remove(table_clone_ret, table_find_ret);

                                            if #table_clone_ret < 1 then
                                                v572 = p537.ROOT_ARCHETYPE;
                                            else
                                                local table_concat_ret = table.concat(table_clone_ret, "_");
                                                v572 = p537.archetype_index[table_concat_ret] or archetype_create(p537, table_clone_ret, table_concat_ret);
                                            end;

                                            v573[v566] = v572;
                                            archetype_edges2[v572.id][v566] = archetype2;
                                        end;
                                    end;
                                else
                                    v572 = v569;
                                end;

                                local row = v571.row;
                                local archetype2 = v571.archetype;
                                local entities2 = v572.entities;
                                local v574 = #entities2 + 1;
                                entities2[v574] = v570;
                                inner_archetype_move(v570, v572, v574, archetype2, row);
                                v571.archetype = v572;
                                v571.row = v574;
                                local _ = i2;
                            end;
                        elseif v560 > 1 then
                            local table_clone_ret = table.clone(types);

                            for i2, _ in v557 do
                                table.remove(table_clone_ret, table.find(table_clone_ret, i2));
                            end;

                            local v575;

                            if #table_clone_ret < 1 then
                                v575 = p537.ROOT_ARCHETYPE;
                            else
                                local table_concat_ret = table.concat(table_clone_ret, "_");
                                v575 = p537.archetype_index[table_concat_ret] or archetype_create(p537, table_clone_ret, table_concat_ret);
                            end;

                            for i2 = #entities, 1, -1 do
                                local v576 = entities[i2];
                                local v577 = u401[v576 % 16777216];

                                if v577 and u400[v577.dense] ~= v576 then
                                    v577 = nil;
                                end;

                                local v578 = v575;
                                local _ = i2;

                                for i3, v in v557 do
                                    local on_remove = v.on_remove;

                                    if on_remove then
                                        on_remove(v576, i3);
                                        local archetype2 = v577.archetype;

                                        if archetype2 ~= v559 then
                                            local archetype_edges = p537.archetype_edges;
                                            local v579 = archetype_edges[archetype2.id];
                                            v575 = v579[i3];

                                            if v575 == nil then
                                                local types2 = archetype2.types;
                                                local table_find_ret = table.find(types2, i3);
                                                local table_clone_ret2 = table.clone(types2);
                                                table.remove(table_clone_ret2, table_find_ret);

                                                if #table_clone_ret2 < 1 then
                                                    v575 = p537.ROOT_ARCHETYPE;
                                                else
                                                    local table_concat_ret = table.concat(table_clone_ret2, "_");
                                                    v575 = p537.archetype_index[table_concat_ret] or archetype_create(p537, table_clone_ret2, table_concat_ret);
                                                end;

                                                v579[i3] = v575;
                                                archetype_edges[v575.id][i3] = archetype2;
                                            end;
                                        end;
                                    end;
                                end;

                                local row = v577.row;
                                local archetype2 = v577.archetype;
                                local entities2 = v575.entities;
                                local v580 = #entities2 + 1;
                                entities2[v580] = v576;
                                inner_archetype_move(v576, v575, v580, archetype2, row);
                                v577.archetype = v575;
                                v577.row = v580;
                                v575 = v578;
                            end;
                        end;

                        table.clear(v557);
                        archetype_destroy(p537, v559);
                    end;
                end;
            end;

            if v558 then
                for i in records do
                    local v581 = archetypes[i];

                    if v581 then
                        local entities = v581.entities;

                        for i2 = #entities, 1, -1 do
                            world_delete(p537, entities[i2]);
                            local _ = i2;
                        end;

                        archetype_destroy(p537, v581);
                    end;
                end;
            end;
        end;

        if v542 then
            local records = v542.records;

            if bit32.btest(v542.flags, 1) then
                for i in records do
                    local v582 = archetypes[i];
                    local entities = v582.entities;

                    for i2 = #entities, 1, -1 do
                        world_delete(p537, entities[i2]);
                        local _ = i2;
                    end;

                    archetype_destroy(p537, v582);
                end;
            else
                local counts = v542.counts;
                local records2 = v542.records;

                for i in records do
                    local v583 = archetypes[i];
                    local entities = v583.entities;
                    local v584 = records2[i];
                    local v585 = counts[i];
                    local types = v583.types;
                    local table_clone_ret = table.clone(types);

                    for i2 = v584, v584 + v585 - 1 do
                        local v586 = types[i2];
                        local table_find_ret = table.find(table_clone_ret, v586);

                        if table_find_ret then
                            table.remove(table_clone_ret, table_find_ret);
                        end;

                        local on_remove = component_index[v586].on_remove;
                        local v587;

                        if on_remove then
                            v587 = i2;

                            for _, v in entities do
                                on_remove(v, v586);
                            end;
                        else
                            v587 = i2;
                        end;
                    end;

                    local v588;

                    if #table_clone_ret < 1 then
                        v588 = p537.ROOT_ARCHETYPE;
                    else
                        local table_concat_ret = table.concat(table_clone_ret, "_");
                        v588 = p537.archetype_index[table_concat_ret] or archetype_create(p537, table_clone_ret, table_concat_ret);
                    end;

                    for i2 = #entities, 1, -1 do
                        local v589 = entities[i2];
                        local v590 = u401[v589 % 16777216];

                        if v590 and u400[v590.dense] ~= v589 then
                            v590 = nil;
                        end;

                        local row = v590.row;
                        local archetype2 = v590.archetype;
                        local entities2 = v588.entities;
                        local v591 = #entities2 + 1;
                        entities2[v591] = v589;
                        inner_archetype_move(v589, v588, v591, archetype2, row);
                        v590.archetype = v588;
                        v590.row = v591;
                        local _ = i2;
                    end;

                    archetype_destroy(p537, v583);
                end;
            end;
        end;

        local dense = v539.dense;
        local alive_count = u402.alive_count;
        u402.alive_count = alive_count - 1;
        local v592 = u400[alive_count];
        u401[v592 % 16777216].dense = dense;
        v539.archetype = nil;
        v539.row = nil;
        v539.dense = alive_count;
        u400[dense] = v592;
        local v593;

        if p538 > 16777216 then
            v593 = p538 % 16777216;
            local v594 = p538 // 16777216 + 1;

            if v594 < 65536 then
                v593 = v593 + v594 * 16777216;
            end;
        else
            v593 = p538 + 16777216;
        end;

        u400[alive_count] = v593;
    end;

    local function world_clear(p595: table, p596: number) -- Line: 3698
        -- upvalues: u401 (copy), u400 (copy), table_create_ret (copy), archetype_delete (ref)
        local v597 = u401[p596 % 16777216];

        if v597 and u400[v597.dense] ~= p596 then
            v597 = nil;
        end;

        if not v597 then
            return;
        end;

        for _, v in v597.archetype.types do
            local on_remove = table_create_ret[v].on_remove;

            if on_remove then
                on_remove(p596, v);
            end;
        end;

        archetype_delete(p595, v597.archetype, v597.row);
        v597.archetype = nil;
        v597.row = nil;
    end;

    local function world_cleanup(p598: table) -- Line: 3729
        -- upvalues: u404 (ref), archetype_destroy (ref), u403 (ref)
        for _, v in u404 do
            if #v.entities == 0 then
                archetype_destroy(p598, v);
            end;
        end;

        local v599 = {};
        local v600 = {};

        for i, v in u404 do
            v599[i] = v;
            v600[v.type] = v;
        end;

        u404 = v599;
        u403 = v600;
        p598.archetypes = v599;
        p598.archetype_index = v600;
    end;

    local function world_component(p601: table) -- Line: 3751
        -- upvalues: u407 (ref), world_add (copy)
        if u407 + 1 > 256 then
            error("Too many components, consider using world:entity() instead to create components.");
        end;

        u407 = u407 + 1;
        p601.max_component_id = u407;
        world_add(p601, u407, 262);

        return u407;
    end;

    function u408.entity(p602: table, p603: number?) -- Line: 3304
        -- upvalues: u401 (copy), u400 (copy), u402 (copy)
        local v604 = u401;
        local v605 = u400;

        if p603 then
            local v606 = p603 % 16777216;
            local alive_count = u402.alive_count;
            local v607 = v604[v606];

            if not v607 then
                local max_id = u402.max_id;

                if max_id < v606 then
                    for i = max_id + 1, v606 - 1 do
                        v604[i] = {
                            dense = 0
                        };
                        local _ = i;
                    end;

                    u402.max_id = v606;
                end;

                local v608 = alive_count + 1;
                u402.alive_count = v608;
                v605[v608] = p603;
                v604[v606] = {
                    dense = v608
                };

                return p603;
            end;

            local dense = v607.dense;

            if dense == 0 then
                local v609 = alive_count + 1;
                u402.alive_count = v609;
                v607.dense = v609;
                v605[v609] = p603;

                return p603;
            end;

            local v610 = v605[dense];

            if not v610 or v610 == p603 then
                return p603;
            end;

            local v611 = alive_count + 1;
            u402.alive_count = v611;
            v607.dense = v611;
            v605[v611] = p603;

            return p603;
        end;

        local alive_count = u402.alive_count;
        local max_id = u402.max_id;
        local v612 = alive_count + 1;
        local v613 = alive_count < max_id and v605[v612];

        if v613 then
            u402.alive_count = v612;

            return v613;
        end;

        local v614 = max_id + 1;
        local range_end = u402.range_end;

        if range_end ~= nil and v614 >= range_end then
            error("Entity is outside range");
        end;

        u402.max_id = v614;
        u402.alive_count = v612;
        v605[v612] = v614;
        v604[v614] = {
            dense = v612
        };

        return v614;
    end;

    u408.query = world_query;
    u408.remove = world_remove;
    u408.clear = world_clear;
    u408.delete = world_delete;
    u408.component = world_component;
    u408.add = world_add;
    u408.set = world_set;

    function u408.get(p615: table, p616: number, p617: number, p618: number?, p619: number?, p620: number?, p621: number?) -- Line: 3075
        -- upvalues: u401 (copy), u400 (copy)
        local v622 = u401[p616 % 16777216];

        if v622 and u400[v622.dense] ~= p616 then
            v622 = nil;
        end;

        if not v622 then
            return nil;
        end;

        local archetype = v622.archetype;

        if not archetype then
            return nil;
        end;

        local columns_map = archetype.columns_map;
        local row = v622.row;
        local v623 = columns_map[p617];
        local v624;

        if v623 then
            v624 = v623[row];
        else
            v624 = nil;
        end;

        if not p618 then
            return v624;
        end;

        if not p619 then
            local v625 = columns_map[p618];

            if v625 then
                return v624, v625[row];
            end;

            return v624, nil;
        end;

        if not p620 then
            local v626 = columns_map[p618];
            local v627;

            if v626 then
                v627 = v626[row];
            else
                v627 = nil;
            end;

            local v628 = columns_map[p619];

            if v628 then
                return v624, v627, v628[row];
            end;

            return v624, v627, nil;
        end;

        if not p621 then
            local v629 = columns_map[p618];
            local v630;

            if v629 then
                v630 = v629[row];
            else
                v630 = nil;
            end;

            local v631 = columns_map[p619];
            local v632;

            if v631 then
                v632 = v631[row];
            else
                v632 = nil;
            end;

            local v633 = columns_map[p620];

            if v633 then
                return v624, v630, v632, v633[row];
            end;

            return v624, v630, v632, nil;
        end;

        error("args exceeded");
    end;

    function u408.has(p634: table, p635: number, p636: number, p637: number?, p638: number?, p639: number?, p640: number?) -- Line: 3238
        -- upvalues: u401 (copy), u400 (copy)
        local v641 = u401[p635 % 16777216];

        if v641 and u400[v641.dense] ~= p635 then
            v641 = nil;
        end;

        if not v641 then
            return false;
        end;

        local archetype = v641.archetype;

        if not archetype then
            return false;
        end;

        local columns_map = archetype.columns_map;
        local v642;

        if columns_map[p636] ~= nil and (p637 == nil or columns_map[p637] ~= nil) and ((p638 == nil or columns_map[p638] ~= nil) and (p639 == nil or columns_map[p639] ~= nil)) then
            v642 = p640 == nil and true or error("args exceeded");
        else
            v642 = false;
        end;

        return v642;
    end;

    u408.target = world_target;

    function u408.parent(p643: table, p644: number) -- Line: 3300
        -- upvalues: world_target (copy)
        return world_target(p643, p644, 261, 0);
    end;

    function u408.contains(p645: table, p646: number) -- Line: 3725
        -- upvalues: u402 (copy)
        local v647 = u402;
        local v648 = v647.sparse_array[p646 % 16777216];

        if not v648 or v648.dense == 0 then
            v648 = nil;
        end;

        if v648 then
            local dense = v648.dense;

            if v647.alive_count < dense then
                v648 = nil;
            elseif v647.dense_array[dense] ~= p646 then
                v648 = nil;
            end;
        end;

        return v648 ~= nil;
    end;

    function u408.exists(p649: table, p650: number) -- Line: 3717
        -- upvalues: u401 (copy)
        local v651 = u401[p650 % 16777216];

        return v651 and v651.dense ~= 0 and true or false;
    end;

    u408.cleanup = world_cleanup;
    u408.each = world_each;
    u408.children = world_children;
    u408.range = world_range;

    if p399 then
        local u652 = nil;

        local function DEBUG_IS_DELETING_ENTITY(p653: number) -- Line: 3790
            -- upvalues: u652 (ref)
            if u652 == p653 then
                error(
                    "\t\t\t\t\tTried to make structural changes while the entity is in process\n\t\t\t\t\tof being deleted. You called this function inside of the\n\t\t\t\t\tOnRemove hook, but the entity is going to remove all of its\n\t\t\t\t\tcomponents making this operation moot.\n\t\t\t\t",
                    2
                );
            end;
        end;

        local function DEBUG_IS_INVALID_ENTITY(p654: number) -- Line: 3801
            -- upvalues: u401 (copy), u400 (copy)
            if u400[u401[p654 % 16777216].dense] ~= p654 then
                error(
                    "\t\t\t\t\tThis Entity handle has an outdated generation. You are\n\t\t\t\t\tprobably holding onto an entity that you got from outside the ECS\n\t\t\t\t",
                    2
                );
            end;
        end;

        local function DEBUG_ID_IS_INVALID(p655: number) -- Line: 3814
            -- upvalues: u408 (copy), ECS_ID (ref)
            if p655 <= 281474976710656 then
                local v656 = u408:contains(p655);
                assert(v656, "The component in your parameters is invalid because it is not alive in the entity index. You might be holding onto an outdated handle or may have forward declared ids via jecs.component() and jecs.tag(). In the latter case, ensure that their calls precede jecs.world() or otherwise they will not register correctly");

                return;
            end;

            if p655 // 16777216 == 260 and true or p655 % 16777216 == 260 then
                error(
                    "\t\t\t\t\t\tYou tried to pass in a wildcard pair. This is strictly\n\t\t\t\t\t\tforbidden. You probably want to iterate the targets and\n\t\t\t\t\t\tremove them one by one. You can also populate a list of\n\t\t\t\t\t\ttargets to remove and use jecs.bulk_remove.\n\t\t\t\t\t",
                    2
                );
            end;

            local v657 = u408;
            local v658 = (p655 - 281474976710656) // 16777216;

            if v658 == 0 then
                v658 = 0;
            else
                local entity_index = v657.entity_index;
                local v659 = entity_index.sparse_array[ECS_ID(v658)];

                if not v659 or v659.dense == 0 then
                    v659 = nil;
                end;

                if v659 then
                    local dense = v659.dense;

                    if entity_index.alive_count < dense then
                        v659 = nil;
                    elseif entity_index.dense_array[dense] ~= v658 then
                        v659 = nil;
                    end;
                end;

                if v659 == nil then
                    if v658 > 16777216 then
                        v658 = 0;
                    else
                        local v660 = entity_index.sparse_array[v658 % 16777216];

                        if not v660 or v660.dense == 0 then
                            v660 = nil;
                        end;

                        local v661;

                        if v660 then
                            local dense = v660.dense;

                            if entity_index.alive_count < dense then
                                v661 = nil;
                            else
                                v661 = entity_index.dense_array[dense];
                            end;
                        else
                            v661 = nil;
                        end;

                        if v661 then
                            local v662 = entity_index.sparse_array[ECS_ID(v661)];

                            if not v662 or v662.dense == 0 then
                                v662 = nil;
                            end;

                            if v662 then
                                local dense = v662.dense;

                                if entity_index.alive_count < dense then
                                    v662 = nil;
                                elseif entity_index.dense_array[dense] ~= v661 then
                                    v662 = nil;
                                end;
                            end;

                            v658 = v662 == nil and 0 or v661;
                        else
                            v658 = 0;
                        end;
                    end;
                end;
            end;

            local v663 = u408;
            local v664 = (p655 - 281474976710656) % 16777216;

            if v664 == 0 then
                v664 = 0;
            else
                local entity_index = v663.entity_index;
                local v665 = entity_index.sparse_array[ECS_ID(v664)];

                if not v665 or v665.dense == 0 then
                    v665 = nil;
                end;

                if v665 then
                    local dense = v665.dense;

                    if entity_index.alive_count < dense then
                        v665 = nil;
                    elseif entity_index.dense_array[dense] ~= v664 then
                        v665 = nil;
                    end;
                end;

                if v665 == nil then
                    if v664 > 16777216 then
                        v664 = 0;
                    else
                        local v666 = entity_index.sparse_array[v664 % 16777216];

                        if not v666 or v666.dense == 0 then
                            v666 = nil;
                        end;

                        local v667;

                        if v666 then
                            local dense = v666.dense;

                            if entity_index.alive_count < dense then
                                v667 = nil;
                            else
                                v667 = entity_index.dense_array[dense];
                            end;
                        else
                            v667 = nil;
                        end;

                        if v667 then
                            local v668 = entity_index.sparse_array[ECS_ID(v667)];

                            if not v668 or v668.dense == 0 then
                                v668 = nil;
                            end;

                            if v668 then
                                local dense = v668.dense;

                                if entity_index.alive_count < dense then
                                    v668 = nil;
                                elseif entity_index.dense_array[dense] ~= v667 then
                                    v668 = nil;
                                end;
                            end;

                            v664 = v668 == nil and 0 or v667;
                        else
                            v664 = 0;
                        end;
                    end;
                end;
            end;

            local v669 = u408:contains(v658);
            assert(v669, "The first element of the pair is invalid because it is not alive in the entity index. You might be holding onto an outdated handle or may have forward declared ids via jecs.component() and jecs.tag(). In the latter case, ensure that their calls precede jecs.world() or otherwise they will not register correctly");
            local v670 = u408:contains(v664);
            assert(v670, "The second element of the pair is invalid because it is not alive in the entity index. You might be holding onto an outdated handle or may have forward declared ids via jecs.component() and jecs.tag(). In the latter case, ensure that their calls precede jecs.world() or otherwise they will not register correctly");
        end;

        local u671 = world_delete;

        world_delete = function(p672: table, p673: number) -- Line: 3838, Name: world_delete_checked
            -- upvalues: u652 (ref), u401 (copy), u400 (copy), u671 (copy)
            u652 = p673;

            if u400[u401[p673 % 16777216].dense] ~= p673 then
                error(
                    "\t\t\t\t\tThis Entity handle has an outdated generation. You are\n\t\t\t\t\tprobably holding onto an entity that you got from outside the ECS\n\t\t\t\t",
                    2
                );
            end;

            u671(p672, p673);
            u652 = nil;
        end;

        local function world_add_checked(p674: table, p675: number, p676: number) -- Line: 3853
            -- upvalues: u652 (ref), u401 (copy), u400 (copy), DEBUG_ID_IS_INVALID (copy), world_add (copy)
            if u652 == p675 then
                error(
                    "\t\t\t\t\tTried to make structural changes while the entity is in process\n\t\t\t\t\tof being deleted. You called this function inside of the\n\t\t\t\t\tOnRemove hook, but the entity is going to remove all of its\n\t\t\t\t\tcomponents making this operation moot.\n\t\t\t\t",
                    2
                );
            end;

            if u400[u401[p675 % 16777216].dense] ~= p675 then
                error(
                    "\t\t\t\t\tThis Entity handle has an outdated generation. You are\n\t\t\t\t\tprobably holding onto an entity that you got from outside the ECS\n\t\t\t\t",
                    2
                );
            end;

            DEBUG_ID_IS_INVALID(p676);
            world_add(p674, p675, p676);
        end;

        local function world_set_checked(p677: table, p678: number, p679: number, p680: any) -- Line: 3860
            -- upvalues: u652 (ref), u401 (copy), u400 (copy), DEBUG_ID_IS_INVALID (copy), world_set (copy)
            if u652 == p678 then
                error(
                    "\t\t\t\t\tTried to make structural changes while the entity is in process\n\t\t\t\t\tof being deleted. You called this function inside of the\n\t\t\t\t\tOnRemove hook, but the entity is going to remove all of its\n\t\t\t\t\tcomponents making this operation moot.\n\t\t\t\t",
                    2
                );
            end;

            if u400[u401[p678 % 16777216].dense] ~= p678 then
                error(
                    "\t\t\t\t\tThis Entity handle has an outdated generation. You are\n\t\t\t\t\tprobably holding onto an entity that you got from outside the ECS\n\t\t\t\t",
                    2
                );
            end;

            DEBUG_ID_IS_INVALID(p679);
            world_set(p677, p678, p679, p680);
        end;

        function u408.remove(p681: table, p682: number, p683: number) -- Line: 3846
            -- upvalues: u652 (ref), u401 (copy), u400 (copy), DEBUG_ID_IS_INVALID (copy), world_remove (copy)
            if u652 == p682 then
                error(
                    "\t\t\t\t\tTried to make structural changes while the entity is in process\n\t\t\t\t\tof being deleted. You called this function inside of the\n\t\t\t\t\tOnRemove hook, but the entity is going to remove all of its\n\t\t\t\t\tcomponents making this operation moot.\n\t\t\t\t",
                    2
                );
            end;

            if u400[u401[p682 % 16777216].dense] ~= p682 then
                error(
                    "\t\t\t\t\tThis Entity handle has an outdated generation. You are\n\t\t\t\t\tprobably holding onto an entity that you got from outside the ECS\n\t\t\t\t",
                    2
                );
            end;

            DEBUG_ID_IS_INVALID(p683);
            world_remove(p681, p682, p683);
        end;

        u408.add = world_add_checked;
        u408.set = world_set_checked;
    end;

    for i = 1, 271 do
        ENTITY_INDEX_NEW_ID(u402);
        local _ = i;
    end;

    for i = 1, u407 do
        world_add(u408, i, 262);
        local _ = i;
    end;

    world_add(u408, 267, 262);
    world_add(u408, 259, 262);
    world_add(u408, 257, 262);
    world_add(u408, 258, 262);
    world_add(u408, 260, 262);
    world_add(u408, 271, 262);
    world_set(u408, 257, 267, "jecs.OnAdd");
    world_set(u408, 258, 267, "jecs.OnRemove");
    world_set(u408, 259, 267, "jecs.OnChange");
    world_set(u408, 260, 267, "jecs.Wildcard");
    world_set(u408, 261, 267, "jecs.ChildOf");
    world_set(u408, 262, 267, "jecs.Component");
    world_set(u408, 263, 267, "jecs.OnDelete");
    world_set(u408, 264, 267, "jecs.OnDeleteTarget");
    world_set(u408, 265, 267, "jecs.Delete");
    world_set(u408, 266, 267, "jecs.Remove");
    world_set(u408, 267, 267, "jecs.Name");
    world_set(u408, 271, 271, "jecs.Rest");
    world_add(u408, 261, 265 % 16777216 + 264 % 16777216 * 16777216 + 281474976710656);
    world_add(u408, 261, 270);
    world_add(u408, 263, 270);
    world_add(u408, 264, 270);

    for i = 272, u6 do
        ENTITY_INDEX_NEW_ID(u402);
        local _ = i;
    end;

    for i, v in u4 do
        local v684 = i;

        for i2, v2 in v do
            if v2 == u1 then
                world_add(u408, v684, i2);
            else
                world_set(u408, v684, i2, v2);
            end;
        end;
    end;

    return u408;
end;

local function ecs_is_tag(p685: table, p686: number) -- Line: 3925
    -- upvalues: ecs_is_tag (copy), ECS_ID (copy)
    if p686 > 281474976710656 then
        local v687 = (p686 - 281474976710656) // 16777216;

        if v687 == 0 then
            v687 = 0;
        else
            local entity_index = p685.entity_index;
            local v688 = entity_index.sparse_array[ECS_ID(v687)];

            if not v688 or v688.dense == 0 then
                v688 = nil;
            end;

            if v688 then
                local dense = v688.dense;

                if entity_index.alive_count < dense then
                    v688 = nil;
                elseif entity_index.dense_array[dense] ~= v687 then
                    v688 = nil;
                end;
            end;

            if v688 == nil then
                if v687 > 16777216 then
                    v687 = 0;
                else
                    local v689 = entity_index.sparse_array[v687 % 16777216];

                    if not v689 or v689.dense == 0 then
                        v689 = nil;
                    end;

                    local v690;

                    if v689 then
                        local dense = v689.dense;

                        if entity_index.alive_count < dense then
                            v690 = nil;
                        else
                            v690 = entity_index.dense_array[dense];
                        end;
                    else
                        v690 = nil;
                    end;

                    if v690 then
                        local v691 = entity_index.sparse_array[ECS_ID(v690)];

                        if not v691 or v691.dense == 0 then
                            v691 = nil;
                        end;

                        if v691 then
                            local dense = v691.dense;

                            if entity_index.alive_count < dense then
                                v691 = nil;
                            elseif entity_index.dense_array[dense] ~= v690 then
                                v691 = nil;
                            end;
                        end;

                        v687 = v691 == nil and 0 or v690;
                    else
                        v687 = 0;
                    end;
                end;
            end;
        end;

        local v692 = ecs_is_tag(p685, v687);

        if v692 then
            local v693 = (p686 - 281474976710656) % 16777216;

            if v693 == 0 then
                v693 = 0;
            else
                local entity_index = p685.entity_index;
                local v694 = entity_index.sparse_array[ECS_ID(v693)];

                if not v694 or v694.dense == 0 then
                    v694 = nil;
                end;

                if v694 then
                    local dense = v694.dense;

                    if entity_index.alive_count < dense then
                        v694 = nil;
                    elseif entity_index.dense_array[dense] ~= v693 then
                        v694 = nil;
                    end;
                end;

                if v694 == nil then
                    if v693 > 16777216 then
                        v693 = 0;
                    else
                        local v695 = entity_index.sparse_array[v693 % 16777216];

                        if not v695 or v695.dense == 0 then
                            v695 = nil;
                        end;

                        local v696;

                        if v695 then
                            local dense = v695.dense;

                            if entity_index.alive_count < dense then
                                v696 = nil;
                            else
                                v696 = entity_index.dense_array[dense];
                            end;
                        else
                            v696 = nil;
                        end;

                        if v696 then
                            local v697 = entity_index.sparse_array[ECS_ID(v696)];

                            if not v697 or v697.dense == 0 then
                                v697 = nil;
                            end;

                            if v697 then
                                local dense = v697.dense;

                                if entity_index.alive_count < dense then
                                    v697 = nil;
                                elseif entity_index.dense_array[dense] ~= v696 then
                                    v697 = nil;
                                end;
                            end;

                            v693 = v697 == nil and 0 or v696;
                        else
                            v693 = 0;
                        end;
                    end;
                end;
            end;

            v692 = ecs_is_tag(p685, v693);
        end;

        return v692;
    end;

    local v698 = p685.component_index[p686];

    if v698 then
        return bit32.btest(v698.flags, 2);
    end;

    local entity_index = p685.entity_index;
    local v699 = entity_index.sparse_array[p686 % 16777216];

    if not v699 or v699.dense == 0 then
        v699 = nil;
    end;

    if v699 then
        local dense = v699.dense;

        if entity_index.alive_count < dense then
            v699 = nil;
        elseif entity_index.dense_array[dense] ~= p686 then
            v699 = nil;
        end;
    end;

    local v700;

    if v699 then
        local archetype = v699.archetype;

        if archetype then
            v700 = archetype.columns_map[262] ~= nil;
        else
            v700 = false;
        end;
    else
        v700 = false;
    end;

    return not v700;
end;

local function entity_index_ensure(p701: table, p702: number) -- Line: 3940
    local sparse_array = p701.sparse_array;
    local dense_array = p701.dense_array;
    local v703 = p702 % 16777216;
    local alive_count = p701.alive_count;
    local v704 = sparse_array[v703];

    if not v704 then
        local max_id = p701.max_id;

        if max_id < v703 then
            for i = max_id + 1, v703 - 1 do
                local _ = sparse_array[i];
                sparse_array[i] = {
                    dense = 0
                };
                local _ = i;
            end;

            p701.max_id = v703;
        end;

        local v705 = alive_count + 1;
        p701.alive_count = v705;
        dense_array[v705] = p702;
        sparse_array[v703] = {
            dense = v705
        };

        return p702;
    end;

    local dense = v704.dense;

    if dense == 0 then
        local v706 = alive_count + 1;
        p701.alive_count = v706;
        v704.dense = v706;
        dense_array[v706] = p702;

        return p702;
    end;

    local v707 = dense_array[dense];

    if not v707 or v707 == p702 then
        return p702;
    end;

    local v708 = alive_count + 1;
    p701.alive_count = v708;
    v704.dense = v708;
    dense_array[v708] = p702;

    return p702;
end;

return {
    new = function(p709: table) -- Line: 3995, Name: new
        -- upvalues: ENTITY_INDEX_NEW_ID (copy)
        return ENTITY_INDEX_NEW_ID(p709.entity_index);
    end,

    new_w_id = function(p710: table, p711: number) -- Line: 4021, Name: new_w_id
        -- upvalues: ENTITY_INDEX_NEW_ID (copy)
        local v712 = ENTITY_INDEX_NEW_ID(p710.entity_index);
        p710.add(p710, v712, p711);

        return v712;
    end,

    new_low_id = function(p713: table) -- Line: 4000, Name: new_low_id
        -- upvalues: ENTITY_INDEX_NEW_ID (copy), entity_index_ensure (copy)
        local entity_index = p713.entity_index;
        local v714;

        if p713.max_component_id < 256 then
            local v715;

            repeat
                p713.max_component_id = p713.max_component_id + 1;
                v714 = p713.max_component_id;
                v715 = entity_index.sparse_array[v714 % 16777216];

                if not v715 or v715.dense == 0 then
                    v715 = nil;
                end;
            until v715 == nil or v714 > 256;
        else
            v714 = 0;
        end;

        if v714 == 0 or v714 >= 256 then
            return ENTITY_INDEX_NEW_ID(entity_index);
        end;

        entity_index_ensure(entity_index, v714);

        return v714;
    end,

    world = world_new,
    World = {
        new = world_new
    },
    component = ECS_COMPONENT,
    tag = ECS_TAG,
    meta = ECS_META,
    is_tag = ecs_is_tag,
    OnAdd = 257,
    OnRemove = 258,
    OnChange = 259,
    ChildOf = 261,
    Component = 262,
    Wildcard = 260,
    w = 260,
    OnDelete = 263,
    OnDeleteTarget = 264,
    Delete = 265,
    Remove = 266,
    Name = 267,
    Exclusive = 270,
    ArchetypeCreate = 268,
    ArchetypeDelete = 269,
    Rest = 271,

    pair = function(p716: number, p717: number) -- Line: 473, Name: ECS_PAIR
        return p717 % 16777216 + p716 % 16777216 * 16777216 + 281474976710656;
    end,

    IS_PAIR = function(p718: number) -- Line: 438, Name: ECS_IS_PAIR
        return p718 > 281474976710656;
    end,

    ECS_PAIR_FIRST = function(p719: number) -- Line: 480, Name: ECS_PAIR_FIRST
        return (p719 - 281474976710656) // 16777216;
    end,

    ECS_PAIR_SECOND = function(p720: number) -- Line: 484, Name: ECS_PAIR_SECOND
        return (p720 - 281474976710656) % 16777216;
    end,

    pair_first = function(p721: table, p722: number) -- Line: 597, Name: ecs_pair_first
        local v723 = (p722 - 281474976710656) // 16777216;

        if v723 == 0 then
            return 0;
        end;

        local entity_index = p721.entity_index;
        local v724 = entity_index.sparse_array[v723 % 16777216];

        if not v724 or v724.dense == 0 then
            v724 = nil;
        end;

        if v724 then
            local dense = v724.dense;

            if entity_index.alive_count < dense then
                v724 = nil;
            elseif entity_index.dense_array[dense] ~= v723 then
                v724 = nil;
            end;
        end;

        if v724 ~= nil then
            return v723;
        end;

        if v723 > 16777216 then
            return 0;
        end;

        local v725 = entity_index.sparse_array[v723 % 16777216];

        if not v725 or v725.dense == 0 then
            v725 = nil;
        end;

        local v726;

        if v725 then
            local dense = v725.dense;

            if entity_index.alive_count < dense then
                v726 = nil;
            else
                v726 = entity_index.dense_array[dense];
            end;
        else
            v726 = nil;
        end;

        if v726 then
            local v727 = entity_index.sparse_array[v726 % 16777216];

            if not v727 or v727.dense == 0 then
                v727 = nil;
            end;

            if v727 then
                local dense = v727.dense;

                if entity_index.alive_count < dense then
                    v727 = nil;
                elseif entity_index.dense_array[dense] ~= v726 then
                    v727 = nil;
                end;
            end;

            if v727 ~= nil then
                return v726;
            end;
        end;

        return 0;
    end,

    pair_second = function(p728: table, p729: number) -- Line: 602, Name: ecs_pair_second
        local v730 = (p729 - 281474976710656) % 16777216;

        if v730 == 0 then
            return 0;
        end;

        local entity_index = p728.entity_index;
        local v731 = entity_index.sparse_array[v730 % 16777216];

        if not v731 or v731.dense == 0 then
            v731 = nil;
        end;

        if v731 then
            local dense = v731.dense;

            if entity_index.alive_count < dense then
                v731 = nil;
            elseif entity_index.dense_array[dense] ~= v730 then
                v731 = nil;
            end;
        end;

        if v731 ~= nil then
            return v730;
        end;

        if v730 > 16777216 then
            return 0;
        end;

        local v732 = entity_index.sparse_array[v730 % 16777216];

        if not v732 or v732.dense == 0 then
            v732 = nil;
        end;

        local v733;

        if v732 then
            local dense = v732.dense;

            if entity_index.alive_count < dense then
                v733 = nil;
            else
                v733 = entity_index.dense_array[dense];
            end;
        else
            v733 = nil;
        end;

        if v733 then
            local v734 = entity_index.sparse_array[v733 % 16777216];

            if not v734 or v734.dense == 0 then
                v734 = nil;
            end;

            if v734 then
                local dense = v734.dense;

                if entity_index.alive_count < dense then
                    v734 = nil;
                elseif entity_index.dense_array[dense] ~= v733 then
                    v734 = nil;
                end;
            end;

            if v734 ~= nil then
                return v733;
            end;
        end;

        return 0;
    end,

    entity_index_get_alive = function(p735: table, p736: number) -- Line: 533, Name: entity_index_get_alive
        local v737 = p735.sparse_array[p736 % 16777216];

        if not v737 or v737.dense == 0 then
            v737 = nil;
        end;

        if not v737 then
            return nil;
        end;

        local dense = v737.dense;

        if p735.alive_count < dense then
            return nil;
        end;

        return p735.dense_array[dense];
    end,

    archetype_append_to_records = function(p738: table, p739: number, p740: table, p741: number, p742: number, p743: table) -- Line: 941, Name: archetype_append_to_records
        local records = p738.records;
        local counts = p738.counts;

        if records[p739] then
            counts[p739] = counts[p739] + 1;

            return;
        end;

        records[p739] = p742;
        counts[p739] = 1;
        p740[p741] = p743;
    end,

    id_record_ensure = function(p744: table, p745: number) -- Line: 930, Name: id_record_ensure
        -- upvalues: id_record_create (copy)
        local component_index = p744.component_index;

        return component_index[p745] or id_record_create(p744, component_index, p745);
    end,

    component_record = function(p746: table, p747: table) -- Line: 847, Name: id_record_get
        return p746.component_index[p747] or nil;
    end,

    record = function(p748: table, p749: number) -- Line: 3936, Name: ecs_entity_record
        local entity_index = p748.entity_index;
        local v750 = entity_index.sparse_array[p749 % 16777216];

        if not v750 or v750.dense == 0 then
            v750 = nil;
        end;

        if v750 then
            local dense = v750.dense;

            if entity_index.alive_count < dense then
                return nil;
            end;

            if entity_index.dense_array[dense] ~= p749 then
                return nil;
            end;
        end;

        return v750;
    end,

    archetype_create = archetype_create,

    archetype_ensure = function(p751: table, p752: table) -- Line: 1055, Name: archetype_ensure
        -- upvalues: archetype_create (copy)
        if #p752 < 1 then
            return p751.ROOT_ARCHETYPE;
        end;

        local table_concat_ret = table.concat(p752, "_");

        return p751.archetype_index[table_concat_ret] or archetype_create(p751, p752, table_concat_ret);
    end,

    find_insert = function(p753: table, p754: number) -- Line: 1069, Name: find_insert
        for i, v in p753 do
            if v == p754 then
                return -1;
            end;

            if p754 < v then
                return i;
            end;
        end;

        return #p753 + 1;
    end,

    find_archetype_with = function(p755: table, p756: number, p757: table) -- Line: 1128, Name: find_archetype_with
        -- upvalues: archetype_create (copy)
        local types = p757.types;
        local table_clone_ret = table.clone(types);
        local v758;

        for i, v in types do
            if v == p756 then
                v758 = -1;
                break;
            end;

            if p756 < v then
                v758 = i;
                break;
            end;
        end;

        v758 = #types + 1;
        table.insert(table_clone_ret, v758, p756);

        if #table_clone_ret < 1 then
            return p755.ROOT_ARCHETYPE;
        end;

        local table_concat_ret = table.concat(table_clone_ret, "_");

        return p755.archetype_index[table_concat_ret] or archetype_create(p755, table_clone_ret, table_concat_ret);
    end,

    find_archetype_without = function(p759: table, p760: table, p761: number) -- Line: 1081, Name: find_archetype_without
        -- upvalues: archetype_create (copy)
        local types = p760.types;
        local table_find_ret = table.find(types, p761);
        local table_clone_ret = table.clone(types);
        table.remove(table_clone_ret, table_find_ret);

        if #table_clone_ret < 1 then
            return p759.ROOT_ARCHETYPE;
        end;

        local table_concat_ret = table.concat(table_clone_ret, "_");

        return p759.archetype_index[table_concat_ret] or archetype_create(p759, table_clone_ret, table_concat_ret);
    end,

    create_edge_for_remove = function(p762: table, p763: table, p764: table, p765: number) -- Line: 1096, Name: create_edge_for_remove
        -- upvalues: archetype_create (copy)
        local types = p763.types;
        local table_find_ret = table.find(types, p765);
        local table_clone_ret = table.clone(types);
        table.remove(table_clone_ret, table_find_ret);
        local v766;

        if #table_clone_ret < 1 then
            v766 = p762.ROOT_ARCHETYPE;
        else
            local table_concat_ret = table.concat(table_clone_ret, "_");
            v766 = p762.archetype_index[table_concat_ret] or archetype_create(p762, table_clone_ret, table_concat_ret);
        end;

        local archetype_edges = p762.archetype_edges;
        archetype_edges[p763.id][p765] = v766;
        archetype_edges[v766.id][p765] = p763;

        return v766;
    end,

    archetype_traverse_add = function(p767: table, p768: number, p769: table) -- Line: 1143, Name: archetype_traverse_add
        -- upvalues: archetype_create (copy)
        local v770 = p769 or p767.ROOT_ARCHETYPE;

        if v770.columns_map[p768] then
            return v770;
        end;

        local archetype_edges = p767.archetype_edges;
        local v771 = archetype_edges[v770.id];
        local v772 = v771[p768];

        if not v772 then
            local types = v770.types;
            local table_clone_ret = table.clone(types);
            local v773;

            for i, v in types do
                if v == p768 then
                    v773 = -1;
                    break;
                end;

                if p768 < v then
                    v773 = i;
                    break;
                end;
            end;

            v773 = #types + 1;
            table.insert(table_clone_ret, v773, p768);

            if #table_clone_ret < 1 then
                v772 = p767.ROOT_ARCHETYPE;
            else
                local table_concat_ret = table.concat(table_clone_ret, "_");
                v772 = p767.archetype_index[table_concat_ret] or archetype_create(p767, table_clone_ret, table_concat_ret);
            end;

            v771[p768] = v772;
            archetype_edges[v772.id][p768] = v770;
        end;

        return v772;
    end,

    archetype_traverse_remove = function(p774: table, p775: number, p776: table) -- Line: 1110, Name: archetype_traverse_remove
        -- upvalues: archetype_create (copy)
        local archetype_edges = p774.archetype_edges;
        local v777 = archetype_edges[p776.id];
        local v778 = v777[p775];

        if v778 == nil then
            local types = p776.types;
            local table_find_ret = table.find(types, p775);
            local table_clone_ret = table.clone(types);
            table.remove(table_clone_ret, table_find_ret);

            if #table_clone_ret < 1 then
                v778 = p774.ROOT_ARCHETYPE;
            else
                local table_concat_ret = table.concat(table_clone_ret, "_");
                v778 = p774.archetype_index[table_concat_ret] or archetype_create(p774, table_clone_ret, table_concat_ret);
            end;

            v777[p775] = v778;
            archetype_edges[v778.id][p775] = p776;
        end;

        return v778;
    end,

    bulk_insert = function(p779: table, p780: number, p781: table, p782: table) -- Line: 2557, Name: ecs_bulk_insert
        -- upvalues: archetype_create (copy), archetype_move (copy)
        local entity_index = p779.entity_index;
        local v783 = entity_index.sparse_array[p780 % 16777216];

        if not v783 or v783.dense == 0 then
            v783 = nil;
        end;

        if v783 then
            local dense = v783.dense;

            if entity_index.alive_count < dense then
                v783 = nil;
            elseif entity_index.dense_array[dense] ~= p780 then
                v783 = nil;
            end;
        end;

        if not v783 then
            return;
        end;

        local archetype = v783.archetype;
        local component_index = p779.component_index;

        if not archetype then
            local table_clone_ret = table.clone(p781);
            table.sort(table_clone_ret);
            local v784;

            if #table_clone_ret < 1 then
                v784 = p779.ROOT_ARCHETYPE;
            else
                local table_concat_ret = table.concat(table_clone_ret, "_");
                v784 = p779.archetype_index[table_concat_ret] or archetype_create(p779, table_clone_ret, table_concat_ret);
            end;

            local entities = v784.entities;
            local v785 = #entities + 1;
            entities[v785] = p780;
            v783.archetype = v784;
            v783.row = v785;
            local ROOT_ARCHETYPE = p779.ROOT_ARCHETYPE;

            for i, v in p781 do
                local v786 = p782[i];

                if v786 then
                    v783.archetype.columns_map[v][v783.row] = v786;
                end;
            end;

            for i, v in p781 do
                local on_add = component_index[v].on_add;

                if on_add then
                    on_add(p780, v, p782[i], ROOT_ARCHETYPE);
                end;
            end;

            return;
        end;

        local table_clone_ret = table.clone(archetype.types);
        local v787 = {};

        for i, v in p781 do
            local v788 = i;
            local v789 = v;
            local v790;

            for i2, v2 in table_clone_ret do
                if v2 == v789 then
                    v790 = -1;
                    break;
                end;

                if v789 < v2 then
                    v790 = i2;
                    break;
                end;
            end;

            v790 = #table_clone_ret + 1;

            if v790 == -1 then
                v787[v788] = true;
            else
                v787[v788] = false;
                table.insert(table_clone_ret, v790, v789);
            end;
        end;

        local v791;

        if #table_clone_ret < 1 then
            v791 = p779.ROOT_ARCHETYPE;
        else
            local table_concat_ret = table.concat(table_clone_ret, "_");
            v791 = p779.archetype_index[table_concat_ret] or archetype_create(p779, table_clone_ret, table_concat_ret);
        end;

        if archetype == v791 then
            for i, v in p781 do
                local v792 = p782[i];
                local on_change = component_index[v].on_change;

                if on_change then
                    on_change(p780, v, v792, archetype);
                end;

                if v792 ~= nil then
                    v783.archetype.columns_map[v][v783.row] = v792;
                end;
            end;

            return;
        end;

        local row = v783.row;
        local archetype2 = v783.archetype;
        local entities = v791.entities;
        local v793 = #entities + 1;
        entities[v793] = p780;
        archetype_move(entity_index, p780, v791, v793, archetype2, row);
        v783.archetype = v791;
        v783.row = v793;

        for i, v in p781 do
            local v794 = p782[i];

            if v794 ~= nil then
                v783.archetype.columns_map[v][v783.row] = v794;
            end;
        end;

        for i, v in v787 do
            local v795 = p782[i];
            local v796 = p781[i];
            local v797 = component_index[v796];

            if v then
                local on_change = v797.on_change;

                if on_change then
                    on_change(p780, v796, v795, archetype);
                end;
            else
                local on_add = v797.on_add;

                if on_add then
                    on_add(p780, v796, v795, archetype);
                end;
            end;
        end;
    end,

    bulk_remove = function(p798: table, p799: number, p800: table) -- Line: 2653, Name: ecs_bulk_remove
        -- upvalues: archetype_create (copy), archetype_move (copy)
        local entity_index = p798.entity_index;
        local v801 = entity_index.sparse_array[p799 % 16777216];

        if not v801 or v801.dense == 0 then
            v801 = nil;
        end;

        if v801 then
            local dense = v801.dense;

            if entity_index.alive_count < dense then
                v801 = nil;
            elseif entity_index.dense_array[dense] ~= p799 then
                v801 = nil;
            end;
        end;

        if not v801 then
            return;
        end;

        local archetype = v801.archetype;
        local component_index = p798.component_index;

        if not archetype then
            return;
        end;

        local columns_map = archetype.columns_map;
        local v802 = {};

        for _, v in p800 do
            if columns_map[v] then
                v802[v] = true;
                local on_remove = component_index[v].on_remove;

                if on_remove then
                    on_remove(p799, v);
                end;
            end;
        end;

        local archetype2 = v801.archetype;

        if archetype == archetype2 then
            archetype2 = archetype;
        end;

        local table_clone_ret = table.clone(archetype2.types);

        for i in v802 do
            local table_find_ret = table.find(table_clone_ret, i);
            table.remove(table_clone_ret, table_find_ret);
        end;

        local v803;

        if #table_clone_ret < 1 then
            v803 = p798.ROOT_ARCHETYPE;
        else
            local table_concat_ret = table.concat(table_clone_ret, "_");
            v803 = p798.archetype_index[table_concat_ret] or archetype_create(p798, table_clone_ret, table_concat_ret);
        end;

        if archetype2 ~= v803 then
            local row = v801.row;
            local archetype3 = v801.archetype;
            local entities = v803.entities;
            local v804 = #entities + 1;
            entities[v804] = p799;
            archetype_move(entity_index, p799, v803, v804, archetype3, row);
            v801.archetype = v803;
            v801.row = v804;
        end;
    end,

    entity_move = function(p805: table, p806: number, p807: table, p808: table) -- Line: 728, Name: entity_move
        -- upvalues: archetype_move (copy)
        local row = p807.row;
        local archetype = p807.archetype;
        local entities = p808.entities;
        local v809 = #entities + 1;
        entities[v809] = p806;
        archetype_move(p805, p806, p808, v809, archetype, row);
        p807.archetype = p808;
        p807.row = v809;
    end,

    entity_index_try_get = function(p810: table, p811: number) -- Line: 501, Name: entity_index_try_get
        local v812 = p810.sparse_array[p811 % 16777216];

        if not v812 or v812.dense == 0 then
            v812 = nil;
        end;

        if v812 then
            local dense = v812.dense;

            if p810.alive_count < dense then
                return nil;
            end;

            if p810.dense_array[dense] ~= p811 then
                return nil;
            end;
        end;

        return v812;
    end,

    entity_index_try_get_fast = function(p813: table, p814: number) -- Line: 515, Name: entity_index_try_get_fast
        local v815 = p813.sparse_array[p814 % 16777216];

        if not v815 or v815.dense == 0 then
            v815 = nil;
        end;

        if v815 and p813.dense_array[v815.dense] ~= p814 then
            return nil;
        end;

        return v815;
    end,

    entity_index_try_get_any = function(p816: table, p817: number) -- Line: 488, Name: entity_index_try_get_any
        local v818 = p816.sparse_array[p817 % 16777216];

        if v818 and v818.dense ~= 0 then
            return v818;
        end;

        return nil;
    end,

    entity_index_is_alive = function(p819: table, p820: number) -- Line: 529, Name: entity_index_is_alive
        local v821 = p819.sparse_array[p820 % 16777216];

        if not v821 or v821.dense == 0 then
            v821 = nil;
        end;

        if v821 then
            local dense = v821.dense;

            if p819.alive_count < dense then
                v821 = nil;
            elseif p819.dense_array[dense] ~= p820 then
                v821 = nil;
            end;
        end;

        return v821 ~= nil;
    end,

    entity_index_new_id = ENTITY_INDEX_NEW_ID,
    entity_index_ensure = entity_index_ensure,
    Query = u258,
    query_iter = query_iter,
    query_iter_init = query_iter_init,
    query_with = query_with,
    query_without = query_without,
    query_archetypes = query_archetypes,

    query_match = function(p822: table, p823: table) -- Line: 607, Name: query_match
        local columns_map = p823.columns_map;

        for _, v in p822.filter_with do
            if not columns_map[v] then
                return false;
            end;
        end;

        local filter_without = p822.filter_without;

        if filter_without then
            for _, v in filter_without do
                if columns_map[v] then
                    return false;
                end;
            end;
        end;

        return true;
    end,

    find_observers = function(p824: table, p825: number, p826: number) -- Line: 629, Name: find_observers
        local v827 = p824.observable[p825];

        if v827 then
            return v827[p826];
        end;

        return nil;
    end,

    ECS_ID = function(p828: number) -- Line: 457, Name: ECS_ENTITY_T_LO
        return p828 % 16777216;
    end,

    ECS_GENERATION_INC = function(p829: number) -- Line: 442, Name: ECS_GENERATION_INC
        if p829 <= 16777216 then
            return p829 + 16777216;
        end;

        local v830 = p829 % 16777216;
        local v831 = p829 // 16777216 + 1;

        if v831 >= 65536 then
            return v830;
        end;

        return v830 + v831 * 16777216;
    end,

    ECS_GENERATION = function(p832: number) -- Line: 465, Name: ECS_GENERATION
        return p832 // 16777216;
    end,

    ECS_ID_IS_WILDCARD = function(p833: number) -- Line: 841, Name: ECS_ID_IS_WILDCARD
        return p833 // 16777216 == 260 and true or p833 % 16777216 == 260;
    end,

    ECS_ID_IS_EXCLUSIVE = 4,
    ECS_ID_DELETE = 1,
    ECS_META_RESET = ECS_META_RESET,

    ECS_COMBINE = function(p834: number, p835: number) -- Line: 434, Name: ECS_COMBINE
        return p834 + p835 * 16777216;
    end,

    ECS_ENTITY_MASK = 16777216
};