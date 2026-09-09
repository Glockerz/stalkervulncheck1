-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent:WaitForChild("customid"))

local common = require(script.Parent:WaitForChild("common"))

require(script.Parent:WaitForChild("types"))

local ecs_name = common.ecs_name
local relationships = common.relationships
local t = {
	create_shared_lookup = function(p1) --[[ create_shared_lookup | Line: 22 ]]
		local t = {}
		local t2 = {}
		local t3 = {}

		for v1 in p1 do
			table.insert(t, v1)
		end

		table.sort(t)

		for v2, v3 in t do
			local v4 = p1[v3]

			t2[v4] = v2
			t3[v2] = v4
		end

		return {
			lookup = p1,
			keys = t,
			indexes = t3,
			members = t2
		}
	end,
	generate_handshake = function(p1) --[[ generate_handshake | Line: 46 ]]
		local t = {
			components = {},
			custom_ids = {},
			serdes = {}
		}
		local t2 = {}

		for v1, v2 in p1.components.lookup do
			t.components[v1] = true
			t2[v2] = v1
		end

		for v3 in p1.custom_ids.lookup do
			t.custom_ids[v3] = true
		end

		for v4, v5 in p1.serdes do
			local v6 = t2[v4]

			if v6 then
				t.serdes[v6] = {
					includes_variants = v5.includes_variants,
					bytespan = v5.bytespan
				}
			end
		end

		return t
	end,
	verify_handshake = function(p1, p2, p3, p4) --[[ verify_handshake | Line: 78 ]]
		local t = {}

		for v1 in p2.components do
			if not p1.components.lookup[v1] then
				return false, ("missing shared component \"%*\" in %*"):format(v1, p4)
			end
		end

		for v2, v3 in p1.components.lookup do
			if not p2.components[v2] then
				return false, ("missing shared component \"%*\" in %*"):format(v2, p3)
			end

			t[v3] = v2
		end

		for v4 in p2.custom_ids do
			if not p1.custom_ids.lookup[v4] then
				return false, ("missing custom id \"%*\" in %*"):format(v4, p4)
			end
		end

		for v5 in p1.custom_ids.lookup do
			if not p2.custom_ids[v5] then
				return false, ("missing custom id \"%*\" in %*"):format(v5, p3)
			end
		end

		for v6, v7 in p2.serdes do
			local v8 = p1.components.lookup[v6]

			if v8 then
				local v9 = p1.serdes[v8]

				if not v9 then
					return false, ("missing serdes for component \"%*\" in %*"):format(v6, p4)
				end

				if (v7.includes_variants or false) ~= (v9.includes_variants or false) then
					return false, ("mismatched includes_variants for component \"%*\": (%* ~= %*)"):format(v6, v7.includes_variants, v9.includes_variants)
				end

				if v7.bytespan ~= v9.bytespan then
					return false, ("mismatched bytespan for component \"%*\": (%* ~= %*)"):format(v6, v7.bytespan, v9.bytespan)
				end

				continue
			end

			warn((("%* registered a serdes for \"%*\" that %* doesn\'t have"):format(p3, v6, p4)))
		end

		for v10 in p1.serdes do
			local v11 = t[v10]

			if v11 and not p2.serdes[v11] then
				warn((("%* registered a serdes for \"%*\" that %* doesn\'t have"):format(p4, v11, p3)))
			end
		end

		return true, nil
	end
}

function t.resolved_shared(p1, p2, p3, p4) --[[ resolved_shared | Line: 144 | Upvalues: common (copy), ecs_name (copy), t (copy) ]]
	local v1 = table.clone(common.implicitly_shared)
	local t2 = {}
	local t3 = {}

	for v2, v3 in p1:query(ecs_name):with(p2.shared):iter() do
		if v1[v3] then
			common.log_error((("detected two components with the same %* name: (%*, %*)"):format(v3, v1[v3], v2)))
		end

		v1[v3] = v2
	end

	for v4 in p1:query(p2.shared):without(ecs_name):iter() do
		common.log_warn((("shared component: %* has no name assigned."):format(v4)))
	end

	for v5 in p3 do
		t2[v5.identifier] = v5
	end

	for v6 in p3 do
		t2[v6.identifier] = v6
	end

	t3.serdes = p4
	t3.components = t.create_shared_lookup(v1)
	t3.custom_ids = t.create_shared_lookup(t2)

	return t3
