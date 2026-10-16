-- Decompiled with Potassium's decompiler.

local u1 = _G.UserInputService or game:GetService("UserInputService");
require("./types");
local u2 = require("./match");
local u3 = 1;

local function deadzone(p4: any, p5: number) -- Line: 14
    return p5 < (p4.deadzone or 0.3) and 0 or p5;
end;

local function getGamepad(p6) -- Line: 28
    return (p6.Value < Enum.UserInputType.Gamepad1.Value or p6.Value > Enum.UserInputType.Gamepad8.Value) and 1 or p6.Value - Enum.UserInputType.Gamepad1.Value + 1;
end;

local function _reset(p7: any, p8: number, p9: any) -- Line: 37
    p7.resets[p9] = { p8, false };
end;

local function read(p10: any, p11: number?) -- Line: 51
    local v12 = p10.vector and Vector3.new(0, 0, 0) or 0;

    return p10.current[p11 or 1] or v12, p10.previous[p11 or 1] or v12;
end;

local function pressing(p13: any, p14: number?) -- Line: 63
    local v15 = p13.vector and Vector3.new(0, 0, 0) or 0;
    local v16 = p13.current[p14 or 1] or v15;
    local _ = p13.previous[p14 or 1] or v15;

    if p13.vector then
        v16 = vector.magnitude(v16);
    end;

    return v16 ~= 0;
end;

local function changed(p17: any, p18: number?) -- Line: 76
    return p17.current[p18 or 1] ~= p17.previous[p18 or 1];
end;

local function pressed(p19: any, p20: number?) -- Line: 87
    local v21 = p19.current[p20 or 1] ~= p19.previous[p20 or 1];

    if v21 then
        local v22 = p19.vector and Vector3.new(0, 0, 0) or 0;
        local v23 = p19.current[p20 or 1] or v22;
        local _ = p19.previous[p20 or 1] or v22;

        if p19.vector then
            v23 = vector.magnitude(v23);
        end;

        v21 = v23 ~= 0;
    end;

    return v21;
end;

local function released(p24: any, p25: number?) -- Line: 98
    local v26 = p24.current[p25 or 1] ~= p24.previous[p25 or 1];

    if v26 then
        local v27 = p24.vector and Vector3.new(0, 0, 0) or 0;
        local v28 = p24.current[p25 or 1] or v27;
        local _ = p24.previous[p25 or 1] or v27;

        if p24.vector then
            v28 = vector.magnitude(v28);
        end;

        v26 = not (v28 ~= 0);
    end;

    return v26;
end;

local function hold(u29: any, p30: any, u31: number?) -- Line: 115
    -- upvalues: u3 (ref)
    local u32 = u3;
    u3 = u3 + 1;
    u29.active[u31 or 1][u32] = p30 or 1;

    return function() -- Line: 120
        -- upvalues: u29 (copy), u31 (copy), u32 (copy)
        u29.active[u31 or 1][u32] = nil;
    end;
end;

local function move(p33: any, p34: any, p35: number?) -- Line: 132
    -- upvalues: u3 (ref)
    local v36 = u3;
    u3 = u3 + 1;
    p33.active[p35 or 1][v36] = p34 or 1;
    p33.resets[v36] = { p35 or 1, false };
end;

