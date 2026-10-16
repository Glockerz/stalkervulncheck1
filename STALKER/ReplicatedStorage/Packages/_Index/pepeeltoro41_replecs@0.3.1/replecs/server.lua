-- Decompiled with Potassium's decompiler.

local utils = require(script.Parent:WaitForChild("utils"));
local common = require(script.Parent:WaitForChild("common"));
require(script.Parent:WaitForChild("types"));
require(script.Parent:WaitForChild("customid"));
local masking = require(script.Parent:WaitForChild("masking"));
local cursor = utils.cursor;
local u1 = {};
u1.__index = u1;
local u2 = newproxy();
local u3 = {
    tag = 1,
    component = 2,
    pair_tag = 3,
    pair_component = 4,
    relation = 5,
    relation_component = 6,
    unreliable = 7,
    unreliable_pair = 8
};
local relationships = common.relationships;
local wildcard = common.wildcard;
local ecs_name = common.ecs_name;
local is_pair = common.is_pair;
local pair = common.pair;
local pair_first = common.pair_first;
local pair_second = common.pair_second;
local world_add = common.world_add;
local world_has = common.world_has;
local world_get = common.world_get;
local world_target = common.world_target;
local is_component = common.is_component;
local listen_relation = common.listen_relation;
local hook_added = common.hook_added;
local hook_changed = common.hook_changed;
local hook_removed = common.hook_removed;

local function HOOK_PAIR_ADDED(p4: any, u5: any, u6: function) -- Line: 177
    -- upvalues: pair_first (copy), hook_added (copy)
    return hook_added(p4, pair_first(p4, u5), function(p7, p8, p9) -- Line: 180
        -- upvalues: u5 (copy), u6 (copy)
        if p8 ~= u5 then
            return;
        end;

        u6(p7, p8, p9);
    end);
end;

local function HOOK_PAIR_CHANGED(p10: any, u11: any, u12: function) -- Line: 188
    -- upvalues: pair_first (copy), hook_changed (copy)
    return hook_changed(p10, pair_first(p10, u11), function(p13, p14, p15) -- Line: 191
        -- upvalues: u11 (copy), u12 (copy)
        if p14 ~= u11 then
            return;
        end;

        u12(p13, p14, p15);
    end);
end;

local function HOOK_PAIR_REMOVED(p16: any, u17: any, u18: function) -- Line: 199
    -- upvalues: pair_first (copy), hook_removed (copy)
    return hook_removed(p16, pair_first(p16, u17), function(p19, p20) -- Line: 202
        -- upvalues: u17 (copy), u18 (copy)
        if p20 ~= u17 then
            return;
        end;

        u18(p19, p20);
    end);
end;

local function QUERY_TRACKING_TYPE(p21, p22) -- Line: 210
    -- upvalues: pair (copy), wildcard (copy), world_target (copy), world_get (copy)
    local world = p21.world;

    for i in world:query(pair(p22, wildcard)):iter() do
        local v23 = i;
        local v24 = 0;

        while true do
            local v25 = world_target(world, v23, p22, v24);

            if not v25 then
                break;
            end;

            p21.set_reliable(p21, v23, v25, world_get(world, v23, pair(p22, v25)));
            v24 = v24 + 1;
        end;
    end;
end;

local function QUERY_CURRENT_NETWORKED(p26) -- Line: 225
    -- upvalues: relationships (copy), QUERY_TRACKING_TYPE (copy)
    for i, v in p26.world:query(p26.components.networked):iter() do
        p26.set_networked(p26, i, v);
    end;

    if relationships then
        QUERY_TRACKING_TYPE(p26, p26.components.reliable);
        QUERY_TRACKING_TYPE(p26, p26.components.unreliable);
        QUERY_TRACKING_TYPE(p26, p26.components.relation);
    end;
end;

local function QUERY_CURRENT_COMPONENTS(p27) -- Line: 237
    for i, v in p27.world:query(p27.components.serdes):iter() do
        p27.component_serdes[i] = v;
    end;

    for i, v in p27.world:query(p27.components.global):iter() do
        p27.global_ids[i] = v;
    end;
end;

local function track_entity_lifetime(p28, p29) -- Line: 246
    -- upvalues: world_add (copy)
    if p28.alive_tracked[p29] then
        return;
    end;

    p28.alive_tracked[p29] = true;
    world_add(p28.world, p29, p28.components.__alive_tracking__);
end;

local function get_or_set_entity_storage(p30, p31) -- Line: 254
    local v32 = p30.storage[p31];

    if not v32 then
        v32 = {
            tags = {},
            components = {},
            pair_tags = {},
            pair_components = {},
            relations = {},
            relation_values = {}
        };
        p30.storage[p31] = v32;
    end;

    return v32;
end;

local function allocate_component_change(p33, p34, p35, p36) -- Line: 272
    -- upvalues: get_or_set_entity_storage (copy), u2 (copy)
    local v37 = get_or_set_entity_storage(p33, p34);

    if p36 == nil then
        p36 = u2;
    end;

    v37.components[p35] = p36;

    if not p33.additions[p34] and p33.track_info.networked[p34] then
        p33.masking:allocate_component_change(p34, p35, p36);
    end;
end;

local function allocate_unreliable_addition(p38, p39, p40) -- Line: 283
    if not p38.additions[p39] and p38.track_info.networked[p39] then
        p38.masking:allocate_unreliable_addition(p39, p40);
    end;
end;

local function allocate_tag_addition(p41, p42, p43) -- Line: 290
    -- upvalues: get_or_set_entity_storage (copy)
    get_or_set_entity_storage(p41, p42).tags[p43] = true;

    if not p41.additions[p42] and p41.track_info.networked[p42] then
        p41.masking:allocate_tag_addition(p42, p43);
    end;
end;

local function allocate_pair_tag_addition(p44, p45, p46) -- Line: 299
    -- upvalues: get_or_set_entity_storage (copy)
    get_or_set_entity_storage(p44, p45).pair_tags[p46] = true;

    if not p44.additions[p45] and p44.track_info.networked[p45] then
        p44.masking:allocate_pair_tag_addition(p45, p46);
    end;
end;

local function allocate_pair_component_change(p47, p48, p49, p50) -- Line: 308
    -- upvalues: get_or_set_entity_storage (copy), u2 (copy)
    local v51 = get_or_set_entity_storage(p47, p48);

    if p50 == nil then
        p50 = u2;
    end;

    v51.pair_components[p49] = p50;

    if not p47.additions[p48] and p47.track_info.networked[p48] then
        p47.masking:allocate_pair_component_change(p48, p49, p50);
    end;
end;

local function allocate_relation_component_change(p52, p53, p54, p55, p56) -- Line: 319
    -- upvalues: get_or_set_entity_storage (copy), u2 (copy)
    local v57 = get_or_set_entity_storage(p52, p53);
    local v58 = v57.relation_values[p54];

    if v58 == nil then
        v58 = {};
        v57.relation_values[p54] = v58;
    end;

    if p56 == nil then
        p56 = u2;
    end;

    v58[p55] = p56;

    if not p52.additions[p53] and p52.track_info.networked[p53] then
        p52.masking:allocate_relation_component_change(p53, p54, p55, p56);
    end;
end;

local function allocate_relation_tag_addition(p59, p60, p61, p62) -- Line: 342
    -- upvalues: get_or_set_entity_storage (copy)
    local v63 = get_or_set_entity_storage(p59, p60);
    local v64 = v63.relations[p61];

    if v64 == nil then
        v64 = {};
        v63.relations[p61] = v64;
    end;

    v64[p62] = true;

    if not p59.additions[p60] and p59.track_info.networked[p60] then
        p59.masking:allocate_relation_tag_addition(p60, p61, p62);
    end;
end;

local function allocate_component_removal(p65, p66, p67) -- Line: 356
    -- upvalues: get_or_set_entity_storage (copy)
    get_or_set_entity_storage(p65, p66).components[p67] = nil;

    if not p65.additions[p66] and p65.track_info.networked[p66] then
        p65.masking:allocate_component_removal(p66, p67);
    end;
end;

local function allocate_unreliable_removal(p68, p69, p70) -- Line: 365
    if not p68.additions[p69] and p68.track_info.networked[p69] then
        p68.masking:allocate_unreliable_removal(p69, p70);
    end;
end;

local function allocate_tag_removal(p71, p72, p73) -- Line: 371
    -- upvalues: get_or_set_entity_storage (copy)
    get_or_set_entity_storage(p71, p72).tags[p73] = nil;

    if not p71.additions[p72] and p71.track_info.networked[p72] then
        p71.masking:allocate_tag_removal(p72, p73);
    end;
end;

local function allocate_pair_tag_removal(p74, p75, p76) -- Line: 380
    -- upvalues: get_or_set_entity_storage (copy)
    get_or_set_entity_storage(p74, p75).pair_tags[p76] = nil;

    if not p74.additions[p75] and p74.track_info.networked[p75] then
        p74.masking:allocate_pair_tag_removal(p75, p76);
    end;
end;

local function allocate_pair_component_removal(p77, p78, p79) -- Line: 389
    -- upvalues: get_or_set_entity_storage (copy)
    get_or_set_entity_storage(p77, p78).pair_components[p79] = nil;

    if not p77.additions[p78] and p77.track_info.networked[p78] then
        p77.masking:allocate_pair_component_removal(p78, p79);
    end;
end;

local function allocate_relation_component_removal(p80, p81, p82, p83) -- Line: 398
    -- upvalues: get_or_set_entity_storage (copy)
    local v84 = get_or_set_entity_storage(p80, p81).relation_values[p82];

    if v84 then
        v84[p83] = nil;
    end;

    if not p80.additions[p81] and p80.track_info.networked[p81] then
        p80.masking:allocate_relation_component_removal(p81, p82, p83);
    end;
end;

local function allocate_relation_tag_removal(p85, p86, p87, p88) -- Line: 410
    -- upvalues: get_or_set_entity_storage (copy)
    local v89 = get_or_set_entity_storage(p85, p86).relations[p87];

    if v89 then
        v89[p88] = nil;
    end;

    if not p85.additions[p86] and p85.track_info.networked[p86] then
        p85.masking:allocate_relation_tag_removal(p86, p87, p88);
    end;
