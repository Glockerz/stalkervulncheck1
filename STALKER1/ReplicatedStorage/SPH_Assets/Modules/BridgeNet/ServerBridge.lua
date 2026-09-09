-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local SerdesLayer = require(script.Parent.SerdesLayer)
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = nil
local v2 = nil
local v3 = nil

local function v4(p1) --[[ deepCopy | Line: 27 | Upvalues: v4 (copy) ]]
	local t = {}

	for v1, v2 in p1 do
		if typeof(v2) == "table" then
			t[v1] = v4(v2)

			continue
		end

		if typeof(v2) == "userdata" then
			warn("warning: copying userdata? you should never see this.")
			t[v1] = v2

			continue
		end

		t[v1] = v2
	end

	return t
end

local t5 = {}

t5.__index = t5
function t5._start() --[[ _start | Line: 55 | Upvalues: v1 (ref), ReplicatedStorage (copy), v2 (ref), SerdesLayer (copy), v3 (ref), RunService (copy), t2 (copy), t4 (copy), t (copy), t3 (copy) ]]
	v1 = Instance.new("RemoteEvent")
	v1.Name = "RemoteEvent"
	v1.Parent = ReplicatedStorage
	v2 = SerdesLayer.CreateIdentifier("Invoke")
	v3 = SerdesLayer.CreateIdentifier("InvokeReply")

	local t5 = {}

	RunService.Heartbeat:Connect(function() --[[ Line: 65 | Upvalues: t2 (ref), SerdesLayer (ref), t4 (ref), v2 (ref), t (ref), t5 (copy), t3 (ref), v3 (ref), v1 (ref) ]]
		debug.profilebegin("ServerBridge")

		local v12 = os.clock()

		for v22, v32 in t2 do
			for i = 1, #v32.args do
				if v32.args[i] == SerdesLayer.NilIdentifier then
					v32.args[i] = nil
				end
			end

			local v4 = t4[SerdesLayer.FromCompressed(v32.remote)]

			if v4 ~= nil then
				if v32.args[1] == v2 then
					if v4._onInvoke == nil then
						local args = v32.args

						table.remove(args, 1)
						table.remove(args, 1)
						table.insert(t, {
							invokeReply = true,
							replRate = 60,
							plrs = v32.plr,
							remote = v4._id,
							uuid = args[2],
							args = { "err", "onInvoke has not yet been registered on the server for " .. v4._name }
						})

						continue
					end

					task.spawn(function() --[[ Line: 92 | Upvalues: v32 (copy), t (ref), v4 (copy) ]]
						local args = v32.args

						table.remove(args, 1)
						table.remove(args, 1)

						local t2 = {
							invokeReply = true,
							replRate = 60,
							plrs = v32.plr,
							remote = v4._id,
							uuid = args[2]
						}
						local t3 = {}

						t3[1] = v4._onInvoke(v32.plr, unpack(v32.args))
						t2.args = t3
						table.insert(t, t2)
					end)

					continue
				end

				debug.profilebegin(string.format("connections_%s", v4._name))

				for v7, v8 in v4._connections do
					task.spawn(function() --[[ Line: 129 | Upvalues: v4 (copy), v32 (copy), v8 (copy) ]]
						if #v4._inboundMiddleware == 0 then
							v8(v32.plr, table.unpack(v32.args))

							return
						end

						local v2 = nil

						for v3, v42 in v4._inboundMiddleware do
							if v2 then
								local t = { v42(table.unpack(v2)) }

								if #t ~= 0 then
									v2 = t
								end

								continue
							end

							local t = {}

							t[1] = v42(table.unpack(v32.args))
							v2 = t
						end

						if v2 == nil then
							v2 = v32.args
						end

						v8(v32.plr, table.unpack(v2))
					end)
				end

				debug.profileend()
			end
		end

		table.clear(t2)

		local t6 = {}
		local t7 = {}
		local t8 = {}
		local t9 = {}

		for v9, v10 in t6 do
			if v12 - t5[v10.replRate] <= 1 / v10.replRate - 0.003 then
				table.insert(t, v10)

				continue
			end

			table.remove(t6, v9)
		end

		for v122, v13 in t do
			local v14, v15, v16, v17, v18, v19, v20, v21, v22, v23

			if t5[v13.replRate] and v12 - t5[v13.replRate] <= 1 / v13.replRate - 0.003 then
				t7[v13.replRate] = true

				if t7[v13.replRate] then
					if t3[v13.replRate] == nil then
						t3[v13.replRate] = {}
					else
						for v24, v25 in t3[v13.replRate] do
							task.spawn(v25)
						end
					end

					for j = 1, #v13.args do
						if v13.args[j] == nil then
							v13.args[j] = SerdesLayer.NilIdentifier
						end
					end

					if v13.invokeReply then
						if v13.invokeReply then
							if t8[v13.plrs] == nil then
								t8[v13.plrs] = {}
							end

							v14 = { v13.remote, v3, v13.uuid }

							for v26, v27 in v13.args do
								table.insert(v14, v27)
							end

							table.insert(t9, v14)
						end

						continue
					end

					v15 = { v13.remote }
					v16 = t4[SerdesLayer.FromCompressed(v13.remote)]

					if #v16._outboundMiddleware == 0 then
						for v28, v29 in v13.args do
							table.insert(v15, v29)
						end
					else
						v17 = nil

						for v30, v31 in v16._outboundMiddleware do
							if v17 then
								v18 = { v31(table.unpack(v17)) }

								if #v18 ~= 0 then
									v17 = v18
								end

								continue
							end

							v19 = {}
							v20 = v13.args
							v19[1] = v31(table.unpack(v20))
							v17 = v19
						end

						if v17 == nil then
							v17 = v13.args
						end

						for v32, v33 in v17 do
							table.insert(v15, v33)
						end
					end

					if v13.plrs == "all" then
						table.insert(t9, v15)

						continue
					end

					v21 = v13.plrs

					if typeof(v21) == "table" then
						for v34, v35 in v13.plrs do
							if t8[v35] == nil then
								t8[v35] = {}
							end

							v22 = t8[v35]
							table.insert(v22, v15)
						end

						continue
					end

					if t8[v13.plrs] == nil then
						t8[v13.plrs] = { v15 }

						continue
					end

					v23 = t8[v13.plrs]
					table.insert(v23, v15)

					continue
				end

				table.insert(t6, v13)
			else
				if t3[v13.replRate] == nil then
					t3[v13.replRate] = {}
				else
					for v24, v25 in t3[v13.replRate] do
						task.spawn(v25)
					end
				end

				for j = 1, #v13.args do
					if v13.args[j] == nil then
						v13.args[j] = SerdesLayer.NilIdentifier
					end
				end

				if v13.invokeReply then
					if v13.invokeReply then
						if t8[v13.plrs] == nil then
							t8[v13.plrs] = {}
						end

						v14 = { v13.remote, v3, v13.uuid }

						for v26, v27 in v13.args do
							table.insert(v14, v27)
						end

						table.insert(t9, v14)
					end

					continue
				end

				v15 = { v13.remote }
				v16 = t4[SerdesLayer.FromCompressed(v13.remote)]

				if #v16._outboundMiddleware == 0 then
					for v28, v29 in v13.args do
						table.insert(v15, v29)
					end
				else
					v17 = nil

					for v30, v31 in v16._outboundMiddleware do
						if v17 then
							v18 = { v31(table.unpack(v17)) }

							if #v18 ~= 0 then
								v17 = v18
							end

							continue
						end

						v19 = {}
						v20 = v13.args
						v19[1] = v31(table.unpack(v20))
						v17 = v19
					end

					if v17 == nil then
						v17 = v13.args
					end

					for v32, v33 in v17 do
						table.insert(v15, v33)
					end
				end

				if v13.plrs == "all" then
					table.insert(t9, v15)

					continue
				end

				v21 = v13.plrs

				if typeof(v21) == "table" then
					for v34, v35 in v13.plrs do
						if t8[v35] == nil then
							t8[v35] = {}
						end

						v22 = t8[v35]
						table.insert(v22, v15)
					end

					continue
				end

				if t8[v13.plrs] == nil then
					t8[v13.plrs] = { v15 }

					continue
				end

				v23 = t8[v13.plrs]
				table.insert(v23, v15)
			end
		end

		if #t9 ~= 0 then
			v1:FireAllClients(t9)
		end

		for v36, v37 in t8 do
			v1:FireClient(v36, v37)
		end

		table.clear(t)

		for v38, v39 in t7 do
			t7[v38] = false
		end

		debug.profileend()
	end)
	v1.OnServerEvent:Connect(function(p1, p2) --[[ Line: 279 | Upvalues: t2 (ref) ]]
		for v1, v2 in p2 do
			table.remove(v2, 1)
			table.insert(t2, {
				remote = v2[1],
				plr = p1,
				args = v2
			})
		end
	end)

	return nil
