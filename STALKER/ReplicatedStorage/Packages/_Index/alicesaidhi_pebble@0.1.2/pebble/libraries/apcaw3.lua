-- Decompiled with Potassium's decompiler.

local u1 = {
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
};

local function isNaN(p2) -- Line: 27
    return p2 ~= p2;
end;

local function sRGBtoY(p3) -- Line: 95
    -- upvalues: u1 (copy)
    local G = p3.G;
    local B = p3.B;

    local function simpleExp(p4) -- Line: 100
        return math.pow(p4, 2.4);
    end;

    return 0.2126729 * math.pow(p3.R, u1.mainTRC) + 0.7151522 * math.pow(G, u1.mainTRC) + 0.072175 * math.pow(B, u1.mainTRC);
end;

local function APCAcontrast(p5, p6, p7) -- Line: 133
    local v8 = p7 or -1;
    local v9 = { 0, 1.1 };

    if math.min(p5, p6) < v9[1] or math.max(p5, p6) > v9[2] then
        return 0;
    end;

    local v10 = p5 > 0.022 and p5 and p5 or p5 + math.pow(0.022 - p5, 1.414);
    local v11 = p6 > 0.022 and p6 and p6 or p6 + math.pow(0.022 - p6, 1.414);

    if math.abs(v11 - v10) < 0.0005 then
        return 0;
    end;

    local v12;

    if v10 < v11 then
        local v13 = (math.pow(v11, 0.56) - math.pow(v10, 0.57)) * 1.14;
        v12 = v13 < 0.1 and 0 or v13 - 0.027;
    else
        local v14 = (math.pow(v11, 0.65) - math.pow(v10, 0.62)) * 1.14;
        v12 = v14 > -0.1 and 0 or v14 + 0.027;
    end;

    if v8 < 0 then
        return v12 * 100;
    end;

    if v8 ~= 0 then
        return v8 // 1 ~= v8 and 0 or v12 * 100 * v8 // 1 / v8;
    end;

    local v15 = math.abs(v12) * 100;

    return math.round(v15);
end;

local function alphaBlend(p16, p17: number, p18, p19: boolean?) -- Line: 177
    local v20 = p19 == nil and true or p19;
    local v21 = p17 or 1;
    local v22 = 1 - v21;
    local v23 = {
        0,
        0,
        0,
        p18.R * v22 + p16.R * v21
    };

    if v20 then
        local math_round_ret = math.round(v23[1]);
        v23[1] = math.min(math_round_ret, 255);
    end;

    v23[2] = p18.G * v22 + p16.G * v21;

    if v20 then
        local math_round_ret = math.round(v23[2]);
        v23[2] = math.min(math_round_ret, 255);
    end;

    v23[3] = p18.B * v22 + p16.B * v21;

    if v20 then
        local math_round_ret = math.round(v23[3]);
        v23[3] = math.min(math_round_ret, 255);
    end;

    return Color3.new(v23[1], v23[2], v23[3]);
end;

