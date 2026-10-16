-- Decompiled with Potassium's decompiler.

local common = require(script.Parent:WaitForChild("common"));
require(script.Parent:WaitForChild("types"));
require(script.Parent:WaitForChild("customid"));
local utils = require(script.Parent:WaitForChild("utils"));
local cursor = utils.cursor;
local u1 = {};
u1.__index = u1;
local u2 = {
    full = 1,
    entity = 2,
    updates = 3,
    unreliable = 4
};
local ecs_name = common.ecs_name;
local wildcard = common.wildcard;
local pair = common.pair;
local iterate_all_relations = common.iterate_all_relations;
local world_entity = common.world_entity;
local world_add = common.world_add;
local world_set = common.world_set;
local world_remove = common.world_remove;
local world_get = common.world_get;
local world_has = common.world_has;
local world_delete = common.world_delete;
local hook_added = common.hook_added;
local hook_changed = common.hook_changed;
local hook_removed = common.hook_removed;

local function QUERY_CURRENT_COMPONENTS(p3) -- Line: 168
    for i, v in p3.world:query(p3.components.serdes):iter() do
        p3.component_serdes[i] = v;
    end;
end;

local function get_or_create_entity(p4: any, p5: number) -- Line: 174
    -- upvalues: world_entity (copy), world_add (copy)
    local world = p4.world;
    local v6 = p4.server_ids[p5];

    if v6 then
        return v6;
    end;

    local v7 = world_entity(world);
    world_add(world, v7, p4.components.__alive_tracking__);
    p4.server_ids[p5] = v7;
    p4.client_ids[v7] = p5;

    for _, v in p4.addition_hooks do
        v(v7);
    end;

    return v7;
end;

local function get_or_create_command_buffer(p8, p9) -- Line: 195
    local command_buffers = p8.command_buffers;

    if not command_buffers then
        error("attempted to use a command buffer without being active. (this should never happen)");
    end;

    local v10 = command_buffers[p9];

    if not v10 then
        v10 = {
            tags = {},
            components = {},
            unreliable_components = {},
            remove = {},
            pairs_add = {},
            pairs_set = {},
            pairs_unprocessed = {},
            pairs_remove = {},
            relations_clear = {}
        };
        command_buffers[p9] = v10;
    end;

    return v10;
end;

function u1.entity_set(p11: any, p12: any, p13: any, p14: any, p15: table?) -- Line: 220
    -- upvalues: get_or_create_command_buffer (copy), world_set (copy)
    if p11.command_buffers_active then
        get_or_create_command_buffer(p11, p12).components[p13] = {
            value = p14
        };

        return;
    end;

    if not p15 then
        world_set(p11.world, p12, p13, p14);

        return;
    end;

    if not p15.overrides then
        world_set(p11.world, p12, p13, p14);
    end;

    for _, v in p15.callbacks do
        v(p12, p13, p14);
    end;
end;

function u1.entity_add(p16: any, p17: any, p18: any, p19: table?) -- Line: 244
    -- upvalues: get_or_create_command_buffer (copy), world_add (copy)
    if p16.command_buffers_active then
        get_or_create_command_buffer(p16, p17).tags[p18] = true;

        return;
    end;

    if not p19 then
        world_add(p16.world, p17, p18);

        return;
    end;

    if not p19.overrides then
        world_add(p16.world, p17, p18);
    end;

    for _, v in p19.callbacks do
        v(p17, p18);
    end;
end;

function u1.entity_set_unreliable(p20: any, p21: any, p22: any, p23: any, p24: table?) -- Line: 262
    -- upvalues: get_or_create_command_buffer (copy), world_has (copy), u1 (copy)
    if p20.command_buffers_active then
        get_or_create_command_buffer(p20, p21).unreliable_components[p22] = {
            value = p23
        };

        return;
    end;

    if world_has(p20.world, p21, p22) then
        u1.entity_set(p20, p21, p22, p23, p24);
    end;
end;

function u1.entity_set_pair(p25: any, p26: any, p27: any, p28: any, p29: any, p30: table?) -- Line: 279
    -- upvalues: get_or_create_command_buffer (copy), u1 (copy), pair (copy)
    if not p25.command_buffers_active then
        u1.entity_set(p25, p26, pair(p27, p28), p29, p30);

        return;
    end;

    local v31 = get_or_create_command_buffer(p25, p26);
    local v32 = v31.pairs_set[p27];

    if v32 then
        v32[p28] = {
            value = p29
        };

        return;
    end;

    v31.pairs_set[p27] = {
        [p28] = {
            value = p29
        }
    };
end;

function u1.entity_add_pair(p33: any, p34: any, p35: any, p36: any, p37: table?) -- Line: 301
    -- upvalues: get_or_create_command_buffer (copy), u1 (copy), pair (copy)
    if not p33.command_buffers_active then
        u1.entity_add(p33, p34, pair(p35, p36), p37);

        return;
    end;

    local v38 = get_or_create_command_buffer(p33, p34);
    local v39 = v38.pairs_add[p35];

    if v39 then
        v39[p36] = true;

        return;
    end;

    v38.pairs_add[p35] = {
        [p36] = true
    };
end;

function u1.entity_set_postponed_pair(p40: any, p41: any, p42: any, p43: any, p44: any, p45: table?) -- Line: 322
    -- upvalues: get_or_create_command_buffer (copy), u1 (copy), world_set (copy)
    if not p40.command_buffers_active then
        local v46, v47 = u1.read_pair_value(p40, p42, p43, p44, p45);
        world_set(p40.world, p41, v46, v47);

        return v47;
    end;

    local pairs_unprocessed = get_or_create_command_buffer(p40, p41).pairs_unprocessed;
    local v48 = pairs_unprocessed[p42];

    if v48 then
        v48[p43] = {
            cursor = p44,
            variants = p45
        };
    else
        pairs_unprocessed[p42] = {
            [p43] = {
                cursor = p44,
                variants = p45
            }
        };
    end;

    return nil;
end;

function u1.entity_remove(p49: any, p50: any, p51: any, p52: table?) -- Line: 356
    -- upvalues: get_or_create_command_buffer (copy), world_remove (copy)
    if p49.command_buffers_active then
        get_or_create_command_buffer(p49, p50).remove[p51] = true;

        return;
    end;

    if p52 then
        for _, v in p52.callbacks do
            v(p50, p51);
        end;

        if not p52.overrides then
            world_remove(p49.world, p50, p51);
        end;
    else
        world_remove(p49.world, p50, p51);
    end;
