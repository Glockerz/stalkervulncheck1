-- Decompiled with Potassium's decompiler.

return {
    Submerged = function(p1: vector) -- Line: 25, Name: Submerged
        local v2 = math.floor(p1.X / 4) * 4;
        local v3 = math.floor(p1.Y / 4) * 4;
        local v4 = math.floor(p1.Z / 4) * 4;
        local Vector3_new_ret = Vector3.new(v2, v3, v4);
        local v5, v6, v7 = pcall(function() -- Line: 31
            -- upvalues: Vector3_new_ret (copy)
            return workspace.Terrain:ReadVoxels(Region3.new(Vector3_new_ret, Vector3_new_ret + Vector3.new(4, 4, 4)), 4);
        end);

        if not (v5 and (v6[1] and v6[1][1])) then
            return false;
        end;

        if v6[1][1][1] == Enum.Material.Water then
            return p1.Y <= Vector3_new_ret.Y + v7[1][1][1] * 4;
        end;

        return false;
    end
};