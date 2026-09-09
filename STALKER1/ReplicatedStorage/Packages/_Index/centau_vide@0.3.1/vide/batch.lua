-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2, v3

if game then
	v1 = require(script.Parent.flags)
	v2 = require(script.Parent.throw)
	v3 = require(script.Parent.graph)

	return function(p13) --[[ batch | Line: 7 | Upvalues: v1 (copy), v3 (copy), v2 (copy) ]]
		local batch = v1.batch
		local v12

		if batch then
			v12 = nil
		else
			v1.batch = true
			v12 = v3.get_update_queue_length()
		end

		local ok, result = pcall(p13)

		if not batch then
			v1.batch = false
			v3.flush_update_queue(v12)
		end

		if ok then
			return
		end

		v2((("error occured while batching updates: %*"):format(result)))
	end
end

script = require("test/relative-string")
v1 = require(script.Parent.flags)
v2 = require(script.Parent.throw)
v3 = require(script.Parent.graph)

return function(p13) --[[ batch | Line: 7 | Upvalues: v1 (copy), v3 (copy), v2 (copy) ]]
	local batch = v1.batch
	local v12

	if batch then
		v12 = nil
	else
		v1.batch = true
		v12 = v3.get_update_queue_length()
	end

	local ok, result = pcall(p13)

	if not batch then
		v1.batch = false
		v3.flush_update_queue(v12)
	end

	if ok then
		return
	end

	v2((("error occured while batching updates: %*"):format(result)))
end