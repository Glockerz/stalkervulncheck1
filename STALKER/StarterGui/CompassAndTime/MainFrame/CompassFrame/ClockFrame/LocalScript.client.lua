-- Decompiled with Potassium's decompiler.

game:GetService("RunService").Heartbeat:Connect(function() -- Line: 3
    script.Parent.AmountLabel.Text = tostring(game.Lighting.TimeOfDay);
end);