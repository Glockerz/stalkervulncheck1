-- Decompiled with Potassium's decompiler.

local jecs = require(script.Parent.Parent.Parent.Parent.jecs);
local lon = require(script.Parent.Parent.Parent.modules.lon);
local queue = require(script.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.modules.remotes);
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector);
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check);
require(script.Parent.Parent.Parent.modules.types);
local public = require(script.Parent.Parent.public);
local query_parser = require(script.Parent.Parent.query_parser);
local entity_index_try_get = jecs.entity_index_try_get;
local IS_PAIR = jecs.IS_PAIR;
local pair = jecs.pair;
local pair_first = jecs.pair_first;
local pair_second = jecs.pair_second;
local u1 = {};

local function get_all_components(p2, p3) -- Line: 18
    -- upvalues: entity_index_try_get (copy), u1 (copy)
    local v4 = entity_index_try_get(p2.entity_index, p3);

    if not v4 then
        return u1;
    end;

    local archetype = v4.archetype;

    if not archetype then
        return u1;
    end;

    local v5 = {};

    for _, v in archetype.types do
        table.insert(v5, v);
    end;

    return v5;
end;

local function convert_component(p6, p7, p8) -- Line: 32
    -- upvalues: IS_PAIR (copy), convert_component (copy), pair_first (copy), pair_second (copy)
    if IS_PAIR(p8) then
        return `({convert_component(p6, p7, pair_first(p6, p8))}, {convert_component(p6, p7, pair_second(p6, p8))})`;
    end;

    return p6:get(p8, p7) or `${tostring(p8)}`;
end;

local u9 = newproxy();
local u10 = newproxy();

local function get_component(p11: string, u12: table) -- Line: 47
    -- upvalues: query_parser (copy), jecs (copy), pair (copy)
    local function get_entity(p13) -- Line: 49
        -- upvalues: u12 (copy)
        local value = p13.value;

        if value.type == "Entity" then
            return value.entity;
        end;

        if value.type == "Name" then
            return u12[value.name];
        end;

        error("bad");
    end;

    local v14 = nil;
    local v15 = query_parser(p11)[1];

    if v15.type ~= "Component" then
        if v15.type == "Relationship" then
            local Wildcard = jecs.Wildcard;
            local Wildcard2 = jecs.Wildcard;

            if v15.left.type == "Component" then
                local value = v15.left.value;

                if value.type == "Entity" then
                    Wildcard = value.entity;
                elseif value.type == "Name" then
                    Wildcard = u12[value.name];
                else
                    error("bad");
                    Wildcard = nil;
                end;
            end;

            if v15.right.type == "Component" then
                local value = v15.right.value;

                if value.type == "Entity" then
                    Wildcard2 = value.entity;
                elseif value.type == "Name" then
                    Wildcard2 = u12[value.name];
                else
                    error("bad");
                    Wildcard2 = nil;
                end;
            end;

            v14 = pair(Wildcard, Wildcard2);
        end;

        return v14;
    end;

    local value = v15.value;

    if value.type == "Entity" then
        return value.entity;
    end;

    if value.type == "Name" then
        return u12[value.name];
    end;

    error("bad");

    return nil;
end;

