-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local graph = require(script.Parent.graph);
local create_node = graph.create_node;
local assert_stable_scope = graph.assert_stable_scope;
local evaluate_node = graph.evaluate_node;

return function(p1: function, p2: any) -- Line: 8, Name: effect
    -- upvalues: create_node (copy), assert_stable_scope (copy), evaluate_node (copy)
    evaluate_node((create_node(assert_stable_scope(), p1, p2)));
end;