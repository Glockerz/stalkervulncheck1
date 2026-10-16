-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
local u1 = {};

local function dataFor(p2) -- Line: 62
    -- upvalues: ItemDatabase (copy)
    if type(p2) == "string" and p2 ~= "" then
        return ItemDatabase.GetItemData(p2);
    end;

    return nil;
end;

local function nameOf(p3) -- Line: 67
    -- upvalues: ItemDatabase (copy)
    local v4;

    if type(p3) == "string" and p3 ~= "" then
        v4 = ItemDatabase.GetItemData(p3);
    else
        v4 = nil;
    end;

    return v4 and v4.Name or (p3 or "that");
end;

local u5 = {
    Head = "HeadGear",
    Body = "BodyGear",
    FaceWear = "FaceWear",
    EyeWear = "EyeWear",
    BeltGear = "BeltGear",
    Backpack = "Backpack",
    NightOptical = "NightOptical"
};
local u6 = { {
        key = "Uniform",
        slot = nil
    }, {
        key = "Body",
        slot = "BodyGear"
    } };

local function sourcesOf(p7) -- Line: 110
    -- upvalues: u6 (copy)
    local v8 = {};

    if type(p7) ~= "table" then
        return v8;
    end;

    for _, v in ipairs(u6) do
        local v9 = p7[v.key];
        local v10;

        if type(v9) == "table" then
            v10 = v9.ID or nil;
        else
            v10 = nil;
        end;

        if type(v10) == "string" and v10 ~= "" then
            v8[#v8 + 1] = {
                id = v10,
                slot = v.slot
            };
        end;
    end;

    return v8;
end;

function u1.UniformSatisfies(p11, p12) -- Line: 132
    if p11 == nil then
        return true;
    end;

    if type(p11) == "string" then
        return p11 == p12;
    end;

    if type(p11) == "table" then
        for _, v in ipairs(p11) do
            if v == p12 then
                return true;
            end;
        end;
    end;

    return false;
end;

local function requirementName(p13) -- Line: 146
    -- upvalues: ItemDatabase (copy)
    local v14;

    if p13 then
        v14 = p13.RequiresUniform;
    else
        v14 = p13;
    end;

    if type(v14) == "table" then
        local RequiresUniformLabel = p13.RequiresUniformLabel;

        if not RequiresUniformLabel then
            local v15 = v14[1];
            local v16;

            if type(v15) == "string" and v15 ~= "" then
                v16 = ItemDatabase.GetItemData(v15);
            else
                v16 = nil;
            end;

            RequiresUniformLabel = v16 and v16.Name or (v15 or "that");
        end;

        return RequiresUniformLabel;
    end;

    local v17;

    if type(v14) == "string" and v14 ~= "" then
        v17 = ItemDatabase.GetItemData(v14);
    else
        v17 = nil;
    end;

    return "the " .. (v17 and v17.Name or (v14 or "that"));
end;

local function excludes(p18, p19) -- Line: 165
    -- upvalues: ItemDatabase (copy)
    local v20;

    if type(p18) == "string" and p18 ~= "" then
        v20 = ItemDatabase.GetItemData(p18);
    else
        v20 = nil;
    end;

    if not v20 or type(v20.ExcludesSlots) ~= "table" then
        return false;
    end;

    for _, v in ipairs(v20.ExcludesSlots) do
        if v == p19 then
            return true;
        end;
    end;

    return false;
end;

local function refusesVisor(p21) -- Line: 182
    -- upvalues: ItemDatabase (copy)
    local v22;

    if type(p21) == "string" and p21 ~= "" then
        v22 = ItemDatabase.GetItemData(p21);
    else
        v22 = nil;
    end;

    local v23;

    if v22 == nil then
        v23 = false;
    else
        v23 = v22.RefusesFaceVisor == true;
    end;

    return v23;
end;

local function hasVisor(p24) -- Line: 186
    -- upvalues: ItemDatabase (copy)
    local v25;

    if type(p24) == "string" and p24 ~= "" then
        v25 = ItemDatabase.GetItemData(p24);
    else
        v25 = nil;
    end;

    local v26;

    if v25 == nil or v25.ItemType ~= "FaceWear" then
        v26 = false;
    else
        v26 = v25.HasVisor == true;
    end;

    return v26;
