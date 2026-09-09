-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, _, _2, v12, _3, v13, v14, _4, v15, v16, v17, v18, v19, v20, v21, v22

if game then
	v1 = require(script.Parent.throw)
	v2 = require(script.Parent.flags)
	v3 = {
		n = 0
	}
	v4 = function(p13, p23) --[[ ycall | Line: 27 ]]
		local v1 = coroutine.create(xpcall)

		local function efn(p13) --[[ efn | Line: 29 ]]
			return debug.traceback(p13, 3)
		end

		local v2, v3, v4 = coroutine.resume(v1, p13, efn, p23)

		assert(v2)

		if coroutine.status(v1) == "dead" then
			return v3, v4
		end

		return false, debug.traceback(v1, "attempt to yield in reactive scope")
	end
	v5 = function() --[[ get_scope | Line: 41 | Upvalues: v3 (copy) ]]
		return v3[v3.n]
	end
	v6 = function() --[[ assert_stable_scope | Line: 45 | Upvalues: v3 (copy), v1 (copy) ]]
		local v12 = v3[v3.n]

		if not v12 then
			return v1((("cannot use %*() outside a stable or reactive scope"):format((debug.info(2, "n")))))
		end

		if not v12.effect then
			return v12
		end

		v1("cannot create a new reactive scope inside another reactive scope")

		return v12
	end
	v7 = function(p13, p23) --[[ push_child | Line: 58 ]]
		table.insert(p13, p23)
		table.insert(p23.parents, p13)
	end
	v8 = function(p13) --[[ push_scope | Line: 63 | Upvalues: v3 (copy) ]]
		local v1 = v3.n + 1

		v3.n = v1
		v3[v1] = p13
	end
	v9 = function() --[[ pop_scope | Line: 69 | Upvalues: v3 (copy) ]]
		local n2 = v3.n

		v3.n = n2 - 1
		v3[n2] = nil
	end
	v10 = function(p13, p23) --[[ push_cleanup | Line: 75 ]]
		if p13.cleanups then
			table.insert(p13.cleanups, p23)
		else
			p13.cleanups = { p23 }
		end
	end
	v11 = function(p13) --[[ flush_cleanups | Line: 83 | Upvalues: v1 (copy) ]]
		if not p13.cleanups then
			return
		end

		for v12, v2 in next, p13.cleanups do
			local ok, result = pcall(v2)

			if not ok then
				v1((("cleanup error: %*"):format(result)))
			end
		end

		table.clear(p13.cleanups)
	end
	_ = function(p13, p23) --[[ find_and_swap_pop | Line: 94 ]]
		local v1 = #p13

		p13[table.find(p13, p23)] = p13[v1]
		p13[v1] = nil
	end
	_2 = function(p13) --[[ unparent | Line: 101 ]]
		local parents = p13.parents

		for v1, v2 in parents do
			local v3 = #v2

			v2[table.find(v2, p13)] = v2[v3]
			v2[v3] = nil
			parents[v1] = nil
		end
	end
	v12 = function(p13) --[[ destroy | Line: 110 | Upvalues: v11 (copy), v12 (copy) ]]
		v11(p13)

		local parents = p13.parents

		for v1, v2 in parents do
			local v3 = #v2

			v2[table.find(v2, p13)] = v2[v3]
			v2[v3] = nil
			parents[v1] = nil
		end

		if p13.owner then
			local owned = p13.owner.owned
			local v4 = #owned

			owned[table.find(owned, p13)] = owned[v4]
			owned[v4] = nil
			p13.owner = false
		end

		if not p13.owned then
			return
		end

		local owned = p13.owned

		while owned[1] do
			v12(owned[1])
		end
	end
	_3 = function(p13) --[[ destroy_owned | Line: 125 | Upvalues: v12 (copy) ]]
		if not p13.owned then
			return
		end

		local owned = p13.owned

		while owned[1] do
			v12(owned[1])
		end
	end
	v13 = {
		n = 0
	}
	v14 = function(p13) --[[ evaluate_node | Line: 134 | Upvalues: v2 (copy), v11 (copy), v12 (copy), v3 (copy), v4 (copy), v13 (copy), v1 (copy) ]]
		if v2.strict then
			local cache = p13.cache

			for i = 1, 2 do
				v11(p13)

				if p13.owned then
					local owned = p13.owned

					while owned[1] do
						v12(owned[1])
					end
				end

				local v14 = v3.n + 1

				v3.n = v14
				v3[v14] = p13

				local v22, v32 = v4(p13.effect, p13.cache)
				local n2 = v3.n

				v3.n = n2 - 1
				v3[n2] = nil

				if not v22 then
					table.clear(v13)
					v13.n = 0
					v1((("effect stacktrace:\n%*"):format(v32)))
				end

				p13.cache = v32
			end

			return cache ~= p13.cache
		end

		local cache = p13.cache

		v11(p13)

		if p13.owned then
			local owned = p13.owned

			while owned[1] do
				v12(owned[1])
			end
		end

		local v42 = v3.n + 1

		v3.n = v42
		v3[v42] = p13

		local ok, result = pcall(p13.effect, p13.cache)
		local n2 = v3.n

		v3.n = n2 - 1
		v3[n2] = nil

		if not ok then
			table.clear(v13)
			v13.n = 0
			v1((("effect stacktrace:\n%*\n"):format(result)))
		end

		p13.cache = result

		return cache ~= result
	end
	_4 = function(p13) --[[ queue_children_for_update | Line: 179 | Upvalues: v13 (copy) ]]
		local n2 = v13.n

		while p13[1] do
			n2 = n2 + 1
			v13[n2] = p13[1]

			local v1 = p13[1]
			local parents = v1.parents

			for v2, v3 in parents do
				local v4 = #v3

				v3[table.find(v3, v1)] = v3[v4]
				v3[v4] = nil
				parents[v2] = nil
			end
		end

		v13.n = n2
	end
	v15 = function() --[[ get_update_queue_length | Line: 189 | Upvalues: v13 (copy) ]]
		return v13.n
	end
	v16 = function(p13) --[[ flush_update_queue | Line: 193 | Upvalues: v13 (copy), v14 (copy) ]]
		local count2 = p13 + 1

		while count2 <= v13.n do
			local v1 = v13[count2]

			if v1.owner and v14(v1) then
				local n2 = v13.n

				while v1[1] do
					n2 = n2 + 1
					v13[n2] = v1[1]

					local v2 = v1[1]
					local parents = v2.parents

					for v3, v4 in parents do
						local v5 = #v4

						v4[table.find(v4, v2)] = v4[v5]
						v4[v5] = nil
						parents[v3] = nil
					end
				end

				v13.n = n2
			end

			v13[count2] = false
			count2 = count2 + 1
		end

		v13.n = p13
	end
	v17 = function(p13) --[[ update_descendants | Line: 210 | Upvalues: v13 (copy), v2 (copy), v14 (copy) ]]
		local n2 = v13.n
		local n22 = v13.n

		while p13[1] do
			n22 = n22 + 1
			v13[n22] = p13[1]

			local v1 = p13[1]
			local parents = v1.parents

			for v22, v3 in parents do
				local v4 = #v3

				v3[table.find(v3, v1)] = v3[v4]
				v3[v4] = nil
				parents[v22] = nil
			end
		end

		v13.n = n22

		if v2.batch then
			return
		end

		local count2 = n2 + 1

		while count2 <= v13.n do
			local v5 = v13[count2]

			if v5.owner and v14(v5) then
				local n3 = v13.n

				while v5[1] do
					n3 = n3 + 1
					v13[n3] = v5[1]

					local v6 = v5[1]
					local parents = v6.parents

					for v7, v8 in parents do
						local v9 = #v8

						v8[table.find(v8, v6)] = v8[v9]
						v8[v9] = nil
						parents[v7] = nil
					end
				end

				v13.n = n3
			end

			v13[count2] = false
			count2 = count2 + 1
		end

		v13.n = n2
	end
	v18 = function(p13) --[[ push_child_to_scope | Line: 233 | Upvalues: v3 (copy) ]]
		local v1 = v3[v3.n]

		if not (v1 and v1.effect) then
			return
		end

		table.insert(p13, v1)
		table.insert(v1.parents, p13)
	end
	v19 = function(p13, p23, p33) --[[ create_node | Line: 240 ]]
		local t2 = {
			cleanups = false,
			context = false,
			owned = false,
			cache = p33,
			effect = p23,
			owner = p13,
			parents = {}
		}

		if p13 then
			if p13.owned then
				table.insert(p13.owned, t2)

				return t2
			end

			p13.owned = { t2 }
		end

		return t2
	end
	v20 = function(p13) --[[ create_source_node | Line: 265 ]]
		return {
			cache = p13
		}
	end
	v21 = function(p13) --[[ get_children | Line: 269 ]]
		return { unpack(p13) }
	end
	v22 = function(p13, p23, p33) --[[ set_context | Line: 273 ]]
		if p13.context then
			p13.context[p23] = p33
		else
			p13.context = {
				[p23] = p33
			}
		end
	end

	return table.freeze({
		push_scope = v8,
		pop_scope = v9,
		evaluate_node = v14,
		get_scope = v5,
		assert_stable_scope = v6,
		push_cleanup = v10,
		destroy = v12,
		flush_cleanups = v11,
		push_child_to_scope = v18,
		update_descendants = v17,
		push_child = v7,
		create_node = v19,
		create_source_node = v20,
		get_children = v21,
		flush_update_queue = v16,
		get_update_queue_length = v15,
		set_context = v22,
		scopes = v3
	})
