-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local loop = require(script.Parent.Parent.Parent.modules.loop)
local spawn_app = require(script.Parent.Parent.spawn_app)
local entity = require(script.Parent.entity)
local widget = require(script.widget)
local source = vide.source
local effect = vide.effect
local cleanup = vide.cleanup

return {
	class_name = "app",
	name = "Query",
	mount = function(p1, p2) --[[ mount | Line: 25 | Upvalues: source (copy), loop (copy), cleanup (copy), RunService (copy), spawn_app (copy), entity (copy), effect (copy), ContextActionService (copy), widget (copy) ]]
		local v1 = source(nil)
		local v2 = source(false)
		local v3 = source()
		local v4 = source()
		local v5 = source("")
		local v6 = source(false)
		local v7 = source("")
		local v8 = source("")
		local v9 = source()
		local v10 = source({})
		local v11 = source(1)
		local v12 = source(25)
		local v13 = source(0)
		local v14 = source(false)
		local v15 = source(false)

		cleanup(RunService.Heartbeat:Connect((loop("app-client-registry", {
			host = p1.host,
			vm = p1.vm,
			id = p1.id,
			enable_pick = v2,
			entity_hovering_over = v3,
			hovering_over = v4,
			set_entity = v1,
			columns = v10,
			query = v8,
			primary_entity = v9,
			paused = v14,
			refresh = v15,
			total_entities = v13,
			from = v11,
			upto = v12,
			validate_query = v5,
			ok = v6,
			msg = v7
		}, {
			i = 1
		}, script.systems.validate_query, script.systems.obtain_query_data, script.systems.send_workspace_entity, script.systems.highlight_workspace_entity))))

		local function open_entity_widget(p12, p2) --[[ open_entity_widget | Line: 88 | Upvalues: v1 (copy), v2 (copy), v3 (copy), v4 (copy), spawn_app (ref), entity (ref), p1 (copy) ]]
			local v12 = v1()

			if p2 ~= Enum.UserInputState.Begin then
				return
			end

			if v12 ~= nil then
				v2(false)
				v3(nil)
				v4(nil)
				spawn_app.spawn_app(entity, {
					host = p1.host,
					vm = p1.vm,
					id = p1.id,
					entity = v12
				})
			end
		end

		effect(function() --[[ Line: 106 | Upvalues: v2 (copy), p1 (copy), ContextActionService (ref), open_entity_widget (copy), cleanup (ref) ]]
			local v1 = v2()
			local v22 = ("select entity:%* %* %*"):format(p1.host, p1.vm, p1.id)

			if v1 then
				ContextActionService:BindAction(v22, open_entity_widget, false, Enum.UserInputType.MouseButton1)
			end

			cleanup(function() --[[ Line: 114 | Upvalues: ContextActionService (ref), v22 (copy) ]]
				ContextActionService:UnbindAction(v22)
			end)
		end)

		return widget({
			host = p1.host,
			vm = p1.vm,
			id = p1.id,
			validate_query = v5,
			update_system_query = v8,
			current_query = v8,
			total_rows_per_page = source(25),
			set_rows_per_page = source(25),
			primary_entity = v9,
			from = v11,
			upto = v12,
			total_entities = v13,
			paused = v14,
			refresh = v15,
			enable_pick = v2,
			entity_hovering_over = v3,
			hovering_over = v4,
			ok = v6,
			msg = v7,
			columns = v10,
			destroy = p2
		})
	end
}