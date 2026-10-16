-- Decompiled with Potassium's decompiler.

local common = require(script.Parent:WaitForChild("common"));
local utils = require(script.Parent:WaitForChild("utils"));
local mask_generator = require(script:WaitForChild("mask_generator"));
local u1 = {
    tag = 1,
    component = 2,
    pair_tag = 3,
    pair_component = 4,
    relation = 5,
    relation_component = 6,
    unreliable = 7,
    unreliable_pair = 8
};
local unreliable = u1.unreliable;
local u2 = {};
u2.__index = u2;

function u2.get_clients_from_bitmask(p3, p4) -- Line: 164
    local v5 = {};

    for i, v in p3.client_indexes do
        if p4:get(v) then
            table.insert(v5, i);
        end;
    end;

    return v5;
end;

local function get_usable_filter(p6) -- Line: 174
    if p6 then
        return type(p6) ~= "table" and {
            [p6] = true
        } or p6;
    end;

    return nil;
end;

local function create_component_indexes() -- Line: 186
    -- upvalues: unreliable (copy)
    local v7 = {};

    for i = 1, unreliable do
        v7[i] = {};
        local _ = i;
    end;

    return v7;
end;

local function create_entity_changes() -- Line: 194
    -- upvalues: create_component_indexes (copy), u1 (copy)
    local v8 = {};
    local v9 = {};
    local v10 = {};
    local v11 = {};
    local v12 = {};
    local v13 = {};
    local v14 = {};
    local v15 = {};
    local v16 = {};
    local v17 = {};
    local v18 = {};
    local v19 = {};
    local v20 = {};
    local v21 = {};
    local v22 = {};
    local v23 = {};
    local v24 = create_component_indexes();
    local v25 = create_component_indexes();
    v24[u1.tag] = v16;
    v24[u1.component] = v17;
    v24[u1.unreliable] = v18;
    v24[u1.unreliable_pair] = v19;
    v24[u1.pair_tag] = v20;
    v24[u1.pair_component] = v21;
    v24[u1.relation] = v22;
    v24[u1.relation_component] = v23;
    v25[u1.tag] = v8;
    v25[u1.component] = v9;
    v25[u1.unreliable] = v10;
    v25[u1.unreliable_pair] = v11;
    v25[u1.pair_tag] = v12;
    v25[u1.pair_component] = v13;
    v25[u1.relation] = v14;
    v25[u1.relation_component] = v15;

    return {
        removed = v25,
        changed = v24,
        tag_removed = v8,
        component_removed = v9,
        unreliable_removed = v10,
        unreliable_pair_removed = v11,
        pair_tag_removed = v12,
        pair_component_removed = v13,
        relation_tag_removed = v14,
        relation_component_removed = v15,
        tag_added = v16,
        component_changed = v17,
        unreliable_added = v18,
        unreliable_pair_added = v19,
        pair_tag_added = v20,
        pair_component_changed = v21,
        relation_tag_added = v22,
        relation_component_changed = v23
    };
end;

function u2.create_new_storage(p26: any, p27: any, p28: string?, p29: table?) -- Line: 264
    return {
        is_empty = true,
        active_count = 0,
        deletions_count = 0,
        mask = {
            bitmask = p27,
            hash = p28 or p27:tostring(),
            members = p29 or p26:get_clients_from_bitmask(p27)
        },
        shared_with = {},
        changes = {
            added = {},
            added_components = {},
            changed = {}
        },
        active = {},
        deletions = {
            entities = {},
            components = {}
        }
    };
end;

local function is_include_filter(p30: table) -- Line: 296
    local v31, v32, v33;
    v31, v32, v33 = p30, nil, nil;
    local v34, v35, v36;

    if type(v31) == "function" then
        v34, v35 = v31(v32, v36);
    else
        v34, v35 = next(v31, v36);
    end;

    v36 = v34;

    return v35 and true or false;
end;

local function create_new_active() -- Line: 306
    -- upvalues: create_component_indexes (copy)
    return {
        component_count = 0,
        is_entity_mask = false,
        components = create_component_indexes()
    };
end;

function u2.get_component_index_entry(p37: table, p38: any, p39: any, p40: number) -- Line: 314
    local v41 = p37[p38];

    if v41 == nil then
        return nil;
    end;

    local v42 = v41[p40];

    if v42 then
        v42 = v42[p39];
    end;

    return v42;
end;

function u2.set_component_index_entry(p43: table, p44: any, p45: any, p46: number, p47: any) -- Line: 329
    -- upvalues: create_component_indexes (copy)
    local v48 = p43[p44];

    if v48 == nil then
        v48 = create_component_indexes();
        p43[p44] = v48;
    end;

    v48[p46][p45] = p47;
end;

function u2.remove_component_index_entry(p49: table, p50: any, p51: any, p52: number) -- Line: 344
    local v53 = p49[p50];

    if v53 == nil then
        return;
    end;

    v53[p52][p51] = nil;
end;

function u2.get_bitmask_deltas(p54, p55) -- Line: 357
    return p55:band(p54:bnot()), p54:band(p55:bnot());
end;

function u2.merge_bitmask_deltas(p56, p57, p58, p59) -- Line: 363
    local v60 = p56:bor(p58);
    local v61 = p57:bor(p59);
    local v62 = v60:band(v61):bnot();

    return v60:band(v62), v61:band(v62);
end;

local function get_or_set_changed(p63: table, p64: any, p65: table?) -- Line: 379
    -- upvalues: create_entity_changes (copy)
    local v66 = p63.changes.changed[p64];

    if v66 == nil then
        v66 = p65 or create_entity_changes();
        p63.changes.changed[p64] = v66;
    end;

    return v66;
end;

local function get_or_set_active(p67: table, p68: any, p69: table?) -- Line: 388
    -- upvalues: create_component_indexes (copy)
    local v70 = p67.active[p68];

    if v70 == nil then
        v70 = p69 or {
            component_count = 0,
            is_entity_mask = false,
            components = create_component_indexes()
        };
        p67.active[p68] = v70;
        p67.active_count = p67.active_count + 1;
    end;

    return v70;
end;

local function get_or_set_component_added(p71: table, p72: any, p73: table?) -- Line: 398
    -- upvalues: create_component_indexes (copy)
    local v74 = p71.changes.added_components[p72];

    if v74 == nil then
        v74 = p73 or create_component_indexes();
        p71.changes.added_components[p72] = v74;
    end;

    return v74;
end;

local function remove_active(p75: table, p76: any) -- Line: 411
    -- upvalues: common (copy)
    local v77 = p75.active[p76];

    if not v77 then
        return common.log_error("attempted to remove an entity that wasn\'t active");
    end;

    p75.active[p76] = nil;
    p75.active_count = p75.active_count - 1;

    return v77;
