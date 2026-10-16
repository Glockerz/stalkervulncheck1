-- Decompiled with Potassium's decompiler.

return {
    new = function(p1) -- Line: 3, Name: new
        local u2 = tick();
        local u3 = p1 or 0;
        local u4 = p1 and (0 * p1 or 0) or 0;
        local u5 = p1 or 0;
        local u6 = 1;
        local u7 = 1;

        local function positionvelocity(p8) -- Line: 11
            -- upvalues: u2 (ref), u3 (ref), u5 (ref), u7 (ref), u6 (ref), u4 (ref)
            local v9 = p8 - u2;
            local v10 = u3 - u5;

            if u7 == 0 then
                return u3, 0;
            end;

            if u6 >= 1 then
                local v11 = u4 / u7 + v10;
                local v12 = 2.718281828459045 ^ (u7 * v9);

                return u5 + (v10 + v11 * u7 * v9) / v12, u7 * (v11 - v10 - v11 * u7 * v9) / v12;
            end;

            local v13 = (1 - u6 * u6) ^ 0.5;
            local v14 = (u4 / u7 + u6 * v10) / v13;
            local math_cos_ret = math.cos(v13 * u7 * v9);
            local math_sin_ret = math.sin(v13 * u7 * v9);
            local v15 = 2.718281828459045 ^ (u6 * u7 * v9);

            return u5 + (v10 * math_cos_ret + v14 * math_sin_ret) / v15, u7 * ((v13 * v14 - u6 * v10) * math_cos_ret - (v13 * v10 + u6 * v14) * math_sin_ret) / v15;
        end;

        return setmetatable({
            accelerate = function(p16, p17) -- Line: 34, Name: accelerate
                -- upvalues: positionvelocity (copy), u3 (ref), u4 (ref), u2 (ref)
                local v18 = tick();
                local v19, v20 = positionvelocity(v18);
                u3 = v19;
                u4 = v20 + p17;
                u2 = v18;
            end
        }, {
            __index = function(p21, p22) -- Line: 44, Name: __index
                -- upvalues: positionvelocity (copy), u2 (ref), u3 (ref), u5 (ref), u7 (ref), u6 (ref), u4 (ref)
                if p22 == "value" or (p22 == "position" or p22 == "p") then
                    local v23, _ = positionvelocity(tick());

                    return v23;
                end;

                if p22 == "velocity" or p22 == "v" then
                    local _, v24 = positionvelocity(tick());

                    return v24;
                end;

                if p22 == "acceleration" or p22 == "a" then
                    local v25 = tick() - u2;
                    local v26 = u3 - u5;

                    if u7 == 0 then
                        return 0;
                    end;

                    if u6 >= 1 then
                        local v27 = u4 / u7 + v26;

                        return u7 * u7 * (v26 - 2 * v27 + v27 * u7 * v25) / 2.718281828459045 ^ (u7 * v25);
                    end;

                    local v28 = (1 - u6 * u6) ^ 0.5;
                    local v29 = (u4 / u7 + u6 * v26) / v28;

                    return u7 * u7 * ((u6 * u6 * v26 - v28 * 2 * u6 * v29 - v28 * v28 * v26) * cos(v28 * u7 * v25) + (u6 * u6 * v29 + v28 * 2 * u6 * v26 - v28 * v28 * v29) * sin(v28 * u7 * v25)) / 2.718281828459045 ^ (u6 * u7 * v25);
                end;

                if p22 == "target" or p22 == "t" then
                    return u5;
                end;

                if p22 == "damper" or p22 == "d" then
                    return u6;
                end;

                if p22 == "speed" or p22 == "s" then
                    return u7;
                end;

                error(p22 .. " is not a valid member of spring", 0);
            end,

            __newindex = function(p30, p31, p32) -- Line: 85, Name: __newindex
                -- upvalues: positionvelocity (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u2 (ref)
                local v33 = tick();

                if p31 == "value" or (p31 == "position" or p31 == "p") then
                    local _, v34 = positionvelocity(v33);
                    u3 = p32;
                    u4 = v34;
                elseif p31 == "velocity" or p31 == "v" then
                    local v35, _ = positionvelocity(v33);
                    u3 = v35;
                    u4 = p32;
                elseif p31 == "acceleration" or p31 == "a" then
                    local v36, v37 = positionvelocity(v33);
                    u3 = v36;
                    u4 = v37 + p32;
                elseif p31 == "target" or p31 == "t" then
                    local v38, v39 = positionvelocity(v33);
                    u3 = v38;
                    u4 = v39;
                    u5 = p32;
                elseif p31 == "damper" or p31 == "d" then
                    local v40, v41 = positionvelocity(v33);
                    u3 = v40;
                    u4 = v41;
                    u6 = p32 < 0 and 0 or (p32 < 1 and p32 and p32 or 1);
                elseif p31 == "speed" or p31 == "s" then
                    local v42, v43 = positionvelocity(v33);
                    u3 = v42;
                    u4 = v43;
                    u7 = p32 < 0 and 0 or p32;
                else
                    error(p31 .. " is not a valid member of spring", 0);
                end;

                u2 = v33;
            end
        });
    end
};