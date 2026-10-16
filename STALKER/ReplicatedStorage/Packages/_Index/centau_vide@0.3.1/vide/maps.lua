-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local throw = require(script.Parent.throw);
local flags = require(script.Parent.flags);
local graph = require(script.Parent.graph);
local create_node = graph.create_node;
local create_source_node = graph.create_source_node;
local push_child_to_scope = graph.push_child_to_scope;
local update_descendants = graph.update_descendants;
local assert_stable_scope = graph.assert_stable_scope;
local push_scope = graph.push_scope;
local pop_scope = graph.pop_scope;
local evaluate_node = graph.evaluate_node;
local destroy = graph.destroy;

local function check_primitives(p1: table) -- Line: 20
    -- upvalues: flags (copy), throw (copy)
    if not flags.strict then
        return;
    end;

    for _, v in next, p1 do
        if type(v) ~= "table" and (type(v) ~= "userdata" and type(v) ~= "function") then
            throw("table source map cannot return primitives");
        end;
    end;
end;

local function indexes(u2: function, u3: function) -- Line: 29
    -- upvalues: assert_stable_scope (copy), create_node (copy), destroy (copy), push_scope (copy), create_source_node (copy), push_child_to_scope (copy), pop_scope (copy), update_descendants (copy), check_primitives (copy), evaluate_node (copy)
    local v4 = assert_stable_scope();
    local u5 = create_node(v4, false, false);
    local u6 = {};
    local u7 = {};
    local u8 = {};
    local u9 = {};
    local u10 = {};

    local function update_children(p11) -- Line: 39
        -- upvalues: u6 (copy), u9 (copy), destroy (ref), u10 (copy), u7 (copy), u8 (copy), push_scope (ref), u5 (copy), create_node (ref), create_source_node (ref), u3 (copy), push_child_to_scope (ref), pop_scope (ref), update_descendants (ref), check_primitives (ref)
        for i in next, u6 do
            if p11[i] == nil then
                table.insert(u9, i);
            end;
        end;

        for _, v in next, u9 do
            destroy(u10[v]);
            u6[v] = nil;
            u7[v] = nil;
            u8[v] = nil;
            u10[v] = nil;
        end;

        table.clear(u9);
        push_scope(u5);

        for i, v in next, p11 do
            local v12 = u6[i];

            if v12 ~= v then
                if v12 == nil then
                    local v13 = create_node(u5, false, false);
                    u10[i] = v13;
                    local u14 = create_source_node(v);
                    push_scope(v13);
                    local success, result = pcall(u3, function() -- Line: 74
                        -- upvalues: push_child_to_scope (ref), u14 (copy)
                        push_child_to_scope(u14);

                        return u14.cache;
                    end, i);
                    pop_scope();

                    if not success then
                        pop_scope();
                        error(result, 0);
                    end;

                    u8[i] = u14;
                    u7[i] = result;
                else
                    u8[i].cache = v;
                    update_descendants(u8[i]);
                end;

                u6[i] = v;
            end;
        end;

        pop_scope();
        local table_create_ret = table.create(#u10);

        for _, v in next, u7 do
            table.insert(table_create_ret, v);
        end;

        check_primitives(table_create_ret);

        return table_create_ret;
    end;

    local u15 = create_node(v4, function() -- Line: 108
        -- upvalues: update_children (copy), u2 (copy)
        return update_children(u2());
    end, false);
    evaluate_node(u15);

    return function() -- Line: 114
        -- upvalues: push_child_to_scope (ref), u15 (copy)
        push_child_to_scope(u15);

        return u15.cache;
    end;
end;

local function values(u16: function, u17: function) -- Line: 120
    -- upvalues: assert_stable_scope (copy), create_node (copy), flags (copy), throw (copy), push_scope (copy), create_source_node (copy), push_child_to_scope (copy), pop_scope (copy), update_descendants (copy), destroy (copy), check_primitives (copy), evaluate_node (copy)
    local v18 = assert_stable_scope();
    local u19 = create_node(v18, false, false);
    local u20 = {};
    local u21 = {};
    local u22 = {};
    local u23 = {};
    local u24 = {};

    local function u32(p25: table) -- Line: 130
        -- upvalues: u20 (ref), u21 (ref), flags (ref), throw (ref), push_scope (ref), u19 (copy), create_node (ref), u24 (copy), create_source_node (ref), u17 (copy), push_child_to_scope (ref), pop_scope (ref), u23 (copy), u22 (copy), update_descendants (ref), destroy (ref), check_primitives (ref)
        local v26 = u20;
        local v27 = u21;

        if flags.strict then
            local v28 = {};

            for _, v in next, p25 do
                if v28[v] ~= nil then
                    throw("duplicate table value detected");
                end;

                v28[v] = true;
            end;
        end;

        push_scope(u19);

        for i, v in next, p25 do
            v27[v] = i;
            local v29 = v26[v];

            if v29 == nil then
                local v30 = create_node(u19, false, false);
                u24[v] = v30;
                local u31 = create_source_node(i);
                push_scope(v30);
                local success, result = pcall(u17, v, function() -- Line: 159
                    -- upvalues: push_child_to_scope (ref), u31 (copy)
                    push_child_to_scope(u31);

                    return u31.cache;
                end);
                pop_scope();

                if not success then
                    pop_scope();
                    error(result, 0);
                end;

                u23[v] = u31;
                u22[v] = result;
            else
                if v29 ~= i then
                    u23[v].cache = i;
                    update_descendants(u23[v]);
                end;

                v26[v] = nil;
            end;
        end;

        pop_scope();

        for i in next, v26 do
            destroy(u24[i]);
            u22[i] = nil;
            u23[i] = nil;
            u24[i] = nil;
        end;

        table.clear(v26);
        u20 = v27;
        u21 = v26;
        local table_create_ret = table.create(#u24);

        for _, v in next, u22 do
            table.insert(table_create_ret, v);
        end;

        check_primitives(table_create_ret);

        return table_create_ret;
    end;

    local u33 = create_node(v18, function() -- Line: 207
        -- upvalues: u32 (copy), u16 (copy)
        return u32(u16());
    end, false);
    evaluate_node(u33);

    return function() -- Line: 213
        -- upvalues: push_child_to_scope (ref), u33 (copy)
        push_child_to_scope(u33);

        return u33.cache;
    end;
end;

return function() -- Line: 219
    -- upvalues: indexes (copy), values (copy)
    return indexes, values;
end;