end;

function u1.entity_remove_pair(p53: any, p54: any, p55: any, p56: any, p57: table?) -- Line: 374
    -- upvalues: get_or_create_command_buffer (copy), u1 (copy), pair (copy)
    if not p53.command_buffers_active then
        u1.entity_remove(p53, p54, pair(p55, p56), p57);

        return;
    end;

    local v58 = get_or_create_command_buffer(p53, p54);
    local v59 = v58.pairs_remove[p55];

    if v59 then
        v59[p56] = true;

        return;
    end;

    v58.pairs_remove[p55] = {
        [p56] = true
    };
end;

function u1.entity_clear_relation(p60: any, u61: any, p62: any, u63: table?) -- Line: 395
    -- upvalues: get_or_create_command_buffer (copy), iterate_all_relations (copy), world_remove (copy)
    if p60.command_buffers_active then
        get_or_create_command_buffer(p60, u61).relations_clear[p62] = true;

        return;
    end;

    local world = p60.world;

    if u63 then
        iterate_all_relations(world, u61, p62, function(p64) -- Line: 407
            -- upvalues: u63 (copy), u61 (copy), world_remove (ref), world (copy)
            for _, v in u63.callbacks do
                v(u61, p64);
            end;

            if not u63.overrides then
                world_remove(world, u61, p64);
            end;
        end);

        return;
    end;

    iterate_all_relations(world, u61, p62, function(p65) -- Line: 416
        -- upvalues: world_remove (ref), world (copy), u61 (copy)
        world_remove(world, u61, p65);
    end);
end;

local function read_variant_value(p66: any, p67: any, p68: table?) -- Line: 423
    -- upvalues: cursor (copy)
    if not p67 then
        local v69 = cursor.read_vlq(p66);

        if v69 == 0 then
            return nil;
        end;

        return p68[v69];
    end;

    local v70 = p67.bytespan or cursor.read_vlq(p66);
    local v71 = cursor.read_buffer(p66, v70);
    local v72 = nil;

    if p67.includes_variants then
        local v73 = cursor.read_vlq(p66);

        if v73 > 0 then
            local v74 = cursor.read_vlq(p66);
            v72 = table.move(p68, v73, v73 + v74 - 1, 1, {});
        end;
    end;

    return p67.deserialize(v71, v72);
end;

function u1.read_pair_value(p75: any, p76: any, p77: any, p78: any, p79: table?) -- Line: 451
    -- upvalues: pair (copy), wildcard (copy), read_variant_value (copy)
    local v80 = pair(p76, p77);
    local v81 = pair(p76, wildcard);

    return v80, read_variant_value(p78, p75.component_serdes[v80] or p75.component_serdes[v81], p79);
end;

function u1.read_component_value(p82: any, p83: any, p84: any, p85: table?) -- Line: 465
    -- upvalues: cursor (copy)
    local v86 = p82.shared.serdes[p83];

    if not v86 then
        local v87 = cursor.read_vlq(p84);

        if v87 == 0 then
            return nil;
        end;

        return p85[v87];
    end;

    local v88 = v86.bytespan or cursor.read_vlq(p84);
    local v89 = cursor.read_buffer(p84, v88);
    local v90 = nil;

    if v86.includes_variants then
        local v91 = cursor.read_vlq(p84);

        if v91 > 0 then
            local v92 = cursor.read_vlq(p84);
            v90 = table.move(p85, v91, v91 + v92 - 1, 1, {});
        end;
    end;

    return v86.deserialize(v89, v90);
end;

