-- Decompiled with Potassium's decompiler.

local table_freeze_ret = table.freeze({});
local u1 = newproxy(false);

local function ecs_assert(p2: any, p3: string?) -- Line: 227
    if not p2 then
        error(p3);
    end;
end;

local u4 = {};
local u5 = 0;
local u6 = 271;

local function ECS_COMPONENT() -- Line: 237
    -- upvalues: u5 (ref)
    u5 = u5 + 1;

    if u5 > 256 then
        error("Too many components");
    end;

    return u5;
end;

local function ECS_TAG() -- Line: 245
    -- upvalues: u6 (ref)
    u6 = u6 + 1;

    return u6;
end;

local function ECS_META(p7: number, p8: number, p9: any) -- Line: 250
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

local function ECS_META_RESET() -- Line: 259
    -- upvalues: u4 (ref), u5 (ref), u6 (ref)
    u4 = {};
    u5 = 0;
    u6 = 271;
end;

local function ECS_COMBINE(p11: number, p12: number) -- Line: 265
    return p11 + p12 * 16777216;
end;

local function ECS_ID(p13: number) -- Line: 292
    return p13 % 16777216;
end;

local function ECS_ENTITY_T_HI(p14: number) -- Line: 300
    return p14 // 16777216;
end;

local function ecs_get_alive(p15: table, p16: any) -- Line: 372
    if p16 == 0 then
        return 0;
    end;

    local entity_index = p15.entity_index;
    local v17 = entity_index.sparse_array[p16 % 16777216];

    if not v17 or v17.dense == 0 then
        v17 = nil;
    end;

    if v17 then
        local dense = v17.dense;

        if entity_index.alive_count < dense then
            v17 = nil;
        elseif entity_index.dense_array[dense] ~= p16 then
            v17 = nil;
        end;
    end;

    if v17 ~= nil then
        return p16;
    end;

    if p16 > 16777216 then
        return 0;
    end;

    local v18 = entity_index.sparse_array[p16 % 16777216];

    if not v18 or v18.dense == 0 then
        v18 = nil;
    end;

    local v19;

    if v18 then
        v19 = entity_index.dense_array[v18.dense];
    else
        v19 = nil;
    end;

    if v19 then
        local v20 = entity_index.sparse_array[v19 % 16777216];

        if not v20 or v20.dense == 0 then
            v20 = nil;
        end;

        if v20 then
            local dense = v20.dense;

            if entity_index.alive_count < dense then
                v20 = nil;
            elseif entity_index.dense_array[dense] ~= v19 then
                v20 = nil;
            end;
        end;

        if v20 ~= nil then
            return v19;
        end;
    end;

    return 0;
end;

local function entity_index_new_id(p21: table) -- Line: 397
    local dense_array = p21.dense_array;
    local alive_count = p21.alive_count;
    local sparse_array = p21.sparse_array;
    local max_id = p21.max_id;

    if alive_count < max_id then
        local v22 = alive_count + 1;
        p21.alive_count = v22;

        return dense_array[v22];
    end;

    local v23 = max_id + 1;
    local range_end = p21.range_end;

    if range_end ~= nil and v23 >= range_end then
        error("Entity is outside range");
    end;

    p21.max_id = v23;
    local v24 = alive_count + 1;
    p21.alive_count = v24;
    dense_array[v24] = v23;
    sparse_array[v23] = {
        dense = v24
    };

    return v23;
end;

local function archetype_move(p25: table, p26: any, p27: table, p28: number, p29: table, p30: number) -- Line: 463
    -- upvalues: table_freeze_ret (copy)
    local columns = p29.columns;
    local entities = p27.entities;
    local entities2 = p29.entities;
    local v31 = #entities2;
    local types = p29.types;
    local columns_map = p27.columns_map;

    if p30 == v31 then
        for i, v in columns do
            if v ~= table_freeze_ret then
                local v32 = columns_map[types[i]];

                if v32 then
                    v32[p28] = v[p30];
                end;

                v[v31] = nil;
            end;
        end;
    else
        for i, v in columns do
            if v ~= table_freeze_ret then
                local v33 = columns_map[types[i]];

                if v33 then
                    v33[p28] = v[p30];
                end;

                v[p30] = v[v31];
                v[v31] = nil;
            end;
        end;

        local v34 = entities2[v31];
        entities2[p30] = v34;
        p25.sparse_array[v34 % 16777216].row = p30;
    end;

    entities2[v31] = nil;
    entities[p28] = p26;
end;

local function archetype_append(p35: any, p36: table) -- Line: 533
    local entities = p36.entities;
    local v37 = #entities + 1;
    entities[v37] = p35;

    return v37;
end;

local function new_entity(p38: any, p39: table, p40: table) -- Line: 543
    local entities = p40.entities;
    local v41 = #entities + 1;
    entities[v41] = p38;
    p39.archetype = p40;
    p39.row = v41;

    return p39;
end;

local function hash(p42: table) -- Line: 568
    return table.concat(p42, "_");
end;

local function fetch(p43: any, p44: table, p45: number) -- Line: 572
    local v46 = p44[p43];

    if v46 then
        return v46[p45];
    end;

    return nil;
end;

local function world_get(p47: table, p48: any, p49: any, p50: any, p51: any, p52: any, p53: any) -- Line: 582
    local entity_index = p47.entity_index;
    local v54 = entity_index.sparse_array[p48 % 16777216];

    if not v54 or v54.dense == 0 then
        v54 = nil;
    end;

    if v54 then
        local dense = v54.dense;

        if entity_index.alive_count < dense then
            v54 = nil;
        elseif entity_index.dense_array[dense] ~= p48 then
            v54 = nil;
        end;
    end;

    if not v54 then
        return nil;
    end;

    local archetype = v54.archetype;

    if not archetype then
        return nil;
    end;

    local columns_map = archetype.columns_map;
    local row = v54.row;
    local v55 = columns_map[p49];
    local v56;

    if v55 then
        v56 = v55[row];
    else
        v56 = nil;
    end;

    if not p50 then
        return v56;
    end;

    if not p51 then
        local v57 = columns_map[p50];

        if v57 then
            return v56, v57[row];
        end;

        return v56, nil;
    end;

    if not p52 then
        local v58 = columns_map[p50];
        local v59;

        if v58 then
            v59 = v58[row];
        else
            v59 = nil;
        end;

        local v60 = columns_map[p51];

        if v60 then
            return v56, v59, v60[row];
        end;

        return v56, v59, nil;
    end;

    if not p53 then
        local v61 = columns_map[p50];
        local v62;

        if v61 then
            v62 = v61[row];
        else
            v62 = nil;
        end;

        local v63 = columns_map[p51];
        local v64;

        if v63 then
            v64 = v63[row];
        else
            v64 = nil;
        end;

        local v65 = columns_map[p52];

        if v65 then
            return v56, v62, v64, v65[row];
        end;

        return v56, v62, v64, nil;
    end;

    error("args exceeded");
end;

local function world_has_one_inline(p66: table, p67: any, p68: number) -- Line: 612
    local entity_index = p66.entity_index;
    local v69 = entity_index.sparse_array[p67 % 16777216];

    if not v69 or v69.dense == 0 then
        v69 = nil;
    end;

    if v69 then
        local dense = v69.dense;

        if entity_index.alive_count < dense then
            v69 = nil;
        elseif entity_index.dense_array[dense] ~= p67 then
            v69 = nil;
        end;
    end;

    if not v69 then
        return false;
    end;

    local archetype = v69.archetype;

    if archetype then
        return archetype.columns_map[p68] ~= nil;
    end;

    return false;
end;

local function world_target(p70: table, p71: any, p72: any, p73: number?) -- Line: 626
    local entity_index = p70.entity_index;
    local v74 = entity_index.sparse_array[p71 % 16777216];

    if not v74 or v74.dense == 0 then
        v74 = nil;
    end;

    if v74 then
        local dense = v74.dense;

        if entity_index.alive_count < dense then
            v74 = nil;
        elseif entity_index.dense_array[dense] ~= p71 then
            v74 = nil;
        end;
    end;

    if not v74 then
        return nil;
    end;

    local archetype = v74.archetype;

    if not archetype then
        return nil;
    end;

    local v75 = p70.component_index[260 % 16777216 + p72 % 16777216 * 16777216 + 281474976710656];

    if not v75 then
        return nil;
    end;

    local id = archetype.id;
    local v76 = v75.counts[id];

    if not v76 then
        return nil;
    end;

    local v77 = p73 or 0;

    if v76 <= v77 then
        v77 = v77 + v76 + 1;
    end;

    local v78 = archetype.types[v77 + v75.records[id]];

    if not v78 then
        return nil;
    end;

    local v79 = entity_index.sparse_array[(v78 - 281474976710656) % 16777216 % 16777216];

    if not v79 or v79.dense == 0 then
        v79 = nil;
    end;

    if v79 then
        return entity_index.dense_array[v79.dense];
    end;

    return nil;
end;

