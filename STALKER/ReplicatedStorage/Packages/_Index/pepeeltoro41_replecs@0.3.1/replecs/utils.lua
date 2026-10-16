-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("customid"));
local common = require(script.Parent:WaitForChild("common"));
require(script.Parent:WaitForChild("types"));
local ecs_name = common.ecs_name;
local relationships = common.relationships;
local u18 = {
    create_shared_lookup = function(p1: table) -- Line: 22, Name: create_shared_lookup
        local v2 = {};
        local v3 = {};
        local v4 = {};

        for i in p1 do
            table.insert(v2, i);
        end;

        table.sort(v2);

        for i, v in v2 do
            local v5 = p1[v];
            v3[v5] = i;
            v4[i] = v5;
        end;

        return {
            lookup = p1,
            keys = v2,
            indexes = v4,
            members = v3
        };
    end,

    generate_handshake = function(p6) -- Line: 46, Name: generate_handshake
        local v7 = {
            components = {},
            custom_ids = {},
            serdes = {}
        };
        local v8 = {};

        for i, v in p6.components.lookup do
            v7.components[i] = true;
            v8[v] = i;
        end;

        for i in p6.custom_ids.lookup do
            v7.custom_ids[i] = true;
        end;

        for i, v in p6.serdes do
            local v9 = v8[i];

            if v9 then
                v7.serdes[v9] = {
                    includes_variants = v.includes_variants,
                    bytespan = v.bytespan
                };
            end;
        end;

        return v7;
    end,

    verify_handshake = function(p10: any, p11: any, p12: string, p13: string) -- Line: 78, Name: verify_handshake
        local v14 = {};

        for i in p11.components do
            if not p10.components.lookup[i] then
                return false, `missing shared component "{i}" in {p13}`;
            end;
        end;

        for i, v in p10.components.lookup do
            if not p11.components[i] then
                return false, `missing shared component "{i}" in {p12}`;
            end;

            v14[v] = i;
        end;

        for i in p11.custom_ids do
            if not p10.custom_ids.lookup[i] then
                return false, `missing custom id "{i}" in {p13}`;
            end;
        end;

        for i in p10.custom_ids.lookup do
            if not p11.custom_ids[i] then
                return false, `missing custom id "{i}" in {p12}`;
            end;
        end;

        for i, v in p11.serdes do
            local v15 = p10.components.lookup[i];

            if v15 then
                local v16 = p10.serdes[v15];

                if not v16 then
                    return false, `missing serdes for component "{i}" in {p13}`;
                end;

                if (v.includes_variants or false) ~= (v16.includes_variants or false) then
                    return false, `mismatched includes_variants for component "{i}": ({v.includes_variants} ~= {v16.includes_variants})`;
                end;

                if v.bytespan ~= v16.bytespan then
                    return false, `mismatched bytespan for component "{i}": ({v.bytespan} ~= {v16.bytespan})`;
                end;
            else
                warn((`{p12} registered a serdes for "{i}" that {p13} doesn't have`));
            end;
        end;

        for i in p10.serdes do
            local v17 = v14[i];

            if v17 and not p11.serdes[v17] then
                warn((`{p13} registered a serdes for "{v17}" that {p12} doesn't have`));
            end;
        end;

        return true, nil;
    end
};

function u18.resolved_shared(p19: any, p20: any, p21: table, p22: table) -- Line: 144
    -- upvalues: common (copy), ecs_name (copy), u18 (copy)
    local table_clone_ret = table.clone(common.implicitly_shared);
    local v23 = {};
    local v24 = {};

    for i, v in p19:query(ecs_name):with(p20.shared):iter() do
        if table_clone_ret[v] then
            common.log_error((`detected two components with the same {v} name: ({table_clone_ret[v]}, {i})`));
        end;

        table_clone_ret[v] = i;
    end;

    for i in p19:query(p20.shared):without(ecs_name):iter() do
        common.log_warn((`shared component: {i} has no name assigned.`));
    end;

    for i in p21 do
        v23[i.identifier] = i;
    end;

    for i in p21 do
        v23[i.identifier] = i;
    end;

    v24.serdes = p22;
    v24.components = u18.create_shared_lookup(table_clone_ret);
    v24.custom_ids = u18.create_shared_lookup(v23);

    return v24;
