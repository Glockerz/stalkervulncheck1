-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.jecs)

local traffic_check = require(script.modules.traffic_check)

require(script.modules.types)

local vm_id = require(script.modules.vm_id)
local server = require(script.server)
local public = require(script.server.public)
local scheduler = require(script.server.scheduler)
local t = {
	add_to_public = function(p1, p2) --[[ add_to_public | Line: 16 | Upvalues: public (copy) ]]
		public.updated = true
		table.insert(public, {
			class_name = "World",
			name = p1,
			world = p2.world,
			entities = p2.entities,
			get_entity_from_part = p2.get_entity_from_part
		})
	end
}
local t2 = {
	add_to_public = function(p1, p2) --[[ add_to_public | Line: 32 | Upvalues: public (copy) ]]
		public.updated = true
		p2.scheduler.name = p1
		table.insert(public, p2.scheduler)
	end
}

return {
	set_check_function = function(p1) --[[ set_check_function | Line: 42 | Upvalues: traffic_check (copy) ]]
		traffic_check.can_use_jabby = p1
	end,
	obtain_client = function() --[[ obtain_client | Line: 46 ]]
		return require(script.client)
	end,
	vm_id = vm_id,
	scheduler = scheduler,
	broadcast_server = server.broadcast,
	applets = {
		world = t,
		scheduler = t2
	},
	register = function(p1) --[[ register | Line: 60 ]]
		p1.applet.add_to_public(p1.name, p1.configuration)
	end
}