end;

local function set_component_active(p78: table, p79: any, p80: number) -- Line: 422
    local v81 = p78.components[p80];

    if v81[p79] == nil then
        v81[p79] = true;
        p78.component_count = p78.component_count + 1;
    end;
end;

local function remove_component_active(p82: table, p83: any, p84: any, p85: number) -- Line: 430
    -- upvalues: common (copy)
    local v86 = p82.active[p83];

    if not v86 then
        return;
    end;

    local v87 = v86.components[p85];

    if v87[p84] then
        v87[p84] = nil;
        v86.component_count = v86.component_count - 1;

        if v86.component_count <= 0 and not v86.is_entity_mask then
            if p82.active[p83] then
                p82.active[p83] = nil;
                p82.active_count = p82.active_count - 1;

                return;
            end;

            common.log_error("attempted to remove an entity that wasn\'t active");
        end;
    end;
end;

function u2.get_or_create_storage_group(p88, p89) -- Line: 452
    local v90 = p89:tostring();
    local v91 = p88.storages[v90];

    if not v91 then
        v91 = p88:create_new_storage(p89, v90);
        p88.storages[v90] = v91;
    end;

    return v91;
end;

function u2.get_component_lookup(p92: any, p93: any, p94: any, p95: number) -- Line: 463
    local v96 = p92.lookups.entities[p93];

    if v96 then
        return v96.filtered_components[p95][p94], v96;
    end;

    return nil;
end;

local function dissect_component_actives(p97: table, p98: any, p99: table) -- Line: 477
    -- upvalues: create_component_indexes (copy), common (copy)
    local v100 = nil;

    for i, v in p97.active[p98].components do
        local v101 = i;

        for i2 in v do
            if p99[v101] and p99[v101][i2] then
                v100 = v100 or {
                    component_count = 0,
                    is_entity_mask = false,
                    components = create_component_indexes()
                };
                local v102 = v100.components[v101];

                if v102[i2] == nil then
                    v102[i2] = true;
                    v100.component_count = v100.component_count + 1;
                end;

                local v103 = p97.active[p98];

                if v103 then
                    local v104 = v103.components[v101];

                    if v104[i2] then
                        v104[i2] = nil;
                        v103.component_count = v103.component_count - 1;

                        if v103.component_count <= 0 and not v103.is_entity_mask then
                            if p97.active[p98] then
                                p97.active[p98] = nil;
                                p97.active_count = p97.active_count - 1;
                            else
                                common.log_error("attempted to remove an entity that wasn\'t active");
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v100;
end;

local function dissect_component_additions(p105: table, p106: table) -- Line: 499
    -- upvalues: create_component_indexes (copy)
    local v107 = nil;

    for i, v in p105 do
        local v108 = i;

        for i2 in v do
            if p106[v108] and p106[v108][i2] then
                v107 = v107 or create_component_indexes();
                v107[v108][i2] = true;
                p105[v108][i2] = nil;
            end;
        end;
    end;

    return v107;
end;

local function dissect_component_changes(p109: table, p110: table) -- Line: 515
    -- upvalues: create_entity_changes (copy)
    local v111 = nil;
    local v112 = nil;
    local v113 = nil;

    for i, v in p109.changed do
        local v114 = p110[i];
        local v115 = v;
        local v116 = i;

        for i2, v2 in v do
            local v117;

            if v114 then
                v117 = v114[i2];
            else
                v117 = v114;
            end;

            if v117 then
                if v111 then
                    v111[v116][i2] = v2;
                    v115[i2] = nil;
                else
                    v113 = create_entity_changes();
                    v111 = v113.changed;
                    v112 = v113.removed;
                end;
            end;
        end;
    end;

    for i, v in p109.removed do
        local v118 = p110[i];
        local v119 = v;
        local v120 = i;

        for i2 in v do
            local v121;

            if v118 then
                v121 = v118[i2];
            else
                v121 = v118;
            end;

            if v121 then
                if v112 then
                    v112[v120][i2] = true;
                    v119[i2] = nil;
                else
                    v113 = create_entity_changes();
                    local _ = v113.changed;
                    v112 = v113.removed;
                end;
            end;
        end;
    end;

    return v113;
end;

local function merge_component_actives(p122: table, p123: table) -- Line: 561
    for i, v in p122.components do
        local v124 = i;

        for i2 in v do
            local v125 = p123.components[v124];

            if v125[i2] == nil then
                v125[i2] = true;
                p123.component_count = p123.component_count + 1;
            end;
        end;
    end;
end;

local function merge_component_additions(p126: table, p127: table) -- Line: 569
    for i, v in p126 do
        local v128 = i;

        for i2 in v do
            p127[v128][i2] = true;
        end;
    end;
end;

local function merge_component_changes(p129: table, p130: table) -- Line: 577
    local changed = p130.changed;
    local removed = p130.removed;

    for i, v in p129.changed do
        local v131 = changed[i];

        for i2, v2 in v do
            v131[i2] = v2;
        end;
    end;

    for i, v in p129.removed do
        local v132 = removed[i];

        for i2, v2 in v do
            v132[i2] = v2;
        end;
    end;
end;

function u2.merge_component_filter(p133: any, p134: any, p135: any, p136: number) -- Line: 597
    -- upvalues: common (copy)
    local _component_lookup, v137 = p133:get_component_lookup(p134, p135, p136);

    if not v137 then
        common.log_error("attempted to merge a component filter to an unactive entity");
    end;

    if _component_lookup == nil then
        local v138 = v137.storage_group.active[p134];
        local v139 = v138.components[p136];

        if v139[p135] == nil then
            v139[p135] = true;
            v138.component_count = v138.component_count + 1;
        end;
    else
        local v140 = p133:move_component_storage(p134, p135, p136, _component_lookup.storage_group, v137.generator.result);
        v137.filtered_components[p136][p135] = nil;
        local v141 = v140.shared_with[p134];

        if v141 ~= nil then
            v141[p136][p135] = nil;
        end;
    end;

    v137.components[p136][p135] = true;
end;