end;

local function cleanup_entity(p90, p91) -- Line: 422
    p90.alive_tracked[p91] = nil;
    p90.storage[p91] = nil;
    p90.global_ids[p91] = nil;
    p90.custom_ids[p91] = nil;
    p90.additions[p91] = nil;
    p90.masking:cleanup_entity(p91);
    local v92 = p90.track_info.entities[p91];

    if v92 then
        for i in v92.components do
            local v93 = p90.track_info.components[i];

            if v93 then
                v93[p91] = nil;
            end;
        end;

        for i in v92.pairs do
            local v94 = p90.track_info.pairs[i];

            if v94 then
                v94[p91] = nil;
            end;
        end;

        p90.track_info.entities[p91] = nil;
    end;
end;

local function hook_pair(u95, u96) -- Line: 448
    -- upvalues: common (copy), pair_second (copy), get_or_set_entity_storage (copy), u2 (copy), pair_first (copy), hook_added (copy), hook_changed (copy), hook_removed (copy)
    local world = u95.world;

    if u95.track_info.pairs[u96] then
        error((`attemped to track a pair twice: {common.log_component(u95.world, pair_second(world, u96))}`));
    end;

    local u97 = {};
    u95.track_info.pairs[u96] = u97;

    local function hook(p98: function) -- Line: 458
        -- upvalues: u95 (copy)
        table.insert(u95.hooked, p98);
    end;

    local function u106(p99, p100, p101) -- Line: 462
        -- upvalues: u97 (copy), u95 (copy), get_or_set_entity_storage (ref), u2 (ref)
        local v102 = u97[p99];

        if not v102 then
            return;
        end;

        if v102 == 4 then
            local v103 = u95;
            local v104 = get_or_set_entity_storage(v103, p99);

            if p101 == nil then
                p101 = u2;
            end;

            v104.pair_components[p100] = p101;

            if not v103.additions[p99] and v103.track_info.networked[p99] then
                v103.masking:allocate_pair_component_change(p99, p100, p101);
            end;
        else
            local v105 = u95;
            get_or_set_entity_storage(v105, p99).pair_tags[p100] = true;

            if not v105.additions[p99] and v105.track_info.networked[p99] then
                v105.masking:allocate_pair_tag_addition(p99, p100);
            end;
        end;
    end;

    local v110 = hook_added(world, pair_first(world, u96), function(p107, p108, p109) -- Line: 180
        -- upvalues: u96 (copy), u106 (copy)
        if p108 ~= u96 then
            return;
        end;

        u106(p107, p108, p109);
    end);
    table.insert(u95.hooked, v110);

    local function u116(p111, p112, p113) -- Line: 474
        -- upvalues: u97 (copy), u95 (copy), get_or_set_entity_storage (ref), u2 (ref)
        if not u97[p111] then
            return;
        end;

        local v114 = u95;
        local v115 = get_or_set_entity_storage(v114, p111);

        if p113 == nil then
            p113 = u2;
        end;

        v115.pair_components[p112] = p113;

        if not v114.additions[p111] and v114.track_info.networked[p111] then
            v114.masking:allocate_pair_component_change(p111, p112, p113);
        end;
    end;

    local v120 = hook_changed(world, pair_first(world, u96), function(p117, p118, p119) -- Line: 191
        -- upvalues: u96 (copy), u116 (copy)
        if p118 ~= u96 then
            return;
        end;

        u116(p117, p118, p119);
    end);
    table.insert(u95.hooked, v120);

    local function u126(p121, p122) -- Line: 482
        -- upvalues: u97 (copy), u95 (copy), get_or_set_entity_storage (ref)
        local v123 = u97[p121];

        if not v123 then
            return;
        end;

        if v123 == 4 then
            local v124 = u95;
            get_or_set_entity_storage(v124, p121).pair_components[p122] = nil;

            if not v124.additions[p121] and v124.track_info.networked[p121] then
                v124.masking:allocate_pair_component_removal(p121, p122);
            end;
        else
            local v125 = u95;
            get_or_set_entity_storage(v125, p121).pair_tags[p122] = nil;

            if not v125.additions[p121] and v125.track_info.networked[p121] then
                v125.masking:allocate_pair_tag_removal(p121, p122);
            end;
        end;
    end;

    local v129 = hook_removed(world, pair_first(world, u96), function(p127, p128) -- Line: 202
        -- upvalues: u96 (copy), u126 (copy)
        if p128 ~= u96 then
            return;
        end;

        u126(p127, p128);
    end);
    table.insert(u95.hooked, v129);

    return u97;
end;

local function hook_component(u130, u131) -- Line: 498
    -- upvalues: common (copy), hook_added (copy), get_or_set_entity_storage (copy), u2 (copy), is_pair (copy), allocate_relation_tag_addition (copy), pair_second (copy), allocate_relation_component_change (copy), hook_changed (copy), hook_removed (copy)
    local world = u130.world;

    if u130.track_info.components[u131] then
        error((`attemped to track a component twice: {common.log_component(u130.world, u131)}`));
    end;

    local u132 = {};
    u130.track_info.components[u131] = u132;

    local function _(p133: function) -- Line: 508
        -- upvalues: u130 (copy)
        table.insert(u130.hooked, p133);
    end;

    local v145 = hook_added(world, u131, function(p134, p135, p136) -- Line: 512
        -- upvalues: u132 (copy), u130 (copy), u131 (copy), get_or_set_entity_storage (ref), u2 (ref), is_pair (ref), allocate_relation_tag_addition (ref), pair_second (ref), world (copy), allocate_relation_component_change (ref)
        local v137 = u132[p134];

        if not v137 then
            return;
        end;

        if v137 == 2 then
            local v138 = u130;
            local v139 = u131;
            local v140 = get_or_set_entity_storage(v138, p134);

            if p136 == nil then
                p136 = u2;
            end;

            v140.components[v139] = p136;

            if not v138.additions[p134] and v138.track_info.networked[p134] then
                v138.masking:allocate_component_change(p134, v139, p136);
            end;
        elseif v137 == 1 then
            local v141 = u130;
            local v142 = u131;
            get_or_set_entity_storage(v141, p134).tags[v142] = true;

            if not v141.additions[p134] and v141.track_info.networked[p134] then
                v141.masking:allocate_tag_addition(p134, v142);
            end;
        else
            if v137 == 5 then
                if not is_pair(p135) then
                    return;
                end;

                allocate_relation_tag_addition(u130, p134, u131, pair_second(world, p135));

                return;
            end;

            if v137 == 6 then
                if not is_pair(p135) then
                    return;
                end;

                allocate_relation_component_change(u130, p134, u131, pair_second(world, p135), p136);

                return;
            end;

            if v137 == 7 then
                local v143 = u130;
                local v144 = u131;

                if not v143.additions[p134] and v143.track_info.networked[p134] then
                    v143.masking:allocate_unreliable_addition(p134, v144);
                end;
            end;
        end;
    end);
    table.insert(u130.hooked, v145);
    local v153 = hook_changed(world, u131, function(p146, p147, p148) -- Line: 536
        -- upvalues: u132 (copy), u130 (copy), u131 (copy), get_or_set_entity_storage (ref), u2 (ref), is_pair (ref), allocate_relation_component_change (ref), pair_second (ref), world (copy)
        local v149 = u132[p146];

        if not v149 then
            return;
        end;

        if v149 == 2 then
            local v150 = u130;
            local v151 = u131;
            local v152 = get_or_set_entity_storage(v150, p146);

            if p148 == nil then
                p148 = u2;
            end;

            v152.components[v151] = p148;

            if not v150.additions[p146] and v150.track_info.networked[p146] then
                v150.masking:allocate_component_change(p146, v151, p148);
            end;
        elseif v149 == 6 then
            if not is_pair(p147) then
                return;
            end;

            allocate_relation_component_change(u130, p146, u131, pair_second(world, p147), p148);
        end;
    end);
    table.insert(u130.hooked, v153);
    local v171 = hook_removed(world, u131, function(p154, p155) -- Line: 550
        -- upvalues: u132 (copy), u130 (copy), u131 (copy), get_or_set_entity_storage (ref), is_pair (ref), pair_second (ref), world (copy)
        local v156 = u132[p154];

        if not v156 then
            return;
        end;

        if v156 == 2 then
            local v157 = u130;
            local v158 = u131;
            get_or_set_entity_storage(v157, p154).components[v158] = nil;

            if not v157.additions[p154] and v157.track_info.networked[p154] then
                v157.masking:allocate_component_removal(p154, v158);
            end;
        elseif v156 == 1 then
            local v159 = u130;
            local v160 = u131;
            get_or_set_entity_storage(v159, p154).tags[v160] = nil;

            if not v159.additions[p154] and v159.track_info.networked[p154] then
                v159.masking:allocate_tag_removal(p154, v160);
            end;
        elseif v156 == 5 then
            if not is_pair(p155) then
                return;
            end;

            local v161 = u130;
            local v162 = u131;
            local v163 = pair_second(world, p155);
            local v164 = get_or_set_entity_storage(v161, p154).relations[v162];

            if v164 then
                v164[v163] = nil;
            end;

            if not v161.additions[p154] and v161.track_info.networked[p154] then
                v161.masking:allocate_relation_tag_removal(p154, v162, v163);
            end;
        elseif v156 == 6 then
            if not is_pair(p155) then
                return;
            end;

            local v165 = u130;
            local v166 = u131;
            local v167 = pair_second(world, p155);
            local v168 = get_or_set_entity_storage(v165, p154).relation_values[v166];

            if v168 then
                v168[v167] = nil;
            end;

            if not v165.additions[p154] and v165.track_info.networked[p154] then
                v165.masking:allocate_relation_component_removal(p154, v166, v167);
            end;
        elseif v156 == 7 then
            local v169 = u130;
            local v170 = u131;

            if not v169.additions[p154] and v169.track_info.networked[p154] then
                v169.masking:allocate_unreliable_removal(p154, v170);
            end;
        end;
    end);
    table.insert(u130.hooked, v171);

    return u132;
