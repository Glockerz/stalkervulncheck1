-- Decompiled with Potassium's decompiler.

local u1 = {
    TABS = { {
            id = "Supporter",
            label = "SUPPORTER"
        }, {
            id = "Faction",
            label = "FACTION PACKS"
        }, {
            id = "Bundles",
            label = "BUNDLES"
        }, {
            id = "Skins",
            label = "SKINS"
        }, {
            id = "Stash",
            label = "STASH"
        } },
    FACTION_KEYS = { "MercenaryFactionUniforms", "DutyFactionUniforms", "FreedomFactionUniforms", "ClearSkyFactionUniforms" },
    LOADOUT_KEYS = { "DutySentinel", "ShadowOfTheZoneMercenary", "FreedomVanguard", "FreedomSEVABundle", "MercenaryACEBundle", "PSZ9MdSEVABundle", "MilitaryFairwayBundle", "MonolithFanaticBundle", "ClearSkyMarshwalkerBundle" }
};

local function itemOf(p2, p3) -- Line: 31
    local v4 = p2[p3];

    return type(v4) == "table" and v4 and v4 or nil;
end;

local function nameOf(p5, p6) -- Line: 36
    local v7 = p5[p6];
    local v8 = type(v7) == "table" and v7 and v7 or nil;

    if v8 then
        p6 = v8.Name or p6;
    end;

    return p6;
end;

local function plural(p9, p10) -- Line: 41
    return ("%d %s%s"):format(p9, p10, p9 == 1 and "" or "s");
end;

local function allOwned(p11, p12) -- Line: 45
    if #p12 == 0 then
        return false;
    end;

    for _, v in ipairs(p12) do
        if not p11[v] then
            return false;
        end;
    end;

    return true;
end;