end;

function u18.create_components(p25: function, p26: function, p27: any) -- Line: 181
    -- upvalues: relationships (copy)
    local v28 = p27 or {};
    v28.shared = p25();
    v28.networked = p26();

    if relationships then
        v28.reliable = p26();
        v28.unreliable = p26();
        v28.relation = p26();
        v28.custom = p25();
    end;

    v28.custom_handler = p26();
    v28.serdes = p26();
    v28.global = p26();
    v28.__alive_tracking__ = p25();
    v28.Shared = v28.shared;
    v28.Networked = v28.networked;

    if relationships then
        v28.Reliable = v28.reliable;
        v28.Unreliable = v28.unreliable;
        v28.Relation = v28.relation;
        v28.Custom = v28.custom;
    end;

    v28.CustomHandler = v28.custom_handler;
    v28.Serdes = v28.serdes;
    v28.Global = v28.global;

    return v28;
end;

function u18.add_component_names(p29: any, p30: function) -- Line: 213
    -- upvalues: relationships (copy)
    p30(p29.shared, "replecs.shared");

    if relationships then
        p30(p29.networked, "replecs.networked");
        p30(p29.reliable, "replecs.reliable");
        p30(p29.unreliable, "replecs.unreliable");
        p30(p29.relation, "replecs.relation");
        p30(p29.custom, "replecs.custom");
    end;

    p30(p29.custom_handler, "replecs.custom_handler");
    p30(p29.serdes, "replecs.serdes");
    p30(p29.global, "replecs.global");
    p30(p29.__alive_tracking__, "replecs.__alive_tracking__");
end;

function u18.component_factory(u31) -- Line: 230
    -- upvalues: common (copy)
    return function() -- Line: 231
        -- upvalues: common (ref), u31 (copy)
        return common.world_component(u31);
    end;
end;

function u18.tag_factory(u32) -- Line: 236
    -- upvalues: common (copy)
    return function() -- Line: 237
        -- upvalues: common (ref), u32 (copy)
        return common.world_tag(u32);
    end;
end;

local u38 = {
    new = function() -- Line: 244, Name: new
        return {
            offset = 0,
            buffer = buffer.create(100)
        };
    end,

    from = function(p33: buffer) -- Line: 251, Name: from
        return {
            buffer = p33,
            offset = buffer.len(p33)
        };
    end,

    from_offset = function(p34: buffer, p35: number) -- Line: 258, Name: from_offset
        return {
            buffer = p34,
            offset = p35
        };
    end,

    tryalloc = function(p36: table, p37: number) -- Line: 265, Name: tryalloc
        local buffer2 = p36.buffer;
        local offset = p36.offset;
        local buffer_len_ret = buffer.len(buffer2);

        if buffer_len_ret < offset + p37 then
            local math_log_ret = math.log((p37 + offset) / buffer_len_ret, 1.5);
            local math_ceil_ret = math.ceil(math_log_ret);
            local buffer_create_ret = buffer.create(buffer_len_ret * 1.5 ^ math_ceil_ret);
            buffer.copy(buffer_create_ret, 0, buffer2, 0);
            p36.buffer = buffer_create_ret;
        end;
    end
};

function u38.write_buffer(p39: table, p40: buffer, p41: number?, p42: number?) -- Line: 278
    -- upvalues: u38 (copy)
    if p41 == nil and p42 == nil then
        u38.tryalloc(p39, buffer.len(p40));
        buffer.copy(p39.buffer, p39.offset, p40, 0, buffer.len(p40));
        p39.offset = p39.offset + buffer.len(p40);

        return;
    end;

    local v43 = buffer.len(p40) - (p41 or 0);

    if p42 then
        v43 = math.min(v43, p42) or v43;
    end;

    u38.tryalloc(p39, v43);
    buffer.copy(p39.buffer, p39.offset, p40, p41 or 0, v43);
    p39.offset = p39.offset + v43;