end

script = require("test/relative-string")
v1 = require(script.Parent.throw)
v2 = require(script.Parent.flags)
v3 = {
	n = 0
}
v4 = function(p13, p23) --[[ ycall | Line: 27 ]]
	local v1 = coroutine.create(xpcall)

	local function efn(p13) --[[ efn | Line: 29 ]]
		return debug.traceback(p13, 3)
	end

	local v2, v3, v4 = coroutine.resume(v1, p13, efn, p23)

	assert(v2)

	if coroutine.status(v1) == "dead" then
		return v3, v4
	end

	return false, debug.traceback(v1, "attempt to yield in reactive scope")
end
v5 = function() --[[ get_scope | Line: 41 | Upvalues: v3 (copy) ]]
	return v3[v3.n]
end
v6 = function() --[[ assert_stable_scope | Line: 45 | Upvalues: v3 (copy), v1 (copy) ]]
	local v12 = v3[v3.n]

	if not v12 then
		return v1((("cannot use %*() outside a stable or reactive scope"):format((debug.info(2, "n")))))
	end

	if not v12.effect then
		return v12
	end

	v1("cannot create a new reactive scope inside another reactive scope")

	return v12
end
v7 = function(p13, p23) --[[ push_child | Line: 58 ]]
	table.insert(p13, p23)
	table.insert(p23.parents, p13)