function u2.move_entity_storage(p142: any, p143: any, p144: table, p145: any) -- Line: 624
    -- upvalues: create_component_indexes (copy), dissect_component_actives (copy), common (copy), merge_component_actives (copy), dissect_component_additions (copy), merge_component_additions (copy), create_entity_changes (copy), dissect_component_changes (copy), merge_component_changes (copy)
    local _or_create_storage_group = p142:get_or_create_storage_group(p145);

    if _or_create_storage_group == p144 then
        return p144;
    end;

    local v146 = p144.shared_with[p143];
    local v147 = p144.active[p143];
    local v148 = _or_create_storage_group.active[p143];

    if v148 == nil then
        v148 = v147 or {
            component_count = 0,
            is_entity_mask = false,
            components = create_component_indexes()
        };
        _or_create_storage_group.active[p143] = v148;
        _or_create_storage_group.active_count = _or_create_storage_group.active_count + 1;
    end;

    v148.is_entity_mask = true;

    if v146 then
        local v149 = dissect_component_actives(p144, p143, v146);

        if v149 then
            p144.active[p143] = v149;
        elseif p144.active[p143] then
            p144.active[p143] = nil;
            p144.active_count = p144.active_count - 1;
        else
            common.log_error("attempted to remove an entity that wasn\'t active");
        end;
    elseif p144.active[p143] then
        p144.active[p143] = nil;
        p144.active_count = p144.active_count - 1;
    else
        common.log_error("attempted to remove an entity that wasn\'t active");
    end;

    if v147 ~= v148 then
        merge_component_actives(v147, v148);
    end;

    local v150 = p144.changes.added_components[p143];

    if v150 then
        local v151 = _or_create_storage_group.changes.added_components[p143];

        if v151 == nil then
            v151 = v150 or create_component_indexes();
            _or_create_storage_group.changes.added_components[p143] = v151;
        end;

        if v146 then
            local v152 = dissect_component_additions(v150, v146);

            if v152 then
                p144.changes.added_components[p143] = v152;
            else
                p144.changes.added_components[p143] = nil;
            end;
        end;

        if v150 ~= v151 then
            merge_component_additions(v150, v151);
        end;
    end;

    local v153 = p144.changes.changed[p143];

    if v153 then
        local v154 = _or_create_storage_group.changes.changed[p143];

        if v154 == nil then
            v154 = v153 or create_entity_changes();
            _or_create_storage_group.changes.changed[p143] = v154;
        end;

        if v146 then
            local v155 = dissect_component_changes(v153, v146);

            if v155 then
                p144.changes.changed[p143] = v155;
            else
                p144.changes.changed[p143] = nil;
            end;
        end;

        if v153 ~= v154 then
            merge_component_changes(v153, v154);
        end;
    end;

    if p144.changes.added[p143] then
        _or_create_storage_group.changes.added[p143] = true;
        p144.changes.added[p143] = nil;
    end;

    return _or_create_storage_group;
end;

function u2.move_component_storage(p156: any, p157: any, p158: any, p159: number, p160: table, p161: any) -- Line: 700
    -- upvalues: create_component_indexes (copy), common (copy), create_entity_changes (copy)
    local _or_create_storage_group = p156:get_or_create_storage_group(p161);

    if _or_create_storage_group == p160 then
        return p160;
    end;

    local v162 = _or_create_storage_group.active[p157];

    if v162 == nil then
        v162 = {
            component_count = 0,
            is_entity_mask = false,
            components = create_component_indexes()
        };
        _or_create_storage_group.active[p157] = v162;
        _or_create_storage_group.active_count = _or_create_storage_group.active_count + 1;
    end;

    local v163 = p160.active[p157];

    if v163 then
        local v164 = v163.components[p159];

        if v164[p158] then
            v164[p158] = nil;
            v163.component_count = v163.component_count - 1;

            if v163.component_count <= 0 and not v163.is_entity_mask then
                if p160.active[p157] then
                    p160.active[p157] = nil;
                    p160.active_count = p160.active_count - 1;
                else
                    common.log_error("attempted to remove an entity that wasn\'t active");
                end;
            end;
        end;
    end;

    local v165 = v162.components[p159];

    if v165[p158] == nil then
        v165[p158] = true;
        v162.component_count = v162.component_count + 1;
    end;

    local shared_with = _or_create_storage_group.shared_with;
    local v166 = shared_with[p157];

    if v166 == nil then
        v166 = create_component_indexes();
        shared_with[p157] = v166;
    end;

    v166[p159][p158] = true;
    local v167 = p160.shared_with[p157];

    if v167 ~= nil then
        v167[p159][p158] = nil;
    end;

    local v168 = p160.changes.added_components[p157];
    local v169;

    if v168 == nil then
        v169 = nil;
    else
        v169 = v168[p159];

        if v169 then
            v169 = v169[p158];
        end;
    end;

    if v169 then
        local v170 = p160.changes.added_components[p157];

        if v170 ~= nil then
            v170[p159][p158] = nil;
        end;

        local added_components = _or_create_storage_group.changes.added_components;
        local v171 = added_components[p157];

        if v171 == nil then
            v171 = create_component_indexes();
            added_components[p157] = v171;
        end;

        v171[p159][p158] = true;
    end;

    local v172 = p160.changes.changed[p157];

    if v172 then
        local v173 = _or_create_storage_group.changes.changed[p157];

        if v173 == nil then
            v173 = create_entity_changes();
            _or_create_storage_group.changes.changed[p157] = v173;
        end;

        v173.changed[p159][p158] = v172.changed[p159][p158];
        v173.removed[p159][p158] = v172.removed[p159][p158];
        v172.changed[p159][p158] = nil;
        v172.removed[p159][p158] = nil;
    end;

    return _or_create_storage_group;
end;

function u2.bind_component_generator(u174: any, u175: any, u176: any, u177: number, u178: any) -- Line: 741
    -- upvalues: mask_generator (copy)
    local _component_lookup, u179 = u174:get_component_lookup(u175, u176, u177);
    local u180 = mask_generator.create(nil, function() -- Line: 749
        -- upvalues: u179 (copy), u178 (copy)
        return u179.generator.result:band(u178.result);
    end);

    local function subscribed() -- Line: 753
        -- upvalues: _component_lookup (ref), u179 (copy), u177 (copy), u176 (copy), u174 (copy), u175 (copy), u180 (copy)
        if not _component_lookup then
            _component_lookup = u179.filtered_components[u177][u176];
        end;

        _component_lookup.storage_group = u174:move_component_storage(u175, u176, u177, _component_lookup.storage_group, u180.result);
    end;

    u180:track(u178);
    u180:track(u174.active_members_generator);
    u180.subscribed = subscribed;

    return u180;
end;

function u2.rebind_component_generators(p181, p182) -- Line: 772
    local v183 = p181.lookups.entities[p182];

    if v183 then
        for i, v in v183.filtered_components do
            local v184 = i;

            for i2, v2 in v do
                v2.band_generator:destroy();
                local v185 = p181:bind_component_generator(p182, i2, v184, v2.generator);
                v2.band_generator = v185;
                v185:run_subscribed();
            end;
        end;
    end;
end;

