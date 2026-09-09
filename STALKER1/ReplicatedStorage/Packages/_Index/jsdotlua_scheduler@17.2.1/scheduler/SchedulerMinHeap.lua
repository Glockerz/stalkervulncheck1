-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local v1 = nil
local v2 = nil
local v3 = nil

function t.push(p1, p2) --[[ Line: 22 | Upvalues: v2 (ref) ]]
	local v1 = #p1 + 1

	p1[v1] = p2
	v2(p1, p2, v1)
end
function t.peek(p1) --[[ Line: 29 ]]
	return p1[1]
end
function t.pop(p1) --[[ Line: 33 | Upvalues: v3 (ref) ]]
	local v1 = p1[1]

	if v1 == nil then
		return nil
	end

	local v2 = p1[#p1]

	p1[#p1] = nil

	if v2 == v1 then
		return v1
	end

	p1[1] = v2
	v3(p1, v2, 1)

	return v1
end
v2 = function(p1, p2, p3) --[[ Line: 49 | Upvalues: v1 (ref) ]]
	while true do
		local v12 = math.floor(p3 / 2)
		local v2 = p1[v12]

		if v2 == nil or not (v1(v2, p2) > 0) then
			break
		end

		p1[v12] = p2
		p1[p3] = v2
		p3 = v12
	end
end
v3 = function(p1, p2, p3) --[[ Line: 65 | Upvalues: v1 (ref) ]]
	while p3 < #p1 do
		local v2 = p3 * 2
		local v3 = p1[v2]
		local v4 = v2 + 1
		local v5 = p1[v4]

		if v3 == nil or not (v1(v3, p2) < 0) then
			if v5 == nil or not (v1(v5, p2) < 0) then
				break
			end
		elseif v5 == nil or not (v1(v5, v3) < 0) then
			p1[p3] = v3
			p1[v2] = p2
			p3 = v2

			continue
		end

		p1[p3] = v5
		p1[v4] = p2
		p3 = v4
	end
end
v1 = function(p1, p2) --[[ Line: 95 ]]
	local v1 = p1.sortIndex - p2.sortIndex

	if v1 == 0 then
		return p1.id - p2.id
	end

	return v1
end

return t