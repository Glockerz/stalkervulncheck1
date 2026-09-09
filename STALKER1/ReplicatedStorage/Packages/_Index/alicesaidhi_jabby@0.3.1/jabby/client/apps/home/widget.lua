-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble)
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide)
local spawn_app = require(script.Parent.Parent.Parent.spawn_app)
local overview_scheduler = require(script.Parent.Parent.overview_scheduler)
local registry = require(script.Parent.Parent.registry)
local create = vide.create
local derive = vide.derive
local source = vide.source
local values = vide.values
local show = vide.show

return function(p1) --[[ Line: 35 | Upvalues: source (copy), Players (copy), derive (copy), pebble (copy), create (copy), show (copy), values (copy), spawn_app (copy), registry (copy), overview_scheduler (copy) ]]
	local v1 = source(Players.LocalPlayer)
	local v2 = derive(function() --[[ Line: 39 | Upvalues: p1 (copy) ]]
		local t = {}

		for v1, v2 in p1.servers() do
			local host = v2.host

			t[host] = t[host] or {}
			table.insert(t[host], v2)
		end

		t.all = p1.servers()

		return t
	end)
	local v3 = derive(function() --[[ Line: 53 | Upvalues: v2 (copy), Players (ref) ]]
		local t = {}

		for v1, v22 in v2() do
			t[v1] = if type(v1) == "string" then v1 else ("@%*"):format(v1.Name)
		end

		t[Players.LocalPlayer] = "localplayer"
		t.all = "all"

		return t
	end)

	local function objects() --[[ objects | Line: 66 | Upvalues: v2 (copy), v1 (copy) ]]
		return v2()[v1()] or {}
	end

	local function is_empty() --[[ is_empty | Line: 70 | Upvalues: v2 (copy), v1 (copy) ]]
		local v12 = next

		if v12(v2()[v1()] or {}) == nil then
			return "No objects found. You may not have permissions to use this."
		end

		return false
	end

	return pebble.widget({
		title = "Home",
		min_size = Vector2.new(230, 200),
		bind_to_close = p1.destroy,
		pebble.container({ create("UIListLayout")({
				Padding = UDim.new(0, 2),
				VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly,
				HorizontalFlex = Enum.UIFlexAlignment.Fill
			}), pebble.select({
				size = UDim2.new(1, 0, 0, 32),
				options = v3,
				selected = v1,
				update_selected = v1
			}), create("ScrollingFrame")({
				CanvasSize = UDim2.new(),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				ScrollBarThickness = 6,
				HorizontalScrollBarInset = Enum.ScrollBarInset.Always,
				create("UIFlexItem")({
					FlexMode = Enum.UIFlexMode.Fill
				}),
				pebble.padding({
					x = UDim.new(0, 1),
					right = UDim.new(0, 8)
				}),
				create("UIListLayout")({
					Wraps = true,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 8)
				}),
				show(is_empty, function() --[[ Line: 124 | Upvalues: pebble (ref), v2 (copy), v1 (copy) ]]
					local t = {
						wrapped = true
					}

					t.text = if if next(v2()[v1()] or {}) == nil then true else false then "No objects found. You may not have permissions to use this." else false
					t.xalignment = Enum.TextXAlignment.Left

					return pebble.typography(t)
				end),
				values(objects, function(p1, p2) --[[ Line: 132 | Upvalues: pebble (ref), create (ref), values (ref), spawn_app (ref), registry (ref), overview_scheduler (ref) ]]
					return pebble.pane({
						name = "",
						size = UDim2.fromOffset(200, 0),
						automaticsize = Enum.AutomaticSize.Y,
						create("UIListLayout")({
							Padding = UDim.new(0, 8)
						}),
						pebble.typography({
							wrapped = true,
							text = ("host: %*\tvm id: %*"):format(p1.host, p1.vm)
						}),
						values(p1.worlds, function(p12) --[[ Line: 148 | Upvalues: pebble (ref), spawn_app (ref), registry (ref), p1 (copy) ]]
							return pebble.button({
								size = UDim2.new(1, 0, 0, 30),
								text = ("World: %*"):format(p12.name),
								activated = function() --[[ activated | Line: 153 | Upvalues: spawn_app (ref), registry (ref), p1 (ref), p12 (copy) ]]
									spawn_app.spawn_app(registry, {
										host = p1.host,
										vm = p1.vm,
										id = p12.id
									})
								end
							})
						end),
						values(p1.schedulers, function(p12) --[[ Line: 163 | Upvalues: pebble (ref), spawn_app (ref), overview_scheduler (ref), p1 (copy) ]]
							return pebble.button({
								size = UDim2.new(1, 0, 0, 30),
								text = ("Scheduler: %*"):format(p12.name),
								activated = function() --[[ activated | Line: 168 | Upvalues: spawn_app (ref), overview_scheduler (ref), p1 (ref), p12 (copy) ]]
									spawn_app.spawn_app(overview_scheduler, {
										host = p1.host,
										vm = p1.vm,
										id = p12.id
									})
								end
							})
						end)
					})
				end)
			}) })
	})
end