end;

local function wornIn(p27, p28) -- Line: 190
    if p27 then
        p27 = p27[p28];
    end;

    local v29 = type(p27) == "table" and p27.ID or nil;

    if type(v29) ~= "string" or (v29 == "" or not v29) then
        v29 = nil;
    end;

    return v29;
end;

function u1.VisorRefusedForGear(p30, p31, p32) -- Line: 196
    -- upvalues: ItemDatabase (copy)
    if type(p30) ~= "table" then
        return nil;
    end;

    if p31 == "NightOptical" then
        local v33;

        if type(p32) == "string" and p32 ~= "" then
            v33 = ItemDatabase.GetItemData(p32);
        else
            v33 = nil;
        end;

        local v34;

        if v33 == nil then
            v34 = false;
        else
            v34 = v33.RefusesFaceVisor == true;
        end;

        if v34 then
            local v35;

            if p30 then
                v35 = p30.FaceWear;
            else
                v35 = p30;
            end;

            local v36;

            if type(v35) == "table" then
                v36 = v35.ID or nil;
            else
                v36 = nil;
            end;

            if type(v36) ~= "string" or (v36 == "" or not v36) then
                v36 = nil;
            end;

            if v36 then
                local v37;

                if type(v36) == "string" and v36 ~= "" then
                    v37 = ItemDatabase.GetItemData(v36);
                else
                    v37 = nil;
                end;

                local v38;

                if v37 == nil or v37.ItemType ~= "FaceWear" then
                    v38 = false;
                else
                    v38 = v37.HasVisor == true;
                end;

                if v38 then
                    local v39;

                    if type(p32) == "string" and p32 ~= "" then
                        v39 = ItemDatabase.GetItemData(p32);
                    else
                        v39 = nil;
                    end;

                    local v40 = v39 and v39.Name or (p32 or "that");
                    local v41;

                    if type(v36) == "string" and v36 ~= "" then
                        v41 = ItemDatabase.GetItemData(v36);
                    else
                        v41 = nil;
                    end;

                    return ("The %s won\'t fit over the %s."):format(v40, v41 and v41.Name or (v36 or "that"));
                end;
            end;
        end;
    end;

    if p31 == "FaceWear" then
        local v42;

        if type(p32) == "string" and p32 ~= "" then
            v42 = ItemDatabase.GetItemData(p32);
        else
            v42 = nil;
        end;

        local v43;

        if v42 == nil or v42.ItemType ~= "FaceWear" then
            v43 = false;
        else
            v43 = v42.HasVisor == true;
        end;

        if v43 then
            if p30 then
                p30 = p30.NightOptical;
            end;

            local v44 = type(p30) == "table" and p30.ID or nil;

            if type(v44) ~= "string" or (v44 == "" or not v44) then
                v44 = nil;
            end;

            if v44 then
                local v45;

                if type(v44) == "string" and v44 ~= "" then
                    v45 = ItemDatabase.GetItemData(v44);
                else
                    v45 = nil;
                end;

                local v46;

                if v45 == nil then
                    v46 = false;
                else
                    v46 = v45.RefusesFaceVisor == true;
                end;

                if v46 then
                    local v47;

                    if type(v44) == "string" and v44 ~= "" then
                        v47 = ItemDatabase.GetItemData(v44);
                    else
                        v47 = nil;
                    end;

                    return ("Take the %s off first."):format(v47 and v47.Name or (v44 or "that"));
                end;
            end;
        end;
    end;

    return nil;
end;

