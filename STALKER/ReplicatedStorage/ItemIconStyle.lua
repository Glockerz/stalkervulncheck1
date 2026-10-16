-- Decompiled with Potassium's decompiler.

local u1 = {
    CropByType = {
        Ammo = true
    }
};

function u1.ScaleTypeFor(p2) -- Line: 68
    -- upvalues: u1 (copy)
    if not p2 then
        return Enum.ScaleType.Fit;
    end;

    if p2.CropIcon ~= nil then
        return p2.CropIcon and Enum.ScaleType.Crop or Enum.ScaleType.Fit;
    end;

    if u1.CropByType[p2.ItemType] then
        return Enum.ScaleType.Crop;
    end;

    return Enum.ScaleType.Fit;
end;

return u1;