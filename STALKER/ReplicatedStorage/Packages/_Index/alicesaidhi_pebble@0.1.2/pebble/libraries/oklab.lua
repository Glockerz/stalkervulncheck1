-- Decompiled with Potassium's decompiler.

local function cbrt(p1: number) -- Line: 11
    return math.sign(p1) * math.abs(p1) ^ 0.3333333333333333;
end;

local u35 = {
    linear_srgb_to_oklab = function(p2: vector) -- Line: 17, Name: linear_srgb_to_oklab
        local v3 = p2.X * 0.4122214708 + p2.Y * 0.5363325363 + p2.Z * 0.0514459929;
        local v4 = p2.X * 0.2119034982 + p2.Y * 0.6806995451 + p2.Z * 0.1073969566;
        local v5 = p2.X * 0.0883024619 + p2.Y * 0.2817188376 + p2.Z * 0.6299787005;
        local v6 = math.sign(v3) * math.abs(v3) ^ 0.3333333333333333;
        local v7 = math.sign(v4) * math.abs(v4) ^ 0.3333333333333333;
        local v8 = math.sign(v5) * math.abs(v5) ^ 0.3333333333333333;

        return Vector3.new(0.2104542553 * v6 + 0.793617785 * v7 - 0.0040720468 * v8, 1.9779984951 * v6 - 2.428592205 * v7 + 0.4505937099 * v8, 0.0259040371 * v6 + 0.7827717662 * v7 - 0.808675766 * v8);
    end,

    oklab_to_linear_srgb = function(p9: vector) -- Line: 35, Name: oklab_to_linear_srgb
        local v10 = p9.X + p9.Y * 0.3963377774 + p9.Z * 0.2158037573;
        local v11 = p9.X - p9.Y * 0.1055613458 - p9.Z * 0.0638541728;
        local v12 = p9.X - p9.Y * 0.0894841775 - p9.Z * 1.291485548;
        local v13 = v10 * v10 * v10;
        local v14 = v11 * v11 * v11;
        local v15 = v12 * v12 * v12;

        return Vector3.new(v13 * 4.0767416621 - v14 * 3.3077115913 + v15 * 0.2309699292, v13 * -1.2684380046 + v14 * 2.6097574011 - v15 * 0.3413193965, v13 * -0.0041960863 - v14 * 0.7034186147 + v15 * 1.707614701);
    end,

    compute_max_saturation = function(p16: number, p17: number) -- Line: 56, Name: compute_max_saturation
        local v18, v19, v20, v21, v22, v23, v24, v25;

        if p16 * -1.88170328 - p17 * 0.80936493 > 1 then
            v18 = -3.3077115913;
            v19 = 0.2309699292;
            v20 = 1.76576728;
            v21 = 1.19086277;
            v22 = 0.59662641;
            v23 = 0.75515197;
            v24 = 0.56771245;
            v25 = 4.0767416621;
        elseif p16 * 1.81444104 - p17 * 1.19445276 > 1 then
            v18 = 2.6097574011;
            v19 = -0.3413193965;
            v20 = -0.45954404;
            v21 = 0.73956515;
            v22 = 0.08285427;
            v23 = 0.1254107;
            v24 = 0.14503204;
            v25 = -1.2684380046;
        else
            v18 = -0.7034186147;
            v19 = 1.707614701;
            v20 = -0.00915799;
            v21 = 1.35733652;
            v22 = -1.1513021;
            v23 = -0.50559606;
            v24 = 0.00692167;
            v25 = -0.0041960863;
        end;

        local v26 = v21 + v20 * p16 + v22 * p17 + v23 * p16 * p16 + v24 * p16 * p17;
        local v27 = p16 * 0.3963377774 + p17 * 0.2158037573;
        local v28 = p16 * -0.1055613458 - p17 * 0.0638541728;
        local v29 = p16 * -0.0894841775 - p17 * 1.291485548;
        local v30 = 1 + v26 * v27;
        local v31 = 1 + v26 * v28;
        local v32 = 1 + v26 * v29;
        local v33 = v25 * (v30 * v30 * v30) + v18 * (v31 * v31 * v31) + v19 * (v32 * v32 * v32);
        local v34 = v25 * (v27 * 3 * v30 * v30) + v18 * (v28 * 3 * v31 * v31) + v19 * (v29 * 3 * v32 * v32);

        return v26 - v33 * v34 / (v34 * v34 - 0.5 * v33 * (v25 * (v27 * 6 * v27 * v30) + v18 * (v28 * 6 * v28 * v31) + v19 * (v29 * 6 * v29 * v32)));
    end
};

