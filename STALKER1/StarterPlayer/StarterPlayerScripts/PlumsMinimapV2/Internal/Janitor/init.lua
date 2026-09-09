-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Promise = require(script.Promise)
local v1 = setmetatable({}, {
	__tostring = function() --[[ __tostring | Line: 16 ]]
		return "LinkToInstanceIndex"
	end
})
local t2 = {
	ClassName = "Janitor",
	CurrentlyCleaning = true,
	SuppressInstanceReDestroy = false
}

t2.__index = t2

local v2 = setmetatable({}, {
	__mode = "k"
})
local t3 = {
	["function"] = true,
	thread = true,
	RBXScriptConnection = "Disconnect"
}

function t2.new() --[[ new | Line: 150 | Upvalues: t2 (copy) ]]
	return setmetatable({
		CurrentlyCleaning = false
	}, t2)
end
function t2.Is(p1) --[[ Is | Line: 163 | Upvalues: t2 (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == t2 else false
end
t2.instanceof = t2.Is

local function Remove(p1, p2) --[[ Remove | Line: 179 | Upvalues: v2 (copy) ]]
	local v1 = v2[p1]

	if v1 then
		local v22 = v1[p2]

		if not v22 then
			return p1
		end

		local v3 = p1[v22]

		if v3 then
			if v3 == true then
				if type(v22) == "function" then
					v22()
				elseif not (if coroutine.running() == v22 then nil else pcall(function() --[[ Line: 196 | Upvalues: v22 (copy) ]]
	task.cancel(v22)
end)) then
					task.defer(function() --[[ Line: 203 | Upvalues: v22 (copy) ]]
						task.cancel(v22)
					end)
				end
			else
				local v5 = v22[v3]

				if v5 and (p1.SuppressInstanceReDestroy and (v3 == "Destroy" and typeof(v22) == "Instance")) then
					pcall(v5, v22)
				elseif v5 then
					v5(v22)
				end
			end

			p1[v22] = nil
		end

		v1[p2] = nil
	end

	return p1
end

local function Add(p1, p2, p3, p4) --[[ Add | Line: 230 | Upvalues: Remove (copy), v2 (copy), t3 (copy) ]]
	if p4 then
		Remove(p1, p4)

		local v1 = v2[p1]

		if not v1 then
			v1 = {}
			v2[p1] = v1
		end

		v1[p4] = p2
	end

	local v22 = typeof(p2)
	local v3 = if p3 then p3 else t3[v22] or "Destroy"

	if v22 == "function" or v22 == "thread" then
		if v3 ~= true then
			warn(string.format("Object is a %* and as such expected `true?` for the method name and instead got %*. Traceback: %*", v22, tostring(v3), debug.traceback(nil, 2)))
		end
	elseif not p2[v3] then
		warn(string.format("Object %* doesn\'t have method %*, are you sure you want to add it? Traceback: %*", tostring(p2), tostring(v3), debug.traceback(nil, 2)))
	end

	p1[p2] = v3

	return p2
end

t2.Add = Add
function t2.AddObject(p1, p2, p3, p4, ...) --[[ AddObject | Line: 383 | Upvalues: Add (copy) ]]
	return Add(p1, p2.new(...), p3, p4)
end
function t2.AddPromise(p1, p2) --[[ AddPromise | Line: 417 | Upvalues: Promise (copy), Add (copy), Remove (copy) ]]
	if not Promise then
		return p2
	end

	if not Promise.is(p2) then
		error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %* (%*)) Traceback: %*", typeof(p2), tostring(p2), debug.traceback(nil, 2)))
	end

	if p2:getStatus() == Promise.Status.Started then
		local v1 = newproxy(false)
		local v2 = Add(p1, Promise.new(function(p1, p22, p3) --[[ Line: 428 | Upvalues: p2 (copy) ]]
			if not p3(function() --[[ Line: 429 | Upvalues: p2 (ref) ]]
				p2:cancel()
			end) then
				p1(p2)
			end
		end), "cancel", v1)

		v2:finally(function() --[[ Line: 438 | Upvalues: Remove (ref), p1 (copy), v1 (copy) ]]
			Remove(p1, v1)
		end)

		return v2
	end

	return p2
end
t2.Remove = Remove
function t2.RemoveNoClean(p1, p2) --[[ RemoveNoClean | Line: 510 | Upvalues: v2 (copy) ]]
	local v1 = v2[p1]

	if v1 then
		local v22 = v1[p2]

		if v22 then
			p1[v22] = nil
			v1[p2] = nil
		end
	end

	return p1
end
function t2.RemoveList(p1, ...) --[[ RemoveList | Line: 565 | Upvalues: v2 (copy), Remove (copy) ]]
	if v2[p1] then
		local v1 = select("#", ...)

		if v1 == 1 then
			return Remove(p1, ...)
		end

		if v1 == 2 then
			local v22, v3 = ...

			Remove(p1, v22)
			Remove(p1, v3)

			return p1
		end

		if v1 == 3 then
			local v4, v5, v6 = ...

			Remove(p1, v4)
			Remove(p1, v5)
			Remove(p1, v6)

			return p1
		end

		for i = 1, v1 do
			Remove(p1, (select(i, ...)))
		end
	end

	return p1
end
function t2.RemoveListNoClean(p1, ...) --[[ RemoveListNoClean | Line: 636 | Upvalues: v2 (copy) ]]
	local v1 = v2[p1]

	if v1 then
		local v22 = select("#", ...)

		if v22 == 1 then
			local v3 = ...
			local v4 = v1[v3]

			if v4 then
				p1[v4] = nil
				v1[v3] = nil
			end

			return p1
		end

		if v22 == 2 then
			local v5, v6 = ...
			local v7 = v1[v5]

			if v7 then
				p1[v7] = nil
				v1[v5] = nil
			end

			local v8 = v1[v6]

			if v8 then
				p1[v8] = nil
				v1[v6] = nil
			end

			return p1
		end

		if v22 == 3 then
			local v9, v10, v11 = ...
			local v12 = v1[v9]

			if v12 then
				p1[v12] = nil
				v1[v9] = nil
			end

			local v13 = v1[v10]

			if v13 then
				p1[v13] = nil
				v1[v10] = nil
			end

			local v14 = v1[v11]

			if v14 then
				p1[v14] = nil
				v1[v11] = nil
			end

			return p1
		end

		for i = 1, v22 do
			local v15 = select(i, ...)
			local v16 = v1[v15]

			if v16 then
				p1[v16] = nil
				v1[v15] = nil
			end
		end
	end

	return p1
end
function t2.Get(p1, p2) --[[ Get | Line: 723 | Upvalues: v2 (copy) ]]
	local v1 = v2[p1]

	if v1 then
		return v1[p2]
	end

	return nil
end
function t2.GetAll(p1) --[[ GetAll | Line: 753 | Upvalues: v2 (copy) ]]
	local v1 = v2[p1]

	if v1 then
		return table.freeze(table.clone(v1))
	end

	return {}
end

local function GetFenv(p1) --[[ GetFenv | Line: 758 ]]
	return function() --[[ Line: 759 | Upvalues: p1 (copy) ]]
		for v1, v2 in next, p1 do
			if v1 ~= "SuppressInstanceReDestroy" then
				return v1, v2
			end
		end
	end
end

local function Cleanup(p1) --[[ Cleanup | Line: 768 | Upvalues: v2 (copy) ]]
	if p1.CurrentlyCleaning then
		return
	end

	p1.CurrentlyCleaning = nil

	local function f1() --[[ Line: 759 | Upvalues: p1 (copy) ]]
		for v1, v2 in next, p1 do
			if v1 ~= "SuppressInstanceReDestroy" then
				return v1, v2
			end
		end
	end

	local v22, v3 = f1()

	while v22 and v3 do
		local v4

		if v3 == true then
			if type(v22) == "function" then
				v22()
			elseif type(v22) == "thread" then
				v4 = if coroutine.running() == v22 then nil else pcall(function() --[[ Line: 782 | Upvalues: v22 (ref) ]]
	task.cancel(v22)
end)

				if not v4 then
					local v5 = v22

					task.defer(function() --[[ Line: 789 | Upvalues: v5 (copy) ]]
						task.cancel(v5)
					end)
				end
			end
		else
			local v6 = v22[v3]

			if v6 and (p1.SuppressInstanceReDestroy and (v3 == "Destroy" and typeof(v22) == "Instance")) then
				pcall(v6, v22)
			elseif v6 then
				v6(v22)
			end
		end

		p1[v22] = nil

		local v7, v8 = f1()

		v22, v3 = v7, v8
	end

	local v9 = v2[p1]

	if v9 then
		table.clear(v9)
		v2[p1] = nil
	end

	p1.CurrentlyCleaning = false
end

t2.Cleanup = Cleanup
function t2.Destroy(p1) --[[ Destroy | Line: 852 | Upvalues: Cleanup (copy) ]]
	Cleanup(p1)
	table.clear(p1)
	setmetatable(p1, nil)
end
t2.__call = Cleanup

local function LinkToInstance(p1, p2, p3) --[[ LinkToInstance | Line: 860 | Upvalues: v1 (copy), Add (copy), Cleanup (copy) ]]
	local v12 = if p3 then newproxy(false) else v1

	return Add(p1, p2.Destroying:Connect(function() --[[ Line: 863 | Upvalues: Cleanup (ref), p1 (copy) ]]
		Cleanup(p1)
	end), "Disconnect", v12)
end

t2.LinkToInstance = LinkToInstance
t2.LegacyLinkToInstance = LinkToInstance
function t2.LinkToInstances(p1, ...) --[[ LinkToInstances | Line: 926 | Upvalues: t2 (copy), LinkToInstance (copy) ]]
	local v1 = t2.new()

	for i = 1, select("#", ...) do
		local v2 = select(i, ...)

		if typeof(v2) == "Instance" then
			v1:Add(LinkToInstance(p1, v2, true), "Disconnect")
		end
	end

	return v1
end
function t2.__tostring(p1) --[[ __tostring | Line: 940 ]]
	return "Janitor"
end

return t2