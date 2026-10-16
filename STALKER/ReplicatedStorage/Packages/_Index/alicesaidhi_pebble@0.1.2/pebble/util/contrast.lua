-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.vide);
local apcaw3 = require(script.Parent.Parent.libraries.apcaw3);
local oklch = require(script.Parent.oklch);
local derive = vide.derive;
local read = vide.read;

local function unwrap(p1) -- Line: 80
    while type(p1) == "function" do
        p1 = p1();
    end;

    return p1;
end;

return {
    min_contrast = function(p2: table) -- Line: 8, Name: min_contrast
        -- upvalues: derive (copy), read (copy)
        local size = p2.size;
        local u3 = p2.weight or 400;
        local body = p2.body;

        if not (size or u3) then
            return 0;
        end;

        local u4 = {
            [12] = { (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0) },
            [14] = { (1 / 0), (1 / 0), (1 / 0), 100, 100, 90, 75, (1 / 0), (1 / 0) },
            [15] = { (1 / 0), (1 / 0), (1 / 0), 100, 90, 75, 70, (1 / 0), (1 / 0) },
            [16] = { (1 / 0), (1 / 0), (1 / 0), 90, 75, 70, 60, 60, (1 / 0) },
            [18] = { (1 / 0), (1 / 0), 100, 75, 70, 60, 55, 55, 55 },
            [21] = { (1 / 0), (1 / 0), 90, 70, 60, 55, 50, 50, 50 },
            [24] = { (1 / 0), (1 / 0), 75, 60, 55, 50, 45, 45, 55 },
            [28] = { (1 / 0), 100, 70, 55, 50, 45, 43, 43, 43 },
            [32] = { (1 / 0), 90, 65, 50, 45, 43, 40, 40, 40 },
            [36] = { (1 / 0), 75, 60, 45, 43, 40, 38, 38, 38 },
            [42] = { 100, 70, 55, 43, 40, 38, 35, 35, 35 },
            [48] = { 90, 60, 50, 40, 38, 35, 33, 33, 33 },
            [60] = { 75, 55, 45, 37, 35, 33, 30, 30, 30 },
            [72] = { 60, 50, 40, 35, 33, 30, 30, 30, 30 },
            [96] = { 50, 45, 35, 33, 30, 30, 30, 30, 30 }
        };
        local u5 = {
            [12] = { (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0) },
            [14] = { (1 / 0), (1 / 0), (1 / 0), 100, 100, 90, 75, (1 / 0), (1 / 0) },
            [15] = { (1 / 0), (1 / 0), (1 / 0), 100, 90, 90, 85, (1 / 0), (1 / 0) },
            [16] = { (1 / 0), (1 / 0), (1 / 0), 90, 75, 85, 75, (1 / 0), (1 / 0) },
            [18] = { (1 / 0), (1 / 0), 100, 75, 85, 75, 70, (1 / 0), (1 / 0) },
            [21] = { (1 / 0), (1 / 0), 90, 70, 75, 70, 65, (1 / 0), (1 / 0) },
            [24] = { (1 / 0), (1 / 0), 75, 75, 70, 65, 60, (1 / 0), (1 / 0) },
            [28] = { (1 / 0), (1 / 0), 85, 70, 65, 60, 58, (1 / 0), (1 / 0) },
            [32] = { (1 / 0), (1 / 0), 80, 65, 60, 58, 55, (1 / 0), (1 / 0) },
            [36] = { (1 / 0), (1 / 0), 75, 60, 58, 55, 52, (1 / 0), (1 / 0) },
            [42] = { (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0) },
            [48] = { (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0) },
            [60] = { (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0) },
            [72] = { (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0) },
            [96] = { (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0), (1 / 0) }
        };

        return derive(function() -- Line: 56
            -- upvalues: read (ref), body (copy), u5 (copy), u4 (copy), size (copy), u3 (copy)
            local v6;

            if read(body) then
                v6 = u5;
            else
                v6 = u4;
            end;

            local v7 = v6[read(size)];

            if not v7 then
                return (1 / 0);
            end;

            local v8 = read(u3);
            local v9 = 400;

            if type(v8) == "number" then
                v9 = v8;
            elseif typeof(v8) == "Font" then
                v9 = v8.Weight.Value;
            end;

            return v7[v9 // 100] or (1 / 0);
        end);
    end,

    get_appropriate_color = function(u10: table) -- Line: 93, Name: get_appropriate_color
        -- upvalues: oklch (copy), apcaw3 (copy)
        return function() -- Line: 100
            -- upvalues: u10 (copy), oklch (ref), apcaw3 (ref)
            local min_contrast = u10.min_contrast;

            while type(min_contrast) == "function" do
                min_contrast = min_contrast();
            end;

            local elevation = u10.elevation;

            while type(elevation) == "function" do
                elevation = elevation();
            end;

            local v11 = elevation or 0;
            local background = u10.background;

            while type(background) == "function" do
                background = background();
            end;

            if background == nil then
                local foreground = u10.foreground;

                while type(foreground) == "function" do
                    foreground = foreground();
                end;

                local v12 = foreground[1];
                local v13, v14, v15 = unpack(v12, 1, 3);
                local v16, v17, v18 = unpack(v12, 4, 6);

                return oklch(v13 + v11 * (v16 or 0), v14 + v11 * (v17 or 0), v15 + v11 * (v18 or 0));
            end;

            if min_contrast == (1 / 0) then
                warn("min contrast is invalid");
            end;

            local Color3_new_ret = Color3.new();
            local foreground = u10.foreground;
            local v19 = -1;

            while type(foreground) == "function" do
                foreground = foreground();
            end;

            for _, v in foreground do
                local v20, v21, v22 = unpack(v, 1, 3);
                local v23, v24, v25 = unpack(v, 4, 6);
                local v26 = oklch(v20 + v11 * (v23 or 0), v21 + v11 * (v24 or 0), v22 + v11 * (v25 or 0));
                local v27 = apcaw3.calcAPCA(v26, background, nil, 1, true);
                local math_abs_ret = math.abs(v27);

                if v19 < math_abs_ret then
                    Color3_new_ret = v26;
                    v19 = math_abs_ret;
                end;

                if min_contrast <= math_abs_ret then
                    return v26;
                end;
            end;

            return Color3_new_ret;
        end;
    end
};