function u35.find_cusp(p36: number, p37: number) -- Line: 118
    -- upvalues: u35 (copy)
    local v38 = u35.compute_max_saturation(p36, p37);
    local v39 = u35.oklab_to_linear_srgb((Vector3.new(1, v38 * p36, v38 * p37)));
    local v40 = 1 / math.max(v39.X, v39.Y, v39.Z);
    local v41 = math.sign(v40) * math.abs(v40) ^ 0.3333333333333333;

    return v41, v41 * v38;
end;

function u35.find_gamut_intersection(p42: number, p43: number, p44: number, p45: number, p46: number) -- Line: 137
    -- upvalues: u35 (copy)
    local v47, v48 = u35.find_cusp(p42, p43);

    if (p44 - p46) * v48 - (v47 - p46) * p45 <= 0 then
        return v48 * p46 / (p45 * v47 + v48 * (p46 - p44));
    end;

    local v49 = v48 * (p46 - 1) / (p45 * (v47 - 1) + v48 * (p46 - p44));
    local v50 = p44 - p46;
    local v51 = p42 * 0.3963377774 + p43 * 0.2158037573;
    local v52 = p42 * -0.1055613458 - p43 * 0.0638541728;
    local v53 = p42 * -0.0894841775 - p43 * 1.291485548;
    local v54 = v50 + p45 * v51;
    local v55 = v50 + p45 * v52;
    local v56 = v50 + p45 * v53;
    local v57 = p46 * (1 - v49) + v49 * p44;
    local v58 = v49 * p45;
    local v59 = v57 + v58 * v51;
    local v60 = v57 + v58 * v52;
    local v61 = v57 + v58 * v53;
    local v62 = v59 * v59 * v59;
    local v63 = v60 * v60 * v60;
    local v64 = v61 * v61 * v61;
    local v65 = v54 * 3 * v59 * v59;
    local v66 = v55 * 3 * v60 * v60;
    local v67 = v56 * 3 * v61 * v61;
    local v68 = v54 * 6 * v54 * v59;
    local v69 = v55 * 6 * v55 * v60;
    local v70 = v56 * 6 * v56 * v61;
    local v71 = 4.0767416621 * v62 - 3.3077115913 * v63 + 0.2309699292 * v64 - 1;
    local v72 = 4.0767416621 * v65 - 3.3077115913 * v66 + 0.2309699292 * v67;
    local v73 = v72 / (v72 * v72 - 0.5 * v71 * (4.0767416621 * v68 - 3.3077115913 * v69 + 0.2309699292 * v70));
    local v74 = -1.2684380046 * v62 + 2.6097574011 * v63 - 0.3413193965 * v64 - 1;
    local v75 = -1.2684380046 * v65 + 2.6097574011 * v66 - 0.3413193965 * v67;
    local v76 = v75 / (v75 * v75 - 0.5 * v74 * (-1.2684380046 * v68 + 2.6097574011 * v69 - 0.3413193965 * v70));
    local v77 = -0.0041960863 * v62 - 0.7034186147 * v63 + 1.707614701 * v64 - 1;
    local v78 = -0.0041960863 * v65 - 0.7034186147 * v66 + 1.707614701 * v67;
    local v79 = v78 / (v78 * v78 - 0.5 * v77 * (-0.0041960863 * v68 - 0.7034186147 * v69 + 1.707614701 * v70));

    return v49 + math.min(v73 < 0 and (1 / 0) or -v71 * v73, v76 < 0 and (1 / 0) or -v74 * v76, v79 < 0 and (1 / 0) or -v77 * v79);
end;

function u35.gamut_clip_preserve_chroma(p80: vector) -- Line: 224
    -- upvalues: u35 (copy)
    if p80.X <= 1 and (p80.Y <= 1 and (p80.Z <= 1 and (p80.X >= 0 and (p80.Y >= 0 and p80.Z >= 0)))) then
        return p80;
    end;

    local v81 = u35.linear_srgb_to_oklab(p80);
    local X = v81.X;
    local math_sqrt_ret = math.sqrt(v81.Y * v81.Y + v81.Z * v81.Z);
    local math_max_ret = math.max(0.00001, math_sqrt_ret);
    local v82 = math_max_ret == 0 and 0 or v81.Y / math_max_ret;
    local v83 = math_max_ret == 0 and 0 or v81.Z / math_max_ret;
    local math_clamp_ret = math.clamp(X, 0, 1);
    local v84 = u35.find_gamut_intersection(v82, v83, X, math_max_ret, math_clamp_ret);
    local v85 = v84 * math_max_ret;

    return u35.oklab_to_linear_srgb((Vector3.new(math_clamp_ret * (1 - v84) + v84 * X, v85 * v82, v85 * v83)));