end
function t.create_components(p1, p2, p3) --[[ create_components | Line: 181 | Upvalues: relationships (copy) ]]
	local v1 = if p3 then p3 else {}

	v1.shared = p1()
	v1.networked = p2()

	if relationships then
		v1.reliable = p2()
		v1.unreliable = p2()
		v1.relation = p2()
		v1.custom = p1()
	end

	v1.custom_handler = p2()
	v1.serdes = p2()
	v1.global = p2()
	v1.__alive_tracking__ = p1()
	v1.Shared = v1.shared
	v1.Networked = v1.networked

	if relationships then
		v1.Reliable = v1.reliable
		v1.Unreliable = v1.unreliable
		v1.Relation = v1.relation
		v1.Custom = v1.custom
	end

	v1.CustomHandler = v1.custom_handler
	v1.Serdes = v1.serdes
	v1.Global = v1.global

	return v1
end
function t.add_component_names(p1, p2) --[[ add_component_names | Line: 213 | Upvalues: relationships (copy) ]]
	p2(p1.shared, "replecs.shared")

	if relationships then
		p2(p1.networked, "replecs.networked")
		p2(p1.reliable, "replecs.reliable")
		p2(p1.unreliable, "replecs.unreliable")
		p2(p1.relation, "replecs.relation")
		p2(p1.custom, "replecs.custom")
	end

	p2(p1.custom_handler, "replecs.custom_handler")
	p2(p1.serdes, "replecs.serdes")
	p2(p1.global, "replecs.global")
	p2(p1.__alive_tracking__, "replecs.__alive_tracking__")
end
function t.component_factory(p1) --[[ component_factory | Line: 230 | Upvalues: common (copy) ]]
	return function() --[[ Line: 231 | Upvalues: common (ref), p1 (copy) ]]
		return common.world_component(p1)
	end
end
function t.tag_factory(p1) --[[ tag_factory | Line: 236 | Upvalues: common (copy) ]]
	return function() --[[ Line: 237 | Upvalues: common (ref), p1 (copy) ]]
		return common.world_tag(p1)
	end
end

local t2 = {
	new = function() --[[ new | Line: 244 ]]
		return {
			offset = 0,
			buffer = buffer.create(100)
		}
	end,
	from = function(p1) --[[ from | Line: 251 ]]
		return {
			buffer = p1,
			offset = buffer.len(p1)
		}
	end,
	from_offset = function(p1, p2) --[[ from_offset | Line: 258 ]]
		return {
			buffer = p1,
			offset = p2
		}
	end,
	tryalloc = function(p1, p2) --[[ tryalloc | Line: 265 ]]
		local buffer2 = p1.buffer
		local offset = p1.offset
		local v1 = buffer.len(buffer2)

		if not (v1 < offset + p2) then
			return
		end

		local v4 = buffer.create(v1 * 1.5 ^ math.ceil((math.log((p2 + offset) / v1, 1.5))))

		buffer.copy(v4, 0, buffer2, 0)
		p1.buffer = v4
	end
}

function t2.write_buffer(p1, p2, p3, p4) --[[ write_buffer | Line: 278 | Upvalues: t2 (copy) ]]
	if p3 == nil and p4 == nil then
		t2.tryalloc(p1, buffer.len(p2))
		buffer.copy(p1.buffer, p1.offset, p2, 0, buffer.len(p2))
		p1.offset = p1.offset + buffer.len(p2)

		return
	end

	local v1 = buffer.len(p2) - (p3 or 0)
	local v2 = p4 and math.min(v1, p4) or v1

	t2.tryalloc(p1, v2)
	buffer.copy(p1.buffer, p1.offset, p2, p3 or 0, v2)
	p1.offset = p1.offset + v2
end
function t2.print(p1) --[[ print | Line: 294 ]]
	local t = {}

	t[1] = string.byte(buffer.tostring(p1.buffer), 1, -1)

	local sum = 7

	for i = 1, p1.offset do
		local v2
		local v3 = t[i]

		v2 = if v3 == 0 then 1 else math.ceil((math.log10(v3 + 1)))
		sum = sum + (v2 + 1)
	end

	local v5 = t[p1.offset + 1]

	if v5 then
		local _ = if v5 == 0 then 1 else math.ceil((math.log10(1 + v5)))
	end

	t[p1.offset + 1] = ("[%*]"):format(t[p1.offset + 1])

	if #t == 0 or p1.offset == buffer.len(p1.buffer) then
		table.insert(t, " ")
	end

	return ("Pos: %* / %*\nBuf: { %* }"):format(p1.offset, buffer.len(p1.buffer), (table.concat(t, " ")))
