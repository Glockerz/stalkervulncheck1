-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 25
    -- upvalues: u1 (copy)
    local v2 = setmetatable({
        size = 0,
        columns = {}
    }, u1);
    setmetatable(v2.columns, {
        __index = function(p3: table, p4: number) -- Line: 32, Name: __index
            p3[p4] = {};

            return p3[p4];
        end
    });

    return v2;
end;

function u1.add(p5, ...) -- Line: 41
    assert(... ~= nil, "first argument cannot be nil");
    local columns = p5.columns;
    local v6 = p5.size + 1;
    p5.size = v6;

    for i = 1, select("#", ...) do
        columns[i][v6] = select(i, ...);
        local _ = i;
    end;
end;

function u1.clear(p7) -- Line: 54
    p7.size = 0;

    for _, v in next, p7.columns do
        table.clear(v);
    end;
end;

local function iter(u8) -- Line: 61
    local columns = u8.columns;
    local size = u8.size;
    local u9 = 0;

    if #columns <= 1 then
        local u10 = columns[1];

        return function() -- Line: 68
            -- upvalues: u9 (ref), u10 (copy), size (copy), u8 (copy)
            u9 = u9 + 1;
            local v11 = u10[u9];

            if u9 == size then
                u8:clear();
            end;

            return v11;
        end;
    end;

    local table_create_ret = table.create(#columns);

    return function() -- Line: 76
        -- upvalues: u9 (ref), columns (copy), table_create_ret (copy), size (copy), u8 (copy)
        u9 = u9 + 1;

        for i, v in next, columns do
            table_create_ret[i] = v[u9];
        end;

        if u9 == size then
            u8:clear();
        end;

        return unpack(table_create_ret);
    end;
end;

u1.iter = iter;
u1.__iter = iter;

function u1.__len(p12) -- Line: 90
    return p12.size;
end;

return function(p13: table?) -- Line: 101
    -- upvalues: u1 (copy)
    local u14 = u1.new();

    if p13 then
        local v15 = p13.connect or p13.Connect;
        assert(v15, "signal has no member `connect()`");
        v15(p13, function(...) -- Line: 107
            -- upvalues: u14 (copy)
            u14:add(...);
        end);
    end;

    return u14;
end;