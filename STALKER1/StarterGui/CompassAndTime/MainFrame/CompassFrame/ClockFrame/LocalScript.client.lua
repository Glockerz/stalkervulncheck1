-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 3 ]]
	local AmountLabel = script.Parent.AmountLabel

	AmountLabel.Text = tostring(game.Lighting.TimeOfDay)
end)