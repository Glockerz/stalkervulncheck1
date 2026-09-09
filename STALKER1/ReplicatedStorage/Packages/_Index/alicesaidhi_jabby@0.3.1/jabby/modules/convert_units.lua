-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ convert_units | Line: 1 ]]
	local v1 = math.sign(p2)
	local v3, count, v4 = math.abs(p2), 0, {
		[4] = "T",
		[3] = "G",
		[2] = "M",
		[1] = "k",
		[0] = " ",
		[-1] = "m",
		[-2] = "u",
		[-3] = "n",
		[-4] = "p"
	}

	while v3 >= 1000 do
		v3 = v3 / 1000
		count = count + 1
	end

	while v3 ~= 0 and v3 < 1 do
		v3 = v3 * 1000
		count = count - 1
	end

	if v3 >= 100 then
		v3 = math.floor(v3)
	elseif v3 >= 10 then
		v3 = math.floor(v3 * 10) / 10
	elseif v3 >= 1 then
		v3 = math.floor(v3 * 100) / 100
	end

	return v3 * v1 .. v4[count] .. p1
end