function u1.read_component_id(p93, p94) -- Line: 500
    -- upvalues: cursor (copy)
    local components = p93.shared.components;
    local v95 = cursor.read_span(p94, #components.keys);
    local v96 = components.indexes[v95];

    if not v96 then
        print("NON SHARED COMPONENT", v95, p93.shared.components);
        error("received a non shared component");
    end;

    return v96;
end;

function u1.resolve_global(p97: any, p98: number) -- Line: 511
    if not p97.global_handler then
        error("global id parser not set, consider using client:handle_global()");
    end;

    return p97.global_handler(p98);
end;

function u1.read_entity_id(p99, p100) -- Line: 520
    -- upvalues: cursor (copy), u1 (copy)
    local v101 = cursor.readu8(p100);

    if v101 > 10 then
        return u1.resolve_global(p99, v101 - 10), nil, v101;
    end;

    if v101 == 1 or (v101 == 3 or v101 == 2) then
        local v102 = cursor.readu40(p100);

        return p99.server_ids[v102], v102, v101;
    end;

    if v101 == 4 then
        return u1.read_component_id(p99, p100), nil, v101;
    end;

    error(`malformed entity type {v101} ` .. cursor.readu32(p100));
end;

local function read_vlq_bitmask(p103: any, p104: number, p105: number) -- Line: 540
    -- upvalues: utils (copy), cursor (copy)
    return not utils.checkbit(p104, p105) and 0 or cursor.read_vlq(p103);
end;

function u1.process_entity_id(p106: any, p107: any, p108: table, p109: function) -- Line: 548
    -- upvalues: u1 (copy), cursor (copy), common (copy), get_or_create_entity (copy)
    local v110, v111, v112 = u1.read_entity_id(p106, p107);

    if v110 then
        if v112 == 3 then
            u1.read_component_id(p106, p107);
        elseif v112 == 2 then
            cursor.readu8(p107);
        end;

        return p109(v110);
    end;

    if v112 ~= 3 and v112 ~= 2 then
        p109((get_or_create_entity(p106, v111)));

        return;
    end;

    if v112 == 3 then
        p108[v111] = u1.read_component_id(p106, p107);
    elseif v112 == 2 then
        local v113 = cursor.readu8(p107);
        local v114 = p106.shared.custom_ids.indexes[v113];

        if not v114 then
            common.log_error("attempted to use a custom id that wasn\'t registered");
        end;

        p108[v111] = v114;
    end;

    if p106.command_buffers_active then
        p109(-v111);

        return;
    end;

    p106.command_buffers_active = true;
    p109(-v111);
    p106.command_buffers_active = false;
end;

function u1.process_entity_relations(u115: any, u116: any, p117: any, p118: table) -- Line: 596
    -- upvalues: u1 (copy), cursor (copy), pair (copy)
    local components = u115.components;
    local u119 = u1.read_component_id(u115, p117);
    local v120 = cursor.read_vlq(p117);
    local u121 = u115.network_hooks.changed[pair(components.relation, u119)];

    for i = 1, v120 do
        u1.process_entity_id(u115, p117, p118, function(p122) -- Line: 603
            -- upvalues: u1 (ref), u115 (copy), u116 (copy), u119 (copy), u121 (copy)
            u1.entity_add_pair(u115, u116, u119, p122, u121);
        end);
        local _ = i;
    end;
end;

function u1.process_entity_relation_values(u123: any, u124: any, p125: any, p126: table, p127: table?) -- Line: 609
    -- upvalues: u1 (copy), cursor (copy), pair (copy)
    local u128 = u1.read_component_id(u123, p125);
    local v129 = cursor.read_vlq(p125);
    local u130 = u123.network_hooks.changed[pair(u123.components.relation, u128)];

    for i = 1, v129 do
        local u131 = u1.read_component_value(u123, u128, p125, p127);
        u1.process_entity_id(u123, p125, p126, function(p132) -- Line: 623
            -- upvalues: u1 (ref), u123 (copy), u124 (copy), u128 (copy), u131 (copy), u130 (copy)
            u1.entity_set_pair(u123, u124, u128, p132, u131, u130);
        end);
        local _ = i;
    end;
end;

function u1.process_entity_pair_value(u133: any, u134: any, u135: any, p136: table, u137: table?) -- Line: 629
    -- upvalues: u1 (copy), cursor (copy)
    local u138 = u1.read_component_id(u133, u135);
    u1.process_entity_id(u133, u135, p136, function(p139) -- Line: 637
        -- upvalues: cursor (ref), u135 (copy), u1 (ref), u133 (copy), u138 (copy), u137 (copy), u134 (copy)
        if p139 > 0 then
            local v140 = cursor.read_vlq(u135);
            local v141 = u135.offset - v140;
            local _, v142 = u1.read_pair_value(u133, u138, p139, u135, u137);
            u1.entity_set_pair(u133, u134, u138, p139, v142);
            u135.offset = v141;

            return;
        end;

        local v143 = cursor.from_offset(u135.buffer, u135.offset);
        local v144 = cursor.read_vlq(u135);
        local v145 = u135;
        v145.offset = v145.offset - v144;
        u1.entity_set_postponed_pair(u133, u134, u138, p139, v143, u137);
    end);
end;

function u1.process_entity_pair(u146: any, u147: any, p148: any, p149: table) -- Line: 657
    -- upvalues: u1 (copy)
    local u150 = u1.read_component_id(u146, p148);
    u1.process_entity_id(u146, p148, p149, function(p151) -- Line: 659
        -- upvalues: u1 (ref), u146 (copy), u147 (copy), u150 (copy)
        u1.entity_add_pair(u146, u147, u150, p151);
    end);
end;

function u1.process_entity(p152: any, p153: any, p154: any, p155: table, p156: table?) -- Line: 665
    -- upvalues: cursor (copy), utils (copy), u1 (copy), pair (copy)
    local v157 = cursor.readu8(p154);
    local changed = p152.network_hooks.changed;
    local components = p152.components;

    for i = 1, not utils.checkbit(v157, 0) and 0 or cursor.read_vlq(p154) do
        local v158 = u1.read_component_id(p152, p154);
        local v159 = changed[pair(components.reliable, v158)];
        u1.entity_add(p152, p153, v158, v159);
        local _ = i;
    end;

    for i = 1, not utils.checkbit(v157, 1) and 0 or cursor.read_vlq(p154) do
        local v160 = u1.read_component_id(p152, p154);
        local v161 = u1.read_component_value(p152, v160, p154, p156);
        local v162 = changed[pair(components.reliable, v160)];
        u1.entity_set(p152, p153, v160, v161, v162);
        local _ = i;
    end;

    for i = 1, not utils.checkbit(v157, 2) and 0 or cursor.read_vlq(p154) do
        u1.process_entity_pair(p152, p153, p154, p155);
        local _ = i;
    end;

    for i = 1, not utils.checkbit(v157, 3) and 0 or cursor.read_vlq(p154) do
        u1.process_entity_pair_value(p152, p153, p154, p155, p156);
        local _ = i;
    end;

    for i = 1, not utils.checkbit(v157, 4) and 0 or cursor.read_vlq(p154) do
        u1.process_entity_relations(p152, p153, p154, p155);
        local _ = i;
    end;

    for i = 1, not utils.checkbit(v157, 5) and 0 or cursor.read_vlq(p154) do
        u1.process_entity_relation_values(p152, p153, p154, p155, p156);
        local _ = i;
    end;
end;

function u1.finish_replication(p163) -- Line: 712
    p163.is_replicating = false;

    for _, v in p163.after_replication_callbacks do
        v();
    end;

    table.clear(p163.after_replication_callbacks);
end;

function u1.resolve_dirty(p164) -- Line: 720
    -- upvalues: utils (copy)
    if p164.is_shared_dirty then
        p164.shared = utils.resolved_shared(p164.world, p164.components, p164.registered_custom_ids, p164.component_serdes);
        p164.is_shared_dirty = false;
    end;
end;

local function check_packet_type(p165: any, p166: number) -- Line: 733
    -- upvalues: cursor (copy), u2 (copy), common (copy)
    local v167 = cursor.readu8(p165);

    if v167 ~= p166 then
        local v168 = nil;
        local v169 = nil;

        for i, v in u2 do
            if v == v167 then
                v169 = i;
            elseif v == p166 then
                v168 = i;
            end;
        end;

        common.log_error((`packet type mismatch, expected: {v168 or "(unknown)"} got: {v169 or "(unknown)"} instead`));
    end;
end;

function u1.apply_command_buffer(p170: any, p171: any, p172: table, p173: function) -- Line: 752
    -- upvalues: pair (copy), u1 (copy)
    local components = p170.components;

    for i in p172.tags do
        local v174 = p170.network_hooks.changed[pair(components.reliable, i)];
        u1.entity_add(p170, p171, i, v174);
    end;

    for i, v in p172.components do
        local v175 = p170.network_hooks.changed[pair(components.reliable, i)];
        u1.entity_set(p170, p171, i, v.value, v175);
    end;

    for i, v in p172.unreliable_components do
        local v176 = p170.network_hooks.changed[pair(components.unreliable, i)];
        u1.entity_set(p170, p171, i, v.value, v176);
    end;

    for i in p172.remove do
        local v177 = p170.network_hooks.removed[pair(components.reliable, i)];
        u1.entity_remove(p170, p171, i, v177);
    end;

    for i, v in p172.pairs_add do
        local v178 = p170.network_hooks.changed[pair(components.relation, i)];
        local v179 = i;

        for i2 in v do
            local v180 = p173(i2);

            if v180 then
                u1.entity_add_pair(p170, p171, v179, v180, v178);
            end;
        end;
    end;

    for i, v in p172.pairs_set do
        local v181 = p170.network_hooks.changed[pair(components.relation, i)];
        local v182 = i;

        for i2, v2 in v do
            local v183 = p173(i2);

            if v183 then
                u1.entity_set_pair(p170, p171, v182, v183, v2.value, v181);
            end;
        end;
    end;

    for i, v in p172.pairs_unprocessed do
        local v184 = i;

        for i2, v2 in v do
            local v185 = p173(i2);

            if v185 then
                local processed_value = v2.processed_value;

                if processed_value then
                    u1.entity_set_pair(p170, p171, v184, v185, processed_value.value);
                else
                    v2.processed_value = {
                        value = u1.entity_set_postponed_pair(p170, p171, v184, v185, v2.cursor, v2.variants)
                    };
                end;
            end;
        end;
    end;

    for i, v in p172.pairs_remove do
        local v186 = p170.network_hooks.removed[pair(components.relation, i)];
        local v187 = i;

        for i2 in v do
            local v188 = p173(i2);

            if v188 then
                u1.entity_remove_pair(p170, p171, v187, v188, v186);
            end;
        end;
    end;

    for i in p172.relations_clear do
        local v189 = p170.network_hooks.removed[pair(components.relation, i)];
        u1.entity_clear_relation(p170, p171, i, v189);
    end;
end;

function u1.find_component_in_buffer(p190: table, p191: any) -- Line: 832
    return p190.components[p191] or p190.unreliable_components[p191];
end;

function u1.find_has_in_buffer(p192: table, p193: any) -- Line: 836
    return (p192.tags[p193] ~= nil or p192.components[p193] ~= nil) and true or p192.unreliable_components[p193] ~= nil;
end;

function u1.find_pair_in_buffer(p194: table, p195: any, p196: any, p197: function) -- Line: 842
    local v198 = p194.pairs_set[p195];

    if v198 then
        for i, v in v198 do
            if p197(i) == p196 then
                return true, v.value;
            end;
        end;
    end;

    local v199 = p194.pairs_add[p195];

    if v199 then
        for i in v199 do
            if p197(i) == p196 then
                return true, nil;
            end;
        end;
    end;

    local v200 = p194.pairs_unprocessed[p195];

    if v200 then
        for i, v in v200 do
            if p197(i) == p196 then
                local processed_value = v.processed_value;

                if processed_value then
                    processed_value = processed_value.value;
                end;

                return true, processed_value;
            end;
        end;
    end;

    return false, nil;
end;

function u1.find_target_in_buffer(p201: table, p202: any, p203: number?) -- Line: 882
    local v204 = 0;
    local v205 = p201.pairs_add[p202];

    if v205 then
        for i in v205 do
            if v204 == (p203 or 0) then
                return i;
            end;

            v204 = v204 + 1;
        end;
    end;

    local v206 = p201.pairs_set[p202];

    if v206 then
        for i in v206 do
            if v204 == (p203 or 0) then
                return i;
            end;

            v204 = v204 + 1;
        end;
    end;

    local v207 = p201.pairs_unprocessed[p202];

    if v207 then
        for i in v207 do
            if v204 == (p203 or 0) then
                return i;
            end;

            v204 = v204 + 1;
        end;
    end;

    return nil;
end;

function u1.finish_custom_ids(u208: any, u209: table, u210: table) -- Line: 922
    -- upvalues: world_get (copy), common (copy), u1 (copy), world_add (copy)
    local world = u208.world;
    local u211 = {};
    local u212 = {};

    local function find(p213) -- Line: 931
        -- upvalues: u208 (copy)
        if p213 > 0 then
            return p213, p213;
        end;

        local v214 = -p213;
        local v215 = u208.server_ids[v214];

        if v215 then
            return v215, v214;
        end;

        return nil, v214;
    end;

    local function process(p216, p217) -- Line: 944
        -- upvalues: u208 (copy), u212 (copy), u210 (copy), u209 (copy), world_get (ref), world (copy), common (ref), u1 (ref), u211 (copy), world_add (ref), process (copy)
        local v218, v219;

        if p216 > 0 then
            v218 = p216;
            v219 = v218;
            local v220 = v218;
            v218 = v219;
            v220 = v219;
        else
            v218 = -p216;
            v219 = u208.server_ids[v218] or nil;
        end;

        if v219 then
            return v219;
        end;

        if u212[v218] then
            return nil;
        end;

        local v221 = u210[p216];
        local v222 = p217 or u209[v218];
        local v223;

        if type(v222) == "number" then
            local v224 = world_get(world, v222, u208.components.custom_handler);

            if not v224 then
                return common.log_error((`received a custom id for a non custom component, consider adding custom_handler to component: {common.log_component(world, v222)}`));
            end;

            if v221 then
                local v225 = u1.find_component_in_buffer(v221, v222);

                if v225 then
                    v223 = v224(v225.value);
                else
                    common.log_warn((`No component found for custom id handler: {common.log_component(world, v222)}`));
                    v223 = v224(nil);
                end;
            else
                common.log_warn((`No component found for custom id handler: {common.log_component(world, v222)}`));
                v223 = v224(nil);
            end;
        else
            local handle_callback = v222.handle_callback;

            if not handle_callback then
                return common.log_error("no handler callback was set for custom id:", v222.identifier);
            end;

            v223 = handle_callback(u211.create_context(p216));
        end;

        if v223 then
            world_add(world, v223, u208.components.__alive_tracking__);
            u208.server_ids[v218] = v223;
            u208.client_ids[v223] = v218;

            if v221 then
                u1.apply_command_buffer(u208, v223, v221, process);
                u210[p216] = nil;
            end;
        end;

        u212[v218] = true;

        return v223;
    end;

    function u211.create_context(p226) -- Line: 1009
        -- upvalues: u210 (copy), u1 (ref), process (copy), find (copy)
        local u227 = u210[p226];

        local function component(p228) -- Line: 1012
            -- upvalues: u227 (copy), u1 (ref)
            if not u227 then
                return nil;
            end;

            local v229 = u1.find_component_in_buffer(u227, p228);

            if v229 then
                v229 = v229.value;
            end;

            return v229;
        end;

        local function target(p230: any, p231: number?) -- Line: 1019
            -- upvalues: u227 (copy), u1 (ref), process (ref)
            if not u227 then
                return nil;
            end;

            local v232 = u1.find_target_in_buffer(u227, p230, p231);

            if v232 then
                return process(v232);
            end;

            return nil;
        end;

        local function pair_value(p233, p234) -- Line: 1029
            -- upvalues: u227 (copy), u1 (ref), find (ref)
            if not u227 then
                return nil;
            end;

            local _, v235 = u1.find_pair_in_buffer(u227, p233, p234, find);

            return v235;
        end;

        local function has_pair(p236, p237) -- Line: 1036
            -- upvalues: u227 (copy), u1 (ref), find (ref)
            if u227 then
                return u1.find_pair_in_buffer(u227, p236, p237, find);
            end;

            return nil;
        end;

        local function has(p238) -- Line: 1043
            -- upvalues: u227 (copy), u1 (ref)
            if u227 then
                return u1.find_has_in_buffer(u227, p238);
            end;

            return nil;
        end;

        local function entity(p239: number) -- Line: 1049
            -- upvalues: process (ref)
            return process(-p239);
        end;

        return {
            entity_id = math.abs(p226),
            has = has,
            component = component,
            target = target,
            pair_value = pair_value,
            has_pair = has_pair,
            entity = entity
        };
    end;

    for i, v in u209 do
        process(-i, v);
    end;

    for i, v in u210 do
        if i >= 0 then
            u1.apply_command_buffer(u208, i, v, process);
        end;
    end;
end;

function u1.apply_full(u240: any, p241: buffer, p242: table?) -- Line: 1079
    -- upvalues: u1 (copy), cursor (copy), check_packet_type (copy), u2 (copy)
    u1.resolve_dirty(u240);
    u240.is_replicating = true;
    local u243 = cursor.from(p241);
    check_packet_type(u243, u2.full);
    local v244 = cursor.read_vlq(u243);
    local v245;

    if p242 then
        v245 = #p242 + 1;
    else
        v245 = p242;
    end;

    local v246 = {};
    u240.command_buffers = v246;
    local u247 = {};

    for i = 1, v244 do
        local v248 = cursor.read_vlq(u243);
        local u249;

        if p242 then
            u249 = p242[v245 - i];
        else
            u249 = p242;
        end;

        local _ = i;

        for i2 = 1, v248 do
            u1.process_entity_id(u240, u243, u247, function(p250) -- Line: 1099
                -- upvalues: u1 (ref), u240 (copy), u243 (copy), u247 (copy), u249 (copy)
                u1.process_entity(u240, p250, u243, u247, u249);
            end);
            local _ = i2;
        end;
    end;

    u1.finish_custom_ids(u240, u247, v246);
    u1.finish_replication(u240);
end;

function u1.apply_entity(u251: any, p252: buffer, p253: table) -- Line: 1109
    -- upvalues: u1 (copy), cursor (copy), check_packet_type (copy), u2 (copy)
    u1.resolve_dirty(u251);
    u251.is_replicating = true;
    local u254 = cursor.from(p252);
    check_packet_type(u254, u2.entity);
    local v255 = cursor.read_vlq(u254);
    local v256;

    if p253 then
        v256 = #p253 + 1;
    else
        v256 = p253;
    end;

    local v257 = {};
    u251.command_buffers = v257;
    local u258 = {};

    for i = 1, v255 do
        local u259;

        if p253 then
            u259 = p253[v256 - i];
        else
            u259 = p253;
        end;

        u1.process_entity_id(u251, u254, u258, function(p260) -- Line: 1127
            -- upvalues: u1 (ref), u251 (copy), u254 (copy), u258 (copy), u259 (copy)
            u1.process_entity(u251, p260, u254, u258, u259);
        end);
        local _ = i;
    end;

    u1.finish_custom_ids(u251, u258, v257);
    u1.finish_replication(u251);
end;

function u1.apply_updates(u261: any, p262: buffer, p263: table?) -- Line: 1136
    -- upvalues: u1 (copy), cursor (copy), check_packet_type (copy), u2 (copy), utils (copy), pair (copy), world_delete (copy)
    u1.resolve_dirty(u261);
    u261.is_replicating = true;
    local u264 = cursor.from(p262);
    check_packet_type(u264, u2.updates);
    local world = u261.world;
    local components = u261.components;
    local v265 = cursor.read_vlq(u264);
    local v266;

    if p263 then
        v266 = #p263 + 1;
    else
        v266 = p263;
    end;

    local changed = u261.network_hooks.changed;
    local removed = u261.network_hooks.removed;
    local deleted = u261.network_hooks.deleted;
    local v267 = {};
    u261.command_buffers = v267;
    local u268 = {};

    for i = 1, v265 do
        local u269;

        if p263 then
            u269 = p263[v266 - i];
        else
            u269 = p263;
        end;

        local v270 = cursor.readu8(u264);
        local _ = i;

        for i2 = 1, not utils.checkbit(v270, 0) and 0 or cursor.read_vlq(u264) do
            u1.process_entity_id(u261, u264, u268, function(p271) -- Line: 1162
                -- upvalues: u1 (ref), u261 (copy), u264 (copy), u268 (copy), u269 (copy)
                u1.process_entity(u261, p271, u264, u268, u269);
            end);
            local _ = i2;
        end;

        for i2 = 1, not utils.checkbit(v270, 1) and 0 or cursor.read_vlq(u264) do
            u1.process_entity_id(u261, u264, u268, function(p272) -- Line: 1169
                -- upvalues: cursor (ref), u264 (copy), utils (ref), u1 (ref), u261 (copy), changed (copy), pair (ref), components (copy), u269 (copy), u268 (copy)
                local v273 = cursor.readu8(u264);

                for i3 = 1, not utils.checkbit(v273, 0) and 0 or cursor.read_vlq(u264) do
                    local v274 = u1.read_component_id(u261, u264);
                    local v275 = changed[pair(components.reliable, v274)];
                    u1.entity_add(u261, p272, v274, v275);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v273, 1) and 0 or cursor.read_vlq(u264) do
                    local v276 = u1.read_component_id(u261, u264);
                    local v277 = u1.read_component_value(u261, v276, u264, u269);
                    local v278 = changed[pair(components.reliable, v276)];
                    u1.entity_set(u261, p272, v276, v277, v278);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v273, 2) and 0 or cursor.read_vlq(u264) do
                    u1.process_entity_pair(u261, p272, u264, u268);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v273, 3) and 0 or cursor.read_vlq(u264) do
                    u1.process_entity_pair_value(u261, p272, u264, u268, u269);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v273, 4) and 0 or cursor.read_vlq(u264) do
                    u1.process_entity_relations(u261, p272, u264, u268);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v273, 5) and 0 or cursor.read_vlq(u264) do
                    u1.process_entity_relation_values(u261, p272, u264, u268, u269);
                    local _ = i3;
                end;
            end);
            local _ = i2;
        end;

        for i2 = 1, not utils.checkbit(v270, 2) and 0 or cursor.read_vlq(u264) do
            u1.process_entity_id(u261, u264, u268, function(u279) -- Line: 1211
                -- upvalues: cursor (ref), u264 (copy), utils (ref), u1 (ref), u261 (copy), changed (copy), pair (ref), components (copy), u269 (copy), removed (copy), u268 (copy)
                local v280 = cursor.readu8(u264);

                for i3 = 1, not utils.checkbit(v280, 0) and 0 or cursor.read_vlq(u264) do
                    local v281 = u1.read_component_id(u261, u264);
                    local v282 = changed[pair(components.reliable, v281)];
                    u1.entity_add(u261, u279, v281, v282);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v280, 1) and 0 or cursor.read_vlq(u264) do
                    local v283 = u1.read_component_id(u261, u264);
                    local v284 = u1.read_component_value(u261, v283, u264, u269);
                    local v285 = changed[pair(components.reliable, v283)];
                    u1.entity_set(u261, u279, v283, v284, v285);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v280, 2) and 0 or cursor.read_vlq(u264) do
                    local v286 = u1.read_component_id(u261, u264);
                    local v287 = removed[pair(components.reliable, v286)];
                    u1.entity_remove(u261, u279, v286, v287);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v280, 3) and 0 or cursor.read_vlq(u264) do
                    u1.process_entity_pair(u261, u279, u264, u268);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v280, 4) and 0 or cursor.read_vlq(u264) do
                    u1.process_entity_pair_value(u261, u279, u264, u268, u269);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v280, 5) and 0 or cursor.read_vlq(u264) do
                    local u288 = u1.read_component_id(u261, u264);
                    u1.process_entity_id(u261, u264, u268, function(p289) -- Line: 1249
                        -- upvalues: u1 (ref), u261 (ref), u279 (copy), u288 (copy)
                        u1.entity_remove_pair(u261, u279, u288, p289);
                    end);
                    local _ = i3;
                end;

                for i3 = 1, not utils.checkbit(v280, 6) and 0 or cursor.read_vlq(u264) do
                    local u290 = u1.read_component_id(u261, u264);
                    local v291 = cursor.read_vlq(u264);
                    local u292 = changed[pair(components.relation, u290)];
                    local _ = i3;

                    for i4 = 1, v291 do
                        u1.process_entity_id(u261, u264, u268, function(p293) -- Line: 1262
                            -- upvalues: u1 (ref), u261 (ref), u279 (copy), u290 (copy), u292 (copy)
                            u1.entity_add_pair(u261, u279, u290, p293, u292);
                        end);
                        local _ = i4;
                    end;
                end;

                for i3 = 1, not utils.checkbit(v280, 7) and 0 or cursor.read_vlq(u264) do
                    local u294 = u1.read_component_id(u261, u264);
                    local v295 = cursor.read_vlq(u264);
                    local u296 = changed[pair(components.relation, u294)];
                    local _ = i3;

                    for i4 = 1, v295 do
                        local u297 = u1.read_component_value(u261, u294, u264, u269);
                        u1.process_entity_id(u261, u264, u268, function(p298) -- Line: 1276
                            -- upvalues: u1 (ref), u261 (ref), u279 (copy), u294 (copy), u297 (copy), u296 (copy)
                            u1.entity_set_pair(u261, u279, u294, p298, u297, u296);
                        end);
                        local _ = i4;
                    end;
                end;

                for i3 = 1, cursor.read_vlq(u264) do
                    local u299 = u1.read_component_id(u261, u264);
                    local v300 = cursor.read_vlq(u264);
                    local u301 = removed[pair(components.relation, u299)];
                    local _ = i3;

                    for i4 = 1, v300 do
                        u1.process_entity_id(u261, u264, u268, function(p302) -- Line: 1291
                            -- upvalues: u1 (ref), u261 (ref), u279 (copy), u299 (copy), u301 (copy)
                            u1.entity_remove_pair(u261, u279, u299, p302, u301);
                        end);
                        local _ = i4;
                    end;
                end;
            end);
            local _ = i2;
        end;

        for i2 = 1, not utils.checkbit(v270, 3) and 0 or cursor.read_vlq(u264) do
            u1.process_entity_id(u261, u264, u268, function(u303) -- Line: 1301
                -- upvalues: cursor (ref), u264 (copy), u1 (ref), u261 (copy), removed (copy), pair (ref), components (copy), u268 (copy)
                for i3 = 1, cursor.read_vlq(u264) do
                    local v304 = u1.read_component_id(u261, u264);
                    local v305 = removed[pair(components.reliable, v304)];
                    u1.entity_remove(u261, u303, v304, v305);
                    local _ = i3;
                end;

                for i3 = 1, cursor.read_vlq(u264) do
                    local u306 = u1.read_component_id(u261, u264);
                    u1.process_entity_id(u261, u264, u268, function(p307) -- Line: 1312
                        -- upvalues: u1 (ref), u261 (ref), u303 (copy), u306 (copy)
                        u1.entity_remove_pair(u261, u303, u306, p307);
                    end);
                    local _ = i3;
                end;

                for i3 = 1, cursor.read_vlq(u264) do
                    local v308 = u1.read_component_id(u261, u264);
                    local v309 = removed[pair(components.relation, v308)];
                    u1.entity_clear_relation(u261, u303, v308, v309);
                    local _ = i3;
                end;
            end);
            local _ = i2;
        end;

        for i2 = 1, not utils.checkbit(v270, 4) and 0 or cursor.read_vlq(u264) do
            local v310, v311 = u1.read_entity_id(u261, u264);
            local v312;

            if v310 then
                local v313 = deleted[v310];

                if v313 then
                    v312 = i2;

                    for _, v in v313.callbacks do
                        v(v310);
                    end;

                    if not v313.overrides then
                        world_delete(world, v310);
                    end;
                else
                    world_delete(world, v310);
                    v312 = i2;
                end;
            else
                v312 = i2;
            end;

            if v311 then
                u261.server_ids[v311] = nil;
            end;
        end;
    end;

    u1.finish_custom_ids(u261, u268, v267);
    u1.finish_replication(u261);
