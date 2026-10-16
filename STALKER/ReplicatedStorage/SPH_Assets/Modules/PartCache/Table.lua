-- Decompiled with Potassium's decompiler.

local Random_new_ret = Random.new();
local u1 = {};

for i, v in pairs(table) do
    u1[i] = v;
end;

function u1.contains(p2, p3) -- Line: 30
    -- upvalues: u1 (copy)
    return u1.indexOf(p2, p3) ~= nil;
end;

function u1.indexOf(p4, p5) -- Line: 35
    -- upvalues: u1 (copy)
    return table.find(p4, p5) or u1.keyOf(p4, p5);
end;

function u1.keyOf(p6, p7) -- Line: 44
    for i, v in pairs(p6) do
        if v == p7 then
            return i;
        end;
    end;

    return nil;
end;

function u1.skip(p8, p9) -- Line: 54
    return table.move(p8, p9 + 1, #p8, 1, table.create(#p8 - p9));
end;

function u1.take(p10, p11) -- Line: 59
    return table.move(p10, 1, p11, 1, table.create(p11));
end;

function u1.range(p12, p13, p14) -- Line: 64
    return table.move(p12, p13, p14, 1, table.create(p14 - p13 + 1));
end;

function u1.skipAndTake(p15, p16, p17) -- Line: 69
    return table.move(p15, p16 + 1, p16 + p17, 1, table.create(p17));
end;

function u1.random(p18) -- Line: 74
    -- upvalues: Random_new_ret (copy)
    return p18[Random_new_ret:NextInteger(1, #p18)];
end;

function u1.join(p19, p20) -- Line: 79
    local table_create_ret = table.create(#p19 + #p20);
    table.move(p19, 1, #p19, 1, table_create_ret);

    return table.move(p20, 1, #p20, #p19 + 1, table_create_ret);
end;

function u1.removeObject(p21, p22) -- Line: 86
    -- upvalues: u1 (copy)
    local v23 = u1.indexOf(p21, p22);

    if v23 then
        table.remove(p21, v23);
    end;
end;

function u1.expand(p24, p25) -- Line: 95
    if p25 < 0 then
        error("Cannot expand a table by a negative amount of objects.");
    end;

    local table_create_ret = table.create(#p24 + p25);

    for i = 1, #p24 do
        table_create_ret[i] = p24[i];
        local _ = i;
    end;

    return table_create_ret;
end;

return u1;