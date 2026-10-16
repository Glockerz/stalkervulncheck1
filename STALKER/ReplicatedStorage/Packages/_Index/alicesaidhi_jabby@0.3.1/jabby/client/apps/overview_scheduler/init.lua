-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local vide = require(script.Parent.Parent.Parent.Parent.vide);
local loop = require(script.Parent.Parent.Parent.modules.loop);
local remotes = require(script.Parent.Parent.Parent.modules.remotes);
local script_widget = require(script.widget);
local source = vide.source;
local cleanup = vide.cleanup;

return {
    class_name = "app",
    name = "Scheduler",

    mount = function(u1: table, p2: function) -- Line: 22, Name: mount
        -- upvalues: source (copy), loop (copy), cleanup (copy), RunService (copy), script_widget (copy), remotes (copy)
        local u3 = source({});
        local v4 = source({});
        local v5 = source({});
        local v6 = loop("app-client-scheduler", {
            host = u1.host,
            vm = u1.vm,
            id = u1.id,
            system_ids = v5,
            system_data = u3,
            system_frames = v4
        }, {
            i = 1
        }, script.systems.get_scheduler_data);
        cleanup(RunService.Heartbeat:Connect(v6));

        return script_widget({
            host = u1.host,
            vm = u1.vm,
            id = u1.id,
            system_ids = v5,
            system_data = u3,
            system_frames = v4,

            pause_system = function(p7: number) -- Line: 56, Name: pause_system
                -- upvalues: remotes (ref), u1 (copy), u3 (copy)
                remotes.scheduler_system_pause:fire({
                    host = u1.host,
                    to_vm = u1.vm
                }, u1.id, p7, not u3()[p7].paused);
            end,

            destroy = p2
        });
    end
};