end;

function u35.gamut_clip_project_to_0_5(p86: vector) -- Line: 247
    -- upvalues: u35 (copy)
    if p86.X <= 1 and (p86.Y <= 1 and (p86.Z <= 1 and (p86.X >= 0 and (p86.Y >= 0 and p86.Z >= 0)))) then
        return p86;
    end;

    local v87 = u35.linear_srgb_to_oklab(p86);
    local X = v87.X;
    local math_sqrt_ret = math.sqrt(v87.Y * v87.Y + v87.Z * v87.Z);
    local math_max_ret = math.max(0.00001, math_sqrt_ret);
    local v88 = v87.Y / math_max_ret;
    local v89 = v87.Z / math_max_ret;
    local v90 = u35.find_gamut_intersection(v88, v89, X, math_max_ret, 0.5);
    local v91 = v90 * math_max_ret;

    return u35.oklab_to_linear_srgb((Vector3.new(0.5 * (1 - v90) + v90 * X, v91 * v88, v91 * v89)));
end;

function u35.gamut_clip_project_to_L_cusp(p92: vector) -- Line: 271
    -- upvalues: u35 (copy)
    if p92.X <= 1 and (p92.Y <= 1 and (p92.Z <= 1 and (p92.X >= 0 and (p92.Y >= 0 and p92.Z >= 0)))) then
        return p92;
    end;

    local v93 = u35.linear_srgb_to_oklab(p92);
    local X = v93.X;
    local math_sqrt_ret = math.sqrt(v93.Y * v93.Y + v93.Z * v93.Z);
    local math_max_ret = math.max(0.00001, math_sqrt_ret);
    local v94 = v93.Y / math_max_ret;
    local v95 = v93.Z / math_max_ret;
    local v96, _ = u35.find_cusp(v94, v95);
    local v97 = u35.find_gamut_intersection(v94, v95, X, math_max_ret, v96);
    local v98 = v97 * math_max_ret;

    return u35.oklab_to_linear_srgb((Vector3.new(v96 * (1 - v97) + v97 * X, v98 * v94, v98 * v95)));
end;

function u35.gamut_clip_adaptive_L0_0_5(p99: vector, p100: number?) -- Line: 299
    -- upvalues: u35 (copy)
    if p99.X <= 1 and (p99.Y <= 1 and (p99.Z <= 1 and (p99.X >= 0 and (p99.Y >= 0 and p99.Z >= 0)))) then
        return p99;
    end;

    local v101 = u35.linear_srgb_to_oklab(p99);
    local X = v101.X;
    local math_sqrt_ret = math.sqrt(v101.Y * v101.Y + v101.Z * v101.Z);
    local math_max_ret = math.max(0.00001, math_sqrt_ret);
    local v102 = v101.Y / math_max_ret;
    local v103 = v101.Z / math_max_ret;
    local v104 = X - 0.5;
    local v105 = math.abs(v104) + 0.5 + (p100 or 0.05) * math_max_ret;
    local math_sign_ret = math.sign(v104);
    local v106 = v105 * v105 - math.abs(v104) * 2;
    local v107 = 0.5 * (1 + math_sign_ret * (v105 - math.sqrt(v106)));
    local v108 = u35.find_gamut_intersection(v102, v103, X, math_max_ret, v107);
    local v109 = v108 * math_max_ret;

    return u35.oklab_to_linear_srgb((Vector3.new(v107 * (1 - v108) + v108 * X, v109 * v102, v109 * v103)));
end;

function u35.gamut_clip_adaptive_L0_L_cusp(p110: vector, p111: number?) -- Line: 327
    -- upvalues: u35 (copy)
    if p110.X < 1 and (p110.Y < 1 and (p110.Z < 1 and (p110.X > 0 and (p110.Y > 0 and p110.Z > 0)))) then
        return p110;
    end;

    local v112 = u35.linear_srgb_to_oklab(p110);
    local X = v112.X;
    local math_sqrt_ret = math.sqrt(v112.Y * v112.Y + v112.Z * v112.Z);
    local math_max_ret = math.max(0.00001, math_sqrt_ret);
    local v113 = v112.Y / math_max_ret;
    local v114 = v112.Z / math_max_ret;
    local v115, _ = u35.find_cusp(v113, v114);
    local v116 = X - v115;
    local v117;

    if v116 > 0 then
        v117 = 1 - v115;
    else
        v117 = v115;
    end;

    local v118 = 2 * v117;
    local v119 = 0.5 * v118 + math.abs(v116) + (p111 or 0.05) * math_max_ret / v118;
    local math_sign_ret = math.sign(v116);
    local v120 = v119 * v119 - 2 * v118 * math.abs(v116);
    local v121 = v115 + 0.5 * (math_sign_ret * (v119 - math.sqrt(v120)));
    local v122 = u35.find_gamut_intersection(v113, v114, X, math_max_ret, v121);
    local v123 = v122 * math_max_ret;

    return u35.oklab_to_linear_srgb((Vector3.new(v121 * (1 - v122) + v122 * X, v123 * v113, v123 * v114)));