end;

local function add_entity_component_tracked(p172: any, p173: any, p174: any, p175: number) -- Line: 578
    local v176 = p172.track_info.entities[p173];

    if v176 == nil then
        p172.track_info.entities[p173] = {
            components = {
                [p174] = p175
            },
            pairs = {}
        };

        return;
    end;

    v176.components[p174] = p175;
end;

local function add_entity_pair_tracked(p177: any, p178: any, p179: any, p180: number) -- Line: 591
    local v181 = p177.track_info.entities[p178];

    if v181 == nil then
        p177.track_info.entities[p178] = {
            components = {},
            pairs = {
                [p179] = p180
            }
        };

        return;
    end;

    v181.pairs[p179] = p180;
end;

local function remove_entity_component_tracked(p182, p183, p184) -- Line: 604
    local v185 = p182.track_info.entities[p183];

    if v185 then
        v185.components[p184] = nil;
    end;
end;

local function remove_entity_pair_tracked(p186, p187, p188) -- Line: 611
    local v189 = p186.track_info.entities[p187];

    if v189 then
        v189.pairs[p188] = nil;
    end;
end;

local function track_entity_unreliable(p190, p191, p192) -- Line: 618
    -- upvalues: hook_component (copy), add_entity_component_tracked (copy)
    (p190.track_info.components[p192] or hook_component(p190, p192))[p191] = 7;
    add_entity_component_tracked(p190, p191, p192, 7);
end;

local function track_entity_component(p193, p194, p195) -- Line: 628
    -- upvalues: hook_component (copy), get_or_set_entity_storage (copy), is_component (copy), world_has (copy), world_get (copy), u2 (copy), add_entity_component_tracked (copy)
    local world = p193.world;
    local v196 = p193.track_info.components[p195] or hook_component(p193, p195);
    local v197 = get_or_set_entity_storage(p193, p194);

    if is_component(world, p195) then
        if world_has(world, p194, p195) then
            local v198 = world_get(world, p194, p195);

            if v198 == nil then
                v197.components[p195] = u2;
            else
                v197.components[p195] = v198;
            end;
        end;

        v196[p194] = 2;
        add_entity_component_tracked(p193, p194, p195, 2);

        return 2;
    end;

    if world_has(world, p194, p195) then
        v197.tags[p195] = true;
    end;

    v196[p194] = 1;
    add_entity_component_tracked(p193, p194, p195, 1);

    return 1;
end;

local function track_entity_pair(p199, p200, p201) -- Line: 664
    -- upvalues: hook_pair (copy), get_or_set_entity_storage (copy), is_component (copy), world_has (copy), world_get (copy), u2 (copy), add_entity_pair_tracked (copy)
    local world = p199.world;
    local v202 = p199.track_info.pairs[p201] or hook_pair(p199, p201);
    local v203 = get_or_set_entity_storage(p199, p200);

    if is_component(world, p201) then
        if world_has(world, p200, p201) then
            local v204 = world_get(world, p200, p201);

            if v204 == nil then
                v203.pair_components[p201] = u2;
            else
                v203.pair_components[p201] = v204;
            end;
        end;

        v202[p200] = 4;
        add_entity_pair_tracked(p199, p200, p201, 4);

        return 4;
    end;

    if world_has(world, p200, p201) then
        v203.pair_tags[p201] = true;
    end;

    v202[p200] = 3;
    add_entity_pair_tracked(p199, p200, p201, 3);

    return 3;
end;

local function track_entity_relation(p205, p206, p207) -- Line: 700
    -- upvalues: hook_component (copy), get_or_set_entity_storage (copy), is_component (copy), world_target (copy), world_get (copy), pair (copy), u2 (copy), add_entity_component_tracked (copy)
    local world = p205.world;
    local v208 = p205.track_info.components[p207] or hook_component(p205, p207);
    local v209 = get_or_set_entity_storage(p205, p206);

    if is_component(world, p207) then
        local v210 = 0;
        local v211 = {};

        while true do
            local v212 = world_target(world, p206, p207, v210);

            if not v212 then
                break;
            end;

            v210 = v210 + 1;
            local v213 = world_get(world, p206, pair(p207, v212));

            if v213 == nil then
                v213 = u2;
            end;

            v211[v212] = v213;
        end;

        v209.relation_values[p207] = v211;
        v208[p206] = 6;
        add_entity_component_tracked(p205, p206, p207, 6);

        return 6;
    end;

    local v214 = 0;
    local v215 = {};

    while true do
        local v216 = world_target(world, p206, p207, v214);

        if not v216 then
            break;
        end;

        v214 = v214 + 1;
        v215[v216] = true;
    end;

    v209.relations[p207] = v215;
    v208[p206] = 5;
    add_entity_component_tracked(p205, p206, p207, 5);

    return 5;
end;

local function untrack_entity_component(p217, p218, p219) -- Line: 749
    local v220 = p217.track_info.components[p219];

    if not v220 then
        return nil;
    end;

    local v221 = v220[p218];
    v220[p218] = nil;
    local v222 = p217.storage[p218];

    if v222 then
        v222.components[p219] = nil;
        v222.tags[p219] = nil;
    end;

    local v223 = p217.track_info.entities[p218];

    if v223 then
        v223.components[p219] = nil;
    end;

    return v221;
end;

local function untrack_entity_pair(p224, p225, p226) -- Line: 767
    local v227 = p224.track_info.pairs[p226];

    if not v227 then
        return nil;
    end;

    local v228 = v227[p225];
    v227[p225] = nil;
    local v229 = p224.storage[p225];

    if v229 then
        v229.pair_tags[p226] = nil;
        v229.pair_components[p226] = nil;
    end;

    local v230 = p224.track_info.entities[p225];

    if v230 then
        v230.pairs[p226] = nil;
    end;

    return v228;
end;

local function untrack_entity_relation(p231, p232, p233) -- Line: 785
    local v234 = p231.track_info.components[p233];

    if not v234 then
        return nil;
    end;

    local v235 = v234[p232];
    v234[p232] = nil;
    local v236 = p231.storage[p232];

    if v236 then
        v236.relations[p233] = nil;
        v236.relation_values[p233] = nil;
    end;

    local v237 = p231.track_info.entities[p232];

    if v237 then
        v237.components[p233] = nil;
    end;

    return v235;
end;

local function write_vlq_bitmask(p238: any, p239: number, p240: number, p241: number) -- Line: 803
    -- upvalues: cursor (copy), utils (copy)
    if p239 <= 0 then
        return p240;
    end;

    cursor.write_vlq(p238, p239);

    return utils.setbit(p240, p241);
end;