end;

function u38.print(p44: table) -- Line: 294
    local v45 = {};
    local buffer_tostring_ret = buffer.tostring(p44.buffer);
    v45[1] = string.byte(buffer_tostring_ret, 1, -1);
    local v46 = 7;

    for i = 1, p44.offset do
        local v47 = v45[i];
        local v48;

        if v47 == 0 then
            v48 = 1;
        else
            local math_log10_ret = math.log10(v47 + 1);
            v48 = math.ceil(math_log10_ret);
        end;

        v46 = v46 + (v48 + 1);
        local _ = i;
    end;

    local v49 = v45[p44.offset + 1];

    if v49 then
        local v50;

        if v49 == 0 then
            v50 = 1;
        else
            local math_log10_ret = math.log10(1 + v49);
            v50 = math.ceil(math_log10_ret);
        end;

        local _ = v46 + v50 // 2;
    end;

    v45[p44.offset + 1] = `[{v45[p44.offset + 1]}]`;

    if #v45 == 0 or p44.offset == buffer.len(p44.buffer) then
        table.insert(v45, " ");
    end;

    return `Pos: {p44.offset} / {buffer.len(p44.buffer)}\nBuf: \{ {table.concat(v45, " ")} }`;
end;

function u38.writeu8(p51: table, p52: number) -- Line: 317
    -- upvalues: u38 (copy)
    u38.tryalloc(p51, 1);
    buffer.writeu8(p51.buffer, p51.offset, p52);
    p51.offset = p51.offset + 1;
end;

function u38.writeu16(p53: table, p54: number) -- Line: 323
    -- upvalues: u38 (copy)
    u38.tryalloc(p53, 2);
    buffer.writeu16(p53.buffer, p53.offset, p54);
    p53.offset = p53.offset + 2;
end;

