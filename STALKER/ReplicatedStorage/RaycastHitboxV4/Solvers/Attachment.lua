-- Decompiled with Potassium's decompiler.

return {
    Solve = function(p1: table, p2: table) -- Line: 9, Name: Solve
        if not p2.LastPosition then
            p2.LastPosition = p2.Instances[1].WorldPosition;
        end;

        return p2.LastPosition, p2.Instances[1].WorldPosition - p2.LastPosition;
    end,

    UpdateToNextPosition = function(p3: table, p4: table) -- Line: 21, Name: UpdateToNextPosition
        return p4.Instances[1].WorldPosition;
    end,

    Visualize = function(p5: table, p6: table) -- Line: 25, Name: Visualize
        return CFrame.lookAt(p6.Instances[1].WorldPosition, p6.LastPosition);
    end
};