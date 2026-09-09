-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)

	describe("Trove", function() --[[ Line: 4 | Upvalues: v1 (copy) ]]
		local v12 = nil

		beforeEach(function() --[[ Line: 7 | Upvalues: v12 (ref), v1 (ref) ]]
			v12 = v1.new()
		end)
		afterEach(function() --[[ Line: 11 | Upvalues: v12 (ref) ]]
			if not v12 then
				return
			end

			v12:Destroy()
			v12 = nil
		end)
		it("should add and clean up roblox instance", function() --[[ Line: 18 | Upvalues: v12 (ref) ]]
			local Part = Instance.new("Part")

			Part.Parent = workspace
			v12:Add(Part)
			v12:Destroy()
			expect(Part.Parent).to.equal(nil)
		end)
		it("should add and clean up roblox connection", function() --[[ Line: 26 | Upvalues: v12 (ref) ]]
			local v1 = workspace.Changed:Connect(function() --[[ Line: 27 ]] end)

			v12:Add(v1)
			v12:Destroy()
			expect(v1.Connected).to.equal(false)
		end)
		it("should add and clean up a table with a destroy method", function() --[[ Line: 33 | Upvalues: v12 (ref) ]]
			local t = {
				Destroyed = false,
				Destroy = function(p1) --[[ Destroy | Line: 35 ]]
					p1.Destroyed = true
				end
			}

			v12:Add(t)
			v12:Destroy()
			expect(t.Destroyed).to.equal(true)
		end)
		it("should add and clean up a table with a disconnect method", function() --[[ Line: 43 | Upvalues: v12 (ref) ]]
			local t = {
				Connected = true,
				Disconnect = function(p1) --[[ Disconnect | Line: 45 ]]
					p1.Connected = false
				end
			}

			v12:Add(t)
			v12:Destroy()
			expect(t.Connected).to.equal(false)
		end)
		it("should add and clean up a function", function() --[[ Line: 53 | Upvalues: v12 (ref) ]]
			local v1 = false

			v12:Add(function() --[[ Line: 55 | Upvalues: v1 (ref) ]]
				v1 = true
			end)
			v12:Destroy()
			expect(v1).to.equal(true)
		end)
		it("should allow a custom cleanup method", function() --[[ Line: 62 | Upvalues: v12 (ref) ]]
			local t = {
				Cleaned = false,
				Cleanup = function(p1) --[[ Cleanup | Line: 64 ]]
					p1.Cleaned = true
				end
			}

			v12:Add(t, "Cleanup")
			v12:Destroy()
			expect(t.Cleaned).to.equal(true)
		end)
		it("should return the object passed to add", function() --[[ Line: 72 | Upvalues: v12 (ref) ]]
			local Part = Instance.new("Part")
			local v1 = v12:Add(Part)

			expect(Part).to.equal(v1)
			v12:Destroy()
		end)
		it("should fail to add object without proper cleanup method", function() --[[ Line: 79 | Upvalues: v12 (ref) ]]
			local t = {}

			expect(function() --[[ Line: 81 | Upvalues: v12 (ref), t (copy) ]]
				v12:Add(t)
			end).to.throw()
		end)
		it("should construct an object and add it", function() --[[ Line: 86 | Upvalues: v12 (ref) ]]
			local t = {}

			t.__index = t
			function t.new(p1) --[[ new | Line: 89 | Upvalues: t (copy) ]]
				local v2 = setmetatable({}, t)

				v2._msg = p1
				v2._destroyed = false

				return v2
			end
			function t.Destroy(p1) --[[ Destroy | Line: 95 ]]
				p1._destroyed = true
			end

			local v1 = v12:Construct(t, "abc")

			expect((typeof(v1))).to.equal("table")
			expect((getmetatable(v1))).to.equal(t)
			expect(v1._msg).to.equal("abc")
			expect(v1._destroyed).to.equal(false)
			v12:Destroy()
			expect(v1._destroyed).to.equal(true)
		end)
		it("should connect to a signal", function() --[[ Line: 108 | Upvalues: v12 (ref) ]]
			local v1 = v12:Connect(workspace.Changed, function() --[[ Line: 109 ]] end)

			expect((typeof(v1))).to.equal("RBXScriptConnection")
			expect(v1.Connected).to.equal(true)
			v12:Destroy()
			expect(v1.Connected).to.equal(false)
		end)
		it("should remove an object", function() --[[ Line: 116 | Upvalues: v12 (ref) ]]
			local v1 = v12:Connect(workspace.Changed, function() --[[ Line: 117 ]] end)

			expect(v12:Remove(v1)).to.equal(true)
			expect(v1.Connected).to.equal(false)
		end)
		it("should not remove an object not in the trove", function() --[[ Line: 122 | Upvalues: v12 (ref) ]]
			local v1 = workspace.Changed:Connect(function() --[[ Line: 123 ]] end)

			expect(v12:Remove(v1)).to.equal(false)
			expect(v1.Connected).to.equal(true)
			v1:Disconnect()
		end)
		it("should attach to instance", function() --[[ Line: 129 | Upvalues: v12 (ref) ]]
			local Part = Instance.new("Part")

			Part.Parent = workspace

			local v1 = v12:AttachToInstance(Part)

			expect(v1.Connected).to.equal(true)
			Part:Destroy()
			expect(v1.Connected).to.equal(false)
		end)
		it("should fail to attach to instance not in hierarchy", function() --[[ Line: 138 | Upvalues: v12 (ref) ]]
			local Part = Instance.new("Part")

			expect(function() --[[ Line: 140 | Upvalues: v12 (ref), Part (copy) ]]
				v12:AttachToInstance(Part)
			end).to.throw()
		end)
		it("should extend itself", function() --[[ Line: 145 | Upvalues: v12 (ref), v1 (ref) ]]
			local v13 = v12:Extend()
			local v2 = false

			v13:Add(function() --[[ Line: 148 | Upvalues: v2 (ref) ]]
				v2 = true
			end)
			expect(v13).to.be.a("table")
			expect((getmetatable(v13))).to.equal(v1)
			v12:Clean()
			expect(v2).to.equal(true)
		end)
		it("should clone an instance", function() --[[ Line: 157 | Upvalues: v12 (ref) ]]
			local TroveCloneTest = v12:Construct(Instance.new, "Part")

			TroveCloneTest.Name = "TroveCloneTest"

			local v1 = v12:Clone(TroveCloneTest)

			expect((typeof(v1))).to.equal("Instance")
			expect(v1).to.never.equal(TroveCloneTest)
			expect(v1.Name).to.equal("TroveCloneTest")
			expect(TroveCloneTest.Name).to.equal(v1.Name)
		end)
		it("should clean up a thread", function() --[[ Line: 168 | Upvalues: v12 (ref) ]]
			local v1 = coroutine.create(function() --[[ Line: 169 ]] end)

			v12:Add(v1)
			expect(coroutine.status(v1)).to.equal("suspended")
			v12:Clean()
			expect(coroutine.status(v1)).to.equal("dead")
		end)
		it("should not allow objects added during cleanup", function() --[[ Line: 176 | Upvalues: v12 (ref) ]]
			expect(function() --[[ Line: 177 | Upvalues: v12 (ref) ]]
				v12:Add(function() --[[ Line: 178 | Upvalues: v12 (ref) ]]
					v12:Add(function() --[[ Line: 179 ]] end)
				end)
				v12:Clean()
			end).to.throw()
		end)
		it("should not allow objects to be removed during cleanup", function() --[[ Line: 185 | Upvalues: v12 (ref) ]]
			expect(function() --[[ Line: 186 | Upvalues: v12 (ref) ]]
				local function f1() --[[ Line: 187 ]] end

				v12:Add(f1)
				v12:Add(function() --[[ Line: 189 | Upvalues: v12 (ref), f1 (copy) ]]
					v12:Remove(f1)
				end)
				v12:Clean()
			end).to.throw()
		end)
	end)
end