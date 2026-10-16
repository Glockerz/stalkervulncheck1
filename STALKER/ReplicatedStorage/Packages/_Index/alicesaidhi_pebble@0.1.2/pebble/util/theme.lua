-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.vide);
require(script.Parent.Parent.libraries.apcaw3);
require(script.Parent.contrast);
local oklch = require(script.Parent.oklch);
local source = vide.source;

local function u2(p1: table) -- Line: 13
    -- upvalues: oklch (copy)
    return table.freeze({
        l = p1[1],
        c = p1[2],
        h = p1[3],
        color = oklch(unpack(p1))
    });
end;

local u3 = source(u2({ 0.2012, 0.01, 0.6 }));
local u4 = source(u2({ 0.52, 0.21, 0.71 }));
local Font_fromName_ret = Font.fromName("BuilderSans", Enum.FontWeight.Regular, Enum.FontStyle.Normal);
local Font_new_ret = Font.new("rbxassetid://16658246179", Enum.FontWeight.Regular, Enum.FontStyle.Normal);

local function should_flip(p5: number) -- Line: 39
    return p5 > 0.65;
end;

local function compute_bg(u6: number) -- Line: 57
    -- upvalues: u3 (copy), u2 (copy), oklch (copy)
    local function get() -- Line: 58
        -- upvalues: u3 (ref), u2 (ref), u6 (copy)
        local v7 = u3();

        return u2({ math.clamp(v7.l + u6 * 0.02, 0, 1), v7.c, v7.h });
    end;

    return function(p8: boolean) -- Line: 82
        -- upvalues: u3 (ref), u6 (copy), oklch (ref)
        if p8 then
            local v9 = u3();
            local v10 = { math.clamp(v9.l + u6 * 0.02, 0, 1), v9.c, v9.h };

            return table.freeze({
                l = v10[1],
                c = v10[2],
                h = v10[3],
                color = oklch(unpack(v10))
            });
        end;

        local v11 = u3();
        local v12 = { math.clamp(v11.l + u6 * 0.02, 0, 1), v11.c, v11.h };

        return table.freeze({
            l = v12[1],
            c = v12[2],
            h = v12[3],
            color = oklch(unpack(v12))
        }).color;
    end;
end;

local function compute_acc(u13: number) -- Line: 88
    -- upvalues: u4 (copy), u2 (copy), oklch (copy)
    local function _() -- Line: 89
        -- upvalues: u4 (ref), u2 (ref), u13 (copy)
        local v14 = u4();

        return u2({ math.clamp(v14.l + u13 * 0.02, 0, 1), v14.c, v14.h });
    end;

    return function(p15: boolean) -- Line: 112
        -- upvalues: u4 (ref), u13 (copy), oklch (ref)
        if p15 then
            local v16 = u4();
            local v17 = { math.clamp(v16.l + u13 * 0.02, 0, 1), v16.c, v16.h };

            return table.freeze({
                l = v17[1],
                c = v17[2],
                h = v17[3],
                color = oklch(unpack(v17))
            });
        end;

        local v18 = u4();
        local v19 = { math.clamp(v18.l + u13 * 0.02, 0, 1), v18.c, v18.h };

        return table.freeze({
            l = v19[1],
            c = v19[2],
            h = v19[3],
            color = oklch(unpack(v19))
        }).color;
    end;
end;

