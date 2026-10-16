-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local vide = require(script.Parent.Parent.Parent.Parent.vide);
local loop = require(script.Parent.Parent.Parent.modules.loop);
local remotes = require(script.Parent.Parent.Parent.modules.remotes);
require(script.Parent.Parent.Parent.modules.types);
local script_widget = require(script.widget);
local cleanup = vide.cleanup;

return {
    class_name = "app",
    name = "System",

    mount = function(p1: table, p2: function) -- Line: 26, Name: mount
        -- upvalues: vide (copy), loop (copy), remotes (copy), cleanup (copy), RunService (copy), script_widget (copy)
        local math_random_ret = math.random(2147483647);
        local v3 = vide.source(false);
        local v4 = vide.source(0);
        local v5 = vide.source({});
        local v6 = vide.source({
            component = {},
            entities = {},
            types = {},
            values = {}
        });
        local v7 = {
            watch_id = math_random_ret,
            host = p1.host,
            vm = p1.vm,
            scheduler = p1.scheduler,
            system = p1.system,
            name = p1.name,
            changes = v6,
            recording = v3,
            per_frame_data = v5,
            watching_frame = v4,
            destroy = p2
        };
        local v8 = loop("app-client-system", v7, {
            i = 1
        }, script.systems.replicate);
        local u9 = {
            host = v7.host,
            to_vm = v7.vm
        };
        remotes.create_watch:fire(u9, p1.scheduler, p1.system, math_random_ret);
        remotes.connect_watch:fire(u9, math_random_ret);
        cleanup(RunService.Heartbeat:Connect(v8));
        cleanup(function() -- Line: 71
            -- upvalues: remotes (ref), u9 (copy), math_random_ret (copy)
            remotes.disconnect_watch:fire(u9, math_random_ret);
            remotes.stop_watch:fire(u9, math_random_ret);
            remotes.remove_watch:fire(u9, math_random_ret);
        end);

        return script_widget(v7);
    end
};