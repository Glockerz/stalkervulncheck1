-- Decompiled with Potassium's decompiler.

local u1 = {};
local PlaceConfig = require(script.Parent:WaitForChild("PlaceConfig"));
u1.Cordon = {
    PlumsMap = "Map_Cordon",
    DefaultZoom = 1200,
    Traders = { {
            Id = "Crow",
            WorldPos = Vector3.new(-42, 7, 54),
            Label = "Crow"
        } },
    Doctors = { {
            Id = "ZoneDoctor",
            WorldPos = Vector3.new(-54, 6, 65),
            Label = "Zone Doctor"
        } },
    Stashes = { {
            Id = "Stash_Cordon_405_-568",
            WorldPos = Vector3.new(405, 11, -568),
            Label = "Stash"
        }, {
            Id = "Stash_Cordon_-79_-2740",
            WorldPos = Vector3.new(-78, 28, -2739),
            Label = "Stash"
        }, {
            Id = "Stash_Cordon_1246_-1370",
            WorldPos = Vector3.new(1247, 3, -1370),
            Label = "Stash"
        } },
    Locations = {
        {
            Name = "Abandoned Military Refueling Depot",
            WorldPos = Vector3.new(682.1, 23.8, 607.5),
            Size = Vector3.new(272.2, 123.4, 306.5)
        },
        {
            Name = "Bandit Camp",
            WorldPos = Vector3.new(616.2, -10.8, -887),
            Size = Vector3.new(225.4, 49.1, 207.6)
        },
        {
            Name = "Checkpoint to Outskirts",
            WorldPos = Vector3.new(146.3, 15.8, -3136.3),
            Size = Vector3.new(147.8, 102.3, 154.3)
        },
        {
            Name = "Construction Yard",
            WorldPos = Vector3.new(117.6, 39.4, -1130.9),
            Size = Vector3.new(119, 49.1, 144.6)
        },
        {
            Name = "Cordon Entrance",
            WorldPos = Vector3.new(350.6, 23.8, 728.5),
            Size = Vector3.new(83.2, 123.4, 132.9)
        },
        {
            Name = "Military Camp",
            WorldPos = Vector3.new(-148.5, 19.5, -506.5),
            Size = Vector3.new(134.6, 75.1, 158.9)
        },
        {
            Name = "Military Watchtower",
            WorldPos = Vector3.new(1073.7, 38.7, -746.5),
            Size = Vector3.new(182.1, 148.2, 129.8)
        },
        {
            Name = "Rookie Village",
            WorldPos = Vector3.new(-30.1, 30, 34.8),
            Size = Vector3.new(240, 54.2, 395.8)
        },
        {
            Name = "The Gauntlet",
            WorldPos = Vector3.new(-147.1, 12.5, -1342.2),
            Size = Vector3.new(322.2, 123.4, 342.2)
        },
        {
            Name = "Trailer Park Encampment",
            WorldPos = Vector3.new(163.6, 17.9, -576.6),
            Size = Vector3.new(94.1, 49.1, 103.1)
        },
        {
            Name = "Tunnel To Darkscape",
            WorldPos = Vector3.new(1679.6, 38.7, -1215.7),
            Size = Vector3.new(222.3, 148.2, 217.3)
        },
        {
            Name = "Warehouses",
            WorldPos = Vector3.new(-28.5, 15.8, -2148.3),
            Size = Vector3.new(147.8, 102.3, 154.3)
        }
    },
    Anomalies = {},
    Camps = {}
};
u1["Great Swamps"] = {
    PlumsMap = "Map_Swamps",
    DefaultZoom = 350,
    Traders = { {
            Id = "Bartender",
            WorldPos = Vector3.new(2082, 53, -1976),
            Label = "Bartender"
        }, {
            Id = "Nimsk",
            WorldPos = Vector3.new(2225, 51, -2111),
            Label = "Nimsk"
        }, {
            Id = "Solokov",
            WorldPos = Vector3.new(2230, 53, -1962),
            Label = "Solokov"
        }, {
            Id = "Technician",
            WorldPos = Vector3.new(2090, 56, -2069),
            Label = "Technician"
        } },
    Doctors = { {
            Id = "Kovalenko",
            WorldPos = Vector3.new(2151, 53, -1971),
            Label = "Dr. Kovalenko"
        } },
    Stashes = {},
    Locations = {
        {
            Name = "Abandoned Church",
            WorldPos = Vector3.new(-531, 62.7, -1103.4),
            Size = Vector3.new(344.5, 45.6, 292.8)
        },
        {
            Name = "Clear Sky Hidden Base (Safezone)",
            WorldPos = Vector3.new(2136.7, 65.3, -2048.8),
            Size = Vector3.new(240, 54.2, 349.1)
        },
        {
            Name = "Clinic",
            WorldPos = Vector3.new(721.6, 67.2, 1681),
            Size = Vector3.new(212.5, 57.3, 219)
        },
        {
            Name = "Convoy Village",
            WorldPos = Vector3.new(1951.5, 67.2, 1240.3),
            Size = Vector3.new(366.1, 57.3, 275)
        },
        {
            Name = "Fishing Cabins",
            WorldPos = Vector3.new(-2651.6, 73.8, 2647.4),
            Size = Vector3.new(353.4, 70.5, 314.3)
        },
        {
            Name = "Gravity Hamlet",
            WorldPos = Vector3.new(1585.8, 67.2, 1782),
            Size = Vector3.new(366.1, 57.3, 275)
        },
        {
            Name = "Lower Farmstead",
            WorldPos = Vector3.new(-96.9, 67.2, 1773.6),
            Size = Vector3.new(180.6, 57.3, 235.7)
        },
        {
            Name = "Metal Yard",
            WorldPos = Vector3.new(1030.8, 72, -1649.3),
            Size = Vector3.new(297.5, 45.6, 210.4)
        },
        {
            Name = "Military Barracks",
            WorldPos = Vector3.new(-1285.4, 67.2, 1576.9),
            Size = Vector3.new(216.8, 57.3, 258.8)
        },
        {
            Name = "Mobile Homes",
            WorldPos = Vector3.new(912.1, 67.2, 2107.5),
            Size = Vector3.new(128.2, 57.3, 76.4)
        },
        {
            Name = "Northern Village",
            WorldPos = Vector3.new(2476, 67.2, 2568.6),
            Size = Vector3.new(366.1, 57.3, 275)
        },
        {
            Name = "Pumping Station",
            WorldPos = Vector3.new(1280.6, 66.8, -43.9),
            Size = Vector3.new(297.5, 56, 210.4)
        },
        {
            Name = "Southern Village",
            WorldPos = Vector3.new(-2038, 73.8, -1248.9),
            Size = Vector3.new(353.4, 70.5, 495.8)
        },
        {
            Name = "Storage Facility",
            WorldPos = Vector3.new(3354.3, 66.7, -955.5),
            Size = Vector3.new(369.3, 56.3, 227.7)
        },
        {
            Name = "Sunken Car Depot",
            WorldPos = Vector3.new(-384.4, 67.2, 881.7),
            Size = Vector3.new(265.1, 57.3, 235.7)
        },
        {
            Name = "Upper Farmstead",
            WorldPos = Vector3.new(116.5, 67.2, 2175.2),
            Size = Vector3.new(180.6, 57.3, 235.7)
        },
        {
            Name = "Village of Fire",
            WorldPos = Vector3.new(-475.1, 83.9, 298.7),
            Size = Vector3.new(265.1, 57.3, 235.7)
        },
        {
            Name = "Watchtower 2",
            WorldPos = Vector3.new(472.6, 73.8, -1044.3),
            Size = Vector3.new(101.5, 70.5, 73.5)
        },
        {
            Name = "Watchtower 3",
            WorldPos = Vector3.new(3081.1, 73.8, 94.5),
            Size = Vector3.new(101.5, 70.5, 73.5)
        },
        {
            Name = "Water Pump",
            WorldPos = Vector3.new(-74.9, 67.2, 3001.2),
            Size = Vector3.new(128.2, 57.3, 181.3)
        },
        {
            Name = "Water Tower Village",
            WorldPos = Vector3.new(1522, 67.2, 954.8),
            Size = Vector3.new(366.1, 57.3, 351.7)
        }
    },
    Anomalies = {},
    Camps = {}
};
u1._regions = {
    Cordon = u1.Cordon,
    ["Great Swamps"] = u1["Great Swamps"]
};

function u1.CurrentZone() -- Line: 151
    -- upvalues: PlaceConfig (copy)
    return PlaceConfig.Name;
end;

function u1.GetRegion(p2) -- Line: 169
    -- upvalues: u1 (copy)
    if p2 then
        return u1._regions[p2];
    end;

    return nil;
end;

function u1.FindLocation(p3, p4) -- Line: 178
    -- upvalues: u1 (copy)
    if not p4 then
        return nil;
    end;

    local Region = u1.GetRegion(p3);

    if not Region then
        return nil;
    end;

    for _, v in ipairs(Region.Locations or {}) do
        if v.Name == p4 then
            return v.WorldPos;
        end;
    end;

    return nil;
end;

return u1;