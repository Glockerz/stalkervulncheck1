-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble)
local vide = require(script.Parent.Parent.Parent.Parent.Parent.vide)
local remotes = require(script.Parent.Parent.Parent.Parent.modules.remotes)
local add_component = require(script.Parent.add_component)
local editor = require(script.Parent.editor)
local create = vide.create
local indexes = vide.indexes
local source = vide.source
local show = vide.show
local v1 = source(Vector2.zero)

RunService.PreRender:Connect(function() --[[ Line: 35 | Upvalues: v1 (copy), UserInputService (copy) ]]
	v1(UserInputService:GetMouseLocation())
end)

return function(p1) --[[ Line: 39 | Upvalues: source (copy), remotes (copy), vide (copy), pebble (copy), create (copy), editor (copy), add_component (copy), indexes (copy), show (copy) ]]
	local t = {
		host = p1.host,
		to_vm = p1.vm
	}
	local live_updates = p1.live_updates
	local changes = p1.changes
	local v1 = source("")
	local v2 = source(false)
	local v3 = source(false)

	local function components() --[[ components | Line: 52 | Upvalues: p1 (copy) ]]
		local t = {}

		for v1, v2 in p1.components() do
			if v2 ~= "tag" then
				t[v1] = v2
			end
		end

		return t
	end

	local function tags() --[[ tags | Line: 63 | Upvalues: p1 (copy) ]]
		local t = {}

		for v1, v2 in p1.components() do
			if v2 == "tag" then
				t[v1] = v2
			end
		end

		return t
	end

	local function is_removed(p1) --[[ is_removed | Line: 74 ]]
		return p1 == "nil"
	end

	local function edit_component(p12) --[[ edit_component | Line: 78 | Upvalues: remotes (ref), t (copy), p1 (copy), v3 (copy), v1 (copy) ]]
		remotes.get_component:fire(t, p1.inspect_id, p12)
		v3(p12)
		v1("waiting...")
	end

	vide.cleanup(remotes.return_component:connect(function(p12, p2, p3, p4) --[[ Line: 85 | Upvalues: p1 (copy), v1 (copy) ]]
		if p1.host ~= p12.host then
			return
		end

		if p1.inspect_id ~= p2 then
			return
		end

		local v12 = p1.changes()[p3]

		if v12 then
			v1(v12)
		else
			v1(p4)
		end
	end))

	return pebble.widget({
		title = ("Entity #%*"):format(p1.entity),
		subtitle = ("host: %* vm: %* id: %*"):format(p1.host, p1.vm, p1.id),
		min_size = Vector2.new(300, 300),
		bind_to_close = p1.destroy,
		create("Frame")({
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			create("UIListLayout")({
				VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly,
				Padding = UDim.new(0, 8)
			}),
			editor({
				components = p1.components,
				editing = v3,
				text = v1,
				changes = changes
			}),
			add_component({
				editing = edit_component,
				text = v1,
				changes = changes,
				adding = v2
			}),
			pebble.row({
				justifycontent = Enum.UIFlexAlignment.Fill,
				pebble.button({
					text = "Live Updates",
					activated = function() --[[ activated | Line: 136 | Upvalues: live_updates (copy) ]]
						live_updates(not live_updates())
					end,
					create("UIListLayout")({
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
						Padding = UDim.new(0, 4)
					}),
					pebble.checkbox({
						size = UDim2.fromOffset(16, 16),
						layoutorder = -1,
						checked = live_updates,
						create("UIFlexItem")({
							FlexMode = Enum.UIFlexMode.None
						})
					})
				}),
				pebble.button({
					size = UDim2.fromOffset(130, 30),
					text = function() --[[ text | Line: 161 | Upvalues: changes (copy) ]]
						local count = 0

						for v1, v2 in changes() do
							count = count + 1
						end

						return ("Apply %* Edits"):format(count)
					end,
					disabled = function() --[[ disabled | Line: 170 | Upvalues: changes (copy) ]]
						return next(changes()) == nil
					end,
					activated = function() --[[ activated | Line: 173 | Upvalues: p1 (copy) ]]
						p1.apply_changes(true)
					end
				}),
				pebble.button({
					create("UIFlexItem")({
						ItemLineAlignment = Enum.ItemLineAlignment.End
					}),
					size = UDim2.fromOffset(130, 30),
					text = "Cancel changes",
					disabled = function() --[[ disabled | Line: 185 | Upvalues: changes (copy) ]]
						return next(changes()) == nil
					end,
					activated = function() --[[ activated | Line: 188 | Upvalues: changes (copy) ]]
						changes({})
					end
				})
			}),
			create("ScrollingFrame")({
				Size = UDim2.fromScale(1, 0),
				CanvasSize = UDim2.new(),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = pebble.theme.bg[-1],
				ScrollBarThickness = 6,
				VerticalScrollBarInset = Enum.ScrollBarInset.Always,
				create("UIFlexItem")({
					FlexMode = Enum.UIFlexMode.Fill
				}),
				create("UIListLayout")({
					Padding = UDim.new(0, 4)
				}),
				pebble.typography({
					text = "Components"
				}),
				pebble.container({
					Size = UDim2.fromScale(1, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					create("UIListLayout")({
						SortOrder = Enum.SortOrder.Name
					}),
					indexes(components, function(p12, p2) --[[ Line: 223 | Upvalues: pebble (ref), remotes (ref), t (copy), p1 (copy), v3 (copy), v1 (copy), create (ref), show (ref) ]]
						local button = pebble.button
						local t2 = {}
						local t3 = {}

						t3.Name = if string.match(p2, "^%a") then p2 else "zzzz" .. p2
						t2[1] = t3
						t2.size = UDim2.new(1, 0, 0, 32)
						t2.automaticsize = Enum.AutomaticSize.Y
						t2.text = ""
						t2.corner = false
						function t2.activated() --[[ activated | Line: 233 | Upvalues: p2 (copy), remotes (ref), t (ref), p1 (ref), v3 (ref), v1 (ref) ]]
							local v12 = p2

							remotes.get_component:fire(t, p1.inspect_id, v12)
							v3(v12)
							v1("waiting...")
						end
						t2[2] = create("UIListLayout")({
							FillDirection = Enum.FillDirection.Horizontal,
							HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							Padding = UDim.new(0, 8)
						})
						t2[3] = pebble.padding({
							y = UDim.new(0, 4)
						})
						t2[4] = pebble.typography({
							code = true,
							wrapped = true,
							size = UDim2.new(0, 100, 0, 18),
							automaticsize = Enum.AutomaticSize.Y,
							text = p2,
							truncate = Enum.TextTruncate.SplitWord,
							xalignment = Enum.TextXAlignment.Left
						})
						t2[5] = pebble.typography({
							size = UDim2.fromOffset(0, 18),
							automaticsize = Enum.AutomaticSize.Y,
							yalignment = Enum.TextYAlignment.Top,
							xalignment = Enum.TextXAlignment.Left,
							text = p12,
							wrapped = true,
							truncate = Enum.TextTruncate.AtEnd,
							code = true,
							create("UIFlexItem")({
								FlexMode = Enum.UIFlexMode.Fill
							})
						})
						t2[6] = show(function() --[[ Line: 275 | Upvalues: p1 (ref), p2 (copy) ]]
							return p1.changes()[p2] ~= nil
						end, function() --[[ Line: 277 | Upvalues: pebble (ref), p12 (copy), p1 (ref), p2 (copy) ]]
							return pebble.typography({
								disabled = true,
								textsize = 14,
								text = function() --[[ text | Line: 279 | Upvalues: p12 (ref), p1 (ref), p2 (ref) ]]
									local v1 = p12()
									local v2 = p1.changes()[p2]

									if v1 == nil then
										return "(added)"
									end

									if v2 == "nil" then
										return "(removed)"
									end

									return "(changed)"
								end
							})
						end)
						t2[7] = create("UISizeConstraint")({
							MaxSize = Vector2.new((1 / 0), 300)
						})

						return button(t2)
					end)
				}),
				pebble.typography({
					text = "Tags"
				}),
				pebble.container({
					Size = UDim2.fromScale(1, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					create("UIListLayout")({
						SortOrder = Enum.SortOrder.Name
					}),
					indexes(tags, function(p12, p2) --[[ Line: 309 | Upvalues: changes (copy), pebble (ref), p1 (copy), create (ref), show (ref) ]]
						local function did_change() --[[ did_change | Line: 310 | Upvalues: changes (ref), p2 (copy) ]]
							return changes()[p2] ~= nil
						end

						local button = pebble.button
						local t = {}
						local t2 = {}

						t2.Name = if string.match(p2, "^%a") then p2 else "zzzz" .. p2
						t[1] = t2
						t.size = UDim2.new(1, 0, 0, 24)
						t.text = ""
						t.corner = false
						function t.activated() --[[ activated | Line: 322 | Upvalues: changes (ref), p2 (copy), p1 (ref) ]]
							if changes()[p2] == "tag" then
								changes()[p2] = nil
								p1.components()[p2] = nil
								changes(changes())
								p1.components(p1.components())

								return
							end

							if changes()[p2] then
								changes()[p2] = nil
							else
								changes()[p2] = "nil"
							end

							changes(changes())
						end
						t[2] = create("UIListLayout")({
							FillDirection = Enum.FillDirection.Horizontal,
							HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							Padding = UDim.new(0, 8)
						})
						t[3] = pebble.padding({
							y = UDim.new(0, 4)
						})
						t[4] = pebble.typography({
							size = UDim2.fromScale(0, 1),
							text = p2,
							code = true,
							wrapped = true,
							truncate = Enum.TextTruncate.SplitWord,
							xalignment = Enum.TextXAlignment.Left,
							create("UIFlexItem")({
								FlexMode = Enum.UIFlexMode.Fill
							})
						})
						t[5] = show(did_change, function() --[[ Line: 367 | Upvalues: pebble (ref), p12 (copy), changes (ref), p2 (copy) ]]
							return pebble.typography({
								disabled = true,
								textsize = 14,
								text = function() --[[ text | Line: 369 | Upvalues: p12 (ref), changes (ref), p2 (ref) ]]
									local v1 = p12()
									local v2 = changes()[p2]

									if v1 == nil then
										return "(added)"
									end

									if v2 == "nil" then
										return "(removed)"
									end

									return "(changed)"
								end
							})
						end)

						return button(t)
					end)
				})
			}),
			pebble.row({
				justifycontent = Enum.UIFlexAlignment.Fill,
				pebble.button({
					text = "Delete Id",
					size = UDim2.fromOffset(100, 30),
					activated = p1.delete
				}),
				pebble.button({
					text = "Add Component",
					size = UDim2.fromOffset(200, 30),
					activated = function() --[[ activated | Line: 402 | Upvalues: v2 (copy) ]]
						v2(true)
					end
				})
			})
		})
	})
end