end
function t2.writeu8(p1, p2) --[[ writeu8 | Line: 317 | Upvalues: t2 (copy) ]]
	t2.tryalloc(p1, 1)
	buffer.writeu8(p1.buffer, p1.offset, p2)
	p1.offset = p1.offset + 1
end
function t2.writeu16(p1, p2) --[[ writeu16 | Line: 323 | Upvalues: t2 (copy) ]]
	t2.tryalloc(p1, 2)
	buffer.writeu16(p1.buffer, p1.offset, p2)
	p1.offset = p1.offset + 2
end
function t2.writeu24(p1, p2) --[[ writeu24 | Line: 328 | Upvalues: t2 (copy) ]]
	t2.tryalloc(p1, 3)
	buffer.writeu8(p1.buffer, p1.offset, p2)
	buffer.writeu16(p1.buffer, p1.offset + 1, p2 // 256)
	p1.offset = p1.offset + 3
end
function t2.writeu32(p1, p2) --[[ writeu32 | Line: 335 | Upvalues: t2 (copy) ]]
	t2.tryalloc(p1, 4)
	buffer.writeu32(p1.buffer, p1.offset, p2)
	p1.offset = p1.offset + 4
end
function t2.writeu40(p1, p2) --[[ writeu40 | Line: 341 | Upvalues: t2 (copy) ]]
	t2.tryalloc(p1, 5)
	buffer.writeu8(p1.buffer, p1.offset, p2)
	buffer.writeu32(p1.buffer, p1.offset + 1, p2 // 256)
	p1.offset = p1.offset + 5
end
function t2.writei8(p1, p2) --[[ writei8 | Line: 348 | Upvalues: t2 (copy) ]]
	t2.tryalloc(p1, 1)
	buffer.writei8(p1.buffer, p1.offset, p2)
	p1.offset = p1.offset + 1
end
function t2.writei16(p1, p2) --[[ writei16 | Line: 354 | Upvalues: t2 (copy) ]]
	t2.tryalloc(p1, 2)
	buffer.writei16(p1.buffer, p1.offset, p2)
	p1.offset = p1.offset + 2
end
function t2.writei32(p1, p2) --[[ writei32 | Line: 360 | Upvalues: t2 (copy) ]]
	t2.tryalloc(p1, 4)
	buffer.writeu32(p1.buffer, p1.offset, p2)
	p1.offset = p1.offset + 4
end
function t2.write_span(p1, p2, p3) --[[ write_span | Line: 366 | Upvalues: t2 (copy) ]]
	if p3 <= 255 then
		t2.writeu8(p1, p2)

		return
	end

	if p3 <= 65535 then
		t2.writeu16(p1, p2)

		return
	end

	if p3 <= 16777215 then
		t2.writeu24(p1, p2)

		return
	end

	if p3 <= 4294967295 then
		t2.writeu32(p1, p2)
	else
		error("span too large")
	end
end
function t2.read_buffer(p1, p2) --[[ read_buffer | Line: 380 ]]
	local v1 = buffer.create(p2)

	buffer.copy(v1, 0, p1.buffer, p1.offset - p2, p2)
	p1.offset = p1.offset - p2

	return v1
end
function t2.readu8(p1) --[[ readu8 | Line: 387 ]]
	p1.offset = p1.offset - 1

	return buffer.readu8(p1.buffer, p1.offset)
end
function t2.readu16(p1) --[[ readu16 | Line: 392 ]]
	p1.offset = p1.offset - 2

	return buffer.readu16(p1.buffer, p1.offset)
end
function t2.readu24(p1) --[[ readu24 | Line: 397 ]]
	p1.offset = p1.offset - 3

	local v1 = buffer.readu8(p1.buffer, p1.offset)

	return v1 + buffer.readu16(p1.buffer, p1.offset + 1) * 256
end
function t2.readu32(p1) --[[ readu32 | Line: 404 ]]
	p1.offset = p1.offset - 4

	return buffer.readu32(p1.buffer, p1.offset)
end
function t2.readu40(p1) --[[ readu40 | Line: 409 ]]
	p1.offset = p1.offset - 5

	local v1 = buffer.readu8(p1.buffer, p1.offset)

	return v1 + buffer.readu32(p1.buffer, p1.offset + 1) * 256
end
function t2.read_span(p1, p2) --[[ read_span | Line: 416 | Upvalues: t2 (copy) ]]
	if p2 <= 255 then
		return t2.readu8(p1)
	end

	if p2 <= 65535 then
		return t2.readu16(p1)
	end

	if p2 <= 16777215 then
		return t2.readu24(p1)
	end

	if p2 <= 4294967295 then
		return t2.readu32(p1)
	end

	error("span too large")
end
function t2.readi8(p1) --[[ readi8 | Line: 430 ]]
	p1.offset = p1.offset - 1

	return buffer.readi8(p1.buffer, p1.offset)
end
function t2.readi16(p1) --[[ readi16 | Line: 435 ]]
	p1.offset = p1.offset - 2

	return buffer.readi16(p1.buffer, p1.offset)
end
function t2.readi32(p1) --[[ readi32 | Line: 439 ]]
	p1.offset = p1.offset - 4

	return buffer.readi32(p1.buffer, p1.offset)
end
function t2.write_vlq(p1, p2) --[[ write_vlq | Line: 444 | Upvalues: t2 (copy) ]]
	local v1 = p2 // 1 % 128
	local v2 = p2 // 128 % 128
	local v3 = p2 // 16384 % 128
	local v4 = p2 // 2097152 % 128

	if v4 ~= 0 then
		t2.tryalloc(p1, 4)
		t2.writeu32(p1, v1 * 16777216 + v2 * 65536 + v3 * 256 + v4 + 128)

		return
	end

	if v3 ~= 0 then
		t2.tryalloc(p1, 3)
		t2.writeu24(p1, v1 * 65536 + v2 * 256 + v3 + 128)

		return
	end

	if v2 == 0 then
		t2.tryalloc(p1, 1)
		t2.writeu8(p1, v1 + 128)
	else
		t2.tryalloc(p1, 2)
		t2.writeu16(p1, v1 * 256 + v2 + 128)
	end
end
function t2.read_vlq(p1) --[[ read_vlq | Line: 465 | Upvalues: t2 (copy) ]]
	local v1 = t2.readu8(p1)

	if v1 >= 128 then
		return v1 - 128
	end

	local v2 = t2.readu8(p1)

	if v2 >= 128 then
		return v1 + (v2 - 128) * 128
	end

	local v3 = v1 + v2 * 128
	local v4 = t2.readu8(p1)

	if v4 >= 128 then
		return v3 + (v4 - 128) * 16384
	end

	local v5 = v3 + v4 * 16384
	local v6 = t2.readu8(p1)

	if v6 >= 128 then
		return v5 + (v6 - 128) * 2097152
	end

	error("vlq length too large")
end
function t2.close(p1) --[[ close | Line: 493 ]]
	local v1 = buffer.create(p1.offset)

	buffer.copy(v1, 0, p1.buffer, 0, p1.offset)
	p1.buffer = v1

	return v1
end
function t.print_buffer(p1) --[[ print_buffer | Line: 500 ]]
	local t = {}

	t[1] = string.byte(buffer.tostring(p1), 1, -1)

	return ("{ %*\n Buf: { %* }"):format(buffer.len(p1), (table.concat(t, " ")))
end
t.cursor = t2

local t3 = {}

t3.__index = t3
function get_entry_bit(p1) --[[ get_entry_bit | Line: 519 ]]
	return math.floor(p1 / 32), p1 % 32
end
function t3.create(p1) --[[ create | Line: 525 | Upvalues: t3 (copy) ]]
	local v1 = math.ceil(p1 / 32)

	return setmetatable({
		buffer = buffer.create(v1 * 4),
		capacity = p1,
		entries = v1
	}, t3)
end
function t3.from_set(p1, p2, p3) --[[ from_set | Line: 538 | Upvalues: t3 (copy) ]]
	local v1 = t3.create(p3 or 32)

	for v2 in p2 do
		local v3 = p1[v2]

		if v3 ~= nil then
			t3.set(v1, v3)
		end
	end

	return v1
end
function t3.expand(p1, p2) --[[ expand | Line: 550 ]]
	if p2 <= p1.capacity then
		return
	end

	local v1 = math.ceil(p2 / 32)
	local v2 = v1 * 4
	local v3 = buffer.create(v2)

	buffer.copy(v3, 0, p1.buffer, 0)

	for i = p1.entries * 4, v2 - 1 do
		buffer.writeu8(v3, i, 0)
	end

	p1.buffer = v3
	p1.capacity = p2
	p1.entries = v1
end
function t3.read(p1, p2) --[[ read | Line: 570 ]]
	if p1.entries <= p2 then
		return 0
	end

	return buffer.readu32(p1.buffer, p2 * 4)
end
function t3.write(p1, p2, p3) --[[ write | Line: 577 | Upvalues: t3 (copy) ]]
	if p1.entries <= p2 then
		t3.expand(p1, (p2 + 1) * 32)
	end

	buffer.writeu32(p1.buffer, p2 * 4, p3)
end
function t3.set(p1, p2) --[[ set | Line: 587 | Upvalues: t3 (copy) ]]
	local v1, v2, v3, v4, v5

	if p2 < 0 then
		error("Bit index cannot be negative")
	end

	v1, v2 = get_entry_bit(p2)
	v3 = t3.read(p1, v1)
	v4 = bit32.lshift(1, v2)
	v5 = bit32.bor(v3, v4)
	t3.write(p1, v1, v5)
end
function t3.get(p1, p2) --[[ get | Line: 598 | Upvalues: t3 (copy) ]]
	if p2 < 0 then
		error("Bit index cannot be negative")
	end

	local v1, v2 = get_entry_bit(p2)

	if p1.entries <= v1 then
		return false
	end

	return bit32.band(t3.read(p1, v1), (bit32.lshift(1, v2))) ~= 0
end
function t3.clear(p1, p2) --[[ clear | Line: 612 | Upvalues: t3 (copy) ]]
	if p2 < 0 then
		error("Bit index cannot be negative")
	end

	local v1, v2 = get_entry_bit(p2)

	if not (p1.entries <= v1) then
		t3.write(p1, v1, (bit32.band(t3.read(p1, v1), (bit32.bnot((bit32.lshift(1, v2)))))))
	end
end
function t3.band(p1, p2) --[[ band | Line: 630 | Upvalues: t3 (copy) ]]
	local v1 = math.max(p1.entries, p2.entries)
	local v2 = t3.create(v1 * 32)

	for i = 0, v1 - 1 do
		local v3 = t3.read(p1, i)

		t3.write(v2, i, (bit32.band(v3, (t3.read(p2, i)))))
	end

	return v2
end
function t3.bor(p1, p2) --[[ bor | Line: 643 | Upvalues: t3 (copy) ]]
	local v1 = math.max(p1.entries, p2.entries)
	local v2 = t3.create(v1 * 32)

	for i = 0, v1 - 1 do
		local v3 = t3.read(p1, i)

		t3.write(v2, i, (bit32.bor(v3, (t3.read(p2, i)))))
	end

	return v2
end
function t3.bxor(p1, p2) --[[ bxor | Line: 656 | Upvalues: t3 (copy) ]]
	local v1 = math.max(p1.entries, p2.entries)
	local v2 = t3.create(v1 * 32)

	for i = 0, v1 - 1 do
		local v3 = t3.read(p1, i)

		t3.write(v2, i, (bit32.bxor(v3, (t3.read(p2, i)))))
	end

	return v2
end
function t3.bnot(p1) --[[ bnot | Line: 669 | Upvalues: t3 (copy) ]]
	local v1 = t3.create(p1.capacity)

	for i = 0, p1.entries - 1 do
		t3.write(v1, i, (bit32.bnot((t3.read(p1, i)))))
	end

	return v1
end
function t3.clone(p1) --[[ clone | Line: 680 | Upvalues: t3 (copy) ]]
	local v1 = t3.create(p1.capacity)

	buffer.copy(v1.buffer, 0, p1.buffer, 0, p1.entries * 4)

	return v1
end
function t3.remap(p1, p2, p3, p4) --[[ remap | Line: 686 | Upvalues: t3 (copy) ]]
	local v1 = t3.create(p4 or 32)

	for v2, v3 in p3 do
		local v4 = p2[v2]

		if v4 then
			if t3.get(p1, v4) then
				t3.set(v1, v3)

				continue
			end

			t3.clear(v1, v3)
		end
	end

	return v1
end
function t3.lshift(p1, p2) --[[ lshift | Line: 702 | Upvalues: t3 (copy) ]]
	if p2 <= 0 then
		return t3.clone(p1)
	end

	local v1 = math.floor(p2 / 32)
	local v2 = p2 % 32
	local v3 = t3.create(p1.capacity + p2)

	if v2 == 0 then
		for i = 0, p1.entries - 1 do
			t3.write(v3, i + v1, (t3.read(p1, i)))
		end
	else
		local v5 = 0

		for j = 0, p1.entries - 1 do
			local v6 = t3.read(p1, j)
			local v7 = bit32.lshift(v6, v2)
			local v8 = bit32.rshift(v6, 32 - v2)

			t3.write(v3, j + v1, (bit32.bor(v7, v5)))
			v5 = v8
		end

		if v5 ~= 0 then
			t3.write(v3, p1.entries + v1, v5)
		end
	end

	return v3
end
function t3.rshift(p1, p2) --[[ rshift | Line: 736 | Upvalues: t3 (copy) ]]
	if p2 <= 0 then
		return t3.clone(p1)
	end

	local v1 = math.floor(p2 / 32)
	local v2 = p2 % 32

	if p1.entries <= v1 then
		return t3.create(32)
	end

	local v3 = t3.create(p1.capacity)

	if v2 == 0 then
		for i = v1, p1.entries - 1 do
			t3.write(v3, i - v1, (t3.read(p1, i)))
		end
	else
		for j = v1, p1.entries - 1 do
			local v5
			local v7 = bit32.rshift(t3.read(p1, j), v2)

			v5 = if j + 1 < p1.entries then t3.read(p1, j + 1) else 0
			t3.write(v3, j - v1, (bit32.bor(v7, (bit32.lshift(v5, 32 - v2)))))
		end
	end

	return v3
end

local function tobinary(p1) --[[ tobinary | Line: 773 ]]
	if p1 == 0 then
		return "0"
	end

	local v1 = ""

	while p1 > 0 do
		p1, v1 = math.floor(p1 / 2), p1 % 2 .. v1
	end

	return string.rep("0", 8 - #v1) .. v1
end

local v1 = table.create(6)

function t3.tostring(p1) --[[ tostring | Line: 788 | Upvalues: v1 (copy), tobinary (copy) ]]
	local buffer2 = p1.buffer
	local v12 = -1

	for i = p1.entries - 1, 0, -1 do
		if buffer.readu32(buffer2, i * 4) ~= 0 then
			v12 = i

			break
		end
	end

	if v12 == -1 then
		return ""
	end

	table.clear(v1)

	local v2 = ""

	for j = 0, v12 do
		v2 = v2 .. tobinary((buffer.readu32(buffer2, j * 4)))
	end

	return v2
end
t.bitmask = {
	create = t3.create,
	from_set = t3.from_set
}
function t.is_client_valid(p1) --[[ is_client_valid | Line: 820 ]]
	if not game then
		return true
	end

	if typeof(p1) ~= "Instance" then
		return false
	end

	return if p1.ClassName == "Player" then p1:IsDescendantOf(game:GetService("Players")) else false
end
function t.vlq_span(p1) --[[ vlq_span | Line: 831 ]]
	if p1 < 128 then
		return 1
	end

	if p1 < 16384 then
		return 2
	end

	if p1 < 2097152 then
		return 3
	end

	return 4
end
function t.number_span(p1) --[[ number_span | Line: 843 ]]
	if p1 <= 255 then
		return 1
	end

	if p1 <= 65535 then
		return 2
	end

	return 4
end
function t.read_number(p1, p2, p3) --[[ read_number | Line: 853 ]]
	if p3 == 1 then
		return buffer.readu8(p1, p2), p2 + 1
	end

	if p3 == 2 then
		return buffer.readu16(p1, p2), p2 + 2
	end

	return buffer.readu32(p1, p2), p2 + 4
end
function t.setbit(p1, p2) --[[ setbit | Line: 863 ]]
	return bit32.bor(p1, (bit32.lshift(1, p2)))
end
function t.checkbit(p1, p2) --[[ checkbit | Line: 866 ]]
	return bit32.band(p1, (bit32.lshift(1, p2))) ~= 0
end

return t