function u2.get_or_postpone_entity_lookup(p186: any, p187: any, p188: any, p189: number, p190: table?) -- Line: 788
    -- upvalues: create_component_indexes (copy)
    local v191 = p186.lookups.entities[p187];

    if v191 then
        return v191;
    end;

    if p190 == nil then
        local postponed = p186.lookups.postponed;
        local v192 = {
            filter = nil
        };
        local v193 = postponed[p187];

        if v193 == nil then
            v193 = create_component_indexes();
            postponed[p187] = v193;
        end;

        v193[p189][p188] = v192;
    else
        local postponed = p186.lookups.postponed;
        local v194 = {
            filter = p190
        };
        local v195 = postponed[p187];

        if v195 == nil then
            v195 = create_component_indexes();
            postponed[p187] = v195;
        end;

        v195[p189][p188] = v194;
    end;

    return nil;
end;

function u2.update_entity_filter(u196: any, u197: any, p198: table?) -- Line: 809
    -- upvalues: mask_generator (copy)
    local u199;

    if p198 then
        u199 = u196:create_generator_from_filter(p198);
    else
        u199 = mask_generator.follow(u196.active_members_generator);
    end;

    local u200 = u196.lookups.entities[u197];

    function u199.subscribed() -- Line: 823
        -- upvalues: u200 (ref), u196 (copy), u197 (copy), u199 (ref)
        if not u200 then
            u200 = u196.lookups.entities[u197];
        end;

        u200.storage_group = u196:move_entity_storage(u197, u200.storage_group, u199.result);
    end;

    return u199;
end;

function u2.start_entity(p201, p202, p203) -- Line: 836
    -- upvalues: create_component_indexes (copy)
    local v204;

    if p203 then
        v204 = type(p203) ~= "table" and {
            [p203] = true
        } or p203;
    else
        v204 = nil;
    end;

    local v205 = p201:update_entity_filter(p202, v204);
    local _or_create_storage_group = p201:get_or_create_storage_group(v205.result);
    local v206 = _or_create_storage_group.active[p202];

    if v206 == nil then
        v206 = {
            component_count = 0,
            is_entity_mask = false,
            components = create_component_indexes()
        };
        _or_create_storage_group.active[p202] = v206;
        _or_create_storage_group.active_count = _or_create_storage_group.active_count + 1;
    end;

    v206.is_entity_mask = true;
    local v207 = {
        generator = v205,
        filter = v204,
        storage_group = _or_create_storage_group,
        filtered_components = create_component_indexes(),
        components = create_component_indexes()
    };
    p201.lookups.entities[p202] = v207;
    local v208 = p201.lookups.postponed[p202];

    if v208 then
        for i, v in v208 do
            local v209 = i;

            for i2, v2 in v do
                p201:start_component(p202, i2, v209, v2.filter);
            end;
        end;

        p201.lookups.postponed[p202] = nil;
    end;
end;

function u2.set_entity(p210, p211, p212) -- Line: 864
    -- upvalues: common (copy)
    local v213;

    if p212 then
        v213 = type(p212) ~= "table" and {
            [p212] = true
        } or p212;
    else
        v213 = nil;
    end;

    local v214 = p210.lookups.entities[p211];

    if not v214 then
        common.log_error("attempted to modify the filter of an unactive entity");
    end;

    v214.generator:destroy();
    local v215 = p210:update_entity_filter(p211, v213);
    v214.generator = v215;
    v214.filter = v213;
    v215:run_subscribed();
    p210:rebind_component_generators(p211);
end;

function u2.stop_entity(p216, p217) -- Line: 881
    -- upvalues: common (copy), create_component_indexes (copy)
    local v218 = p216.lookups.entities[p217];

    if not v218 then
        common.log_error("attemped to stop an unactive entity");
    end;

    local v219 = p216.lookups.postponed[p217];

    for i, v in v218.filtered_components do
        local v220 = i;

        for i2, v2 in v do
            v2.band_generator:destroy();
            v2.generator:destroy();
            local storage_group = v2.storage_group;
            local v221 = storage_group.active[p217];

            if v221 then
                local v222 = v221.components[v220];

                if v222[i2] then
                    v222[i2] = nil;
                    v221.component_count = v221.component_count - 1;

                    if v221.component_count <= 0 and not v221.is_entity_mask then
                        if storage_group.active[p217] then
                            storage_group.active[p217] = nil;
                            storage_group.active_count = storage_group.active_count - 1;
                        else
                            common.log_error("attempted to remove an entity that wasn\'t active");
                        end;
                    end;
                end;
            end;

            local storage_group2 = v2.storage_group;
            storage_group2.shared_with[p217] = nil;
            storage_group2.changes.added[p217] = nil;
            storage_group2.changes.changed[p217] = nil;
            storage_group2.changes.added_components[p217] = nil;

            if v219 == nil then
                v219 = create_component_indexes();
                p216.lookups.postponed[p217] = v219;
            end;

            v219[v220][i2] = {
                filter = v2.filter
            };
        end;
    end;

    for i, v in v218.components do
        local v223 = i;

        for i2 in v do
            if v219 == nil then
                v219 = create_component_indexes();
                p216.lookups.postponed[p217] = v219;
            end;

            v219[v223][i2] = {
                filter = nil
            };
        end;
    end;

    v218.generator:destroy();
    local storage_group = v218.storage_group;

    if storage_group.active[p217] then
        storage_group.active[p217] = nil;
        storage_group.active_count = storage_group.active_count - 1;
    else
        common.log_error("attempted to remove an entity that wasn\'t active");
    end;

    v218.storage_group.changes.added[p217] = nil;
    v218.storage_group.changes.changed[p217] = nil;
    v218.storage_group.changes.added_components[p217] = nil;
    p216.lookups.entities[p217] = nil;
end;

function u2.cleanup_entity(p224, p225) -- Line: 927
    p224.lookups.entities[p225] = nil;
    p224.lookups.postponed[p225] = nil;
    p224.lookups.deletions.entities[p225] = nil;
    p224.lookups.deletions.components[p225] = nil;
end;

function u2.update_component_filter(p226: any, p227: any, p228: any, p229: number, p230: table) -- Line: 934
    local v231 = p226:create_generator_from_filter(p230);

    return v231, p226:bind_component_generator(p227, p228, p229, v231);
end;