end;

function u1.apply_unreliable(p314: any, p315: buffer, p316: table?) -- Line: 1353
    -- upvalues: u1 (copy), cursor (copy), check_packet_type (copy), u2 (copy), pair (copy)
    u1.resolve_dirty(p314);
    p314.is_replicating = true;
    local v317 = cursor.from(p315);
    check_packet_type(v317, u2.unreliable);
    local components = p314.components;
    local v318 = cursor.read_vlq(v317);
    local v319;

    if p316 then
        v319 = #p316 + 1;
    else
        v319 = p316;
    end;

    local changed = p314.network_hooks.changed;

    for i = 1, v318 do
        local v320 = cursor.read_vlq(v317);
        local v321;

        if p316 then
            v321 = p316[v319 - i];
        else
            v321 = p316;
        end;

        local _ = i;

        for i2 = 1, v320 do
            local v322 = u1.read_entity_id(p314, v317);
            local v323 = cursor.read_vlq(v317);
            local v324;

            if v322 then
                v324 = i2;

                for i3 = 1, v323 do
                    local v325 = u1.read_component_id(p314, v317);
                    local v326 = u1.read_component_value(p314, v325, v317, v321);
                    local v327 = changed[pair(components.unreliable, v325)];
                    u1.entity_set_unreliable(p314, v322, v325, v326, v327);
                    local _ = i3;
                end;
            else
                v324 = i2;

                for i3 = 1, v323 do
                    local v328 = u1.read_component_id(p314, v317);
                    u1.read_component_value(p314, v328, v317, v321);
                    local _ = i3;
                end;
            end;
        end;
    end;

    u1.finish_replication(p314);
