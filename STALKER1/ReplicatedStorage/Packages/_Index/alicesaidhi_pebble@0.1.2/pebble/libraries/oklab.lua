-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function cbrt(p1) --[[ cbrt | Line: 11 ]]
	return math.sign(p1) * math.abs(p1) ^ 0.3333333333333333
end

local t = {
	linear_srgb_to_oklab = function(p1) --[[ linear_srgb_to_oklab | Line: 17 ]]
		local v1 = p1.X * 0.4122214708 + p1.Y * 0.5363325363 + p1.Z * 0.0514459929
		local v2 = p1.X * 0.2119034982 + p1.Y * 0.6806995451 + p1.Z * 0.1073969566
		local v3 = p1.X * 0.0883024619 + p1.Y * 0.2817188376 + p1.Z * 0.6299787005
		local v4 = math.sign(v1) * math.abs(v1) ^ 0.3333333333333333
		local v5 = math.sign(v2) * math.abs(v2) ^ 0.3333333333333333
		local v6 = math.sign(v3) * math.abs(v3) ^ 0.3333333333333333

		return Vector3.new(0.2104542553 * v4 + 0.793617785 * v5 - 0.0040720468 * v6, 1.9779984951 * v4 - 2.428592205 * v5 + 0.4505937099 * v6, 0.0259040371 * v4 + 0.7827717662 * v5 - 0.808675766 * v6)
	end,
	oklab_to_linear_srgb = function(p1) --[[ oklab_to_linear_srgb | Line: 35 ]]
		local v1 = p1.X + p1.Y * 0.3963377774 + p1.Z * 0.2158037573
		local v2 = p1.X - p1.Y * 0.1055613458 - p1.Z * 0.0638541728
		local v3 = p1.X - p1.Y * 0.0894841775 - p1.Z * 1.291485548
		local v4 = v1 * v1 * v1
		local v5 = v2 * v2 * v2
		local v6 = v3 * v3 * v3

		return Vector3.new(v4 * 4.0767416621 - v5 * 3.3077115913 + v6 * 0.2309699292, v4 * -1.2684380046 + v5 * 2.6097574011 - v6 * 0.3413193965, v4 * -0.0041960863 - v5 * 0.7034186147 + v6 * 1.707614701)
	end,
	compute_max_saturation = function(p1, p2) --[[ compute_max_saturation | Line: 56 ]]
		local v1, v2, v3, v4, v5, v6, v7, v8

		if p1 * -1.88170328 - p2 * 0.80936493 > 1 then
			v1 = -3.3077115913
			v2 = 0.2309699292
			v3 = 1.76576728
			v4 = 1.19086277
			v5 = 0.59662641
			v6 = 0.75515197
			v7 = 0.56771245
			v8 = 4.0767416621
		elseif p1 * 1.81444104 - p2 * 1.19445276 > 1 then
			v1 = 2.6097574011
			v2 = -0.3413193965
			v3 = -0.45954404
			v4 = 0.73956515
			v5 = 0.08285427
			v6 = 0.1254107
			v7 = 0.14503204
			v8 = -1.2684380046
		else
			v1 = -0.7034186147
			v2 = 1.707614701
			v3 = -0.00915799
			v4 = 1.35733652
			v5 = -1.1513021
			v6 = -0.50559606
			v7 = 0.00692167
			v8 = -0.0041960863
		end

		local v9 = v4 + v3 * p1 + v5 * p2 + v6 * p1 * p1 + v7 * p1 * p2
		local v10 = p1 * 0.3963377774 + p2 * 0.2158037573
		local v11 = p1 * -0.1055613458 - p2 * 0.0638541728
		local v12 = p1 * -0.0894841775 - p2 * 1.291485548
		local v13 = 1 + v9 * v10
		local v14 = 1 + v9 * v11
		local v15 = 1 + v9 * v12
		local v16 = v8 * (v13 * v13 * v13) + v1 * (v14 * v14 * v14) + v2 * (v15 * v15 * v15)
		local v17 = v8 * (v10 * 3 * v13 * v13) + v1 * (v11 * 3 * v14 * v14) + v2 * (v12 * 3 * v15 * v15)

		return v9 - v16 * v17 / (v17 * v17 - 0.5 * v16 * (v8 * (v10 * 6 * v10 * v13) + v1 * (v11 * 6 * v11 * v14) + v2 * (v12 * 6 * v12 * v15)))
	end
}

