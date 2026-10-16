-- Decompiled with Potassium's decompiler.

require(script.Parent.jecs);
local traffic_check = require(script.modules.traffic_check);
require(script.modules.types);
local vm_id = require(script.modules.vm_id);
local script_server = require(script.server);
local public = require(script.server.public);

return {
    set_check_function = function(p1: function) -- Line: 42, Name: set_check_function
        -- upvalues: traffic_check (copy)
        traffic_check.can_use_jabby = p1;
    end,

    obtain_client = function() -- Line: 46, Name: obtain_client
        return require(script.client);
    end,

    vm_id = vm_id,
    scheduler = require(script.server.scheduler),
    broadcast_server = script_server.broadcast,
    applets = {
        world = {
            add_to_public = function(p2: string, p3: table) -- Line: 16, Name: add_to_public
                -- upvalues: public (copy)
                public.updated = true;
                table.insert(public, {
                    class_name = "World",
                    name = p2,
                    world = p3.world,
                    entities = p3.entities,
                    get_entity_from_part = p3.get_entity_from_part
                });
            end
        },
        scheduler = {
            add_to_public = function(p4: string, p5: table) -- Line: 32, Name: add_to_public
                -- upvalues: public (copy)
                public.updated = true;
                p5.scheduler.name = p4;
                table.insert(public, p5.scheduler);
            end
        }
    },

    register = function(p6: table) -- Line: 60, Name: register
        p6.applet.add_to_public(p6.name, p6.configuration);
    end
};