end;

function u1.set_serdes(p329, p330, p331) -- Line: 1395
    p329.component_serdes[p330] = p331;
    p329.is_shared_dirty = true;
end;

function u1.remove_serdes(p332, p333) -- Line: 1400
    p332.component_serdes[p333] = nil;
    p332.is_shared_dirty = true;
end;

function u1.init(u334, p335) -- Line: 1407
    -- upvalues: utils (copy), common (copy), hook_removed (copy), hook_added (copy), u1 (copy), hook_changed (copy)
    if u334.inited == true then
        return warn("attempted to init a client twice");
    end;

    if u334.inited == nil then
        return warn("attempted to re-init a destroyed client");
    end;

    u334.inited = true;
    local u336 = p335 or u334.world;
    u334.world = u336;

    if not u336 then
        error("Providing a world is required to start replecs");
    end;

    if not u334.components then
        u334.components = utils.create_components(utils.tag_factory(u336), utils.component_factory(u336));
        utils.add_component_names(u334.components, function(p337, p338) -- Line: 1425
            -- upvalues: common (ref), u336 (copy)
            common.add_name(u336, p337, p338);
        end);
    end;

    local components = u334.components;

    local function hook(p339: function) -- Line: 1432
        -- upvalues: u334 (copy)
        table.insert(u334.hooked, p339);
    end;

    local v342 = hook_removed(u336, components.__alive_tracking__, function(p340) -- Line: 1436
        -- upvalues: u334 (copy)
        local v341 = u334.client_ids[p340];

        if v341 then
            u334.server_ids[v341] = nil;
            u334.client_ids[p340] = nil;
        end;

        u334.network_hooks.deleted[p340] = nil;
    end);
    table.insert(u334.hooked, v342);
    local v346 = hook_added(u336, components.serdes, function(p343, p344, p345) -- Line: 1445
        -- upvalues: u1 (ref), u334 (copy)
        u1.set_serdes(u334, p343, p345);
    end);
    table.insert(u334.hooked, v346);
    local v350 = hook_changed(u336, components.serdes, function(p347, p348, p349) -- Line: 1448
        -- upvalues: u1 (ref), u334 (copy)
        u1.set_serdes(u334, p347, p349);
    end);
    table.insert(u334.hooked, v350);
    local v352 = hook_removed(u336, components.serdes, function(p351) -- Line: 1451
        -- upvalues: u1 (ref), u334 (copy)
        u1.remove_serdes(u334, p351);
    end);
    table.insert(u334.hooked, v352);

    for _, v in u334.requires_shared_lookup do
        local v353 = hook_added(u336, v, function() -- Line: 1456
            -- upvalues: u334 (copy)
            u334.is_shared_dirty = true;
        end);
        table.insert(u334.hooked, v353);
        local v354 = hook_removed(u336, v, function() -- Line: 1459
            -- upvalues: u334 (copy)
            u334.is_shared_dirty = true;
        end);
        table.insert(u334.hooked, v354);
    end;

    for i, v in u334.world:query(u334.components.serdes):iter() do
        u334.component_serdes[i] = v;
    end;

    u334.shared = utils.resolved_shared(u336, components, u334.registered_custom_ids, u334.component_serdes);