function t.find_cusp(p1, p2) --[[ find_cusp | Line: 118 | Upvalues: t (copy) ]]
	local v1 = t.compute_max_saturation(p1, p2)
	local v2 = t.oklab_to_linear_srgb((Vector3.new(1, v1 * p1, v1 * p2)))
	local v3 = 1 / math.max(v2.X, v2.Y, v2.Z)
	local v4 = math.sign(v3) * math.abs(v3) ^ 0.3333333333333333

	return v4, v4 * v1
end
function t.find_gamut_intersection(p1, p2, p3, p4, p5) --[[ find_gamut_intersection | Line: 137 | Upvalues: t (copy) ]]
	local v1, v2 = t.find_cusp(p1, p2)

	if (p3 - p5) * v2 - (v1 - p5) * p4 <= 0 then
		return v2 * p5 / (p4 * v1 + v2 * (p5 - p3))
	end

	local v3 = v2 * (p5 - 1) / (p4 * (v1 - 1) + v2 * (p5 - p3))
	local v4 = p3 - p5
	local v5 = p1 * 0.3963377774 + p2 * 0.2158037573
	local v6 = p1 * -0.1055613458 - p2 * 0.0638541728
	local v7 = p1 * -0.0894841775 - p2 * 1.291485548
	local v8 = v4 + p4 * v5
	local v9 = v4 + p4 * v6
	local v10 = v4 + p4 * v7
	local v11 = p5 * (1 - v3) + v3 * p3
	local v12 = v3 * p4
	local v13 = v11 + v12 * v5
	local v14 = v11 + v12 * v6
	local v15 = v11 + v12 * v7
	local v16 = v13 * v13 * v13
	local v17 = v14 * v14 * v14
	local v18 = v15 * v15 * v15
	local v19 = v8 * 3 * v13 * v13
	local v20 = v9 * 3 * v14 * v14
	local v21 = v10 * 3 * v15 * v15
	local v22 = v8 * 6 * v8 * v13
	local v23 = v9 * 6 * v9 * v14
	local v24 = v10 * 6 * v10 * v15
	local v25 = 4.0767416621 * v16 - 3.3077115913 * v17 + 0.2309699292 * v18 - 1
	local v26 = 4.0767416621 * v19 - 3.3077115913 * v20 + 0.2309699292 * v21
	local v27 = v26 / (v26 * v26 - 0.5 * v25 * (4.0767416621 * v22 - 3.3077115913 * v23 + 0.2309699292 * v24))
	local v28 = -1.2684380046 * v16 + 2.6097574011 * v17 - 0.3413193965 * v18 - 1
	local v29 = -1.2684380046 * v19 + 2.6097574011 * v20 - 0.3413193965 * v21
	local v30 = v29 / (v29 * v29 - 0.5 * v28 * (-1.2684380046 * v22 + 2.6097574011 * v23 - 0.3413193965 * v24))
	local v31 = -v28 * v30
	local v32 = -0.0041960863 * v16 - 0.7034186147 * v17 + 1.707614701 * v18 - 1
	local v33 = -0.0041960863 * v19 - 0.7034186147 * v20 + 1.707614701 * v21
	local v34 = v33 / (v33 * v33 - 0.5 * v32 * (-0.0041960863 * v22 - 0.7034186147 * v23 + 1.707614701 * v24))
	local v35 = -v32 * v34

	if not (v30 >= 0) then
		v31 = (1 / 0)
	end

	if not (v34 >= 0) then
		v35 = (1 / 0)
	end

	return v3 + math.min(if v27 >= 0 then -v25 * v27 else (1 / 0), v31, v35)
