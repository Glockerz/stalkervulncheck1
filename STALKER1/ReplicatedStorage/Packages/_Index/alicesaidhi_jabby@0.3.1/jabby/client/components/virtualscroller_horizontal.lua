-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local pebble = require(script.Parent.Parent.Parent.Parent.pebble)
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local create = vide.create
local source = vide.source
local values = vide.values
local changed = vide.changed
local effect = vide.effect
local untrack = vide.untrack

return function(p1) --[[ Line: 32 | Upvalues: source (copy), effect (copy), untrack (copy), create (copy), values (copy), pebble (copy), changed (copy) ]]
	local v1 = source({})
	local v2 = source(Vector2.zero)
	local v3 = source(Vector2.zero)
	local item_size = p1.item_size
	local v4 = p1.separator_size or 0
	local item = p1.item
	local separator = p1.separator

	effect(function() --[[ Line: 47 | Upvalues: v2 (copy), v3 (copy), item_size (copy), v4 (copy), untrack (ref), v1 (copy), p1 (copy), source (ref) ]]
		local v12 = v2()
		local v22 = v3()
		local v32 = item_size + v4
		local v5 = math.ceil(v12.X / v32) + 8
		local v6 = untrack(v1)
		local v8 = math.floor(v22.X / v32)
		local v10 = math.ceil((v22.X + v12.X) / v32)
		local v11 = if p1.max_items then p1.max_items() else (1 / 0)

		untrack(function() --[[ Line: 63 | Upvalues: v6 (copy), v8 (copy), v10 (copy), v11 (ref), v5 (copy), source (ref), v1 (ref) ]]
			local t = {}

			for v12, v2 in v6 do
				local v3 = v2()

				if math.max(v8, 1) <= v3 then
					if not (v3 <= math.min(v10, v11)) then
						t[v12] = true
						v2(-1)
					end
				else
					t[v12] = true
					v2(-1)
				end
			end

			if #v6 < v5 then
				for i = #v6 + 1, v5 do
					v6[i] = source(-1)
					t[i] = true
				end

				v1(v6)
			end

			local t2 = {}

			for j = math.max(v8, 1), math.min(v10, v11) do
				t2[j] = true
			end

			for v102, v112 in v6 do
				t2[v112()] = nil
			end

			for v12 in t do
				local v14 = next(t2)

				if not v14 then
					break
				end

				v6[v12](v14)
				t2[v14] = nil
				t[v12] = nil
			end

			if next(t2) then
				warn("missing source!", next(t2))
			end

			if not (v5 < #v6) then
				return
			end

			for k = #v6, 1, -1 do
				if t[k] then
					table.remove(v6, k)
				end

				t[k] = nil

				if #v6 < v5 then
					break
				end
			end

			v1(v6)
		end)
	end)

	local v5 = create("ScrollingFrame")
	local t = {}

	t.Size = p1.size or UDim2.fromScale(1, 1)
	t.Position = p1.position
	t.AnchorPoint = p1.anchorpoint
	t.BackgroundTransparency = 1
	function t.CanvasSize() --[[ CanvasSize | Line: 134 | Upvalues: p1 (copy), item_size (copy), v4 (copy), v2 (copy), v3 (copy) ]]
		if p1.max_items then
			return UDim2.fromOffset(p1.max_items() * (item_size + v4), 0)
		end

		local v1 = v2()
		local v22 = item_size + v4

		return UDim2.fromOffset((math.ceil((v3().X + v1.X) / v22) + 4) * v22, 0)
	end
	t[1] = values(v1, function(p1) --[[ Line: 146 | Upvalues: create (ref), item_size (copy), v4 (copy), pebble (ref), item (copy), separator (copy) ]]
		local v1 = create("Frame")
		local t = {
			Name = p1,
			Position = function() --[[ Position | Line: 150 | Upvalues: p1 (copy), item_size (ref), v4 (ref) ]]
				if p1() ~= -1 then
					return UDim2.fromOffset((item_size + v4) * (p1() - 1), 0)
				end

				UDim2.fromOffset(0, -1000)

				return UDim2.fromOffset((item_size + v4) * (p1() - 1), 0)
			end,
			Size = UDim2.new(0, item_size + v4, 1, 0),
			BackgroundTransparency = 1
		}
		local v2 = pebble.container({
			Name = "Item",
			item(p1)
		})
		local v3 = if separator then pebble.container({
	Name = "Separator",
	separator(p1)
}) else nil

		t[1] = v2
		t[2] = v3

		return v1(t)
	end)
	t[2] = changed("AbsoluteSize", v2)
	t[3] = changed("CanvasPosition", v3)
	t[4] = unpack(p1)

	return v5(t)
end