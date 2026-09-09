-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local jecs = require(script.Parent.Parent.Parent.Parent.jecs)
local queue = require(script.Parent.Parent.Parent.modules.queue)
local remotes = require(script.Parent.Parent.Parent.modules.remotes)
local reverse_connector = require(script.Parent.Parent.Parent.modules.reverse_connector)
local traffic_check = require(script.Parent.Parent.Parent.modules.traffic_check)

require(script.Parent.Parent.Parent.modules.types)

local public = require(script.Parent.Parent.public)
local entity_index_try_get = jecs.entity_index_try_get
local IS_PAIR = jecs.IS_PAIR
local pair_first = jecs.pair_first
local pair_second = jecs.pair_second
local t = {}

local function v1(p1, p2, p3) --[[ convert_component | Line: 16 | Upvalues: IS_PAIR (copy), v1 (copy), pair_first (copy), pair_second (copy) ]]
	if IS_PAIR(p3) then
		return ("(%*, %*)"):format(v1(p1, p2, pair_first(p1, p3)), (v1(p1, p2, pair_second(p1, p3))))
	end

	return p1:get(p3, p2) or ("$%*"):format((tostring(p3)))
end

local function get_type(p1) --[[ get_type | Line: 26 ]]
	local v1, v2 = next(p1)

	if v1 == nil then
		return ""
	end

	return ("[%*]: %*"):format(typeof(v1), (typeof(v2)))
end

local function get_string_keys(p1) --[[ get_string_keys | Line: 32 ]]
	local count = 0
	local t = {}

	for v1 in p1 do
		if count > 3 then
			return t, true
		end

		if typeof(v1) == "string" then
			table.insert(t, v1)
			count = count + 1
		end
	end

	return t, false
end

local function is_tag(p1, p2) --[[ is_tag | Line: 44 | Upvalues: jecs (copy) ]]
	return jecs.is_tag(p1, p2)
end

local function get_all_components(p1, p2) --[[ get_all_components | Line: 48 | Upvalues: entity_index_try_get (copy), t (copy), jecs (copy) ]]
	local v1 = entity_index_try_get(p1.entity_index, p2)

	if not v1 then
		return t
	end

	local archetype = v1.archetype

	if not archetype then
		return t
	end

	local t2 = {}

	for v2, v3 in archetype.types do
		table.insert(t2, v3)
	end

	table.sort(t2, function(p12, p2) --[[ Line: 60 | Upvalues: p1 (copy), jecs (ref) ]]
		if jecs.is_tag(p1, p12) and jecs.is_tag(p1, p2) then
			return p12 < p2
		end

		if jecs.is_tag(p1, p12) then
			return true
		end

		if jecs.is_tag(p1, p2) then
			return false
		end

		return p12 < p2
	end)

	return t2
end

local function obtain_string(p1, p2) --[[ obtain_string | Line: 70 | Upvalues: jecs (copy), get_all_components (copy), v1 (copy), get_string_keys (copy) ]]
	local v12 = false
	local v2 = p2:get(p1, jecs.Name)
	local t = {}

	t[1] = ("<b>%*%*</b>\n"):format(if v2 then ("%* #"):format(v2) else "#", p1)

	local sum = #t[1]

	for v7, v8 in get_all_components(p2, p1) do
		local v5, v6

		if v8 ~= jecs.Name then
			local v9 = v1(p2, jecs.Name, v8)
			local v10 = if jecs.is_tag(p2, v8) then nil else p2:get(p1, v8)

			if typeof(v10) == "table" then
				if #get_string_keys(v10) > 0 then
					local t2 = { (("<b>%*</b>:"):format(v9)) }
					local v11 = #t2[1]

					for k, v in pairs(v10) do
						local v122

						if #t2 > 0 then
							table.insert(t2, "\n")
						end

						if type(v) == "string" then
							v122 = ("%*"):format(v)
						elseif typeof(v) == "table" then
							local v13, v14 = next(v)

							v122 = if v13 == nil then "" else ("[%*]: %*"):format(typeof(v13), (typeof(v14)))
						else
							v122 = tostring(v)
						end

						if #v122 > 32 then
							v122 = ("%*.."):format((string.sub(v122, 1, 30)))
						end

						local v17 = ("%*: %*"):format(k, v122)

						if v11 + #v17 + 2 > 32 then
							table.insert(t2, "...")

							break
						end

						table.insert(t2, v17)
					end

					v5 = ("%*"):format((table.concat(t2)))
				else
					local v20, v21 = next(v10)

					v6 = if v20 == nil then "" else ("[%*]: %*"):format(typeof(v20), (typeof(v21)))
					v5 = ("<b>%*</b>: %*"):format(v9, v6)
				end
			elseif jecs.is_tag(p2, v8) then
				v5 = ("<b>%*</b>"):format(v9)
			else
				local v25 = tostring(v10)

				v5 = if #v25 > 32 then ("<b>%*</b>: %*.."):format(v9, (string.sub(v25, 1, 30))) else ("<b>%*</b>: %*"):format(v9, v25)
			end

			if sum + #v5 < 840 then
				table.insert(t, v5)
				sum = sum + #v5

				continue
			end

			v12 = true
		end
	end

	local v28 = table.concat(t, "\n")

	if v12 then
		v28 = v28 .. "..."
	end

	return v28
end

return function() --[[ Line: 141 | Upvalues: queue (copy), remotes (copy), traffic_check (copy), public (copy), reverse_connector (copy), obtain_string (copy), jecs (copy) ]]
	local v1 = queue(remotes.send_mouse_pointer)

	return function() --[[ Line: 145 | Upvalues: v1 (copy), traffic_check (ref), public (ref), reverse_connector (ref), remotes (ref), obtain_string (ref), jecs (ref) ]]
		for v2, v3, v4, v5 in v1:iter() do
			local v12

			if traffic_check.check_no_wl(v2.host) then
				local v6 = public[v3]
				local world = v6.world
				local v7 = reverse_connector(v2)

				if (v6.entities ~= nil or v6.get_entity_from_part ~= nil) and (v6 and v6.class_name == "World") then
					local v8 = workspace:Raycast(v4, v5 * 1000)

					if v8 then
						local v9 = v8.Instance

						if v6.get_entity_from_part == nil and v6.entities == nil then
							remotes.send_mouse_entity:fire(v7, v3)

							continue
						end

						if v6.get_entity_from_part == nil then
							v12 = v6.entities[v9]

							while v12 == nil and v9.Parent ~= game do
								v12 = v6.entities[v9]
								v9 = v9.Parent
							end
						else
							local v11, v122 = v6.get_entity_from_part(v9)

							v12 = v11
							v9 = v122
						end

						if v12 then
							remotes.send_mouse_entity:fire(v7, v3, v9, v12, (obtain_string(v12, world, jecs.Name)))

							continue
						end

						remotes.send_mouse_entity:fire(v7, v3)

						continue
					end

					remotes.send_mouse_entity:fire(v7, v3)
				end
			end
		end
	end
end