local function id_record_ensure(p80: table, p81: any) -- Line: 684
    -- upvalues: world_target (copy)
    local component_index = p80.component_index;
    local entity_index = p80.entity_index;
    local v82 = component_index[p81];

    if v82 then
        return v82;
    end;

    local v83 = 0;
    local v84 = p81 > 281474976710656;
    local v85 = false;
    local v86 = false;
    local v87;

    if v84 then
        local v88 = entity_index.sparse_array[(p81 - 281474976710656) // 16777216 % 16777216];

        if not v88 or v88.dense == 0 then
            v88 = nil;
        end;

        if v88 then
            v87 = entity_index.dense_array[v88.dense];
        else
            v87 = nil;
        end;

        local v89;

        if v87 then
            local v90 = entity_index.sparse_array[v87 % 16777216];

            if not v90 or v90.dense == 0 then
                v90 = nil;
            end;

            if v90 then
                local dense = v90.dense;

                if entity_index.alive_count < dense then
                    v90 = nil;
                elseif entity_index.dense_array[dense] ~= v87 then
                    v90 = nil;
                end;
            end;

            v89 = v90 ~= nil;
        else
            v89 = v87;
        end;

        if not v89 then
            error("\tThis is an internal error, please file a bug report via the following link:\n\n\thttps://github.com/Ukendio/jecs/issues/new?template=BUG-REPORT.md\n");
        end;

        local v91 = entity_index.sparse_array[(p81 - 281474976710656) % 16777216 % 16777216];

        if not v91 or v91.dense == 0 then
            v91 = nil;
        end;

        if v91 then
            v83 = entity_index.dense_array[v91.dense];
        else
            v83 = nil;
        end;

        local v92;

        if v83 then
            local v93 = entity_index.sparse_array[v83 % 16777216];

            if not v93 or v93.dense == 0 then
                v93 = nil;
            end;

            if v93 then
                local dense = v93.dense;

                if entity_index.alive_count < dense then
                    v93 = nil;
                elseif entity_index.dense_array[dense] ~= v83 then
                    v93 = nil;
                end;
            end;

            v92 = v93 ~= nil;
        else
            v92 = v83;
        end;

        if not v92 then
            error("\tThis is an internal error, please file a bug report via the following link:\n\n\thttps://github.com/Ukendio/jecs/issues/new?template=BUG-REPORT.md\n");
        end;

        v85 = world_target(p80, v87, 264, 0) == 265 and true or v85;
        local entity_index2 = p80.entity_index;
        local v94 = entity_index2.sparse_array[v87 % 16777216];

        if not v94 or v94.dense == 0 then
            v94 = nil;
        end;

        if v94 then
            local dense = v94.dense;

            if entity_index2.alive_count < dense then
                v94 = nil;
            elseif entity_index2.dense_array[dense] ~= v87 then
                v94 = nil;
            end;
        end;

        local v95;

        if v94 then
            local archetype = v94.archetype;

            if archetype then
                v95 = archetype.columns_map[270] ~= nil;
            else
                v95 = false;
            end;
        else
            v95 = false;
        end;

        if v95 then
            v86 = true;
        end;
    elseif world_target(p80, p81, 263, 0) == 265 then
        v87 = p81;
        v85 = true;
    else
        v87 = p81;
    end;

    local entity_index2 = p80.entity_index;
    local v96 = entity_index2.sparse_array[v87 % 16777216];

    if not v96 or v96.dense == 0 then
        v96 = nil;
    end;

    if v96 then
        local dense = v96.dense;

        if entity_index2.alive_count < dense then
            v96 = nil;
        elseif entity_index2.dense_array[dense] ~= v87 then
            v96 = nil;
        end;
    end;

    local v97, v98, v99;

    if v96 then
        local archetype = v96.archetype;

        if archetype then
            local columns_map = archetype.columns_map;
            local row = v96.row;
            local v100 = columns_map[257];

            if v100 then
                v97 = v100[row];
            else
                v97 = nil;
            end;

            local v101 = columns_map[259];

            if v101 then
                v98 = v101[row];
            else
                v98 = nil;
            end;

            local v102 = columns_map[258];

            if v102 then
                v99 = v102[row];
            else
                v99 = nil;
            end;
        else
            v99 = nil;
            v97 = nil;
            v98 = nil;
        end;
    else
        v99 = nil;
        v97 = nil;
        v98 = nil;
    end;

    local entity_index3 = p80.entity_index;
    local v103 = entity_index3.sparse_array[v87 % 16777216];

    if not v103 or v103.dense == 0 then
        v103 = nil;
    end;

    if v103 then
        local dense = v103.dense;

        if entity_index3.alive_count < dense then
            v103 = nil;
        elseif entity_index3.dense_array[dense] ~= v87 then
            v103 = nil;
        end;
    end;

    local v104;

    if v103 then
        local archetype = v103.archetype;

        if archetype then
            v104 = archetype.columns_map[262] ~= nil;
        else
            v104 = false;
        end;
    else
        v104 = false;
    end;

    local v105 = not v104;

    if v105 and v84 then
        local entity_index4 = p80.entity_index;
        local v106 = entity_index4.sparse_array[v83 % 16777216];

        if not v106 or v106.dense == 0 then
            v106 = nil;
        end;

        if v106 then
            local dense = v106.dense;

            if entity_index4.alive_count < dense then
                v106 = nil;
            elseif entity_index4.dense_array[dense] ~= v83 then
                v106 = nil;
            end;
        end;

        local v107;

        if v106 then
            local archetype = v106.archetype;

            if archetype then
                v107 = archetype.columns_map[262] ~= nil;
            else
                v107 = false;
            end;
        else
            v107 = false;
        end;

        v105 = not v107;
    end;

    local v108 = {
        size = 0,
        records = {},
        counts = {},
        flags = bit32.bor(0, v85 and 1 or 0, v105 and 2 or 0, v86 and 4 or 0),
        on_add = v97,
        on_change = v98,
        on_remove = v99
    };
    component_index[p81] = v108;

    return v108;
end;

local function archetype_register(p109: table, p110: table) -- Line: 780
    -- upvalues: id_record_ensure (copy), table_freeze_ret (copy)
    local id = p110.id;
    local columns_map = p110.columns_map;
    local columns = p110.columns;

    for i, v in p110.types do
        local v111 = id_record_ensure(p109, v);
        local v112 = not bit32.btest(v111.flags, 2) and {} or table_freeze_ret;
        columns[i] = v112;
        local records = v111.records;
        local counts = v111.counts;

        if records[id] then
            counts[id] = counts[id] + 1;
        else
            records[id] = i;
            counts[id] = 1;
            columns_map[v] = v112;
        end;

        if v > 281474976710656 then
            local v113 = 260 % 16777216 + (v - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656;
            local v114 = id_record_ensure(p109, v113);
            local records2 = v114.records;
            local counts2 = v114.counts;

            if records2[id] then
                counts2[id] = counts2[id] + 1;
            else
                records2[id] = i;
                counts2[id] = 1;
                columns_map[v113] = v112;
            end;

            local v115 = (v - 281474976710656) % 16777216 % 16777216 + 260 % 16777216 * 16777216 + 281474976710656;
            local v116 = id_record_ensure(p109, v115);
            local records3 = v116.records;
            local counts3 = v116.counts;

            if records3[id] then
                counts3[id] = counts3[id] + 1;
            else
                records3[id] = i;
                counts3[id] = 1;
                columns_map[v115] = v112;
            end;
        end;
    end;

    p109.archetype_index[p110.type] = p110;
    p109.archetypes[id] = p110;
    p109.archetype_edges[p110.id] = {};
end;

local function archetype_create(p117: table, p118: table, p119: any, p120: number?) -- Line: 813
    -- upvalues: archetype_register (copy)
    local v121 = p117.max_archetype_id + 1;
    p117.max_archetype_id = v121;
    local v122 = {};
    local v123 = {
        dead = false,
        columns = table.create(#p118),
        columns_map = v122,
        entities = {},
        id = v121,
        type = p119,
        types = p118
    };
    archetype_register(p117, v123, false);

    for i in v122 do
        local v124 = p117.observable[268];
        local v125;

        if v124 then
            v125 = v124[i];
        else
            v125 = nil;
        end;

        if v125 then
            for _, v in v125 do
                local query = v.query;
                local columns_map = v123.columns_map;
                local v126 = v;
                local v127;

                for _, v2 in query.filter_with do
                    if not columns_map[v2] then
                        v127 = false;
                        break;
                    end;
                end;

                local filter_without = query.filter_without;

                if filter_without then
                    v127 = true;

                    for _, v2 in filter_without do
                        if columns_map[v2] then
                            v127 = false;
                            break;
                        end;
                    end;
                end;

                if v127 then
                    v126.callback(v123);
                end;
            end;
        end;
    end;

    return v123;
end;

local function world_range(p128: table, p129: number, p130: number?) -- Line: 850
    local entity_index = p128.entity_index;
    entity_index.range_begin = p129;
    entity_index.range_end = p130;
    local max_id = entity_index.max_id;

    if max_id < p129 then
        local dense_array = entity_index.dense_array;
        local sparse_array = entity_index.sparse_array;

        for i = max_id + 1, p129 do
            dense_array[i] = i;
            sparse_array[i] = {
                dense = 0
            };
            local _ = i;
        end;

        entity_index.max_id = p129 - 1;
        entity_index.alive_count = p129 - 1;
    end;
end;

local function world_component(p131: table) -- Line: 979
    local v132 = p131.max_component_id + 1;

    if v132 > 256 then
        error("Too many components, consider using world:entity() instead to create components.");
    end;

    p131.max_component_id = v132;

    return v132;
end;

local function archetype_fast_delete_last(p133: table, p134: number) -- Line: 991
    -- upvalues: table_freeze_ret (copy)
    for _, v in p133 do
        if v ~= table_freeze_ret then
            v[p134] = nil;
        end;
    end;
end;

local function archetype_fast_delete(p135: table, p136: number, p137: number) -- Line: 999
    -- upvalues: table_freeze_ret (copy)
    for _, v in p135 do
        if v ~= table_freeze_ret then
            v[p137] = v[p136];
            v[p136] = nil;
        end;
    end;
end;

local function archetype_delete(p138: table, p139: table, p140: number) -- Line: 1008
    -- upvalues: table_freeze_ret (copy)
    local entity_index = p138.entity_index;
    local component_index = p138.component_index;
    local columns = p139.columns;
    local types = p139.types;
    local entities = p139.entities;
    local v141 = #entities;
    local v142 = #entities;
    local v143 = entities[v142];
    local v144;

    if p140 == v142 then
        v144 = v143;
    else
        local v145 = entity_index.sparse_array[v143 % 16777216];

        if not v145 or v145.dense == 0 then
            v145 = nil;
        end;

        if v145 then
            v145.row = p140;
        end;

        v144 = entities[p140];
        entities[p140] = v143;
    end;

    for _, v in types do
        local on_remove = component_index[v].on_remove;

        if on_remove then
            on_remove(v144, v);
        end;
    end;

    entities[v142] = nil;

    if p140 == v142 then
        for _, v in columns do
            if v ~= table_freeze_ret then
                v[v141] = nil;
            end;
        end;

        return;
    end;

    for _, v in columns do
        if v ~= table_freeze_ret then
            v[p140] = v[v141];
            v[v141] = nil;
        end;
    end;
end;

local function archetype_destroy(p146: table, p147: table) -- Line: 1048
    if p147 == p146.ROOT_ARCHETYPE then
        return;
    end;

    local component_index = p146.component_index;
    local archetype_edges = p146.archetype_edges;

    for i, v in archetype_edges[p147.id] do
        archetype_edges[v.id][i] = nil;
    end;

    local id = p147.id;
    p146.archetypes[id] = nil;
    p146.archetype_index[p147.type] = nil;

    for i in p147.columns_map do
        local v148 = component_index[i];
        v148.records[id] = nil;
        v148.counts[id] = nil;
        v148.size = v148.size - 1;

        if v148.size == 0 then
            component_index[i] = nil;
        end;

        local v149 = p146.observable[269];
        local v150;

        if v149 then
            v150 = v149[i];
        else
            v150 = nil;
        end;

        if v150 then
            for _, v in v150 do
                local query = v.query;
                local columns_map = p147.columns_map;
                local v151 = v;
                local v152;

                for _, v2 in query.filter_with do
                    if not columns_map[v2] then
                        v152 = false;
                        break;
                    end;
                end;

                local filter_without = query.filter_without;

                if filter_without then
                    v152 = true;

                    for _, v2 in filter_without do
                        if columns_map[v2] then
                            v152 = false;
                            break;
                        end;
                    end;
                end;

                if v152 then
                    v151.callback(p147);
                end;
            end;
        end;
    end;

    p147.dead = true;
end;

local function NOOP() -- Line: 1087
end;

local function query_iter_init(p153: table) -- Line: 1090
    -- upvalues: NOOP (copy)
    local compatible_archetypes = p153.compatible_archetypes;
    local u154 = 1;
    local u155 = compatible_archetypes[1];

    if not u155 then
        return NOOP;
    end;

    local entities = u155.entities;
    local u156 = #entities;
    local columns_map = u155.columns_map;
    local ids = p153.ids;
    local u157, u158, u159, u160, u161, u162, u163, u164, v165 = unpack(ids);
    local u166 = nil;
    local u167 = nil;
    local u168 = nil;
    local u169 = nil;
    local u170 = nil;
    local u171 = nil;
    local u172 = nil;
    local u173;

    if u158 then
        if u159 then
            if u160 then
                if u161 then
                    if u162 then
                        if u163 then
                            if u164 then
                                u173 = columns_map[u157];
                                u166 = columns_map[u158];
                                u167 = columns_map[u159];
                                u168 = columns_map[u160];
                                u169 = columns_map[u161];
                                u170 = columns_map[u162];
                                u171 = columns_map[u163];
                                u172 = columns_map[u164];
                            else
                                u173 = columns_map[u157];
                                u166 = columns_map[u158];
                                u167 = columns_map[u159];
                                u168 = columns_map[u160];
                                u169 = columns_map[u161];
                                u170 = columns_map[u162];
                                u171 = columns_map[u163];
                            end;
                        else
                            u173 = columns_map[u157];
                            u166 = columns_map[u158];
                            u167 = columns_map[u159];
                            u168 = columns_map[u160];
                            u169 = columns_map[u161];
                            u170 = columns_map[u162];
                        end;
                    else
                        u173 = columns_map[u157];
                        u166 = columns_map[u158];
                        u167 = columns_map[u159];
                        u168 = columns_map[u160];
                        u169 = columns_map[u161];
                    end;
                else
                    u173 = columns_map[u157];
                    u166 = columns_map[u158];
                    u167 = columns_map[u159];
                    u168 = columns_map[u160];
                end;
            else
                u173 = columns_map[u157];
                u166 = columns_map[u158];
                u167 = columns_map[u159];
            end;
        else
            u173 = columns_map[u157];
            u166 = columns_map[u158];
        end;
    else
        u173 = columns_map[u157];
    end;

    local v174;

    if u158 then
        if u159 then
            if u160 then
                if u161 then
                    if u162 then
                        if u163 then
                            if u164 then
                                if v165 then
                                    local u175 = {};
                                    local u176 = #ids;

                                    v174 = function() -- Line: 1385, Name: world_query_iter_next
                                        -- upvalues: entities (ref), u156 (ref), u154 (ref), u155 (ref), compatible_archetypes (copy), columns_map (ref), u173 (ref), u157 (copy), u166 (ref), u158 (copy), u167 (ref), u159 (copy), u168 (ref), u160 (copy), u169 (ref), u161 (copy), u170 (ref), u162 (copy), u171 (ref), u163 (copy), u172 (ref), u164 (copy), u176 (copy), u175 (copy)
                                        local v177 = entities[u156];

                                        while v177 == nil do
                                            u154 = u154 + 1;
                                            u155 = compatible_archetypes[u154];

                                            if not u155 then
                                                return nil;
                                            end;

                                            entities = u155.entities;
                                            u156 = #entities;

                                            if u156 ~= 0 then
                                                v177 = entities[u156];
                                                columns_map = u155.columns_map;
                                                u173 = columns_map[u157];
                                                u166 = columns_map[u158];
                                                u167 = columns_map[u159];
                                                u168 = columns_map[u160];
                                                u169 = columns_map[u161];
                                                u170 = columns_map[u162];
                                                u171 = columns_map[u163];
                                                u172 = columns_map[u164];
                                            end;
                                        end;

                                        local v178 = u156;
                                        u156 = u156 - 1;

                                        for i = 9, u176 do
                                            u175[i - 8] = columns_map[i][v178];
                                            local _ = i;
                                        end;

                                        return v177, u173[v178], u166[v178], u167[v178], u168[v178], u169[v178], u170[v178], u171[v178], u172[v178], unpack(u175);
                                    end;
                                else
                                    v174 = function() -- Line: 1351, Name: world_query_iter_next
                                        -- upvalues: entities (ref), u156 (ref), u154 (ref), u155 (ref), compatible_archetypes (copy), columns_map (ref), u173 (ref), u157 (copy), u166 (ref), u158 (copy), u167 (ref), u159 (copy), u168 (ref), u160 (copy), u169 (ref), u161 (copy), u170 (ref), u162 (copy), u171 (ref), u163 (copy), u172 (ref), u164 (copy)
                                        local v179 = entities[u156];

                                        while v179 == nil do
                                            u154 = u154 + 1;
                                            u155 = compatible_archetypes[u154];

                                            if not u155 then
                                                return nil;
                                            end;

                                            entities = u155.entities;
                                            u156 = #entities;

                                            if u156 ~= 0 then
                                                v179 = entities[u156];
                                                columns_map = u155.columns_map;
                                                u173 = columns_map[u157];
                                                u166 = columns_map[u158];
                                                u167 = columns_map[u159];
                                                u168 = columns_map[u160];
                                                u169 = columns_map[u161];
                                                u170 = columns_map[u162];
                                                u171 = columns_map[u163];
                                                u172 = columns_map[u164];
                                            end;
                                        end;

                                        local v180 = u156;
                                        u156 = u156 - 1;

                                        return v179, u173[v180], u166[v180], u167[v180], u168[v180], u169[v180], u170[v180], u171[v180], u172[v180];
                                    end;
                                end;
                            else
                                v174 = function() -- Line: 1320, Name: world_query_iter_next
                                    -- upvalues: entities (ref), u156 (ref), u154 (ref), u155 (ref), compatible_archetypes (copy), columns_map (ref), u173 (ref), u157 (copy), u166 (ref), u158 (copy), u167 (ref), u159 (copy), u168 (ref), u160 (copy), u169 (ref), u161 (copy), u170 (ref), u162 (copy), u171 (ref), u163 (copy)
                                    local v181 = entities[u156];

                                    while v181 == nil do
                                        u154 = u154 + 1;
                                        u155 = compatible_archetypes[u154];

                                        if not u155 then
                                            return nil;
                                        end;

                                        entities = u155.entities;
                                        u156 = #entities;

                                        if u156 ~= 0 then
                                            v181 = entities[u156];
                                            columns_map = u155.columns_map;
                                            u173 = columns_map[u157];
                                            u166 = columns_map[u158];
                                            u167 = columns_map[u159];
                                            u168 = columns_map[u160];
                                            u169 = columns_map[u161];
                                            u170 = columns_map[u162];
                                            u171 = columns_map[u163];
                                        end;
                                    end;

                                    local v182 = u156;
                                    u156 = u156 - 1;

                                    return v181, u173[v182], u166[v182], u167[v182], u168[v182], u169[v182], u170[v182], u171[v182];
                                end;
                            end;
                        else
                            v174 = function() -- Line: 1290, Name: world_query_iter_next
                                -- upvalues: entities (ref), u156 (ref), u154 (ref), u155 (ref), compatible_archetypes (copy), columns_map (ref), u173 (ref), u157 (copy), u166 (ref), u158 (copy), u167 (ref), u159 (copy), u168 (ref), u160 (copy), u169 (ref), u161 (copy), u170 (ref), u162 (copy)
                                local v183 = entities[u156];

                                while v183 == nil do
                                    u154 = u154 + 1;
                                    u155 = compatible_archetypes[u154];

                                    if not u155 then
                                        return nil;
                                    end;

                                    entities = u155.entities;
                                    u156 = #entities;

                                    if u156 ~= 0 then
                                        v183 = entities[u156];
                                        columns_map = u155.columns_map;
                                        u173 = columns_map[u157];
                                        u166 = columns_map[u158];
                                        u167 = columns_map[u159];
                                        u168 = columns_map[u160];
                                        u169 = columns_map[u161];
                                        u170 = columns_map[u162];
                                    end;
                                end;

                                local v184 = u156;
                                u156 = u156 - 1;

                                return v183, u173[v184], u166[v184], u167[v184], u168[v184], u169[v184], u170[v184];
                            end;
                        end;
                    else
                        v174 = function() -- Line: 1261, Name: world_query_iter_next
                            -- upvalues: entities (ref), u156 (ref), u154 (ref), u155 (ref), compatible_archetypes (copy), columns_map (ref), u173 (ref), u157 (copy), u166 (ref), u158 (copy), u167 (ref), u159 (copy), u168 (ref), u160 (copy), u169 (ref), u161 (copy)
                            local v185 = entities[u156];

                            while v185 == nil do
                                u154 = u154 + 1;
                                u155 = compatible_archetypes[u154];

                                if not u155 then
                                    return nil;
                                end;

                                entities = u155.entities;
                                u156 = #entities;

                                if u156 ~= 0 then
                                    v185 = entities[u156];
                                    columns_map = u155.columns_map;
                                    u173 = columns_map[u157];
                                    u166 = columns_map[u158];
                                    u167 = columns_map[u159];
                                    u168 = columns_map[u160];
                                    u169 = columns_map[u161];
                                end;
                            end;

                            local v186 = u156;
                            u156 = u156 - 1;

                            return v185, u173[v186], u166[v186], u167[v186], u168[v186], u169[v186];
                        end;
                    end;
                else
                    v174 = function() -- Line: 1233, Name: world_query_iter_next
                        -- upvalues: entities (ref), u156 (ref), u154 (ref), u155 (ref), compatible_archetypes (copy), columns_map (ref), u173 (ref), u157 (copy), u166 (ref), u158 (copy), u167 (ref), u159 (copy), u168 (ref), u160 (copy)
                        local v187 = entities[u156];

                        while v187 == nil do
                            u154 = u154 + 1;
                            u155 = compatible_archetypes[u154];

                            if not u155 then
                                return nil;
                            end;

                            entities = u155.entities;
                            u156 = #entities;

                            if u156 ~= 0 then
                                v187 = entities[u156];
                                columns_map = u155.columns_map;
                                u173 = columns_map[u157];
                                u166 = columns_map[u158];
                                u167 = columns_map[u159];
                                u168 = columns_map[u160];
                            end;
                        end;

                        local v188 = u156;
                        u156 = u156 - 1;

                        return v187, u173[v188], u166[v188], u167[v188], u168[v188];
                    end;
                end;
            else
                v174 = function() -- Line: 1206, Name: world_query_iter_next
                    -- upvalues: entities (ref), u156 (ref), u154 (ref), u155 (ref), compatible_archetypes (copy), columns_map (ref), u173 (ref), u157 (copy), u166 (ref), u158 (copy), u167 (ref), u159 (copy)
                    local v189 = entities[u156];

                    while v189 == nil do
                        u154 = u154 + 1;
                        u155 = compatible_archetypes[u154];

                        if not u155 then
                            return nil;
                        end;

                        entities = u155.entities;
                        u156 = #entities;

                        if u156 ~= 0 then
                            v189 = entities[u156];
                            columns_map = u155.columns_map;
                            u173 = columns_map[u157];
                            u166 = columns_map[u158];
                            u167 = columns_map[u159];
                        end;
                    end;

                    local v190 = u156;
                    u156 = u156 - 1;

                    return v189, u173[v190], u166[v190], u167[v190];
                end;
            end;
        else
            v174 = function() -- Line: 1180, Name: world_query_iter_next
                -- upvalues: entities (ref), u156 (ref), u154 (ref), u155 (ref), compatible_archetypes (copy), columns_map (ref), u173 (ref), u157 (copy), u166 (ref), u158 (copy)
                local v191 = entities[u156];

                while v191 == nil do
                    u154 = u154 + 1;
                    u155 = compatible_archetypes[u154];

                    if not u155 then
                        return nil;
                    end;

                    entities = u155.entities;
                    u156 = #entities;

                    if u156 ~= 0 then
                        v191 = entities[u156];
                        columns_map = u155.columns_map;
                        u173 = columns_map[u157];
                        u166 = columns_map[u158];
                    end;
                end;

                local v192 = u156;
                u156 = u156 - 1;

                return v191, u173[v192], u166[v192];
            end;
        end;
    else
        v174 = function() -- Line: 1155, Name: world_query_iter_next
            -- upvalues: entities (ref), u156 (ref), u154 (ref), u155 (ref), compatible_archetypes (copy), columns_map (ref), u173 (ref), u157 (copy)
            local v193 = entities[u156];

            while v193 == nil do
                u154 = u154 + 1;
                u155 = compatible_archetypes[u154];

                if not u155 then
                    return nil;
                end;

                entities = u155.entities;
                u156 = #entities;

                if u156 ~= 0 then
                    v193 = entities[u156];
                    columns_map = u155.columns_map;
                    u173 = columns_map[u157];
                end;
            end;

            local v194 = u156;
            u156 = u156 - 1;

            return v193, u173[v194];
        end;
    end;

    p153.next = v174;

    return v174;
end;

local function query_iter(p195) -- Line: 1426
    -- upvalues: query_iter_init (copy)
    return p195.next or query_iter_init(p195);
end;

local function query_without(p196: table, ...) -- Line: 1434
    local v197 = { ... };
    p196.filter_without = v197;
    local compatible_archetypes = p196.compatible_archetypes;

    for i = #compatible_archetypes, 1, -1 do
        local columns_map = compatible_archetypes[i].columns_map;
        local v198 = i;
        local v199 = true;

        for _, v in v197 do
            if columns_map[v] then
                v199 = false;
                break;
            end;
        end;

        if not v199 then
            local v200 = #compatible_archetypes;

            if v200 ~= v198 then
                compatible_archetypes[v198] = compatible_archetypes[v200];
            end;

            compatible_archetypes[v200] = nil;
        end;
    end;

    return p196;
end;

local function query_with(p201: table, ...) -- Line: 1464
    local compatible_archetypes = p201.compatible_archetypes;
    local v202 = { ... };
    p201.filter_with = v202;

    for i = #compatible_archetypes, 1, -1 do
        local columns_map = compatible_archetypes[i].columns_map;
        local v203 = i;
        local v204 = true;

        for _, v in v202 do
            if not columns_map[v] then
                v204 = false;
                break;
            end;
        end;

        if not v204 then
            local v205 = #compatible_archetypes;

            if v205 ~= v203 then
                compatible_archetypes[v203] = compatible_archetypes[v205];
            end;

            compatible_archetypes[v205] = nil;
        end;
    end;

    return p201;
end;

local function query_archetypes(p206) -- Line: 1498
    return p206.compatible_archetypes;
end;

local u207 = {};
u207.__index = u207;
u207.__iter = query_iter;
u207.iter = query_iter_init;
u207.without = query_without;
u207.with = query_with;
u207.archetypes = query_archetypes;

function u207.cached(p208: table) -- Line: 1502
    -- upvalues: NOOP (copy), query_archetypes (copy)
    local filter_with = p208.filter_with;
    local ids = p208.ids;

    if filter_with then
        table.move(ids, 1, #ids, #filter_with + 1, filter_with);
    else
        p208.filter_with = ids;
    end;

    local compatible_archetypes = p208.compatible_archetypes;
    local u209 = 1;
    local u210, u211, u212, u213, u214, u215, u216, u217, v218 = unpack(ids);
    local u219 = nil;
    local u220 = nil;
    local u221 = nil;
    local u222 = nil;
    local u223 = nil;
    local u224 = nil;
    local u225 = nil;
    local u226 = nil;
    local u227 = nil;
    local u228 = nil;
    local u229 = nil;
    local u230 = nil;
    local u231 = nil;
    local compatible_archetypes2 = p208.compatible_archetypes;
    local observable = p208.world.observable;
    local v232 = observable[268];

    if not v232 then
        v232 = {};
        observable[268] = v232;
    end;

    local v233 = v232[u210];

    if not v233 then
        v233 = {};
        v232[u210] = v233;
    end;

    local v234 = observable[269];

    if not v234 then
        v234 = {};
        observable[269] = v234;
    end;

    local v235 = v234[u210];

    if not v235 then
        v235 = {};
        v234[u210] = v235;
    end;

    table.insert(v233, {
        query = p208,

        callback = function(p236) -- Line: 1551, Name: on_create_callback
            -- upvalues: compatible_archetypes2 (copy)
            table.insert(compatible_archetypes2, p236);
        end
    });
    table.insert(v235, {
        query = p208,

        callback = function(p237) -- Line: 1555, Name: on_delete_callback
            -- upvalues: compatible_archetypes2 (copy)
            local table_find_ret = table.find(compatible_archetypes2, p237);

            if table_find_ret == nil then
                return;
            end;

            local v238 = #compatible_archetypes2;
            compatible_archetypes2[table_find_ret] = compatible_archetypes2[v238];
            compatible_archetypes2[v238] = nil;
        end
    });

    local function cached_query_iter() -- Line: 1571
        -- upvalues: u209 (ref), u230 (ref), compatible_archetypes (copy), NOOP (ref), u228 (ref), u229 (ref), u231 (ref), u211 (copy), u219 (ref), u210 (copy), u212 (copy), u220 (ref), u213 (copy), u221 (ref), u214 (copy), u222 (ref), u215 (copy), u223 (ref), u216 (copy), u224 (ref), u217 (copy), u225 (ref), u226 (ref), u227 (ref)
        u209 = 1;
        u230 = compatible_archetypes[u209];

        if not u230 then
            return NOOP;
        end;

        u228 = u230.entities;
        u229 = #u228;
        u231 = u230.columns_map;

        if u211 then
            if u212 then
                if u213 then
                    if u214 then
                        if u215 then
                            if u216 then
                                if u217 then
                                    u219 = u231[u210];
                                    u220 = u231[u211];
                                    u221 = u231[u212];
                                    u222 = u231[u213];
                                    u223 = u231[u214];
                                    u224 = u231[u215];
                                    u225 = u231[u216];
                                    u226 = u231[u217];
                                else
                                    u219 = u231[u210];
                                    u220 = u231[u211];
                                    u221 = u231[u212];
                                    u222 = u231[u213];
                                    u223 = u231[u214];
                                    u224 = u231[u215];
                                    u225 = u231[u216];
                                end;
                            else
                                u219 = u231[u210];
                                u220 = u231[u211];
                                u221 = u231[u212];
                                u222 = u231[u213];
                                u223 = u231[u214];
                                u224 = u231[u215];
                            end;
                        else
                            u219 = u231[u210];
                            u220 = u231[u211];
                            u221 = u231[u212];
                            u222 = u231[u213];
                            u223 = u231[u214];
                        end;
                    else
                        u219 = u231[u210];
                        u220 = u231[u211];
                        u221 = u231[u212];
                        u222 = u231[u213];
                    end;
                else
                    u219 = u231[u210];
                    u220 = u231[u211];
                    u221 = u231[u212];
                end;
            else
                u219 = u231[u210];
                u220 = u231[u211];
            end;
        else
            u219 = u231[u210];
        end;

        return u227;
    end;

    if u211 then
        if u212 then
            if u213 then
                if u214 then
                    if u215 then
                        if u216 then
                            if u217 then
                                if v218 then
                                    local u239 = {};
                                    local u240 = #ids;

                                    u227 = function() -- Line: 1860, Name: world_query_iter_next
                                        -- upvalues: u228 (ref), u229 (ref), u209 (ref), u230 (ref), compatible_archetypes (copy), u231 (ref), u219 (ref), u210 (copy), u220 (ref), u211 (copy), u221 (ref), u212 (copy), u222 (ref), u213 (copy), u223 (ref), u214 (copy), u224 (ref), u215 (copy), u225 (ref), u216 (copy), u226 (ref), u217 (copy), u240 (copy), u239 (copy)
                                        local v241 = u228[u229];

                                        while v241 == nil do
                                            u209 = u209 + 1;
                                            u230 = compatible_archetypes[u209];

                                            if not u230 then
                                                return nil;
                                            end;

                                            u228 = u230.entities;
                                            u229 = #u228;

                                            if u229 ~= 0 then
                                                v241 = u228[u229];
                                                u231 = u230.columns_map;
                                                u219 = u231[u210];
                                                u220 = u231[u211];
                                                u221 = u231[u212];
                                                u222 = u231[u213];
                                                u223 = u231[u214];
                                                u224 = u231[u215];
                                                u225 = u231[u216];
                                                u226 = u231[u217];
                                            end;
                                        end;

                                        local v242 = u229;
                                        u229 = u229 - 1;

                                        for i = 9, u240 do
                                            u239[i - 8] = u231[i][v242];
                                            local _ = i;
                                        end;

                                        return v241, u219[v242], u220[v242], u221[v242], u222[v242], u223[v242], u224[v242], u225[v242], unpack(u239);
                                    end;
                                else
                                    u227 = function() -- Line: 1826, Name: world_query_iter_next
                                        -- upvalues: u228 (ref), u229 (ref), u209 (ref), u230 (ref), compatible_archetypes (copy), u231 (ref), u219 (ref), u210 (copy), u220 (ref), u211 (copy), u221 (ref), u212 (copy), u222 (ref), u213 (copy), u223 (ref), u214 (copy), u224 (ref), u215 (copy), u225 (ref), u216 (copy), u226 (ref), u217 (copy)
                                        local v243 = u228[u229];

                                        while v243 == nil do
                                            u209 = u209 + 1;
                                            u230 = compatible_archetypes[u209];

                                            if not u230 then
                                                return nil;
                                            end;

                                            u228 = u230.entities;
                                            u229 = #u228;

                                            if u229 ~= 0 then
                                                v243 = u228[u229];
                                                u231 = u230.columns_map;
                                                u219 = u231[u210];
                                                u220 = u231[u211];
                                                u221 = u231[u212];
                                                u222 = u231[u213];
                                                u223 = u231[u214];
                                                u224 = u231[u215];
                                                u225 = u231[u216];
                                                u226 = u231[u217];
                                            end;
                                        end;

                                        local v244 = u229;
                                        u229 = u229 - 1;

                                        return v243, u219[v244], u220[v244], u221[v244], u222[v244], u223[v244], u224[v244], u225[v244], u226[v244];
                                    end;
                                end;
                            else
                                u227 = function() -- Line: 1795, Name: world_query_iter_next
                                    -- upvalues: u228 (ref), u229 (ref), u209 (ref), u230 (ref), compatible_archetypes (copy), u231 (ref), u219 (ref), u210 (copy), u220 (ref), u211 (copy), u221 (ref), u212 (copy), u222 (ref), u213 (copy), u223 (ref), u214 (copy), u224 (ref), u215 (copy), u225 (ref), u216 (copy)
                                    local v245 = u228[u229];

                                    while v245 == nil do
                                        u209 = u209 + 1;
                                        u230 = compatible_archetypes[u209];

                                        if not u230 then
                                            return nil;
                                        end;

                                        u228 = u230.entities;
                                        u229 = #u228;

                                        if u229 ~= 0 then
                                            v245 = u228[u229];
                                            u231 = u230.columns_map;
                                            u219 = u231[u210];
                                            u220 = u231[u211];
                                            u221 = u231[u212];
                                            u222 = u231[u213];
                                            u223 = u231[u214];
                                            u224 = u231[u215];
                                            u225 = u231[u216];
                                        end;
                                    end;

                                    local v246 = u229;
                                    u229 = u229 - 1;

                                    return v245, u219[v246], u220[v246], u221[v246], u222[v246], u223[v246], u224[v246], u225[v246];
                                end;
                            end;
                        else
                            u227 = function() -- Line: 1765, Name: world_query_iter_next
                                -- upvalues: u228 (ref), u229 (ref), u209 (ref), u230 (ref), compatible_archetypes (copy), u231 (ref), u219 (ref), u210 (copy), u220 (ref), u211 (copy), u221 (ref), u212 (copy), u222 (ref), u213 (copy), u223 (ref), u214 (copy), u224 (ref), u215 (copy)
                                local v247 = u228[u229];

                                while v247 == nil do
                                    u209 = u209 + 1;
                                    u230 = compatible_archetypes[u209];

                                    if not u230 then
                                        return nil;
                                    end;

                                    u228 = u230.entities;
                                    u229 = #u228;

                                    if u229 ~= 0 then
                                        v247 = u228[u229];
                                        u231 = u230.columns_map;
                                        u219 = u231[u210];
                                        u220 = u231[u211];
                                        u221 = u231[u212];
                                        u222 = u231[u213];
                                        u223 = u231[u214];
                                        u224 = u231[u215];
                                    end;
                                end;

                                local v248 = u229;
                                u229 = u229 - 1;

                                return v247, u219[v248], u220[v248], u221[v248], u222[v248], u223[v248], u224[v248];
                            end;
                        end;
                    else
                        u227 = function() -- Line: 1736, Name: world_query_iter_next
                            -- upvalues: u228 (ref), u229 (ref), u209 (ref), u230 (ref), compatible_archetypes (copy), u231 (ref), u219 (ref), u210 (copy), u220 (ref), u211 (copy), u221 (ref), u212 (copy), u222 (ref), u213 (copy), u223 (ref), u214 (copy)
                            local v249 = u228[u229];

                            while v249 == nil do
                                u209 = u209 + 1;
                                u230 = compatible_archetypes[u209];

                                if not u230 then
                                    return nil;
                                end;

                                u228 = u230.entities;
                                u229 = #u228;

                                if u229 ~= 0 then
                                    v249 = u228[u229];
                                    u231 = u230.columns_map;
                                    u219 = u231[u210];
                                    u220 = u231[u211];
                                    u221 = u231[u212];
                                    u222 = u231[u213];
                                    u223 = u231[u214];
                                end;
                            end;

                            local v250 = u229;
                            u229 = u229 - 1;

                            return v249, u219[v250], u220[v250], u221[v250], u222[v250], u223[v250];
                        end;
                    end;
                else
                    u227 = function() -- Line: 1708, Name: world_query_iter_next
                        -- upvalues: u228 (ref), u229 (ref), u209 (ref), u230 (ref), compatible_archetypes (copy), u231 (ref), u219 (ref), u210 (copy), u220 (ref), u211 (copy), u221 (ref), u212 (copy), u222 (ref), u213 (copy)
                        local v251 = u228[u229];

                        while v251 == nil do
                            u209 = u209 + 1;
                            u230 = compatible_archetypes[u209];

                            if not u230 then
                                return nil;
                            end;

                            u228 = u230.entities;
                            u229 = #u228;

                            if u229 ~= 0 then
                                v251 = u228[u229];
                                u231 = u230.columns_map;
                                u219 = u231[u210];
                                u220 = u231[u211];
                                u221 = u231[u212];
                                u222 = u231[u213];
                            end;
                        end;

                        local v252 = u229;
                        u229 = u229 - 1;

                        return v251, u219[v252], u220[v252], u221[v252], u222[v252];
                    end;
                end;
            else
                u227 = function() -- Line: 1681, Name: world_query_iter_next
                    -- upvalues: u228 (ref), u229 (ref), u209 (ref), u230 (ref), compatible_archetypes (copy), u231 (ref), u219 (ref), u210 (copy), u220 (ref), u211 (copy), u221 (ref), u212 (copy)
                    local v253 = u228[u229];

                    while v253 == nil do
                        u209 = u209 + 1;
                        u230 = compatible_archetypes[u209];

                        if not u230 then
                            return nil;
                        end;

                        u228 = u230.entities;
                        u229 = #u228;

                        if u229 ~= 0 then
                            v253 = u228[u229];
                            u231 = u230.columns_map;
                            u219 = u231[u210];
                            u220 = u231[u211];
                            u221 = u231[u212];
                        end;
                    end;

                    local v254 = u229;
                    u229 = u229 - 1;

                    return v253, u219[v254], u220[v254], u221[v254];
                end;
            end;
        else
            u227 = function() -- Line: 1655, Name: world_query_iter_next
                -- upvalues: u228 (ref), u229 (ref), u209 (ref), u230 (ref), compatible_archetypes (copy), u231 (ref), u219 (ref), u210 (copy), u220 (ref), u211 (copy)
                local v255 = u228[u229];

                while v255 == nil do
                    u209 = u209 + 1;
                    u230 = compatible_archetypes[u209];

                    if not u230 then
                        return nil;
                    end;

                    u228 = u230.entities;
                    u229 = #u228;

                    if u229 ~= 0 then
                        v255 = u228[u229];
                        u231 = u230.columns_map;
                        u219 = u231[u210];
                        u220 = u231[u211];
                    end;
                end;

                local v256 = u229;
                u229 = u229 - 1;

                return v255, u219[v256], u220[v256];
            end;
        end;
    else
        u227 = function() -- Line: 1630, Name: world_query_iter_next
            -- upvalues: u228 (ref), u229 (ref), u209 (ref), u230 (ref), compatible_archetypes (copy), u231 (ref), u219 (ref), u210 (copy)
            local v257 = u228[u229];

            while v257 == nil do
                u209 = u209 + 1;
                u230 = compatible_archetypes[u209];

                if not u230 then
                    return nil;
                end;

                u228 = u230.entities;
                u229 = #u228;

                if u229 ~= 0 then
                    v257 = u228[u229];
                    u231 = u230.columns_map;
                    u219 = u231[u210];
                end;
            end;

            local v258 = u229;
            u229 = u229 - 1;

            return v257, u219[v258];
        end;
    end;

    p208.archetypes = query_archetypes;
    p208.__iter = cached_query_iter;
    p208.iter = cached_query_iter;
    setmetatable(p208, p208);

    return p208;
end;

local function world_query(p259: table, ...) -- Line: 1914
    -- upvalues: u207 (copy)
    local v260 = {};
    local v261 = { ... };
    local archetypes = p259.archetypes;
    local component_index = p259.component_index;
    local v262 = setmetatable({
        ids = v261,
        compatible_archetypes = v260,
        world = p259
    }, u207);
    local v263 = nil;
    local v264 = 0;

    for _, v in v261 do
        local v265 = component_index[v];

        if not v265 then
            return v262;
        end;

        if v263 == nil or v265.size < v263.size then
            v263 = v265;
        end;
    end;

    if v263 == nil then
        return v262;
    end;

    for i in v263.records do
        local v266 = archetypes[i];

        if #v266.entities ~= 0 then
            local columns_map = v266.columns_map;
            local v267 = false;

            for _, v in v261 do
                if not columns_map[v] then
                    v267 = true;
                    break;
                end;
            end;

            if not v267 then
                v264 = v264 + 1;
                v260[v264] = v266;
            end;
        end;
    end;

    return v262;
end;

local function world_each(p268: table, p269: any) -- Line: 1974
    -- upvalues: NOOP (copy)
    local v270 = p268.component_index[p269];

    if not v270 then
        return NOOP;
    end;

    local records = v270.records;
    local archetypes = p268.archetypes;
    local u271 = next(records, nil);
    local u272 = archetypes[u271];

    if not u272 then
        return NOOP;
    end;

    local entities = u272.entities;
    local u273 = #entities;

    return function() -- Line: 1991
        -- upvalues: entities (ref), u273 (ref), u271 (ref), records (copy), u272 (ref), archetypes (copy)
        local v274 = entities[u273];

        while not v274 do
            u271 = next(records, u271);

            if not u271 then
                return;
            end;

            u272 = archetypes[u271];
            entities = u272.entities;
            u273 = #entities;
            v274 = entities[u273];
        end;

        u273 = u273 - 1;

        return v274;
    end;
end;

local function world_children(p275: table, p276: any) -- Line: 2008
    -- upvalues: NOOP (copy)
    local v277 = p275.component_index[p276 % 16777216 + 261 % 16777216 * 16777216 + 281474976710656];

    if not v277 then
        return NOOP;
    end;

    local records = v277.records;
    local archetypes = p275.archetypes;
    local u278 = next(records, nil);
    local u279 = archetypes[u278];

    if not u279 then
        return NOOP;
    end;

    local entities = u279.entities;
    local u280 = #entities;

    return function() -- Line: 1991
        -- upvalues: entities (ref), u280 (ref), u278 (ref), records (copy), u279 (ref), archetypes (copy)
        local v281 = entities[u280];

        while not v281 do
            u278 = next(records, u278);

            if not u278 then
                return;
            end;

            u279 = archetypes[u278];
            entities = u279.entities;
            u280 = #entities;
            v281 = entities[u280];
        end;

        u280 = u280 - 1;

        return v281;
    end;
end;

return {
    world = function() -- Line: 2138, Name: world_new
        -- upvalues: u5 (ref), archetype_create (copy), table_freeze_ret (copy), archetype_register (copy), entity_index_new_id (copy), archetype_delete (copy), archetype_destroy (copy), archetype_move (copy), world_query (copy), world_component (copy), world_each (copy), world_children (copy), world_range (copy), u6 (ref), u4 (ref), u1 (copy)
        local u282 = {};
        local u283 = {};
        local u284 = {
            alive_count = 0,
            max_id = 0,
            dense_array = u282,
            sparse_array = u283
        };
        local u285 = {};
        local u286 = {};
        local u287 = {};
        local u288 = {};
        local u289 = {
            ROOT_ARCHETYPE = nil,
            max_archetype_id = 0,
            archetype_edges = u288,
            component_index = u285,
            entity_index = u284,
            archetypes = u287,
            archetype_index = u286,
            max_component_id = u5,
            observable = {}
        };
        local u290 = archetype_create(u289, {}, "");
        u289.ROOT_ARCHETYPE = u290;

        local function inner_entity_index_try_get_any(p291: number) -- Line: 2178
            -- upvalues: u283 (copy)
            local v292 = u283[p291 % 16777216];

            if v292 and v292.dense ~= 0 then
                return v292;
            end;

            return nil;
        end;

        local function inner_archetype_move(p293: any, p294: table, p295: number, p296: table, p297: number) -- Line: 2188
            -- upvalues: table_freeze_ret (ref), u283 (copy)
            local columns = p296.columns;
            local entities = p294.entities;
            local entities2 = p296.entities;
            local v298 = #entities2;
            local types = p296.types;
            local columns_map = p294.columns_map;

            if p297 == v298 then
                for i, v in columns do
                    if v ~= table_freeze_ret then
                        local v299 = columns_map[types[i]];

                        if v299 then
                            v299[p295] = v[p297];
                        end;

                        v[v298] = nil;
                    end;
                end;
            else
                for i, v in columns do
                    if v ~= table_freeze_ret then
                        local v300 = columns_map[types[i]];

                        if v300 then
                            v300[p295] = v[p297];
                        end;

                        v[p297] = v[v298];
                        v[v298] = nil;
                    end;
                end;

                local v301 = entities2[v298];
                entities2[p297] = v301;
                u283[v301 % 16777216].row = p297;
            end;

            entities2[v298] = nil;
            entities[p295] = p293;
        end;

        local function inner_entity_move(p302: table, p303: any, p304: table, p305: table) -- Line: 2244
            -- upvalues: inner_archetype_move (copy)
            local row = p304.row;
            local archetype = p304.archetype;
            local entities = p305.entities;
            local v306 = #entities + 1;
            entities[v306] = p303;
            inner_archetype_move(p303, p305, v306, archetype, row);
            p304.archetype = p305;
            p304.row = v306;
        end;

        local function inner_entity_index_try_get_unsafe(p307: number) -- Line: 2272
            -- upvalues: u283 (copy), u282 (copy)
            local v308 = u283[p307 % 16777216];

            if not v308 or v308.dense == 0 then
                v308 = nil;
            end;

            if v308 and u282[v308.dense] ~= p307 then
                return nil;
            end;

            return v308;
        end;

        local function inner_world_add(p309: table, p310: any, p311: any) -- Line: 2286
            -- upvalues: u283 (copy), u282 (copy), u290 (copy), u288 (copy), u285 (copy), archetype_register (ref), archetype_create (ref), inner_archetype_move (copy)
            local _ = p309.entity_index;
            local v312 = u283[p310 % 16777216];

            if not v312 or v312.dense == 0 then
                v312 = nil;
            end;

            if v312 and u282[v312.dense] ~= p310 then
                v312 = nil;
            end;

            if not v312 then
                return;
            end;

            local archetype = v312.archetype;

            if p311 <= 281474976710656 then
                local v313 = archetype or p309.ROOT_ARCHETYPE;
                local v314;

                if v313.columns_map[p311] then
                    v314 = v313;
                else
                    local archetype_edges = p309.archetype_edges;
                    local v315 = archetype_edges[v313.id];
                    v314 = v315[p311];

                    if not v314 then
                        local types = v313.types;
                        local table_clone_ret = table.clone(types);
                        local v316;

                        for i, v in types do
                            if v == p311 then
                                v316 = -1;
                                break;
                            end;

                            if p311 < v then
                                v316 = i;
                                break;
                            end;
                        end;

                        v316 = #types + 1;
                        table.insert(table_clone_ret, v316, p311);

                        if #table_clone_ret < 1 then
                            v314 = p309.ROOT_ARCHETYPE;
                        else
                            local table_concat_ret = table.concat(table_clone_ret, "_");
                            v314 = p309.archetype_index[table_concat_ret];

                            if v314 then
                                if v314.dead then
                                    archetype_register(p309, v314);
                                    v314.dead = false;
                                end;
                            else
                                v314 = archetype_create(p309, table_clone_ret, table_concat_ret);
                            end;
                        end;

                        v315[p311] = v314;
                        archetype_edges[v314.id][p311] = v313;
                    end;
                end;

                if archetype == v314 then
                    return;
                end;

                if archetype then
                    local row = v312.row;
                    local archetype2 = v312.archetype;
                    local entities = v314.entities;
                    local v317 = #entities + 1;
                    entities[v317] = p310;
                    inner_archetype_move(p310, v314, v317, archetype2, row);
                    v312.archetype = v314;
                    v312.row = v317;
                elseif #v314.types > 0 then
                    local entities = v314.entities;
                    local v318 = #entities + 1;
                    entities[v318] = p310;
                    v312.archetype = v314;
                    v312.row = v318;
                end;

                local on_add = u285[p311].on_add;

                if on_add then
                    on_add(p310, p311);
                end;

                return;
            end;

            local v319 = archetype or u290;
            local v320 = u288[v319.id];
            local v321 = v320[p311];
            local v322;

            if v321 then
                if v321.dead then
                    archetype_register(p309, v321);
                    v321.dead = false;
                end;

                v322 = u285[p311];
            else
                v322 = u285[260 % 16777216 + (p311 - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656];

                if v322 and bit32.btest(v322.flags, 4) then
                    local v323 = v322.records[v319.id];

                    if v323 then
                        local on_remove = v322.on_remove;
                        local types = v319.types;

                        if on_remove then
                            on_remove(p310, types[v323]);
                            local archetype2 = v312.archetype;
                            types = archetype2.types;
                            v323 = v322.records[archetype2.id];
                        end;

                        local table_clone_ret = table.clone(types);
                        table_clone_ret[v323] = p311;

                        if #table_clone_ret < 1 then
                            v321 = p309.ROOT_ARCHETYPE;
                        else
                            local table_concat_ret = table.concat(table_clone_ret, "_");
                            v321 = p309.archetype_index[table_concat_ret];

                            if v321 then
                                if v321.dead then
                                    archetype_register(p309, v321);
                                    v321.dead = false;
                                end;
                            else
                                v321 = archetype_create(p309, table_clone_ret, table_concat_ret);
                            end;
                        end;
                    else
                        local types = v319.types;
                        local table_clone_ret = table.clone(types);
                        local v324;

                        for i, v in types do
                            if v == p311 then
                                v324 = -1;
                                break;
                            end;

                            if p311 < v then
                                v324 = i;
                                break;
                            end;
                        end;

                        v324 = #types + 1;
                        table.insert(table_clone_ret, v324, p311);

                        if #table_clone_ret < 1 then
                            v321 = p309.ROOT_ARCHETYPE;
                        else
                            local table_concat_ret = table.concat(table_clone_ret, "_");
                            v321 = p309.archetype_index[table_concat_ret];

                            if v321 then
                                if v321.dead then
                                    archetype_register(p309, v321);
                                    v321.dead = false;
                                end;
                            else
                                v321 = archetype_create(p309, table_clone_ret, table_concat_ret);
                            end;
                        end;

                        v322 = u285[p311];
                    end;
                else
                    local types = v319.types;
                    local table_clone_ret = table.clone(types);
                    local v325;

                    for i, v in types do
                        if v == p311 then
                            v325 = -1;
                            break;
                        end;

                        if p311 < v then
                            v325 = i;
                            break;
                        end;
                    end;

                    v325 = #types + 1;
                    table.insert(table_clone_ret, v325, p311);

                    if #table_clone_ret < 1 then
                        v321 = p309.ROOT_ARCHETYPE;
                    else
                        local table_concat_ret = table.concat(table_clone_ret, "_");
                        v321 = p309.archetype_index[table_concat_ret];

                        if v321 then
                            if v321.dead then
                                archetype_register(p309, v321);
                                v321.dead = false;
                            end;
                        else
                            v321 = archetype_create(p309, table_clone_ret, table_concat_ret);
                        end;
                    end;

                    v322 = u285[p311];
                end;

                v320[p311] = v321;
            end;

            if archetype == v321 then
                return;
            end;

            if archetype then
                local row = v312.row;
                local archetype2 = v312.archetype;
                local entities = v321.entities;
                local v326 = #entities + 1;
                entities[v326] = p310;
                inner_archetype_move(p310, v321, v326, archetype2, row);
                v312.archetype = v321;
                v312.row = v326;
            elseif #v321.types > 0 then
                local entities = v321.entities;
                local v327 = #entities + 1;
                entities[v327] = p310;
                v312.archetype = v321;
                v312.row = v327;
            end;

            local on_add = v322.on_add;

            if on_add then
                on_add(p310, p311);
            end;
        end;

        local function inner_world_target(p328: table, p329: any, p330: any, p331: number?) -- Line: 2428
            -- upvalues: u283 (copy), u282 (copy)
            local v332 = u283[p329 % 16777216];

            if not v332 or v332.dense == 0 then
                v332 = nil;
            end;

            if v332 and u282[v332.dense] ~= p329 then
                v332 = nil;
            end;

            if not v332 then
                return nil;
            end;

            local archetype = v332.archetype;

            if not archetype then
                return nil;
            end;

            local v333 = p328.component_index[260 % 16777216 + p330 % 16777216 * 16777216 + 281474976710656];

            if not v333 then
                return nil;
            end;

            local id = archetype.id;
            local v334 = v333.counts[id];

            if not v334 then
                return nil;
            end;

            local v335 = p331 or 0;

            if v334 <= v335 then
                v335 = v335 + v334 + 1;
            end;

            local v336 = archetype.types[v335 + v333.records[id]];

            if not v336 then
                return nil;
            end;

            local entity_index = p328.entity_index;
            local v337 = entity_index.sparse_array[(v336 - 281474976710656) % 16777216 % 16777216];

            if not v337 or v337.dense == 0 then
                v337 = nil;
            end;

            if v337 then
                return entity_index.dense_array[v337.dense];
            end;

            return nil;
        end;

        local function inner_archetype_traverse_add(p338: any, p339: table) -- Line: 2472
            -- upvalues: u290 (copy), u288 (copy), u289 (copy), archetype_register (ref), archetype_create (ref)
            local v340 = p339 or u290;

            if v340.columns_map[p338] then
                return v340;
            end;

            local v341 = u288;
            local v342 = v341[v340.id];
            local v343 = v342[p338];

            if not v343 then
                local v344 = u289;
                local types = v340.types;
                local table_clone_ret = table.clone(types);
                local v345;

                for i, v in types do
                    if v == p338 then
                        v345 = -1;
                        break;
                    end;

                    if p338 < v then
                        v345 = i;
                        break;
                    end;
                end;

                v345 = #types + 1;
                table.insert(table_clone_ret, v345, p338);

                if #table_clone_ret < 1 then
                    v343 = v344.ROOT_ARCHETYPE;
                else
                    local table_concat_ret = table.concat(table_clone_ret, "_");
                    v343 = v344.archetype_index[table_concat_ret];

                    if v343 then
                        if v343.dead then
                            archetype_register(v344, v343);
                            v343.dead = false;
                        end;
                    else
                        v343 = archetype_create(v344, table_clone_ret, table_concat_ret);
                    end;
                end;

                v342[p338] = v343;
                v341[v343.id][p338] = v340;
            end;

            return v343;
        end;

        local function inner_world_set(p346: table, p347: any, p348: any, p349: any) -- Line: 2490
            -- upvalues: u283 (copy), u282 (copy), u290 (copy), u285 (copy), u288 (copy), archetype_register (ref), archetype_create (ref), u289 (copy), u284 (copy), inner_archetype_move (copy)
            local v350 = u283[p347 % 16777216];

            if not v350 or v350.dense == 0 then
                v350 = nil;
            end;

            if v350 and u282[v350.dense] ~= p347 then
                v350 = nil;
            end;

            if not v350 then
                return;
            end;

            local archetype = v350.archetype;
            local v351 = archetype or u290;
            local v352 = v351.columns_map[p348];

            if v352 then
                local v353 = u285[p348];
                v352[v350.row] = p349;
                local on_change = v353.on_change;

                if on_change then
                    on_change(p347, p348, p349);
                end;
            else
                local v354, v355;

                if p348 > 281474976710656 then
                    local v356 = u288[v351.id];
                    v354 = v356[p348];

                    if v354 then
                        v355 = u285[p348];
                    else
                        v355 = u285[260 % 16777216 + (p348 - 281474976710656) // 16777216 % 16777216 * 16777216 + 281474976710656];

                        if v355 and bit32.btest(v355.flags, 4) then
                            local v357 = v355.records[v351.id];

                            if v357 then
                                local on_remove = v355.on_remove;
                                local types = v351.types;

                                if on_remove then
                                    on_remove(p347, types[v357]);
                                    local archetype2 = v350.archetype;
                                    types = archetype2.types;
                                    v357 = v355.records[archetype2.id];
                                end;

                                local table_clone_ret = table.clone(types);
                                table_clone_ret[v357] = p348;

                                if #table_clone_ret < 1 then
                                    v354 = p346.ROOT_ARCHETYPE;
                                else
                                    local table_concat_ret = table.concat(table_clone_ret, "_");
                                    v354 = p346.archetype_index[table_concat_ret];

                                    if v354 then
                                        if v354.dead then
                                            archetype_register(p346, v354);
                                            v354.dead = false;
                                        end;
                                    else
                                        v354 = archetype_create(p346, table_clone_ret, table_concat_ret);
                                    end;
                                end;
                            else
                                local types = v351.types;
                                local table_clone_ret = table.clone(types);
                                local v358;

                                for i, v in types do
                                    if v == p348 then
                                        v358 = -1;
                                        break;
                                    end;

                                    if p348 < v then
                                        v358 = i;
                                        break;
                                    end;
                                end;

                                v358 = #types + 1;
                                table.insert(table_clone_ret, v358, p348);

                                if #table_clone_ret < 1 then
                                    v354 = p346.ROOT_ARCHETYPE;
                                else
                                    local table_concat_ret = table.concat(table_clone_ret, "_");
                                    v354 = p346.archetype_index[table_concat_ret];

                                    if v354 then
                                        if v354.dead then
                                            archetype_register(p346, v354);
                                            v354.dead = false;
                                        end;
                                    else
                                        v354 = archetype_create(p346, table_clone_ret, table_concat_ret);
                                    end;
                                end;

                                v355 = u285[p348];
                            end;
                        else
                            local types = v351.types;
                            local table_clone_ret = table.clone(types);
                            local v359;

                            for i, v in types do
                                if v == p348 then
                                    v359 = -1;
                                    break;
                                end;

                                if p348 < v then
                                    v359 = i;
                                    break;
                                end;
                            end;

                            v359 = #types + 1;
                            table.insert(table_clone_ret, v359, p348);

                            if #table_clone_ret < 1 then
                                v354 = p346.ROOT_ARCHETYPE;
                            else
                                local table_concat_ret = table.concat(table_clone_ret, "_");
                                v354 = p346.archetype_index[table_concat_ret];

                                if v354 then
                                    if v354.dead then
                                        archetype_register(p346, v354);
                                        v354.dead = false;
                                    end;
                                else
                                    v354 = archetype_create(p346, table_clone_ret, table_concat_ret);
                                end;
                            end;

                            v355 = u285[p348];
                        end;

                        v356[p348] = v354;
                    end;
                else
                    local v360 = archetype or u290;

                    if v360.columns_map[p348] then
                        v354 = v360;
                    else
                        local v361 = u288;
                        local v362 = v361[v360.id];
                        v354 = v362[p348];

                        if not v354 then
                            local v363 = u289;
                            local types = v360.types;
                            local table_clone_ret = table.clone(types);
                            local v364;

                            for i, v in types do
                                if v == p348 then
                                    v364 = -1;
                                    break;
                                end;

                                if p348 < v then
                                    v364 = i;
                                    break;
                                end;
                            end;

                            v364 = #types + 1;
                            table.insert(table_clone_ret, v364, p348);

                            if #table_clone_ret < 1 then
                                v354 = v363.ROOT_ARCHETYPE;
                            else
                                local table_concat_ret = table.concat(table_clone_ret, "_");
                                v354 = v363.archetype_index[table_concat_ret];

                                if v354 then
                                    if v354.dead then
                                        archetype_register(v363, v354);
                                        v354.dead = false;
                                    end;
                                else
                                    v354 = archetype_create(v363, table_clone_ret, table_concat_ret);
                                end;
                            end;

                            v362[p348] = v354;
                            v361[v354.id][p348] = v360;
                        end;
                    end;

                    v355 = u285[p348];
                end;

                if archetype then
                    local row = v350.row;
                    local archetype2 = v350.archetype;
                    local entities = v354.entities;
                    local v365 = #entities + 1;
                    entities[v365] = p347;
                    inner_archetype_move(p347, v354, v365, archetype2, row);
                    v350.archetype = v354;
                    v350.row = v365;
                else
                    local entities = v354.entities;
                    local v366 = #entities + 1;
                    entities[v366] = p347;
                    v350.archetype = v354;
                    v350.row = v366;
                end;

                v354.columns_map[p348][v350.row] = p349;
                local on_add = v355.on_add;

                if on_add then
                    on_add(p347, p348, p349);
                end;
            end;
        end;

        local function inner_world_remove(p367: table, p368: any, p369: any) -- Line: 2640
            -- upvalues: u283 (copy), u282 (copy), archetype_register (ref), archetype_create (ref), u284 (copy), inner_archetype_move (copy)
            local v370 = u283[p368 % 16777216];

            if not v370 or v370.dense == 0 then
                v370 = nil;
            end;

            if v370 and u282[v370.dense] ~= p368 then
                v370 = nil;
            end;

            if not v370 then
                return;
            end;

            local archetype = v370.archetype;

            if not archetype then
                return;
            end;

            if archetype.columns_map[p369] then
                local on_remove = p367.component_index[p369].on_remove;

                if on_remove then
                    on_remove(p368, p369);
                end;

                local archetype2 = v370.archetype;
                local archetype_edges = p367.archetype_edges;
                local v371 = archetype_edges[archetype2.id];
                local v372 = v371[p369];

                if v372 == nil then
                    local types = archetype2.types;
                    local table_find_ret = table.find(types, p369);
                    local table_clone_ret = table.clone(types);
                    table.remove(table_clone_ret, table_find_ret);

                    if #table_clone_ret < 1 then
                        v372 = p367.ROOT_ARCHETYPE;
                    else
                        local table_concat_ret = table.concat(table_clone_ret, "_");
                        v372 = p367.archetype_index[table_concat_ret];

                        if v372 then
                            if v372.dead then
                                archetype_register(p367, v372);
                                v372.dead = false;
                            end;
                        else
                            v372 = archetype_create(p367, table_clone_ret, table_concat_ret);
                        end;
                    end;

                    v371[p369] = v372;
                    archetype_edges[v372.id][p369] = archetype2;
                end;

                local row = v370.row;
                local archetype3 = v370.archetype;
                local entities = v372.entities;
                local v373 = #entities + 1;
                entities[v373] = p368;
                inner_archetype_move(p368, v372, v373, archetype3, row);
                v370.archetype = v372;
                v370.row = v373;
            end;
        end;

        local function inner_world_clear(p374: table, p375: any) -- Line: 2664
            -- upvalues: u285 (copy), u287 (ref), inner_world_remove (copy), u284 (copy), archetype_register (ref), archetype_create (ref), u283 (copy), u282 (copy), inner_archetype_move (copy)
            local v376 = u285[p375 % 16777216 + 260 % 16777216 * 16777216 + 281474976710656];
            local v377 = u285[p375];
            local v378 = u285[260 % 16777216 + p375 % 16777216 * 16777216 + 281474976710656];

            if v377 then
                local v379 = 0;
                local v380 = {};

                for i in v377.records do
                    local entities = u287[i].entities;
                    local v381 = #entities;
                    table.move(entities, 1, v381, v379 + 1, v380);
                    v379 = v379 + v381;
                end;

                for _, v in v380 do
                    inner_world_remove(p374, v, p375);
                end;
            end;

            if v376 then
                for i in v376.records do
                    local v382 = u287[i];
                    local entities = v382.entities;

                    for _, v in v382.types do
                        if v > 281474976710656 then
                            local v383 = u284;
                            local v384 = v383.sparse_array[(v - 281474976710656) % 16777216 % 16777216];

                            if not v384 or v384.dense == 0 then
                                v384 = nil;
                            end;

                            local v385;

                            if v384 then
                                v385 = v383.dense_array[v384.dense];
                            else
                                v385 = nil;
                            end;

                            if v385 == p375 then
                                local archetype_edges = p374.archetype_edges;
                                local v386 = archetype_edges[v382.id];
                                local v387 = v386[v];

                                if v387 == nil then
                                    local types = v382.types;
                                    local table_find_ret = table.find(types, v);
                                    local table_clone_ret = table.clone(types);
                                    table.remove(table_clone_ret, table_find_ret);

                                    if #table_clone_ret < 1 then
                                        v387 = p374.ROOT_ARCHETYPE;
                                    else
                                        local table_concat_ret = table.concat(table_clone_ret, "_");
                                        v387 = p374.archetype_index[table_concat_ret];

                                        if v387 then
                                            if v387.dead then
                                                archetype_register(p374, v387);
                                                v387.dead = false;
                                            end;
                                        else
                                            v387 = archetype_create(p374, table_clone_ret, table_concat_ret);
                                        end;
                                    end;

                                    v386[v] = v387;
                                    archetype_edges[v387.id][v] = v382;
                                end;

                                local on_remove = u285[v].on_remove;

                                if on_remove then
                                    local v388 = v;

                                    for _, v2 in entities do
                                        on_remove(v2, v388);
                                    end;

                                    v382 = v387;
                                else
                                    v382 = v387;
                                end;
                            end;
                        end;
                    end;

                    for i2 = #entities, 1, -1 do
                        local v389 = entities[i2];
                        local v390 = u283[v389 % 16777216];

                        if not v390 or v390.dense == 0 then
                            v390 = nil;
                        end;

                        if v390 and u282[v390.dense] ~= v389 then
                            v390 = nil;
                        end;

                        local row = v390.row;
                        local archetype = v390.archetype;
                        local entities2 = v382.entities;
                        local v391 = #entities2 + 1;
                        entities2[v391] = v389;
                        inner_archetype_move(v389, v382, v391, archetype, row);
                        v390.archetype = v382;
                        v390.row = v391;
                        local _ = i2;
                    end;
                end;
            end;

            if v378 then
                local records = v378.records;
                local counts = v378.counts;

                for i in v378.records do
                    local v392 = u287[i];
                    local entities = v392.entities;
                    local v393 = records[i];
                    local types = v392.types;
                    local v394 = v392;

                    for i2 = v393, v393 + counts[i] - 1 do
                        local v395 = types[i2];
                        local archetype_edges = p374.archetype_edges;
                        local v396 = archetype_edges[v392.id];
                        v394 = v396[v395];

                        if v394 == nil then
                            local types2 = v392.types;
                            local table_find_ret = table.find(types2, v395);
                            local table_clone_ret = table.clone(types2);
                            table.remove(table_clone_ret, table_find_ret);

                            if #table_clone_ret < 1 then
                                v394 = p374.ROOT_ARCHETYPE;
                            else
                                local table_concat_ret = table.concat(table_clone_ret, "_");
                                v394 = p374.archetype_index[table_concat_ret];

                                if v394 then
                                    if v394.dead then
                                        archetype_register(p374, v394);
                                        v394.dead = false;
                                    end;
                                else
                                    v394 = archetype_create(p374, table_clone_ret, table_concat_ret);
                                end;
                            end;

                            v396[v395] = v394;
                            archetype_edges[v394.id][v395] = v392;
                        end;

                        local on_remove = u285[v395].on_remove;
                        local v397;

                        if on_remove then
                            v397 = i2;

                            for _, v in entities do
                                on_remove(v, v395);
                            end;
                        else
                            v397 = i2;
                        end;
                    end;

                    for i2 = #entities, 1, -1 do
                        local v398 = entities[i2];
                        local v399 = u283[v398 % 16777216];

                        if not v399 or v399.dense == 0 then
                            v399 = nil;
                        end;

                        if v399 and u282[v399.dense] ~= v398 then
                            v399 = nil;
                        end;

                        local row = v399.row;
                        local archetype = v399.archetype;
                        local entities2 = v394.entities;
                        local v400 = #entities2 + 1;
                        entities2[v400] = v398;
                        inner_archetype_move(v398, v394, v400, archetype, row);
                        v399.archetype = v394;
                        v399.row = v400;
                        local _ = i2;
                    end;
                end;
            end;
        end;

        local function inner_world_delete(p401: table, p402: any) -- Line: 2751
            -- upvalues: u283 (copy), u282 (copy), archetype_delete (ref), inner_world_delete (copy), archetype_destroy (ref), archetype_register (ref), archetype_create (ref), u284 (copy), inner_archetype_move (copy), archetype_move (ref)
            local v403 = u283[p402 % 16777216];

            if not v403 or v403.dense == 0 then
                v403 = nil;
            end;

            if v403 and u282[v403.dense] ~= p402 then
                v403 = nil;
            end;

            if not v403 then
                return;
            end;

            local archetype = v403.archetype;
            local row = v403.row;

            if archetype then
                archetype_delete(p401, archetype, row);
            end;

            local component_index = p401.component_index;
            local archetypes = p401.archetypes;
            local v404 = component_index[p402 % 16777216 + 260 % 16777216 * 16777216 + 281474976710656];
            local v405 = component_index[p402];
            local v406 = component_index[260 % 16777216 + p402 % 16777216 * 16777216 + 281474976710656];

            if v405 then
                if bit32.btest(v405.flags, 1) then
                    for i in v405.records do
                        local v407 = archetypes[i];
                        local entities = v407.entities;

                        for i2 = #entities, 1, -1 do
                            inner_world_delete(p401, entities[i2]);
                            local _ = i2;
                        end;

                        archetype_destroy(p401, v407);
                    end;
                else
                    local on_remove = v405.on_remove;

                    if on_remove then
                        for i in v405.records do
                            local v408 = archetypes[i];
                            local archetype_edges = p401.archetype_edges;
                            local v409 = archetype_edges[v408.id];
                            local v410 = v409[p402];

                            if v410 == nil then
                                local types = v408.types;
                                local table_find_ret = table.find(types, p402);
                                local table_clone_ret = table.clone(types);
                                table.remove(table_clone_ret, table_find_ret);

                                if #table_clone_ret < 1 then
                                    v410 = p401.ROOT_ARCHETYPE;
                                else
                                    local table_concat_ret = table.concat(table_clone_ret, "_");
                                    v410 = p401.archetype_index[table_concat_ret];

                                    if v410 then
                                        if v410.dead then
                                            archetype_register(p401, v410);
                                            v410.dead = false;
                                        end;
                                    else
                                        v410 = archetype_create(p401, table_clone_ret, table_concat_ret);
                                    end;
                                end;

                                v409[p402] = v410;
                                archetype_edges[v410.id][p402] = v408;
                            end;

                            local entities = v408.entities;

                            for i2 = #entities, 1, -1 do
                                local v411 = entities[i2];
                                on_remove(v411, p402);
                                local v412 = u283[v411 % 16777216];
                                local archetype2 = v412.archetype;

                                if archetype2 ~= v408 then
                                    local archetype_edges2 = p401.archetype_edges;
                                    local v413 = archetype_edges2[archetype2.id];
                                    v410 = v413[p402];

                                    if v410 == nil then
                                        local types = archetype2.types;
                                        local table_find_ret = table.find(types, p402);
                                        local table_clone_ret = table.clone(types);
                                        table.remove(table_clone_ret, table_find_ret);

                                        if #table_clone_ret < 1 then
                                            v410 = p401.ROOT_ARCHETYPE;
                                        else
                                            local table_concat_ret = table.concat(table_clone_ret, "_");
                                            v410 = p401.archetype_index[table_concat_ret];

                                            if v410 then
                                                if v410.dead then
                                                    archetype_register(p401, v410);
                                                    v410.dead = false;
                                                end;
                                            else
                                                v410 = archetype_create(p401, table_clone_ret, table_concat_ret);
                                            end;
                                        end;

                                        v413[p402] = v410;
                                        archetype_edges2[v410.id][p402] = archetype2;
                                    end;
                                end;

                                local row2 = v412.row;
                                local archetype3 = v412.archetype;
                                local entities2 = v410.entities;
                                local v414 = #entities2 + 1;
                                entities2[v414] = v411;
                                inner_archetype_move(v411, v410, v414, archetype3, row2);
                                v412.archetype = v410;
                                v412.row = v414;
                                local _ = i2;
                            end;

                            archetype_destroy(p401, v408);
                        end;
                    else
                        for i in v405.records do
                            local v415 = archetypes[i];
                            local archetype_edges = p401.archetype_edges;
                            local v416 = archetype_edges[v415.id];
                            local v417 = v416[p402];

                            if v417 == nil then
                                local types = v415.types;
                                local table_find_ret = table.find(types, p402);
                                local table_clone_ret = table.clone(types);
                                table.remove(table_clone_ret, table_find_ret);

                                if #table_clone_ret < 1 then
                                    v417 = p401.ROOT_ARCHETYPE;
                                else
                                    local table_concat_ret = table.concat(table_clone_ret, "_");
                                    v417 = p401.archetype_index[table_concat_ret];

                                    if v417 then
                                        if v417.dead then
                                            archetype_register(p401, v417);
                                            v417.dead = false;
                                        end;
                                    else
                                        v417 = archetype_create(p401, table_clone_ret, table_concat_ret);
                                    end;
                                end;

                                v416[p402] = v417;
                                archetype_edges[v417.id][p402] = v415;
                            end;

                            local entities = v415.entities;

                            for i2 = #entities, 1, -1 do
                                local v418 = entities[i2];
                                local v419 = u283[v418 % 16777216];
                                local row2 = v419.row;
                                local archetype2 = v419.archetype;
                                local entities2 = v417.entities;
                                local v420 = #entities2 + 1;
                                entities2[v420] = v418;
                                archetype_move(u284, v418, v417, v420, archetype2, row2);
                                v419.archetype = v417;
                                v419.row = v420;
                                local _ = i2;
                            end;

                            archetype_destroy(p401, v415);
                        end;
                    end;
                end;
            end;

            if v404 then
                local records = v404.records;

                for i in records do
                    local v421 = archetypes[i];
                    local entities = v421.entities;
                    local v422 = false;

                    for _, v in v421.types do
                        if v > 281474976710656 then
                            local v423 = u284;
                            local v424 = v423.sparse_array[(v - 281474976710656) % 16777216 % 16777216];

                            if not v424 or v424.dense == 0 then
                                v424 = nil;
                            end;

                            local v425;

                            if v424 then
                                v425 = v423.dense_array[v424.dense];
                            else
                                v425 = nil;
                            end;

                            if v425 == p402 then
                                if bit32.btest(component_index[v].flags, 1) then
                                    for i2 = #entities, 1, -1 do
                                        inner_world_delete(p401, entities[i2]);
                                        local _ = i2;
                                    end;

                                    v422 = true;
                                    break;
                                end;

                                local archetype_edges = p401.archetype_edges;
                                local v426 = archetype_edges[v421.id];
                                local v427 = v426[v];

                                if v427 == nil then
                                    local types = v421.types;
                                    local table_find_ret = table.find(types, v);
                                    local table_clone_ret = table.clone(types);
                                    table.remove(table_clone_ret, table_find_ret);

                                    if #table_clone_ret < 1 then
                                        v427 = p401.ROOT_ARCHETYPE;
                                    else
                                        local table_concat_ret = table.concat(table_clone_ret, "_");
                                        v427 = p401.archetype_index[table_concat_ret];

                                        if v427 then
                                            if v427.dead then
                                                archetype_register(p401, v427);
                                                v427.dead = false;
                                            end;
                                        else
                                            v427 = archetype_create(p401, table_clone_ret, table_concat_ret);
                                        end;
                                    end;

                                    v426[v] = v427;
                                    archetype_edges[v427.id][v] = v421;
                                end;

                                local on_remove = component_index[v].on_remove;

                                if on_remove then
                                    local v428 = v;

                                    for _, v2 in entities do
                                        on_remove(v2, v428);
                                    end;

                                    v421 = v427;
                                else
                                    v421 = v427;
                                end;
                            end;
                        end;
                    end;

                    if not v422 then
                        for i2 = #entities, 1, -1 do
                            local v429 = entities[i2];
                            local v430 = u283[v429 % 16777216];

                            if not v430 or v430.dense == 0 then
                                v430 = nil;
                            end;

                            if v430 and u282[v430.dense] ~= v429 then
                                v430 = nil;
                            end;

                            local row2 = v430.row;
                            local archetype2 = v430.archetype;
                            local entities2 = v421.entities;
                            local v431 = #entities2 + 1;
                            entities2[v431] = v429;
                            inner_archetype_move(v429, v421, v431, archetype2, row2);
                            v430.archetype = v421;
                            v430.row = v431;
                            local _ = i2;
                        end;
                    end;
                end;

                for i in records do
                    archetype_destroy(p401, archetypes[i]);
                end;
            end;

            if v406 then
                local records = v406.records;

                if bit32.btest(v406.flags, 1) then
                    for i in records do
                        local v432 = archetypes[i];
                        local entities = v432.entities;

                        for i2 = #entities, 1, -1 do
                            inner_world_delete(p401, entities[i2]);
                            local _ = i2;
                        end;

                        archetype_destroy(p401, v432);
                    end;
                else
                    local counts = v406.counts;
                    local records2 = v406.records;

                    for i in records do
                        local v433 = archetypes[i];
                        local entities = v433.entities;
                        local v434 = records2[i];
                        local types = v433.types;

                        for i2 = v434, v434 + counts[i] - 1 do
                            local v435 = types[i2];
                            local archetype_edges = p401.archetype_edges;
                            local v436 = archetype_edges[v433.id];
                            local v437 = v436[v435];

                            if v437 == nil then
                                local types2 = v433.types;
                                local table_find_ret = table.find(types2, v435);
                                local table_clone_ret = table.clone(types2);
                                table.remove(table_clone_ret, table_find_ret);

                                if #table_clone_ret < 1 then
                                    v437 = p401.ROOT_ARCHETYPE;
                                else
                                    local table_concat_ret = table.concat(table_clone_ret, "_");
                                    v437 = p401.archetype_index[table_concat_ret];

                                    if v437 then
                                        if v437.dead then
                                            archetype_register(p401, v437);
                                            v437.dead = false;
                                        end;
                                    else
                                        v437 = archetype_create(p401, table_clone_ret, table_concat_ret);
                                    end;
                                end;

                                v436[v435] = v437;
                                archetype_edges[v437.id][v435] = v433;
                            end;

                            local on_remove = component_index[v435].on_remove;
                            local v438;

                            if on_remove then
                                v438 = i2;

                                for _, v in entities do
                                    on_remove(v, v435);
                                end;

                                v433 = v437;
                            else
                                v433 = v437;
                                v438 = i2;
                            end;
                        end;

                        for i2 = #entities, 1, -1 do
                            local v439 = entities[i2];
                            local v440 = u283[v439 % 16777216];

                            if not v440 or v440.dense == 0 then
                                v440 = nil;
                            end;

                            if v440 and u282[v440.dense] ~= v439 then
                                v440 = nil;
                            end;

                            local row2 = v440.row;
                            local archetype2 = v440.archetype;
                            local entities2 = v433.entities;
                            local v441 = #entities2 + 1;
                            entities2[v441] = v439;
                            inner_archetype_move(v439, v433, v441, archetype2, row2);
                            v440.archetype = v433;
                            v440.row = v441;
                            local _ = i2;
                        end;
                    end;

                    for i in records do
                        archetype_destroy(p401, archetypes[i]);
                    end;
                end;
            end;

            local dense = v403.dense;
            local alive_count = u284.alive_count;
            u284.alive_count = alive_count - 1;
            local v442 = u282[alive_count];
            local v443 = u283[v442 % 16777216];

            if not v443 or v443.dense == 0 then
                v443 = nil;
            end;

            v443.dense = dense;
            v403.archetype = nil;
            v403.row = nil;
            v403.dense = alive_count;
            u282[dense] = v442;
            local v444;

            if p402 > 16777216 then
                v444 = p402 % 16777216;
                local v445 = p402 // 16777216 + 1;

                if v445 < 65536 then
                    v444 = v444 + v445 * 16777216;
                end;
            else
                v444 = p402 + 16777216;
            end;

            u282[alive_count] = v444;
        end;

        local function inner_world_cleanup(p446: table) -- Line: 2950
            -- upvalues: u287 (ref), archetype_destroy (ref), u286 (ref)
            for _, v in u287 do
                if #v.entities == 0 then
                    archetype_destroy(p446, v);
                end;
            end;

            local v447 = {};
            local v448 = {};

            for i, v in u287 do
                v447[i] = v;
                v448[v.type] = v;
            end;

            u287 = v447;
            u286 = v448;
            p446.archetypes = v447;
            p446.archetype_index = v448;
        end;

        function u289.entity(p449: table, p450: any) -- Line: 2567
            -- upvalues: u284 (copy), u283 (copy), u282 (copy), entity_index_new_id (ref)
            if not p450 then
                return entity_index_new_id(u284);
            end;

            local v451 = p450 % 16777216;
            local alive_count = u284.alive_count;
            local v452 = u283[v451];

            if v452 then
                local dense = v452.dense;

                if dense and v452.dense ~= 0 then
                    if u282[dense] ~= p450 and alive_count <= dense then
                        local v453 = u282[dense];
                        local v454 = u283[v453 % 16777216];

                        if not v454 or v454.dense == 0 then
                            v454 = nil;
                        end;

                        v454.dense = dense;
                        local v455 = alive_count + 1;
                        u284.alive_count = v455;
                        v452.dense = v455;
                        u282[dense] = v453;
                        u282[v455] = p450;
                    end;

                    return p450;
                end;

                v452.dense = v451;

                if u282[v451] == p450 then
                    local v456 = u282[v451];
                    local v457 = u283[v456 % 16777216];

                    if not v457 or v457.dense == 0 then
                        v457 = nil;
                    end;

                    v457.dense = v451;
                    local v458 = alive_count + 1;
                    u284.alive_count = v458;
                    v452.dense = v458;
                    u282[v451] = v456;
                    u282[v458] = p450;
                end;

                return p450;
            end;

            for i = 1, v451 do
                u283[i] = {
                    dense = i
                };
                u282[i] = i;
                local _ = i;
            end;

            u284.max_id = v451;
            local v459 = u282[alive_count];
            u283[alive_count].dense = v451;
            local v460 = alive_count + 1;
            u284.alive_count = v460;
            local v461 = u283[v451];
            v461.dense = v460;
            u283[v451] = v461;
            u282[v451] = v459;
            u282[v460] = p450;

            return p450;
        end;

        u289.query = world_query;
        u289.remove = inner_world_remove;
        u289.clear = inner_world_clear;
        u289.delete = inner_world_delete;
        u289.component = world_component;
        u289.add = inner_world_add;
        u289.set = inner_world_set;

        function u289.get(p462: table, p463: any, p464: any, p465: any, p466: any, p467: any, p468: any) -- Line: 2376
            -- upvalues: u283 (copy), u282 (copy)
            local v469 = u283[p463 % 16777216];

            if not v469 or v469.dense == 0 then
                v469 = nil;
            end;

            if v469 and u282[v469.dense] ~= p463 then
                v469 = nil;
            end;

            if not v469 then
                return nil;
            end;

            local archetype = v469.archetype;

            if not archetype then
                return nil;
            end;

            local columns_map = archetype.columns_map;
            local row = v469.row;
            local v470 = columns_map[p464];
            local v471;

            if v470 then
                v471 = v470[row];
            else
                v471 = nil;
            end;

            if not p465 then
                return v471;
            end;

            if not p466 then
                local v472 = columns_map[p465];

                if v472 then
                    return v471, v472[row];
                end;

                return v471, nil;
            end;

            if not p467 then
                local v473 = columns_map[p465];
                local v474;

                if v473 then
                    v474 = v473[row];
                else
                    v474 = nil;
                end;

                local v475 = columns_map[p466];

                if v475 then
                    return v471, v474, v475[row];
                end;

                return v471, v474, nil;
            end;

            if not p468 then
                local v476 = columns_map[p465];
                local v477;

                if v476 then
                    v477 = v476[row];
                else
                    v477 = nil;
                end;

                local v478 = columns_map[p466];
                local v479;

                if v478 then
                    v479 = v478[row];
                else
                    v479 = nil;
                end;

                local v480 = columns_map[p467];

                if v480 then
                    return v471, v477, v479, v480[row];
                end;

                return v471, v477, v479, nil;
            end;

            error("args exceeded");
        end;

        function u289.has(p481: table, p482: number, p483: number, p484: number?, p485: number?, p486: number?, p487: number?) -- Line: 2406
            -- upvalues: u283 (copy), u282 (copy)
            local v488 = u283[p482 % 16777216];

            if not v488 or v488.dense == 0 then
                v488 = nil;
            end;

            if v488 and u282[v488.dense] ~= p482 then
                v488 = nil;
            end;

            if not v488 then
                return false;
            end;

            local archetype = v488.archetype;

            if not archetype then
                return false;
            end;

            local columns_map = archetype.columns_map;
            local v489;

            if columns_map[p483] ~= nil and (p484 == nil or columns_map[p484] ~= nil) and ((p485 == nil or columns_map[p485] ~= nil) and (p486 == nil or columns_map[p486] ~= nil)) then
                v489 = p487 == nil and true or error("args exceeded");
            else
                v489 = false;
            end;

            return v489;
        end;

        u289.target = inner_world_target;

        function u289.parent(p490: table, p491: any) -- Line: 2468
            -- upvalues: inner_world_target (copy)
            return inner_world_target(p490, p491, 261, 0);
        end;

        function u289.contains(p492: table, p493: any) -- Line: 2946
            local entity_index = p492.entity_index;
            local v494 = entity_index.sparse_array[p493 % 16777216];

            if not v494 or v494.dense == 0 then
                v494 = nil;
            end;

            if v494 then
                local dense = v494.dense;

                if entity_index.alive_count < dense then
                    v494 = nil;
                elseif entity_index.dense_array[dense] ~= p493 then
                    v494 = nil;
                end;
            end;

            return v494 ~= nil;
        end;

        function u289.exists(p495: table, p496: any) -- Line: 2942
            -- upvalues: u283 (copy)
            local v497 = u283[p496 % 16777216];

            if not v497 or v497.dense == 0 then
                v497 = nil;
            end;

            return v497 ~= nil;
        end;

        u289.cleanup = inner_world_cleanup;
        u289.each = world_each;
        u289.children = world_children;
        u289.range = world_range;

        for i = 1, 256 do
            inner_world_add(u289, entity_index_new_id(u284), 262);
            local _ = i;
        end;

        for i = 257, 271 do
            entity_index_new_id(u284);
            local _ = i;
        end;

        inner_world_add(u289, 267, 262);
        inner_world_add(u289, 259, 262);
        inner_world_add(u289, 257, 262);
        inner_world_add(u289, 258, 262);
        inner_world_add(u289, 260, 262);
        inner_world_add(u289, 271, 262);
        inner_world_set(u289, 257, 267, "jecs.OnAdd");
        inner_world_set(u289, 258, 267, "jecs.OnRemove");
        inner_world_set(u289, 259, 267, "jecs.OnChange");
        inner_world_set(u289, 260, 267, "jecs.Wildcard");
        inner_world_set(u289, 261, 267, "jecs.ChildOf");
        inner_world_set(u289, 262, 267, "jecs.Component");
        inner_world_set(u289, 263, 267, "jecs.OnDelete");
        inner_world_set(u289, 264, 267, "jecs.OnDeleteTarget");
        inner_world_set(u289, 265, 267, "jecs.Delete");
        inner_world_set(u289, 266, 267, "jecs.Remove");
        inner_world_set(u289, 267, 267, "jecs.Name");
        inner_world_set(u289, 271, 271, "jecs.Rest");
        inner_world_add(u289, 261, 265 % 16777216 + 264 % 16777216 * 16777216 + 281474976710656);
        inner_world_add(u289, 261, 270);

        for i = 272, u6 do
            entity_index_new_id(u284);
            local _ = i;
        end;

        for i, v in u4 do
            local v498 = i;

            for i2, v2 in v do
                if v2 == u1 then
                    inner_world_add(u289, v498, i2);
                else
                    inner_world_set(u289, v498, i2, v2);
                end;
            end;
        end;

        return u289;
    end,

    component = ECS_COMPONENT,
    tag = ECS_TAG,
    meta = ECS_META,

    is_tag = function(p499: table, p500: any) -- Line: 3059, Name: ecs_is_tag
        local v501 = p499.component_index[p500];

        if v501 then
            return bit32.btest(v501.flags, 2);
        end;

        local entity_index = p499.entity_index;
        local v502 = entity_index.sparse_array[p500 % 16777216];

        if not v502 or v502.dense == 0 then
            v502 = nil;
        end;

        if v502 then
            local dense = v502.dense;

            if entity_index.alive_count < dense then
                v502 = nil;
            elseif entity_index.dense_array[dense] ~= p500 then
                v502 = nil;
            end;
        end;

        local v503;

        if v502 then
            local archetype = v502.archetype;

            if archetype then
                v503 = archetype.columns_map[262] ~= nil;
            else
                v503 = false;
            end;
        else
            v503 = false;
        end;

        return not v503;
    end,

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

    pair = function(p504: number, p505: number) -- Line: 304, Name: ECS_PAIR
        return p505 % 16777216 + p504 % 16777216 * 16777216 + 281474976710656;
    end,

    ECS_ID = function(p506: number) -- Line: 288, Name: ECS_ENTITY_T_LO
        return p506 % 16777216;
    end,

    ECS_GENERATION_INC = function(p507: number) -- Line: 273, Name: ECS_GENERATION_INC
        if p507 <= 16777216 then
            return p507 + 16777216;
        end;

        local v508 = p507 % 16777216;
        local v509 = p507 // 16777216 + 1;

        if v509 >= 65536 then
            return v508;
        end;

        return v508 + v509 * 16777216;
    end,

    ECS_GENERATION = function(p510: number) -- Line: 296, Name: ECS_GENERATION
        return p510 // 16777216;
    end,

    ECS_ID_IS_WILDCARD = function(p511: number) -- Line: 667, Name: ECS_ID_IS_WILDCARD
        return p511 // 16777216 == 260 and true or p511 % 16777216 == 260;
    end,

    ECS_ID_DELETE = 1,
    ECS_META_RESET = ECS_META_RESET,

    IS_PAIR = function(p512: number) -- Line: 269, Name: ECS_IS_PAIR
        return p512 > 281474976710656;
    end,

    ECS_PAIR_FIRST = function(p513: number) -- Line: 311, Name: ECS_PAIR_FIRST
        return (p513 - 281474976710656) // 16777216;
    end,

    ECS_PAIR_SECOND = function(p514: number) -- Line: 315, Name: ECS_PAIR_SECOND
        return (p514 - 281474976710656) % 16777216;
    end,

    pair_first = function(p515: table, p516: number) -- Line: 423, Name: ecs_pair_first
        local v517 = (p516 - 281474976710656) // 16777216;

        if v517 == 0 then
            return 0;
        end;

        local entity_index = p515.entity_index;
        local v518 = entity_index.sparse_array[v517 % 16777216];

        if not v518 or v518.dense == 0 then
            v518 = nil;
        end;

        if v518 then
            local dense = v518.dense;

            if entity_index.alive_count < dense then
                v518 = nil;
            elseif entity_index.dense_array[dense] ~= v517 then
                v518 = nil;
            end;
        end;

        if v518 ~= nil then
            return v517;
        end;

        if v517 > 16777216 then
            return 0;
        end;

        local v519 = entity_index.sparse_array[v517 % 16777216];

        if not v519 or v519.dense == 0 then
            v519 = nil;
        end;

        local v520;

        if v519 then
            v520 = entity_index.dense_array[v519.dense];
        else
            v520 = nil;
        end;

        if v520 then
            local v521 = entity_index.sparse_array[v520 % 16777216];

            if not v521 or v521.dense == 0 then
                v521 = nil;
            end;

            if v521 then
                local dense = v521.dense;

                if entity_index.alive_count < dense then
                    v521 = nil;
                elseif entity_index.dense_array[dense] ~= v520 then
                    v521 = nil;
                end;
            end;

            if v521 ~= nil then
                return v520;
            end;
        end;

        return 0;
    end,

    pair_second = function(p522: table, p523: number) -- Line: 428, Name: ecs_pair_second
        local v524 = (p523 - 281474976710656) % 16777216;

        if v524 == 0 then
            return 0;
        end;

        local entity_index = p522.entity_index;
        local v525 = entity_index.sparse_array[v524 % 16777216];

        if not v525 or v525.dense == 0 then
            v525 = nil;
        end;

        if v525 then
            local dense = v525.dense;

            if entity_index.alive_count < dense then
                v525 = nil;
            elseif entity_index.dense_array[dense] ~= v524 then
                v525 = nil;
            end;
        end;

        if v525 ~= nil then
            return v524;
        end;

        if v524 > 16777216 then
            return 0;
        end;

        local v526 = entity_index.sparse_array[v524 % 16777216];

        if not v526 or v526.dense == 0 then
            v526 = nil;
        end;

        local v527;

        if v526 then
            v527 = entity_index.dense_array[v526.dense];
        else
            v527 = nil;
        end;

        if v527 then
            local v528 = entity_index.sparse_array[v527 % 16777216];

            if not v528 or v528.dense == 0 then
                v528 = nil;
            end;

            if v528 then
                local dense = v528.dense;

                if entity_index.alive_count < dense then
                    v528 = nil;
                elseif entity_index.dense_array[dense] ~= v527 then
                    v528 = nil;
                end;
            end;

            if v528 ~= nil then
                return v527;
            end;
        end;

        return 0;
    end,

    entity_index_get_alive = function(p529: table, p530: any) -- Line: 364, Name: entity_index_get_alive
        local v531 = p529.sparse_array[p530 % 16777216];

        if not v531 or v531.dense == 0 then
            v531 = nil;
        end;

        if v531 then
            return p529.dense_array[v531.dense];
        end;

        return nil;
    end,

    archetype_append_to_records = function(p532: table, p533: number, p534: table, p535: number, p536: number, p537: table) -- Line: 759, Name: archetype_append_to_records
        local records = p532.records;
        local counts = p532.counts;

        if records[p533] then
            counts[p533] = counts[p533] + 1;

            return;
        end;

        records[p533] = p536;
        counts[p533] = 1;
        p534[p535] = p537;
    end,

    id_record_ensure = id_record_ensure,

    component_record = function(p538: table, p539: any) -- Line: 673, Name: id_record_get
        return p538.component_index[p539] or nil;
    end,

    archetype_create = archetype_create,

    archetype_ensure = function(p540: table, p541: table) -- Line: 873, Name: archetype_ensure
        -- upvalues: archetype_register (copy), archetype_create (copy)
        if #p541 < 1 then
            return p540.ROOT_ARCHETYPE;
        end;

        local table_concat_ret = table.concat(p541, "_");
        local v542 = p540.archetype_index[table_concat_ret];

        if not v542 then
            return archetype_create(p540, p541, table_concat_ret);
        end;

        if v542.dead then
            archetype_register(p540, v542);
            v542.dead = false;
        end;

        return v542;
    end,

    find_insert = function(p543: table, p544: number) -- Line: 891, Name: find_insert
        for i, v in p543 do
            if v == p544 then
                return -1;
            end;

            if p544 < v then
                return i;
            end;
        end;

        return #p543 + 1;
    end,

    find_archetype_with = function(p545: table, p546: any, p547: table) -- Line: 950, Name: find_archetype_with
        -- upvalues: archetype_register (copy), archetype_create (copy)
        local types = p547.types;
        local table_clone_ret = table.clone(types);
        local v548;

        for i, v in types do
            if v == p546 then
                v548 = -1;
                break;
            end;

            if p546 < v then
                v548 = i;
                break;
            end;
        end;

        v548 = #types + 1;
        table.insert(table_clone_ret, v548, p546);

        if #table_clone_ret < 1 then
            return p545.ROOT_ARCHETYPE;
        end;

        local table_concat_ret = table.concat(table_clone_ret, "_");
        local v549 = p545.archetype_index[table_concat_ret];

        if not v549 then
            return archetype_create(p545, table_clone_ret, table_concat_ret);
        end;

        if v549.dead then
            archetype_register(p545, v549);
            v549.dead = false;
        end;

        return v549;
    end,

    find_archetype_without = function(p550: table, p551: table, p552: any) -- Line: 903, Name: find_archetype_without
        -- upvalues: archetype_register (copy), archetype_create (copy)
        local types = p551.types;
        local table_find_ret = table.find(types, p552);
        local table_clone_ret = table.clone(types);
        table.remove(table_clone_ret, table_find_ret);

        if #table_clone_ret < 1 then
            return p550.ROOT_ARCHETYPE;
        end;

        local table_concat_ret = table.concat(table_clone_ret, "_");
        local v553 = p550.archetype_index[table_concat_ret];

        if not v553 then
            return archetype_create(p550, table_clone_ret, table_concat_ret);
        end;

        if v553.dead then
            archetype_register(p550, v553);
            v553.dead = false;
        end;

        return v553;
    end,

    create_edge_for_remove = function(p554: table, p555: table, p556: table, p557: any) -- Line: 918, Name: create_edge_for_remove
        -- upvalues: archetype_register (copy), archetype_create (copy)
        local types = p555.types;
        local table_find_ret = table.find(types, p557);
        local table_clone_ret = table.clone(types);
        table.remove(table_clone_ret, table_find_ret);
        local v558;

        if #table_clone_ret < 1 then
            v558 = p554.ROOT_ARCHETYPE;
        else
            local table_concat_ret = table.concat(table_clone_ret, "_");
            v558 = p554.archetype_index[table_concat_ret];

            if v558 then
                if v558.dead then
                    archetype_register(p554, v558);
                    v558.dead = false;
                end;
            else
                v558 = archetype_create(p554, table_clone_ret, table_concat_ret);
            end;
        end;

        local archetype_edges = p554.archetype_edges;
        archetype_edges[p555.id][p557] = v558;
        archetype_edges[v558.id][p557] = p555;

        return v558;
    end,

    archetype_traverse_add = function(p559: table, p560: any, p561: table) -- Line: 961, Name: archetype_traverse_add
        -- upvalues: archetype_register (copy), archetype_create (copy)
        local v562 = p561 or p559.ROOT_ARCHETYPE;

        if v562.columns_map[p560] then
            return v562;
        end;

        local archetype_edges = p559.archetype_edges;
        local v563 = archetype_edges[v562.id];
        local v564 = v563[p560];

        if not v564 then
            local types = v562.types;
            local table_clone_ret = table.clone(types);
            local v565;

            for i, v in types do
                if v == p560 then
                    v565 = -1;
                    break;
                end;

                if p560 < v then
                    v565 = i;
                    break;
                end;
            end;

            v565 = #types + 1;
            table.insert(table_clone_ret, v565, p560);

            if #table_clone_ret < 1 then
                v564 = p559.ROOT_ARCHETYPE;
            else
                local table_concat_ret = table.concat(table_clone_ret, "_");
                v564 = p559.archetype_index[table_concat_ret];

                if v564 then
                    if v564.dead then
                        archetype_register(p559, v564);
                        v564.dead = false;
                    end;
                else
                    v564 = archetype_create(p559, table_clone_ret, table_concat_ret);
                end;
            end;

            v563[p560] = v564;
            archetype_edges[v564.id][p560] = v562;
        end;

        return v564;
    end,

    archetype_traverse_remove = function(p566: table, p567: any, p568: table) -- Line: 932, Name: archetype_traverse_remove
        -- upvalues: archetype_register (copy), archetype_create (copy)
        local archetype_edges = p566.archetype_edges;
        local v569 = archetype_edges[p568.id];
        local v570 = v569[p567];

        if v570 == nil then
            local types = p568.types;
            local table_find_ret = table.find(types, p567);
            local table_clone_ret = table.clone(types);
            table.remove(table_clone_ret, table_find_ret);

            if #table_clone_ret < 1 then
                v570 = p566.ROOT_ARCHETYPE;
            else
                local table_concat_ret = table.concat(table_clone_ret, "_");
                v570 = p566.archetype_index[table_concat_ret];

                if v570 then
                    if v570.dead then
                        archetype_register(p566, v570);
                        v570.dead = false;
                    end;
                else
                    v570 = archetype_create(p566, table_clone_ret, table_concat_ret);
                end;
            end;

            v569[p567] = v570;
            archetype_edges[v570.id][p567] = p568;
        end;

        return v570;
    end,

    bulk_insert = function(p571: table, p572: any, p573: table, p574: table) -- Line: 2012, Name: ecs_bulk_insert
        -- upvalues: archetype_register (copy), archetype_create (copy), archetype_move (copy)
        local entity_index = p571.entity_index;
        local v575 = entity_index.sparse_array[p572 % 16777216];

        if not v575 or v575.dense == 0 then
            v575 = nil;
        end;

        if v575 then
            local dense = v575.dense;

            if entity_index.alive_count < dense then
                v575 = nil;
            elseif entity_index.dense_array[dense] ~= p572 then
                v575 = nil;
            end;
        end;

        if not v575 then
            return;
        end;

        local archetype = v575.archetype;
        local component_index = p571.component_index;

        if not archetype then
            local v576;

            if #p573 < 1 then
                v576 = p571.ROOT_ARCHETYPE;
            else
                local table_concat_ret = table.concat(p573, "_");
                v576 = p571.archetype_index[table_concat_ret];

                if v576 then
                    if v576.dead then
                        archetype_register(p571, v576);
                        v576.dead = false;
                    end;
                else
                    v576 = archetype_create(p571, p573, table_concat_ret);
                end;
            end;

            local entities = v576.entities;
            local v577 = #entities + 1;
            entities[v577] = p572;
            v575.archetype = v576;
            v575.row = v577;
            local row = v575.row;
            local columns_map = v576.columns_map;

            for i, v in p573 do
                local v578 = p574[i];
                local on_add = component_index[v].on_add;

                if v578 then
                    columns_map[v][row] = v578;

                    if on_add then
                        on_add(p572, v, v578);
                    end;
                elseif on_add then
                    on_add(p572, v);
                end;
            end;

            return;
        end;

        local table_clone_ret = table.clone(archetype.types);
        local v579 = {};

        for i, v in p573 do
            local v580 = i;
            local v581 = v;
            local v582;

            for i2, v2 in table_clone_ret do
                if v2 == v581 then
                    v582 = -1;
                    break;
                end;

                if v581 < v2 then
                    v582 = i2;
                    break;
                end;
            end;

            v582 = #table_clone_ret + 1;

            if v582 == -1 then
                v579[v580] = true;
            else
                v579[v580] = false;
                table.insert(table_clone_ret, v582, v581);
            end;
        end;

        local v583;

        if #table_clone_ret < 1 then
            v583 = p571.ROOT_ARCHETYPE;
        else
            local table_concat_ret = table.concat(table_clone_ret, "_");
            v583 = p571.archetype_index[table_concat_ret];

            if v583 then
                if v583.dead then
                    archetype_register(p571, v583);
                    v583.dead = false;
                end;
            else
                v583 = archetype_create(p571, table_clone_ret, table_concat_ret);
            end;
        end;

        local columns_map = v583.columns_map;

        if archetype ~= v583 then
            local row = v575.row;
            local archetype2 = v575.archetype;
            local entities = v583.entities;
            local v584 = #entities + 1;
            entities[v584] = p572;
            archetype_move(entity_index, p572, v583, v584, archetype2, row);
            v575.archetype = v583;
            v575.row = v584;
        end;

        local row = v575.row;

        for i, v in v579 do
            local v585 = p573[i];
            local v586 = component_index[v585];
            local v587 = p574[i];
            local on_add = v586.on_add;

            if v587 == nil then
                if on_add then
                    on_add(p572, v585);
                end;
            else
                columns_map[v585][row] = v587;
                local on_change = v586.on_change;

                if v then
                    on_add = on_change;
                end;

                if on_add then
                    on_add(p572, v585, v587);
                end;
            end;
        end;
    end,

    bulk_remove = function(p588: table, p589: any, p590: table) -- Line: 2090, Name: ecs_bulk_remove
        -- upvalues: archetype_register (copy), archetype_create (copy), archetype_move (copy)
        local entity_index = p588.entity_index;
        local v591 = entity_index.sparse_array[p589 % 16777216];

        if not v591 or v591.dense == 0 then
            v591 = nil;
        end;

        if v591 then
            local dense = v591.dense;

            if entity_index.alive_count < dense then
                v591 = nil;
            elseif entity_index.dense_array[dense] ~= p589 then
                v591 = nil;
            end;
        end;

        if not v591 then
            return;
        end;

        local archetype = v591.archetype;
        local component_index = p588.component_index;

        if not archetype then
            return;
        end;

        local columns_map = archetype.columns_map;
        local v592 = {};

        for _, v in p590 do
            if columns_map[v] then
                v592[v] = true;
                local on_remove = component_index[v].on_remove;

                if on_remove then
                    on_remove(p589, v);
                end;
            end;
        end;

        local archetype2 = v591.archetype;

        if archetype == archetype2 then
            archetype2 = archetype;
        end;

        local table_clone_ret = table.clone(archetype2.types);

        for i in v592 do
            local table_find_ret = table.find(table_clone_ret, i);
            table.remove(table_clone_ret, table_find_ret);
        end;

        local v593;

        if #table_clone_ret < 1 then
            v593 = p588.ROOT_ARCHETYPE;
        else
            local table_concat_ret = table.concat(table_clone_ret, "_");
            v593 = p588.archetype_index[table_concat_ret];

            if v593 then
                if v593.dead then
                    archetype_register(p588, v593);
                    v593.dead = false;
                end;
            else
                v593 = archetype_create(p588, table_clone_ret, table_concat_ret);
            end;
        end;

        if archetype2 ~= v593 then
            local row = v591.row;
            local archetype3 = v591.archetype;
            local entities = v593.entities;
            local v594 = #entities + 1;
            entities[v594] = p589;
            archetype_move(entity_index, p589, v593, v594, archetype3, row);
            v591.archetype = v593;
            v591.row = v594;
        end;
    end,

    entity_move = function(p595: table, p596: any, p597: table, p598: table) -- Line: 554, Name: entity_move
        -- upvalues: archetype_move (copy)
        local row = p597.row;
        local archetype = p597.archetype;
        local entities = p598.entities;
        local v599 = #entities + 1;
        entities[v599] = p596;
        archetype_move(p595, p596, p598, v599, archetype, row);
        p597.archetype = p598;
        p597.row = v599;
    end,

    entity_index_try_get = function(p600: table, p601: any) -- Line: 332, Name: entity_index_try_get
        local v602 = p600.sparse_array[p601 % 16777216];

        if not v602 or v602.dense == 0 then
            v602 = nil;
        end;

        if v602 then
            local dense = v602.dense;

            if p600.alive_count < dense then
                return nil;
            end;

            if p600.dense_array[dense] ~= p601 then
                return nil;
            end;
        end;

        return v602;
    end,

    entity_index_try_get_fast = function(p603: table, p604: any) -- Line: 346, Name: entity_index_try_get_fast
        local v605 = p603.sparse_array[p604 % 16777216];

        if not v605 or v605.dense == 0 then
            v605 = nil;
        end;

        if v605 and p603.dense_array[v605.dense] ~= p604 then
            return nil;
        end;

        return v605;
    end,

    entity_index_try_get_any = function(p606: table, p607: any) -- Line: 319, Name: entity_index_try_get_any
        local v608 = p606.sparse_array[p607 % 16777216];

        if v608 and v608.dense ~= 0 then
            return v608;
        end;

        return nil;
    end,

    entity_index_is_alive = function(p609: table, p610: any) -- Line: 360, Name: entity_index_is_alive
        local v611 = p609.sparse_array[p610 % 16777216];

        if not v611 or v611.dense == 0 then
            v611 = nil;
        end;

        if v611 then
            local dense = v611.dense;

            if p609.alive_count < dense then
                v611 = nil;
            elseif p609.dense_array[dense] ~= p610 then
                v611 = nil;
            end;
        end;

        return v611 ~= nil;
    end,

    entity_index_new_id = entity_index_new_id,
    query_iter = query_iter,
    query_iter_init = query_iter_init,
    query_with = query_with,
    query_without = query_without,
    query_archetypes = query_archetypes,

    query_match = function(p612: table, p613: table) -- Line: 433, Name: query_match
        local columns_map = p613.columns_map;

        for _, v in p612.filter_with do
            if not columns_map[v] then
                return false;
            end;
        end;

        local filter_without = p612.filter_without;

        if filter_without then
            for _, v in filter_without do
                if columns_map[v] then
                    return false;
                end;
            end;
        end;

        return true;
    end,

    find_observers = function(p614: table, p615: any, p616: any) -- Line: 455, Name: find_observers
        local v617 = p614.observable[p615];

        if v617 then
            return v617[p616];
        end;

        return nil;
    end
};