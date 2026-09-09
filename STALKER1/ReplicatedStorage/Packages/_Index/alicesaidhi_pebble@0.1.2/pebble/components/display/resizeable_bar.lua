-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local padding = require(script.Parent.Parent.util.padding)
local rounded_frame = require(script.Parent.Parent.util.rounded_frame)
local typography = require(script.Parent.typography)
local create = vide.create
local source = vide.source
local derive = vide.derive
local effect = vide.effect
local cleanup = vide.cleanup
local indexes = vide.indexes
local changed = vide.changed
local untrack = vide.untrack
local v1 = source(0)
local v2 = source(1)

return function(p1) --[[ Line: 34 | Upvalues: source (copy), derive (copy), effect (copy), vide (copy), v1 (copy), v2 (copy), untrack (copy), rounded_frame (copy), theme (copy), create (copy), indexes (copy), typography (copy), padding (copy), changed (copy), cleanup (copy), RunService (copy), UserInputService (copy) ]]
	local meaning = p1.meaning
	local sizes = p1.sizes
	local v12 = p1.min_sizes or source({})
	local v22 = p1.suggested_sizes or {}
	local v3 = source(Vector2.one)
	local v4 = source(Vector2.one)
	local v5 = derive(function() --[[ Line: 43 | Upvalues: meaning (copy) ]]
		return #meaning()
	end)
	local v6 = p1.splits or source({})
	local v7 = derive(function() --[[ Line: 48 | Upvalues: p1 (copy) ]]
		return #p1.meaning()
	end)

	effect(function(p1) --[[ Line: 52 | Upvalues: v7 (copy), vide (ref), source (ref), v22 (copy), v6 (copy) ]]
		local t = {}

		for i = 1, v7() - 1 do
			local v1
			local v3 = vide.read(p1 and p1[i] or nil)

			v1 = if v3 and v3 ~= 1 then v3 else v22[i] or 1
			t[i] = source((math.min(v1, i / v7())))
		end

		v6(t)

		return t
	end)

	for v9, v10 in p1.base_splits or {} do
		v6()[v9](v10)
	end

	local function get_size(p1) --[[ get_size | Line: 68 | Upvalues: v6 (copy), v1 (ref), v2 (ref) ]]
		local v12 = v6()[p1 - 1] or v1
		local v22 = v6()[p1] or v2

		return v22() - v12()
	end

	local function get_min_size(p1) --[[ get_min_size | Line: 76 | Upvalues: v12 (copy) ]]
		local v1 = v12()[p1]

		return if v1 then v1() or 0.025 else 0.025
	end

	effect(function() --[[ Line: 81 | Upvalues: v5 (copy), v12 (copy), source (ref), untrack (ref), derive (ref), v6 (copy), v1 (ref), v2 (ref), sizes (copy) ]]
		local v13 = setmetatable({}, {
			__index = function() --[[ __index | Line: 83 ]]
				return function() --[[ Line: 84 ]]
					return 0
				end
			end
		})

		for i = 1, v5() do
			v12()[i] = v12()[i] or source(0.025)
			untrack(function() --[[ Line: 90 | Upvalues: v13 (copy), i (copy), derive (ref), v6 (ref), v1 (ref), v2 (ref) ]]
				v13[i] = derive(function() --[[ Line: 91 | Upvalues: i (ref), v6 (ref), v1 (ref), v2 (ref) ]]
					local v12 = i
					local v22 = v6()[v12 - 1] or v1
					local v3 = v6()[v12] or v2

					return v3() - v22()
				end)
			end)
		end

		sizes(v13)
	end)

	local v11 = false
	local v122 = 0

	return rounded_frame({
		size = function() --[[ size | Line: 104 ]]
			return UDim2.new(1, 0, 0, 32)
		end,
		topleft = UDim.new(0, 8),
		topright = UDim.new(0, 8),
		color = theme.bg[1],
		create("TextButton")({
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			AutoLocalize = false,
			Text = "",
			create("UIListLayout")({
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 0)
			}),
			indexes(meaning, function(p1, p2) --[[ Line: 122 | Upvalues: typography (ref), v6 (copy), v1 (ref), v2 (ref), padding (ref) ]]
				return typography({
					size = function() --[[ size | Line: 124 | Upvalues: p2 (copy), v6 (ref), v1 (ref), v2 (ref) ]]
						local fromScale = UDim2.fromScale
						local v12 = p2
						local v22 = v6()[v12 - 1] or v1
						local v3 = v6()[v12] or v2

						return fromScale(v3() - v22(), 1)
					end,
					automaticsize = Enum.AutomaticSize.None,
					text = function() --[[ text | Line: 128 | Upvalues: p1 (copy) ]]
						return p1() or ""
					end,
					xalignment = Enum.TextXAlignment.Left,
					truncate = Enum.TextTruncate.AtEnd,
					header = true,
					textsize = 18,
					padding({
						x = UDim.new(0, 8)
					})
				})
			end),
			changed("AbsoluteSize", v3),
			changed("AbsolutePosition", v4),
			MouseButton1Down = function(p1) --[[ MouseButton1Down | Line: 143 | Upvalues: v4 (copy), v3 (copy), v6 (copy), v11 (ref), v122 (ref) ]]
				local v1 = p1 - v4().X
				local v2 = v3()
				local v32 = -1

				for v42, v5 in v6() do
					if not (math.abs(v1 - v2.X * v5()) > 32) then
						v32 = v42
					end
				end

				v11 = v32 ~= -1
				v122 = v32
			end,
			MouseButton1Up = function() --[[ MouseButton1Up | Line: 159 | Upvalues: v11 (ref) ]]
				v11 = false
			end,
			cleanup(RunService.Heartbeat:Connect(function() --[[ Line: 163 | Upvalues: UserInputService (ref), v4 (copy), v11 (ref), v3 (copy), v6 (copy), v122 (ref), v5 (copy), v12 (copy), v1 (ref), v2 (ref) ]]
				local v13 = UserInputService:GetMouseLocation().X - v4().X

				if v11 == false then
					return
				end

				v11 = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == true

				local sum = v13 / v3().X - v6()[v122]()

				if sum > 0 then
					for i = v122, v5() - 1 do
						local v32
						local v42 = v12()[i + 1]

						v32 = v42 and v42() or 0.025

						local v62 = i + 1
						local v7 = v6()[v62 - 1] or v1
						local v8 = v6()[v62] or v2
						local v9 = v8() - v7()
						local v10 = v9 - math.max(v9 - sum, v32)

						v6()[i](v6()[i]() + v10)
						sum = sum - v10

						if sum == 0 then
							break
						end
					end

					return
				end

				for j = v122, 1, -1 do
					local v112
					local v123 = v12()[j]

					v112 = v123 and v123() or 0.025

					local v14 = v6()[j - 1] or v1
					local v15 = v6()[j] or v2
					local v17 = math.max(v15() - v14(), v112)
					local v18 = math.max(v17 + sum, v112) - v17

					v6()[j](v6()[j]() + v18)
					sum = sum - v18

					if sum == 0 then
						break
					end
				end
			end))
		})
	})
end