function u2.start_component(p232: any, p233: any, p234: any, p235: number, p236: any) -- Line: 946
    -- upvalues: create_component_indexes (copy)
    local v237;

    if p236 then
        v237 = type(p236) ~= "table" and {
            [p236] = true
        } or p236;
    else
        v237 = nil;
    end;

    local _or_postpone_entity_lookup = p232:get_or_postpone_entity_lookup(p233, p234, p235, v237);

    if _or_postpone_entity_lookup == nil then
        return;
    end;

    if v237 == nil then
        _or_postpone_entity_lookup.components[p235][p234] = true;
        local v238 = _or_postpone_entity_lookup.storage_group.active[p233];
        local v239 = v238.components[p235];

        if v239[p234] == nil then
            v239[p234] = true;
            v238.component_count = v238.component_count + 1;
        end;

        return;
    end;

    local v240, v241 = p232:update_component_filter(p233, p234, p235, v237);
    local _or_create_storage_group = p232:get_or_create_storage_group(v241.result);
    local v242 = _or_create_storage_group.active[p233];

    if v242 == nil then
        v242 = {
            component_count = 0,
            is_entity_mask = false,
            components = create_component_indexes()
        };
        _or_create_storage_group.active[p233] = v242;
        _or_create_storage_group.active_count = _or_create_storage_group.active_count + 1;
    end;

    local v243 = v242.components[p235];

    if v243[p234] == nil then
        v243[p234] = true;
        v242.component_count = v242.component_count + 1;
    end;

    local shared_with = _or_create_storage_group.shared_with;
    local v244 = shared_with[p233];

    if v244 == nil then
        v244 = create_component_indexes();
        shared_with[p233] = v244;
    end;

    v244[p235][p234] = true;
    _or_postpone_entity_lookup.filtered_components[p235][p234] = {
        generator = v240,
        band_generator = v241,
        filter = v237,
        storage_group = _or_create_storage_group
    };
end;

function u2.set_component(p245: any, p246: any, p247: any, p248: number, p249: any) -- Line: 981
    -- upvalues: create_component_indexes (copy)
    local v250;

    if p249 then
        v250 = type(p249) ~= "table" and {
            [p249] = true
        } or p249;
    else
        v250 = nil;
    end;

    local _or_postpone_entity_lookup = p245:get_or_postpone_entity_lookup(p246, p247, p248, v250);

    if _or_postpone_entity_lookup == nil then
        return;
    end;

    local v251 = _or_postpone_entity_lookup.filtered_components[p248][p247];

    if v250 == nil then
        if v251 ~= nil then
            v251.band_generator:destroy();
            v251.generator:destroy();
            p245:merge_component_filter(p246, p247, p248);
        end;

        return;
    end;

    local v252, v253 = p245:update_component_filter(p246, p247, p248, v250);

    if v251 == nil then
        local _or_create_storage_group = p245:get_or_create_storage_group(v253.result);
        local v254;

        if _or_create_storage_group and _or_create_storage_group == _or_postpone_entity_lookup.storage_group then
            v254 = _or_postpone_entity_lookup.storage_group;
            local shared_with = _or_create_storage_group.shared_with;
            local v255 = shared_with[p246];

            if v255 == nil then
                v255 = create_component_indexes();
                shared_with[p246] = v255;
            end;

            v255[p248][p247] = true;
        else
            v254 = p245:move_component_storage(p246, p247, p248, _or_postpone_entity_lookup.storage_group, v253.result);
        end;

        _or_postpone_entity_lookup.filtered_components[p248][p247] = {
            generator = v252,
            band_generator = v253,
            filter = v250,
            storage_group = v254
        };
        _or_postpone_entity_lookup.components[p248][p247] = nil;

        return;
    end;

    v251.band_generator:destroy();
    v251.generator:destroy();
    v251.band_generator = v253;
    v251.generator = v252;
    v251.filter = v250;
    v253:run_subscribed();
end;

function u2.stop_component(p256: any, p257: any, p258: any, p259: number) -- Line: 1043
    -- upvalues: common (copy)
    local _component_lookup, v260 = p256:get_component_lookup(p257, p258, p259);

    if _component_lookup == nil then
        if not v260 then
            local v261 = p256.lookups.postponed[p257];

            if v261 == nil then
                return;
            end;

            v261[p259][p258] = nil;

            return;
        end;

        local storage_group = v260.storage_group;
        local v262 = storage_group.active[p257];

        if v262 then
            local v263 = v262.components[p259];

            if v263[p258] then
                v263[p258] = nil;
                v262.component_count = v262.component_count - 1;

                if v262.component_count <= 0 and not v262.is_entity_mask then
                    if storage_group.active[p257] then
                        storage_group.active[p257] = nil;
                        storage_group.active_count = storage_group.active_count - 1;
                    else
                        common.log_error("attempted to remove an entity that wasn\'t active");
                    end;
                end;
            end;
        end;

        v260.components[p259][p258] = nil;

        return;
    end;

    _component_lookup.band_generator:destroy();
    _component_lookup.generator:destroy();
    local storage_group = _component_lookup.storage_group;
    local v264 = storage_group.active[p257];

    if v264 then
        local v265 = v264.components[p259];

        if v265[p258] then
            v265[p258] = nil;
            v264.component_count = v264.component_count - 1;

            if v264.component_count <= 0 and not v264.is_entity_mask then
                if storage_group.active[p257] then
                    storage_group.active[p257] = nil;
                    storage_group.active_count = storage_group.active_count - 1;
                else
                    common.log_error("attempted to remove an entity that wasn\'t active");
                end;
            end;
        end;
    end;

    local v266 = _component_lookup.storage_group.shared_with[p257];

    if v266 ~= nil then
        v266[p259][p258] = nil;
    end;

    v260.filtered_components[p259][p258] = nil;
end;

function u2.get_component_storage_group(p267: any, p268: any, p269: any, p270: number) -- Line: 1067
    local _component_lookup, v271 = p267:get_component_lookup(p268, p269, p270);

    if _component_lookup ~= nil then
        return _component_lookup.storage_group;
    end;

    if v271 then
        return v271.storage_group;
    end;

    error("attempted to use an entity that is not active");
end;

function u2.allocate_propagated_entity_start(p272, p273) -- Line: 1084
    local v274 = p272.lookups.entities[p273];

    if v274 then
        v274.storage_group.changes.added[p273] = true;

        for _, v in v274.filtered_components do
            for _, v2 in v do
                v2.storage_group.changes.added[p273] = true;
            end;
        end;
    end;
end;

function u2.allocate_shared_entity_start(p275: any, p276: any, p277: any, p278: number) -- Line: 1097
    local _component_lookup = p275:get_component_lookup(p276, p277, p278);

    if _component_lookup ~= nil then
        _component_lookup.storage_group.changes.added[p276] = true;
    end;
end;

function u2.allocate_entity_stop(p279, p280) -- Line: 1109
    local v281 = p279.lookups.entities[p280];

    if not v281 then
        return;
    end;

    local storage_group = v281.storage_group;

    if storage_group.deletions.entities[p280] then
        return;
    end;

    storage_group.deletions.entities[p280] = true;