function u1.ExclusionRefusedForGear(p48, p49, p50) -- Line: 213
    -- upvalues: u1 (copy), u5 (copy), ItemDatabase (copy)
    if type(p48) ~= "table" or type(p49) ~= "string" then
        return nil;
    end;

    local v51 = u1.VisorRefusedForGear(p48, p49, p50);

    if v51 then
        return v51;
    end;

    for i, v in pairs(u5) do
        local v52 = p48[i];
        local v53;

        if type(v52) == "table" then
            v53 = v52.ID or nil;
        else
            v53 = nil;
        end;

        if v53 and v ~= p49 then
            local v54;

            if type(v53) == "string" and v53 ~= "" then
                v54 = ItemDatabase.GetItemData(v53);
            else
                v54 = nil;
            end;

            local v55;

            if v54 and type(v54.ExcludesSlots) == "table" then
                v55 = false;

                for _, v2 in ipairs(v54.ExcludesSlots) do
                    if v2 == p49 then
                        v55 = true;
                        break;
                    end;
                end;
            else
                v55 = false;
            end;

            if v55 then
                local v56;

                if type(v53) == "string" and v53 ~= "" then
                    v56 = ItemDatabase.GetItemData(v53);
                else
                    v56 = nil;
                end;

                return ("The %s covers that. Take it off first."):format(v56 and v56.Name or (v53 or "that"));
            end;
        end;
    end;

    local v57;

    if type(p50) == "string" and p50 ~= "" then
        v57 = ItemDatabase.GetItemData(p50);
    else
        v57 = nil;
    end;

    if v57 and type(v57.ExcludesSlots) == "table" then
        for i, v in pairs(u5) do
            local v58 = p48[i];
            local v59;

            if type(v58) == "table" then
                v59 = v58.ID or nil;
            else
                v59 = nil;
            end;

            if v59 and v ~= p49 then
                local v60;

                if type(p50) == "string" and p50 ~= "" then
                    v60 = ItemDatabase.GetItemData(p50);
                else
                    v60 = nil;
                end;

                local v61;

                if v60 and type(v60.ExcludesSlots) == "table" then
                    local v62 = v;
                    v61 = false;

                    for _, v2 in ipairs(v60.ExcludesSlots) do
                        if v2 == v62 then
                            v61 = true;
                            break;
                        end;
                    end;
                else
                    v61 = false;
                end;

                if v61 then
                    local v63;

                    if type(v59) == "string" and v59 ~= "" then
                        v63 = ItemDatabase.GetItemData(v59);
                    else
                        v63 = nil;
                    end;

                    return ("Take the %s off first."):format(v63 and v63.Name or (v59 or "that"));
                end;
            end;
        end;
    end;

    return nil;
end;

function u1.GearSlots(p64) -- Line: 240
    -- upvalues: ItemDatabase (copy)
    local v65;

    if type(p64) == "string" and p64 ~= "" then
        v65 = ItemDatabase.GetItemData(p64);
    else
        v65 = nil;
    end;

    return v65 and (type(v65.GearSlots) == "table" and v65.GearSlots) or nil;
end;

function u1.LockedSlots(p66) -- Line: 246
    -- upvalues: ItemDatabase (copy)
    local v67;

    if type(p66) == "string" and p66 ~= "" then
        v67 = ItemDatabase.GetItemData(p66);
    else
        v67 = nil;
    end;

    if not v67 or type(v67.LocksSlots) ~= "table" then
        return nil;
    end;

    local v68 = nil;

    for _, v in ipairs(v67.LocksSlots) do
        if type(v) == "string" and v ~= "" then
            v68 = v68 or {};
            v68[v] = true;
        end;
    end;

    return v68;
end;

function u1.IsSealed(p69) -- Line: 263
    -- upvalues: u1 (copy)
    return u1.GearSlots(p69) ~= nil and true or u1.LockedSlots(p69) ~= nil;
end;

function u1.HostRefusedBy(p70, p71, p72) -- Line: 279
    -- upvalues: u1 (copy), ItemDatabase (copy)
    if type(p71) ~= "string" or p71 == "" then
        return nil;
    end;

    local v73 = u1.LockedSlots(p70);

    if v73 and v73[p71] then
        local v74;

        if type(p70) == "string" and p70 ~= "" then
            v74 = ItemDatabase.GetItemData(p70);
        else
            v74 = nil;
        end;

        return ("The %s covers that."):format(v74 and v74.Name or (p70 or "that"));
    end;

    local v75 = u1.GearSlots(p70);

    if v75 then
        v75 = v75[p71];
    end;

    if not v75 or v75 == p72 then
        return nil;
    end;

    local v76;

    if type(v75) == "string" and v75 ~= "" then
        v76 = ItemDatabase.GetItemData(v75);
    else
        v76 = nil;
    end;

    local v77 = v76 and v76.Name or (v75 or "that");
    local v78;

    if type(p70) == "string" and p70 ~= "" then
        v78 = ItemDatabase.GetItemData(p70);
    else
        v78 = nil;
    end;

    return ("Only the %s fits under the %s."):format(v77, v78 and v78.Name or (p70 or "that"));
