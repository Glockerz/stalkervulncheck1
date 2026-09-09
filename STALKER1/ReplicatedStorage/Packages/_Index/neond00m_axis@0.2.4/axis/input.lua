-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = _G.UserInputService or game:GetService("UserInputService")

require("./types")

local v2 = require("./match")
local v3 = 1

local function deadzone(p1, p2) --[[ deadzone | Line: 14 ]]
	if p2 < (p1.deadzone or 0.3) then
		return 0
	end

	return p2
end

local function getGamepad(p1) --[[ getGamepad | Line: 28 ]]
	if p1.Value < Enum.UserInputType.Gamepad1.Value or p1.Value > Enum.UserInputType.Gamepad8.Value then
		return 1
	end

	return p1.Value - Enum.UserInputType.Gamepad1.Value + 1
end

local function _reset(p1, p2, p3) --[[ _reset | Line: 37 ]]
	p1.resets[p3] = { p2, false }
end

local function read(p1, p2) --[[ read | Line: 51 ]]
	local v1 = if p1.vector then Vector3.new(0, 0, 0) else 0

	return p1.current[p2 or 1] or v1, p1.previous[p2 or 1] or v1
end

local function pressing(p1, p2) --[[ pressing | Line: 63 ]]
	local v1 = if p1.vector then Vector3.new(0, 0, 0) else 0
	local v2 = p1.current[p2 or 1] or v1
	local _ = p1.previous[p2 or 1] or v1

	return (if p1.vector then vector.magnitude(v2) else v2) ~= 0
end

local function changed(p1, p2) --[[ changed | Line: 76 ]]
	return p1.current[p2 or 1] ~= p1.previous[p2 or 1]
end

local function pressed(p1, p2) --[[ pressed | Line: 87 ]]
	local v1 = p1.current[p2 or 1] ~= p1.previous[p2 or 1]

	if v1 then
		local v2 = if p1.vector then Vector3.new(0, 0, 0) else 0
		local v3 = p1.current[p2 or 1] or v2
		local _ = p1.previous[p2 or 1] or v2

		v1 = (if p1.vector then vector.magnitude(v3) else v3) ~= 0
	end

	return v1
end

local function released(p1, p2) --[[ released | Line: 98 ]]
	local v1 = p1.current[p2 or 1] ~= p1.previous[p2 or 1]

	if v1 then
		local v2 = if p1.vector then Vector3.new(0, 0, 0) else 0
		local v3 = p1.current[p2 or 1] or v2
		local _ = p1.previous[p2 or 1] or v2

		v1 = not ((if p1.vector then vector.magnitude(v3) else v3) ~= 0)
	end

	return v1
end

local function hold(p1, p2, p3) --[[ hold | Line: 115 | Upvalues: v3 (ref) ]]
	local v1 = v3

	v3 = v3 + 1
	p1.active[p3 or 1][v1] = p2 or 1

	return function() --[[ Line: 120 | Upvalues: p1 (copy), p3 (copy), v1 (copy) ]]
		p1.active[p3 or 1][v1] = nil
	end
end

local function move(p1, p2, p3) --[[ move | Line: 132 | Upvalues: v3 (ref) ]]
	local v1 = v3

	v3 = v3 + 1
	p1.active[p3 or 1][v1] = p2 or 1
	p1.resets[v1] = { p3 or 1, false }
end

