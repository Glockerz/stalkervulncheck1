-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local jecs = require(script.Parent:WaitForChild("jecs"))
local common = require(script:WaitForChild("common"))

require(script:WaitForChild("types"))

local utils = require(script:WaitForChild("utils"))
local client = require(script:WaitForChild("client"))
local server = require(script:WaitForChild("server"))
local customid = require(script:WaitForChild("customid"))
local t = {
	VERSION = require(script:WaitForChild("ver"))
}

t.__index = t

local preregistration = common.preregistration

if preregistration then
	utils.create_components(common.preregister_tag, common.preregister_component, t)
	utils.add_component_names(t, common.add_preregistered_name)
	jecs.meta(t.custom, jecs.Exclusive)
	jecs.meta(t.global, jecs.Exclusive)
end

local v1 = if preregistration then t else nil

function t.create_server(p1) --[[ create_server | Line: 62 | Upvalues: server (copy), v1 (copy) ]]
	return server.create(p1, v1)
end
function t.create_client(p1) --[[ create_client | Line: 66 | Upvalues: client (copy), v1 (copy) ]]
	return client.create(p1, v1)
end
function t.create(p1) --[[ create | Line: 70 | Upvalues: v1 (copy), utils (copy), common (copy), server (copy), client (copy), t (copy) ]]
	assert(game, "This is a Roblox specific function")

	local RunService = game:GetService("RunService")
	local t2 = {}

	if v1 then
		t2.components = v1
	elseif p1 then
		t2.components = utils.create_components(utils.tag_factory(p1), utils.component_factory(p1))
		utils.add_component_names(t2.components, function(p12, p2) --[[ Line: 79 | Upvalues: common (ref), p1 (copy) ]]
			common.add_name(p1, p12, p2)
		end)
	end

	if RunService:IsServer() then
		t2.server = server.create(p1, t2.components)
	end

	if RunService:IsClient() then
		t2.client = client.create(p1, t2.components)
	end

	return setmetatable(t2, t)
end
function t.create_custom_id(p1, p2) --[[ create_custom_id | Line: 94 | Upvalues: customid (copy) ]]
	return customid.create(p1, p2)
end
function t.after_replication(p1, p2) --[[ after_replication | Line: 98 ]]
	local client = p1.client

	if client then
		client:after_replication(p2)
	else
		p2()
	end
end
function t.register_custom_id(p1, p2) --[[ register_custom_id | Line: 107 ]]
	if p1.server then
		p1.server:register_custom_id(p2)
	end

	if not p1.client then
		return
	end

	p1.client:register_custom_id(p2)
end
function t.set_serdes(p1, p2, p3) --[[ set_serdes | Line: 116 ]]
	if p1.server then
		p1.server:set_serdes(p2, p3)
	end

	if not p1.client then
		return
	end

	p1.client:set_serdes(p2, p3)
end
function t.remove_serdes(p1, p2) --[[ remove_serdes | Line: 125 ]]
	if p1.server then
		p1.server:remove_serdes(p2)
	end

	if not p1.client then
		return
	end

	p1.client:remove_serdes(p2)
end

return t