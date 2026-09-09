-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.vide)
local apcaw3 = require(script.Parent.Parent.libraries.apcaw3)
local oklch = require(script.Parent.oklch)
local derive = vide.derive
local read = vide.read

local function min_contrast(p1) --[[ min_contrast | Line: 8 | Upvalues: derive (copy), read (copy) ]]
	local size = p1.size
	local v1 = p1.weight or 400
	local body = p1.body

	if not (size or v1) then
		return 0
	end

	local t = {
		[12] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0)
		},
		[14] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			100,
			100,
			90,
			75,
			(1 / 0),
			(1 / 0)
		},
		[15] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			100,
			90,
			75,
			70,
			(1 / 0),
			(1 / 0)
		},
		[16] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			90,
			75,
			70,
			60,
			60,
			(1 / 0)
		},
		[18] = {
			(1 / 0),
			(1 / 0),
			100,
			75,
			70,
			60,
			55,
			55,
			55
		},
		[21] = {
			(1 / 0),
			(1 / 0),
			90,
			70,
			60,
			55,
			50,
			50,
			50
		},
		[24] = {
			(1 / 0),
			(1 / 0),
			75,
			60,
			55,
			50,
			45,
			45,
			55
		},
		[28] = {
			(1 / 0),
			100,
			70,
			55,
			50,
			45,
			43,
			43,
			43
		},
		[32] = {
			(1 / 0),
			90,
			65,
			50,
			45,
			43,
			40,
			40,
			40
		},
		[36] = {
			(1 / 0),
			75,
			60,
			45,
			43,
			40,
			38,
			38,
			38
		},
		[42] = {
			100,
			70,
			55,
			43,
			40,
			38,
			35,
			35,
			35
		},
		[48] = {
			90,
			60,
			50,
			40,
			38,
			35,
			33,
			33,
			33
		},
		[60] = {
			75,
			55,
			45,
			37,
			35,
			33,
			30,
			30,
			30
		},
		[72] = {
			60,
			50,
			40,
			35,
			33,
			30,
			30,
			30,
			30
		},
		[96] = {
			50,
			45,
			35,
			33,
			30,
			30,
			30,
			30,
			30
		}
	}
	local t2 = {
		[12] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0)
		},
		[14] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			100,
			100,
			90,
			75,
			(1 / 0),
			(1 / 0)
		},
		[15] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			100,
			90,
			90,
			85,
			(1 / 0),
			(1 / 0)
		},
		[16] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			90,
			75,
			85,
			75,
			(1 / 0),
			(1 / 0)
		},
		[18] = {
			(1 / 0),
			(1 / 0),
			100,
			75,
			85,
			75,
			70,
			(1 / 0),
			(1 / 0)
		},
		[21] = {
			(1 / 0),
			(1 / 0),
			90,
			70,
			75,
			70,
			65,
			(1 / 0),
			(1 / 0)
		},
		[24] = {
			(1 / 0),
			(1 / 0),
			75,
			75,
			70,
			65,
			60,
			(1 / 0),
			(1 / 0)
		},
		[28] = {
			(1 / 0),
			(1 / 0),
			85,
			70,
			65,
			60,
			58,
			(1 / 0),
			(1 / 0)
		},
		[32] = {
			(1 / 0),
			(1 / 0),
			80,
			65,
			60,
			58,
			55,
			(1 / 0),
			(1 / 0)
		},
		[36] = {
			(1 / 0),
			(1 / 0),
			75,
			60,
			58,
			55,
			52,
			(1 / 0),
			(1 / 0)
		},
		[42] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0)
		},
		[48] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0)
		},
		[60] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0)
		},
		[72] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0)
		},
		[96] = {
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0),
			(1 / 0)
		}
	}

	return derive(function() --[[ Line: 56 | Upvalues: read (ref), body (copy), t2 (copy), t (copy), size (copy), v1 (copy) ]]
		local v12 = if read(body) then t2 else t
		local v2 = v12[read(size)]

		if not v2 then
			return (1 / 0)
		end

		local v3 = read(v1)
		local v4 = 400

		if type(v3) == "number" then
			v4 = v3
		elseif typeof(v3) == "Font" then
			v4 = v3.Weight.Value
		end

		return v2[v4 // 100] or (1 / 0)
	end)
end

local function unwrap(p1) --[[ unwrap | Line: 80 ]]
	while type(p1) == "function" do
		p1 = p1()
	end

	return p1
end

return {
	min_contrast = min_contrast,
	get_appropriate_color = function(p1) --[[ get_appropriate_color | Line: 93 | Upvalues: oklch (copy), apcaw3 (copy) ]]
		return function() --[[ Line: 100 | Upvalues: p1 (copy), oklch (ref), apcaw3 (ref) ]]
			local min_contrast = p1.min_contrast

			while type(min_contrast) == "function" do
				min_contrast = min_contrast()
			end

			local elevation = p1.elevation
			local v2 = min_contrast

			while type(elevation) == "function" do
				elevation = elevation()
			end

			local v4 = elevation or 0
			local background = p1.background

			while type(background) == "function" do
				background = background()
			end

			if background == nil then
				local foreground = p1.foreground

				while type(foreground) == "function" do
					foreground = foreground()
				end

				local v7 = foreground[1]
				local v8, v9, v10 = unpack(v7, 1, 3)
				local v11, v12, v13 = unpack(v7, 4, 6)

				return oklch(v8 + v4 * (v11 or 0), v9 + v4 * (v12 or 0), v10 + v4 * (v13 or 0))
			end

			if v2 == (1 / 0) then
				warn("min contrast is invalid")
			end

			local v14 = Color3.new()
			local foreground = p1.foreground

			v15 = background
			v16 = -1

			while type(foreground) == "function" do
				foreground = foreground()
			end

			for v18, v19 in foreground do
				local v20, v21, v22 = unpack(v19, 1, 3)
				local v23, v24, v25 = unpack(v19, 4, 6)
				local v26 = oklch(v20 + v4 * (v23 or 0), v21 + v4 * (v24 or 0), v22 + v4 * (v25 or 0))
				local v28 = math.abs((apcaw3.calcAPCA(v26, background, nil, 1, true)))

				if v16 < v28 then
					v16 = v28
					v14 = v26
				end

				if v2 <= v28 then
					return v26
				end
			end

			return v14
		end
	end
}