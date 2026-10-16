-- Decompiled with Potassium's decompiler.

local jecs = require(script.Parent.Parent:WaitForChild("jecs"));
local v1 = {};
local Wildcard = jecs.Wildcard;
local Name = jecs.Name;
local v2 = {
    ["jecs.ChildOf"] = jecs.ChildOf
};

function LOGERROR(...)
    error("REPLECS ERROR - " .. table.concat({ ... }, " "));
end;

function LOGWARN(...)
    warn("REPLECS WARN - " .. table.concat({ ... }, " "));
end;

function LOG_COMPONENT(p3, p4)
    -- upvalues: Name (copy)
    return ` name: {p3:get(p4, Name) or "(no name)"}, id: {p4}`;
end;

local component = jecs.component;
local tag = jecs.tag;
v1.preregistration = true;
v1.relationships = true;
v1.wildcard = Wildcard;
v1.ecs_name = Name;
v1.implicitly_shared = v2;

function v1.is_pair(p5) -- Line: 29
    -- upvalues: jecs (copy)
    return jecs.IS_PAIR(p5);
end;

function v1.pair(p6, p7) -- Line: 33
    -- upvalues: jecs (copy)
    return jecs.pair(p6, p7);
end;

function v1.pair_first(p8, p9) -- Line: 37
    -- upvalues: jecs (copy)
    if not jecs.IS_PAIR(p9) then
        LOGERROR((`expected a pair, got: {LOG_COMPONENT(p8, p9)}`));
    end;

    return jecs.pair_first(p8, p9);
end;

function v1.pair_second(p10, p11) -- Line: 44
    -- upvalues: jecs (copy)
    if not jecs.IS_PAIR(p11) then
        LOGERROR((`expected a pair, got: {LOG_COMPONENT(p10, p11)}`));
    end;

    return jecs.pair_second(p10, p11);
end;

function v1.add_name(p12: any, p13: any, p14: string) -- Line: 55
    -- upvalues: Name (copy)
    p12:set(p13, Name, p14);
end;

function v1.add_preregistered_name(p15: any, p16: string) -- Line: 59
    -- upvalues: jecs (copy), Name (copy)
    jecs.meta(p15, Name, p16);
end;

function v1.iterate_all_relations(p17: any, p18: any, p19: any, p20: function) -- Line: 63
    -- upvalues: jecs (copy), Wildcard (copy)
    local v21 = jecs.entity_index_try_get_fast(p17.entity_index, p18);

    if not v21 then
        return;
    end;

    local archetype = v21.archetype;
    local v22 = jecs.pair(p19, Wildcard);
    local v23 = p17.component_index[v22];

    if not v23 then
        return;
    end;

    local id = archetype.id;
    local v24 = v23.counts[id];

    if not v24 then
        return;
    end;

    local v25 = v23.records[id];

    if not v25 then
        return;
    end;

    for i = v25, v25 + v24 - 1 do
        p20(archetype.types[i]);
        local _ = i;
    end;
end;

function v1.world_set(p26, p27, p28, p29) -- Line: 96
    p26:set(p27, p28, p29);
end;

function v1.world_remove(p30, p31, p32) -- Line: 100
    p30:remove(p31, p32);
end;

function v1.world_delete(p33, p34) -- Line: 104
    p33:delete(p34);
end;

function v1.world_add(p35, p36, p37) -- Line: 92
    p35:add(p36, p37);
end;

function v1.world_get(p38, p39, p40) -- Line: 108
    return p38:get(p39, p40);
end;

function v1.world_target(p41: any, p42: any, p43: any, p44: number?) -- Line: 112
    return p41:target(p42, p43, p44);
end;

function v1.world_has(p45, p46, p47) -- Line: 116
    return p45:has(p46, p47);
end;

function v1.world_entity(p48) -- Line: 120
    return p48:entity();
end;

function v1.world_tag(p49) -- Line: 124
    return p49:entity();
end;

function v1.world_component(p50) -- Line: 127
    return p50:component();
end;

v1.preregister_component = component;
v1.preregister_tag = tag;

function v1.is_component(p51, p52) -- Line: 134
    -- upvalues: jecs (copy)
    return not jecs.is_tag(p51, p52);
end;

function v1.listen_relation(p53) -- Line: 51
    return p53;
end;

function v1.hook_added(p54: any, p55: any, p56: function) -- Line: 138
    return p54:added(p55, p56);
end;

function v1.hook_changed(p57: any, p58: any, p59: function) -- Line: 142
    return p57:changed(p58, p59);
end;

function v1.hook_removed(p60: any, p61: any, p62: function) -- Line: 150
    return p60:removed(p61, p62);
end;

v1.log_error = LOGERROR;
v1.log_warn = LOGWARN;
v1.log_component = LOG_COMPONENT;

return v1;