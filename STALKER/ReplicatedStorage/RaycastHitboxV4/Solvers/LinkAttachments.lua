-- Decompiled with Potassium's decompiler.

return {
    Solve = function(p1: table, p2: table) -- Line: 9, Name: Solve
        return p2.Instances[1].WorldPosition, p2.Instances[2].WorldPosition - p2.Instances[1].WorldPosition;
    end,

    UpdateToNextPosition = function(p3: table, p4: table) -- Line: 16, Name: UpdateToNextPosition
        return p4.Instances[1].WorldPosition;
    end,

    Visualize = function(p5: table, p6: table) -- Line: 20, Name: Visualize
        return CFrame.lookAt(p6.Instances[1].WorldPosition, p6.Instances[2].WorldPosition);
    end
};