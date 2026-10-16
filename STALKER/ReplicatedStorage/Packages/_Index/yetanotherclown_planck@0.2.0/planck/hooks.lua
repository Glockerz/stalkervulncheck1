-- Decompiled with Potassium's decompiler.

return {
    Hooks = {
        SystemAdd = "SystemAdd",
        SystemRemove = "SystemRemove",
        SystemReplace = "SystemReplace",
        SystemError = "SystemError",
        OuterSystemCall = "OuterSystemCall",
        InnerSystemCall = "InnerSystemCall",
        SystemCall = "SystemCall",
        PhaseAdd = "PhaseAdd",
        PhaseBegan = "PhaseBegan"
    },

    systemAdd = function(p1, p2) -- Line: 3, Name: systemAdd
        local v3 = {
            scheduler = p1,
            system = p2
        };

        for _, v in p1._hooks[p1.Hooks.SystemAdd] do
            local success, result = pcall(v, v3);

            if not success then
                warn("Unexpected error in hook:", result);
            end;
        end;
    end,

    systemRemove = function(p4, p5) -- Line: 18, Name: systemRemove
        local v6 = {
            scheduler = p4,
            system = p5
        };

        for _, v in p4._hooks[p4.Hooks.SystemRemove] do
            local success, result = pcall(v, v6);

            if not success then
                warn("Unexpected error in hook:", result);
            end;
        end;
    end,

    systemReplace = function(p7, p8, p9) -- Line: 33, Name: systemReplace
        local v10 = {
            scheduler = p7,
            new = p9,
            old = p8
        };

        for _, v in p7._hooks[p7.Hooks.SystemReplace] do
            local success, result = pcall(v, v10);

            if not success then
                warn("Unexpected error in hook:", result);
            end;
        end;
    end,

    systemCall = function(p11, p12, p13, p14) -- Line: 49, Name: systemCall
        local v15 = p11._hooks[p11.Hooks[p12]];

        if v15 then
            for _, v in v15 do
                p14 = v({
                    scheduler = nil,
                    system = p13,
                    nextFn = p14
                });

                if not p14 then
                    local debug_info_ret, v16 = debug.info(v, "sl");
                    warn((`{debug_info_ret}:{v16}: Expected 'SystemCall' hook to return a function`));
                end;
            end;
        end;

        p14();
    end,

    systemError = function(p17, p18, p19) -- Line: 72, Name: systemError
        local v20 = p17._hooks[p17.Hooks.SystemError];

        if v20 then
            for _, v in v20 do
                v({
                    scheduler = p17,
                    system = p18,
                    error = p19
                });
            end;
        end;
    end,

    phaseAdd = function(p21, p22) -- Line: 91, Name: phaseAdd
        local v23 = {
            scheduler = p21,
            phase = p22
        };

        for _, v in p21._hooks[p21.Hooks.PhaseAdd] do
            local success, result = pcall(v, v23);

            if not success then
                warn("Unexpected error in hook:", result);
            end;
        end;
    end,

    phaseBegan = function(p24, p25) -- Line: 106, Name: phaseBegan
        local v26 = {
            scheduler = p24,
            phase = p25
        };

        for _, v in p24._hooks[p24.Hooks.PhaseBegan] do
            local success, result = pcall(v, v26);

            if not success then
                warn("Unexpected error in hook:", result);
            end;
        end;
    end
};