end;

function u2.allocate_component_start(p282: any, p283: any, p284: any, p285: number) -- Line: 1122
    -- upvalues: create_component_indexes (copy)
    local _component_storage_group = p282:get_component_storage_group(p283, p284, p285);
    local v286 = _component_storage_group.changes.added_components[p283];

    if v286 == nil then
        v286 = create_component_indexes();
        _component_storage_group.changes.added_components[p283] = v286;
    end;

    v286[p285][p284] = true;
end;

function u2.allocate_component_stop(p287: any, p288: any, p289: any, p290: number) -- Line: 1133
    -- upvalues: create_component_indexes (copy)
    local _component_storage_group = p287:get_component_storage_group(p288, p289, p290);

    if not _component_storage_group then
        return;
    end;

    local v291 = _component_storage_group.deletions.components[p288];

    if v291 ~= nil then
        v291[p290][p289] = true;

        return;
    end;

    local v292 = create_component_indexes();
    v292[p290][p289] = true;
    _component_storage_group.deletions.components[p288] = v292;
end;

function u2.deallocate_entity_stop(p293, p294) -- Line: 1154
    local v295 = p293.lookups.deletions.entities[p294];

    if not v295 then
        return;
    end;

    local storage_group = v295.storage_group;

    if storage_group.deletions.entities[p294] then
        storage_group.deletions.entities[p294] = nil;
        storage_group.deletions_count = storage_group.deletions_count - 1;
    end;
end;

function u2.deallocate_component_start(p296: any, p297: any, p298: any, p299: number) -- Line: 1167
    local v300 = p296:get_component_storage_group(p297, p298, p299).changes.added_components[p297];

    if v300 then
        v300[p299][p298] = nil;
    end;
end;

function u2.deallocate_component_stop(p301: any, p302: any, p303: any, p304: number) -- Line: 1180
    local v305 = p301.lookups.deletions.components[p302];
    local v306;

    if v305 == nil then
        v306 = nil;
    else
        v306 = v305[p304];

        if v306 then
            v306 = v306[p303];
        end;
    end;

    if v306 == nil then
        return;
    end;

    local v307 = v306.storage_group.deletions.components[p302];

    if v307 and v307[p304][p303] then
        v307[p304][p303] = nil;
    end;
end;

function u2.allocate_tag_addition(p308, p309, p310) -- Line: 1201
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p308:get_component_storage_group(p309, p310, u1.tag);
    local v311 = _component_storage_group.changes.changed[p309];

    if v311 == nil then
        v311 = create_entity_changes();
        _component_storage_group.changes.changed[p309] = v311;
    end;

    v311.tag_added[p310] = true;
    v311.tag_removed[p310] = nil;
end;

function u2.allocate_component_change(p312, p313, p314, p315) -- Line: 1209
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p312:get_component_storage_group(p313, p314, u1.component);
    local v316 = _component_storage_group.changes.changed[p313];

    if v316 == nil then
        v316 = create_entity_changes();
        _component_storage_group.changes.changed[p313] = v316;
    end;

    v316.component_changed[p314] = p315;
    v316.component_removed[p314] = nil;
end;

function u2.allocate_unreliable_addition(p317, p318, p319) -- Line: 1222
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p317:get_component_storage_group(p318, p319, u1.unreliable);
    local v320 = _component_storage_group.changes.changed[p318];

    if v320 == nil then
        v320 = create_entity_changes();
        _component_storage_group.changes.changed[p318] = v320;
    end;

    v320.unreliable_added[p319] = true;
    v320.unreliable_removed[p319] = nil;
end;

function u2.allocate_pair_tag_addition(p321, p322, p323) -- Line: 1234
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p321:get_component_storage_group(p322, p323, u1.pair_tag);
    local v324 = _component_storage_group.changes.changed[p322];

    if v324 == nil then
        v324 = create_entity_changes();
        _component_storage_group.changes.changed[p322] = v324;
    end;

    v324.pair_tag_added[p323] = true;
    v324.pair_tag_removed[p323] = nil;
end;

function u2.allocate_pair_component_change(p325, p326, p327, p328) -- Line: 1242
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p325:get_component_storage_group(p326, p327, u1.pair_component);
    local v329 = _component_storage_group.changes.changed[p326];

    if v329 == nil then
        v329 = create_entity_changes();
        _component_storage_group.changes.changed[p326] = v329;
    end;

    v329.pair_component_changed[p327] = p328;
    v329.pair_component_removed[p327] = nil;
end;

function u2.allocate_relation_component_change(p330, p331, p332, p333, p334) -- Line: 1255
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p330:get_component_storage_group(p331, p332, u1.relation_component);
    local v335 = _component_storage_group.changes.changed[p331];

    if v335 == nil then
        v335 = create_entity_changes();
        _component_storage_group.changes.changed[p331] = v335;
    end;

    local v336 = v335.relation_component_changed[p332];

    if v336 == nil then
        v336 = {};
        v335.relation_component_changed[p332] = v336;
    end;

    v336[p333] = p334;
    local v337 = v335.relation_component_removed[p332];

    if v337 ~= nil then
        v337[p333] = nil;
    end;
end;

function u2.allocate_relation_tag_addition(p338, p339, p340, p341) -- Line: 1277
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p338:get_component_storage_group(p339, p340, u1.relation);
    local v342 = _component_storage_group.changes.changed[p339];

    if v342 == nil then
        v342 = create_entity_changes();
        _component_storage_group.changes.changed[p339] = v342;
    end;

    local v343 = v342.relation_tag_added[p340];

    if v343 == nil then
        v343 = {};
        v342.relation_tag_added[p340] = v343;
    end;

    v343[p341] = true;
    local v344 = v342.relation_tag_removed[p340];

    if v344 then
        v344[p341] = nil;
    end;
end;

function u2.allocate_tag_removal(p345, p346, p347) -- Line: 1298
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p345:get_component_storage_group(p346, p347, u1.tag);
    local v348 = _component_storage_group.changes.changed[p346];

    if v348 == nil then
        v348 = create_entity_changes();
        _component_storage_group.changes.changed[p346] = v348;
    end;

    v348.tag_added[p347] = nil;
    v348.tag_removed[p347] = true;
end;

function u2.allocate_component_removal(p349, p350, p351) -- Line: 1306
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p349:get_component_storage_group(p350, p351, u1.component);
    local v352 = _component_storage_group.changes.changed[p350];

    if v352 == nil then
        v352 = create_entity_changes();
        _component_storage_group.changes.changed[p350] = v352;
    end;

    v352.component_changed[p351] = nil;
    v352.component_removed[p351] = true;
end;

