-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local flags = require(script.Parent.flags);
local throw = require(script.Parent.throw);
local graph = require(script.Parent.graph);

return function(p1: function) -- Line: 7, Name: batch
    -- upvalues: flags (copy), graph (copy), throw (copy)
    local batch = flags.batch;
    local v2;

    if batch then
        v2 = nil;
    else
        flags.batch = true;
        v2 = graph.get_update_queue_length();
    end;

    local success, result = pcall(p1);

    if not batch then
        flags.batch = false;
        graph.flush_update_queue(v2);
    end;

    if not success then
        throw((`error occured while batching updates: {result}`));
    end;
end;