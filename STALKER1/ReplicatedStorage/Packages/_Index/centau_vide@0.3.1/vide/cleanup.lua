-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
if not game then
	script = require("test/relative-string")
end

local v1 = game and typeof or require("test/mock").typeof
local throw = require(script.Parent.throw)
local graph = require(script.Parent.graph)
local get_scope = graph.get_scope
local push_cleanup = graph.push_cleanup

local function helper(p1) --[[ helper | Line: 9 | Upvalues: v1 (copy), throw (copy) ]]
	if v1(p1) == "RBXScriptConnection" then
		return function() --[[ Line: 11 | Upvalues: p1 (copy) ]]
			p1:Disconnect()
		end
	end

	if v1(p1) == "Instance" then
		return function() --[[ Line: 12 | Upvalues: p1 (copy) ]]
			p1:Destroy()
		end
	end

	if p1.destroy then
		return function() --[[ Line: 13 | Upvalues: p1 (copy) ]]
			p1:destroy()
		end
	end

	if p1.disconnect then
		return function() --[[ Line: 14 | Upvalues: p1 (copy) ]]
			p1:disconnect()
		end
	end

	if p1.Destroy then
		return function() --[[ Line: 15 | Upvalues: p1 (copy) ]]
			p1:Destroy()
		end
	end

	if p1.Disconnect then
		return function() --[[ Line: 16 | Upvalues: p1 (copy) ]]
			p1:Disconnect()
		end
	end

	return throw("cannot cleanup given object")
end

return function(p1) --[[ cleanup | Line: 20 | Upvalues: get_scope (copy), throw (copy), push_cleanup (copy), helper (copy) ]]
	local v1 = get_scope()

	if not v1 then
		throw("cannot cleanup outside a stable or reactive scope")
	end

	assert(v1)

	if type(p1) == "function" then
		push_cleanup(v1, p1)
	else
		push_cleanup(v1, (helper(p1)))
	end
end