function u1.write_component_id(p242, p243, p244) -- Line: 812
    -- upvalues: common (copy), cursor (copy)
    local components = p242.shared.components;
    local v245 = components.members[p244];

    if v245 then
        cursor.write_span(p243, v245, #components.keys);

        return;
    end;

    common.log_error("attempted to replicate a non-shared component ", common.log_component(p242.world, p244));
end;

function u1.write_variant_value(p246, p247, p248, p249, p250, p251) -- Line: 822
    -- upvalues: u2 (copy), cursor (copy), common (copy)
    if p249 then
        if p250 == u2 then
            p250 = nil;
        end;

        local v252, v253 = p249.serialize(p250);

        if p249.includes_variants then
            if v253 == nil then
                cursor.writeu8(p247, 128);
            else
                if #v253 > 0 then
                    table.move(v253, 1, #v253, #p251 + 1, p251);
                end;

                cursor.write_vlq(p247, #v253);
                cursor.write_vlq(p247, #p251 + 1);
            end;
        elseif v253 ~= nil then
            common.log_error("serdes: serializer provided variants yet includes_variants is not set to true for component: ", common.log_component(p246.world, p248));
        end;

        local bytespan = p249.bytespan;
        cursor.write_buffer(p247, v252);

        if not bytespan then
            local buffer_len_ret = buffer.len(v252);
            cursor.write_vlq(p247, buffer_len_ret);

            return;
        end;

        if bytespan ~= buffer.len(v252) then
            common.log_error(`bytespan: {bytespan} mismatch for buffer lenght: {buffer.len(v252)} in component: `, common.log_component(p246.world, p248));
        end;
    else
        if p250 == nil or p250 == u2 then
            cursor.writeu8(p247, 128);

            return;
        end;

        table.insert(p251, p250);
        cursor.write_vlq(p247, #p251);
    end;
end;

function u1.write_component_value(p254: any, p255: any, p256: any, p257: any, p258: table) -- Line: 876
    -- upvalues: u1 (copy)
    u1.write_variant_value(p254, p255, p256, p254.shared.serdes[p256], p257, p258);
end;

function u1.write_pair_value(p259: any, p260: any, p261: any, p262: any, p263: any, p264: table) -- Line: 887
    -- upvalues: pair (copy), wildcard (copy), u1 (copy)
    local v265 = p259.shared.serdes[p262] or p259.shared.serdes[pair(p261, wildcard)];
    u1.write_variant_value(p259, p260, p261, v265, p263, p264);
end;

function u1.write_entity_id(p266, p267, p268) -- Line: 899
    -- upvalues: cursor (copy), u1 (copy)
    local v269 = p266.custom_ids[p268];
    local v270 = p266.global_ids[p268];

    if v270 then
        cursor.writeu8(p267, v270 + 10);

        return;
    end;

    if v269 then
        if type(v269) == "number" then
            u1.write_component_id(p266, p267, v269);
            cursor.writeu40(p267, p268);
            cursor.writeu8(p267, 3);

            return;
        end;

        cursor.writeu8(p267, p266.shared.custom_ids.members[v269]);
        cursor.writeu40(p267, p268);
        cursor.writeu8(p267, 2);

        return;
    end;

    local v271 = p266.shared.components.members[p268];

    if v271 then
        cursor.writeu8(p267, v271);
        cursor.writeu8(p267, 4);

        return;
    end;

    cursor.writeu40(p267, p268);
    cursor.writeu8(p267, 1, p268);
end;

function u1.write_entity_relations(p272: any, p273: table, p274: any, p275: any) -- Line: 927
    -- upvalues: u1 (copy), cursor (copy)
    local v276 = 0;

    for i in p273.relations[p275] do
        u1.write_entity_id(p272, p274, i);
        v276 = v276 + 1;
    end;

    cursor.write_vlq(p274, v276);
    u1.write_component_id(p272, p274, p275);
end;

function u1.write_entity_relations_values(p277: any, p278: table, p279: any, p280: any, p281: table) -- Line: 939
    -- upvalues: u1 (copy), cursor (copy)
    local v282 = 0;

    for i, v in p278.relation_values[p280] do
        u1.write_entity_id(p277, p279, i);
        u1.write_component_value(p277, p279, p280, v, p281);
        v282 = v282 + 1;
    end;

    cursor.write_vlq(p279, v282);
    u1.write_component_id(p277, p279, p280);
end;

function u1.write_entity_pair_value(p283: any, p284: any, p285: any, p286: any, p287: any, p288: table) -- Line: 958
    -- upvalues: pair_first (copy), pair_second (copy), u1 (copy), cursor (copy)
    local v289 = pair_first(p284, p286);
    local v290 = pair_second(p284, p286);
    local offset = p285.offset;
    u1.write_pair_value(p283, p285, v289, p286, p287, p288);
    cursor.write_vlq(p285, p285.offset - offset);
    u1.write_entity_id(p283, p285, v290);
    u1.write_component_id(p283, p285, v289);
end;

function u1.write_entity_pair(p291, p292, p293, p294) -- Line: 980
    -- upvalues: pair_first (copy), pair_second (copy), u1 (copy)
    local v295 = pair_first(p292, p294);
    local v296 = pair_second(p292, p294);
    u1.write_entity_id(p291, p293, v296);
    u1.write_component_id(p291, p293, v295);
end;

function u1.write_entity(p297: any, p298: any, p299: any, p300: any, p301: table) -- Line: 987
    -- upvalues: u1 (copy), cursor (copy), utils (copy), world_has (copy), world_get (copy)
    local world = p297.world;
    local v302 = p297.storage[p299];
    local v303 = 0;
    local v304 = 0;

    for i in p300.components[6] do
        u1.write_entity_relations_values(p297, v302, p298, i, p301);
        v303 = v303 + 1;
    end;

    if v303 > 0 then
        cursor.write_vlq(p298, v303);
        v304 = utils.setbit(v304, 5);
    end;

    local v305 = 0;

    for i in p300.components[5] do
        u1.write_entity_relations(p297, v302, p298, i);
        v305 = v305 + 1;
    end;

    if v305 > 0 then
        cursor.write_vlq(p298, v305);
        v304 = utils.setbit(v304, 4);
    end;

    local v306 = 0;

    for i in p300.components[4] do
        local v307 = v302.pair_components[i];

        if v307 ~= nil then
            u1.write_entity_pair_value(p297, world, p298, i, v307, p301);
            v306 = v306 + 1;
        end;
    end;

    if v306 > 0 then
        cursor.write_vlq(p298, v306);
        v304 = utils.setbit(v304, 3);
    end;

    local v308 = 0;

    for i in p300.components[3] do
        if v302.pair_tags[i] then
            u1.write_entity_pair(p297, world, p298, i);
            v308 = v308 + 1;
        end;
    end;

    if v308 > 0 then
        cursor.write_vlq(p298, v308);
        v304 = utils.setbit(v304, 2);
    end;

    local v309 = 0;

    for i in p300.components[2] do
        local v310 = v302.components[i];

        if v310 ~= nil then
            u1.write_component_value(p297, p298, i, v310, p301);
            u1.write_component_id(p297, p298, i);
            v309 = v309 + 1;
        end;
    end;

    for i in p300.components[7] do
        if world_has(world, p299, i) then
            local v311 = world_get(world, p299, i);
            u1.write_component_value(p297, p298, i, v311, p301);
            u1.write_component_id(p297, p298, i);
            v309 = v309 + 1;
        end;
    end;

    if v309 > 0 then
        cursor.write_vlq(p298, v309);
        v304 = utils.setbit(v304, 1);
    end;

    local v312 = 0;

    for i in p300.components[1] do
        if v302.tags[i] then
            u1.write_component_id(p297, p298, i);
            v312 = v312 + 1;
        end;
    end;

    if v312 > 0 then
        cursor.write_vlq(p298, v312);
        v304 = utils.setbit(v304, 0);
    end;

    cursor.writeu8(p298, v304);
end;

function u1.resolve_dirty(p313) -- Line: 1071
    -- upvalues: utils (copy)
    if p313.is_shared_dirty then
        p313.shared = utils.resolved_shared(p313.world, p313.components, p313.registered_custom_ids, p313.component_serdes);
        p313.is_shared_dirty = false;
    end;
end;

local function append_packet(p314: table, p315: table, p316: buffer, p317: table) -- Line: 1094
    -- upvalues: utils (copy)
    local buffer_len_ret = buffer.len(p316);

    for _, v in p315 do
        if utils.is_client_valid(v) then
            local v318 = p314[v];

            if v318 then
                table.insert(v318.packets, {
                    buffer = p316,
                    variants = p317
                });
                v318.total_size = v318.total_size + buffer_len_ret;
            else
                p314[v] = {
                    packets = {
                        {
                            buffer = p316,
                            variants = p317
                        }
                    },
                    total_size = buffer_len_ret
                };
            end;
        end;
    end;
end;

local function combine_packet_outputs(p319: table, p320: number, p321: number) -- Line: 1122
    -- upvalues: utils (copy), cursor (copy)
    local buffer_create_ret = buffer.create(p320 + utils.vlq_span(#p319) + 1);
    local table_create_ret = table.create(#p319);
    local v322 = 0;

    for _, v in p319 do
        buffer.copy(buffer_create_ret, v322, v.buffer);
        v322 = v322 + buffer.len(v.buffer);
        table.insert(table_create_ret, v.variants);
    end;

    cursor.write_vlq({
        offset = v322,
        buffer = buffer_create_ret
    }, #p319);
    local v323 = buffer.len(buffer_create_ret) - 1;
    buffer.writeu8(buffer_create_ret, v323, p321);

    return buffer_create_ret, table_create_ret;
end;

local function create_packet_iterator(u324: table, u325: number) -- Line: 1143
    -- upvalues: utils (copy), combine_packet_outputs (copy)
    local u326 = nil;

    return function() -- Line: 1145, Name: iterator
        -- upvalues: u324 (copy), u326 (ref), utils (ref), combine_packet_outputs (ref), u325 (copy)
        local v327, v328 = next(u324, u326);

        while not utils.is_client_valid(v327) and (v327 or v328) do
            v327, v328 = next(u324, v327);
        end;

        if not v327 then
            return nil;
        end;

        u326 = v327;
        local v329, v330 = combine_packet_outputs(v328.packets, v328.total_size, u325);

        return v327, v329, v330;
    end;
end;

local function create_unreliable_packet_iterator(u331: table) -- Line: 1164
    -- upvalues: utils (copy), combine_packet_outputs (copy)
    return coroutine.wrap(function() -- Line: 1165
        -- upvalues: u331 (copy), utils (ref), combine_packet_outputs (ref)
        for i, v in u331 do
            if utils.is_client_valid(i) then
                table.sort(v.packets, function(p332, p333) -- Line: 1171
                    return buffer.len(p332.buffer) < buffer.len(p333.buffer);
                end);
                local v334 = #v.packets;
                local v335 = i;
                local v336 = v;
                local v337 = 1;

                while v337 <= v334 do
                    local v338 = 0;
                    local v339 = {};

                    while v337 <= v334 do
                        local v340 = v336.packets[v337];
                        local buffer_len_ret = buffer.len(v340.buffer);

                        if v338 + buffer_len_ret > 900 and #v339 > 0 then
                            break;
                        end;

                        table.insert(v339, v340);
                        v338 = v338 + buffer_len_ret;
                        v337 = v337 + 1;

                        if v338 >= 900 then
                            break;
                        end;
                    end;

                    if #v339 > 0 then
                        coroutine.yield(v335, combine_packet_outputs(v339, v338, 4));
                    end;
                end;
            end;
        end;
    end);
end;

function u1.get_full(p341: any, p342: userdata) -- Line: 1206
    -- upvalues: u1 (copy), common (copy), cursor (copy), combine_packet_outputs (copy)
    u1.resolve_dirty(p341);
    local v343 = p341.masking.client_indexes[p342];

    if v343 == nil then
        common.log_error("attempted to replicate for a non registered client");
    end;

    local v344 = {};
    local v345 = 0;

    for _, v in p341.masking.storages do
        if v.active_count ~= 0 and v.mask.bitmask:get(v343) then
            local v346 = cursor.new();
            local v347 = {};
            local v348 = 0;

            for i, v2 in v.active do
                u1.write_entity(p341, v346, i, v2, v347);
                u1.write_entity_id(p341, v346, i);
                v348 = v348 + 1;
            end;

            cursor.write_vlq(v346, v348);
            local v349 = cursor.close(v346);
            table.insert(v344, {
                buffer = v349,
                variants = v347
            });
            v345 = v345 + buffer.len(v349);
        end;
    end;

    return combine_packet_outputs(v344, v345, 1);
end;

function u1.collect_entity(p350, p351) -- Line: 1246
    -- upvalues: u1 (copy), cursor (copy), append_packet (copy), utils (copy), combine_packet_outputs (copy)
    u1.resolve_dirty(p350);
    local u352 = {};
    local v353 = {};
    local v354 = p350.masking.lookups.entities[p351];
    local storage_group = v354.storage_group;
    local v355 = cursor.new();
    local v356 = {};
    u1.write_entity(p350, v355, p351, storage_group.active[p351], v356);
    u1.write_entity_id(p350, v355, p351);
    append_packet(u352, storage_group.mask.members, cursor.close(v355), v356);
    v353[storage_group] = true;

    for _, v in v354.filtered_components do
        for _, v2 in v do
            local storage_group2 = v2.storage_group;

            if not v353[storage_group2] then
                local v357 = cursor.new();
                local v358 = {};
                u1.write_entity(p350, v357, p351, storage_group2.active[p351], v358);
                u1.write_entity_id(p350, v357, p351);
                append_packet(u352, storage_group2.mask.members, cursor.close(v357), v358);
                v353[storage_group2] = true;
            end;
        end;
    end;

    local u359 = nil;
    local u360 = 2;

    return function() -- Line: 1145, Name: iterator
        -- upvalues: u352 (copy), u359 (ref), utils (ref), combine_packet_outputs (ref), u360 (copy)
        local v361, v362 = next(u352, u359);

        while not utils.is_client_valid(v361) and (v361 or v362) do
            v361, v362 = next(u352, v361);
        end;

        if not v361 then
            return nil;
        end;

        u359 = v361;
        local v363, v364 = combine_packet_outputs(v362.packets, v362.total_size, u360);

        return v361, v363, v364;
    end;
end;

function u1.collect_updates(p365) -- Line: 1282
    -- upvalues: u1 (copy), cursor (copy), utils (copy), world_get (copy), append_packet (copy), combine_packet_outputs (copy)
    u1.resolve_dirty(p365);
    local world = p365.world;
    local u366 = {};

    for _, v in p365.masking.storages do
        local v367 = cursor.new();
        local entities = v.deletions.entities;
        local v368 = v;
        local v369 = 0;
        local v370 = 0;
        local v371 = {};

        for i in entities do
            u1.write_entity_id(p365, v367, i);
            v369 = v369 + 1;
        end;

        table.clear(entities);

        if v369 > 0 then
            cursor.write_vlq(v367, v369);
            v370 = utils.setbit(v370, 4);
        end;

        local components = v368.deletions.components;
        local v372 = 0;

        for i, v2 in components do
            local v373 = v2;
            local v374 = 0;

            for i2 in v2[6] do
                u1.write_component_id(p365, v367, i2);
                v374 = v374 + 1;
            end;

            for i2 in v373[5] do
                u1.write_component_id(p365, v367, i2);
                v374 = v374 + 1;
            end;

            cursor.write_vlq(v367, v374);
            local v375 = 0;

            for i2 in v373[4] do
                u1.write_entity_pair(p365, world, v367, i2);
                v375 = v375 + 1;
            end;

            for i2 in v373[3] do
                u1.write_entity_pair(p365, world, v367, i2);
                v375 = v375 + 1;
            end;

            cursor.write_vlq(v367, v375);
            local v376 = 0;

            for i2 in v373[2] do
                u1.write_component_id(p365, v367, i2);
                v376 = v376 + 1;
            end;

            for i2 in v373[7] do
                u1.write_component_id(p365, v367, i2);
                v376 = v376 + 1;
            end;

            for i2 in v373[1] do
                u1.write_component_id(p365, v367, i2);
                v376 = v376 + 1;
            end;

            cursor.write_vlq(v367, v376);
            u1.write_entity_id(p365, v367, i);
            v372 = v372 + 1;
        end;

        table.clear(components);

        if v372 > 0 then
            cursor.write_vlq(v367, v372);
            v370 = utils.setbit(v370, 3);
        end;

        local changes = v368.changes;
        local v377 = 0;

        for i, v2 in changes.changed do
            local v378 = i;
            local v379 = v2;
            local v380 = 0;

            for i2, v3 in v2.relation_component_removed do
                local v381 = 0;

                for i3 in v3 do
                    u1.write_entity_id(p365, v367, i3);
                    v381 = v381 + 1;
                end;

                cursor.write_vlq(v367, v381);
                u1.write_component_id(p365, v367, i2);
                v380 = v380 + 1;
            end;

            for i2, v3 in v379.relation_tag_removed do
                local v382 = 0;

                for i3 in v3 do
                    u1.write_entity_id(p365, v367, i3);
                    v382 = v382 + 1;
                end;

                cursor.write_vlq(v367, v382);
                u1.write_component_id(p365, v367, i2);
                v380 = v380 + 1;
            end;

            cursor.write_vlq(v367, v380);
            local v383 = 0;
            local v384 = 0;

            for i2, v3 in v379.relation_component_changed do
                local v385 = i2;
                local v386 = 0;

                for i3, v4 in v3 do
                    u1.write_entity_id(p365, v367, i3);
                    u1.write_component_value(p365, v367, v385, v4, v371);
                    v386 = v386 + 1;
                end;

                cursor.write_vlq(v367, v386);
                u1.write_component_id(p365, v367, v385);
                v383 = v383 + 1;
            end;

            if v383 > 0 then
                cursor.write_vlq(v367, v383);
                v384 = utils.setbit(v384, 7);
            end;

            local v387 = 0;

            for i2, v3 in v379.relation_tag_added do
                local v388 = 0;

                for i3 in v3 do
                    u1.write_entity_id(p365, v367, i3);
                    v388 = v388 + 1;
                end;

                cursor.write_vlq(v367, v388);
                u1.write_component_id(p365, v367, i2);
                v387 = v387 + 1;
            end;

            if v387 > 0 then
                cursor.write_vlq(v367, v387);
                v384 = utils.setbit(v384, 6);
            end;

            local v389 = 0;

            for i2 in v379.pair_component_removed do
                u1.write_entity_pair(p365, world, v367, i2);
                v389 = v389 + 1;
            end;

            for i2 in v379.pair_tag_removed do
                u1.write_entity_pair(p365, world, v367, i2);
                v389 = v389 + 1;
            end;

            if v389 > 0 then
                cursor.write_vlq(v367, v389);
                v384 = utils.setbit(v384, 5);
            end;

            local v390 = 0;

            for i2, v3 in v379.pair_component_changed do
                u1.write_entity_pair_value(p365, world, v367, i2, v3, v371);
                v390 = v390 + 1;
            end;

            if v390 > 0 then
                cursor.write_vlq(v367, v390);
                v384 = utils.setbit(v384, 4);
            end;

            local v391 = 0;

            for i2 in v379.pair_tag_added do
                u1.write_entity_pair(p365, world, v367, i2);
                v391 = v391 + 1;
            end;

            if v391 > 0 then
                cursor.write_vlq(v367, v391);
                v384 = utils.setbit(v384, 3);
            end;

            local v392 = 0;

            for i2 in v379.component_removed do
                u1.write_component_id(p365, v367, i2);
                v392 = v392 + 1;
            end;

            for i2 in v379.unreliable_removed do
                u1.write_component_id(p365, v367, i2);
                v392 = v392 + 1;
            end;

            for i2 in v379.tag_removed do
                u1.write_component_id(p365, v367, i2);
                v392 = v392 + 1;
            end;

            if v392 > 0 then
                cursor.write_vlq(v367, v392);
                v384 = utils.setbit(v384, 2);
            end;

            local v393 = 0;

            for i2, v3 in v379.component_changed do
                u1.write_component_value(p365, v367, i2, v3, v371);
                u1.write_component_id(p365, v367, i2);
                v393 = v393 + 1;
            end;

            for i2 in v379.unreliable_added do
                local v394 = world_get(world, v378, i2);
                u1.write_component_value(p365, v367, i2, v394, v371);
                u1.write_component_id(p365, v367, i2);
                v393 = v393 + 1;
            end;

            if v393 > 0 then
                cursor.write_vlq(v367, v393);
                v384 = utils.setbit(v384, 1);
            end;

            local v395 = 0;

            for i2 in v379.tag_added do
                u1.write_component_id(p365, v367, i2);
                v395 = v395 + 1;
            end;

            if v395 > 0 then
                cursor.write_vlq(v367, v395);
                v384 = utils.setbit(v384, 0);
            end;

            if v384 + v380 ~= 0 then
                cursor.writeu8(v367, v384);
                u1.write_entity_id(p365, v367, v378);
                v377 = v377 + 1;
            end;
        end;

        table.clear(changes.changed);

        if v377 > 0 then
            cursor.write_vlq(v367, v377);
            v370 = utils.setbit(v370, 2);
        end;

        local v396 = 0;

        for i, v2 in changes.added_components do
            local v397 = p365.storage[i];
            local v398 = i;
            local v399 = v2;
            local v400 = 0;
            local v401 = 0;

            for i2 in v2[6] do
                u1.write_entity_relations_values(p365, v397, v367, i2, v371);
                v400 = v400 + 1;
            end;

            if v400 > 0 then
                cursor.write_vlq(v367, v400);
                v401 = utils.setbit(v401, 5);
            end;

            local v402 = 0;

            for i2 in v399[5] do
                u1.write_entity_relations(p365, v397, v367, i2);
                v402 = v402 + 1;
            end;

            if v402 > 0 then
                cursor.write_vlq(v367, v402);
                v401 = utils.setbit(v401, 4);
            end;

            local v403 = 0;

            for i2 in v399[4] do
                u1.write_entity_pair_value(p365, world, v367, i2, v397.pair_components[i2], v371);
                v403 = v403 + 1;
            end;

            if v403 > 0 then
                cursor.write_vlq(v367, v403);
                v401 = utils.setbit(v401, 3);
            end;

            local v404 = 0;

            for i2 in v399[3] do
                u1.write_entity_pair(p365, world, v367, i2);
                v404 = v404 + 1;
            end;

            if v404 > 0 then
                cursor.write_vlq(v367, v404);
                v401 = utils.setbit(v401, 2);
            end;

            local v405 = 0;

            for i2 in v399[2] do
                u1.write_component_value(p365, v367, i2, v397.components[i2], v371);
                u1.write_component_id(p365, v367, i2);
                v405 = v405 + 1;
            end;

            for i2 in v399[7] do
                local v406 = world_get(world, v398, i2);
                u1.write_component_value(p365, v367, i2, v406, v371);
                u1.write_component_id(p365, v367, i2);
                v405 = v405 + 1;
            end;

            if v405 > 0 then
                cursor.write_vlq(v367, v405);
                v401 = utils.setbit(v401, 1);
            end;

            local v407 = 0;

            for i2 in v399[1] do
                if v397.tags[i2] then
                    u1.write_component_id(p365, v367, i2);
                    v407 = v407 + 1;
                end;
            end;

            if v407 > 0 then
                cursor.write_vlq(v367, v407);
                v401 = utils.setbit(v401, 0);
            end;

            if v401 ~= 0 then
                cursor.writeu8(v367, v401);
                u1.write_entity_id(p365, v367, v398);
                v396 = v396 + 1;
            end;
        end;

        table.clear(changes.added_components);

        if v396 > 0 then
            cursor.write_vlq(v367, v396);
            v370 = utils.setbit(v370, 1);
        end;

        local v408 = 0;

        for i in changes.added do
            local v409 = v368.active[i];

            if v409 then
                u1.write_entity(p365, v367, i, v409, v371);
                u1.write_entity_id(p365, v367, i);
                v408 = v408 + 1;
            end;
        end;

        table.clear(changes.added);

        if v408 > 0 then
            cursor.write_vlq(v367, v408);
            v370 = utils.setbit(v370, 0);
        end;

        if v370 ~= 0 then
            cursor.writeu8(v367, v370);
            local v410 = cursor.close(v367);
            append_packet(u366, v368.mask.members, v410, v371);
        end;
    end;

    table.clear(p365.additions);
    local u411 = nil;
    local u412 = 3;

    return function() -- Line: 1145, Name: iterator
        -- upvalues: u366 (copy), u411 (ref), utils (ref), combine_packet_outputs (ref), u412 (copy)
        local v413, v414 = next(u366, u411);

        while not utils.is_client_valid(v413) and (v413 or v414) do
            v413, v414 = next(u366, v413);
        end;

        if not v413 then
            return nil;
        end;

        u411 = v413;
        local v415, v416 = combine_packet_outputs(v414.packets, v414.total_size, u412);

        return v413, v415, v416;
    end;
end;

function u1.collect_unreliable(p417) -- Line: 1588
    -- upvalues: u1 (copy), cursor (copy), append_packet (copy), world_has (copy), world_get (copy), utils (copy), combine_packet_outputs (copy)
    u1.resolve_dirty(p417);
    local world = p417.world;
    local u418 = {};

    for _, v in p417.masking.storages do
        if v.active_count ~= 0 then
            local active = v.active;
            local u419 = cursor.new();
            local u420 = {};
            local u421 = 0;
            local u422 = 0;
            local u423 = 0;
            local u424 = 0;

            local function create_checkpoint() -- Line: 1607
                -- upvalues: u422 (ref), u419 (ref), u423 (ref), u420 (ref), u424 (ref), u421 (ref)
                u422 = u419.offset;
                u423 = #u420;
                u424 = u421;
            end;

            local function rollback_checkpoint() -- Line: 1613
                -- upvalues: cursor (ref), u419 (ref), u422 (ref), u420 (ref), u423 (ref), u421 (ref), u424 (ref)
                local v425 = cursor.new();
                cursor.write_buffer(v425, u419.buffer, u422, u419.offset - u422);
                u419.offset = u422;
                u419 = v425;
                local v426 = {};

                for i = #u420, u423 + 1, -1 do
                    local table_remove_ret = table.remove(u420);
                    table.insert(v426, 1, table_remove_ret);
                    local _ = i;
                end;

                u420 = v426;
                u421 = u421 - u424;
            end;

            local function commit_checkpoint(p427, p428, p429) -- Line: 1628
                -- upvalues: cursor (ref), append_packet (ref), u418 (copy), v (copy)
                if p429 <= 0 then
                    return;
                end;

                cursor.write_vlq(p427, p429);
                local v430 = cursor.close(p427);
                append_packet(u418, v.mask.members, v430, p428);
            end;

            local v431 = v;

            for i, v2 in active do
                u422 = u419.offset;
                u423 = #u420;
                u424 = u421;
                local v432 = i;
                local v433 = 0;

                for i2 in v2.components[7] do
                    if world_has(world, v432, i2) then
                        local v434 = world_get(world, v432, i2);
                        u1.write_component_value(p417, u419, i2, v434, u420);
                        u1.write_component_id(p417, u419, i2);
                        v433 = v433 + 1;
                    end;
                end;

                if v433 > 0 then
                    u421 = u421 + 1;
                    cursor.write_vlq(u419, v433);
                    u1.write_entity_id(p417, u419, v432);

                    if u419.offset > 900 then
                        local v435 = u419;
                        local v436 = u420;
                        rollback_checkpoint();
                        local v437 = u424;

                        if v437 > 0 then
                            cursor.write_vlq(v435, v437);
                            local v438 = cursor.close(v435);
                            append_packet(u418, v431.mask.members, v438, v436);
                        end;
                    end;
                end;
            end;

            local v439 = u419;
            local v440 = u420;
            local v441 = u421;

            if v441 > 0 then
                cursor.write_vlq(v439, v441);
                local v442 = cursor.close(v439);
                append_packet(u418, v431.mask.members, v442, v440);
            end;
        end;
    end;

    return coroutine.wrap(function() -- Line: 1165
        -- upvalues: u418 (copy), utils (ref), combine_packet_outputs (ref)
        for i, v in u418 do
            if utils.is_client_valid(i) then
                table.sort(v.packets, function(p443, p444) -- Line: 1171
                    return buffer.len(p443.buffer) < buffer.len(p444.buffer);
                end);
                local v445 = #v.packets;
                local v446 = i;
                local v447 = v;
                local v448 = 1;

                while v448 <= v445 do
                    local v449 = 0;
                    local v450 = {};

                    while v448 <= v445 do
                        local v451 = v447.packets[v448];
                        local buffer_len_ret = buffer.len(v451.buffer);

                        if v449 + buffer_len_ret > 900 and #v450 > 0 then
                            break;
                        end;

                        table.insert(v450, v451);
                        v449 = v449 + buffer_len_ret;
                        v448 = v448 + 1;

                        if v449 >= 900 then
                            break;
                        end;
                    end;

                    if #v450 > 0 then
                        coroutine.yield(v446, combine_packet_outputs(v450, v449, 4));
                    end;
                end;
            end;
        end;
    end);
end;

function u1.start_networked(p452, p453, p454) -- Line: 1676
    -- upvalues: world_add (copy)
    local masking2 = p452.masking;
    masking2:deallocate_entity_stop(p453);
    masking2:start_entity(p453, p454);
    masking2:allocate_propagated_entity_start(p453);
    p452.additions[p453] = true;
    p452.track_info.networked[p453] = true;

    if p452.alive_tracked[p453] then
        return;
    end;

    p452.alive_tracked[p453] = true;
    world_add(p452.world, p453, p452.components.__alive_tracking__);
end;

function u1.start_reliable(p455, p456, p457, p458) -- Line: 1688
    -- upvalues: track_entity_component (copy)
    local masking2 = p455.masking;
    local v459 = track_entity_component(p455, p456, p457);
    masking2:deallocate_component_stop(p456, p457, v459);
    masking2:start_component(p456, p457, v459, p458);

    if p455.additions[p456] then
        masking2:allocate_shared_entity_start(p456, p457, v459);

        return;
    end;

    if p455.track_info.networked[p456] then
        masking2:allocate_component_start(p456, p457, v459);
    end;
end;

function u1.start_unreliable(p460, p461, p462, p463) -- Line: 1702
    -- upvalues: hook_component (copy), u3 (copy), add_entity_component_tracked (copy)
    local masking2 = p460.masking;
    (p460.track_info.components[p462] or hook_component(p460, p462))[p461] = u3.unreliable;
    add_entity_component_tracked(p460, p461, p462, u3.unreliable);
    masking2:deallocate_component_stop(p461, p462, 7);
    masking2:start_component(p461, p462, 7, p463);

    if p460.additions[p461] then
        masking2:allocate_shared_entity_start(p461, p462, 7);

        return;
    end;

    if p460.track_info.networked[p461] then
        masking2:allocate_component_start(p461, p462, 7);
    end;
end;

function u1.start_pair(p464, p465, p466, p467) -- Line: 1717
    -- upvalues: track_entity_pair (copy)
    local masking2 = p464.masking;
    local v468 = track_entity_pair(p464, p465, p466);
    masking2:deallocate_component_stop(p465, p466, v468);
    masking2:start_component(p465, p466, v468, p467);

    if p464.additions[p465] then
        masking2:allocate_shared_entity_start(p465, p466, v468);

        return;
    end;

    if p464.track_info.networked[p465] then
        masking2:allocate_component_start(p465, p466, v468);
    end;
end;

function u1.start_relation(p469, p470, p471, p472) -- Line: 1731
    -- upvalues: track_entity_relation (copy)
    local masking2 = p469.masking;
    local v473 = track_entity_relation(p469, p470, p471);
    masking2:deallocate_component_stop(p470, p471, v473);
    masking2:start_component(p470, p471, v473, p472);

    if p469.additions[p470] then
        masking2:allocate_shared_entity_start(p470, p471, v473);

        return;
    end;

    if p469.track_info.networked[p470] then
        masking2:allocate_component_start(p470, p471, v473);
    end;
end;

function u1.change_networked(p474, p475, p476) -- Line: 1745
    p474.masking:set_entity(p475, p476);
end;

function u1.change_reliable(p477, p478, p479, p480) -- Line: 1750
    -- upvalues: is_component (copy)
    local masking2 = p477.masking;

    if is_component(p477.world, p479) then
        masking2:set_component(p478, p479, 2, p480);

        return;
    end;

    masking2:set_component(p478, p479, 1, p480);
end;

function u1.change_unreliable(p481, p482, p483, p484) -- Line: 1761
    p481.masking:set_component(p482, p483, 7, p484);
end;

function u1.change_pair(p485, p486, p487, p488) -- Line: 1766
    -- upvalues: is_component (copy)
    local masking2 = p485.masking;

    if is_component(p485.world, p487) then
        masking2:set_component(p486, p487, 4, p488);

        return;
    end;

    masking2:set_component(p486, p487, 3, p488);
end;

function u1.change_relation(p489, p490, p491, p492) -- Line: 1777
    -- upvalues: is_component (copy)
    local masking2 = p489.masking;

    if is_component(p489.world, p491) then
        masking2:set_component(p490, p491, 6, p492);

        return;
    end;

    masking2:set_component(p490, p491, 5, p492);
end;

local function stop_tracked_component(p493: any, p494: any, p495: any, p496: number, p497: boolean?) -- Line: 1788
    local masking2 = p493.masking;

    if p493.track_info.networked[p494] then
        masking2:deallocate_component_start(p494, p495, p496);

        if not p497 then
            masking2:allocate_component_stop(p494, p495, p496);
        end;
    end;

    masking2:stop_component(p494, p495, p496);
end;

function u1.stop_networked(p498: any, p499: any, p500: boolean?) -- Line: 1805
    if not p498.track_info.networked[p499] then
        return;
    end;

    local masking2 = p498.masking;

    if not p500 then
        masking2:allocate_entity_stop(p499);
    end;

    masking2:stop_entity(p499);
    p498.additions[p499] = nil;
    p498.track_info.networked[p499] = nil;
end;

function u1.stop_reliable(p501: any, p502: any, p503: any, p504: boolean?) -- Line: 1820
    -- upvalues: stop_tracked_component (copy)
    if not p501.track_info.entities[p502] then
        return;
    end;

    local v505 = p501.track_info.components[p503];
    local v506;

    if v505 then
        v506 = v505[p502];
        v505[p502] = nil;
        local v507 = p501.storage[p502];

        if v507 then
            v507.components[p503] = nil;
            v507.tags[p503] = nil;
        end;

        local v508 = p501.track_info.entities[p502];

        if v508 then
            v508.components[p503] = nil;
        end;
    else
        v506 = nil;
    end;

    if not v506 then
        return;
    end;

    stop_tracked_component(p501, p502, p503, v506, p504);
end;

function u1.stop_unreliable(p509: any, p510: any, p511: any, p512: boolean?) -- Line: 1833
    -- upvalues: stop_tracked_component (copy)
    if not p509.track_info.entities[p510] then
        return;
    end;

    local v513 = p509.track_info.components[p511];
    local v514;

    if v513 then
        v514 = v513[p510];
        v513[p510] = nil;
        local v515 = p509.storage[p510];

        if v515 then
            v515.components[p511] = nil;
            v515.tags[p511] = nil;
        end;

        local v516 = p509.track_info.entities[p510];

        if v516 then
            v516.components[p511] = nil;
        end;
    else
        v514 = nil;
    end;

    if not v514 then
        return;
    end;

    stop_tracked_component(p509, p510, p511, 7, p512);
end;

function u1.stop_pair(p517: any, p518: any, p519: any, p520: boolean?) -- Line: 1846
    -- upvalues: stop_tracked_component (copy)
    if not p517.track_info.entities[p518] then
        return;
    end;

    local v521 = p517.track_info.pairs[p519];
    local v522;

    if v521 then
        v522 = v521[p518];
        v521[p518] = nil;
        local v523 = p517.storage[p518];

        if v523 then
            v523.pair_tags[p519] = nil;
            v523.pair_components[p519] = nil;
        end;

        local v524 = p517.track_info.entities[p518];

        if v524 then
            v524.pairs[p519] = nil;
        end;
    else
        v522 = nil;
    end;

    if not v522 then
        return;
    end;

    stop_tracked_component(p517, p518, p519, v522, p520);
end;

function u1.stop_relation(p525: any, p526: any, p527: any, p528: boolean?) -- Line: 1859
    -- upvalues: stop_tracked_component (copy)
    if not p525.track_info.entities[p526] then
        return;
    end;

    local v529 = p525.track_info.components[p527];
    local v530;

    if v529 then
        v530 = v529[p526];
        v529[p526] = nil;
        local v531 = p525.storage[p526];

        if v531 then
            v531.relations[p527] = nil;
            v531.relation_values[p527] = nil;
        end;

        local v532 = p525.track_info.entities[p526];

        if v532 then
            v532.components[p527] = nil;
        end;
    else
        v530 = nil;
    end;

    if not v530 then
        return;
    end;

    stop_tracked_component(p525, p526, p527, v530, p528);
end;

function u1.set_networked(p533, p534, p535) -- Line: 1872
    -- upvalues: u1 (copy)
    if p533.track_info.networked[p534] then
        u1.change_networked(p533, p534, p535);

        return;
    end;

    u1.start_networked(p533, p534, p535);
end;

function u1.set_reliable(p536, p537, p538, p539) -- Line: 1880
    -- upvalues: u1 (copy)
    local v540 = p536.track_info.entities[p537];

    if v540 and v540.components[p538] then
        u1.change_reliable(p536, p537, p538, p539);

        return;
    end;

    u1.start_reliable(p536, p537, p538, p539);
end;

function u1.set_unreliable(p541, p542, p543, p544) -- Line: 1889
    -- upvalues: u1 (copy)
    local v545 = p541.track_info.entities[p542];

    if v545 and v545.components[p543] then
        u1.change_unreliable(p541, p542, p543, p544);

        return;
    end;

    u1.start_unreliable(p541, p542, p543, p544);
end;

function u1.set_pair(p546, p547, p548, p549) -- Line: 1898
    -- upvalues: u1 (copy)
    local v550 = p546.track_info.entities[p547];

    if v550 and v550.pairs[p548] then
        u1.change_pair(p546, p547, p548, p549);

        return;
    end;

    u1.start_pair(p546, p547, p548, p549);
end;

function u1.set_relation(p551, p552, p553, p554) -- Line: 1907
    -- upvalues: u1 (copy)
    local v555 = p551.track_info.entities[p552];

    if v555 and v555.components[p553] then
        u1.change_relation(p551, p552, p553, p554);

        return;
    end;

    u1.start_relation(p551, p552, p553, p554);
end;

function u1.set_custom(p556, p557, p558) -- Line: 1916
    -- upvalues: common (copy)
    if p556.custom_ids[p557] then
        common.log_warn("attempted to register a custom_id twice for the same entity", debug.traceback());

        return;
    end;

    p556.custom_ids[p557] = p558;
end;

function u1.remove_custom(p559, p560) -- Line: 1924
    p559.custom_ids[p560] = nil;
end;

function u1.set_serdes(p561, p562, p563) -- Line: 1928
    p561.component_serdes[p562] = p563;
    p561.is_shared_dirty = true;
end;

function u1.remove_serdes(p564, p565) -- Line: 1933
    p564.component_serdes[p565] = nil;
    p564.is_shared_dirty = true;
end;

local function check_created(p566) -- Line: 1938
    if p566.inited == true then
        warn("attempted to init a server twice");

        return false;
    end;

    if p566.inited ~= nil then
        return true;
    end;

    warn("attempted to init a destroyed server");

    return false;
end;

function u1.init(u567, p568) -- Line: 1950
    -- upvalues: utils (copy), common (copy), hook_added (copy), u1 (copy), hook_changed (copy), hook_removed (copy), relationships (copy), listen_relation (copy), pair_second (copy), is_pair (copy), cleanup_entity (copy), QUERY_CURRENT_COMPONENTS (copy), QUERY_CURRENT_NETWORKED (copy)
    local v569;

    if u567.inited == true then
        warn("attempted to init a server twice");
        v569 = false;
    elseif u567.inited == nil then
        warn("attempted to init a destroyed server");
        v569 = false;
    else
        v569 = true;
    end;

    if not v569 then
        return;
    end;

    u567.inited = true;
    local u570 = p568 or u567.world;
    u567.world = u570;

    if not u570 then
        error("Providing a world is required to start replecs");
    end;

    if not u567.components then
        u567.components = utils.create_components(utils.tag_factory(u570), utils.component_factory(u570));
        utils.add_component_names(u567.components, function(p571, p572) -- Line: 1965
            -- upvalues: common (ref), u570 (copy)
            common.add_name(u570, p571, p572);
        end);
    end;

    local components = u567.components;

    local function _(p573: function) -- Line: 1972
        -- upvalues: u567 (copy)
        table.insert(u567.hooked, p573);
    end;

    local v577 = hook_added(u570, components.networked, function(p574, p575, p576) -- Line: 1976
        -- upvalues: u1 (ref), u567 (copy)
        u1.start_networked(u567, p574, p576);
    end);
    table.insert(u567.hooked, v577);
    local v581 = hook_changed(u570, components.networked, function(p578, p579, p580) -- Line: 1979
        -- upvalues: u1 (ref), u567 (copy)
        u1.change_networked(u567, p578, p580);
    end);
    table.insert(u567.hooked, v581);
    local v583 = hook_removed(u570, components.networked, function(p582) -- Line: 1982
        -- upvalues: u1 (ref), u567 (copy)
        u1.stop_networked(u567, p582);
    end);
    table.insert(u567.hooked, v583);

    if relationships then
        local v588 = hook_added(u570, listen_relation(components.reliable), function(p584, p585, p586) -- Line: 1987
            -- upvalues: pair_second (ref), u570 (copy), u1 (ref), u567 (copy)
            local v587 = pair_second(u570, p585);
            u1.start_reliable(u567, p584, v587, p586);
        end);
        table.insert(u567.hooked, v588);
        local v593 = hook_changed(u570, listen_relation(components.reliable), function(p589, p590, p591) -- Line: 1991
            -- upvalues: pair_second (ref), u570 (copy), u1 (ref), u567 (copy)
            local v592 = pair_second(u570, p590);
            u1.change_reliable(u567, p589, v592, p591);
        end);
        table.insert(u567.hooked, v593);
        local v597 = hook_removed(u570, listen_relation(components.reliable), function(p594, p595) -- Line: 1995
            -- upvalues: pair_second (ref), u570 (copy), u1 (ref), u567 (copy)
            local v596 = pair_second(u570, p595);
            u1.stop_reliable(u567, p594, v596);
        end);
        table.insert(u567.hooked, v597);
        local v602 = hook_added(u570, listen_relation(components.relation), function(p598, p599, p600) -- Line: 2000
            -- upvalues: pair_second (ref), u570 (copy), u1 (ref), u567 (copy)
            local v601 = pair_second(u570, p599);
            u1.start_relation(u567, p598, v601, p600);
        end);
        table.insert(u567.hooked, v602);
        local v607 = hook_changed(u570, listen_relation(components.relation), function(p603, p604, p605) -- Line: 2004
            -- upvalues: pair_second (ref), u570 (copy), u1 (ref), u567 (copy)
            local v606 = pair_second(u570, p604);
            u1.change_relation(u567, p603, v606, p605);
        end);
        table.insert(u567.hooked, v607);
        local v611 = hook_removed(u570, listen_relation(components.relation), function(p608, p609) -- Line: 2008
            -- upvalues: pair_second (ref), u570 (copy), u1 (ref), u567 (copy)
            local v610 = pair_second(u570, p609);
            u1.stop_relation(u567, p608, v610);
        end);
        table.insert(u567.hooked, v611);
        local v616 = hook_added(u570, listen_relation(components.unreliable), function(p612, p613, p614) -- Line: 2013
            -- upvalues: pair_second (ref), u570 (copy), u1 (ref), u567 (copy)
            local v615 = pair_second(u570, p613);
            u1.start_unreliable(u567, p612, v615, p614);
        end);
        table.insert(u567.hooked, v616);
        local v621 = hook_changed(u570, listen_relation(components.unreliable), function(p617, p618, p619) -- Line: 2017
            -- upvalues: pair_second (ref), u570 (copy), u1 (ref), u567 (copy)
            local v620 = pair_second(u570, p618);
            u1.change_unreliable(u567, p617, v620, p619);
        end);
        table.insert(u567.hooked, v621);
        local v625 = hook_removed(u570, listen_relation(components.unreliable), function(p622, p623) -- Line: 2021
            -- upvalues: pair_second (ref), u570 (copy), u1 (ref), u567 (copy)
            local v624 = pair_second(u570, p623);
            u1.stop_unreliable(u567, p622, v624);
        end);
        table.insert(u567.hooked, v625);
        local v629 = hook_added(u570, listen_relation(components.custom), function(p626, p627) -- Line: 2026
            -- upvalues: is_pair (ref), common (ref), pair_second (ref), u570 (copy), u1 (ref), u567 (copy)
            if not is_pair(p627) then
                common.log_error("replecs.custom should be used with a relationship in the server");
            end;

            local v628 = pair_second(u570, p627);
            u1.set_custom(u567, p626, v628);
        end);
        table.insert(u567.hooked, v629);
        local v631 = hook_removed(u570, listen_relation(components.custom), function(p630) -- Line: 2033
            -- upvalues: u1 (ref), u567 (copy)
            u1.remove_custom(u567, p630);
        end);
        table.insert(u567.hooked, v631);
    end;

    local v635 = hook_added(u570, components.global, function(p632, p633, p634) -- Line: 2037
        -- upvalues: common (ref), u567 (copy)
        if p634 > 245 then
            common.log_error("global id size exceeded, max is 245");
        end;

        u567.global_ids[p632] = p634;
    end);
    table.insert(u567.hooked, v635);
    local v639 = hook_changed(u570, components.global, function(p636, p637, p638) -- Line: 2044
        -- upvalues: common (ref), u567 (copy)
        if p638 > 245 then
            common.log_error("global id size exceeded, max is 245");
        end;

        u567.global_ids[p636] = p638;
    end);
    table.insert(u567.hooked, v639);
    local v641 = hook_removed(u570, components.global, function(p640) -- Line: 2050
        -- upvalues: u567 (copy)
        u567.global_ids[p640] = nil;
    end);
    table.insert(u567.hooked, v641);
    local v645 = hook_added(u570, components.serdes, function(p642, p643, p644) -- Line: 2054
        -- upvalues: u1 (ref), u567 (copy)
        u1.set_serdes(u567, p642, p644);
    end);
    table.insert(u567.hooked, v645);
    local v649 = hook_changed(u570, components.serdes, function(p646, p647, p648) -- Line: 2057
        -- upvalues: u1 (ref), u567 (copy)
        u1.set_serdes(u567, p646, p648);
    end);
    table.insert(u567.hooked, v649);
    local v651 = hook_removed(u570, components.serdes, function(p650) -- Line: 2060
        -- upvalues: u1 (ref), u567 (copy)
        u1.remove_serdes(u567, p650);
    end);
    table.insert(u567.hooked, v651);
    local v653 = hook_removed(u570, components.__alive_tracking__, function(p652) -- Line: 2064
        -- upvalues: u567 (copy), u1 (ref), cleanup_entity (ref)
        if u567.track_info.networked[p652] then
            u1.stop_networked(u567, p652);
        end;

        cleanup_entity(u567, p652);
    end);
    table.insert(u567.hooked, v653);

    for _, v in u567.requires_shared_lookup do
        local v654 = hook_added(u570, v, function() -- Line: 2072
            -- upvalues: u567 (copy)
            u567.is_shared_dirty = true;
        end);
        table.insert(u567.hooked, v654);
        local v655 = hook_changed(u570, v, function() -- Line: 2075
            -- upvalues: u567 (copy)
            u567.is_shared_dirty = true;
        end);
        table.insert(u567.hooked, v655);
        local v656 = hook_removed(u570, v, function() -- Line: 2078
            -- upvalues: u567 (copy)
            u567.is_shared_dirty = true;
        end);
        table.insert(u567.hooked, v656);
    end;

    QUERY_CURRENT_COMPONENTS(u567);
    QUERY_CURRENT_NETWORKED(u567);
    u567.shared = utils.resolved_shared(u570, components, u567.registered_custom_ids, u567.component_serdes);

    if game and game:GetService("RunService"):IsServer() then
        local Players = game:GetService("Players");
        local v658 = Players.PlayerAdded:Connect(function(p657) -- Line: 2091
            -- upvalues: u567 (copy)
            u567.masking:register_client(p657);
        end);
        local v660 = Players.PlayerRemoving:Connect(function(p659) -- Line: 2094
            -- upvalues: u567 (copy)
            u567.masking:unregister_client(p659);
        end);

        for _, v in Players:GetPlayers() do
            u567.masking:register_client(v);
        end;

        table.insert(u567.connections, v658);
        table.insert(u567.connections, v660);
    end;
end;

function u1.encode_component(p661, p662) -- Line: 2106
    -- upvalues: u1 (copy), common (copy)
    u1.resolve_dirty(p661);
    local v663 = p661.shared.components.members[p662];

    if v663 then
        return v663;
    end;

    common.log_error("attempted to encode a non-shared component ", common.log_component(p661.world, p662));

    return 0;
end;

function u1.decode_component(p664: any, p665: number) -- Line: 2116
    -- upvalues: u1 (copy)
    u1.resolve_dirty(p664);

    return p664.shared.components.indexes[p665];
end;

function u1.get_shared_count(p666) -- Line: 2122
    -- upvalues: u1 (copy)
    u1.resolve_dirty(p666);

    return #p666.shared.components.keys;
end;

function u1.mark_player_ready(p667: any, p668: userdata) -- Line: 2127
    p667.masking:activate_client(p668);
end;

function u1.is_player_ready(p669: any, p670: userdata) -- Line: 2131
    return p669.masking:member_is_active(p670);
end;

function u1.add_player_alias(p671: any, p672: userdata, p673: any) -- Line: 2135
    p671.masking.client_aliases[p673] = p672;
end;

function u1.remove_player_alias(p674, p675) -- Line: 2139
    p674.masking.client_aliases[p675] = nil;
end;

function u1.register_custom_id(p676, p677) -- Line: 2143
    p676.registered_custom_ids[p677] = true;
    p676.is_shared_dirty = true;
end;

function u1.generate_handshake(p678) -- Line: 2148
    -- upvalues: u1 (copy), utils (copy)
    u1.resolve_dirty(p678);

    return utils.generate_handshake(p678.shared);
end;

function u1.verify_handshake(p679, p680) -- Line: 2153
    -- upvalues: u1 (copy), utils (copy)
    u1.resolve_dirty(p679);

    return utils.verify_handshake(p679.shared, p680, "client", "server");
end;

function u1.destroy(p681) -- Line: 2158
    if p681.inited == nil then
        return warn("attempted to destroy a server twice");
    end;

    p681.inited = nil;

    for _, v in p681.hooked do
        v();
    end;

    for _, v in p681.connections do
        v:Disconnect();
    end;
end;

return {
    create = function(u682, p683) -- Line: 2172, Name: create
        -- upvalues: utils (copy), common (copy), masking (copy), ecs_name (copy), u1 (copy)
        local v684 = {};

        if p683 then
            v684.components = p683;
        elseif u682 then
            v684.components = utils.create_components(utils.tag_factory(u682), utils.component_factory(u682));
            utils.add_component_names(v684.components, function(p685, p686) -- Line: 2179
                -- upvalues: common (ref), u682 (copy)
                common.add_name(u682, p685, p686);
            end);
        end;

        v684.shared = {};
        v684.world = u682;
        v684.additions = {};
        v684.storage = {};
        v684.hooked = {};
        v684.is_shared_dirty = false;
        v684.global_ids = {};
        v684.pending_cleanups = {};
        v684.track_info = {
            networked = {},
            entities = {},
            components = {},
            pairs = {}
        };
        v684.connections = {};
        v684.inited = false;
        v684.masking = masking.create();
        v684.alive_tracked = {};
        v684.custom_ids = {};
        v684.registered_custom_ids = {};
        v684.component_serdes = {};
        v684.requires_shared_lookup = { v684.components.shared, ecs_name };

        return setmetatable(v684, u1);
    end,

    server_replicator = u1
};