-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent:WaitForChild("utils"));
local u1 = {};
u1.__index = u1;

function u1.track(p2, p3) -- Line: 34
    table.insert(p2.tracking, p3);
    p3:mark_as_tracked(p2);
end;

function u1.mark_as_tracked(p4, p5) -- Line: 39
    table.insert(p4.tracked_by, p5);
    p4.tracked_indexes[p5] = #p4.tracked_by;
end;

function u1.unmark_tracked(p6, p7) -- Line: 44
    local v8 = p6.tracked_indexes[p7];

    if v8 then
        local table_remove_ret = table.remove(p6.tracked_by);

        if table_remove_ret and table_remove_ret ~= p7 then
            p6.tracked_by[v8] = table_remove_ret;
            p6.tracked_indexes[table_remove_ret] = v8;
        end;

        p6.tracked_indexes[p7] = nil;
    end;
end;

function u1.run_subscribed(p9) -- Line: 58
    if p9.subscribed then
        p9.subscribed(p9);
    end;
end;

function u1.compute(p10) -- Line: 64
    if p10.compute_callback then
        p10.result = p10.compute_callback(p10);
    end;

    if p10.subscribed then
        p10.subscribed(p10);
    end;

    for _, v in p10.tracked_by do
        v:compute();
    end;
end;

function u1.destroy(p11) -- Line: 78
    for _, v in p11.tracking do
        v:unmark_tracked(p11);
    end;
end;

function create(p12: any, p13: function?)
    -- upvalues: u1 (copy)
    local v14 = {
        bitmask = p12
    };

    if p13 then
        p12 = p13(v14);
    end;

    v14.result = p12;
    v14.compute_callback = p13;
    v14.subscribed = nil;
    v14.tracking = {};
    v14.tracked_by = {};
    v14.tracked_indexes = {};

    return setmetatable(v14, u1);
end;

function follow(u15: table)
    local v16 = create(u15.result, function() -- Line: 99
        -- upvalues: u15 (copy)
        return u15.result;
    end);
    v16:track(u15);

    return v16;
end;

return {
    create = create,
    follow = follow
};