end;

local function needsMount(p79) -- Line: 315
    -- upvalues: ItemDatabase (copy)
    local v80;

    if type(p79) == "string" and p79 ~= "" then
        v80 = ItemDatabase.GetItemData(p79);
    else
        v80 = nil;
    end;

    local v81;

    if v80 == nil then
        v81 = false;
    else
        v81 = v80.RequiresMount == true;
    end;

    return v81;
end;

local function hasMount(p82) -- Line: 320
    -- upvalues: ItemDatabase (copy)
    local v83;

    if type(p82) == "string" and p82 ~= "" then
        v83 = ItemDatabase.GetItemData(p82);
    else
        v83 = nil;
    end;

    local v84;

    if v83 == nil then
        v84 = false;
    else
        v84 = v83.NVGMount == true;
    end;

    return v84;
end;

local function wornHeadGear(p85) -- Line: 328
    if type(p85) ~= "table" then
        return nil;
    end;

    local Head = p85.Head;
    local v86 = type(Head) == "table" and Head.ID or nil;

    if type(v86) ~= "string" or (v86 == "" or not v86) then
        v86 = nil;
    end;

    return v86;
end;

function u1.MountRefusedForGear(p87, p88, p89) -- Line: 344
    -- upvalues: ItemDatabase (copy)
    if type(p88) ~= "string" or p88 == "" then
        return nil;
    end;

    local v90, v91, v92, v93, v94, v95, v96, v97, v98;

    if p88 ~= "NightOptical" then
        if p88 == "HeadGear" then
            if type(p89) == "string" and p89 ~= "" then
                v90 = ItemDatabase.GetItemData(p89);
            else
                v90 = nil;
            end;

            if v90 == nil then
                v91 = false;
            else
                v91 = v90.NVGMount == true;
            end;

            if not v91 then
                if p87 then
                    p87 = p87.NightOptical;
                end;

                if type(p87) == "table" then
                    v92 = p87.ID or nil;
                else
                    v92 = nil;
                end;

                if v92 then
                    if type(v92) == "string" and v92 ~= "" then
                        v93 = ItemDatabase.GetItemData(v92);
                    else
                        v93 = nil;
                    end;

                    if v93 == nil then
                        v94 = false;
                    else
                        v94 = v93.RequiresMount == true;
                    end;

                    if v94 then
                        v95 = "The %s has nowhere to mount on the %s.";

                        if type(v92) == "string" and v92 ~= "" then
                            v96 = ItemDatabase.GetItemData(v92);
                        else
                            v96 = nil;
                        end;

                        v97 = v96 and v96.Name or (v92 or "that");

                        if type(p89) == "string" and p89 ~= "" then
                            v98 = ItemDatabase.GetItemData(p89);
                        else
                            v98 = nil;
                        end;

                        return v95:format(v97, v98 and v98.Name or (p89 or "that"));
                    end;
                end;
            end;
        end;

        return nil;
    end;

    local v99;

    if type(p89) == "string" and p89 ~= "" then
        v99 = ItemDatabase.GetItemData(p89);
    else
        v99 = nil;
    end;

    local v100;

    if v99 == nil then
        v100 = false;
    else
        v100 = v99.RequiresMount == true;
    end;

    if not v100 then
        if p88 == "HeadGear" then
            if type(p89) == "string" and p89 ~= "" then
                v90 = ItemDatabase.GetItemData(p89);
            else
                v90 = nil;
            end;

            if v90 == nil then
                v91 = false;
            else
                v91 = v90.NVGMount == true;
            end;

            if not v91 then
                if p87 then
                    p87 = p87.NightOptical;
                end;

                if type(p87) == "table" then
                    v92 = p87.ID or nil;
                else
                    v92 = nil;
                end;

                if v92 then
                    if type(v92) == "string" and v92 ~= "" then
                        v93 = ItemDatabase.GetItemData(v92);
                    else
                        v93 = nil;
                    end;

                    if v93 == nil then
                        v94 = false;
                    else
                        v94 = v93.RequiresMount == true;
                    end;

                    if v94 then
                        v95 = "The %s has nowhere to mount on the %s.";

                        if type(v92) == "string" and v92 ~= "" then
                            v96 = ItemDatabase.GetItemData(v92);
                        else
                            v96 = nil;
                        end;

                        v97 = v96 and v96.Name or (v92 or "that");

                        if type(p89) == "string" and p89 ~= "" then
                            v98 = ItemDatabase.GetItemData(p89);
                        else
                            v98 = nil;
                        end;

                        return v95:format(v97, v98 and v98.Name or (p89 or "that"));
                    end;
                end;
            end;
        end;

        return nil;
    end;

    local v101;

    if type(p87) == "table" then
        local Head = p87.Head;
        v101 = type(Head) == "table" and Head.ID or nil;

        if type(v101) ~= "string" or (v101 == "" or not v101) then
            v101 = nil;
        end;
    else
        v101 = nil;
    end;

    if v101 then
        local v102;

        if type(v101) == "string" and v101 ~= "" then
            v102 = ItemDatabase.GetItemData(v101);
        else
            v102 = nil;
        end;

        local v103;

        if v102 == nil then
            v103 = false;
        else
            v103 = v102.NVGMount == true;
        end;

        if v103 then
            if p88 == "HeadGear" then
                if type(p89) == "string" and p89 ~= "" then
                    v90 = ItemDatabase.GetItemData(p89);
                else
                    v90 = nil;
                end;

                if v90 == nil then
                    v91 = false;
                else
                    v91 = v90.NVGMount == true;
                end;

                if not v91 then
                    if p87 then
                        p87 = p87.NightOptical;
                    end;

                    if type(p87) == "table" then
                        v92 = p87.ID or nil;
                    else
                        v92 = nil;
                    end;

                    if v92 then
                        if type(v92) == "string" and v92 ~= "" then
                            v93 = ItemDatabase.GetItemData(v92);
                        else
                            v93 = nil;
                        end;

                        if v93 == nil then
                            v94 = false;
                        else
                            v94 = v93.RequiresMount == true;
                        end;

                        if v94 then
                            v95 = "The %s has nowhere to mount on the %s.";

                            if type(v92) == "string" and v92 ~= "" then
                                v96 = ItemDatabase.GetItemData(v92);
                            else
                                v96 = nil;
                            end;

                            v97 = v96 and v96.Name or (v92 or "that");

                            if type(p89) == "string" and p89 ~= "" then
                                v98 = ItemDatabase.GetItemData(p89);
                            else
                                v98 = nil;
                            end;

                            return v95:format(v97, v98 and v98.Name or (p89 or "that"));
                        end;
                    end;
                end;
            end;

            return nil;
        end;
    end;

    local v104;

    if type(p89) == "string" and p89 ~= "" then
        v104 = ItemDatabase.GetItemData(p89);
    else
        v104 = nil;
    end;

    return ("The %s needs a helmet with a mount."):format(v104 and v104.Name or (p89 or "that"));
