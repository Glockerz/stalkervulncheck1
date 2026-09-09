-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
if not game then
	script = require("test/relative-string")
end

local v1 = game and typeof or require("test/mock").typeof
local v2 = game and Instance or require("test/mock").Instance
local throw = require(script.Parent.throw)
local defaults = require(script.Parent.defaults)
local apply = require(script.Parent.apply)
local t = {}

setmetatable(t, {
	__index = function(p1, p2) --[[ __index | Line: 12 | Upvalues: v2 (copy), throw (copy), defaults (copy), apply (copy) ]]
		local ok, result = pcall(v2.new, p2)

		if not ok then
			throw((("invalid class name, could not create instance of class %*"):format(p2)))
		end

		local v1 = defaults[p2]

		if v1 then
			for v22, v3 in next, v1 do
				result[v22] = v3
			end
		end

		local function ctor(p1) --[[ ctor | Line: 23 | Upvalues: apply (ref), result (copy) ]]
			return apply(result:Clone(), p1)
		end

		p1[p2] = ctor

		return ctor
	end
})

local function create_instance(p1) --[[ create_instance | Line: 32 | Upvalues: t (copy) ]]
	return t[p1]
end

local function clone_instance(p1) --[[ clone_instance | Line: 36 | Upvalues: throw (copy), apply (copy) ]]
	return function(p13) --[[ Line: 37 | Upvalues: p1 (copy), throw (ref), apply (ref) ]]
		local v1 = p1:Clone()

		if v1 then
			return apply(v1, p13)
		end

		throw("attempt to clone a non-archivable instance")

		return apply(v1, p13)
	end
end

return function(p1) --[[ create | Line: 44 | Upvalues: t (copy), v1 (copy), throw (copy), apply (copy) ]]
	if type(p1) == "string" then
		return t[p1]
	end

	if v1(p1) == "Instance" then
		return function(p13) --[[ Line: 37 | Upvalues: p1 (copy), throw (ref), apply (ref) ]]
			local v1 = p1:Clone()

			if v1 then
				return apply(v1, p13)
			end

			throw("attempt to clone a non-archivable instance")

			return apply(v1, p13)
		end
	end

	throw("bad argument #1, expected string or instance, got " .. v1(p1))

	return nil
end