function u38.writeu24(p55: table, p56: number) -- Line: 328
    -- upvalues: u38 (copy)
    u38.tryalloc(p55, 3);
    buffer.writeu8(p55.buffer, p55.offset, p56);
    buffer.writeu16(p55.buffer, p55.offset + 1, p56 // 256);
    p55.offset = p55.offset + 3;
end;

function u38.writeu32(p57: table, p58: number) -- Line: 335
    -- upvalues: u38 (copy)
    u38.tryalloc(p57, 4);
    buffer.writeu32(p57.buffer, p57.offset, p58);
    p57.offset = p57.offset + 4;
end;

function u38.writeu40(p59: table, p60: number) -- Line: 341
    -- upvalues: u38 (copy)
    u38.tryalloc(p59, 5);
    buffer.writeu8(p59.buffer, p59.offset, p60);
    buffer.writeu32(p59.buffer, p59.offset + 1, p60 // 256);
    p59.offset = p59.offset + 5;
end;

function u38.writei8(p61: table, p62: number) -- Line: 348
    -- upvalues: u38 (copy)
    u38.tryalloc(p61, 1);
    buffer.writei8(p61.buffer, p61.offset, p62);
    p61.offset = p61.offset + 1;
end;

function u38.writei16(p63: table, p64: number) -- Line: 354
    -- upvalues: u38 (copy)
    u38.tryalloc(p63, 2);
    buffer.writei16(p63.buffer, p63.offset, p64);
    p63.offset = p63.offset + 2;
end;

function u38.writei32(p65: table, p66: number) -- Line: 360
    -- upvalues: u38 (copy)
    u38.tryalloc(p65, 4);
    buffer.writeu32(p65.buffer, p65.offset, p66);
    p65.offset = p65.offset + 4;
end;

function u38.write_span(p67: table, p68: number, p69: number) -- Line: 366
    -- upvalues: u38 (copy)
    if p69 <= 255 then
        u38.writeu8(p67, p68);

        return;
    end;

    if p69 <= 65535 then
        u38.writeu16(p67, p68);

        return;
    end;

    if p69 <= 16777215 then
        u38.writeu24(p67, p68);

        return;
    end;

    if p69 <= 4294967295 then
        u38.writeu32(p67, p68);

        return;
    end;

    error("span too large");
end;

function u38.read_buffer(p70: table, p71: number) -- Line: 380
    local buffer_create_ret = buffer.create(p71);
    buffer.copy(buffer_create_ret, 0, p70.buffer, p70.offset - p71, p71);
    p70.offset = p70.offset - p71;

    return buffer_create_ret;
end;

function u38.readu8(p72: table) -- Line: 387
    p72.offset = p72.offset - 1;

    return buffer.readu8(p72.buffer, p72.offset);
end;

function u38.readu16(p73: table) -- Line: 392
    p73.offset = p73.offset - 2;

    return buffer.readu16(p73.buffer, p73.offset);
end;

function u38.readu24(p74: table) -- Line: 397
    p74.offset = p74.offset - 3;

    return buffer.readu8(p74.buffer, p74.offset) + buffer.readu16(p74.buffer, p74.offset + 1) * 256;
end;

function u38.readu32(p75: table) -- Line: 404
    p75.offset = p75.offset - 4;

    return buffer.readu32(p75.buffer, p75.offset);
end;

function u38.readu40(p76: table) -- Line: 409
    p76.offset = p76.offset - 5;

    return buffer.readu8(p76.buffer, p76.offset) + buffer.readu32(p76.buffer, p76.offset + 1) * 256;
end;

function u38.read_span(p77: table, p78: number) -- Line: 416
    -- upvalues: u38 (copy)
    if p78 <= 255 then
        return u38.readu8(p77);
    end;

    if p78 <= 65535 then
        return u38.readu16(p77);
    end;

    if p78 <= 16777215 then
        return u38.readu24(p77);
    end;

    if p78 <= 4294967295 then
        return u38.readu32(p77);
    end;

    error("span too large");
end;

function u38.readi8(p79: table) -- Line: 430
    p79.offset = p79.offset - 1;

    return buffer.readi8(p79.buffer, p79.offset);
end;

function u38.readi16(p80: table) -- Line: 435
    p80.offset = p80.offset - 2;

    return buffer.readi16(p80.buffer, p80.offset);
end;

function u38.readi32(p81: table) -- Line: 439
    p81.offset = p81.offset - 4;

    return buffer.readi32(p81.buffer, p81.offset);
end;

function u38.write_vlq(p82: table, p83: number) -- Line: 444
    -- upvalues: u38 (copy)
    local v84 = p83 // 1 % 128;
    local v85 = p83 // 128 % 128;
    local v86 = p83 // 16384 % 128;
    local v87 = p83 // 2097152 % 128;

    if v87 ~= 0 then
        u38.tryalloc(p82, 4);
        u38.writeu32(p82, v84 * 16777216 + v85 * 65536 + v86 * 256 + v87 + 128);

        return;
    end;

    if v86 ~= 0 then
        u38.tryalloc(p82, 3);
        u38.writeu24(p82, v84 * 65536 + v85 * 256 + v86 + 128);

        return;
    end;

    if v85 == 0 then
        u38.tryalloc(p82, 1);
        u38.writeu8(p82, v84 + 128);

        return;
    end;

    u38.tryalloc(p82, 2);
    u38.writeu16(p82, v84 * 256 + v85 + 128);
end;

function u38.read_vlq(p88: table) -- Line: 465
    -- upvalues: u38 (copy)
    local v89 = u38.readu8(p88);

    if v89 >= 128 then
        return v89 - 128;
    end;

    local v90 = u38.readu8(p88);

    if v90 >= 128 then
        return v89 + (v90 - 128) * 128;
    end;

    local v91 = v89 + v90 * 128;
    local v92 = u38.readu8(p88);

    if v92 >= 128 then
        return v91 + (v92 - 128) * 16384;
    end;

    local v93 = v91 + v92 * 16384;
    local v94 = u38.readu8(p88);

    if v94 >= 128 then
        return v93 + (v94 - 128) * 2097152;
    end;

    local _ = v93 + v94 * 2097152;
    error("vlq length too large");
end;

function u38.close(p95: table) -- Line: 493
    local buffer_create_ret = buffer.create(p95.offset);
    buffer.copy(buffer_create_ret, 0, p95.buffer, 0, p95.offset);
    p95.buffer = buffer_create_ret;

    return buffer_create_ret;
end;

function u18.print_buffer(p96: buffer) -- Line: 500
    local v97 = {};
    local buffer_tostring_ret = buffer.tostring(p96);
    v97[1] = string.byte(buffer_tostring_ret, 1, -1);

    return `\{ {buffer.len(p96)}\n Buf: \{ {table.concat(v97, " ")} }`;
end;

u18.cursor = u38;
local u98 = {};
u98.__index = u98;

function get_entry_bit(p99: number)
    return math.floor(p99 / 32), p99 % 32;
end;

function u98.create(p100: number?) -- Line: 525
    -- upvalues: u98 (copy)
    local math_ceil_ret = math.ceil(p100 / 32);
    local v101 = {
        buffer = buffer.create(math_ceil_ret * 4),
        capacity = p100,
        entries = math_ceil_ret
    };

    return setmetatable(v101, u98);
end;

function u98.from_set(p102: table, p103: table, p104: number?) -- Line: 538
    -- upvalues: u98 (copy)
    local v105 = u98.create(p104 or 32);

    for i in p103 do
        local v106 = p102[i];

        if v106 ~= nil then
            u98.set(v105, v106);
        end;
    end;

    return v105;
end;

function u98.expand(p107: any, p108: number) -- Line: 550
    if p108 <= p107.capacity then
        return;
    end;

    local math_ceil_ret = math.ceil(p108 / 32);
    local v109 = math_ceil_ret * 4;
    local buffer_create_ret = buffer.create(v109);
    buffer.copy(buffer_create_ret, 0, p107.buffer, 0);

    for i = p107.entries * 4, v109 - 1 do
        buffer.writeu8(buffer_create_ret, i, 0);
        local _ = i;
    end;

    p107.buffer = buffer_create_ret;
    p107.capacity = p108;
    p107.entries = math_ceil_ret;
end;

function u98.read(p110: any, p111: number) -- Line: 570
    return p110.entries <= p111 and 0 or buffer.readu32(p110.buffer, p111 * 4);
end;

function u98.write(p112: any, p113: number, p114: number) -- Line: 577
    -- upvalues: u98 (copy)
    if p112.entries <= p113 then
        u98.expand(p112, (p113 + 1) * 32);
    end;

    buffer.writeu32(p112.buffer, p113 * 4, p114);
end;

function u98.set(p115: any, p116: number) -- Line: 587
    -- upvalues: u98 (copy)
    if p116 < 0 then
        error("Bit index cannot be negative");
    end;

    local v117, v118 = get_entry_bit(p116);
    local v119 = u98.read(p115, v117);
    local bit32_lshift_ret = bit32.lshift(1, v118);
    local bit32_bor_ret = bit32.bor(v119, bit32_lshift_ret);
    u98.write(p115, v117, bit32_bor_ret);
end;

function u98.get(p120: any, p121: number) -- Line: 598
    -- upvalues: u98 (copy)
    if p121 < 0 then
        error("Bit index cannot be negative");
    end;

    local v122, v123 = get_entry_bit(p121);

    if p120.entries <= v122 then
        return false;
    end;

    local v124 = u98.read(p120, v122);
    local bit32_lshift_ret = bit32.lshift(1, v123);

    return bit32.band(v124, bit32_lshift_ret) ~= 0;
end;

function u98.clear(p125: any, p126: number) -- Line: 612
    -- upvalues: u98 (copy)
    if p126 < 0 then
        error("Bit index cannot be negative");
    end;

    local v127, v128 = get_entry_bit(p126);

    if p125.entries <= v127 then
        return;
    end;

    local v129 = u98.read(p125, v127);
    local bit32_lshift_ret = bit32.lshift(1, v128);
    local bit32_bnot_ret = bit32.bnot(bit32_lshift_ret);
    local bit32_band_ret = bit32.band(v129, bit32_bnot_ret);
    u98.write(p125, v127, bit32_band_ret);
end;

function u98.band(p130, p131) -- Line: 630
    -- upvalues: u98 (copy)
    local math_max_ret = math.max(p130.entries, p131.entries);
    local v132 = u98.create(math_max_ret * 32);

    for i = 0, math_max_ret - 1 do
        local v133 = u98.read(p130, i);
        local v134 = u98.read(p131, i);
        u98.write(v132, i, (bit32.band(v133, v134)));
        local _ = i;
    end;

    return v132;
end;

function u98.bor(p135, p136) -- Line: 643
    -- upvalues: u98 (copy)
    local math_max_ret = math.max(p135.entries, p136.entries);
    local v137 = u98.create(math_max_ret * 32);

    for i = 0, math_max_ret - 1 do
        local v138 = u98.read(p135, i);
        local v139 = u98.read(p136, i);
        u98.write(v137, i, (bit32.bor(v138, v139)));
        local _ = i;
    end;

    return v137;
end;

function u98.bxor(p140, p141) -- Line: 656
    -- upvalues: u98 (copy)
    local math_max_ret = math.max(p140.entries, p141.entries);
    local v142 = u98.create(math_max_ret * 32);

    for i = 0, math_max_ret - 1 do
        local v143 = u98.read(p140, i);
        local v144 = u98.read(p141, i);
        u98.write(v142, i, (bit32.bxor(v143, v144)));
        local _ = i;
    end;

    return v142;
end;

function u98.bnot(p145) -- Line: 669
    -- upvalues: u98 (copy)
    local v146 = u98.create(p145.capacity);

    for i = 0, p145.entries - 1 do
        local v147 = u98.read(p145, i);
        u98.write(v146, i, (bit32.bnot(v147)));
        local _ = i;
    end;

    return v146;
end;

function u98.clone(p148) -- Line: 680
    -- upvalues: u98 (copy)
    local v149 = u98.create(p148.capacity);
    buffer.copy(v149.buffer, 0, p148.buffer, 0, p148.entries * 4);

    return v149;
end;

function u98.remap(p150: any, p151: table, p152: table, p153: number?) -- Line: 686
    -- upvalues: u98 (copy)
    local v154 = u98.create(p153 or 32);

    for i, v in p152 do
        local v155 = p151[i];

        if v155 then
            if u98.get(p150, v155) then
                u98.set(v154, v);
            else
                u98.clear(v154, v);
            end;
        end;
    end;

    return v154;
end;

function u98.lshift(p156: any, p157: number) -- Line: 702
    -- upvalues: u98 (copy)
    if p157 <= 0 then
        return u98.clone(p156);
    end;

    local math_floor_ret = math.floor(p157 / 32);
    local v158 = p157 % 32;
    local v159 = u98.create(p156.capacity + p157);

    if v158 == 0 then
        for i = 0, p156.entries - 1 do
            local v160 = u98.read(p156, i);
            u98.write(v159, i + math_floor_ret, v160);
            local _ = i;
        end;

        return v159;
    end;

    local v161 = 0;

    for i = 0, p156.entries - 1 do
        local v162 = u98.read(p156, i);
        local bit32_lshift_ret = bit32.lshift(v162, v158);
        local bit32_rshift_ret = bit32.rshift(v162, 32 - v158);
        u98.write(v159, i + math_floor_ret, (bit32.bor(bit32_lshift_ret, v161)));
        v161 = bit32_rshift_ret;
        local _ = i;
    end;

    if v161 ~= 0 then
        u98.write(v159, p156.entries + math_floor_ret, v161);
    end;

    return v159;
end;

function u98.rshift(p163: any, p164: number) -- Line: 736
    -- upvalues: u98 (copy)
    if p164 <= 0 then
        return u98.clone(p163);
    end;

    local math_floor_ret = math.floor(p164 / 32);
    local v165 = p164 % 32;

    if p163.entries <= math_floor_ret then
        return u98.create(32);
    end;

    local v166 = u98.create(p163.capacity);

    if v165 == 0 then
        for i = math_floor_ret, p163.entries - 1 do
            local v167 = u98.read(p163, i);
            u98.write(v166, i - math_floor_ret, v167);
            local _ = i;
        end;

        return v166;
    end;

    for i = math_floor_ret, p163.entries - 1 do
        local v168 = u98.read(p163, i);
        local bit32_rshift_ret = bit32.rshift(v168, v165);
        local v169 = i + 1 >= p163.entries and 0 or u98.read(p163, i + 1);
        local bit32_lshift_ret = bit32.lshift(v169, 32 - v165);
        u98.write(v166, i - math_floor_ret, (bit32.bor(bit32_rshift_ret, bit32_lshift_ret)));
        local _ = i;
    end;

    return v166;
end;

local function tobinary(p170: number) -- Line: 773
    if p170 == 0 then
        return "0";
    end;

    local v171 = "";

    while p170 > 0 do
        v171 = p170 % 2 .. v171;
        p170 = math.floor(p170 / 2);
    end;

    return string.rep("0", 8 - #v171) .. v171;
end;

local table_create_ret = table.create(6);

function u98.tostring(p172) -- Line: 788
    -- upvalues: table_create_ret (copy), tobinary (copy)
    local buffer2 = p172.buffer;
    local v173 = -1;

    for i = p172.entries - 1, 0, -1 do
        if buffer.readu32(buffer2, i * 4) ~= 0 then
            v173 = i;
            break;
        end;

        local _ = i;
    end;

    if v173 == -1 then
        return "";
    end;

    table.clear(table_create_ret);
    local v174 = "";

    for i = 0, v173 do
        v174 = v174 .. tobinary((buffer.readu32(buffer2, i * 4)));
        local _ = i;
    end;

    return v174;
end;

u18.bitmask = {
    create = u98.create,
    from_set = u98.from_set
};

function u18.is_client_valid(p175) -- Line: 820
    if not game then
        return true;
    end;

    if typeof(p175) ~= "Instance" then
        return false;
    end;

    local v176;

    if p175.ClassName == "Player" then
        v176 = p175:IsDescendantOf(game:GetService("Players"));
    else
        v176 = false;
    end;

    return v176;
end;

function u18.vlq_span(p177: number) -- Line: 831
    return p177 < 128 and 1 or (p177 < 16384 and 2 or (p177 < 2097152 and 3 or 4));
end;

function u18.number_span(p178: number) -- Line: 843
    return p178 <= 255 and 1 or (p178 <= 65535 and 2 or 4);
end;

function u18.read_number(p179: buffer, p180: number, p181: number) -- Line: 853
    if p181 == 1 then
        return buffer.readu8(p179, p180), p180 + 1;
    end;

    if p181 == 2 then
        return buffer.readu16(p179, p180), p180 + 2;
    end;

    return buffer.readu32(p179, p180), p180 + 4;
end;

function u18.setbit(p182: number, p183: number) -- Line: 863
    local bit32_lshift_ret = bit32.lshift(1, p183);

    return bit32.bor(p182, bit32_lshift_ret);
end;

function u18.checkbit(p184: number, p185: number) -- Line: 866
    local bit32_lshift_ret = bit32.lshift(1, p185);

    return bit32.band(p184, bit32_lshift_ret) ~= 0;
end;

return u18;