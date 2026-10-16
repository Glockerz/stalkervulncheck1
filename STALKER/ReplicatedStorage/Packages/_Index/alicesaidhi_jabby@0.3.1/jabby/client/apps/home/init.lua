-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local vide = require(script.Parent.Parent.Parent.Parent.vide);
local loop = require(script.Parent.Parent.Parent.modules.loop);
local script_widget = require(script.widget);
local cleanup = vide.cleanup;

return {
    class_name = "app",
    name = "Home",

    mount = function(p1: nil, p2: function) -- Line: 14, Name: mount
        -- upvalues: vide (copy), loop (copy), cleanup (copy), RunService (copy), script_widget (copy)
        local v3 = vide.source({});
        local v4 = loop("app-client-home", v3, {
            i = 1
        }, script.systems.get_core_data);
        cleanup(RunService.Heartbeat:Connect(v4));

        return script_widget({
            servers = v3,
            destroy = p2
        });
    end
};