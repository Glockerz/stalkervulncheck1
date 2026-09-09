-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	mainTRC = 2.4,
	mainTRCencode = 0.4166666666666667,
	sRco = 0.2126729,
	sGco = 0.7151522,
	sBco = 0.072175,
	normBG = 0.56,
	normTXT = 0.57,
	revTXT = 0.62,
	revBG = 0.65,
	blkThrs = 0.022,
	blkClmp = 1.414,
	scaleBoW = 1.14,
	scaleWoB = 1.14,
	loBoWoffset = 0.027,
	loWoBoffset = 0.027,
	deltaYmin = 0.0005,
	loClip = 0.1,
	mFactor = 1.9468554433171,
	mFactInv = 0.5136488193988227,
	mOffsetIn = 0.0387393816571401,
	mExpAdj = 0.283343396420869,
	mExp = 0.20038429732734725,
	mOffsetOut = 0.312865795870758
}

local function isNaN(p1) --[[ isNaN | Line: 27 ]]
	return p1 ~= p1
end

local function reverseAPCA(p1, p2, p3, p4) --[[ reverseAPCA | Line: 31 ]]
	if p1 == nil then
		p1 = 0
	end

	if p2 == nil then
		p2 = 1
	end

	if p3 == nil then
		p3 = "bg"
	end

	if p4 == nil then
		p4 = "hex"
	end

	if math.abs(p1) < 9 then
		return false
	end

	local v4 = (assert((tonumber(p1))) * 0.01 + (if p1 > 0 then 0.027 else -0.027)) / 1.14

	if not (p2 > 0.022) then
		p2 = p2 + math.pow(0.022 - p2, 1.414)
	end

	local v5

	if p3 == "bg" or p3 == "background" then
		local v9 = math.pow(math.pow(p2, if v4 > 0 then 0.56 else 0.65) - v4, 1 / (if v4 > 0 then 0.57 else 0.62))

		if if v9 == v9 then false else true then
			return false
		end

		v5 = v9
	else
		if p3 ~= "txt" and p3 ~= "text" then
			return false
		end

		local v14 = math.pow(v4 + math.pow(p2, if v4 > 0 then 0.57 else 0.62), 1 / (if v4 > 0 then 0.56 else 0.65))

		if if v14 == v14 then false else true then
			return false
		end

		v5 = v14
	end

	if v5 > 1.06 or v5 < 0 then
		return false
	end

	if not (v5 > 0.022) then
		v5 = math.pow((v5 + 0.0387393816571401) * 1.9468554433171, 0.20038429732734725) * 0.5136488193988227 - 0.312865795870758
	end

	local v17 = math.max(math.min(v5, 1), 0)

	if p4 == "color" then
		local v19 = math.round(math.pow(v17, 0.4166666666666667) * 255)

		return {
			v19,
			v19,
			v19,
			1,
			if p3 == "bg" then "txtColor" else "bgColor"
		}
	end

	if p4 == "Y" or p4 == "y" then
		return math.max(0, v17)
	end

	return false
end

local function sRGBtoY(p1) --[[ sRGBtoY | Line: 95 | Upvalues: t (copy) ]]
	local function simpleExp(p1) --[[ simpleExp | Line: 100 ]]
		return math.pow(p1, 2.4)
	end

	local v1 = 0.2126729 * math.pow(p1.R, t.mainTRC)
	local v2 = v1 + 0.7151522 * math.pow(p1.G, t.mainTRC)

	return v2 + 0.072175 * math.pow(p1.B, t.mainTRC)
end

local function displayP3toY(p1) --[[ displayP3toY | Line: 107 ]]
	local function simpleExp(p1) --[[ simpleExp | Line: 111 ]]
		return math.pow(p1, 2.4)
	end

	local v1 = 0.228982959480578 * math.pow(p1.R, 2.4)
	local v2 = v1 + 0.691749262585238 * math.pow(p1.G, 2.4)

	return v2 + 0.0792677779341829 * math.pow(p1.B, 2.4)
end

local function adobeRGBtoY(p1) --[[ adobeRGBtoY | Line: 118 ]]
	local function simpleExp(p1) --[[ simpleExp | Line: 125 ]]
		return math.pow(p1 / 255, 2.35)
	end

	local v2 = 0.297355022711381 * math.pow(p1.R / 255, 2.35)
	local v4 = v2 + 0.627372749714528 * math.pow(p1.G / 255, 2.35)

	return v4 + 0.0752722275740913 * math.pow(p1.B / 255, 2.35)
end

