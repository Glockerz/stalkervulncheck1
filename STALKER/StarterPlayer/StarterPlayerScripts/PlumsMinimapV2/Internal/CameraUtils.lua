-- Decompiled with Potassium's decompiler.

function ViewportPointToRay(p1, p2: number, p3, p4)
    local v5 = p4.X / p4.Y;
    local math_rad_ret = math.rad(p2);
    local v6 = p3.X / p4.X * 2 - 1;
    local v7 = 1 - p3.Y / p4.Y * 2;
    local math_tan_ret = math.tan(math_rad_ret / 2);
    local v8 = p1:VectorToWorldSpace(Vector3.new(v6 * math_tan_ret * v5, v7 * math_tan_ret, -1).Unit);

    return Ray.new(p1.Position, v8);
end;

function ViewportPointToPlanePoint(p9, p10: number, p11, p12, p13: number)
    local v14 = ViewportPointToRay(p9, p10, p11, p12);

    if v14.Direction.Unit.Y == 0 then
        return Vector3.new(v14.Origin.X, p13, v14.Origin.Z);
    end;

    return v14.Origin + v14.Direction.Unit * ((p13 - v14.Origin.Y) / v14.Direction.Unit.Y);
end;

return {
    ViewportToPointRay = ViewportPointToRay,

    PointToViewport = function(p15, p16: number, p17: vector, p18) -- Line: 1, Name: pointToViewport
        local v19 = p15:PointToObjectSpace(p17);
        local v20 = p18.X / p18.Y;
        local v21 = -v19.z;
        local math_rad_ret = math.rad(p16 / 2);
        local v22 = v21 * math.tan(math_rad_ret);
        local v23 = v20 * v22;
        local v24 = v19 - Vector3.new(-v23, v22, v19.z);
        local v25 = v24.x / (v23 * 2);
        local v26 = -v24.y / (v22 * 2);

        if -v19.z > 0 and (v25 >= 0 and (v25 <= 1 and v26 >= 0)) then
            local _ = v26 <= 1;
        end;

        return Vector2.new(v25 * p18.X, v26 * p18.Y);
    end,

    ViewportPointToPlanePoint = ViewportPointToPlanePoint
};