end;

function u1.after_replication(p355: any, p356: function) -- Line: 1469
    if p355.is_replicating then
        table.insert(p355.after_replication_callbacks, p356);

        return;
    end;

    p356();
end;

function u1.added(u357: any, u358: function) -- Line: 1477
    table.insert(u357.addition_hooks, u358);

    return function() -- Line: 1479
        -- upvalues: u357 (copy), u358 (copy)
        local table_find_ret = table.find(u357.addition_hooks, u358);

        if table_find_ret then
            table.remove(u357.addition_hooks, table_find_ret);
        end;
    end;
end;

local function add_hook_entry(p359: any, p360: string, ...) -- Line: 1487
    if p360 == "changed" or p360 == "removed" then
        local u361 = select(1, ...);
        local u362 = select(2, ...);
        local u363 = p360 == "changed" and p359.network_hooks.changed or p359.network_hooks.removed;
        local u364 = u363[u361];

        if not u364 then
            u364 = {
                overrides = false,
                callbacks = {}
            };
            u363[u361] = u364;
        end;

        table.insert(u364.callbacks, u362);

        return u364, function() -- Line: 1503, Name: disconnect
            -- upvalues: u364 (ref), u362 (copy), u363 (copy), u361 (copy)
            local callbacks = u364.callbacks;
            local table_find_ret = table.find(callbacks, u362);

            if table_find_ret then
                table.remove(callbacks, table_find_ret);

                if #callbacks == 0 then
                    u363[u361] = nil;
                end;
            end;
        end;
    end;

    if p360 == "deleted" then
        local u365 = select(1, ...);
        local u366 = select(2, ...);
        local deleted = p359.network_hooks.deleted;
        local u367 = deleted[u365];

        if not u367 then
            u367 = {
                overrides = false,
                callbacks = {}
            };
            deleted[u365] = u367;
        end;

        table.insert(u367.callbacks, u366);

        return u367, function() -- Line: 1529, Name: disconnect
            -- upvalues: u367 (ref), u366 (copy), deleted (copy), u365 (copy)
            local callbacks = u367.callbacks;
            local table_find_ret = table.find(callbacks, u366);

            if table_find_ret then
                table.remove(callbacks, table_find_ret);

                if #callbacks == 0 then
                    deleted[u365] = nil;
                end;
            end;
        end;
    end;

    error("invalid hook action: " .. p360);