function u2.allocate_unreliable_removal(p353, p354, p355) -- Line: 1314
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p353:get_component_storage_group(p354, p355, u1.unreliable);
    local v356 = _component_storage_group.changes.changed[p354];

    if v356 == nil then
        v356 = create_entity_changes();
        _component_storage_group.changes.changed[p354] = v356;
    end;

    v356.unreliable_added[p355] = nil;
    v356.unreliable_removed[p355] = true;
end;

function u2.allocate_pair_tag_removal(p357, p358, p359) -- Line: 1326
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p357:get_component_storage_group(p358, p359, u1.pair_tag);
    local v360 = _component_storage_group.changes.changed[p358];

    if v360 == nil then
        v360 = create_entity_changes();
        _component_storage_group.changes.changed[p358] = v360;
    end;

    v360.pair_tag_added[p359] = nil;
    v360.pair_tag_removed[p359] = true;
end;

function u2.allocate_pair_component_removal(p361, p362, p363) -- Line: 1334
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p361:get_component_storage_group(p362, p363, u1.pair_component);
    local v364 = _component_storage_group.changes.changed[p362];

    if v364 == nil then
        v364 = create_entity_changes();
        _component_storage_group.changes.changed[p362] = v364;
    end;

    v364.pair_component_changed[p363] = nil;
    v364.pair_component_removed[p363] = true;
end;

function u2.allocate_relation_tag_removal(p365, p366, p367, p368) -- Line: 1342
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p365:get_component_storage_group(p366, p367, u1.relation);
    local v369 = _component_storage_group.changes.changed[p366];

    if v369 == nil then
        v369 = create_entity_changes();
        _component_storage_group.changes.changed[p366] = v369;
    end;

    local v370 = v369.relation_tag_removed[p367];

    if v370 == nil then
        v370 = {};
        v369.relation_tag_removed[p367] = v370;
    end;

    v370[p368] = true;
    local v371 = v369.relation_tag_added[p367];

    if v371 then
        v371[p368] = nil;
    end;
end;

function u2.allocate_relation_component_removal(p372, p373, p374, p375) -- Line: 1363
    -- upvalues: u1 (copy), create_entity_changes (copy)
    local _component_storage_group = p372:get_component_storage_group(p373, p374, u1.relation_component);
    local v376 = _component_storage_group.changes.changed[p373];

    if v376 == nil then
        v376 = create_entity_changes();
        _component_storage_group.changes.changed[p373] = v376;
    end;

    local v377 = v376.relation_component_removed[p374];

    if v377 == nil then
        v377 = {};
        v376.relation_component_removed[p374] = v377;
    end;

    v377[p375] = true;
    local v378 = v376.relation_component_changed[p374];

    if v378 then
        v378[p375] = nil;
    end;
end;

local function remap_bitmask(p379: any, p380: table, p381: table, p382: number?) -- Line: 1384
    -- upvalues: utils (copy)
    local v383 = utils.bitmask.create(p382);

    for i, v in p381 do
        local v384 = p380[i];

        if v384 then
            local v385 = p379:get(v384);

            if v385 then
                v383:set(v, v385);
            else
                v383:clear(v);
            end;
        end;
    end;

    return v383;
end;

local function bitmask_from_set(p386: any, p387: table) -- Line: 1405
    -- upvalues: utils (copy), u2 (copy)
    local v388 = utils.bitmask.create(p386.member_count);

    for i in p387 do
        local v389 = p386.client_indexes[i];
        local v390;

        if v389 then
            v390 = v389;
        else
            v390 = p386.client_indexes[p386.client_aliases[i]];

            if v390 then
                if not utils.is_client_valid(v390) then
                    v390 = v389;
                end;
            elseif utils.is_client_valid(i) then
                u2.register_client(p386, i);
                v390 = p386.client_indexes[i];
            else
                v390 = v389;
            end;
        end;

        if v390 then
            v388:set(v390);
        end;
    end;

    return v388;
end;

function u2.merge_storages(p391: any, p392: table, p393: table) -- Line: 1427
    -- upvalues: create_component_indexes (copy), merge_component_actives (copy), merge_component_additions (copy), create_entity_changes (copy), merge_component_changes (copy)
    if p393 == p392 then
        return;
    end;

    for i, v in p392.active do
        local v394 = p393.active[i];

        if v394 == nil then
            v394 = {
                component_count = 0,
                is_entity_mask = false,
                components = create_component_indexes()
            };
            p393.active[i] = v394;
            p393.active_count = p393.active_count + 1;
        end;

        merge_component_actives(v, v394);

        if v.is_entity_mask then
            p391.lookups.entities[i].storage_group = p393;
            v394.is_entity_mask = true;
        end;
    end;

    for i, v in p392.shared_with do
        local v395 = i;

        for i2, v2 in v do
            local v396 = i2;

            for i3 in v2 do
                local shared_with = p393.shared_with;
                local v397 = shared_with[v395];

                if v397 == nil then
                    v397 = create_component_indexes();
                    shared_with[v395] = v397;
                end;

                v397[v396][i3] = true;
                local _component_lookup = p391:get_component_lookup(v395, i3, v396);

                if _component_lookup ~= nil then
                    _component_lookup.storage_group = p393;
                end;
            end;
        end;
    end;

    for i, v in p392.changes.added_components do
        local v398 = p393.changes.added_components[i];

        if v398 == nil then
            v398 = create_component_indexes();
            p393.changes.added_components[i] = v398;
        end;

        merge_component_additions(v398, v);
    end;

    for i, v in p392.changes.changed do
        local v399 = p393.changes.changed[i];

        if v399 == nil then
            v399 = create_entity_changes();
            p393.changes.changed[i] = v399;
        end;

        merge_component_changes(v399, v);
    end;

    for i in p392.changes.added do
        p393.changes.added[i] = true;
    end;

    for i in p392.deletions.entities do
        p393.deletions.entities[i] = true;
    end;

    for i, v in p392.deletions.components do
        local v400 = i;

        for i2, v2 in v do
            local v401 = i2;

            for i3 in v2 do
                local components = p393.deletions.components;
                local v402 = components[v400];

                if v402 == nil then
                    v402 = create_component_indexes();
                    components[v400] = v402;
                end;

                v402[v401][i3] = true;
            end;
        end;
    end;
end;

