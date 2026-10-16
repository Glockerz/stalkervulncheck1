-- Decompiled with Potassium's decompiler.

local jecs = require(script.Parent:WaitForChild("jecs"));
local common = require(script:WaitForChild("common"));
require(script:WaitForChild("types"));
local utils = require(script:WaitForChild("utils"));
local client = require(script:WaitForChild("client"));
local server = require(script:WaitForChild("server"));
local customid = require(script:WaitForChild("customid"));
local u1 = {
    VERSION = require(script:WaitForChild("ver"))
};
u1.__index = u1;
local preregistration = common.preregistration;

if preregistration then
    utils.create_components(common.preregister_tag, common.preregister_component, u1);
    utils.add_component_names(u1, common.add_preregistered_name);
    jecs.meta(u1.custom, jecs.Exclusive);
    jecs.meta(u1.global, jecs.Exclusive);
end;

local u2;

if preregistration then
    u2 = u1;
else
    u2 = nil;
end;

function u1.create_server(p3) -- Line: 62
    -- upvalues: server (copy), u2 (copy)
    return server.create(p3, u2);
end;

function u1.create_client(p4) -- Line: 66
    -- upvalues: client (copy), u2 (copy)
    return client.create(p4, u2);
end;

function u1.create(u5) -- Line: 70
    -- upvalues: u2 (copy), utils (copy), common (copy), server (copy), client (copy), u1 (copy)
    assert(game, "This is a Roblox specific function");
    local RunService = game:GetService("RunService");
    local v6 = {};

    if u2 then
        v6.components = u2;
    elseif u5 then
        v6.components = utils.create_components(utils.tag_factory(u5), utils.component_factory(u5));
        utils.add_component_names(v6.components, function(p7, p8) -- Line: 79
            -- upvalues: common (ref), u5 (copy)
            common.add_name(u5, p7, p8);
        end);
    end;

    if RunService:IsServer() then
        v6.server = server.create(u5, v6.components);
    end;

    if RunService:IsClient() then
        v6.client = client.create(u5, v6.components);
    end;

    return setmetatable(v6, u1);
end;

function u1.create_custom_id(p9: string, p10: function) -- Line: 94
    -- upvalues: customid (copy)
    return customid.create(p9, p10);
end;

function u1.after_replication(p11: table, p12: function) -- Line: 98
    local client2 = p11.client;

    if client2 then
        client2:after_replication(p12);

        return;
    end;

    p12();
end;

function u1.register_custom_id(p13: table, p14: any) -- Line: 107
    if p13.server then
        p13.server:register_custom_id(p14);
    end;

    if p13.client then
        p13.client:register_custom_id(p14);
    end;
end;

function u1.set_serdes(p15: table, p16: any, p17: any) -- Line: 116
    if p15.server then
        p15.server:set_serdes(p16, p17);
    end;

    if p15.client then
        p15.client:set_serdes(p16, p17);
    end;
end;

function u1.remove_serdes(p18: table, p19: any) -- Line: 125
    if p18.server then
        p18.server:remove_serdes(p19);
    end;

    if p18.client then
        p18.client:remove_serdes(p19);
    end;
end;

return u1;