end;

function u1.hook(p368: any, p369: string, ...) -- Line: 1545
    -- upvalues: add_hook_entry (copy)
    local v370, v371 = add_hook_entry(p368, p369, ...);
    v370.overrides = false;

    return v371;
end;

function u1.override(p372: any, p373: string, ...) -- Line: 1550
    -- upvalues: add_hook_entry (copy)
    local v374, v375 = add_hook_entry(p372, p373, ...);
    v374.overrides = true;

    return v375;
end;

function u1.encode_component(p376, p377) -- Line: 1556
    -- upvalues: u1 (copy), common (copy)
    u1.resolve_dirty(p376);
    local v378 = p376.shared.components.members[p377];

    if v378 then
        return v378;
    end;

    common.log_error("attempted to encode a non-shared component ", common.log_component(p376.world, p377));

    return 0;
end;

function u1.decode_component(p379: any, p380: number) -- Line: 1566
    -- upvalues: u1 (copy)
    u1.resolve_dirty(p379);
    local v381 = p379.shared.components.indexes[p380];

    if not v381 then
        print("NON SHARED COMPONENT", p380, p379.shared.components);
        error("attemped to decode a non shared component");
    end;

    return v381;
end;

function u1.get_shared_count(p382) -- Line: 1576
    -- upvalues: u1 (copy)
    u1.resolve_dirty(p382);

    return #p382.shared.components.keys;
