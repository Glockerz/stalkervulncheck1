-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;

function v1.push(p5: table, p6: table) -- Line: 22
    -- upvalues: u3 (ref)
    local v7 = #p5 + 1;
    p5[v7] = p6;
    u3(p5, p6, v7);
end;

function v1.peek(p8: table) -- Line: 29
    return p8[1];
end;

function v1.pop(p9: table) -- Line: 33
    -- upvalues: u4 (ref)
    local v10 = p9[1];

    if v10 == nil then
        return nil;
    end;

    local v11 = p9[#p9];
    p9[#p9] = nil;

    if v11 ~= v10 then
        p9[1] = v11;
        u4(p9, v11, 1);
    end;

    return v10;
end;

u3 = function(p12: table, p13: table, p14: number) -- Line: 49
    -- upvalues: u2 (ref)
    while true do
        local math_floor_ret = math.floor(p14 / 2);
        local v15 = p12[math_floor_ret];

        if v15 == nil or u2(v15, p13) <= 0 then
            break;
        end;

        p12[math_floor_ret] = p13;
        p12[p14] = v15;
        p14 = math_floor_ret;
    end;
end;

u4 = function(p16: table, p17: table, p18: number) -- Line: 65
    -- upvalues: u2 (ref)
    while p18 < #p16 do
        local v19 = p18 * 2;
        local v20 = p16[v19];
        local v21 = v19 + 1;
        local v22 = p16[v21];

        if v20 == nil or u2(v20, p17) >= 0 then
            if v22 == nil or u2(v22, p17) >= 0 then
                return;
            end;

            p16[p18] = v22;
            p16[v21] = p17;
        elseif v22 == nil or u2(v22, v20) >= 0 then
            p16[p18] = v20;
            p16[v19] = p17;
            v21 = v19;
        else
            p16[p18] = v22;
            p16[v21] = p17;
        end;

        p18 = v21;
    end;
end;

u2 = function(p23: table, p24: table) -- Line: 95
    local v25 = p23.sortIndex - p24.sortIndex;

    if v25 == 0 then
        return p23.id - p24.id;
    end;

    return v25;
end;

return v1;