local function APCAcontrast(p1, p2, p3) --[[ APCAcontrast | Line: 133 ]]
	local v1 = p3 or -1
	local t = { 0, 1.1 }

	if math.min(p1, p2) < t[1] or math.max(p1, p2) > t[2] then
		return 0
	end

	local v2 = if p1 > 0.022 then p1 else p1 + math.pow(0.022 - p1, 1.414)
	local v3, v4

	if p2 > 0.022 then
		v3 = p2
		v4 = v2
	else
		v3 = p2 + math.pow(0.022 - p2, 1.414)
		v4 = v2
	end

	if math.abs(v3 - v4) < 0.0005 then
		return 0
	end

	local v5

	if v4 < v3 then
		local v6 = (math.pow(v3, 0.56) - math.pow(v4, 0.57)) * 1.14

		v5 = if v6 < 0.1 then 0 else v6 - 0.027
	else
		local v8 = (math.pow(v3, 0.65) - math.pow(v4, 0.62)) * 1.14

		v5 = if v8 > -0.1 then 0 else v8 + 0.027
	end

	if v1 < 0 then
		return v5 * 100
	end

	if v1 == 0 then
		return math.round(math.abs(v5) * 100)
	end

	if v1 // 1 == v1 then
		return v5 * 100 * v1 // 1 / v1
	end

	return 0
end

local function alphaBlend(p1, p2, p3, p4) --[[ alphaBlend | Line: 177 ]]
	if p4 == nil then
		p4 = true
	end

	local v1 = p2 or 1
	local v2 = 1 - v1
	local t = {
		0,
		0,
		0,
		p3.R * v2 + p1.R * v1
	}

	if p4 then
		t[1] = math.min(math.round(t[1]), 255)
	end

	t[2] = p3.G * v2 + p1.G * v1

	if p4 then
		t[2] = math.min(math.round(t[2]), 255)
	end

	t[3] = p3.B * v2 + p1.B * v1

	if p4 then
		t[3] = math.min(math.round(t[3]), 255)
	end

	return Color3.new(t[1], t[2], t[3])
end