end
function t.gamut_clip_preserve_chroma(p1) --[[ gamut_clip_preserve_chroma | Line: 224 | Upvalues: t (copy) ]]
	if p1.X <= 1 and (p1.Y <= 1 and (p1.Z <= 1 and (p1.X >= 0 and (p1.Y >= 0 and p1.Z >= 0)))) then
		return p1
	end

	local v1 = t.linear_srgb_to_oklab(p1)
	local X = v1.X
	local v4 = math.max(0.00001, (math.sqrt(v1.Y * v1.Y + v1.Z * v1.Z)))
	local v5 = if v4 == 0 then 0 else v1.Y / v4
	local v6 = if v4 == 0 then 0 else v1.Z / v4
	local v7 = math.clamp(X, 0, 1)
	local v8 = t.find_gamut_intersection(v5, v6, X, v4, v7)
	local v9 = v8 * v4

	return t.oklab_to_linear_srgb((Vector3.new(v7 * (1 - v8) + v8 * X, v9 * v5, v9 * v6)))
end
function t.gamut_clip_project_to_0_5(p1) --[[ gamut_clip_project_to_0_5 | Line: 247 | Upvalues: t (copy) ]]
	if p1.X <= 1 and (p1.Y <= 1 and (p1.Z <= 1 and (p1.X >= 0 and (p1.Y >= 0 and p1.Z >= 0)))) then
		return p1
	end

	local v1 = t.linear_srgb_to_oklab(p1)
	local X = v1.X
	local v4 = math.max(0.00001, (math.sqrt(v1.Y * v1.Y + v1.Z * v1.Z)))
	local v5 = v1.Y / v4
	local v6 = v1.Z / v4
	local v7 = t.find_gamut_intersection(v5, v6, X, v4, 0.5)
	local v8 = v7 * v4

	return t.oklab_to_linear_srgb((Vector3.new(0.5 * (1 - v7) + v7 * X, v8 * v5, v8 * v6)))
end
function t.gamut_clip_project_to_L_cusp(p1) --[[ gamut_clip_project_to_L_cusp | Line: 271 | Upvalues: t (copy) ]]
	if p1.X <= 1 and (p1.Y <= 1 and (p1.Z <= 1 and (p1.X >= 0 and (p1.Y >= 0 and p1.Z >= 0)))) then
		return p1
	end

	local v1 = t.linear_srgb_to_oklab(p1)
	local X = v1.X
	local v4 = math.max(0.00001, (math.sqrt(v1.Y * v1.Y + v1.Z * v1.Z)))
	local v5 = v1.Y / v4
	local v6 = v1.Z / v4
	local v7, _ = t.find_cusp(v5, v6)
	local v8 = t.find_gamut_intersection(v5, v6, X, v4, v7)
	local v9 = v8 * v4

	return t.oklab_to_linear_srgb((Vector3.new(v7 * (1 - v8) + v8 * X, v9 * v5, v9 * v6)))
end
function t.gamut_clip_adaptive_L0_0_5(p1, p2) --[[ gamut_clip_adaptive_L0_0_5 | Line: 299 | Upvalues: t (copy) ]]
	if p1.X <= 1 and (p1.Y <= 1 and (p1.Z <= 1 and (p1.X >= 0 and (p1.Y >= 0 and p1.Z >= 0)))) then
		return p1
	end

	local v1 = t.linear_srgb_to_oklab(p1)
	local X = v1.X
	local v4 = math.max(0.00001, (math.sqrt(v1.Y * v1.Y + v1.Z * v1.Z)))
	local v5 = v1.Y / v4
	local v6 = v1.Z / v4
	local v7 = X - 0.5
	local v8 = math.abs(v7) + 0.5 + (p2 or 0.05) * v4
	local v9 = math.sign(v7)
	local v11 = 0.5 * (1 + v9 * (v8 - math.sqrt(v8 * v8 - math.abs(v7) * 2)))
	local v12 = t.find_gamut_intersection(v5, v6, X, v4, v11)
	local v13 = v12 * v4

	return t.oklab_to_linear_srgb((Vector3.new(v11 * (1 - v12) + v12 * X, v13 * v5, v13 * v6)))