end;

function u1.get_server_entity(p383, p384) -- Line: 1581
    return p383.client_ids[p384];
end;

function u1.get_client_entity(p385: any, p386: number) -- Line: 1585
    return p385.server_ids[p386];
end;

function u1.register_entity(p387: any, p388: any, p389: number) -- Line: 1589
    -- upvalues: world_add (copy)
    p387.server_ids[p389] = p388;
    p387.client_ids[p388] = p389;
    world_add(p387.world, p388, p387.components.__alive_tracking__);
end;

function u1.unregister_entity(p390, p391) -- Line: 1595
    local v392 = p390.client_ids[p391];

    if v392 then
        p390.server_ids[v392] = nil;
        p390.client_ids[p391] = nil;
    end;
end;

function u1.register_custom_id(p393, p394) -- Line: 1603
    p393.registered_custom_ids[p394] = true;
    p393.is_shared_dirty = true;
end;

function u1.generate_handshake(p395) -- Line: 1608
    -- upvalues: u1 (copy), utils (copy)
    u1.resolve_dirty(p395);

    return utils.generate_handshake(p395.shared);
end;

function u1.verify_handshake(p396, p397) -- Line: 1613
    -- upvalues: u1 (copy), utils (copy)
    u1.resolve_dirty(p396);

    return utils.verify_handshake(p396.shared, p397, "server", "client");
end;

function u1.destroy(p398) -- Line: 1618
    if p398.inited == nil then
        return warn("attempted to destroy a client twice");
    end;

    p398.inited = nil;

    for _, v in p398.hooked do
        v();
    end;
end;

function u1.handle_global(p399: any, p400: function) -- Line: 1628
    p399.global_handler = p400;
end;

return {
    create = function(u401, p402) -- Line: 1632, Name: create
        -- upvalues: utils (copy), common (copy), ecs_name (copy), u1 (copy)
        local v403 = {};

        if p402 then
            v403.components = p402;
        elseif u401 then
            v403.components = utils.create_components(utils.tag_factory(u401), utils.component_factory(u401));
            utils.add_component_names(v403.components, function(p404, p405) -- Line: 1639
                -- upvalues: common (ref), u401 (copy)
                common.add_name(u401, p404, p405);
            end);
        end;

        v403.server_ids = {};
        v403.client_ids = {};
        v403.is_shared_dirty = false;
        v403.component_serdes = {};
        v403.requires_shared_lookup = { v403.components.shared, ecs_name };
        v403.global_handler = nil;
        v403.world = u401;
        v403.inited = false;
        v403.is_replicating = false;
        v403.hooked = {};
        v403.registered_custom_ids = {};
        v403.addition_hooks = {};
        v403.network_hooks = {
            deleted = {},
            changed = {},
            removed = {}
        };
        v403.after_replication_callbacks = {};

        return setmetatable(v403, u1);
    end,

    client_replicator = u1
};