local function map(p1, p2) --[[ map | Line: 153 | Upvalues: v1 (copy), v2 (copy) ]]
	for v12, v22 in p1.connections do
		v22:Disconnect()
	end

	p1.vector = nil

	local v3 = nil

	local function setVector(p12, p2) --[[ setVector | Line: 162 | Upvalues: p1 (copy), v3 (ref) ]]
		if p1.vector ~= nil and p1.vector ~= p12 then
			error((("[Axis] Input axis cannot be both vector and scalar.\n\t(%* and %*)"):format(("%* was %*a vector input"):format(v3, if p1.vector then "" else "not "), (("%* is %*a vector input"):format(p2, if p12 then "" else "not ")))))
		end

		p1.vector = p12
		v3 = p2
	end

	if next(p2) == nil then
		return
	end

	local t = {}

	p1.keyMap = p2
	p1.inputMap = t

	local t2 = {}

	for v4, v5 in p2 do
		local v6 = if type(v4) == "number" then v5 else v4
		local v7 = if type(v4) == "number" then 1 else v5

		t[v6] = v7

		local v8 = if type(v7) == "number" then false else true

		if v6 == Enum.UserInputType.MouseMovement then
			if p1.vector ~= nil and p1.vector ~= true then
				error((("[Axis] Input axis cannot be both vector and scalar.\n\t(%* and %*)"):format(("%* was %*a vector input"):format(v3, if p1.vector then "" else "not "), (("%* is a vector input"):format(v6)))))
			end

			p1.vector = true
			v3 = v6
			table.insert(p1.connections, v1.InputChanged:Connect(function(p12) --[[ Line: 189 | Upvalues: p1 (copy), v7 (copy) ]]
				if p12.UserInputType == Enum.UserInputType.MouseMovement then
					p1.active[1][Enum.UserInputType.MouseMovement] = vector.create(p12.Delta.X, -p12.Delta.Y) * v7
					p1.resets[Enum.UserInputType.MouseMovement] = { 1, false }
				end
			end))

			continue
		end

		if v6 == Enum.UserInputType.MouseWheel then
			if p1.vector ~= nil and p1.vector ~= v8 then
				error((("[Axis] Input axis cannot be both vector and scalar.\n\t(%* and %*)"):format(("%* was %*a vector input"):format(v3, if p1.vector then "" else "not "), (("%* is %*a vector input"):format(v6, if v8 then "" else "not ")))))
			end

			p1.vector = v8
			v3 = v6
			table.insert(p1.connections, v1.InputChanged:Connect(function(p12, p2) --[[ Line: 198 | Upvalues: p1 (copy), v7 (copy) ]]
				if p2 then
					return
				end

				if p12.UserInputType == Enum.UserInputType.MouseWheel then
					p1.active[1][Enum.UserInputType.MouseWheel] = p12.Position.Z * v7
					p1.resets[Enum.UserInputType.MouseWheel] = { 1, false }
				end
			end))

			continue
		end

		if v6 == Enum.KeyCode.Thumbstick1 then
			if p1.vector ~= nil and p1.vector ~= true then
				error((("[Axis] Input axis cannot be both vector and scalar.\n\t(%* and %*)"):format(("%* was %*a vector input"):format(v3, if p1.vector then "" else "not "), (("%* is a vector input"):format(v6)))))
			end

			p1.vector = true
			v3 = v6
			table.insert(p1.connections, v1.InputChanged:Connect(function(p12) --[[ Line: 211 | Upvalues: p1 (copy), v7 (copy) ]]
				if p12.KeyCode ~= Enum.KeyCode.Thumbstick1 then
					return
				end

				local Position = p12.Position
				local UserInputType = p12.UserInputType
				local v2 = p1.active[if UserInputType.Value < Enum.UserInputType.Gamepad1.Value or UserInputType.Value > Enum.UserInputType.Gamepad8.Value then 1 else UserInputType.Value - Enum.UserInputType.Gamepad1.Value + 1]
				local Thumbstick1 = Enum.KeyCode.Thumbstick1
				local X = Position.X
				local v4 = if X < (p1.deadzone or 0.3) then 0 else X
				local Y = Position.Y

				v2[Thumbstick1] = vector.create(v4, if Y < (p1.deadzone or 0.3) then 0 else Y) * v7
			end))

			continue
		end

		if v6 == Enum.KeyCode.Thumbstick2 then
			if p1.vector ~= nil and p1.vector ~= true then
				error((("[Axis] Input axis cannot be both vector and scalar.\n\t(%* and %*)"):format(("%* was %*a vector input"):format(v3, if p1.vector then "" else "not "), (("%* is a vector input"):format(v6)))))
			end

			p1.vector = true
			v3 = v6
			table.insert(p1.connections, v1.InputChanged:Connect(function(p12) --[[ Line: 221 | Upvalues: p1 (copy), v7 (copy) ]]
				if p12.KeyCode ~= Enum.KeyCode.Thumbstick2 then
					return
				end

				local Position = p12.Position
				local UserInputType = p12.UserInputType
				local v2 = p1.active[if UserInputType.Value < Enum.UserInputType.Gamepad1.Value or UserInputType.Value > Enum.UserInputType.Gamepad8.Value then 1 else UserInputType.Value - Enum.UserInputType.Gamepad1.Value + 1]
				local Thumbstick2 = Enum.KeyCode.Thumbstick2
				local X = Position.X
				local v4 = if X < (p1.deadzone or 0.3) then 0 else X
				local Y = Position.Y

				v2[Thumbstick2] = vector.create(v4, if Y < (p1.deadzone or 0.3) then 0 else Y) * v7
			end))

			continue
		end

		if v6 == v1.TouchSwipe then
			if p1.vector ~= nil and p1.vector ~= true then
				error((("[Axis] Input axis cannot be both vector and scalar.\n\t(%* and %*)"):format(("%* was %*a vector input"):format(v3, if p1.vector then "" else "not "), (("%* is a vector input"):format(v6)))))
			end

			p1.vector = true
			v3 = v6

			local TouchSwipe = v1.TouchSwipe

			local function f36(p12) --[[ Line: 231 | Upvalues: p1 (copy), v1 (ref), v7 (copy), v2 (ref) ]]
				p1.active[1][v1.TouchSwipe] = v7 * v2(p12)({
					Enum.SwipeDirection.Left,
					Vector3.new(-1, 0, 0),
					Enum.SwipeDirection.Right,
					Vector3.new(1, 0, 0),
					Enum.SwipeDirection.Up,
					Vector3.new(0, 1, 0),
					Enum.SwipeDirection.Down,
					Vector3.new(0, -1, 0)
				})
			end

			table.insert(p1.connections, TouchSwipe:Connect(f36))

			continue
		end

		if v6 == v1.TouchPinch then
			if p1.vector ~= nil and p1.vector ~= v8 then
				error((("[Axis] Input axis cannot be both vector and scalar.\n\t(%* and %*)"):format(("%* was %*a vector input"):format(v3, if p1.vector then "" else "not "), (("%* is %*a vector input"):format(v6, if v8 then "" else "not ")))))
			end

			p1.vector = v8
			v3 = v6

			local TouchPinch = v1.TouchPinch

			local function f44(p12, p2, p3, p4, p5) --[[ Line: 241 | Upvalues: p1 (copy), v1 (ref) ]]
				if p4 == Enum.UserInputState.End then
					p1.active[1][v1.TouchPinch] = nil
				else
					p1.active[1][v1.TouchPinch] = p2
				end
			end

			table.insert(p1.connections, TouchPinch:Connect(f44))

			continue
		end

		if p1.vector ~= nil and p1.vector ~= v8 then
			error((("[Axis] Input axis cannot be both vector and scalar.\n\t(%* and %*)"):format(("%* was %*a vector input"):format(v3, if p1.vector then "" else "not "), (("%* is %*a vector input"):format(v6, if v8 then "" else "not ")))))
		end

		p1.vector = v8
		v3 = v6
		table.insert(t2, v6)
	end

	local function inputHappened(p12) --[[ inputHappened | Line: 254 | Upvalues: p1 (copy), t2 (copy) ]]
		local UserInputType = p12.UserInputType
		local v1 = if UserInputType.Value < Enum.UserInputType.Gamepad1.Value or UserInputType.Value > Enum.UserInputType.Gamepad8.Value then 1 else UserInputType.Value - Enum.UserInputType.Gamepad1.Value + 1

		p1.active[v1] = p1.active[v1] or {}

		local v3 = p1.active[v1]

		for v5, v6 in t2 do
			local v4

			if p12.KeyCode == v6 or p12.UserInputType == v6 then
				v4 = if p12.UserInputState == Enum.UserInputState.Begin or p12.UserInputState == Enum.UserInputState.Change then p1.inputMap[v6] else nil
				v3[v6] = v4
			end
		end
	end

	local InputBegan = v1.InputBegan

	table.insert(p1.connections, InputBegan:Connect(function(p1, p2) --[[ Line: 268 | Upvalues: inputHappened (copy) ]]
		if p2 then
			return
		end

		inputHappened(p1)
	end))

	local InputEnded = v1.InputEnded

	table.insert(p1.connections, InputEnded:Connect(inputHappened))
end

local function update(p1) --[[ update | Line: 282 ]]
	local v1 = if p1.vector then Vector3.new(0, 0, 0) else 0

	for v2, v3 in p1.resets do
		if v3[2] then
			p1.active[v3[1]][v2] = nil
			p1.resets[v2] = nil

			continue
		end

		v3[2] = true
	end

	for v4, v5 in p1.active do
		p1.previous[v4] = p1.current[v4] or v1

		local v6 = nil

		for v7, v8 in v5 do
			v6 = if v6 == nil then v8 else v6 + v8
		end

		p1.current[v4] = v6 or v1
	end
end

return function(p1) --[[ new | Line: 313 | Upvalues: read (copy), pressing (copy), pressed (copy), released (copy), changed (copy), hold (copy), map (copy), update (copy), move (copy) ]]
	local t = {
		vector = false,
		current = {},
		previous = {},
		active = {
			{}
		},
		resets = {},
		connections = {},
		inputMap = p1,
		deadzone = p1.deadzone,
		read = read,
		pressing = pressing,
		pressed = pressed,
		released = released,
		changed = changed,
		hold = hold,
		map = map,
		update = update,
		move = move,
		keyMap = p1
	}

	map(t, p1)

	return t
end