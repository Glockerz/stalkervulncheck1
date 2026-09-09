-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent:WaitForChild("utils"))

local t = {}

t.__index = t
function t.track(p1, p2) --[[ track | Line: 34 ]]
	table.insert(p1.tracking, p2)
	p2:mark_as_tracked(p1)
end
function t.mark_as_tracked(p1, p2) --[[ mark_as_tracked | Line: 39 ]]
	table.insert(p1.tracked_by, p2)
	p1.tracked_indexes[p2] = #p1.tracked_by
end
function t.unmark_tracked(p1, p2) --[[ unmark_tracked | Line: 44 ]]
	local v1 = p1.tracked_indexes[p2]

	if not v1 then
		return
	end

	local v2 = table.remove(p1.tracked_by)

	if v2 and v2 ~= p2 then
		p1.tracked_by[v1] = v2
		p1.tracked_indexes[v2] = v1
	end

	p1.tracked_indexes[p2] = nil
end
function t.run_subscribed(p1) --[[ run_subscribed | Line: 58 ]]
	if not p1.subscribed then
		return
	end

	p1.subscribed(p1)
end
function t.compute(p1) --[[ compute | Line: 64 ]]
	if p1.compute_callback then
		p1.result = p1.compute_callback(p1)
	end

	if p1.subscribed then
		p1.subscribed(p1)
	end

	for v1, v2 in p1.tracked_by do
		v2:compute()
	end
end
function t.destroy(p1) --[[ destroy | Line: 78 ]]
	for v1, v2 in p1.tracking do
		v2:unmark_tracked(p1)
	end
end
function create(p1, p2) --[[ create | Line: 84 | Upvalues: t (copy) ]]
	local t2 = {
		bitmask = p1
	}

	t2.result = if p2 then p2(t2) else p1
	t2.compute_callback = p2
	t2.subscribed = nil
	t2.tracking = {}
	t2.tracked_by = {}
	t2.tracked_indexes = {}

	return setmetatable(t2, t)
end
function follow(p1) --[[ follow | Line: 98 ]]
	local v1 = create(p1.result, function() --[[ Line: 99 | Upvalues: p1 (copy) ]]
		return p1.result
	end)

	v1:track(p1)

	return v1
end

return {
	create = create,
	follow = follow
}