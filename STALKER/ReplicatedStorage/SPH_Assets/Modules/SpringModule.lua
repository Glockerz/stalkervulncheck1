-- Decompiled with Potassium's decompiler.

return {
    new = function(p1, p2, p3, p4, p5) -- Line: 11, Name: new
        return {
            Target = Vector3.new(),
            Position = Vector3.new(),
            Velocity = Vector3.new(),
            Mass = p2 or 5,
            Force = p3 or 50,
            Damping = p4 or 4,
            Speed = p5 or 4,

            getstats = function(p6) -- Line: 24, Name: getstats
                return p6.Mass, p6.Force, p6.Damping, p6.Speed;
            end,

            changestats = function(p7, p8, p9, p10, p11) -- Line: 28, Name: changestats
                p7.Mass = p8 or p7.Mass;
                p7.Force = p9 or p7.Force;
                p7.Damping = p10 or p7.Damping;
                p7.Speed = p11 or p7.Speed;
            end,

            shove = function(p12, p13) -- Line: 35, Name: shove
                local X = p13.X;
                local Y = p13.Y;
                local Z = p13.Z;
                p12.Velocity = p12.Velocity + Vector3.new((X ~= X or (X == (1 / 0) or X == (-1 / 0))) and 0 or X, (Y ~= Y or (Y == (1 / 0) or Y == (-1 / 0))) and 0 or Y, (Z ~= Z or (Z == (1 / 0) or Z == (-1 / 0))) and 0 or Z);
            end,

            update = function(p14, p15) -- Line: 49, Name: update
                local v16 = p15 * p14.Speed / 8;

                for i = 1, 8 do
                    p14.Velocity = p14.Velocity + ((p14.Target - p14.Position) * p14.Force / p14.Mass - p14.Velocity * p14.Damping) * v16;
                    p14.Position = p14.Position + p14.Velocity * v16;
                    local _ = i;
                end;

                return p14.Position;
            end
        };
    end
};