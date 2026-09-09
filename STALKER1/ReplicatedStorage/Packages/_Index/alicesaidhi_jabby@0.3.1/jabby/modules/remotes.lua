-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent.jecs)

local net = require(script.Parent.net)

require(script.Parent.types)

return {
	new_server_registered = net.create_event("server_registered", false, true),
	ping = net.create_event("ping", false, true),
	bind_to_server_core = net.create_event("client_registered"),
	update_server_data = net.create_event("update_server_data"),
	send_mouse_pointer = net.create_event("send_mouse_pointer"),
	send_mouse_entity = net.create_event("send_mouse_entity", true),
	validate_query = net.create_event("validate_query"),
	validate_result = net.create_event("validate_result"),
	request_query = net.create_event("replicate_query"),
	disconnect_query = net.create_event("disconnect_query"),
	advance_query_page = net.create_event("advance_query_page"),
	pause_query = net.create_event("pause_query"),
	refresh_results = net.create_event("refresh_query"),
	update_query_result = net.create_event("update_query_result", true),
	count_total_entities = net.create_event("count_total_entities", true),
	request_scheduler = net.create_event("initiate_replicate_scheduler"),
	disconnect_scheduler = net.create_event("disconnect_replicate_scheduler"),
	scheduler_system_static_update = net.create_event("scheduler_system_update_static"),
	scheduler_system_update = net.create_event("append_frame_system", true),
	scheduler_system_pause = net.create_event("scheduler_pause"),
	validate_entity_component = net.create_event("validate_entity_component"),
	validate_entity_component_result = net.create_event("validate_entity_component_result"),
	inspect_entity = net.create_event("inspect_entity"),
	get_component = net.create_event("get_entity_component"),
	return_component = net.create_event("return_entity_component"),
	delete_entity = net.create_event("delete_entity"),
	stop_inspect_entity = net.create_event("stop_inspect_entity"),
	update_entity = net.create_event("update_entity"),
	update_inspect_settings = net.create_event("inspect_entity_settings_update"),
	inspect_entity_update = net.create_event("inspect_entity_update"),
	create_watch = net.create_event("create_watch"),
	remove_watch = net.create_event("remove_watch"),
	request_watch_data = net.create_event("request_watch_data"),
	update_watch_data = net.create_event("update_watch_data"),
	start_record_watch = net.create_event("start_record_watch"),
	stop_watch = net.create_event("stop_watch"),
	clear_watch = net.create_event("clear_watch"),
	connect_watch = net.create_event("connect_to_watch"),
	disconnect_watch = net.create_event("disconnect_watch"),
	update_overview = net.create_event("update_watch_overview", true)
}