return function() -- Line: 81
    -- upvalues: queue (copy), remotes (copy), public (copy), reverse_connector (copy), traffic_check (copy), jecs (copy), get_component (copy), lon (copy), u9 (copy), get_all_components (copy), convert_component (copy), u10 (copy)
    local u16 = queue(remotes.inspect_entity);
    local u17 = queue(remotes.update_inspect_settings);
    local u18 = queue(remotes.stop_inspect_entity);
    local u19 = queue(remotes.update_entity);
    local u20 = queue(remotes.delete_entity);
    local u21 = queue(remotes.get_component);
    local u22 = queue(remotes.validate_entity_component);
    local u23 = {};

    return function() -- Line: 94
        -- upvalues: u22 (copy), public (ref), reverse_connector (ref), traffic_check (ref), jecs (ref), get_component (ref), remotes (ref), u16 (copy), u23 (copy), u18 (copy), u20 (copy), u17 (copy), u21 (copy), lon (ref), u19 (copy), u9 (ref), get_all_components (ref), convert_component (ref), u10 (ref)
        for i, v, v2 in u22:iter() do
            local v24 = public[v];
            local v25 = reverse_connector(i);

            if traffic_check.check_no_wl(i.host) and (v24 and v24.class_name == "World") then
                local v26 = v2;
                local v27 = {};

                for i2, v3 in v24.world:query(jecs.Name):iter() do
                    v27[v3] = i2;
                end;

                local success, result = pcall(get_component, v26, v27);

                if success or not result then
                    result = nil;
                end;

                remotes.validate_entity_component_result:fire(v25, v, v26, success, result);
            end;
        end;

        for i, v, v2, v3 in u16:iter() do
            local v28 = public[v];
            local v29 = reverse_connector(i);

            if traffic_check.check_no_wl(i.host) and (v28 and v28.class_name == "World") then
                u23[v3] = {
                    paused = false,
                    outgoing = v29,
                    world = v28,
                    entity = v2,
                    new_values = {},
                    old_values = {}
                };
            end;
        end;

        for i, v in u18:iter() do
            if traffic_check.check_no_wl(i.host) then
                u23[v] = nil;
            end;
        end;

        for i, v in u20:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v30 = u23[v];
                v30.world.world:delete(v30.entity);
            end;
        end;

        for i, v, v2 in u17:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v31 = u23[v];

                if v31 then
                    v31.paused = v2.paused;
                end;
            end;
        end;

        for i, v, v2 in u21:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v32 = u23[v];
                local world = v32.world.world;
                local entity = v32.entity;
                local v33 = reverse_connector(i);
                local v34 = v;
                local v35 = {};

                for i2, v3 in world:query(jecs.Name):iter() do
                    v35[v3] = i2;
                end;

                local success, result = pcall(get_component, v2, v35);

                if result and success then
                    remotes.return_component:fire(v33, v34, result, lon.output(world:get(entity, result), true, false));
                else
                    remotes.return_component:fire(v33, v34, result, "nil");
                end;
            end;
        end;

        for i, v, v2 in u19:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v36 = u23[v];
                local world = v36.world.world;
                local entity = v36.entity;
                local v37 = {};

                for i2, v3 in world:query(jecs.Name):iter() do
                    v37[v3] = i2;
                end;

                for i2, v3 in v2 do
                    local success, result = pcall(get_component, i2, v37);
                    local v38 = world:get(entity, result);

                    if success then
                        local success2, result2 = pcall(lon.parse, v3);

                        if success2 then
                            local success3, result3 = pcall(lon.compile, result2, {
                                tag = u9,
                                old = v38
                            });

                            if success3 then
                                if result3 == nil then
                                    world:remove(entity, result);
                                elseif result3 == u9 then
                                    world:add(entity, result);
                                else
                                    world:set(entity, result, result3);
                                end;
                            else
                                warn("attempted to set", i2, "to", v3);
                                warn(result3);
                            end;
                        else
                            warn("attempted to set", i2, "to", v3);
                            warn(result2);
                        end;
                    else
                        warn("attempted to set", i2, "to", v3);
                        warn(result);
                    end;
                end;
            end;
        end;

        for i, v in u23 do
            local world = v.world.world;
            local entity = v.entity;

            if not v.paused and world:contains(entity) ~= false then
                local new_values = v.new_values;
                local old_values = v.old_values;

                local function is_tag(p39) -- Line: 245
                    -- upvalues: jecs (ref), world (copy)
                    return jecs.is_tag(world, p39);
                end;

                local v40 = i;
                local v41 = v;

                for _, v2 in get_all_components(world, entity) do
                    local v42 = convert_component(world, jecs.Name, v2);

                    if jecs.is_tag(world, v2) then
                        new_values[v42] = u9;
                    else
                        local v43 = world:get(entity, v2);

                        if v43 == nil then
                            v43 = u10;
                        end;

                        new_values[v42] = v43;
                    end;
                end;

                for i2, v2 in new_values do
                    if old_values[i2] ~= v2 or typeof(v2) == "table" then
                        remotes.inspect_entity_update:fire(v41.outgoing, v40, i2, v2 == u9 and "tag" or (v2 == u10 and "nil (not allowed)" or lon.output(v2, true, true)));
                    end;
                end;

                for i2, _ in old_values do
                    if new_values[i2] == nil then
                        remotes.inspect_entity_update:fire(v41.outgoing, v40, i2, nil);
                    end;
                end;

                table.clear(old_values);
                v41.new_values = old_values;
                v41.old_values = new_values;
            end;
        end;
    end;
end;