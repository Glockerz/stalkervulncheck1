-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SerdesLayer = require(script.Parent.SerdesLayer)
local v1 = nil
local v2 = nil
local v3 = nil
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}

t6.__index = t6
function t6._start() --[[ _start | Line: 34 | Upvalues: v1 (ref), ReplicatedStorage (copy), v2 (ref), SerdesLayer (copy), v3 (ref), RunService (copy), t (ref), t5 (copy), t3 (copy), t2 (ref), t4 (copy) ]]
	v1 = ReplicatedStorage:WaitForChild("RemoteEvent")
	v2 = SerdesLayer.FromIdentifier("Invoke")
	v3 = SerdesLayer.FromIdentifier("InvokeReply")

	local t6 = {}

	RunService.Heartbeat:Connect(function() --[[ Line: 42 | Upvalues: t (ref), t6 (copy), t5 (ref), SerdesLayer (ref), v2 (ref), t3 (ref), v1 (ref), t2 (ref), v3 (ref), t4 (ref) ]]
		debug.profilebegin("ClientBridge")

		local v12 = os.clock()
		local t7 = {}
		local t8 = {}
		local t9 = {}

		for v22, v32 in t7 do
			if v12 - t8[v32.replRate] <= 1 / v32.replRate - 0.003 then
				table.insert(t, v32)

				continue
			end

			table.remove(t7, v22)
		end

		for v5, v6 in t do
			if t8[v6.replRate] and v12 - t8[v6.replRate] <= 1 / v6.replRate - 0.003 then
				t6[v6.replRate] = true

				if not t6[v6.replRate] then
					table.insert(t7, v6)

					continue
				end
			end

			if t5[v6.replRate] == nil then
				t5[v6.replRate] = {}
			else
				for v7, v8 in t5[v6.replRate] do
					task.spawn(v8)
				end
			end

			t8[v6.replRate] = v12

			for i = 1, #v6.args do
				if v6.args[i] == nil then
					v6.args[i] = SerdesLayer.NilIdentifier
				end
			end

			if v6.requestType == "invoke" then
				local t10 = { v6.remote, v2, v6.uuid }

				for v9, v10 in v6.args do
					table.insert(t10, v10)
				end

				table.insert(t9, t10)

				continue
			end

			if v6.requestType == "send" then
				local t10 = { v6.remote }
				local v11 = t3[SerdesLayer.FromCompressed(v6.remote)]

				if not v11 then
					return
				end

				if #v11._outboundMiddleware == 0 then
					for v122, v13 in v6.args do
						table.insert(t10, v13)
					end
				else
					local v14 = nil

					for v15, v16 in v11._outboundMiddleware do
						if v14 then
							local t11 = { v16(table.unpack(v14)) }

							if #t11 ~= 0 then
								v14 = t11
							end

							continue
						end

						local t11 = {}

						t11[1] = v16(table.unpack(v6.args))
						v14 = t11
					end

					if v14 == nil then
						v14 = v6.args
					end

					for v17, v18 in v14 do
						table.insert(t10, v18)
					end
				end

				table.insert(t9, t10)
			end
		end

		if #t9 ~= 0 then
			v1:FireServer(t9)
		end

		t = t7

		for v19, v20 in t2 do
			local args = v20.args
			local v21 = #args
			local v22 = t3[SerdesLayer.FromCompressed(v20.remote)]

			if v22 ~= nil then
				for j = 1, #args do
					if args[j] == SerdesLayer.NilIdentifier then
						args[j] = nil
					end
				end

				if args[1] == v3 then
					if args[1] == v3 then
						local v23 = SerdesLayer.UnpackUUID(args[2])

						table.remove(args, 1)
						table.remove(args, 1)
						task.spawn(t4[v23], unpack(args, 1, v21 - 2))
						t4[v23] = nil
					end

					continue
				end

				for v24, v25 in v22._connections do
					task.spawn(function() --[[ Line: 153 | Upvalues: v22 (copy), v20 (copy), v25 (copy) ]]
						if #v22._inboundMiddleware == 0 then
							v25(table.unpack(v20.args))

							return
						end

						local v2 = nil

						for v3, v4 in v22._inboundMiddleware do
							if v2 then
								local t = { v4(table.unpack(v2)) }

								if #t ~= 0 then
									v2 = t
								end

								continue
							end

							local t = {}

							t[1] = v4(table.unpack(v20.args))
							v2 = t
						end

						if v2 == nil then
							v2 = v20.args
						end

						v25(table.unpack(v2))
					end)
				end
			end
		end

		t2 = {}
		debug.profileend()
	end)
	v1.OnClientEvent:Connect(function(p1) --[[ Line: 193 | Upvalues: t2 (ref) ]]
		for v1, v2 in p1 do
			table.remove(v2, 1)
			table.insert(t2, {
				remote = v2[1],
				args = v2
			})
		end
	end)