end;

function u1.MountRemovalRefused(p105, p106, p107) -- Line: 380
    -- upvalues: ItemDatabase (copy)
    if p106 ~= "HeadGear" then
        return nil;
    end;

    local v108;

    if type(p107) == "string" and p107 ~= "" then
        v108 = ItemDatabase.GetItemData(p107);
    else
        v108 = nil;
    end;

    local v109;

    if v108 == nil then
        v109 = false;
    else
        v109 = v108.NVGMount == true;
    end;

    if not v109 then
        return nil;
    end;

    if p105 then
        p105 = p105.NightOptical;
    end;

    local v110 = type(p105) == "table" and p105.ID or nil;

    if v110 then
        local v111;

        if type(v110) == "string" and v110 ~= "" then
            v111 = ItemDatabase.GetItemData(v110);
        else
            v111 = nil;
        end;

        local v112;

        if v111 == nil then
            v112 = false;
        else
            v112 = v111.RequiresMount == true;
        end;

        if v112 then
            local v113;

            if type(v110) == "string" and v110 ~= "" then
                v113 = ItemDatabase.GetItemData(v110);
            else
                v113 = nil;
            end;

            return ("Take the %s off first."):format(v113 and v113.Name or (v110 or "that"));
        end;
    end;

    return nil;