end
v8 = function(p13) --[[ push_scope | Line: 63 | Upvalues: v3 (copy) ]]
	local v1 = v3.n + 1

	v3.n = v1
	v3[v1] = p13
end
v9 = function() --[[ pop_scope | Line: 69 | Upvalues: v3 (copy) ]]
	local n2 = v3.n

	v3.n = n2 - 1
	v3[n2] = nil
end
v10 = function(p13, p23) --[[ push_cleanup | Line: 75 ]]
	if p13.cleanups then
		table.insert(p13.cleanups, p23)
	else
		p13.cleanups = { p23 }
	end
end
v11 = function(p13) --[[ flush_cleanups | Line: 83 | Upvalues: v1 (copy) ]]
	if not p13.cleanups then
		return
	end

	for v12, v2 in next, p13.cleanups do
		local ok, result = pcall(v2)

		if not ok then
			v1((("cleanup error: %*"):format(result)))
		end
	end

	table.clear(p13.cleanups)
end
_ = function(p13, p23) --[[ find_and_swap_pop | Line: 94 ]]
	local v1 = #p13

	p13[table.find(p13, p23)] = p13[v1]
	p13[v1] = nil
end
_2 = function(p13) --[[ unparent | Line: 101 ]]
	local parents = p13.parents

	for v1, v2 in parents do
		local v3 = #v2

		v2[table.find(v2, p13)] = v2[v3]
		v2[v3] = nil
		parents[v1] = nil
	end
end
v12 = function(p13) --[[ destroy | Line: 110 | Upvalues: v11 (copy), v12 (copy) ]]
	v11(p13)

	local parents = p13.parents

	for v1, v2 in parents do
		local v3 = #v2

		v2[table.find(v2, p13)] = v2[v3]
		v2[v3] = nil
		parents[v1] = nil
	end

	if p13.owner then
		local owned = p13.owner.owned
		local v4 = #owned

		owned[table.find(owned, p13)] = owned[v4]
		owned[v4] = nil
		p13.owner = false
	end

	if not p13.owned then
		return
	end

	local owned = p13.owned

	while owned[1] do
		v12(owned[1])
	end
end
_3 = function(p13) --[[ destroy_owned | Line: 125 | Upvalues: v12 (copy) ]]
	if not p13.owned then
		return
	end

	local owned = p13.owned

	while owned[1] do
		v12(owned[1])
	end
end
v13 = {
	n = 0
}
v14 = function(p13) --[[ evaluate_node | Line: 134 | Upvalues: v2 (copy), v11 (copy), v12 (copy), v3 (copy), v4 (copy), v13 (copy), v1 (copy) ]]
	if v2.strict then
		local cache = p13.cache

		for i = 1, 2 do
			v11(p13)

			if p13.owned then
				local owned = p13.owned

				while owned[1] do
					v12(owned[1])
				end
			end

			local v14 = v3.n + 1

			v3.n = v14
			v3[v14] = p13

			local v22, v32 = v4(p13.effect, p13.cache)
			local n2 = v3.n

			v3.n = n2 - 1
			v3[n2] = nil

			if not v22 then
				table.clear(v13)
				v13.n = 0
				v1((("effect stacktrace:\n%*"):format(v32)))
			end

			p13.cache = v32
		end

		return cache ~= p13.cache
	end

	local cache = p13.cache

	v11(p13)

	if p13.owned then
		local owned = p13.owned

		while owned[1] do
			v12(owned[1])
		end
	end

	local v42 = v3.n + 1

	v3.n = v42
	v3[v42] = p13

	local ok, result = pcall(p13.effect, p13.cache)
	local n2 = v3.n

	v3.n = n2 - 1
	v3[n2] = nil

	if not ok then
		table.clear(v13)
		v13.n = 0
		v1((("effect stacktrace:\n%*\n"):format(result)))
	end

	p13.cache = result

	return cache ~= result