local function map(u37, p38) -- Line: 153
    -- upvalues: u1 (copy), u2 (copy)
    for _, v in u37.connections do
        v:Disconnect();
    end;

    u37.vector = nil;
    local u39 = nil;

    local function setVector(p40: boolean, p41: any) -- Line: 162
        -- upvalues: u37 (copy), u39 (ref)
        if u37.vector ~= nil and u37.vector ~= p40 then
            local v42 = `{u39} was {u37.vector and "" or "not "}a vector input`;
            local v43 = `{p41} is {p40 and "" or "not "}a vector input`;
            error((`[Axis] Input axis cannot be both vector and scalar.\n\t({v42} and {v43})`));
        end;

        u37.vector = p40;
        u39 = p41;
    end;

    if next(p38) == nil then
        return;
    end;

    local v44 = {};
    u37.keyMap = p38;
    u37.inputMap = v44;
    local u45 = {};

    for i, v in p38 do
        local v46;

        if type(i) == "number" then
            v46 = v;
        else
            v46 = i;
        end;

        local u47 = type(i) == "number" and 1 or v;
        v44[v46] = u47;
        local v48 = type(u47) ~= "number";

        if v46 == Enum.UserInputType.MouseMovement then
            if u37.vector ~= nil and u37.vector ~= true then
                local v49 = `{u39} was {u37.vector and "" or "not "}a vector input`;
                local v50 = `{v46} is a vector input`;
                error((`[Axis] Input axis cannot be both vector and scalar.\n\t({v49} and {v50})`));
            end;

            u37.vector = true;
            u39 = v46;
            table.insert(u37.connections, u1.InputChanged:Connect(function(p51) -- Line: 189
                -- upvalues: u37 (copy), u47 (copy)
                if p51.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return;
                end;

                u37.active[1][Enum.UserInputType.MouseMovement] = vector.create(p51.Delta.X, -p51.Delta.Y) * u47;
                u37.resets[Enum.UserInputType.MouseMovement] = { 1, false };
            end));
        elseif v46 == Enum.UserInputType.MouseWheel then
            if u37.vector ~= nil and u37.vector ~= v48 then
                local v52 = `{u39} was {u37.vector and "" or "not "}a vector input`;
                local v53 = `{v46} is {v48 and "" or "not "}a vector input`;
                error((`[Axis] Input axis cannot be both vector and scalar.\n\t({v52} and {v53})`));
            end;

            u37.vector = v48;
            u39 = v46;
            table.insert(u37.connections, u1.InputChanged:Connect(function(p54: any, p55: boolean) -- Line: 198
                -- upvalues: u37 (copy), u47 (copy)
                if p55 then
                    return;
                end;

                if p54.UserInputType ~= Enum.UserInputType.MouseWheel then
                    return;
                end;

                u37.active[1][Enum.UserInputType.MouseWheel] = p54.Position.Z * u47;
                u37.resets[Enum.UserInputType.MouseWheel] = { 1, false };
            end));
        elseif v46 == Enum.KeyCode.Thumbstick1 then
            if u37.vector ~= nil and u37.vector ~= true then
                local v56 = `{u39} was {u37.vector and "" or "not "}a vector input`;
                local v57 = `{v46} is a vector input`;
                error((`[Axis] Input axis cannot be both vector and scalar.\n\t({v56} and {v57})`));
            end;

            u37.vector = true;
            u39 = v46;
            table.insert(u37.connections, u1.InputChanged:Connect(function(p58) -- Line: 211
                -- upvalues: u37 (copy), u47 (copy)
                if p58.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                    return;
                end;

                local Position = p58.Position;
                local UserInputType = p58.UserInputType;
                local X = Position.X;
                local Y = Position.Y;
                u37.active[(UserInputType.Value < Enum.UserInputType.Gamepad1.Value or UserInputType.Value > Enum.UserInputType.Gamepad8.Value) and 1 or UserInputType.Value - Enum.UserInputType.Gamepad1.Value + 1][Enum.KeyCode.Thumbstick1] = vector.create(X < (u37.deadzone or 0.3) and 0 or X, Y < (u37.deadzone or 0.3) and 0 or Y) * u47;
            end));
        elseif v46 == Enum.KeyCode.Thumbstick2 then
            if u37.vector ~= nil and u37.vector ~= true then
                local v59 = `{u39} was {u37.vector and "" or "not "}a vector input`;
                local v60 = `{v46} is a vector input`;
                error((`[Axis] Input axis cannot be both vector and scalar.\n\t({v59} and {v60})`));
            end;

            u37.vector = true;
            u39 = v46;
            table.insert(u37.connections, u1.InputChanged:Connect(function(p61) -- Line: 221
                -- upvalues: u37 (copy), u47 (copy)
                if p61.KeyCode ~= Enum.KeyCode.Thumbstick2 then
                    return;
                end;

                local Position = p61.Position;
                local UserInputType = p61.UserInputType;
                local X = Position.X;
                local Y = Position.Y;
                u37.active[(UserInputType.Value < Enum.UserInputType.Gamepad1.Value or UserInputType.Value > Enum.UserInputType.Gamepad8.Value) and 1 or UserInputType.Value - Enum.UserInputType.Gamepad1.Value + 1][Enum.KeyCode.Thumbstick2] = vector.create(X < (u37.deadzone or 0.3) and 0 or X, Y < (u37.deadzone or 0.3) and 0 or Y) * u47;
            end));
        elseif v46 == u1.TouchSwipe then
            if u37.vector ~= nil and u37.vector ~= true then
                local v62 = `{u39} was {u37.vector and "" or "not "}a vector input`;
                local v63 = `{v46} is a vector input`;
                error((`[Axis] Input axis cannot be both vector and scalar.\n\t({v62} and {v63})`));
            end;

            u37.vector = true;
            u39 = v46;
            table.insert(u37.connections, u1.TouchSwipe:Connect(function(p64) -- Line: 231
                -- upvalues: u37 (copy), u1 (ref), u47 (copy), u2 (ref)
                u37.active[1][u1.TouchSwipe] = u47 * u2(p64)({
                    Enum.SwipeDirection.Left,
                    Vector3.new(-1, 0, 0),
                    Enum.SwipeDirection.Right,
                    Vector3.new(1, 0, 0),
                    Enum.SwipeDirection.Up,
                    Vector3.new(0, 1, 0),
                    Enum.SwipeDirection.Down,
                    Vector3.new(0, -1, 0)
                });
            end));
        elseif v46 == u1.TouchPinch then
            if u37.vector ~= nil and u37.vector ~= v48 then
                local v65 = `{u39} was {u37.vector and "" or "not "}a vector input`;
                local v66 = `{v46} is {v48 and "" or "not "}a vector input`;
                error((`[Axis] Input axis cannot be both vector and scalar.\n\t({v65} and {v66})`));
            end;

            u37.vector = v48;
            u39 = v46;
            table.insert(u37.connections, u1.TouchPinch:Connect(function(p67: any, p68: number, p69: any, p70: any, p71: any) -- Line: 241
                -- upvalues: u37 (copy), u1 (ref)
                if p70 == Enum.UserInputState.End then
                    u37.active[1][u1.TouchPinch] = nil;

                    return;
                end;

                u37.active[1][u1.TouchPinch] = p68;
            end));
        else
            if u37.vector ~= nil and u37.vector ~= v48 then
                local v72 = `{u39} was {u37.vector and "" or "not "}a vector input`;
                local v73 = `{v46} is {v48 and "" or "not "}a vector input`;
                error((`[Axis] Input axis cannot be both vector and scalar.\n\t({v72} and {v73})`));
            end;

            u37.vector = v48;
            u39 = v46;
            table.insert(u45, v46);
        end;
    end;

    local function inputHappened(p74) -- Line: 254
        -- upvalues: u37 (copy), u45 (copy)
        local UserInputType = p74.UserInputType;
        local v75 = (UserInputType.Value < Enum.UserInputType.Gamepad1.Value or UserInputType.Value > Enum.UserInputType.Gamepad8.Value) and 1 or UserInputType.Value - Enum.UserInputType.Gamepad1.Value + 1;
        u37.active[v75] = u37.active[v75] or {};
        local v76 = u37.active[v75];

        for _, v in u45 do
            if p74.KeyCode == v or p74.UserInputType == v then
                local v77;

                if p74.UserInputState == Enum.UserInputState.Begin or p74.UserInputState == Enum.UserInputState.Change then
                    v77 = u37.inputMap[v];
                else
                    v77 = nil;
                end;

                v76[v] = v77;
            end;
        end;
    end;

    table.insert(u37.connections, u1.InputBegan:Connect(function(p78, p79) -- Line: 268
        -- upvalues: inputHappened (copy)
        if not p79 then
            inputHappened(p78);
        end;
    end));
    table.insert(u37.connections, u1.InputEnded:Connect(inputHappened));
end;

local function update(p80) -- Line: 282
    local v81 = p80.vector and Vector3.new(0, 0, 0) or 0;

    for i, v in p80.resets do
        if v[2] then
            p80.active[v[1]][i] = nil;
            p80.resets[i] = nil;
        else
            v[2] = true;
        end;
    end;

    for i, v in p80.active do
        p80.previous[i] = p80.current[i] or v81;
        local v82 = nil;

        for _, v2 in v do
            if v82 == nil then
                v82 = v2;
            else
                v82 = v82 + v2;
            end;
        end;

        p80.current[i] = v82 or v81;
    end;
end;

return function(p83) -- Line: 313, Name: new
    -- upvalues: read (copy), pressing (copy), pressed (copy), released (copy), changed (copy), hold (copy), map (copy), update (copy), move (copy)
    local v84 = {
        vector = false,
        current = {},
        previous = {},
        active = { {} },
        resets = {},
        connections = {},
        inputMap = p83,
        deadzone = p83.deadzone,
        read = read,
        pressing = pressing,
        pressed = pressed,
        released = released,
        changed = changed,
        hold = hold,
        map = map,
        update = update,
        move = move,
        keyMap = p83
    };
    map(v84, p83);

    return v84;
end;