local function compute_fg_on_bg_high(u20: number) -- Line: 118
    -- upvalues: u3 (copy), u2 (copy), oklch (copy)
    local function _() -- Line: 58
        -- upvalues: u3 (ref), u2 (ref), u20 (copy)
        local v21 = u3();

        return u2({ math.clamp(v21.l + u20 * 0.02, 0, 1), v21.c, v21.h });
    end;

    local function u27(p22: boolean) -- Line: 82
        -- upvalues: u3 (ref), u20 (copy), oklch (ref)
        if p22 then
            local v23 = u3();
            local v24 = { math.clamp(v23.l + u20 * 0.02, 0, 1), v23.c, v23.h };

            return table.freeze({
                l = v24[1],
                c = v24[2],
                h = v24[3],
                color = oklch(unpack(v24))
            });
        end;

        local v25 = u3();
        local v26 = { math.clamp(v25.l + u20 * 0.02, 0, 1), v25.c, v25.h };

        return table.freeze({
            l = v26[1],
            c = v26[2],
            h = v26[3],
            color = oklch(unpack(v26))
        }).color;
    end;

    return function() -- Line: 120
        -- upvalues: u27 (copy), oklch (ref)
        local v28 = u27(true);

        if v28.l > 0.65 then
            local v29 = { v28.l - 0.7, v28.c, v28.h };

            return table.freeze({
                l = v29[1],
                c = v29[2],
                h = v29[3],
                color = oklch(unpack(v29))
            }).color;
        end;

        local v30 = { v28.l + 0.7, v28.c, v28.h };

        return table.freeze({
            l = v30[1],
            c = v30[2],
            h = v30[3],
            color = oklch(unpack(v30))
        }).color;
    end;
end;

local function compute_fg_on_bg_low(u31: number) -- Line: 137
    -- upvalues: u3 (copy), u2 (copy), oklch (copy)
    local function _() -- Line: 58
        -- upvalues: u3 (ref), u2 (ref), u31 (copy)
        local v32 = u3();

        return u2({ math.clamp(v32.l + u31 * 0.02, 0, 1), v32.c, v32.h });
    end;

    local function u38(p33: boolean) -- Line: 82
        -- upvalues: u3 (ref), u31 (copy), oklch (ref)
        if p33 then
            local v34 = u3();
            local v35 = { math.clamp(v34.l + u31 * 0.02, 0, 1), v34.c, v34.h };

            return table.freeze({
                l = v35[1],
                c = v35[2],
                h = v35[3],
                color = oklch(unpack(v35))
            });
        end;

        local v36 = u3();
        local v37 = { math.clamp(v36.l + u31 * 0.02, 0, 1), v36.c, v36.h };

        return table.freeze({
            l = v37[1],
            c = v37[2],
            h = v37[3],
            color = oklch(unpack(v37))
        }).color;
    end;

    return function() -- Line: 139
        -- upvalues: u38 (copy), oklch (ref)
        local v39 = u38(true);

        if v39.l > 0.65 then
            local v40 = { v39.l - 0.4, v39.c, v39.h };

            return table.freeze({
                l = v40[1],
                c = v40[2],
                h = v40[3],
                color = oklch(unpack(v40))
            }).color;
        end;

        local v41 = { v39.l + 0.4, v39.c, v39.h };

        return table.freeze({
            l = v41[1],
            c = v41[2],
            h = v41[3],
            color = oklch(unpack(v41))
        }).color;
    end;
end;

local function compute_fg_on_acc_low(u42: number) -- Line: 156
    -- upvalues: u4 (copy), u2 (copy), oklch (copy)
    local function _() -- Line: 89
        -- upvalues: u4 (ref), u2 (ref), u42 (copy)
        local v43 = u4();

        return u2({ math.clamp(v43.l + u42 * 0.02, 0, 1), v43.c, v43.h });
    end;

    local function u49(p44: boolean) -- Line: 112
        -- upvalues: u4 (ref), u42 (copy), oklch (ref)
        if p44 then
            local v45 = u4();
            local v46 = { math.clamp(v45.l + u42 * 0.02, 0, 1), v45.c, v45.h };

            return table.freeze({
                l = v46[1],
                c = v46[2],
                h = v46[3],
                color = oklch(unpack(v46))
            });
        end;

        local v47 = u4();
        local v48 = { math.clamp(v47.l + u42 * 0.02, 0, 1), v47.c, v47.h };

        return table.freeze({
            l = v48[1],
            c = v48[2],
            h = v48[3],
            color = oklch(unpack(v48))
        }).color;
    end;

    return function() -- Line: 158
        -- upvalues: u49 (copy), oklch (ref)
        local v50 = u49(true);

        if v50.l > 0.65 then
            local v51 = { v50.l - 0.4, v50.c, v50.h };

            return table.freeze({
                l = v51[1],
                c = v51[2],
                h = v51[3],
                color = oklch(unpack(v51))
            }).color;
        end;

        local v52 = { v50.l + 0.4, v50.c, v50.h };

        return table.freeze({
            l = v52[1],
            c = v52[2],
            h = v52[3],
            color = oklch(unpack(v52))
        }).color;
    end;
