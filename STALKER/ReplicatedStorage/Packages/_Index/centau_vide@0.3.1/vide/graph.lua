-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local throw = require(script.Parent.throw);
local flags = require(script.Parent.flags);
local u1 = {
    n = 0
};

local function ycall(p2: function, p3: any) -- Line: 27
    local coroutine_create_ret = coroutine.create(xpcall);
    local coroutine_resume_ret, v5, v6 = coroutine.resume(coroutine_create_ret, p2, function(p4: string) -- Line: 29, Name: efn
        return debug.traceback(p4, 3);
    end, p3);
    assert(coroutine_resume_ret);

    if coroutine.status(coroutine_create_ret) == "dead" then
        return v5, v6;
    end;

    return false, debug.traceback(coroutine_create_ret, "attempt to yield in reactive scope");
end;

local function flush_cleanups(p7: table) -- Line: 83
    -- upvalues: throw (copy)
    if p7.cleanups then
        for _, v in next, p7.cleanups do
            local success, result = pcall(v);

            if not success then
                throw((`cleanup error: {result}`));
            end;
        end;

        table.clear(p7.cleanups);
    end;
end;

local function find_and_swap_pop(p8: table, p9: any) -- Line: 94
    local table_find_ret = table.find(p8, p9);
    local v10 = #p8;
    p8[table_find_ret] = p8[v10];
    p8[v10] = nil;
end;

local function unparent(p11: table) -- Line: 101
    local parents = p11.parents;

    for i, v in parents do
        local table_find_ret = table.find(v, p11);
        local v12 = #v;
        v[table_find_ret] = v[v12];
        v[v12] = nil;
        parents[i] = nil;
    end;
end;

local function destroy(p13: table) -- Line: 110
    -- upvalues: flush_cleanups (copy), destroy (copy)
    flush_cleanups(p13);
    local parents = p13.parents;

    for i, v in parents do
        local table_find_ret = table.find(v, p13);
        local v14 = #v;
        v[table_find_ret] = v[v14];
        v[v14] = nil;
        parents[i] = nil;
    end;

    if p13.owner then
        local owned = p13.owner.owned;
        local table_find_ret = table.find(owned, p13);
        local v15 = #owned;
        owned[table_find_ret] = owned[v15];
        owned[v15] = nil;
        p13.owner = false;
    end;

    if p13.owned then
        local owned = p13.owned;

        while owned[1] do
            destroy(owned[1]);
        end;
    end;
end;

local function destroy_owned(p16: table) -- Line: 125
    -- upvalues: destroy (copy)
    if p16.owned then
        local owned = p16.owned;

        while owned[1] do
            destroy(owned[1]);
        end;
    end;
end;

local u17 = {
    n = 0
};

local function evaluate_node(p18: table) -- Line: 134
    -- upvalues: flags (copy), flush_cleanups (copy), destroy (copy), u1 (copy), ycall (copy), u17 (copy), throw (copy)
    if flags.strict then
        local cache = p18.cache;

        for i = 1, 2 do
            local cache2 = p18.cache;
            flush_cleanups(p18);
            local v19;

            if p18.owned then
                local owned = p18.owned;
                v19 = i;

                while owned[1] do
                    destroy(owned[1]);
                end;
            else
                v19 = i;
            end;

            local v20 = u1.n + 1;
            u1.n = v20;
            u1[v20] = p18;
            local v21, v22 = ycall(p18.effect, cache2);
            local n = u1.n;
            u1.n = n - 1;
            u1[n] = nil;

            if not v21 then
                table.clear(u17);
                u17.n = 0;
                throw((`effect stacktrace:\n{v22}`));
            end;

            p18.cache = v22;
        end;

        return cache ~= p18.cache;
    end;

    local cache = p18.cache;
    flush_cleanups(p18);

    if p18.owned then
        local owned = p18.owned;

        while owned[1] do
            destroy(owned[1]);
        end;
    end;

    local v23 = u1.n + 1;
    u1.n = v23;
    u1[v23] = p18;
    local success, result = pcall(p18.effect, p18.cache);
    local n = u1.n;
    u1.n = n - 1;
    u1[n] = nil;

    if not success then
        table.clear(u17);
        u17.n = 0;
        throw((`effect stacktrace:\n{result}\n`));
    end;

    p18.cache = result;

    return cache ~= result;
end;

local function queue_children_for_update(p24: table) -- Line: 179
    -- upvalues: u17 (copy)
    local n = u17.n;

    while p24[1] do
        n = n + 1;
        u17[n] = p24[1];
        local v25 = p24[1];
        local parents = v25.parents;

        for i, v in parents do
            local table_find_ret = table.find(v, v25);
            local v26 = #v;
            v[table_find_ret] = v[v26];
            v[v26] = nil;
            parents[i] = nil;
        end;
    end;

    u17.n = n;
end;

