-- Decompiled with Potassium's decompiler.

local Random_new_ret = Random.new();
local u1 = table;
local u2 = {};

function u2.contains(p3, p4) -- Line: 27
    -- upvalues: u2 (copy)
    return u2.indexOf(p3, p4) ~= nil;
end;

function u2.indexOf(p5, p6) -- Line: 32
    -- upvalues: u2 (copy)
    return table.find(p5, p6) or u2.keyOf(p5, p6);
end;

function u2.keyOf(p7, p8) -- Line: 41
    for i, v in pairs(p7) do
        if v == p8 then
            return i;
        end;
    end;

    return nil;
end;

function u2.insertAndGetIndexOf(p9, p10) -- Line: 51
    p9[#p9 + 1] = p10;

    return #p9;
end;

function u2.skip(p11, p12) -- Line: 57
    return table.move(p11, p12 + 1, #p11, 1, table.create(#p11 - p12));
end;

function u2.take(p13, p14) -- Line: 62
    return table.move(p13, 1, p14, 1, table.create(p14));
end;

function u2.range(p15, p16, p17) -- Line: 67
    return table.move(p15, p16, p17, 1, table.create(p17 - p16 + 1));
end;

function u2.skipAndTake(p18, p19, p20) -- Line: 72
    return table.move(p18, p19 + 1, p19 + p20, 1, table.create(p20));
end;

function u2.random(p21) -- Line: 77
    -- upvalues: Random_new_ret (copy)
    return p21[Random_new_ret:NextInteger(1, #p21)];
end;

function u2.join(p22, p23) -- Line: 82
    local table_create_ret = table.create(#p22 + #p23);
    table.move(p22, 1, #p22, 1, table_create_ret);

    return table.move(p23, 1, #p23, #p22 + 1, table_create_ret);
end;

function u2.removeObject(p24, p25) -- Line: 89
    -- upvalues: u2 (copy)
    local v26 = u2.indexOf(p24, p25);

    if v26 then
        table.remove(p24, v26);
    end;
end;

return setmetatable({}, {
    __index = function(p27, p28) -- Line: 97, Name: __index
        -- upvalues: u2 (copy), u1 (copy)
        if u2[p28] == nil then
            return u1[p28];
        end;

        return u2[p28];
    end,

    __newindex = function(p29, p30, p31) -- Line: 105, Name: __newindex
        error("Add new table entries by editing the Module itself.");
    end
});