-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = { "BackpackContents", "ChestRigContents", "BattleBeltContents" }

function t.IsEncoded(p1) --[[ IsEncoded | Line: 61 ]]
	if type(p1) ~= "table" then
		return false
	end

	local v1 = p1[1]

	return if type(v1) == "table" and v1.Index ~= nil then type(v1.Item) == "table" else false
end

local function encodeItem(p1, p2, p3) --[[ encodeItem | Line: 90 | Upvalues: t2 (copy), t (copy) ]]
	if type(p1) ~= "table" then
		return p1
	end

	local v1 = if p2 then p2 else {}
	local v2 = p3 or 0

	if v1[p1] then
		local v3 = warn
		local format = string.format

		v3(format("[InventoryWire] CYCLE: item \'%s\' is inside itself -- sending one copy with empty contents. The stored data still holds the loop and needs repairing.", (tostring(p1.ID))))

		local v4 = table.clone(p1)

		for i, v in ipairs(t2) do
			if type(v4[v]) == "table" then
				v4[v] = {}
			end
		end

		return v4
	end

	local v6 = table.clone(p1)

	v1[p1] = true

	local v7 = v1

	for i, v in ipairs(t2) do
		local v8 = v6[v]

		if type(v8) == "table" then
			if v7[v8] then
				local v9 = warn
				local format = string.format

				v9(format("[InventoryWire] CYCLE: item \'%s\' has %s that contains the item itself -- sending it empty. The stored data still holds the loop and needs repairing.", tostring(p1.ID), v))
				v6[v] = {}

				continue
			end

			if v2 >= 8 then
				local v10 = warn
				local format = string.format

				v10(format("[InventoryWire] item \'%s\' nests deeper than %d levels at %s -- sending it empty", tostring(p1.ID), 8, v))
				v6[v] = {}

				continue
			end

			v6[v] = t.EncodeItems(v8, v7, v2 + 1)
		end
	end

	v7[p1] = nil

	return v6
end

local function decodeItem(p1) --[[ decodeItem | Line: 136 | Upvalues: t2 (copy), t (copy) ]]
	if type(p1) ~= "table" then
		return p1
	end

	local v1 = table.clone(p1)

	for i, v in ipairs(t2) do
		if t.IsEncoded(v1[v]) then
			v1[v] = t.DecodeItems(v1[v])
		end
	end

	return v1
end

function t.EncodeItems(p1, p2, p3) --[[ EncodeItems | Line: 153 | Upvalues: t (copy), encodeItem (copy) ]]
	local t2 = {}

	if type(p1) ~= "table" then
		return t2
	end

	local v1 = if p2 then p2 else {}
	local v2 = p3 or 0

	if v1[p1] then
		warn("[InventoryWire] CYCLE: contents table reached itself -- encoding it empty")

		return t2
	end

	v1[p1] = true

	if t.IsEncoded(p1) then
		local v3 = v1

		for i, v in ipairs(p1) do
			t2[i] = {
				Index = v.Index,
				Item = encodeItem(v.Item, v3, v2)
			}
		end

		v3[p1] = nil
	else
		list = {}
		v4 = v1

		for k, v in pairs(p1) do
			if v ~= nil then
				table.insert(list, k)
			end
		end

		table.sort(list, function(p1, p2) --[[ Line: 178 ]]
			local v1 = type(p1)

			if v1 == type(p2) then
				if v1 == "number" then
					return p1 < p2
				end

				return tostring(p1) < tostring(p2)
			end

			return v1 == "number"
		end)

		for i, v in ipairs(list) do
			t2[i] = {
				Index = v,
				Item = encodeItem(p1[v], v4, v2)
			}
		end

		v4[p1] = nil
	end

	return t2
end
function t.DecodeItems(p1) --[[ DecodeItems | Line: 192 | Upvalues: t (copy), decodeItem (copy) ]]
	local t2 = {}

	if type(p1) ~= "table" then
		return t2
	end

	if t.IsEncoded(p1) then
		for i, v in ipairs(p1) do
			if v ~= nil and v.Index ~= nil then
				t2[v.Index] = decodeItem(v.Item)
			end
		end
	else
		for k, v in pairs(p1) do
			t2[k] = decodeItem(v)
		end
	end

	return t2
end
function t.EncodeInventory(p1) --[[ EncodeInventory | Line: 213 | Upvalues: t (copy) ]]
	if type(p1) == "table" then
		local v1 = table.clone(p1)

		v1.Items = t.EncodeItems(p1.Items)
		v1.WireVersion = 1

		return v1
	end

	return p1
end
function t.SafeEncode(p1, p2) --[[ SafeEncode | Line: 235 | Upvalues: t (copy) ]]
	if type(p1) == "table" and type(p1.Items) == "table" then
		local v1 = t.EncodeInventory(p1)
		local v2 = t.Count(p1.Items)
		local v3 = t.Count(v1.Items)

		if v2 == v3 then
			return v1
		end

		warn(string.format("[WIRE] %s encode count mismatch %d -> %d -- sending RAW", tostring(p2), v2, v3))

		return p1
	end

	return p1
end
function t.SafeEncodeItems(p1, p2) --[[ SafeEncodeItems | Line: 253 | Upvalues: t (copy) ]]
	if type(p1) ~= "table" then
		return p1
	end

	local v1 = t.EncodeItems(p1)
	local v2 = t.Count(p1)
	local v3 = t.Count(v1)

	if v2 == v3 then
		return v1
	end

	warn(string.format("[WIRE] %s encode count mismatch %d -> %d -- sending RAW", tostring(p2), v2, v3))

	return p1
end
function t.EncodeEquipPayload(p1) --[[ EncodeEquipPayload | Line: 279 | Upvalues: t2 (copy), t (copy) ]]
	if type(p1) ~= "table" then
		return p1
	end

	local v1 = table.clone(p1)

	for i, v in ipairs(t2) do
		if type(v1[v]) == "table" then
			v1[v] = t.EncodeItems(v1[v])
		end
	end

	return v1
end
function t.Each(p1) --[[ Each | Line: 312 | Upvalues: t (copy) ]]
	if type(p1) ~= "table" then
		return function() --[[ Line: 314 ]]
			return nil
		end
	end

	if t.IsEncoded(p1) then
		local v1 = 0

		return function() --[[ Line: 320 | Upvalues: v1 (ref), p1 (copy) ]]
			local v12

			repeat
				v1 = v1 + 1
				v12 = p1[v1]

				if v12 == nil then
					return nil
				end

				if type(v12) ~= "table" or v12.Index == nil then
					repeat
						v1 = v1 + 1
						v12 = p1[v1]

						if v12 == nil then
							return nil
						end
					until type(v12) == "table" and v12.Index ~= nil
				end
			until type(v12.Item) == "table"

			return v12.Index, v12.Item
		end
	end

	return pairs(p1)
end
function t.Count(p1) --[[ Count | Line: 334 | Upvalues: t (copy) ]]
	if type(p1) ~= "table" then
		return 0
	end

	local count = 0

	if t.IsEncoded(p1) then
		for i, v in ipairs(p1) do
			if v and v.Item then
				count = count + 1
			end
		end
	else
		for k, v in pairs(p1) do
			if v then
				count = count + 1
			end
		end
	end

	return count
end

return t