end
function t6.new(p1) --[[ new | Line: 206 | Upvalues: t6 (copy), SerdesLayer (copy), t3 (copy) ]]
	assert(type(p1) == "string", "[BridgeNet] remote name must be a string")

	local v2 = t6.from(p1)

	if v2 ~= nil then
		return v2
	end

	local v4 = setmetatable({}, t6)

	v4._name = p1
	v4._connections = {}
	v4._replRate = 60
	v4._inboundMiddleware = {}
	v4._outboundMiddleware = {}
	v4._id = SerdesLayer.FromIdentifier(v4._name)

	if v4._id == nil then
		task.spawn(function() --[[ Line: 226 | Upvalues: v4 (copy), SerdesLayer (ref) ]]
			local sum = 0
			local sum2 = sum + 0.1

			repeat
				sum = sum + task.wait()
				v4._id = SerdesLayer.FromIdentifier(v4._name)

				if sum2 < sum then
					print("[BridgeNet] waiting for (" .. v4._name .. ") to be replicated to the client")
					sum2 = sum2 + 0.1
				end
			until v4._id ~= nil or sum >= 10
		end)
	end

	t3[v4._name] = v4

	return v4
end
function t6._getReplicationStepSignal(p1, p2) --[[ _getReplicationStepSignal | Line: 244 | Upvalues: t5 (copy) ]]
	if t5[p1] == nil then
		t5[p1] = { p2 }
	else
		table.insert(t5[p1], p2)
	end
end
function t6.from(p1) --[[ from | Line: 254 | Upvalues: t3 (copy) ]]
	assert(type(p1) == "string", "[BridgeNet] Remote name must be a string")

	return t3[p1]
end
function t6.waitForBridge(p1) --[[ waitForBridge | Line: 259 | Upvalues: t3 (copy) ]]
	while not t3[p1] do
		task.wait()
	end

	return t3[p1]
end
function t6._returnQueue() --[[ _returnQueue | Line: 266 | Upvalues: t (ref), t2 (ref) ]]
	return t, t2
end
function t6.Fire(p1, ...) --[[ Fire | Line: 281 | Upvalues: SerdesLayer (copy), t (ref) ]]
	if p1._id == nil then
		p1._id = SerdesLayer.FromIdentifier(p1._name)
	end

	table.insert(t, {
		requestType = "send",
		remote = p1._id,
		args = { ... },
		replRate = p1._replRate
	})
end
function t6.InvokeServerAsync(p1, ...) --[[ InvokeServerAsync | Line: 306 | Upvalues: SerdesLayer (copy), t4 (copy), t (ref) ]]
	if p1._id == nil then
		p1._id = SerdesLayer.FromIdentifier(p1._name)
	end

	local v1 = coroutine.running()
	local v2 = SerdesLayer.CreateUUID()

	t4[v2] = v1
	table.insert(t, {
		requestType = "invoke",
		remote = p1._id,
		uuid = SerdesLayer.PackUUID(v2),
		args = { ... },
		replRate = p1._replRate
	})

	local t3 = { coroutine.yield() }

	if t3[1] == "err" then
		error(t3[2], 2)
	end

	return table.unpack(t3)
end
function t6.Connect(p1, p2) --[[ Connect | Line: 346 | Upvalues: SerdesLayer (copy) ]]
	assert(if type(p2) == "function" then true else false, "[BridgeNet] Attempt to connect non-function to a Bridge")

	local v2 = SerdesLayer.CreateUUID()

	p1._connections[v2] = p2

	return {
		Disconnect = function() --[[ Disconnect | Line: 353 | Upvalues: p1 (copy), v2 (ref) ]]
			p1._connections[v2] = nil
			v2 = nil
		end
	}
end
function t6.GetName(p1) --[[ GetName | Line: 372 ]]
	return p1._name
end
function t6.Once(p1, p2) --[[ Once | Line: 394 ]]
	local v1 = nil

	v1 = p1:Connect(function(...) --[[ Line: 396 | Upvalues: v1 (ref), p2 (copy) ]]
		v1:Disconnect()
		p2(...)
	end)
end
function t6.SetReplicationRate(p1, p2) --[[ SetReplicationRate | Line: 408 ]]
	assert(if typeof(p2) == "number" then true else false, "[BridgeNet] replication rate must be a number")
	p1._replRate = p2
end
function t6.SetOutboundMiddleware(p1, p2) --[[ SetOutboundMiddleware | Line: 413 ]]
	assert(if typeof(p2) == "table" then true else false, "[BridgeNet] outbound middleware must be a table")
	p1._outboundMiddleware = p2
end
function t6.SetInboundMiddleware(p1, p2) --[[ SetInboundMiddleware | Line: 418 ]]
	assert(if typeof(p2) == "table" then true else false, "[BridgeNet] inbound middleware must be a table")
	p1._inboundMiddleware = p2
end
function t6.Destroy(p1) --[[ Destroy | Line: 436 | Upvalues: t3 (copy) ]]
	t3[p1._name] = nil

	for v1, v2 in p1 do
		if type(v2) == "number" or type(v2) == "string" then
			p1[v1] = nil

			continue
		end

		if v2.Destroy == nil then
			p1[v1] = nil

			continue
		end

		v2:Destroy()
	end

	setmetatable(p1, nil)
end

return t6