return {
    APCAcontrast = APCAcontrast,

    reverseAPCA = function(p24, p25, p26, p27) -- Line: 31, Name: reverseAPCA
        local v28 = p24 == nil and 0 or p24;
        local v29 = p25 == nil and 1 or p25;
        local v30 = p26 == nil and "bg" or p26;
        local v31 = p27 == nil and "hex" or p27;

        if math.abs(v28) < 9 then
            return false;
        end;

        local _ = v28 > 0;
        local v32 = tonumber(v28);
        local v33 = (assert(v32) * 0.01 + (v28 > 0 and 0.027 or -0.027)) / 1.14;

        if v29 <= 0.022 then
            v29 = v29 + math.pow(0.022 - v29, 1.414);
        end;

        local v34;

        if v30 == "bg" or v30 == "background" then
            local v35 = math.pow(v29, v33 > 0 and 0.56 or 0.65) - v33;
            v34 = math.pow(v35, 1 / (v33 > 0 and 0.57 or 0.62));

            if v34 ~= v34 then
                return false;
            end;
        else
            if v30 ~= "txt" and v30 ~= "text" then
                return false;
            end;

            local v36 = v33 + math.pow(v29, v33 > 0 and 0.57 or 0.62);
            v34 = math.pow(v36, 1 / (v33 > 0 and 0.56 or 0.65));

            if v34 ~= v34 then
                return false;
            end;
        end;

        if v34 > 1.06 or v34 < 0 then
            return false;
        end;

        if v34 <= 0.022 then
            v34 = math.pow((v34 + 0.0387393816571401) * 1.9468554433171, 0.20038429732734725) * 0.5136488193988227 - 0.312865795870758;
        end;

        local math_min_ret = math.min(v34, 1);
        local math_max_ret = math.max(math_min_ret, 0);

        if v31 ~= "color" then
            if v31 == "Y" or v31 == "y" then
                return math.max(0, math_max_ret);
            end;

            return false;
        end;

        local v37 = math.pow(math_max_ret, 0.4166666666666667) * 255;
        local math_round_ret = math.round(v37);

        return {
            math_round_ret,
            math_round_ret,
            math_round_ret,
            1,
            v30 == "bg" and "txtColor" or "bgColor"
        };
    end,

    calcAPCA = function(p38, p39, p40: number?, p41: number?, p42: boolean?) -- Line: 194, Name: calcAPCA
        -- upvalues: alphaBlend (copy), APCAcontrast (copy), sRGBtoY (copy)
        if p40 then
            p38 = alphaBlend(p38, p40, p39, p42);
        end;

        return APCAcontrast(sRGBtoY(p38), sRGBtoY(p39), -1);
    end,

    fontLookupAPCA = function(p43: any, p44: number?) -- Line: 203, Name: fontLookupAPCA
        local v45 = p44 or 2;
        local v46 = {
            { "Lc", 100, 200, 300, 400, 500, 600, 700, 800, 900 },
            { 0, 999, 999, 999, 999, 999, 999, 999, 999, 999 },
            { 10, 999, 999, 999, 999, 999, 999, 999, 999, 999 },
            { 15, 777, 777, 777, 777, 777, 777, 777, 777, 777 },
            { 20, 777, 777, 777, 777, 777, 777, 777, 777, 777 },
            { 25, 777, 777, 777, 120, 120, 108, 96, 96, 96 },
            { 30, 777, 777, 120, 108, 108, 96, 72, 72, 72 },
            { 35, 777, 120, 108, 96, 72, 60, 48, 48, 48 },
            { 40, 120, 108, 96, 60, 48, 42, 32, 32, 32 },
            { 45, 108, 96, 72, 42, 32, 28, 24, 24, 24 },
            { 50, 96, 72, 60, 32, 28, 24, 21, 21, 21 },
            { 55, 80, 60, 48, 28, 24, 21, 18, 18, 18 },
            { 60, 72, 48, 42, 24, 21, 18, 16, 16, 18 },
            { 65, 68, 46, 32, 21.75, 19, 17, 15, 16, 18 },
            { 70, 64, 44, 28, 19.5, 18, 16, 14.5, 16, 18 },
            { 75, 60, 42, 24, 18, 16, 15, 14, 16, 18 },
            { 80, 56, 38.25, 23, 17.25, 15.81, 14.81, 14, 16, 18 },
            { 85, 52, 34.5, 22, 16.5, 15.625, 14.625, 14, 16, 18 },
            { 90, 48, 32, 21, 16, 15.5, 14.5, 14, 16, 18 },
            { 95, 45, 28, 19.5, 15.5, 15, 14, 13.5, 16, 18 },
            { 100, 42, 26.5, 18.5, 15, 14.5, 13.5, 13, 16, 18 },
            { 105, 39, 25, 18, 14.5, 14, 13, 12, 16, 18 },
            { 110, 36, 24, 18, 14, 13, 12, 11, 16, 18 },
            { 115, 34.5, 22.5, 17.25, 12.5, 11.875, 11.25, 10.625, 14.5, 16.5 },
            { 120, 33, 21, 16.5, 11, 10.75, 10.5, 10.25, 13, 15 },
            { 125, 32, 20, 16, 10, 10, 10, 10, 12, 14 }
        };
        local v47 = #{ 0, 100, 200, 300, 400, 500, 600, 700, 800, 900 };
        local v48 = {
            tostring(p43 * v45 // 1 / v45),
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0
        };
        local _ = #v48;
        local _ = #{ "lc", 0, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125 };
        local math_abs_ret = math.abs(p43);
        local v49 = math_abs_ret == 0 and 1 or bit32.bor(math_abs_ret * 0.2, 0);
        local v50 = 0;
        local v51 = (math_abs_ret - v46[v49 + 1][v50 + 1]) * 0.2;
        local v52 = v50 + 1;
        local v53 = {
            { "∆Lc", 100, 200, 300, 400, 500, 600, 700, 800, 900 },
            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
            { 10, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
            { 15, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
            { 20, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
            { 25, 0, 0, 0, 12, 12, 12, 24, 24, 24 },
            { 30, 0, 0, 12, 12, 36, 36, 24, 24, 24 },
            { 35, 0, 12, 12, 36, 24, 18, 16, 16, 16 },
            { 40, 12, 12, 24, 18, 16, 14, 8, 8, 8 },
            { 45, 12, 24, 12, 10, 4, 4, 3, 3, 3 },
            { 50, 16, 12, 12, 4, 4, 3, 3, 3, 3 },
            { 55, 8, 12, 6, 4, 3, 3, 2, 2, 0 },
            { 60, 4, 2, 10, 2.25, 2, 1, 1, 0, 0 },
            { 65, 4, 2, 4, 2.25, 1, 1, 0.5, 0, 0 },
            { 70, 4, 2, 4, 1.5, 2, 1, 0.5, 0, 0 },
            { 75, 4, 3.75, 1, 0.75, 0.188, 0.188, 0, 0, 0 },
            { 80, 4, 3.75, 1, 0.75, 0.188, 0.188, 0, 0, 0 },
            { 85, 4, 2.5, 1, 0.5, 0.125, 0.125, 0, 0, 0 },
            { 90, 3, 4, 1.5, 0.5, 0.5, 0.5, 0.5, 0, 0 },
            { 95, 3, 1.5, 1, 0.5, 0.5, 0.5, 0.5, 0, 0 },
            { 100, 3, 1.5, 0.5, 0.5, 0.5, 0.5, 1, 0, 0 },
            { 105, 3, 1, 0, 0.5, 1, 1, 1, 0, 0 },
            { 110, 1.5, 1.5, 0.75, 1.5, 1.125, 0.75, 0.375, 1.5, 1.5 },
            { 115, 1.5, 1.5, 0.75, 1.5, 1.125, 0.75, 0.375, 1.5, 1.5 },
            { 120, 1, 1, 0.5, 1, 0.75, 0.5, 0.25, 1, 1 },
            { 125, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        };

        while v52 < v47 do
            v52 = v52 + 1;
            local v54 = v46[v49 + 1][v52 + 1];

            if v54 > 400 then
                v48[v52 + 1] = v54;
            elseif math_abs_ret < 14.5 then
                v48[v52 + 1] = 999;
            elseif math_abs_ret < 29.5 then
                v48[v52 + 1] = 777;
            elseif v54 > 24 then
                v48[v52 + 1] = math.round(v54 - v53[v49 + 1][v52 + 1] * v51);
            else
                v48[v52 + 1] = v54 - 2 * v53[v49 + 1][v52 + 1] * v51 // 1 * 0.5;
            end;
        end;

        return v48;
    end,

    sRGBtoY = sRGBtoY,

    displayP3toY = function(p55) -- Line: 107, Name: displayP3toY
        local function _(p56) -- Line: 111
            return math.pow(p56, 2.4);
        end;

        return 0.228982959480578 * math.pow(p55.R, 2.4) + 0.691749262585238 * math.pow(p55.G, 2.4) + 0.0792677779341829 * math.pow(p55.B, 2.4);
    end,

    adobeRGBtoY = function(p57) -- Line: 118, Name: adobeRGBtoY
        local function _(p58) -- Line: 125
            return math.pow(p58 / 255, 2.35);
        end;

        return 0.297355022711381 * math.pow(p57.R / 255, 2.35) + 0.627372749714528 * math.pow(p57.G / 255, 2.35) + 0.0752722275740913 * math.pow(p57.B / 255, 2.35);
    end,

    alphaBlend = alphaBlend
};