return {
	APCAcontrast = APCAcontrast,
	reverseAPCA = reverseAPCA,
	calcAPCA = function(p1, p2, p3, p4, p5) --[[ calcAPCA | Line: 194 | Upvalues: alphaBlend (copy), APCAcontrast (copy), sRGBtoY (copy) ]]
		if p3 then
			p1 = alphaBlend(p1, p3, p2, p5)
		end

		return APCAcontrast(sRGBtoY(p1), sRGBtoY(p2), -1)
	end,
	fontLookupAPCA = function(p1, p2) --[[ fontLookupAPCA | Line: 203 ]]
		local v1 = p2 or 2
		local t = {
			{
				"Lc",
				100,
				200,
				300,
				400,
				500,
				600,
				700,
				800,
				900
			},
			{
				0,
				999,
				999,
				999,
				999,
				999,
				999,
				999,
				999,
				999
			},
			{
				10,
				999,
				999,
				999,
				999,
				999,
				999,
				999,
				999,
				999
			},
			{
				15,
				777,
				777,
				777,
				777,
				777,
				777,
				777,
				777,
				777
			},
			{
				20,
				777,
				777,
				777,
				777,
				777,
				777,
				777,
				777,
				777
			},
			{
				25,
				777,
				777,
				777,
				120,
				120,
				108,
				96,
				96,
				96
			},
			{
				30,
				777,
				777,
				120,
				108,
				108,
				96,
				72,
				72,
				72
			},
			{
				35,
				777,
				120,
				108,
				96,
				72,
				60,
				48,
				48,
				48
			},
			{
				40,
				120,
				108,
				96,
				60,
				48,
				42,
				32,
				32,
				32
			},
			{
				45,
				108,
				96,
				72,
				42,
				32,
				28,
				24,
				24,
				24
			},
			{
				50,
				96,
				72,
				60,
				32,
				28,
				24,
				21,
				21,
				21
			},
			{
				55,
				80,
				60,
				48,
				28,
				24,
				21,
				18,
				18,
				18
			},
			{
				60,
				72,
				48,
				42,
				24,
				21,
				18,
				16,
				16,
				18
			},
			{
				65,
				68,
				46,
				32,
				21.75,
				19,
				17,
				15,
				16,
				18
			},
			{
				70,
				64,
				44,
				28,
				19.5,
				18,
				16,
				14.5,
				16,
				18
			},
			{
				75,
				60,
				42,
				24,
				18,
				16,
				15,
				14,
				16,
				18
			},
			{
				80,
				56,
				38.25,
				23,
				17.25,
				15.81,
				14.81,
				14,
				16,
				18
			},
			{
				85,
				52,
				34.5,
				22,
				16.5,
				15.625,
				14.625,
				14,
				16,
				18
			},
			{
				90,
				48,
				32,
				21,
				16,
				15.5,
				14.5,
				14,
				16,
				18
			},
			{
				95,
				45,
				28,
				19.5,
				15.5,
				15,
				14,
				13.5,
				16,
				18
			},
			{
				100,
				42,
				26.5,
				18.5,
				15,
				14.5,
				13.5,
				13,
				16,
				18
			},
			{
				105,
				39,
				25,
				18,
				14.5,
				14,
				13,
				12,
				16,
				18
			},
			{
				110,
				36,
				24,
				18,
				14,
				13,
				12,
				11,
				16,
				18
			},
			{
				115,
				34.5,
				22.5,
				17.25,
				12.5,
				11.875,
				11.25,
				10.625,
				14.5,
				16.5
			},
			{
				120,
				33,
				21,
				16.5,
				11,
				10.75,
				10.5,
				10.25,
				13,
				15
			},
			{
				125,
				32,
				20,
				16,
				10,
				10,
				10,
				10,
				12,
				14
			}
		}
		local t2 = {
			{
				"\226\136\134Lc",
				100,
				200,
				300,
				400,
				500,
				600,
				700,
				800,
				900
			},
			{
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			},
			{
				10,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			},
			{
				15,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			},
			{
				20,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			},
			{
				25,
				0,
				0,
				0,
				12,
				12,
				12,
				24,
				24,
				24
			},
			{
				30,
				0,
				0,
				12,
				12,
				36,
				36,
				24,
				24,
				24
			},
			{
				35,
				0,
				12,
				12,
				36,
				24,
				18,
				16,
				16,
				16
			},
			{
				40,
				12,
				12,
				24,
				18,
				16,
				14,
				8,
				8,
				8
			},
			{
				45,
				12,
				24,
				12,
				10,
				4,
				4,
				3,
				3,
				3
			},
			{
				50,
				16,
				12,
				12,
				4,
				4,
				3,
				3,
				3,
				3
			},
			{
				55,
				8,
				12,
				6,
				4,
				3,
				3,
				2,
				2,
				0
			},
			{
				60,
				4,
				2,
				10,
				2.25,
				2,
				1,
				1,
				0,
				0
			},
			{
				65,
				4,
				2,
				4,
				2.25,
				1,
				1,
				0.5,
				0,
				0
			},
			{
				70,
				4,
				2,
				4,
				1.5,
				2,
				1,
				0.5,
				0,
				0
			},
			{
				75,
				4,
				3.75,
				1,
				0.75,
				0.188,
				0.188,
				0,
				0,
				0
			},
			{
				80,
				4,
				3.75,
				1,
				0.75,
				0.188,
				0.188,
				0,
				0,
				0
			},
			{
				85,
				4,
				2.5,
				1,
				0.5,
				0.125,
				0.125,
				0,
				0,
				0
			},
			{
				90,
				3,
				4,
				1.5,
				0.5,
				0.5,
				0.5,
				0.5,
				0,
				0
			},
			{
				95,
				3,
				1.5,
				1,
				0.5,
				0.5,
				0.5,
				0.5,
				0,
				0
			},
			{
				100,
				3,
				1.5,
				0.5,
				0.5,
				0.5,
				0.5,
				1,
				0,
				0
			},
			{
				105,
				3,
				1,
				0,
				0.5,
				1,
				1,
				1,
				0,
				0
			},
			{
				110,
				1.5,
				1.5,
				0.75,
				1.5,
				1.125,
				0.75,
				0.375,
				1.5,
				1.5
			},
			{
				115,
				1.5,
				1.5,
				0.75,
				1.5,
				1.125,
				0.75,
				0.375,
				1.5,
				1.5
			},
			{
				120,
				1,
				1,
				0.5,
				1,
				0.75,
				0.5,
				0.25,
				1,
				1
			},
			{
				125,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0
			}
		}
		local t3 = {
			tostring(p1 * v1 // 1 / v1),
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
		local v3 = math.abs(p1)
		local v4 = if v3 == 0 then 1 else bit32.bor(v3 * 0.2, 0)
		local v5 = 0
		local v6 = (v3 - t[v4 + 1][v5 + 1]) * 0.2
		local count = v5 + 1

		while count < #{
			0,
			100,
			200,
			300,
			400,
			500,
			600,
			700,
			800,
			900
		} do
			count = count + 1

			local v7 = t[v4 + 1][count + 1]

			if v7 > 400 then
				t3[count + 1] = v7
			else
				if v3 < 14.5 then
					t3[count + 1] = 999

					continue
				end

				if v3 < 29.5 then
					t3[count + 1] = 777

					continue
				end

				if v7 > 24 then
					t3[count + 1] = math.round(v7 - t2[v4 + 1][count + 1] * v6)

					continue
				end

				t3[count + 1] = v7 - 2 * t2[v4 + 1][count + 1] * v6 // 1 * 0.5
			end
		end

		return t3
	end,
	sRGBtoY = sRGBtoY,
	displayP3toY = displayP3toY,
	adobeRGBtoY = adobeRGBtoY,
	alphaBlend = alphaBlend
}