-- Decompiled with Potassium's decompiler.

local DependencyGraph = require(script.Parent.DependencyGraph);
local Phase = require(script.Parent.Phase);
local u1 = {};
u1.__index = u1;

function u1.__tostring(p2) -- Line: 13
    return p2._name;
end;

function u1.insert(p3, p4) -- Line: 23
    p3.dependencyGraph:insert(p4);

    return p3;
end;

function u1.insertAfter(p5, p6, p7) -- Line: 35
    local table_find_ret = table.find(p5.dependencyGraph.nodes, p7);
    assert(table_find_ret, "Unknown Phase in Pipeline:insertAfter(_, unknown), try adding this Phase to the Pipeline.");
    p5.dependencyGraph:insertAfter(p6, p7);

    return p5;
end;

function u1.insertBefore(p8, p9, p10) -- Line: 53
    local table_find_ret = table.find(p8.dependencyGraph.nodes, p10);
    assert(table_find_ret, "Unknown Phase in Pipeline:insertBefore(_, unknown), try adding this Phase to the Pipeline.");
    p8.dependencyGraph:insertBefore(p9, p10);

    return p8;
end;

function u1.new(p11: string?) -- Line: 68
    -- upvalues: DependencyGraph (copy), u1 (copy)
    local v12 = {
        _type = "pipeline",
        _name = p11 or debug.info(2, "sl"),
        dependencyGraph = DependencyGraph.new()
    };

    return setmetatable(v12, u1);
end;

u1.Startup = u1.new():insert(Phase.PreStartup):insert(Phase.Startup):insert(Phase.PostStartup);

return u1;