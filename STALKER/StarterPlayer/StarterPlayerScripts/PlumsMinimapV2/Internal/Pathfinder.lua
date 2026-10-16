-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 4
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.Waypoints = {};
    v2.Neighbors = {};
    v2.NextSerial = 1;

    return v2;
end;

function u1.fromWaypoints(p3, p4) -- Line: 11
    -- upvalues: u1 (copy)
    local v5 = u1.new();
    local v6 = 0;

    for i, v in pairs(p3) do
        if v6 < i then
            v6 = i;
        end;

        v5.Waypoints[i] = v;
    end;

    v5.Neighbors = p4;
    v5.NextSerial = v6 + 1;

    return v5;
end;

function u1.SetWaypointPosition(p7: table, p8: number, p9: vector) -- Line: 25
    local v10 = p7.Waypoints[p8];
    local v11 = "No waypoint by serial: " .. tostring(p8);
    assert(v10, v11);
    p7.Waypoints[p8][1] = p9;
end;

function u1.SetWaypointLabel(p12: table, p13: number, p14: string) -- Line: 29
    local v15 = p12.Waypoints[p13];
    local v16 = "No waypoint by serial: " .. tostring(p13);
    assert(v15, v16);
    p12.Waypoints[p13][2] = p14;
end;

function u1.SetWaypointWeight(p17: table, p18: number, p19: number) -- Line: 33
    local v20 = p17.Waypoints[p18];
    local v21 = "No waypoint by serial: " .. tostring(p18);
    assert(v20, v21);
    p17.Waypoints[p18][3] = p19;
end;

function u1.AddWaypoint(p22: table, p23: vector, p24: string, p25: number) -- Line: 38
    local v26 = { p23, tostring(p24) or "", tonumber(p25) or 255 };
    local NextSerial = p22.NextSerial;
    p22.Waypoints[NextSerial] = v26;
    p22.Neighbors[NextSerial] = {};
    p22.NextSerial = p22.NextSerial + 1;

    return NextSerial;
end;

function u1.RemoveWaypoint(p27: table, p28: number) -- Line: 46
    p27.Waypoints[p28] = nil;

    for i, _ in pairs(p27.Neighbors[p28]) do
        p27:DisconnectWaypoints(p28, i);
    end;

    p27.Neighbors[p28] = nil;
end;

function u1.ConnectWaypoints(p29: table, p30: number, p31: number, p32: boolean) -- Line: 54
    if p30 == p31 then
        warn(tostring(p30) .. " == " .. tostring(p31));

        return;
    end;

    if not p29.Neighbors[p30] then
        warn("Waypoint by serial: " .. tostring(p30) .. " does not exist");

        return;
    end;

    if not p29.Neighbors[p31] then
        warn("Waypoint by serial: " .. tostring(p31) .. " does not exist");

        return;
    end;

    if p32 then
        p29.Neighbors[p30][p31] = true;
        p29.Neighbors[p31][p30] = true;

        return;
    end;

    p29.Neighbors[p30][p31] = true;
    p29.Neighbors[p31][p30] = false;
end;

function u1.DisconnectWaypoints(p33: table, p34: number, p35: number) -- Line: 66
    if not p33.Neighbors[p34] then
        warn("Waypoint by serial: " .. tostring(p34) .. " does not exist");

        return;
    end;

    if not p33.Neighbors[p35] then
        warn("Waypoint by serial: " .. tostring(p35) .. " does not exist");

        return;
    end;

    p33.Neighbors[p34][p35] = nil;
    p33.Neighbors[p35][p34] = nil;
end;

function u1.GetWaypointAtSerial(p36: table, p37: number) -- Line: 73
    local v38 = p36.Waypoints[p37];

    if v38 then
        return {
            Position = v38[1],
            Label = v38[2],
            Weight = v38[3]
        };
    end;

    warn("No waypoint at serial: " .. tostring(p37));

    return nil;
end;

function u1.GetNearestWaypoint(p39: table, p40: vector) -- Line: 86
    local v41 = (1 / 0);
    local v42 = nil;

    for i, v in pairs(p39.Waypoints) do
        local Magnitude = (v[1] - p40).Magnitude;

        if Magnitude < v41 then
            v42 = i;
            v41 = Magnitude;
        end;
    end;

    return v42;
end;

function u1.GetOrderedWaypoints(p43: table, p44: number, p45: vector, p46: function, p47: vector) -- Line: 99
    if StartPosition == p45 then
        return {
            {
                Label = "",
                Weight = 0,
                Position = p45
            }
        }, 0;
    end;

    local NearestWaypoint = p43:GetNearestWaypoint(p45);
    local _ = p43.Waypoints[p44];
    local v48 = p43.Waypoints[NearestWaypoint];
    local v49 = {
        [p44] = 0
    };
    local v50 = {};
    local v51 = {};

    while true do
        local v52 = (1 / 0);
        local v53 = nil;
        local v54 = nil;

        for i, v in pairs(v49) do
            local v55 = v + (p43.Waypoints[i][1] - v48[1]).Magnitude;

            if v55 < v52 then
                v54 = v;
                v53 = i;
                v52 = v55;
            end;
        end;

        v49[v53] = nil;
        v50[v53] = true;

        if v53 == NearestWaypoint then
            local v56 = NearestWaypoint;
            local v57 = {};

            while NearestWaypoint do
                local WaypointAtSerial = p43:GetWaypointAtSerial(NearestWaypoint);
                table.insert(v57, 1, WaypointAtSerial);

                if v51[NearestWaypoint] then
                    NearestWaypoint = v51[NearestWaypoint][1];
                else
                    NearestWaypoint = nil;
                end;
            end;

            table.insert(v57, {
                Label = "",
                Weight = 0,
                Position = p45
            });

            return v57, v51[v56][2];
        end;

        local v58 = p43.Waypoints[v53];

        for i, v in pairs(p43.Neighbors[v53]) do
            if v then
                local v59 = p43.Waypoints[i];
                local v60 = 0;

                if v53 == p44 and p47 then
                    local v61 = p47:Dot((v59[1] - v58[1]).Unit);

                    if v61 < -0.75 then
                        v60 = (1 - v61) * 10000000000000;
                    end;
                end;

                if not v50[i] then
                    if v49[i] then
                        local v62 = v49[i];

                        if v62 < v54 + v60 then
                            v51[i] = { v53, v62 };
                            v49[i] = v62;
                        end;
                    else
                        local v63 = v54 + (v59[1] - v58[1]).Magnitude + v59[3] + v60;
                        local _ = v63 + (v59[1] - v48[1]).Magnitude;
                        v51[i] = { v53, v63 };
                        v49[i] = v63;
                    end;
                end;
            end;
        end;
    end;
end;

return u1;