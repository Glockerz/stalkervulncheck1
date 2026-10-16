-- Decompiled with Potassium's decompiler.

local jecs = require(script.Parent.Parent.Parent.Parent.jecs);
local hash_connector = require(script.Parent.Parent.Parent.modules.hash_connector);
local lon = require(script.Parent.Parent.Parent.modules.lon);
local queue = require(script.Parent.Parent.Parent.modules.queue);
local remotes = require(script.Parent.Parent.Parent.modules.remotes);
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector);
require(script.Parent.Parent.Parent.modules.types);
local public = require(script.Parent.Parent.public);
local NIL = require(script.Parent.Parent.watch).NIL;

return function() -- Line: 33
    -- upvalues: remotes (copy), public (copy), jecs (copy), NIL (copy), lon (copy), hash_connector (copy), queue (copy), reverse_connector (copy)
    local u1 = {};
    local u2 = {};

    local function create_watch_for_id(p3: any, p4: any, p5: number) -- Line: 38
        -- upvalues: u1 (copy)
        u1[p5] = p3:create_watch_for_system(p4);
    end;

    local function send_watch_data_to(p6: any, p7: number, p8: number) -- Line: 47
        -- upvalues: u1 (copy), remotes (ref), public (ref), jecs (ref), NIL (ref), lon (ref)
        local v9 = {};
        local v10 = u1[p7].watch.frames[p8];

        if not v10 then
            remotes.update_watch_data:fire(p6, p7, p8, nil);

            return;
        end;

        for _, v in ipairs(public) do
            if v.world ~= nil then
                v9[v.world] = jecs.Name;
            end;
        end;

        local v11 = {
            types = v10.types,
            entities = v10.entities,
            component = table.clone(v10.component),
            values = table.clone(v10.values)
        };

        for i, v in v11.component do
            local v12 = v10.worlds[i];
            v11.component[i] = v12:get(v, v9[v12]) or v;
        end;

        for i, v in v11.values do
            if v == NIL then
                v11.values[i] = "";
            end;

            v11.values[i] = lon.output(v, false);
        end;

        remotes.update_watch_data:fire(p6, p7, p8, v11);
    end;

    local function remove_watch_id(p13: number) -- Line: 83
        -- upvalues: u1 (copy), u2 (copy)
        if not u1[p13] then
            return;
        end;

        u1[p13].untrack();
        u1[p13] = nil;
        u2[p13] = nil;
    end;

    local function start_record_watch(p14: number) -- Line: 90
        -- upvalues: u1 (copy)
        u1[p14].active = true;
    end;

    local function stop_record_watch(p15: number) -- Line: 95
        -- upvalues: u1 (copy)
        u1[p15].active = false;
    end;

    local function connect_watch(p16: any, p17: number) -- Line: 100
        -- upvalues: u2 (copy), hash_connector (ref), u1 (copy), remotes (ref)
        u2[p17] = u2[p17] or {};
        u2[p17][hash_connector(p16)] = p16;

        for i, v in u1[p17].watch.frames do
            remotes.update_overview:fire(p16, p17, i, #v.types);
        end;
    end;

    local function disconnect_watch(p18: any, p19: number) -- Line: 110
        -- upvalues: u2 (copy), hash_connector (ref)
        if not u2[p19] then
            return;
        end;

        u2[p19][hash_connector(p18)] = nil;
    end;

    local u20 = queue(remotes.create_watch);
    local u21 = queue(remotes.remove_watch);
    local u22 = queue(remotes.request_watch_data);
    local u23 = queue(remotes.stop_watch);
    local u24 = queue(remotes.start_record_watch);
    local u25 = queue(remotes.connect_watch);
    local u26 = queue(remotes.disconnect_watch);

    return function() -- Line: 124
        -- upvalues: u20 (copy), public (ref), u1 (copy), u23 (copy), u21 (copy), u2 (copy), u22 (copy), send_watch_data_to (copy), reverse_connector (ref), u24 (copy), u25 (copy), connect_watch (copy), u26 (copy), hash_connector (ref), remotes (ref)
        for _, v, v2, v3 in u20:iter() do
            local v27 = public[v];

            if v27.class_name == "Scheduler" and v27 ~= nil then
                u1[v3] = v27:create_watch_for_system(v2);
            end;
        end;

        for _, v in u23:iter() do
            u1[v].active = false;
        end;

        for _, v in u21:iter() do
            if u1[v] then
                u1[v].untrack();
                u1[v] = nil;
                u2[v] = nil;
            end;
        end;

        for i, v, v2 in u22:iter() do
            send_watch_data_to(reverse_connector(i), v, v2);
        end;

        for _, v in u24:iter() do
            u1[v].active = true;
        end;

        for i, v in u25:iter() do
            connect_watch(reverse_connector(i), v);
        end;

        for i, v in u26:iter() do
            if u2[v] then
                u2[v][hash_connector(i)] = nil;
            end;
        end;

        for i, v in u2 do
            local v28 = u1[i];
            local frame = v28.watch.frame;
            local v29 = #(v28.watch.frames[frame] or {
                types = {}
            }).types;
            local v30 = i;

            for _, v2 in v do
                remotes.update_overview:fire(v2, v30, frame, v29);
            end;
        end;
    end;
end;