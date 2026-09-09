-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function AwaitCondition(p1, p2) --[[ AwaitCondition | Line: 1 ]]
	local v1 = os.clock()
	local v2 = p2 or 10

	while not p1() do
		if v2 < os.clock() - v1 then
			return false
		end

		task.wait()
	end

	return true
end

return function() --[[ Line: 15 | Upvalues: AwaitCondition (copy) ]]
	local v1 = require(script.Parent)
	local v2 = nil

	local function NumConns(p1) --[[ NumConns | Line: 20 | Upvalues: v2 (ref) ]]
		return #(if p1 then p1 else v2):GetConnections()
	end

	beforeEach(function() --[[ Line: 25 | Upvalues: v2 (ref), v1 (copy) ]]
		v2 = v1.new()
	end)
	afterEach(function() --[[ Line: 29 | Upvalues: v2 (ref) ]]
		v2:Destroy()
	end)
	describe("Constructor", function() --[[ Line: 33 | Upvalues: v1 (copy), v2 (ref), AwaitCondition (ref) ]]
		it("should create a new signal and fire it", function() --[[ Line: 34 | Upvalues: v1 (ref), v2 (ref) ]]
			expect(v1.Is(v2)).to.equal(true)
			task.defer(function() --[[ Line: 36 | Upvalues: v2 (ref) ]]
				v2:Fire(10, 20)
			end)

			local v12, v22 = v2:Wait()

			expect(v12).to.equal(10)
			expect(v22).to.equal(20)
		end)
		it("should create a proxy signal and connect to it", function() --[[ Line: 44 | Upvalues: v1 (ref), AwaitCondition (ref) ]]
			local v12 = v1.Wrap(game:GetService("RunService").Heartbeat)

			expect(v1.Is(v12)).to.equal(true)

			local v2 = false

			v12:Connect(function() --[[ Line: 48 | Upvalues: v2 (ref) ]]
				v2 = true
			end)
			expect(AwaitCondition(function() --[[ Line: 51 | Upvalues: v2 (ref) ]]
				return v2
			end, 2)).to.equal(true)
			v12:Destroy()
		end)
	end)
	describe("FireDeferred", function() --[[ Line: 58 | Upvalues: v2 (ref), AwaitCondition (ref) ]]
		it("should be able to fire primitive argument", function() --[[ Line: 59 | Upvalues: v2 (ref), AwaitCondition (ref) ]]
			local v1 = nil

			v2:Connect(function(p1) --[[ Line: 62 | Upvalues: v1 (ref) ]]
				v1 = p1
			end)
			v2:FireDeferred(10)
			expect(AwaitCondition(function() --[[ Line: 66 | Upvalues: v1 (ref) ]]
				return v1 == 10
			end, 1)).to.equal(true)
		end)
		it("should be able to fire a reference based argument", function() --[[ Line: 71 | Upvalues: v2 (ref), AwaitCondition (ref) ]]
			local t = { 10, 20 }
			local v1 = nil

			v2:Connect(function(p1) --[[ Line: 74 | Upvalues: v1 (ref) ]]
				v1 = p1
			end)
			v2:FireDeferred(t)
			expect(AwaitCondition(function() --[[ Line: 78 | Upvalues: t (copy), v1 (ref) ]]
				return t == v1
			end, 1)).to.equal(true)
		end)
	end)
	describe("Fire", function() --[[ Line: 84 | Upvalues: v2 (ref) ]]
		it("should be able to fire primitive argument", function() --[[ Line: 85 | Upvalues: v2 (ref) ]]
			local v1 = nil

			v2:Connect(function(p1) --[[ Line: 88 | Upvalues: v1 (ref) ]]
				v1 = p1
			end)
			v2:Fire(10)
			expect(v1).to.equal(10)
		end)
		it("should be able to fire a reference based argument", function() --[[ Line: 95 | Upvalues: v2 (ref) ]]
			local t = { 10, 20 }
			local v1 = nil

			v2:Connect(function(p1) --[[ Line: 98 | Upvalues: v1 (ref) ]]
				v1 = p1
			end)
			v2:Fire(t)
			expect(v1).to.equal(t)
		end)
	end)
	describe("ConnectOnce", function() --[[ Line: 106 | Upvalues: v2 (ref) ]]
		it("should only capture first fire", function() --[[ Line: 107 | Upvalues: v2 (ref) ]]
			local v1 = nil
			local v22 = v2:ConnectOnce(function(p1) --[[ Line: 109 | Upvalues: v1 (ref) ]]
				v1 = p1
			end)

			expect(v22.Connected).to.equal(true)
			v2:Fire(10)
			expect(v22.Connected).to.equal(false)
			v2:Fire(20)
			expect(v1).to.equal(10)
		end)
	end)
	describe("Wait", function() --[[ Line: 120 | Upvalues: v2 (ref) ]]
		it("should be able to wait for a signal to fire", function() --[[ Line: 121 | Upvalues: v2 (ref) ]]
			task.defer(function() --[[ Line: 122 | Upvalues: v2 (ref) ]]
				v2:Fire(10, 20, 30)
			end)

			local v1, v22, v3 = v2:Wait()

			expect(v1).to.equal(10)
			expect(v22).to.equal(20)
			expect(v3).to.equal(30)
		end)
	end)
	describe("DisconnectAll", function() --[[ Line: 132 | Upvalues: v2 (ref) ]]
		it("should disconnect all connections", function() --[[ Line: 133 | Upvalues: v2 (ref) ]]
			v2:Connect(function() --[[ Line: 134 ]] end)
			v2:Connect(function() --[[ Line: 135 ]] end)

			local v22 = nil

			expect(#(if v22 then v22 else v2):GetConnections()).to.equal(2)
			v2:DisconnectAll()

			local v5 = nil

			expect(#(if v5 then v5 else v2):GetConnections()).to.equal(0)
		end)
	end)
	describe("Disconnect", function() --[[ Line: 142 | Upvalues: v2 (ref), AwaitCondition (ref) ]]
		it("should disconnect connection", function() --[[ Line: 143 | Upvalues: v2 (ref) ]]
			local v1 = v2:Connect(function() --[[ Line: 144 ]] end)
			local v3 = nil

			expect(#(if v3 then v3 else v2):GetConnections()).to.equal(1)
			v1:Disconnect()

			local v6 = nil

			expect(#(if v6 then v6 else v2):GetConnections()).to.equal(0)
		end)
		it("should still work if connections disconnected while firing", function() --[[ Line: 150 | Upvalues: v2 (ref) ]]
			local v1 = 0
			local v22 = nil

			v2:Connect(function() --[[ Line: 153 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end)
			v22 = v2:Connect(function() --[[ Line: 156 | Upvalues: v22 (ref), v1 (ref) ]]
				v22:Disconnect()
				v1 = v1 + 1
			end)
			v2:Connect(function() --[[ Line: 160 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end)
			v2:Fire()
			expect(v1).to.equal(3)
		end)
		it("should still work if connections disconnected while firing deferred", function() --[[ Line: 167 | Upvalues: v2 (ref), AwaitCondition (ref) ]]
			local v1 = 0
			local v22 = nil

			v2:Connect(function() --[[ Line: 170 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end)
			v22 = v2:Connect(function() --[[ Line: 173 | Upvalues: v22 (ref), v1 (ref) ]]
				v22:Disconnect()
				v1 = v1 + 1
			end)
			v2:Connect(function() --[[ Line: 177 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end)
			v2:FireDeferred()
			expect(AwaitCondition(function() --[[ Line: 181 | Upvalues: v1 (ref) ]]
				return v1 == 3
			end)).to.equal(true)
		end)
	end)
end