end
function t5._getReplicationStepSignal(p1, p2) --[[ _getReplicationStepSignal | Line: 296 | Upvalues: t3 (copy) ]]
	if t3[p1] == nil then
		t3[p1] = { p2 }
	else
		table.insert(t3[p1], p2)
	end
end
function t5._returnQueue() --[[ _returnQueue | Line: 306 | Upvalues: t (copy), t2 (copy) ]]
	return t, t2
end
function t5._destroy() --[[ _destroy | Line: 327 | Upvalues: v1 (ref) ]]
	v1:Destroy()
end
function t5.new(p1) --[[ new | Line: 331 | Upvalues: t5 (copy), SerdesLayer (copy), t4 (copy) ]]
	assert(type(p1) == "string", "[BridgeNet] Remote name must be a string")

	local v2 = t5.from(p1)

	if v2 == nil then
		local v4 = setmetatable({}, t5)

		v4._name = p1
		v4._onInvoke = nil
		v4._connections = {}
		v4._replRate = 60
		v4._rateLimit = nil
		v4._rateHandler = nil
		v4._rateInThisMinute = {
			num = 0,
			min = 0
		}
		v4._id = SerdesLayer.CreateIdentifier(p1)
		v4._outboundMiddleware = {}
		v4._inboundMiddleware = {}
		t4[v4._name] = v4

		return v4
	end

	return v2
