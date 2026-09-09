-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local create = vide.create
local source = vide.source
local cleanup = vide.cleanup
local effect = vide.effect
local action = vide.action
local changed = vide.changed
local untrack = vide.untrack
local read = vide.read

local function in_bounds(p1, p2, p3) --[[ in_bounds | Line: 33 ]]
	return if p1.X >= p2.X and (p1.X <= p2.X + p3.X and p1.Y >= p2.Y) then p1.Y <= p2.Y + p3.Y else false
end

return function() --[[ Line: 37 | Upvalues: source (copy), create (copy), changed (copy), action (copy), cleanup (copy), effect (copy), untrack (copy), read (copy), UserInputService (copy) ]]
	local t = {}
	local v1 = source(Vector2.zero)

	local function snap_area(p1) --[[ snap_area | Line: 42 | Upvalues: source (ref), create (ref), changed (ref), action (ref), t (copy), cleanup (ref) ]]
		local v1 = source(Vector2.zero)
		local v2 = source(Vector2.zero)
		local v3 = source(false)

		return create("Frame")({
			Name = "SnapArea",
			AutoLocalize = false,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			changed("AbsoluteSize", v2),
			changed("AbsolutePosition", v1),
			action(function(p12) --[[ Line: 57 | Upvalues: t (ref), v1 (copy), v3 (copy), v2 (copy), p1 (copy), cleanup (ref) ]]
				t[p12] = {
					position = v1,
					docked = v3,
					size = v2,
					zindex = p1.zindex or 0
				}
				cleanup(function() --[[ Line: 65 | Upvalues: t (ref), p12 (copy) ]]
					t[p12] = nil
				end)
			end)
		})
	end

	local function snappable(p1) --[[ snappable | Line: 72 | Upvalues: source (ref), effect (ref), v1 (copy), untrack (ref), t (copy), read (ref) ]]
		local v12 = source()

		effect(function() --[[ Line: 75 | Upvalues: p1 (copy), v1 (ref), untrack (ref), v12 (copy), t (ref), read (ref) ]]
			if p1.dragging() ~= false then
				local v13 = v1()

				untrack(function() --[[ Line: 79 | Upvalues: v12 (ref), t (ref), v13 (copy), read (ref), p1 (ref) ]]
					if v12() then
						v12().docked(false)
					end

					local v1 = nil

					for v2, v3 in t do
						local v4 = v13
						local v5 = v3.position()
						local v6 = v3.size()
						local v7 = if v4.X >= v5.X and (v4.X <= v5.X + v6.X and v4.Y >= v5.Y) then v4.Y <= v5.Y + v6.Y else false

						if v7 and not (v1 and read(v3.zindex) <= read(v1.zindex)) then
							v1 = v3
						end
					end

					if not v1 and read(p1.allow_floating) == false then
						return
					end

					if v1 and v1.docked() then
						return
					end

					if v1 then
						v1.docked(true)
					end

					v12(v1)
				end)
			end
		end)
		effect(function() --[[ Line: 98 | Upvalues: p1 (copy), v12 (copy) ]]
			p1.snapped(v12() and true or false)
		end)
		effect(function() --[[ Line: 102 | Upvalues: v12 (copy), p1 (copy) ]]
			if v12() then
				local v1 = v12()
				local v2 = v1.position()
				local v3 = v1.size()

				p1.position(UDim2.fromOffset(v2.X, v2.Y))
				p1.size(UDim2.fromOffset(v3.X, v3.Y))
			end
		end)
	end

	cleanup(UserInputService.InputChanged:Connect(function(p1) --[[ Line: 113 | Upvalues: v1 (copy) ]]
		if p1.UserInputType == Enum.UserInputType.MouseMovement then
			v1(Vector2.new(p1.Position.X, p1.Position.Y))
		end
	end))

	return {
		snap_area = snap_area,
		snappable = snappable
	}
end