end;

local function compute_fg_on_acc_high(u53: number) -- Line: 175
    -- upvalues: u4 (copy), u2 (copy), oklch (copy)
    local function _() -- Line: 89
        -- upvalues: u4 (ref), u2 (ref), u53 (copy)
        local v54 = u4();

        return u2({ math.clamp(v54.l + u53 * 0.02, 0, 1), v54.c, v54.h });
    end;

    local function u60(p55: boolean) -- Line: 112
        -- upvalues: u4 (ref), u53 (copy), oklch (ref)
        if p55 then
            local v56 = u4();
            local v57 = { math.clamp(v56.l + u53 * 0.02, 0, 1), v56.c, v56.h };

            return table.freeze({
                l = v57[1],
                c = v57[2],
                h = v57[3],
                color = oklch(unpack(v57))
            });
        end;

        local v58 = u4();
        local v59 = { math.clamp(v58.l + u53 * 0.02, 0, 1), v58.c, v58.h };

        return table.freeze({
            l = v59[1],
            c = v59[2],
            h = v59[3],
            color = oklch(unpack(v59))
        }).color;
    end;

    return function() -- Line: 177
        -- upvalues: u60 (copy), oklch (ref)
        local v61 = u60(true);

        if v61.l > 0.65 then
            local v62 = { v61.l - 0.7, v61.c, v61.h };

            return table.freeze({
                l = v62[1],
                c = v62[2],
                h = v62[3],
                color = oklch(unpack(v62))
            }).color;
        end;

        local v63 = { v61.l + 0.7, v61.c, v61.h };

        return table.freeze({
            l = v63[1],
            c = v63[2],
            h = v63[3],
            color = oklch(unpack(v63))
        }).color;
    end;
end;