end
function t5.from(p1) --[[ from | Line: 364 | Upvalues: t4 (copy) ]]
	return t4[p1]
end
function t5.waitForBridge(p1) --[[ waitForBridge | Line: 368 | Upvalues: t4 (copy) ]]
	local v1

	while true do
		v1 = t4[p1]

		if v1 then
			break
		end

		task.wait()
	end

	return v1
end
function t5.FireTo(p1, p2, ...) --[[ FireTo | Line: 390 | Upvalues: t (copy) ]]
	table.insert(t, {
		plrs = p2,
		remote = p1._id,
		args = { ... },
		replRate = p1._replRate
	})
end
function t5.OnInvoke(p1, p2) --[[ OnInvoke | Line: 417 ]]
	function p1._onInvoke(...) --[[ wrappedCallback | Line: 418 | Upvalues: p2 (copy) ]]
		local ok, result = pcall(function(...) --[[ Line: 419 | Upvalues: p2 (ref) ]]
			return table.pack(p2(...))
		end, ...)

		if ok == true then
			return table.unpack(result)
		end

		return "err", result
	end
end
function t5.FireToAllExcept(p1, p2, ...) --[[ FireToAllExcept | Line: 446 | Upvalues: Players (copy), t (copy) ]]
	local t2 = {}

	for v1, v2 in Players:GetPlayers() do
		if typeof(p2) == "table" then
			if not table.find(p2, v2) then
				table.insert(t2, v2)
			end
		elseif p2 ~= v2 then
			table.insert(t2, v2)
		end
	end

	table.insert(t, {
		plrs = t2,
		remote = p1._id,
		args = { ... },
		replRate = p1._replRate
	})

	return t2
