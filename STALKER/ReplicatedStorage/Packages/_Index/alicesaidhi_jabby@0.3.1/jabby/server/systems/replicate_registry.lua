-- Decompiled with Potassium's decompiler.

local jecs = require(script.Parent.Parent.Parent.Parent.jecs);
local queue = require(script.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.modules.remotes);
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector);
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check);
require(script.Parent.Parent.Parent.modules.types);
local public = require(script.Parent.Parent.public);
local query_parser = require(script.Parent.Parent.query_parser);
local u1 = newproxy();

local function clear_columns(p2: table) -- Line: 35
    for _, v in p2 do
        local v3 = v[1];
        table.clear(v);
        v[1] = v3;
        assert(v[1] == v3);
    end;

    return p2;
end;

local function reverse_columns(p4: table, p5: number) -- Line: 45
    for _, v in p4 do
        local v6 = v;

        for i = 0, p5 // 2 - 1 do
            local v7 = v6[i + 2];
            v6[i + 2] = v6[p5 + 1 - i];
            v6[p5 + 1 - i] = v7;
            local _ = i;
        end;
    end;

    return p4;
end;

return function() -- Line: 54
    -- upvalues: queue (copy), remotes (copy), query_parser (copy), jecs (copy), traffic_check (copy), public (copy), reverse_connector (copy), u1 (copy), clear_columns (copy)
    local u8 = {};
    local u9 = queue(remotes.validate_query);
    local u10 = queue(remotes.request_query);
    local u11 = queue(remotes.disconnect_query);
    local u12 = queue(remotes.advance_query_page);
    local u13 = queue(remotes.pause_query);
    local u14 = queue(remotes.refresh_results);

    local function check_if_query_valid(p15: any, p16: string) -- Line: 65
        -- upvalues: query_parser (ref), jecs (ref)
        local v17 = {};
        local success, result = pcall(query_parser, p16);

        if not success then
            return success, result;
        end;

        for i, v in p15.world:query(jecs.Name):iter() do
            v17[v] = i;
        end;

        local v18 = 0;

        for _, v in result do
            if not success then
                break;
            end;

            if v.query and not v.exclude then
                v18 = v18 + 1;
            end;

            if v.type == "Component" then
                if v.value.type == "Entity" then
                    if not p15.world:contains(v.value.entity) then
                        return false, "entity does not exist";
                    end;
                else
                    if v.value.type ~= "Name" then
                        return false, "what";
                    end;

                    if not v17[v.value.name] then
                        return false, `unknown component called {v.value.name}`;
                    end;
                end;
            elseif v.type == "Relationship" then
                local v19;

                if v.left.type == "Wildcard" then
                    v19 = v.right.type == "Wildcard";
                else
                    v19 = false;
                end;

                if v19 then
                    return false, "(*, *) is not a valid relationship";
                end;

                local left = v.left;
                local right = v.right;

                if left.type == "Component" then
                    if left.value.type == "Entity" then
                        if not p15.world:contains(left.value.entity) then
                            return false, "entity does not exist";
                        end;
                    else
                        if left.value.type ~= "Name" then
                            return false, "what";
                        end;

                        if not v17[left.value.name] then
                            return false, `unknown component called {left.value.name}`;
                        end;
                    end;
                elseif right.type == "Component" then
                    if right.value.type == "Entity" then
                        if not p15.world:contains(right.value.entity) then
                            return false, "entity does not exist";
                        end;
                    else
                        if right.value.type ~= "Name" then
                            return false, "what";
                        end;

                        if not v17[right.value.name] then
                            return false, `unknown component called {right.value.name}`;
                        end;
                    end;
                end;
            end;
        end;

        if v18 <= 26 then
            return success, nil;
        end;

        warn("attempting to observe too many values");

        return false, "attempting to observe too many entities";
    end;

    local function check_if_still_valid(p20: any, p21: table) -- Line: 141
        -- upvalues: jecs (ref)
        for _, v in p21 do
            if jecs.IS_PAIR(v) then
                local v22 = jecs.pair_first(p20, v) and jecs.pair_second(p20, v);

                if not p20:contains(v22) then
                    return false;
                end;
            elseif not p20:contains(v) then
                return false;
            end;
        end;

        return true;
    end;

    local function get_terms(p23: string, p24: any) -- Line: 154
        -- upvalues: query_parser (ref), jecs (ref)
        local v25 = query_parser(p23);
        local u26 = {};
        local v27 = {};
        local v28 = {};
        local v29 = {};
        local v30 = {};

        for i, v in p24:query(jecs.Name):iter() do
            u26[v] = i;
        end;

        local function get_entity(p31) -- Line: 166
            -- upvalues: u26 (copy)
            local value = p31.value;

            if value.type == "Entity" then
                return value.entity;
            end;

            if value.type == "Name" then
                return u26[value.name];
            end;

            error("bad");
        end;

        for _, v in v25 do
            if v.type == "Component" then
                local value = v.value;
                local v32;

                if value.type == "Entity" then
                    v32 = value.entity;
                elseif value.type == "Name" then
                    v32 = u26[value.name];
                else
                    error("bad");
                    v32 = nil;
                end;

                v27[v] = v32;
            elseif v.type == "Relationship" then
                local Wildcard = jecs.Wildcard;
                local Wildcard2 = jecs.Wildcard;

                if v.left.type == "Component" then
                    local value = v.left.value;

                    if value.type == "Entity" then
                        Wildcard = value.entity;
                    elseif value.type == "Name" then
                        Wildcard = u26[value.name];
                    else
                        error("bad");
                        Wildcard = nil;
                    end;
                end;

                if v.right.type == "Component" then
                    local value = v.right.value;

                    if value.type == "Entity" then
                        Wildcard2 = value.entity;
                    elseif value.type == "Name" then
                        Wildcard2 = u26[value.name];
                    else
                        error("bad");
                        Wildcard2 = nil;
                    end;
                end;

                v27[v] = jecs.pair(Wildcard, Wildcard2);
            end;
        end;

        for _, v in v25 do
            local v33 = v27[v];

            if v.exclude then
                table.insert(v28, v33);
            elseif v.query then
                table.insert(v29, v33);
            else
                table.insert(v30, v33);
            end;
        end;

        return v29, v28, v30;
    end;

    return function() -- Line: 211
        -- upvalues: u9 (copy), traffic_check (ref), public (ref), reverse_connector (ref), remotes (ref), check_if_query_valid (copy), get_terms (copy), u11 (copy), u8 (copy), u10 (copy), u14 (copy), u13 (copy), u12 (copy), jecs (ref), check_if_still_valid (copy), u1 (ref), clear_columns (ref)
        for i, v, v2 in u9:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v34 = public[v];
                local v35 = reverse_connector(i);

                if v34 and v34.class_name == "World" then
                    local v36, v37 = check_if_query_valid(v34, v2);
                    local v38, v39, v40;

                    if v36 then
                        v38, v39, v40 = get_terms(v2, v34.world);
                    else
                        v38 = nil;
                        v39 = nil;
                        v40 = nil;
                    end;

                    remotes.validate_result:fire(v35, v, v2, v36 and {
                        include = v38,
                        exclude = v39,
                        with = v40
                    }, v36, v37);
                else
                    remotes.validate_result:fire(v35, v, v2, nil, false, "world does not exist");
                end;
            end;
        end;

        for _, v in u11:iter() do
            u8[v] = nil;
        end;

        for i, v, v2, v3 in u10:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v41 = public[v];
                local v42 = reverse_connector(i);

                if v41 and (v41.class_name == "World" and check_if_query_valid(v41, v3)) then
                    local v43, v44, v45 = get_terms(v3, v41.world);
                    local v46 = {};
                    local v47 = {};
                    table.insert(v46, {});
                    table.insert(v47, {});
                    local v48 = v2;

                    for _, _ in v43 do
                        table.insert(v46, {});
                        table.insert(v47, {});
                    end;

                    if u8[v48] then
                        local v49 = u8[v48];
                        v49.outgoing = v42;
                        v49.query_id = v48;
                        v49.world = v41;
                        v49.refresh = true;
                        v49.include = v43;
                        v49.exclude = v44;
                        v49.with = v45;
                        v49.new_columns = v46;
                        v49.old_columns = v47;
                        v49.from = 1;
                        v49.upto = 25;
                    else
                        u8[v48] = {
                            frame = 0,
                            paused = false,
                            refresh = false,
                            from = 1,
                            upto = 25,
                            outgoing = v42,
                            query_id = v48,
                            world = v41,
                            include = v43,
                            exclude = v44,
                            with = v45,
                            new_columns = v46,
                            old_columns = v47
                        };
                    end;
                end;
            end;
        end;

        for i, v in u14:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v50 = u8[v];

                if v50 then
                    v50.refresh = true;
                end;
            end;
        end;

        for i, v, v2 in u13:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v51 = u8[v];

                if v51 then
                    v51.paused = v2;
                end;
            end;
        end;

        for i, v, v2, v3 in u12:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v52 = u8[v];

                if v52 then
                    v52.refresh = true;
                    v52.from = v2;
                    v52.upto = v3;
                end;
            end;
        end;

        for i, v in u8 do
            if not v.paused or v.refresh == true then
                debug.profilebegin("process query");
                v.refresh = false;
                local world = v.world.world;
                local Name = jecs.Name;

                if check_if_still_valid(world, v.include) and (check_if_still_valid(world, v.exclude) and check_if_still_valid(world, v.with)) then
                    local v53 = world:query(unpack(v.include));

                    if #v.exclude > 0 then
                        v53 = v53:without(unpack(v.exclude));
                    end;

                    if #v.with > 0 then
                        v53 = v53:with(unpack(v.with));
                    end;

                    local from = v.from;
                    local upto = v.upto;
                    local new_columns = v.new_columns;
                    local old_columns = v.old_columns;

                    local function get_name(p54) -- Line: 367
                        -- upvalues: jecs (ref), world (copy), get_name (copy), Name (copy)
                        if jecs.IS_PAIR(p54) then
                            local v55 = jecs.pair_first(world, p54);
                            local v56 = jecs.pair_second(world, p54);

                            return `({get_name(v55)}, {get_name(v56)})`;
                        end;

                        if p54 == jecs.Wildcard then
                            return "*";
                        end;

                        if world:has(p54, Name) then
                            return world:get(p54, Name);
                        end;

                        return `${p54}`;
                    end;

                    local v57 = i;
                    local v58 = v;

                    for i2, v2 in new_columns do
                        local v59 = v58.include[i2 - 1];

                        if v59 then
                            v2[1] = get_name(v59);
                        else
                            v2[1] = "id";
                        end;
                    end;

                    local v60 = v53:archetypes();
                    local v61 = 0;

                    for _, v2 in v60 do
                        v61 = v61 + #v2.entities;
                    end;

                    local table_create_ret = table.create(v61);
                    local v62 = 1;

                    for _, v2 in v60 do
                        local v63 = v2;

                        for i2 = #v2.entities, 1, -1 do
                            table.insert(table_create_ret, v63.entities[i2]);
                            local _ = i2;
                        end;
                    end;

                    table.sort(table_create_ret);

                    for i2 = from, upto do
                        v62 = v62 + 1;
                        local v64 = table_create_ret[i2];
                        local v65;

                        if v64 then
                            new_columns[1][v62] = v64;
                            v65 = i2;

                            for i3, v2 in v58.include do
                                local v66 = world:get(v64, v2);

                                if v66 == nil then
                                    v66 = u1;
                                end;

                                new_columns[i3 + 1][v62] = v66;
                            end;
                        else
                            v65 = i2;
                        end;
                    end;

                    remotes.count_total_entities:fire(v58.outgoing, v57, v61);

                    for i2 = 1, math.max(#new_columns, #old_columns) do
                        local v67 = i2;

                        for i3 = 1, upto do
                            local v68 = new_columns[v67][i3];
                            local v69;

                            if v68 == old_columns[v67][i3] and typeof(v68) ~= "table" then
                                v69 = i3;
                            else
                                local v70;

                                if typeof(v68) == "string" then
                                    v70 = `"{string.sub(v68, 1, 748)}"`;
                                    v69 = i3;
                                elseif typeof(v68) == "table" then
                                    v69 = i3;
                                    local v71 = {};

                                    for i4, v2 in v68 do
                                        if #v71 > 0 then
                                            table.insert(v71, "; ");
                                        end;

                                        local v72;

                                        if type(v2) == "string" then
                                            v72 = `"{v2}"`;
                                        else
                                            v72 = tostring(v2);
                                        end;

                                        local v73 = `{i4}: {v72}`;

                                        if #v73 + 0 + 2 > 750 then
                                            table.insert(v71, "...");
                                            break;
                                        end;

                                        table.insert(v71, v73);
                                    end;

                                    v70 = `\{{table.concat(v71)}}`;
                                elseif v68 == u1 then
                                    v69 = i3;
                                    v70 = "";
                                elseif v68 == nil then
                                    v69 = i3;
                                    v70 = nil;
                                else
                                    local v74 = tostring(v68);
                                    v70 = string.sub(v74, 1, 748);
                                    v69 = i3;
                                end;

                                if v69 ~= 1 then
                                    v68 = v70;
                                end;

                                remotes.update_query_result:fire(v58.outgoing, v57, v58.frame, v67, v69, v68);
                            end;
                        end;
                    end;

                    v58.new_columns = clear_columns(old_columns);
                    v58.old_columns = new_columns;
                    v58.frame = v58.frame + 1;
                    debug.profileend();
                else
                    debug.profileend();
                end;
            end;
        end;
    end;
end;