end;

function u1.EquipRefusedBy(p114, p115, p116) -- Line: 391
    -- upvalues: u1 (copy), ItemDatabase (copy)
    if type(p115) ~= "string" or p115 == "" then
        return nil;
    end;

    local v117 = u1.HostRefusedBy(p114, p115, p116);

    if v117 then
        return v117;
    end;

    local v118;

    if type(p116) == "string" and p116 ~= "" then
        v118 = ItemDatabase.GetItemData(p116);
    else
        v118 = nil;
    end;

    local v119;

    if v118 then
        v119 = v118.RequiresUniform;
    else
        v119 = v118;
    end;

    if v119 then
        local v120;

        if v119 == nil then
            v120 = true;
        elseif type(v119) == "string" then
            v120 = v119 == p114;
        elseif type(v119) == "table" then
            v120 = false;

            for _, v in ipairs(v119) do
                if v == p114 then
                    v120 = true;
                    break;
                end;
            end;
        end;

        if not v120 then
            local v121;

            if type(p116) == "string" and p116 ~= "" then
                v121 = ItemDatabase.GetItemData(p116);
            else
                v121 = nil;
            end;

            local v122 = v121 and v121.Name or (p116 or "that");
            local v123;

            if v118 then
                v123 = v118.RequiresUniform;
            else
                v123 = v118;
            end;

            local v124;

            if type(v123) == "table" then
                v124 = v118.RequiresUniformLabel;

                if not v124 then
                    local v125 = v123[1];
                    local v126;

                    if type(v125) == "string" and v125 ~= "" then
                        v126 = ItemDatabase.GetItemData(v125);
                    else
                        v126 = nil;
                    end;

                    v124 = v126 and v126.Name or (v125 or "that");
                end;
            else
                local v127;

                if type(v123) == "string" and v123 ~= "" then
                    v127 = ItemDatabase.GetItemData(v123);
                else
                    v127 = nil;
                end;

                v124 = "the " .. (v127 and v127.Name or (v123 or "that"));
            end;

            return ("The %s only fits %s."):format(v122, v124);
        end;
    end;

    return nil;
end;

function u1.EquipRefusedForGear(p128, p129, p130) -- Line: 414
    -- upvalues: ItemDatabase (copy), sourcesOf (copy), u1 (copy)
    local v131 = p128 and p128.Uniform and p128.Uniform.ID;
    local v132;

    if type(p130) == "string" and p130 ~= "" then
        v132 = ItemDatabase.GetItemData(p130);
    else
        v132 = nil;
    end;

    local v133;

    if v132 then
        v133 = v132.RequiresUniform;
    else
        v133 = v132;
    end;

    if v133 then
        local v134;

        if v133 == nil then
            v134 = true;
        elseif type(v133) == "string" then
            v134 = v133 == v131;
        elseif type(v133) == "table" then
            v134 = false;

            for _, v in ipairs(v133) do
                if v == v131 then
                    v134 = true;
                    break;
                end;
            end;
        end;

        if not v134 then
            local v135;

            if type(p130) == "string" and p130 ~= "" then
                v135 = ItemDatabase.GetItemData(p130);
            else
                v135 = nil;
            end;

            local v136 = v135 and v135.Name or (p130 or "that");
            local v137;

            if v132 then
                v137 = v132.RequiresUniform;
            else
                v137 = v132;
            end;

            local v138;

            if type(v137) == "table" then
                v138 = v132.RequiresUniformLabel;

                if not v138 then
                    local v139 = v137[1];
                    local v140;

                    if type(v139) == "string" and v139 ~= "" then
                        v140 = ItemDatabase.GetItemData(v139);
                    else
                        v140 = nil;
                    end;

                    v138 = v140 and v140.Name or (v139 or "that");
                end;
            else
                local v141;

                if type(v137) == "string" and v137 ~= "" then
                    v141 = ItemDatabase.GetItemData(v137);
                else
                    v141 = nil;
                end;

                v138 = "the " .. (v141 and v141.Name or (v137 or "that"));
            end;

            return ("The %s only fits %s."):format(v136, v138);
        end;
    end;

    if v132 then
        v132 = v132.RequiresHost;
    end;

    if v132 then
        local v142 = false;

        for _, v in ipairs((sourcesOf(p128))) do
            if v.id == v132 then
                v142 = true;
                break;
            end;
        end;

        if not v142 then
            local v143;

            if type(p130) == "string" and p130 ~= "" then
                v143 = ItemDatabase.GetItemData(p130);
            else
                v143 = nil;
            end;

            local v144 = v143 and v143.Name or (p130 or "that");
            local v145;

            if type(v132) == "string" and v132 ~= "" then
                v145 = ItemDatabase.GetItemData(v132);
            else
                v145 = nil;
            end;

            return ("The %s is part of the %s."):format(v144, v145 and v145.Name or (v132 or "that"));
        end;
    end;

    for _, v in ipairs((sourcesOf(p128))) do
        if v.slot ~= p129 then
            local v146 = u1.HostRefusedBy(v.id, p129, p130);

            if v146 then
                return v146;
            end;
        end;
    end;

    return u1.MountRefusedForGear(p128, p129, p130) or (u1.ExclusionRefusedForGear(p128, p129, p130) or nil);