end
function t5.FireAllInRangeExcept(p1, p2, p3, p4, ...) --[[ FireAllInRangeExcept | Line: 496 | Upvalues: Players (copy), t (copy) ]]
	local t2 = {}

	for v1, v2 in Players:GetPlayers() do
		if v2:DistanceFromCharacter(p3) <= p4 then
			if typeof(p2) == "table" then
				if not table.find(p2, v2) then
					table.insert(t2, v2)
				end
			elseif p2 ~= v2 then
				table.insert(t2, v2)
			end
		end
	end

	table.insert(t, {
		plrs = t2,
		remote = p1._id,
		args = { ... },
		replRate = p1._replRate
	})

	return t2
end
function t5.FireAllInRange(p1, p2, p3, ...) --[[ FireAllInRange | Line: 551 | Upvalues: Players (copy), t (copy) ]]
	assert(if typeof(p2) == "Vector3" then true else false, "[BridgeNet] point must be a Vector3")
	assert(if typeof(p3) == "number" then true else false, "[BridgeNet] range must be a number")

	local t2 = {}

	for v3, v4 in Players:GetPlayers() do
		if v4:DistanceFromCharacter(p2) <= p3 then
			table.insert(t2, v4)
		end
	end

	table.insert(t, {
		plrs = t2,
		remote = p1._id,
		args = { ... },
		replRate = p1._replRate
	})

	return t2
end
function t5.FireAll(p1, ...) --[[ FireAll | Line: 584 | Upvalues: t (copy) ]]
	table.insert(t, {
		plrs = "all",
		remote = p1._id,
		args = { ... },
		replRate = p1._replRate
	})

	return nil
end
function t5.FireToMultiple(p1, p2, ...) --[[ FireToMultiple | Line: 608 | Upvalues: t (copy) ]]
	assert(if type(p2) == "table" then true else false, "[BridgeNet] First argument must be a table!")
	table.insert(t, {
		plrs = p2,
		remote = p1._id,
		args = { ... },
		replRate = p1._replRate
	})

	return nil
end
function t5.SetInboundMiddleware(p1, p2) --[[ SetInboundMiddleware | Line: 647 ]]
	assert(if typeof(p2) == "table" then true else false, "[BridgeNet] middlewareTable must be a table")
	p1._inboundMiddleware = if p2 then p2 else {}
end
function t5.SetOutboundMiddleware(p1, p2) --[[ SetOutboundMiddleware | Line: 675 ]]
	assert(if typeof(p2) == "table" then true else false, "[BridgeNet] middlewareTable must be a table")
	p1._outboundMiddleware = if p2 then p2 else {}
end
function t5.Once(p1, p2) --[[ Once | Line: 698 ]]
	local v1 = nil

	v1 = p1:Connect(function(...) --[[ Line: 700 | Upvalues: v1 (ref), p2 (copy) ]]
		v1:Disconnect()
		p2(...)
	end)
end
function t5.Connect(p1, p2) --[[ Connect | Line: 719 | Upvalues: SerdesLayer (copy) ]]
	assert(if type(p2) == "function" then true else false, "[BridgeNet] attempt to connect non-function to a Bridge")

	local v2 = SerdesLayer.CreateUUID()

	p1._connections[v2] = p2

	return {
		Disconnect = function() --[[ Disconnect | Line: 726 | Upvalues: p1 (copy), v2 (ref) ]]
			p1._connections[v2] = nil
			v2 = nil
		end
	}
end
function t5.GetName(p1) --[[ GetName | Line: 745 ]]
	return p1._name
end
function t5.SetReplicationRate(p1, p2) --[[ SetReplicationRate | Line: 754 ]]
	p1._replRate = p2
end
function t5.Destroy(p1) --[[ Destroy | Line: 770 | Upvalues: t4 (copy), SerdesLayer (copy) ]]
	t4[p1._name] = nil
	SerdesLayer.DestroyIdentifier(p1.Name)

	for v1, v2 in p1 do
		if v2.Destroy == nil then
			p1[v1] = nil

			continue
		end

		v2:Destroy()
	end

	setmetatable(p1, nil)
end

return t5