function u2.compact_members(p403) -- Line: 1480
    -- upvalues: remap_bitmask (copy)
    local client_indexes = p403.client_indexes;
    local v404 = {};
    local v405 = 0;

    for i in client_indexes do
        v404[i] = v405;
        v405 = v405 + 1;
    end;

    p403.client_indexes = v404;
    p403.member_count = v405;

    for _, v in p403.lookups.entities do
        local generator = v.generator;
        local bitmask = generator.bitmask;

        if bitmask then
            generator.bitmask = remap_bitmask(bitmask, client_indexes, v404, v405);
        end;

        generator.result = remap_bitmask(generator.result, client_indexes, v404, v405);

        for _, v2 in v.filtered_components do
            for _, v3 in v2 do
                local generator2 = v3.generator;
                local bitmask2 = generator2.bitmask;

                if bitmask2 then
                    generator2.bitmask = remap_bitmask(bitmask2, client_indexes, v404, v405);
                end;

                generator2.result = remap_bitmask(generator2.result, client_indexes, v404, v405);
                local band_generator = v3.band_generator;
                local bitmask3 = band_generator.bitmask;

                if bitmask3 then
                    band_generator.bitmask = remap_bitmask(bitmask3, client_indexes, v404, v405);
                end;

                band_generator.result = remap_bitmask(band_generator.result, client_indexes, v404, v405);
            end;
        end;
    end;

    local all_members_generator = p403.all_members_generator;
    local unactive_members_generator = p403.unactive_members_generator;
    local active_members_generator = p403.active_members_generator;
    all_members_generator.bitmask = remap_bitmask(all_members_generator.bitmask, client_indexes, v404, v405);
    all_members_generator.result = all_members_generator.bitmask;
    unactive_members_generator.bitmask = remap_bitmask(unactive_members_generator.bitmask, client_indexes, v404, v405);
    unactive_members_generator.result = unactive_members_generator.bitmask;
    active_members_generator.result = remap_bitmask(active_members_generator.result, client_indexes, v404, v405);
    local v406 = {};

    for _, v in p403.storages do
        local v407 = remap_bitmask(v.mask.bitmask, client_indexes, v404, v405);
        v.mask.bitmask = v407;
        local v408 = v407:tostring();
        v.mask.hash = v408;
        v.mask.members = p403:get_clients_from_bitmask(v407);
        local v409 = v406[v408];

        if v409 then
            p403:merge_storages(v, v409);
        else
            v406[v408] = v;
        end;
    end;

    p403.storages = v406;
end;

function u2.create_generator_from_filter(p410: any, p411: table) -- Line: 1551
    local v412;

    for _, v in p411 do
        v412 = v and true or false;
        break;
    end;

    v412 = true;

    if v412 then
        return p410:create_include_generator(p411);
    end;

    return p410:create_exclude_generator(p411);
end;

function u2.create_exclude_generator(p413: any, p414: table) -- Line: 1563
    -- upvalues: bitmask_from_set (copy), mask_generator (copy)
    local v415 = bitmask_from_set(p413, p414);
    local active_members_generator = p413.active_members_generator;
    local v417 = mask_generator.create(v415, function(p416) -- Line: 1567
        -- upvalues: active_members_generator (copy)
        return active_members_generator.result:band(p416.bitmask:bnot());
    end);
    v417:track(active_members_generator);

    return v417;
end;

function u2.create_include_generator(p418: any, p419: table) -- Line: 1577
    -- upvalues: bitmask_from_set (copy), mask_generator (copy)
    local v420 = bitmask_from_set(p418, p419);
    local active_members_generator = p418.active_members_generator;
    local v422 = mask_generator.create(v420, function(p421) -- Line: 1581
        -- upvalues: active_members_generator (copy)
        return p421.bitmask:band(active_members_generator.result);
    end);
    v422:track(active_members_generator);

    return v422;
end;

function u2.create_all_members_generator(p423) -- Line: 1590
    -- upvalues: utils (copy), mask_generator (copy)
    local v424 = {};

    for i in p423.client_indexes do
        v424[i] = true;
    end;

    local v425 = utils.bitmask.from_set(p423.client_indexes, v424, p423.member_count);

    return mask_generator.create(v425);
end;

function u2.create_unactive_generator(p426) -- Line: 1598
    -- upvalues: utils (copy), mask_generator (copy)
    local v427 = utils.bitmask.from_set(p426.client_indexes, p426.unreplicated, p426.member_count);

    return mask_generator.create(v427);
end;

function u2.create_active_generator(p428) -- Line: 1602
    -- upvalues: mask_generator (copy)
    local all_members_generator = p428.all_members_generator;
    local unactive_members_generator = p428.unactive_members_generator;
    local v429 = mask_generator.create(nil, function() -- Line: 1606
        -- upvalues: all_members_generator (copy), unactive_members_generator (copy)
        return all_members_generator.result:band(unactive_members_generator.result:bnot());
    end);
    v429:track(all_members_generator);
    v429:track(unactive_members_generator);

    return v429;
end;

function u2.register_client(p430, p431) -- Line: 1619
    if p430.client_indexes[p431] then
        return;
    end;

    local member_count = p430.member_count;
    p430.client_indexes[p431] = member_count;
    p430.member_count = p430.member_count + 1;
    p430.unreplicated[p431] = true;
    p430.unactive_members_generator.bitmask:set(member_count);
    p430.all_members_generator.bitmask:set(member_count);
    p430.active_members_generator:compute();

    if p430.member_count >= p430.compact_count then
        p430:compact_members();
    end;
end;

function u2.unregister_client(p432, p433) -- Line: 1638
    local v434 = p432.client_indexes[p433];

    if v434 == nil then
        return;
    end;

    p432.client_indexes[p433] = nil;
    p432.all_members_generator.bitmask:clear(v434);
    p432.active_members_generator:compute();
end;

function u2.activate_client(p435, p436) -- Line: 1648
    local v437 = p435.client_indexes[p436];
    p435.unreplicated[p436] = nil;
    p435.unactive_members_generator.bitmask:clear(v437);
    p435.active_members_generator:compute();
end;

function u2.member_is_active(p438, p439) -- Line: 1656
    local v440 = p438.client_indexes[p439];

    if v440 == nil then
        return false;
    end;

    return p438.active_members_generator.result:get(v440);
end;

return {
    create = function() -- Line: 1665, Name: create
        -- upvalues: u2 (copy)
        local v441 = {
            client_indexes = {},
            group_indexes = {},
            client_aliases = {},
            member_count = 0,
            compact_count = 100,
            storages = {},
            lookups = {
                entities = {},
                components = {},
                deletions = {
                    entities = {},
                    components = {}
                },
                filter_deltas = {
                    entities = {},
                    components = {}
                },
                postponed = {}
            },
            unreplicated = {}
        };
        v441.all_members_generator = u2.create_all_members_generator(v441);
        v441.unactive_members_generator = u2.create_unactive_generator(v441);
        v441.active_members_generator = u2.create_active_generator(v441);

        return setmetatable(v441, u2);
    end,

    masking_controller = u2,
    COMPONENT_TYPES = u1
};