end;

function u1.AttachedSlots(p147) -- Line: 487
    -- upvalues: ItemDatabase (copy)
    local v148;

    if type(p147) == "string" and p147 ~= "" then
        v148 = ItemDatabase.GetItemData(p147);
    else
        v148 = nil;
    end;

    if not v148 or type(v148.AttachedSlots) ~= "table" then
        return nil;
    end;

    local v149 = nil;

    for _, v in ipairs(v148.AttachedSlots) do
        if type(v) == "string" and v ~= "" then
            v149 = v149 or {};
            v149[v] = true;
        end;
    end;

    return v149;
end;

function u1.RemovalRefusedBy(p150, p151, p152) -- Line: 506
    -- upvalues: u1 (copy), ItemDatabase (copy)
    if type(p151) ~= "string" or p151 == "" then
        return nil;
    end;

    local v153 = u1.AttachedSlots(p150);

    if not (v153 and v153[p151]) then
        return nil;
    end;

    local v154 = u1.GearSlots(p150);

    if v154 then
        v154 = v154[p151];
    end;

    if v154 and v154 ~= p152 then
        return nil;
    end;

    local v155;

    if type(p152) == "string" and p152 ~= "" then
        v155 = ItemDatabase.GetItemData(p152);
    else
        v155 = nil;
    end;

    local v156 = v155 and v155.Name or (p152 or "that");
    local v157;

    if type(p150) == "string" and p150 ~= "" then
        v157 = ItemDatabase.GetItemData(p150);
    else
        v157 = nil;
    end;

    return ("The %s is part of the %s. Take that off first."):format(v156, v157 and v157.Name or (p150 or "that"));
end;

function u1.RemovalRefusedForGear(p158, p159, p160) -- Line: 523
    -- upvalues: sourcesOf (copy), u1 (copy)
    for _, v in ipairs((sourcesOf(p158))) do
        if v.slot ~= p159 then
            local v161 = u1.RemovalRefusedBy(v.id, p159, p160);

            if v161 then
                return v161;
            end;
        end;
    end;

    return u1.MountRemovalRefused(p158, p159, p160) or nil;
end;

function u1.KeptSlots(p162) -- Line: 593
    -- upvalues: ItemDatabase (copy)
    local v163;

    if type(p162) == "string" and p162 ~= "" then
        v163 = ItemDatabase.GetItemData(p162);
    else
        v163 = nil;
    end;

    if not v163 or type(v163.KeptSlots) ~= "table" then
        return nil;
    end;

    local v164 = nil;

    for _, v in ipairs(v163.KeptSlots) do
        if type(v) == "string" and v ~= "" then
            v164 = v164 or {};
            v164[v] = true;
        end;
    end;

    return v164;
end;