end
function t.gamut_clip_adaptive_L0_L_cusp(p1, p2) --[[ gamut_clip_adaptive_L0_L_cusp | Line: 327 | Upvalues: t (copy) ]]
	if p1.X < 1 and (p1.Y < 1 and (p1.Z < 1 and (p1.X > 0 and (p1.Y > 0 and p1.Z > 0)))) then
		return p1
	end

	local v2 = t.linear_srgb_to_oklab(p1)
	local X = v2.X
	local v5 = math.max(0.00001, (math.sqrt(v2.Y * v2.Y + v2.Z * v2.Z)))
	local v6 = v2.Y / v5
	local v7 = v2.Z / v5
	local v8, _ = t.find_cusp(v6, v7)
	local v9 = X - v8
	local v12 = 2 * (if v9 > 0 then 1 - v8 else v8)
	local v13 = 0.5 * v12 + math.abs(v9) + (p2 or 0.05) * v5 / v12
	local v14 = math.sign(v9)
	local v16 = v8 + 0.5 * (v14 * (v13 - math.sqrt(v13 * v13 - 2 * v12 * math.abs(v9))))
	local v17 = t.find_gamut_intersection(v6, v7, X, v5, v16)
	local v18 = v17 * v5

	return t.oklab_to_linear_srgb((Vector3.new(v16 * (1 - v17) + v17 * X, v18 * v6, v18 * v7)))
end
t.default_gamut_clip = t.gamut_clip_adaptive_L0_0_5

local function component_to_gamma(p1) --[[ component_to_gamma | Line: 366 ]]
	if p1 >= 0.0031308 then
		return p1 ^ 0.4166666666666667 * 1.055 - 0.055
	end

	return p1 * 12.92
end

local function component_to_linear(p1) --[[ component_to_linear | Line: 374 ]]
	if p1 >= 0.04045 then
		return ((p1 + 0.055) / 1.055) ^ 2.4
	end

	return p1 / 12.92
end

function t.color3_to_linear_srgb(p1) --[[ color3_to_linear_srgb | Line: 382 ]]
	local R = p1.R
	local G = p1.G
	local B = p1.B

	return Vector3.new(if R >= 0.04045 then ((R + 0.055) / 1.055) ^ 2.4 else R / 12.92, if G >= 0.04045 then ((G + 0.055) / 1.055) ^ 2.4 else G / 12.92, if B >= 0.04045 then ((B + 0.055) / 1.055) ^ 2.4 else B / 12.92)
end
function t.linear_srgb_to_color3(p1, p2) --[[ linear_srgb_to_color3 | Line: 392 | Upvalues: t (copy) ]]
	if p2 == false then
		local v1 = Color3.new
		local X = p1.X
		local Y = p1.Y
		local Z = p1.Z

		return v1(if X >= 0.0031308 then X ^ 0.4166666666666667 * 1.055 - 0.055 else X * 12.92, if Y >= 0.0031308 then Y ^ 0.4166666666666667 * 1.055 - 0.055 else Y * 12.92, if Z >= 0.0031308 then Z ^ 0.4166666666666667 * 1.055 - 0.055 else Z * 12.92)
	end

	local v5 = t.default_gamut_clip(p1)
	local v6 = Color3.new
	local X = v5.X
	local v8 = math.clamp(if X >= 0.0031308 then X ^ 0.4166666666666667 * 1.055 - 0.055 else X * 12.92, 0, 1)
	local Y = v5.Y
	local v10 = math.clamp(if Y >= 0.0031308 then Y ^ 0.4166666666666667 * 1.055 - 0.055 else Y * 12.92, 0, 1)
	local Z = v5.Z

	return v6(v8, v10, (math.clamp(if Z >= 0.0031308 then Z ^ 0.4166666666666667 * 1.055 - 0.055 else Z * 12.92, 0, 1)))
end
function t.oklch_to_oklab(p1) --[[ oklch_to_oklab | Line: 418 ]]
	return Vector3.new(p1.X, p1.Y * math.cos(p1.Z * 6.283185307179586), p1.Y * math.sin(p1.Z * 6.283185307179586))
end
function t.oklab_to_oklch(p1) --[[ oklab_to_oklch | Line: 426 ]]
	return Vector3.new(p1.X, math.sqrt(p1.Y ^ 2 + p1.Z ^ 2), math.atan2(p1.Z, p1.Y) / 6.283185307179586 % 1)
end

return t