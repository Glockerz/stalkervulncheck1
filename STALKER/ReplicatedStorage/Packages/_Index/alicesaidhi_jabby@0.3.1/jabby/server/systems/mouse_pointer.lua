-- Decompiled with Potassium's decompiler.

local jecs = require(script.Parent.Parent.Parent.Parent.jecs);
local queue = require(script.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.modules.remotes);
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector);
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check);
require(script.Parent.Parent.Parent.modules.types);
local public = require(script.Parent.Parent.public);
local entity_index_try_get = jecs.entity_index_try_get;
local IS_PAIR = jecs.IS_PAIR;
local pair_first = jecs.pair_first;
local pair_second = jecs.pair_second;
local u1 = {};

local function convert_component(p2, p3, p4) -- Line: 16
    -- upvalues: IS_PAIR (copy), convert_component (copy), pair_first (copy), pair_second (copy)
    if IS_PAIR(p4) then
        return `({convert_component(p2, p3, pair_first(p2, p4))}, {convert_component(p2, p3, pair_second(p2, p4))})`;
    end;

    return p2:get(p4, p3) or `${tostring(p4)}`;
end;

local function get_type(p5: table) -- Line: 26
    local v6, v7 = next(p5);

    return v6 == nil and "" or `[{typeof(v6)}]: {typeof(v7)}`;
end;

local function get_string_keys(p8: table) -- Line: 32
    local v9 = 0;
    local v10 = {};

    for i in p8 do
        if v9 > 3 then
            return v10, true;
        end;

        if typeof(i) == "string" then
            table.insert(v10, i);
            v9 = v9 + 1;
        end;
    end;

    return v10, false;
end;

local function is_tag(p11, p12) -- Line: 44
    -- upvalues: jecs (copy)
    return jecs.is_tag(p11, p12);
end;

local function get_all_components(u13, p14) -- Line: 48
    -- upvalues: entity_index_try_get (copy), u1 (copy), jecs (copy)
    local v15 = entity_index_try_get(u13.entity_index, p14);

    if not v15 then
        return u1;
    end;

    local archetype = v15.archetype;

    if not archetype then
        return u1;
    end;

    local v16 = {};

    for _, v in archetype.types do
        table.insert(v16, v);
    end;

    table.sort(v16, function(p17, p18) -- Line: 60
        -- upvalues: u13 (copy), jecs (ref)
        if jecs.is_tag(u13, p17) and jecs.is_tag(u13, p18) then
            return p17 < p18;
        end;

        if jecs.is_tag(u13, p17) then
            return true;
        end;

        if jecs.is_tag(u13, p18) then
            return false;
        end;

        return p17 < p18;
    end);

    return v16;
end;

local function obtain_string(p19, p20) -- Line: 70
    -- upvalues: jecs (copy), get_all_components (copy), convert_component (copy), get_string_keys (copy)
    local v21 = p20:get(p19, jecs.Name);
    local v22 = { (`<b>{not v21 and "#" or `{v21} #`}{p19}</b>\n`) };
    local v23 = #v22[1];
    local v24 = false;

    for _, v in get_all_components(p20, p19) do
        if v ~= jecs.Name then
            local v25 = convert_component(p20, jecs.Name, v);
            local v26;

            if jecs.is_tag(p20, v) then
                v26 = nil;
            else
                v26 = p20:get(p19, v);
            end;

            local v27;

            if typeof(v26) == "table" then
                if #get_string_keys(v26) > 0 then
                    local v28 = { (`<b>{v25}</b>:`) };
                    local v29 = #v28[1];

                    for i, v2 in pairs(v26) do
                        if #v28 > 0 then
                            table.insert(v28, "\n");
                        end;

                        local v30;

                        if type(v2) == "string" then
                            v30 = `{v2}`;
                        elseif typeof(v2) == "table" then
                            local v31, v32 = next(v2);
                            v30 = v31 == nil and "" or `[{typeof(v31)}]: {typeof(v32)}`;
                        else
                            v30 = tostring(v2);
                        end;

                        if #v30 > 32 then
                            v30 = `{string.sub(v30, 1, 30)}..`;
                        end;

                        local v33 = `{i}: {v30}`;

                        if v29 + #v33 + 2 > 32 then
                            table.insert(v28, "...");
                            break;
                        end;

                        table.insert(v28, v33);
                    end;

                    v27 = `{table.concat(v28)}`;
                else
                    local v34, v35 = next(v26);
                    v27 = `<b>{v25}</b>: {v34 == nil and "" or `[{typeof(v34)}]: {typeof(v35)}`}`;
                end;
            elseif jecs.is_tag(p20, v) then
                v27 = `<b>{v25}</b>`;
            else
                local v36 = tostring(v26);

                if #v36 > 32 then
                    v27 = `<b>{v25}</b>: {string.sub(v36, 1, 30)}..`;
                else
                    v27 = `<b>{v25}</b>: {v36}`;
                end;
            end;

            if v23 + #v27 < 840 then
                v23 = v23 + #v27;
                table.insert(v22, v27);
            else
                v24 = true;
            end;
        end;
    end;

    local table_concat_ret = table.concat(v22, "\n");

    if v24 then
        table_concat_ret = table_concat_ret .. "...";
    end;

    return table_concat_ret;
end;

return function() -- Line: 141
    -- upvalues: queue (copy), remotes (copy), traffic_check (copy), public (copy), reverse_connector (copy), obtain_string (copy), jecs (copy)
    local u37 = queue(remotes.send_mouse_pointer);

    return function() -- Line: 145
        -- upvalues: u37 (copy), traffic_check (ref), public (ref), reverse_connector (ref), remotes (ref), obtain_string (ref), jecs (ref)
        for i, v, v2, v3 in u37:iter() do
            if traffic_check.check_no_wl(i.host) then
                local v38 = public[v];
                local world = v38.world;
                local v39 = reverse_connector(i);

                if (v38.entities ~= nil or v38.get_entity_from_part ~= nil) and (v38 and v38.class_name == "World") then
                    local v40 = workspace:Raycast(v2, v3 * 1000);

                    if v40 then
                        local Instance = v40.Instance;

                        if v38.get_entity_from_part == nil and v38.entities == nil then
                            remotes.send_mouse_entity:fire(v39, v);
                        else
                            local v41, v42;

                            if v38.get_entity_from_part == nil then
                                v41 = v38.entities[Instance];
                                v42 = v;

                                while v41 == nil and Instance.Parent ~= game do
                                    v41 = v38.entities[Instance];
                                    Instance = Instance.Parent;
                                end;
                            else
                                v41, Instance = v38.get_entity_from_part(Instance);
                                v42 = v;
                            end;

                            if v41 then
                                local v43 = obtain_string(v41, world, jecs.Name);
                                remotes.send_mouse_entity:fire(v39, v42, Instance, v41, v43);
                            else
                                remotes.send_mouse_entity:fire(v39, v42);
                            end;
                        end;
                    else
                        remotes.send_mouse_entity:fire(v39, v);
                    end;
                end;
            end;
        end;
    end;
end;