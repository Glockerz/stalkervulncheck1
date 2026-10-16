-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local vide = require(script.Parent.Parent.Parent.Parent.vide);
local loop = require(script.Parent.Parent.Parent.modules.loop);
local script_widget = require(script.widget);
local source = vide.source;
local cleanup = vide.cleanup;
local v1 = {
    class_name = "app",
    name = "Entity"
};

local function generate_random_query_id() -- Line: 22
    return math.random(2147483647);
end;

function v1.mount(p2: table, p3: function) -- Line: 26
    -- upvalues: source (copy), loop (copy), cleanup (copy), RunService (copy), script_widget (copy)
    local v4 = source({});
    local v5 = source({});
    local v6 = source(true);
    local v7 = source(false);
    local u8 = source(false);
    local math_random_ret = math.random(2147483647);
    local v9 = loop("app-client-entity", {
        host = p2.host,
        vm = p2.vm,
        id = p2.id,
        inspect_id = math_random_ret,
        entity = tonumber(p2.entity),
        keys = v4,
        live_updates = v6,
        changes = v5,
        apply_changes = v7,
        deleting = u8
    }, {
        i = 1
    }, script.systems.obtain_entity_data);
    cleanup(RunService.Heartbeat:Connect(v9));

    return script_widget({
        host = p2.host,
        vm = p2.vm,
        id = p2.id,
        inspect_id = math_random_ret,
        entity = p2.entity,
        components = v4,
        live_updates = v6,
        changes = v5,
        apply_changes = v7,

        delete = function() -- Line: 72, Name: delete
            -- upvalues: u8 (copy)
            u8(true);
        end,

        destroy = p3
    });
end;

return v1;