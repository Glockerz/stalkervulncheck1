-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.__tostring(p2) -- Line: 16
    local v3 = "\n";

    for i = 1, p2.length do
        if i == 1 then
            v3 = v3 .. "\n";
        end;

        local v4 = i;
        local v5 = "";

        for i2 = 1, p2.width do
            local v6;

            if i2 == p2.width then
                v5 = v5 .. `{p2.matrix[v4][i2]}`;
                v6 = i2;
            else
                v5 = v5 .. `{p2.matrix[v4][i2]}, `;
                v6 = i2;
            end;
        end;

        v3 = v3 .. v5 .. "\n";
    end;

    return v3;
end;

function u1.extend(p7) -- Line: 41
    p7.length = p7.length + 1;
    p7.width = p7.length + 1;
    p7.matrix[p7.length] = {};

    for i = 1, p7.width do
        p7.matrix[p7.length][i] = 0;
        local _ = i;
    end;

    for i = 1, p7.length do
        p7.matrix[i][p7.width] = 0;
        local _ = i;
    end;
end;

function u1.setEdge(p8, p9, p10, p11) -- Line: 55
    p8.matrix[p9][p10] = p11;
end;

function u1.toAdjacencyList(p12) -- Line: 59
    local v13 = {};

    for i = 1, p12.length do
        v13[i] = {};
        local v14 = i;

        for i2 = 1, p12.width do
            local v15;

            if p12.matrix[v14][i2] == 0 then
                v15 = i2;
            else
                table.insert(v13[v14], i2);
                v15 = i2;
            end;
        end;
    end;

    return v13;
end;

function u1.topologicalSort(p16) -- Line: 74
    local v17 = p16:toAdjacencyList();
    local table_create_ret = table.create(p16.length, 0);
    local v18 = {};

    for i = 1, p16.length do
        local _ = i;

        for _, v in v17[i] do
            table_create_ret[v] = table_create_ret[v] + 1;
        end;
    end;

    local v19 = {};

    for i = 1, p16.length do
        local v20;

        if table_create_ret[i] == 0 then
            table.insert(v19, i);
            v20 = i;
        else
            v20 = i;
        end;
    end;

    while #v19 ~= 0 do
        local table_remove_ret = table.remove(v19, 1);
        table.insert(v18, table_remove_ret);

        for _, v in v17[table_remove_ret] do
            table_create_ret[v] = table_create_ret[v] - 1;

            if table_create_ret[v] == 0 then
                table.insert(v19, v);
            end;
        end;
    end;

    if #v18 == p16.length then
        return v18;
    end;

    return nil;
end;

function u1.new() -- Line: 112
    -- upvalues: u1 (copy)
    return setmetatable({
        length = 0,
        width = 0,
        matrix = {}
    }, u1);
end;

local u21 = {};
u21.__index = u21;

function u21.getOrderedList(p22) -- Line: 144
    local v23 = {};
    local v24 = p22.matrix:topologicalSort();

    if not v24 then
        return nil;
    end;

    for _, v in v24 do
        table.insert(v23, p22.nodes[v]);
    end;

    return v23;
end;

function u21.insertBefore(p25, p26, p27) -- Line: 159
    if not table.find(p25.nodes, p27) then
        error("Node not found in DependencyGraph:insertBefore(_, unknown)");
    end;

    local table_find_ret = table.find(p25.nodes, p26);

    if not table_find_ret then
        table.insert(p25.nodes, p26);
        table_find_ret = #p25.nodes;
    end;

    local table_find_ret2 = table.find(p25.nodes, p27);
    p25.matrix:extend();
    p25.matrix:setEdge(table_find_ret, table_find_ret2, 1);

    return p25;
end;

function u21.insertAfter(p28, p29, p30) -- Line: 178
    if not table.find(p28.nodes, p30) then
        error("Node not found in DependencyGraph:insertAfter(_, unknown)");
    end;

    local table_find_ret = table.find(p28.nodes, p29);

    if not table_find_ret then
        table.insert(p28.nodes, p29);
        table_find_ret = #p28.nodes;
    end;

    local table_find_ret2 = table.find(p28.nodes, p30);
    p28.matrix:extend();
    p28.matrix:setEdge(table_find_ret2, table_find_ret, 1);

    return p28;
end;

function u21.insert(p31, p32) -- Line: 197
    local v33 = #p31.nodes;
    table.insert(p31.nodes, p32);
    local v34 = #p31.nodes;
    p31.matrix:extend();

    if v33 ~= 0 then
        p31.matrix:setEdge(v33, v34, 1);
    end;

    return p31;
end;

function u21.new() -- Line: 211
    -- upvalues: u1 (copy), u21 (copy)
    local v35 = {
        length = 0,
        width = 0,
        nodes = {},
        matrix = u1.new()
    };

    return setmetatable(v35, u21);
end;

return u21;