end
_4 = function(p13) --[[ queue_children_for_update | Line: 179 | Upvalues: v13 (copy) ]]
	local n2 = v13.n

	while p13[1] do
		n2 = n2 + 1
		v13[n2] = p13[1]

		local v1 = p13[1]
		local parents = v1.parents

		for v2, v3 in parents do
			local v4 = #v3

			v3[table.find(v3, v1)] = v3[v4]
			v3[v4] = nil
			parents[v2] = nil
		end
	end

	v13.n = n2
end
v15 = function() --[[ get_update_queue_length | Line: 189 | Upvalues: v13 (copy) ]]
	return v13.n
end
v16 = function(p13) --[[ flush_update_queue | Line: 193 | Upvalues: v13 (copy), v14 (copy) ]]
	local count2 = p13 + 1

	while count2 <= v13.n do
		local v1 = v13[count2]

		if v1.owner and v14(v1) then
			local n2 = v13.n

			while v1[1] do
				n2 = n2 + 1
				v13[n2] = v1[1]

				local v2 = v1[1]
				local parents = v2.parents

				for v3, v4 in parents do
					local v5 = #v4

					v4[table.find(v4, v2)] = v4[v5]
					v4[v5] = nil
					parents[v3] = nil
				end
			end

			v13.n = n2
		end

		v13[count2] = false
		count2 = count2 + 1
	end

	v13.n = p13
end
v17 = function(p13) --[[ update_descendants | Line: 210 | Upvalues: v13 (copy), v2 (copy), v14 (copy) ]]
	local n2 = v13.n
	local n22 = v13.n

	while p13[1] do
		n22 = n22 + 1
		v13[n22] = p13[1]

		local v1 = p13[1]
		local parents = v1.parents

		for v22, v3 in parents do
			local v4 = #v3

			v3[table.find(v3, v1)] = v3[v4]
			v3[v4] = nil
			parents[v22] = nil
		end
	end

	v13.n = n22

	if v2.batch then
		return
	end

	local count2 = n2 + 1

	while count2 <= v13.n do
		local v5 = v13[count2]

		if v5.owner and v14(v5) then
			local n3 = v13.n

			while v5[1] do
				n3 = n3 + 1
				v13[n3] = v5[1]

				local v6 = v5[1]
				local parents = v6.parents

				for v7, v8 in parents do
					local v9 = #v8

					v8[table.find(v8, v6)] = v8[v9]
					v8[v9] = nil
					parents[v7] = nil
				end
			end

			v13.n = n3
		end

		v13[count2] = false
		count2 = count2 + 1
	end

	v13.n = n2
end
v18 = function(p13) --[[ push_child_to_scope | Line: 233 | Upvalues: v3 (copy) ]]
	local v1 = v3[v3.n]

	if not (v1 and v1.effect) then
		return
	end

	table.insert(p13, v1)
	table.insert(v1.parents, p13)
end
v19 = function(p13, p23, p33) --[[ create_node | Line: 240 ]]
	local t2 = {
		cleanups = false,
		context = false,
		owned = false,
		cache = p33,
		effect = p23,
		owner = p13,
		parents = {}
	}

	if p13 then
		if p13.owned then
			table.insert(p13.owned, t2)

			return t2
		end

		p13.owned = { t2 }
	end

	return t2
end
v20 = function(p13) --[[ create_source_node | Line: 265 ]]
	return {
		cache = p13
	}
end
v21 = function(p13) --[[ get_children | Line: 269 ]]
	return { unpack(p13) }
end
v22 = function(p13, p23, p33) --[[ set_context | Line: 273 ]]
	if p13.context then
		p13.context[p23] = p33
	else
		p13.context = {
			[p23] = p33
		}
	end
end

return table.freeze({
	push_scope = v8,
	pop_scope = v9,
	evaluate_node = v14,
	get_scope = v5,
	assert_stable_scope = v6,
	push_cleanup = v10,
	destroy = v12,
	flush_cleanups = v11,
	push_child_to_scope = v18,
	update_descendants = v17,
	push_child = v7,
	create_node = v19,
	create_source_node = v20,
	get_children = v21,
	flush_update_queue = v16,
	get_update_queue_length = v15,
	set_context = v22,
	scopes = v3
})