function u1.Build(p13) -- Line: 53
    -- upvalues: plural (copy), u1 (copy)
    local SupporterCatalog = p13.SupporterCatalog;
    local SkinCatalog = p13.SkinCatalog;
    local StashTierConfig = p13.StashTierConfig;
    local ItemDatabase = p13.ItemDatabase;
    local u14 = p13.ownedSet or {};
    local u15 = {};
    local v16 = SupporterCatalog.Tiers and SupporterCatalog.Tiers.MasterStalker;
    local u17 = {};
    local v18 = {};

    for _, v in ipairs(v16 and (v16.UniformPacks or {}) or {}) do
        u17[v] = true;
        local v19 = SkinCatalog.Packs and SkinCatalog.Packs[v];

        for _, v2 in ipairs(v19 and v19.Skins or {}) do
            v18[v2] = true;
        end;
    end;

    for _, v in ipairs(v16 and v16.ExclusiveSkins or {}) do
        v18[v] = true;
    end;

    local v20 = p13.tierKey and SupporterCatalog.Tiers and SupporterCatalog.Tiers[p13.tierKey];
    local v21 = v20 and v20.Level or 0;

    for _, v in ipairs(SupporterCatalog.TierOrder or {}) do
        local v22 = SupporterCatalog.Tiers[v];

        if v22 then
            local v23 = { ("Stash +%d tiers, kept through wipes"):format(v22.StashTierBonus or 0), "Respawn loadout" };

            if v22.ChatPrefix and v22.ChatPrefix ~= "" then
                table.insert(v23, v22.ChatPrefix .. " chat tag");
            end;

            local v24 = #(v22.UniformPacks or {});

            if v24 > 0 then
                table.insert(v23, plural(v24, "faction uniform pack"));
            elseif v == "Veteran" then
                table.insert(v23, "One faction uniform pack of your choice");
            end;

            local v25 = #(v22.ExclusiveSkins or {});

            if v25 > 0 then
                table.insert(v23, plural(v25, "exclusive skin"));
            end;

            if v22.BadgeID and v22.BadgeID ~= 0 then
                table.insert(v23, "Supporter badge");
            end;

            local v26 = {
                tab = "Supporter",
                subtitle = "SUPPORTER TIER",
                kind = "pass",
                ownedLabel = "OWNED",
                includedWithMaster = false,
                id = "sup:" .. v,
                name = v22.DisplayName or v,
                blurb = v22.Blurb or "Supports the game. Every perk stays through wipes.",
                bullets = v23,
                chip = v22.Chip,
                robloxId = v22.GamepassID or 0,
                giftId = v22.GiftProductID or 0,
                isOwned = (v22.Level or 0) <= v21,
                previewPack = v .. "Pack"
            };
            local v27 = {};
            v27[1] = v22.ExclusiveSkins and v22.ExclusiveSkins[#v22.ExclusiveSkins];
            v26.previewSkins = v27;
            table.insert(u15, v26);
        end;
    end;

    local function packs(p28, p29, p30, p31, p32) -- Line: 102
        -- upvalues: SkinCatalog (copy), ItemDatabase (copy), u17 (copy), u15 (copy), u14 (copy)
        for _, v in ipairs(p28) do
            local v33 = SkinCatalog.Packs and SkinCatalog.Packs[v];

            if v33 then
                local v34 = v33.Skins or {};
                local v35 = v;
                local v36 = {};

                for _, v2 in ipairs(v34) do
                    local v37 = ItemDatabase[v2];
                    local v38 = type(v37) == "table" and v37 and v37 or nil;
                    local v39;

                    if v38 then
                        v39 = v38.Name or v2;
                    else
                        v39 = v2;
                    end;

                    table.insert(v36, v39 .. " skin");
                end;

                local v40 = u17[v35] == true;

                if v40 then
                    table.insert(v36, "Included with Master Stalker");
                end;

                local v41 = {
                    kind = "pass",
                    ownedLabel = "OWNED",
                    id = p31 .. v35,
                    tab = p29,
                    name = v33.DisplayName or v35,
                    subtitle = p30,
                    blurb = v33.Blurb or p32,
                    bullets = v36,
                    chip = v33.Chip,
                    robloxId = v33.GamepassID or 0,
                    giftId = v33.GiftProductID or 0
                };
                local v42 = u14;
                local v43;

                if #v34 == 0 then
                    v43 = false;
                else
                    v43 = true;

                    for _, v2 in ipairs(v34) do
                        if not v42[v2] then
                            v43 = false;
                            break;
                        end;
                    end;
                end;

                v41.isOwned = v43;
                v41.includedWithMaster = v40;
                v41.previewPack = v35 .. "Pack";
                v41.previewSkins = table.clone(v34);
                table.insert(u15, v41);
            end;
        end;
    end;

    packs(u1.FACTION_KEYS, "Faction", "FACTION UNIFORM PACK", "faction:", "The faction\'s uniforms as skins. Wear the look over any uniform you have on.");
    packs(u1.LOADOUT_KEYS, "Bundles", "LOADOUT BUNDLE", "loadout:", "A themed set as skins: uniform, armor, helmet and face piece.");
    local v44 = {};

    for i in pairs(SkinCatalog.Skins or {}) do
        table.insert(v44, i);
    end;

    table.sort(v44, function(p45, p46) -- Line: 132
        -- upvalues: ItemDatabase (copy)
        local v47 = ItemDatabase[p45];
        local v48 = type(v47) == "table" and v47 and v47 or nil;

        if v48 then
            p45 = v48.Name or p45;
        end;

        local v49 = ItemDatabase[p46];
        local v50 = type(v49) == "table" and v49 and v49 or nil;

        if v50 then
            p46 = v50.Name or p46;
        end;

        return p45 < p46;
    end);

    for _, v in ipairs(v44) do
        local v51 = SkinCatalog.Skins[v];

        if (v51.DevProductID or 0) ~= 0 then
            local v52 = ItemDatabase[v];
            local v53 = type(v52) == "table" and v52 and v52 or nil;
            local v54 = v18[v] == true;
            local v55 = { "Changes the look, never the stats" };

            if v54 then
                table.insert(v55, "Included with Master Stalker");
            end;

            local v56 = {
                tab = "Skins",
                kind = "product",
                ownedLabel = "OWNED",
                id = "skin:" .. v
            };
            local v57 = ItemDatabase[v];
            local v58 = type(v57) == "table" and v57 and v57 or nil;
            local v59;

            if v58 then
                v59 = v58.Name or v;
            else
                v59 = v;
            end;

            v56.name = v59;
            v56.subtitle = string.upper(v53 and (v53.ItemType or "SKIN") or "SKIN");
            v56.blurb = v51.Blurb or (v53 and v53.Description or "Cosmetic skin.");
            v56.bullets = v55;
            v56.chip = v51.Chip;
            v56.robloxId = v51.DevProductID or 0;
            v56.giftId = v51.GiftProductID or 0;
            v56.isOwned = u14[v] == true;
            v56.includedWithMaster = v54;
            v56.previewSkins = { v };
            table.insert(u15, v56);
        end;
    end;

    local v60 = StashTierConfig and (StashTierConfig.MAX_TOTAL_TIER or 7) or 7;
    local v61 = (p13.premiumTier or 0) + (p13.barterTier or 0);
    local v62 = v60 <= v61;
    local v63 = p13.stashKnown == false;
    local v64 = v63 and { "Your stash tier shows at a stash, in a safe zone" } or { ("Current tier: %d / %d"):format(math.min(v61, v60), v60) };
    local v65 = not (v63 or (v62 or not (StashTierConfig and StashTierConfig.GetSizeForTier))) and StashTierConfig.GetSizeForTier(v61 + 1);

    if v65 then
        table.insert(v64, ("Next size: %dx%d"):format(v65.X, v65.Y));
    end;

    table.insert(v64, "Kept through wipes, bound to your account");
    table.insert(u15, {
        id = "stash",
        tab = "Stash",
        name = "Stash Expansion",
        subtitle = "+1 ROW",
        blurb = "One more row in your personal stash, for good.",
        chip = nil,
        kind = "product",
        giftId = 0,
        ownedLabel = "MAX",
        includedWithMaster = false,
        bullets = v64,
        robloxId = StashTierConfig and StashTierConfig.PremiumStashDevProductId or 0,
        isOwned = not v63 and v62,
        blocked = v63 and "VISIT A STASH" or nil
    });
    local v66 = nil;

    if type(SkinCatalog.Featured) == "string" then
        for _, v in ipairs(u15) do
            if v.id == SkinCatalog.Featured then
                v66 = v;
                break;
            end;
        end;
    end;

    return u15, v66;
end;

return u1;