-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local u1 = {
    TABS = { "All", "Weapons", "Ammo", "Helmets", "Body Armor", "Face & Eyes", "Belts & Packs", "Uniforms", "Medical", "Food", "Barter", "Cosmetics", "Storage", "Other" },
    TYPE_TO_TAB = {
        Primary = "Weapons",
        Sidearm = "Weapons",
        Melee = "Weapons",
        UpgradeKit = "Weapons",
        Ammo = "Ammo",
        AmmoPack = "Ammo",
        HeadGear = "Helmets",
        BodyGear = "Body Armor",
        ArmorInsert = "Body Armor",
        FaceWear = "Face & Eyes",
        EyeWear = "Face & Eyes",
        NightOptical = "Face & Eyes",
        MaskFilter = "Face & Eyes",
        BeltGear = "Belts & Packs",
        Backpack = "Belts & Packs",
        Uniform = "Uniforms",
        Medical = "Medical",
        Injector = "Medical",
        Vial = "Medical",
        FoodAndDrink = "Food",
        Barter = "Barter",
        HighValue = "Barter",
        Watch = "Cosmetics",
        Patch = "Cosmetics",
        StorageBox = "Storage"
    }
};

local function dataFor(p2) -- Line: 67
    -- upvalues: ItemDatabase (copy)
    local v3 = rawget(ItemDatabase, p2);

    return type(v3) == "table" and v3 and v3 or nil;
end;

function u1.CategoryOf(p4: string) -- Line: 74
    -- upvalues: ItemDatabase (copy), u1 (copy)
    local v5 = rawget(ItemDatabase, p4);
    local v6 = type(v5) == "table" and v5 and v5 or nil;

    return v6 and u1.TYPE_TO_TAB[v6.ItemType] or "Other";
end;

local u7 = {};

local function haystack(p8: string) -- Line: 83
    -- upvalues: u7 (copy), ItemDatabase (copy)
    local v9 = u7[p8];

    if v9 then
        return v9;
    end;

    local v10 = rawget(ItemDatabase, p8);
    local v11 = type(v10) == "table" and v10 and v10 or nil;
    local v12 = { p8 };

    if v11 then
        local v13 = tostring(v11.Name or "");
        table.insert(v12, v13);

        if v11.ammoType then
            local v14 = tostring(v11.ammoType);
            table.insert(v12, v14);
        end;

        local MagType = v11.MagType;

        if MagType then
            local v15 = rawget(ItemDatabase, v11.MagType);
            MagType = type(v15) == "table" and v15 and v15 or nil;
        end;

        if MagType and MagType.ammoType then
            local v16 = tostring(MagType.ammoType);
            table.insert(v12, v16);
        end;
    end;

    local string_lower_ret = string.lower(table.concat(v12, " "));
    u7[p8] = string_lower_ret;

    return string_lower_ret;
end;

function u1.Matches(p17: string, p18: string?) -- Line: 102
    -- upvalues: haystack (copy)
    if p18 == nil then
        return true;
    end;

    local v19 = haystack(p17);

    for i in string.gmatch(string.lower(p18), "%S+") do
        if not string.find(v19, i, 1, true) then
            return false;
        end;
    end;

    return true;
end;

return u1;