function u1.AttachedKeptSlots(p165) -- Line: 606
    -- upvalues: u1 (copy), u5 (copy), ItemDatabase (copy)
    if type(p165) ~= "table" then
        return nil;
    end;

    local v166;

    if type(p165.Uniform) == "table" then
        v166 = p165.Uniform.ID or nil;
    else
        v166 = nil;
    end;

    local v167 = u1.AttachedSlots(v166);
    local v168 = u1.KeptSlots(v166);

    if not (v167 or v168) then
        return nil;
    end;

    local v169 = u1.GearSlots(v166) or {};
    local v170 = v167 or {};
    local v171 = v168 or {};
    local v172 = nil;

    for i, v in pairs(u5) do
        local v173 = p165[i];

        if type(v173) == "table" and v173.ID then
            local v174 = v170[v] and v169[v] == v173.ID;
            local v175;

            if v174 or not v171[v] then
                v175 = i;
            else
                local ID = v173.ID;
                local v176;

                if type(ID) == "string" and ID ~= "" then
                    v176 = ItemDatabase.GetItemData(ID);
                else
                    v176 = nil;
                end;

                if v176 == nil or v176.RequiresUniform == nil then
                    v175 = i;
                    v174 = false;
                else
                    local RequiresUniform = v176.RequiresUniform;

                    if RequiresUniform == nil then
                        v175 = i;
                        v174 = true;
                    elseif type(RequiresUniform) == "string" then
                        v174 = RequiresUniform == v166;
                        v175 = i;
                    elseif type(RequiresUniform) == "table" then
                        v175 = i;
                        v174 = false;

                        for _, v2 in ipairs(RequiresUniform) do
                            if v2 == v166 then
                                v174 = true;
                                break;
                            end;
                        end;
                    else
                        v175 = i;
                    end;
                end;
            end;

            if v174 then
                v172 = v172 or {};
                v172[v175] = true;
            end;
        end;
    end;

    return v172;
end;

function u1.OccupiedSlots(p177) -- Line: 642
    -- upvalues: u5 (copy)
    local v178 = {};

    if type(p177) ~= "table" then
        return v178;
    end;

    for i, v in pairs(u5) do
        local v179 = p177[i];

        if type(v179) == "table" and v179.ID then
            v178[v] = v179.ID;
        end;
    end;

    return v178;
end;

function u1.BlockingNames(p180, p181) -- Line: 668
    -- upvalues: u1 (copy), ItemDatabase (copy)
    local v182 = {};

    if type(p181) ~= "table" then
        return v182;
    end;

    if not u1.IsSealed(p180) then
        return v182;
    end;

    local v183 = u1.LockedSlots(p180) or {};
    local v184 = u1.GearSlots(p180) or {};

    for i, v in pairs(p181) do
        local v185 = v184[i];

        if v183[i] or v185 and v185 ~= v then
            local v186;

            if type(v) == "string" and v ~= "" then
                v186 = ItemDatabase.GetItemData(v);
            else
                v186 = nil;
            end;

            v182[#v182 + 1] = v186 and v186.Name or (v or "that");
        end;
    end;

    table.sort(v182);

    return v182;
end;

function u1.UniformBlockedBy(p187, p188) -- Line: 689
    -- upvalues: u1 (copy)
    local v189 = u1.BlockingNames(p187, p188);

    if #v189 == 0 then
        return nil;
    end;

    return ("Take off your %s first."):format(table.concat(v189, " and "));
end;

function u1.UniformBlockedForGear(p190, p191) -- Line: 697
    -- upvalues: u1 (copy)
    return u1.UniformBlockedBy(p190, u1.OccupiedSlots(p191));
end;

function u1.WearBlockersForGear(p192, p193) -- Line: 705
    -- upvalues: u1 (copy), ItemDatabase (copy)
    local v194 = u1.BlockingNames(p192, u1.OccupiedSlots(p193));
    local v195;

    if type(p193) == "table" and type(p193.Uniform) == "table" then
        v195 = p193.Uniform.ID;
    else
        v195 = false;
    end;

    if type(v195) == "string" and v195 ~= "" then
        local v196;

        if type(v195) == "string" and v195 ~= "" then
            v196 = ItemDatabase.GetItemData(v195);
        else
            v196 = nil;
        end;

        table.insert(v194, 1, v196 and v196.Name or (v195 or "that"));
    end;

    return v194;
end;

function u1.JoinNames(p197) -- Line: 716
    return #p197 <= 1 and (p197[1] or "") or table.concat(p197, ", ", 1, #p197 - 1) .. " and " .. p197[#p197];
end;

return u1;