local v117 = {
    __index = (function() -- Line: 211, Name: compute_theme
        -- upvalues: Font_fromName_ret (copy), Font_new_ret (copy), u3 (copy), u2 (copy), oklch (copy), u4 (copy)
        local v64 = {
            body = 18,
            header = 24,
            bg = {},
            acc = {},
            fg_on_bg_high = {},
            fg_on_bg_low = {},
            fg_on_acc_high = {},
            fg_on_acc_low = {},
            font = Font_fromName_ret,
            code = Font_new_ret
        };

        for i = -20, 20 do
            local function _() -- Line: 58
                -- upvalues: u3 (ref), u2 (ref), i (copy)
                local v65 = u3();

                return u2({ math.clamp(v65.l + i * 0.02, 0, 1), v65.c, v65.h });
            end;

            v64.bg[i] = function(p66: boolean) -- Line: 82
                -- upvalues: u3 (ref), i (copy), oklch (ref)
                if p66 then
                    local v67 = u3();
                    local v68 = { math.clamp(v67.l + i * 0.02, 0, 1), v67.c, v67.h };

                    return table.freeze({
                        l = v68[1],
                        c = v68[2],
                        h = v68[3],
                        color = oklch(unpack(v68))
                    });
                end;

                local v69 = u3();
                local v70 = { math.clamp(v69.l + i * 0.02, 0, 1), v69.c, v69.h };

                return table.freeze({
                    l = v70[1],
                    c = v70[2],
                    h = v70[3],
                    color = oklch(unpack(v70))
                }).color;
            end;

            local function _() -- Line: 89
                -- upvalues: u4 (ref), u2 (ref), i (copy)
                local v71 = u4();

                return u2({ math.clamp(v71.l + i * 0.02, 0, 1), v71.c, v71.h });
            end;

            v64.acc[i] = function(p72: boolean) -- Line: 112
                -- upvalues: u4 (ref), i (copy), oklch (ref)
                if p72 then
                    local v73 = u4();
                    local v74 = { math.clamp(v73.l + i * 0.02, 0, 1), v73.c, v73.h };

                    return table.freeze({
                        l = v74[1],
                        c = v74[2],
                        h = v74[3],
                        color = oklch(unpack(v74))
                    });
                end;

                local v75 = u4();
                local v76 = { math.clamp(v75.l + i * 0.02, 0, 1), v75.c, v75.h };

                return table.freeze({
                    l = v76[1],
                    c = v76[2],
                    h = v76[3],
                    color = oklch(unpack(v76))
                }).color;
            end;

            local function _() -- Line: 89
                -- upvalues: u4 (ref), u2 (ref), i (copy)
                local v77 = u4();

                return u2({ math.clamp(v77.l + i * 0.02, 0, 1), v77.c, v77.h });
            end;

            local function u83(p78: boolean) -- Line: 112
                -- upvalues: u4 (ref), i (copy), oklch (ref)
                if p78 then
                    local v79 = u4();
                    local v80 = { math.clamp(v79.l + i * 0.02, 0, 1), v79.c, v79.h };

                    return table.freeze({
                        l = v80[1],
                        c = v80[2],
                        h = v80[3],
                        color = oklch(unpack(v80))
                    });
                end;

                local v81 = u4();
                local v82 = { math.clamp(v81.l + i * 0.02, 0, 1), v81.c, v81.h };

                return table.freeze({
                    l = v82[1],
                    c = v82[2],
                    h = v82[3],
                    color = oklch(unpack(v82))
                }).color;
            end;

            v64.fg_on_acc_high[i] = function() -- Line: 177
                -- upvalues: u83 (copy), oklch (ref)
                local v84 = u83(true);

                if v84.l > 0.65 then
                    local v85 = { v84.l - 0.7, v84.c, v84.h };

                    return table.freeze({
                        l = v85[1],
                        c = v85[2],
                        h = v85[3],
                        color = oklch(unpack(v85))
                    }).color;
                end;

                local v86 = { v84.l + 0.7, v84.c, v84.h };

                return table.freeze({
                    l = v86[1],
                    c = v86[2],
                    h = v86[3],
                    color = oklch(unpack(v86))
                }).color;
            end;

            local function _() -- Line: 89
                -- upvalues: u4 (ref), u2 (ref), i (copy)
                local v87 = u4();

                return u2({ math.clamp(v87.l + i * 0.02, 0, 1), v87.c, v87.h });
            end;

            local function u93(p88: boolean) -- Line: 112
                -- upvalues: u4 (ref), i (copy), oklch (ref)
                if p88 then
                    local v89 = u4();
                    local v90 = { math.clamp(v89.l + i * 0.02, 0, 1), v89.c, v89.h };

                    return table.freeze({
                        l = v90[1],
                        c = v90[2],
                        h = v90[3],
                        color = oklch(unpack(v90))
                    });
                end;

                local v91 = u4();
                local v92 = { math.clamp(v91.l + i * 0.02, 0, 1), v91.c, v91.h };

                return table.freeze({
                    l = v92[1],
                    c = v92[2],
                    h = v92[3],
                    color = oklch(unpack(v92))
                }).color;
            end;

            v64.fg_on_acc_low[i] = function() -- Line: 158
                -- upvalues: u93 (copy), oklch (ref)
                local v94 = u93(true);

                if v94.l > 0.65 then
                    local v95 = { v94.l - 0.4, v94.c, v94.h };

                    return table.freeze({
                        l = v95[1],
                        c = v95[2],
                        h = v95[3],
                        color = oklch(unpack(v95))
                    }).color;
                end;

                local v96 = { v94.l + 0.4, v94.c, v94.h };

                return table.freeze({
                    l = v96[1],
                    c = v96[2],
                    h = v96[3],
                    color = oklch(unpack(v96))
                }).color;
            end;

            local function _() -- Line: 58
                -- upvalues: u3 (ref), u2 (ref), i (copy)
                local v97 = u3();

                return u2({ math.clamp(v97.l + i * 0.02, 0, 1), v97.c, v97.h });
            end;

            local function u103(p98: boolean) -- Line: 82
                -- upvalues: u3 (ref), i (copy), oklch (ref)
                if p98 then
                    local v99 = u3();
                    local v100 = { math.clamp(v99.l + i * 0.02, 0, 1), v99.c, v99.h };

                    return table.freeze({
                        l = v100[1],
                        c = v100[2],
                        h = v100[3],
                        color = oklch(unpack(v100))
                    });
                end;

                local v101 = u3();
                local v102 = { math.clamp(v101.l + i * 0.02, 0, 1), v101.c, v101.h };

                return table.freeze({
                    l = v102[1],
                    c = v102[2],
                    h = v102[3],
                    color = oklch(unpack(v102))
                }).color;
            end;

            v64.fg_on_bg_high[i] = function() -- Line: 120
                -- upvalues: u103 (copy), oklch (ref)
                local v104 = u103(true);

                if v104.l > 0.65 then
                    local v105 = { v104.l - 0.7, v104.c, v104.h };

                    return table.freeze({
                        l = v105[1],
                        c = v105[2],
                        h = v105[3],
                        color = oklch(unpack(v105))
                    }).color;
                end;

                local v106 = { v104.l + 0.7, v104.c, v104.h };

                return table.freeze({
                    l = v106[1],
                    c = v106[2],
                    h = v106[3],
                    color = oklch(unpack(v106))
                }).color;
            end;

            local function _() -- Line: 58
                -- upvalues: u3 (ref), u2 (ref), i (copy)
                local v107 = u3();

                return u2({ math.clamp(v107.l + i * 0.02, 0, 1), v107.c, v107.h });
            end;

            local function u113(p108: boolean) -- Line: 82
                -- upvalues: u3 (ref), i (copy), oklch (ref)
                if p108 then
                    local v109 = u3();
                    local v110 = { math.clamp(v109.l + i * 0.02, 0, 1), v109.c, v109.h };

                    return table.freeze({
                        l = v110[1],
                        c = v110[2],
                        h = v110[3],
                        color = oklch(unpack(v110))
                    });
                end;

                local v111 = u3();
                local v112 = { math.clamp(v111.l + i * 0.02, 0, 1), v111.c, v111.h };

                return table.freeze({
                    l = v112[1],
                    c = v112[2],
                    h = v112[3],
                    color = oklch(unpack(v112))
                }).color;
            end;

            v64.fg_on_bg_low[i] = function() -- Line: 139
                -- upvalues: u113 (copy), oklch (ref)
                local v114 = u113(true);

                if v114.l > 0.65 then
                    local v115 = { v114.l - 0.4, v114.c, v114.h };

                    return table.freeze({
                        l = v115[1],
                        c = v115[2],
                        h = v115[3],
                        color = oklch(unpack(v115))
                    }).color;
                end;

                local v116 = { v114.l + 0.4, v114.c, v114.h };

                return table.freeze({
                    l = v116[1],
                    c = v116[2],
                    h = v116[3],
                    color = oklch(unpack(v116))
                }).color;
            end;

            local _ = i;
        end;

        return v64;
    end)()
};

return setmetatable({
    settings = {
        background = u3,
        accent = u4
    }
}, v117);