end;

u35.default_gamut_clip = u35.gamut_clip_adaptive_L0_0_5;

local function component_to_gamma(p124: number) -- Line: 366
    if p124 >= 0.0031308 then
        return p124 ^ 0.4166666666666667 * 1.055 - 0.055;
    end;

    return p124 * 12.92;
end;

local function component_to_linear(p125: number) -- Line: 374
    if p125 >= 0.04045 then
        return ((p125 + 0.055) / 1.055) ^ 2.4;
    end;

    return p125 / 12.92;
end;

function u35.color3_to_linear_srgb(p126) -- Line: 382
    local R = p126.R;
    local v127;

    if R >= 0.04045 then
        v127 = ((R + 0.055) / 1.055) ^ 2.4;
    else
        v127 = R / 12.92;
    end;

    local G = p126.G;
    local v128;

    if G >= 0.04045 then
        v128 = ((G + 0.055) / 1.055) ^ 2.4;
    else
        v128 = G / 12.92;
    end;

    local B = p126.B;
    local v129;

    if B >= 0.04045 then
        v129 = ((B + 0.055) / 1.055) ^ 2.4;
    else
        v129 = B / 12.92;
    end;

    return Vector3.new(v127, v128, v129);
end;

function u35.linear_srgb_to_color3(p130: vector, p131: boolean?) -- Line: 392
    -- upvalues: u35 (copy)
    if p131 == false then
        local X = p130.X;
        local v132;

        if X >= 0.0031308 then
            v132 = X ^ 0.4166666666666667 * 1.055 - 0.055;
        else
            v132 = X * 12.92;
        end;

        local Y = p130.Y;
        local v133;

        if Y >= 0.0031308 then
            v133 = Y ^ 0.4166666666666667 * 1.055 - 0.055;
        else
            v133 = Y * 12.92;
        end;

        local Z = p130.Z;
        local v134;

        if Z >= 0.0031308 then
            v134 = Z ^ 0.4166666666666667 * 1.055 - 0.055;
        else
            v134 = Z * 12.92;
        end;

        return Color3.new(v132, v133, v134);
    end;

    local v135 = u35.default_gamut_clip(p130);
    local Color3_new = Color3.new;
    local X = v135.X;
    local v136;

    if X >= 0.0031308 then
        v136 = X ^ 0.4166666666666667 * 1.055 - 0.055;
    else
        v136 = X * 12.92;
    end;

    local math_clamp_ret = math.clamp(v136, 0, 1);
    local Y = v135.Y;
    local v137;

    if Y >= 0.0031308 then
        v137 = Y ^ 0.4166666666666667 * 1.055 - 0.055;
    else
        v137 = Y * 12.92;
    end;

    local math_clamp_ret2 = math.clamp(v137, 0, 1);
    local Z = v135.Z;
    local v138;

    if Z >= 0.0031308 then
        v138 = Z ^ 0.4166666666666667 * 1.055 - 0.055;
    else
        v138 = Z * 12.92;
    end;

    return Color3_new(math_clamp_ret, math_clamp_ret2, (math.clamp(v138, 0, 1)));
end;

function u35.oklch_to_oklab(p139: vector) -- Line: 418
    local X = p139.X;
    local v140 = p139.Y * math.cos(p139.Z * 6.283185307179586);
    local v141 = p139.Y * math.sin(p139.Z * 6.283185307179586);

    return Vector3.new(X, v140, v141);
end;

function u35.oklab_to_oklch(p142: vector) -- Line: 426
    local X = p142.X;
    local math_sqrt_ret = math.sqrt(p142.Y ^ 2 + p142.Z ^ 2);
    local v143 = math.atan2(p142.Z, p142.Y) / 6.283185307179586 % 1;

    return Vector3.new(X, math_sqrt_ret, v143);
end;

return u35;