return table.freeze({
    push_scope = function(p27: table) -- Line: 63, Name: push_scope
        -- upvalues: u1 (copy)
        local v28 = u1.n + 1;
        u1.n = v28;
        u1[v28] = p27;
    end,

    pop_scope = function() -- Line: 69, Name: pop_scope
        -- upvalues: u1 (copy)
        local n = u1.n;
        u1.n = n - 1;
        u1[n] = nil;
    end,

    evaluate_node = evaluate_node,

    get_scope = function() -- Line: 41, Name: get_scope
        -- upvalues: u1 (copy)
        return u1[u1.n];
    end,

    assert_stable_scope = function() -- Line: 45, Name: assert_stable_scope
        -- upvalues: u1 (copy), throw (copy)
        local v29 = u1[u1.n];

        if not v29 then
            return throw((`cannot use {debug.info(2, "n")}() outside a stable or reactive scope`));
        end;

        if v29.effect then
            throw("cannot create a new reactive scope inside another reactive scope");
        end;

        return v29;
    end,

    push_cleanup = function(p30: table, p31: function) -- Line: 75, Name: push_cleanup
        if p30.cleanups then
            table.insert(p30.cleanups, p31);

            return;
        end;

        p30.cleanups = { p31 };
    end,

    destroy = destroy,
    flush_cleanups = flush_cleanups,

    push_child_to_scope = function(p32: table) -- Line: 233, Name: push_child_to_scope
        -- upvalues: u1 (copy)
        local v33 = u1[u1.n];

        if v33 and v33.effect then
            table.insert(p32, v33);
            table.insert(v33.parents, p32);
        end;
    end,

    update_descendants = function(p34: table) -- Line: 210, Name: update_descendants
        -- upvalues: u17 (copy), flags (copy), evaluate_node (copy)
        local n = u17.n;
        local n2 = u17.n;

        while p34[1] do
            n2 = n2 + 1;
            u17[n2] = p34[1];
            local v35 = p34[1];
            local parents = v35.parents;

            for i, v in parents do
                local table_find_ret = table.find(v, v35);
                local v36 = #v;
                v[table_find_ret] = v[v36];
                v[v36] = nil;
                parents[i] = nil;
            end;
        end;

        u17.n = n2;

        if flags.batch then
            return;
        end;

        local v37 = n + 1;

        while v37 <= u17.n do
            local v38 = u17[v37];

            if v38.owner and evaluate_node(v38) then
                local n3 = u17.n;

                while v38[1] do
                    n3 = n3 + 1;
                    u17[n3] = v38[1];
                    local v39 = v38[1];
                    local parents = v39.parents;

                    for i, v in parents do
                        local table_find_ret = table.find(v, v39);
                        local v40 = #v;
                        v[table_find_ret] = v[v40];
                        v[v40] = nil;
                        parents[i] = nil;
                    end;
                end;

                u17.n = n3;
            end;

            u17[v37] = false;
            v37 = v37 + 1;
        end;

        u17.n = n;
    end,

    push_child = function(p41: table, p42: table) -- Line: 58, Name: push_child
        table.insert(p41, p42);
        table.insert(p42.parents, p41);
    end,

    create_node = function(p43, p44, p45) -- Line: 240, Name: create_node
        local v46 = {
            cleanups = false,
            context = false,
            owned = false,
            cache = p45,
            effect = p44,
            owner = p43,
            parents = {}
        };

        if p43 then
            if p43.owned then
                table.insert(p43.owned, v46);

                return v46;
            end;

            p43.owned = { v46 };
        end;

        return v46;
    end,

    create_source_node = function(p47) -- Line: 265, Name: create_source_node
        return {
            cache = p47
        };
    end,

    get_children = function(p48: table) -- Line: 269, Name: get_children
        return { unpack(p48) };
    end,

    flush_update_queue = function(p49: number) -- Line: 193, Name: flush_update_queue
        -- upvalues: u17 (copy), evaluate_node (copy)
        local v50 = p49 + 1;

        while v50 <= u17.n do
            local v51 = u17[v50];

            if v51.owner and evaluate_node(v51) then
                local n = u17.n;

                while v51[1] do
                    n = n + 1;
                    u17[n] = v51[1];
                    local v52 = v51[1];
                    local parents = v52.parents;

                    for i, v in parents do
                        local table_find_ret = table.find(v, v52);
                        local v53 = #v;
                        v[table_find_ret] = v[v53];
                        v[v53] = nil;
                        parents[i] = nil;
                    end;
                end;

                u17.n = n;
            end;

            u17[v50] = false;
            v50 = v50 + 1;
        end;

        u17.n = p49;
    end,

    get_update_queue_length = function() -- Line: 189, Name: get_update_queue_length
        -- upvalues: u17 (copy)
        return u17.n;
    end,

    set_context = function(p54: table, p55: number, p56: any) -- Line: 273, Name: set_context
        if p54.context then
            p54.context[p55] = p56;

            return;
        end;

        p54.context = {
            [p55] = p56
        };
    end,

    scopes = u1
});